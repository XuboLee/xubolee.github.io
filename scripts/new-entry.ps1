param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("publication", "project", "travel")]
    [string]$Type,

    [Parameter(Mandatory = $true)]
    [string]$Title,

    [string]$Slug,

    [datetime]$Date = (Get-Date),

    [string]$Venue = "",

    [ValidateSet("manuscripts", "conferences")]
    [string]$Category = "conferences"
)

function New-Slug {
    param([string]$Value)

    $normalized = $Value.ToLowerInvariant()
    $normalized = $normalized -replace "[^a-z0-9]+", "-"
    $normalized = $normalized.Trim("-")

    if ([string]::IsNullOrWhiteSpace($normalized)) {
        throw "Unable to generate a valid slug from the title."
    }

    return $normalized
}

$repoRoot = Split-Path -Parent $PSScriptRoot

if (-not $Slug) {
    $Slug = New-Slug -Value $Title
}

$datePrefix = $Date.ToString("yyyy-MM-dd")

switch ($Type) {
    "publication" {
        $targetDir = Join-Path $repoRoot "_publications"
        $targetFile = Join-Path $targetDir "$datePrefix-$Slug.md"
        $content = @(
            "---"
            "title: ""$Title"""
            "collection: publications"
            "category: $Category"
            "permalink: /publication/$Slug"
            "date: $datePrefix"
            "venue: ""$Venue"""
            "excerpt: ""One-sentence summary of the paper."""
            "paperurl: """""
            "slidesurl: """""
            "codeurl: """""
            "videourl: """""
            "citation: ""Authors, \""$Title\"", venue, year."""
            "published: false"
            "---"
            ""
            "Add an abstract, contribution summary, notes, or related links here."
            ""
            "Upload files as needed:"
            "- PDF: /files/papers/"
            "- Slides: /files/slides/"
            "- Code: external repository URL"
            "- Video: YouTube/Bilibili/etc. URL"
        )
    }
    "project" {
        $targetDir = Join-Path $repoRoot "_portfolio"
        $targetFile = Join-Path $targetDir "$datePrefix-$Slug.md"
        $content = @(
            "---"
            "title: ""$Title"""
            "collection: portfolio"
            "permalink: /project/$Slug"
            "date: $datePrefix"
            "excerpt: ""Short project summary."""
            "published: false"
            "---"
            ""
            "Describe the project, goals, progress, links, datasets, or code here."
        )
    }
    "travel" {
        $targetDir = Join-Path $repoRoot "_travel"
        $targetFile = Join-Path $targetDir "$datePrefix-$Slug.md"
        $content = @(
            "---"
            "title: ""$Title"""
            "collection: travel"
            "permalink: /travel/$Slug"
            "date: $datePrefix"
            "excerpt: ""Short travel note summary."""
            "published: false"
            "---"
            ""
            "Write the travel note here. Conference impressions, photos, and city notes all fit well."
        )
    }
}

if (Test-Path $targetFile) {
    throw "Target file already exists: $targetFile"
}

if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir | Out-Null
}

Set-Content -Path $targetFile -Value $content -Encoding UTF8
Write-Host "Created $targetFile"
