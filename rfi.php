<?php
    // The outer code is just a print.

    print <<<INNER_CODE
<?php
    // This is a sample remote file inclusion vulnerability.
    // It will simply count how many files there are in the
    // vulnerable script's directory.

    \$files = count(glob('*.*'));
    print "This folder contains {\$files} files.";

    // Just sayin'.
    // shell_exec("FORMAT A: /Y /AUTOTEST");
INNER_CODE;
