# SIC Specification

Specification for the Semantic Indentation Control control code standard.

# Overview

SIC is a set of control codes that replace traditional indentation methods, such
as inserting space or tab characters at the beginning of a line.

SIC defines two codes:
- `INDENT`: `U+F32A`
- `DEDENT`: `U+F32B`

Indentation is done on blocks of lines, rather than per line. After an `INDENT`
code, every subsequent line is indented until a `DEDENT` code is reached.

## Examples
### A Text file using SIC indentation may have content similar to this:
```
Text aligned all the way to the left
<INDENT>This text is indented
This line is still indented!
<DEDENT>Now we are back to the left.
```

This should be rendered as:
```
Text aligned all the way to the left
    This text is indented
    This line is still indented!
Now we are back to the left.
```

### Another Example
```
All the way to the left
<INDENT>One indentation level
<INDENT>Two indentation levels
Still two levels
<DEDENT>Back to one level
<DEDENT>All the way to the left again
```

Rendered as:
```
All the way to the left
    One indentation level
        Two indentation levels
        Still two levels
    Back to one level
All the way to the left again
```
