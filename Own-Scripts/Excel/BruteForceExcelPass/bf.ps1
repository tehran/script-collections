$filepath = "C:\Users\Administrator\Desktop\test.xlsx"
$password = 1000

Do
{
    Write-Output ("TRY: " + $password)
    try {
                $excel = New-Object -ComObject Excel.Application
                $excel.Visible = $true
                $excel.DisplayAlerts = $true
                $wb = $excel.Workbooks.Open($filepath, [Type]::Missing, [Type]::Missing, [Type]::Missing, $password)
                $sheet = $wb.ActiveSheet
                Write-Output ("SUCCESS, PASSWORD is: " + $password)

            } finally {
                            $sheet, $wb, $excel | ForEach-Object {
                                                        if ($_ -ne $null) {
                        [void][System.Runtime.Interopservices.Marshal]::ReleaseComObject($_)
                    }
                }
            }

} While (($password = $password + 1) -le 9999)