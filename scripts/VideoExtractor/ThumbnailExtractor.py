import datetime
import logging
import os
import re
import subprocess


class ThumbnailExtractor:
    def which(self, program):
        """ Somewhat equivalent to which(1) """

        def is_executable(fpath):
            return os.path.isfile(fpath) and os.access(fpath, os.X_OK)

        if is_executable(program):
            return program
        path, program = os.path.split(program)
        if path:
            return None
        for path in os.environ["PATH"].split(os.pathsep):
            path = path.strip('"')
            exe = os.path.join(path, program)
            if is_executable(exe):
                return exe
            # Windows-style
            exe = os.path.join(path, "{}.exe".format(program))
            if is_executable(exe):
                return exe
        return None


    def thumb_with_ffmpeg(self, infile, position=0.5, executable=None, outfile='thumbnail.jpeg'):
        """
        Extract a thumbnail using ffmpeg
        
        :param infile: File to thumbnail.
        :param position: Position at which to take the thumbnail. Default: 0.5
        :param executable: Executable to use. Default: first "ffmpeg" in $PATH
        :returns: The thumbnail data (binary string)
        """
        if not os.path.exists(infile):
            logging.error("Video file not found")
            return 1
    
        ffmpeg = self.which(executable or "ffmpeg")
        if not ffmpeg:
            raise RuntimeError(
                           "Failed to find ffmpeg executable: {}".format(executable))
        if position < 0 or position >= 1.0:
            raise ValueError(
                         "Position {} is not between 0.0 and 1.0".format(position))
    
        proc = subprocess.Popen([ffmpeg, "-i", infile], stderr=subprocess.PIPE)
        _, result = proc.communicate()
        #m = re.search(r"Duration:\s*(\d+):(\d+):(\d+)\.(\d+)", result)
        m = re.search(r"Duration:\s*(\d+):(\d+):(\d+)\.(\d+)", result.decode('utf-8'))
        if not m:
            raise KeyError("Cannot determine duration")
        # Avoiding strptime here because it has some issues handling milliseconds.
        m = [int(m.group(i)) for i in range(1, 5)]
        duration = datetime.timedelta(hours=m[0],
                                  minutes=m[1],
                                  seconds=m[2],
                                  # * 10 because truncated to 2 decimal places
                                  milliseconds=m[3] * 10
                                  ).total_seconds()
        target = max(0, min(duration * position, duration - 0.1))
        target = "{:.3f}".format(target)
        args = [ffmpeg,
            "-ss", target,
            "-i", infile,
            "-map", "v:0",     # first video stream
            "-frames:v", "1",  # 1 frame
            "-f", "mjpeg",     # motion jpeg (aka. jpeg since 1 frame) output
            "pipe:"            # pipe output to stdout
            ]
        proc = subprocess.Popen(args, stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE)
        output, _ = proc.communicate()
        if proc.returncode:
            raise subprocess.CalledProcessError(proc.returncode, args)
        if not output:
            raise subprocess.CalledProcessError(-2, args)
        with open(outfile, "wb+") as op:
            op.write(output)
        return output
