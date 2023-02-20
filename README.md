# SIC Specification

Specification for the Semantic Indentation Control control code standard.

# Overview

SIC is a set of control codes that replace traditional indentation methods, such
as inserting space or tab characters at the beginning of a line.

SIC defines two codes:
- INDENT: `U+F32A`
- DEDENT: `U+F32B`

A Text file using SIC indentation may have content similar to this:
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
