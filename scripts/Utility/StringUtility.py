class StringUtility:
    @staticmethod
    def retain_alphabet(string):
        return ''.join(char for char in string if char.isalpha())

    @staticmethod
    def trim_title(title):
        title = title.replace("/", "-")
        title = title.replace("<", "")
        title = title.replace(" ", "_")
        return title

