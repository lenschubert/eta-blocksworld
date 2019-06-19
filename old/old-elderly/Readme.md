
# Text mode:

1. Make sure that \*mode\* is set to value NIL in file "lissa-main-body.lisp": `(setq *mode* NIL)`
 
2. Open ACL (Allegro Common Lisp) or SBCL (Steelbank Common Lisp)

3. To load the lisp program you need to first change the working directory to wherever the main file is located (where this Readme file is). To change directory in ACL you need to type:
`:cd C:\inetpub\wwwroot\RocSpeakRafayet\lissa5`

4. Load the program: `(load "lissa-main-body")`

The program will ask for user-id (say x) and session-number (say y). Then it
loads the dialogue of day y and it stores the knowledge in the file corresponding
to user x.

As an example: 

```
user id: kevin
session number: 5
```

You can type exit in one of the above fields to exit from the program.


# Speak mode:

1. Make sure that \*mode\* is set to value T in file "lissa-main-body.lisp": `(setq *mode* NIL)`

2. Open ACL (Allegro Common Lisp) or SBCL (Steelbank Common Lisp)

3. To load the lisp program you need to first change the working directory to wherever the main file is located (where this Readme file is). To change directory in ACL you need to type:
`:cd C:\inetpub\wwwroot\RocSpeakRafayet\lissa5`
		
4. Load the program: `(load "lissa-main-body")`

5. Session number and user id would be read from sessionInfo.lisp located in the
current directory and it should be written in the following format:

```lisp
(setq *user-id* "kevin)
(setq *session-number* "2")
```

As soon as the above command is written in “sessionInfo.lisp”, the lisp program loads the dialogue of day 2 for user kevin, it also clear the content of this file right after it reads the it. After this day’s conversation is done, it will keep looking at “sessionInfo.lisp” to get the command again.

