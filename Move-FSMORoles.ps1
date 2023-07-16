# Transfers FSMO roles from one DC to another DC

Function Move-Afsmo {
    [CmdletBinding()]
    param([string]$server,
        [ValidateSet("schema", "domain", "rid", "infra", "pdc")]
        [string]$fsmo
    )
    $dom = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
    $sid = ($dom.GetDirectoryEntry()).objectSid
    $dc = [ADSI]"LDAP://$server/rootDSE"
    switch ($fsmo.ToLower()) {
        "schema" { $role = "becomeSchemaMaster"; break }
        "domain" { $role = "becomeDomainMaster"; break }
        "rid" { $role = "becomeRidMaster"; break }
        "infra" { $role = "becomeInfraStructureMaster"; break }
        "pdc" { $role = "becomePDC"; break }
    }
    if ($role -eq "becomePDC") { $dc.Put($role, $sid[0]) }
    else { $dc.Put($role, 1) }
    $dc.SetInfo()
}

# Call the Function
Move-Afsmo -Server <ServerName> -Fsmo <RoleName>

# Role Names: schema, domain, rid, infra, and pdc
# FSMO Roles: Schema Master,  Domain Naming Master, PDC Emulator, RID Master, Infrastructure Master