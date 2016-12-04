class FileUtility:
    def __init__(self):
        self.buffer = dict()

    def write_file(self, path, content):
        self.buffer[path] = content

    def read_file(self, path):
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
        return content

    def flush(self):
        for path in self.buffer:
            content = self.buffer[path]
            with open(path, 'w+', encoding='utf-8') as f:
                f.write(content)
        self.buffer.clear()
