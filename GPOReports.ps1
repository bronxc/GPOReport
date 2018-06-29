Param (
               [parameter(Mandatory=$true)][string]$computername,
               [parameter(Mandatory=$true)][string]$username,
               [parameter(Mandatory=$true)][string]$email
               )


Write-Host ""
Write-Warning "Remember to run this as an Administrator and provide the username as domain\username!" 
Write-Host ""
Write-Host "Collecting GPO Information" -ForegroundColor "Green"


Invoke-Command -ScriptBlock {

                    $computername = $args[0]
                    $username = $args[1]
                    $email = $args[2]


                    gpresult /h C:\$computername.html /user:$username /f 

                    Send-MailMessage -SmtpServer $smtp -to "$email" -From "$email" -Attachments "C:\$computername.html" -Subject "GPO Report for Computer $computername User $username" -Body "See Attached Report"

                    Remove-Item -Path "C:\$computername.html"

                } -computerName $computername -ArgumentList $computername,$username,$email


Write-Host ""
Write-Host "Email has been sent" -ForegroundColor "Green"

