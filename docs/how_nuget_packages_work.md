# What is it?

NuGet is basically a zip containing DLLs and a manifest. It can be thought of as a spec for sharing code across projects.

# How they work

Nuget handles
- resolution: checks framework version (e.g., .NET 9.0) and pulls the correct version of the DLL
- dependency graphing: package A needs package B, NuGet ensures both are pulled and checks for version conflicts 
- reference injection: instructs compiler to refer to packages
