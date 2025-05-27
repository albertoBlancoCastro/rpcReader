function x = escapeSpecialCharacters(x)
    x = regexprep(x, '%', '%%');
    x = regexprep(x, '\\', '\\\\');
    x = regexprep(x, '''', '''''');
end