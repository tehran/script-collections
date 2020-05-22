get-childitem *.mp4 | foreach { rename-item $_ $_.Name.Replace("Learning Path Cisco CCNP Routing and Switching", "") }
get-childitem *.mp4 | foreach { rename-item $_ $_.Name.Replace("Learning Path Cisco CCNP Routing and", "") }
get-childitem *.mp4 | foreach { rename-item $_ $_.Name.Replace("Learning Path Cisco CCNP Routing", "") }
get-childitem *.mp4 | foreach { rename-item $_ $_.Name.Replace("Learning Path Cisco CCNP", "") }
get-childitem *.mp4 | foreach { rename-item $_ $_.Name.Replace("Learning Path Cisco", "") }
get-childitem *.mp4 | foreach { rename-item $_ $_.Name.Replace("Learning Path", "") }
get-childitem *.mp4 | foreach { rename-item $_ $_.Name.Replace("Learning", "") }