# aws-demo-training — AWS-adapted sandbox definition

A minimal CyberRangeCZ sandbox definition + starter scenario, adapted for an
**AWS** deployment (eu-west-1). Mirrors the upstream `library-demo-training`
but swaps OpenStack image/flavor names for AWS AMIs and EC2 instance types.

## Layout
| File | Role |
|------|------|
| `topology.yml` | Lab environment: 2 hosts + 1 router, two isolated subnets |
| `variables.yml` | Per-sandbox randomized variables (`telnet_port`, `root_flag`) |
| `provisioning/playbook.yml` | Stage-two Ansible: configures the hosts |
| `provisioning/requirements.yml` | Galaxy deps (none here) |
| `training.json` | Starter scenario (levels, tasks, hints, scoring) |

## AWS specifics (already applied)
- `base_box.image` = **AMI IDs** (region-specific, eu-west-1):
  - hosts → `ami-0635b68d5cdcb86e6` (Ubuntu Noble 24.04, user `ubuntu`)
  - router → `ami-05d6feeb792ebaeff` (Debian 12, user `admin`)
- `flavor` = **EC2 instance type** (`t3.small`), not an OpenStack flavor.
- AMIs are eu-west-1 only — re-resolve them if you deploy to another region.

## How to use
1. Push this folder to a Git repo the platform can reach.
2. In the portal UI: **Sandbox Definitions → Create** → paste the Git URL.
   (For a private repo, add its host+token to `git_config.providers` first.)
3. **Build** the definition (creates a sandbox pool); then create a
   **Training Definition** referencing it (or import `training.json`).
