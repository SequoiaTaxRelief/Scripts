# Get all disks
# custom script I wrote because I was having issue figuring out which disk was which because
# windoiws uses 10 different ways to refer to them depending on where you are

# Get all disks
$disks = Get-Disk

foreach ($disk in $disks) {
    "Disk $($disk.Number): $($disk.FriendlyName)"
    "  Health Status: $($disk.HealthStatus)"
    "  Operational Status: $($disk.OperationalStatus)"
    "  Size: [Total: $($disk.Size / 1GB -as [int]) GB]"
    "  Partition Style: $($disk.PartitionStyle)"
    "  Serial Number: $($disk.SerialNumber)"
    ""
    
    # Get all partitions on the current disk
    $partitions = Get-Partition -DiskNumber $disk.Number

    foreach ($partition in $partitions) {
        "  Partition $($partition.PartitionNumber):"
        
        # Get the volume associated with the current partition
        $volume = Get-Volume -Partition $partition

        if ($volume) {
            "    Volume $($volume.DriveLetter):"
            "      ObjectID: $($volume.ObjectId)"
            "      File System Label: $($volume.FileSystemLabel)"
            "      File System: $($volume.FileSystem)"
            "      Size: [Used: $((($volume.Size - $volume.SizeRemaining) / 1GB) -as [int]) GB, Free: $($volume.SizeRemaining / 1GB -as [int]) GB]"
        } else {
            "      No volume information available"
        }
    }
    "`n" # Add a newline for readability between disks
}
