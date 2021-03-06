function Get-FreeDiskSpace
{
    <#
    .Synopsis
    Gets the free disk space on logical drives
    of the local computer or a remote computer.

    .Description
    Gets the performance counters values for free disk space,
    both in megabytes and as a percentage for all or selected
    logical drives of the local computer or a remote computer.

    .Parameter Drive
    
    Limits the data to a specified drive or volume. The default
    is all logical drives on the computer, all volumes, and a
    summary value (_total). 
    
    Enter a drive letter, a hard disk volume number, or,
    for a sum all drives, type "_Total".

    .Parameter SampleInterval
    
    Specifies the time between samples in seconds. The minimum
    value and the default value are 1 second.

    .Parameter MaxSamples
    
    Specifies the number of samples to get from each counter. 
    The default is 1 (sample). 
    
    .Parameter Continuous
    
    Gets samples continuously until you press CTRL+C. The
    default is $false.


    .Parameter ComputerName
    
    Enter the name of a remote computer. The default
    is the local computer. You can use "-ComputerName"
    or its alias, "-Cn".
        
    .Notes
    To get its data, this function uses the 
    Get-Counter cmdlet.

    .Example
    Get-FreeDiskSpace

    .Example
    Get-FreeDiskSpace –drive C: -sampleInterval 5 –MaxSamples 5

    .Example
    Get-FreeDiskSpace –cn Server01 –drive _total -continuous

    .Link
    Get-Counter

    #>

    param(
    $Drive = "*",
    [Parameter(ParameterSetName='GetCounterSet')]
    [ValidateRange(1, 2147483647)]
    [System.Int32]
    $SampleInterval,

    [Parameter(ParameterSetName='GetCounterSet')]
    [ValidateRange(1, 9223372036854775807)]
    [System.Int64]
    $MaxSamples,

    [Parameter(ParameterSetName='GetCounterSet')]
    [Switch]
    $Continuous,

    [Alias('Cn')]
    [ValidateNotNull()]
    [AllowEmptyCollection()]
    [System.String[]]
    $ComputerName)

    $null = $psBoundParameters.Remove("Drive")
    $PsBoundParameters.Counter = "\LogicalDisk($drive)\% Free Space", 
        "\LogicalDisk($drive)\Free Megabytes"     
    Get-Counter @PSBoundParameters
}