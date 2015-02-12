Get-WmiObject -Namespace root\Microsoft\SqlServer\ComputerManagement12 -Class ServerNetworkProtocol |
  Where-Object {$_.InstanceName -eq 'SQL2014' -and $_.ProtocolName -eq 'Tcp'} |
  ForEach-Object {$_.SetEnable()}

$tcpProperties =
  Get-WmiObject -Namespace root\Microsoft\SqlServer\ComputerManagement12 -Class ServerNetworkProtocolProperty |
    Where-Object {$_.InstanceName -eq 'SQL2014' -and $_.ProtocolName -eq 'Tcp' -and $_.IPAddressName -eq 'IPAll'}

foreach( $tcpProperty in $tcpProperties ){
  $requestedValue = ""
  if($tcpProperty.PropertyName -eq "TcpPort"){
    $requestedValue = "1433"
  }
  $tcpProperty.SetStringValue($requestedValue)
}
