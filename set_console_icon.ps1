param(
    [Parameter(Mandatory = $true)]
    [string]$IconPath
)

if (-not (Test-Path -LiteralPath $IconPath -PathType Leaf)) {
    exit 0
}

Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;

public static class ULanConsoleIcon {
    [DllImport("kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();

    [DllImport("user32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
    public static extern IntPtr LoadImage(IntPtr instance, string name, uint type, int width, int height, uint flags);

    [DllImport("user32.dll")]
    public static extern IntPtr SendMessage(IntPtr window, uint message, IntPtr iconType, IntPtr icon);

    [DllImport("user32.dll")]
    public static extern bool IsWindow(IntPtr window);
}
'@

$window = [ULanConsoleIcon]::GetConsoleWindow()
if ($window -eq [IntPtr]::Zero) {
    exit 0
}

$icon = [ULanConsoleIcon]::LoadImage([IntPtr]::Zero, $IconPath, 1, 0, 0, 0x10)
if ($icon -eq [IntPtr]::Zero) {
    [Console]::Error.WriteLine("ULan: Could not load console icon from '{0}'." -f $IconPath)
    exit 1
}

[void][ULanConsoleIcon]::SendMessage($window, 0x80, [IntPtr]1, $icon)
[void][ULanConsoleIcon]::SendMessage($window, 0x80, [IntPtr]0, $icon)

while ([ULanConsoleIcon]::IsWindow($window)) {
    Start-Sleep -Seconds 2
}
