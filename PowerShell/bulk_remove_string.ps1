##How to remove the same part of a txt file name for many files in Windows

get-childitem *.txt | foreach { rename-item $_ $_.Name.Replace("ExampleString", "") }
