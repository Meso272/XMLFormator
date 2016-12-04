class StringUtility:
    def retain_alphabeta(self, string):
        return ''.join(char for char in string if char.isalpha())

    def trim_title(self, title):
        title = title.replace("/", "-")
        title = title.replace("<", "")
        title = title.replace(" ", "_")
        return title

