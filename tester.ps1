# Define file paths
$scriptPath = $MyInvocation.MyCommand.Path
$cppFile = ".\hello.cpp"
$javaFile = ".\hello.java"
$pythonFile = ".\hello.py"

# Initialize a flag to track successful runs
$allRunsSuccessful = $true

Remove-Item ".\.git" -Force -Recurse
Remove-Item "4" -Force -ErrorAction SilentlyContinue

# Compile C++ file
Write-Host "Compiling hello.cpp..."
$cppCompile = g++ $cppFile -o hello_cpp.exe 2>&1
if ($cppCompile -eq $null) {
    Write-Host "C++ compile successful"
} else {
    Write-Host "C++ compile failed:"
    Write-Host $cppCompile
	$allRunsSuccessful = $false
}

# Run C++ executable
Write-Host "Running hello_cpp.exe..."
$cppRun = .\hello_cpp.exe
if ($LASTEXITCODE -eq 0) {
    Write-Host "C++ run successful"
	Remove-Item $cppFile -Force
	Remove-Item ".\hello_cpp.exe" -force
	Write-Host "C++ files scrubbed"
} else {
    Write-Host "C++ run failed"
	$allRunsSuccessful = $false
}

# Compile Java file
Write-Host "Compiling hello.java..."
$javaCompile = javac hello.java
if ($javaCompile -eq $null) {
    Write-Host "Java compile successful"
} else {
    Write-Host "Java compile failed:"
    Write-Host $javaCompile
	$allRunsSuccessful = $false
}

#Run Java file
Write-Host "Running hello.java..."
$javaRun = java hello
if ($LASTEXITCODE -eq 0) {
    Write-Host "Java run successful"
	Remove-Item $javaFile -Force
	Remove-Item "hello.class" -Force
	Write-Host "Java files scrubbed"
} else {
    Write-Host "Java run failed"
	$allRunsSuccessful = $false
}

# Run Python file
Write-Host "Running hello.py..."
$pythonRun = python $pythonFile
if ($LASTEXITCODE -eq 0) {
    Write-Host "Python run successful"
	Remove-Item $pythonFile -Force
	Write-Host "Python files scrubbed"
} else {
    Write-Host "Python run failed"
	$allRunsSuccessful = $false
}

# Remove the script if all runs were successful
if ($allRunsSuccessful) {
    Write-Host "All runs were successful. Removing the script..."
    Remove-Item $scriptPath -Force
} else {
    Write-Host "Not all runs were successful. The script will not be removed."
}
