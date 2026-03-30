Return-Path: <linux-rdma+bounces-18786-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMYNBsdwymnG8gUAu9opvQ
	(envelope-from <linux-rdma+bounces-18786-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 14:47:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 793F035B407
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 14:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AEFD30A77A8
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 12:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06763D75BA;
	Mon, 30 Mar 2026 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVEj0m9v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D13D6CCA;
	Mon, 30 Mar 2026 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874357; cv=none; b=ewXisAFlbzXdASe6C1UjozmG7E2/m1UJLcqg7A+xUbs2p03hA8wxifOmOwNLT0I0qbHDrZlvFrtetzlVcvIHZoXLoMYBWeOBzjq+L0uPsSdU+uGvZkq5Ln9sLmNuwN6I6fujihUm2RQKUaQD35PsWbcBIRMp/6iAy4CZWY+fbUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874357; c=relaxed/simple;
	bh=4dyZy//1X+fVVnoNZknAXNXq0USkV3bXJr+4nv7eBKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cn23pMcWwcX0ymkctwn3LqyP4rTD11sMW9UitVs5BjnuiP4mONCDrqozlYsa1wfjEEClMS8TY4gM7n25mO5jOHsVff1TL5aSRJfUXSotAZ2K4yQMDVl1JbCi41Fgq02ZY5vkpTbBSgQawtizCZjtR6MrabjfccZqOKyHydffG/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVEj0m9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C6FC4CEF7;
	Mon, 30 Mar 2026 12:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774874356;
	bh=4dyZy//1X+fVVnoNZknAXNXq0USkV3bXJr+4nv7eBKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cVEj0m9v1NsfKaOWhAOMvy2A/WDOce/obbDKErN8s8qP/4DQOsEUBYG+f+wcxjAr+
	 UogHzmLHS2Mx+n9Nxo9RdDQU08EwJehczOIB5MgEYSSZB1WP5EjtCY1cyEmeILxRU+
	 qw4AOoD3TMWlzviEYgSXOchnkQ0OKkuRncLNneQC4G3mKr4BFBN2FRj+SQyfZ+AG67
	 5axUWg12zjHm+ktWCadTLQ8o/zqexjIkR5R5+RnUFF9YqF3lelhdz2ZMOMYnP/v0KJ
	 hoXhl5+xfc40dX0s6fL9x8sb1Ybwf/n/ViWE5ZBQM/WVm0AmFwY5SQpyeHTXAHe0Pj
	 9d/wvvVYWHwrw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	krzysztof.czurylo@intel.com,
	tatyana.e.nikolova@intel.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.6] RDMA/irdma: Fix double free related to rereg_user_mr
Date: Mon, 30 Mar 2026 08:38:36 -0400
Message-ID: <20260330123842.756154-23-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330123842.756154-1-sashal@kernel.org>
References: <20260330123842.756154-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18786-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 793F035B407
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jacob Moroni <jmoroni@google.com>

[ Upstream commit 29a3edd7004bb635d299fb9bc6f0ea4ef13ed5a2 ]

If IB_MR_REREG_TRANS is set during rereg_user_mr, the
umem will be released and a new one will be allocated
in irdma_rereg_mr_trans. If any step of irdma_rereg_mr_trans
fails after the new umem is allocated, it releases the umem,
but does not set iwmr->region to NULL. The problem is that
this failure is propagated to the user, who will then call
ibv_dereg_mr (as they should). Then, the dereg_mr path will
see a non-NULL umem and attempt to call ib_umem_release again.

Fix this by setting iwmr->region to NULL after ib_umem_release.

Fixed: 5ac388db27c4 ("RDMA/irdma: Add support to re-register a memory region")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
Link: https://patch.msgid.link/20260227152743.1183388-1-jmoroni@google.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the facts. Here is my complete analysis:

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: PARSE THE SUBJECT LINE
Record: [RDMA/irdma] [Fix] [double free related to rereg_user_mr — stale
`iwmr->region` pointer after error in `irdma_rereg_mr_trans`]

### Step 1.2: PARSE ALL COMMIT MESSAGE TAGS
- **Fixed:** `5ac388db27c4` ("RDMA/irdma: Add support to re-register a
  memory region") — Note: uses `Fixed:` instead of the standard `Fixes:`
  tag, but semantically identical. This identifies the commit that
  introduced the bug.
- **Signed-off-by:** Jacob Moroni <jmoroni@google.com> (author)
- **Link:**
  https://patch.msgid.link/20260227152743.1183388-1-jmoroni@google.com
- **Signed-off-by:** Leon Romanovsky <leon@kernel.org> (RDMA subsystem
  maintainer)
- No Reported-by, Tested-by, Reviewed-by, Acked-by, or Cc: stable tags
  present.

Record: Author from Google with prior RDMA double-free fixes (e.g.,
`40126bcbefa79 RDMA/umem: Fix double dma_buf_unpin in failure path`).
Accepted through the RDMA maintainer tree (Leon Romanovsky).

### Step 1.3: ANALYZE THE COMMIT BODY TEXT
The commit message precisely describes the bug mechanism:
1. When `IB_MR_REREG_TRANS` is set, `irdma_rereg_user_mr()` releases the
   old umem and NULLs `iwmr->region`.
2. `irdma_rereg_mr_trans()` allocates a new umem and stores it in
   `iwmr->region` (line 3700).
3. If a later step fails (page_size check or
   `irdma_reg_user_mr_type_mem()`), the `err:` path calls
   `ib_umem_release(region)` but does NOT set `iwmr->region = NULL`.
4. Error propagates to userspace. User correctly calls `ibv_dereg_mr`.
5. `irdma_dereg_mr()` sees non-NULL `iwmr->region` at line 3932 and
   calls `ib_umem_release()` again — double free.

Record: Bug = double free of ib_umem. Symptom = kernel crash, memory
corruption, or potential security vulnerability. Root cause = stale
pointer in `iwmr->region` after error-path free.

### Step 1.4: DETECT HIDDEN BUG FIXES
Record: Not hidden — explicitly labeled "Fix double free." This is a
direct, clear memory-safety bug fix.

---

## PHASE 2: DIFF ANALYSIS — LINE BY LINE

### Step 2.1: INVENTORY THE CHANGES
Record: **1 file**: `drivers/infiniband/hw/irdma/verbs.c`, **+1 line**
added. Function modified: `irdma_rereg_mr_trans()`. Scope: single-file,
single-line surgical fix.

### Step 2.2: UNDERSTAND THE CODE FLOW CHANGE
Before the fix, the `err:` label at line 3721 runs:

```3721:3723:drivers/infiniband/hw/irdma/verbs.c
err:
        ib_umem_release(region);
        return err;
```

After the fix, it becomes:
```c
err:
        ib_umem_release(region);
        iwmr->region = NULL;
        return err;
```

Record: Before = freed memory, left dangling pointer in `iwmr->region`.
After = freed memory, set `iwmr->region = NULL` to prevent double-free
in `irdma_dereg_mr()`.

### Step 2.3: IDENTIFY THE BUG MECHANISM
Category: **Double-free / memory safety**.

The confirmed double-free path:
1. Line 3700: `iwmr->region = region;` — stores new umem pointer
2. Lines 3706-3717: possible failure paths (`goto err`)
3. Line 3722: `ib_umem_release(region);` — frees the umem
4. Line 3723: returns error (but `iwmr->region` still points to freed
   memory)
5. Later, in `irdma_dereg_mr()`:

```3932:3933:drivers/infiniband/hw/irdma/verbs.c
        if (iwmr->region)
                ib_umem_release(iwmr->region);
```

This calls `ib_umem_release()` on already-freed memory. Verified that
`ib_umem_release()` dereferences the `umem` object, unpins pages, and
calls `kfree(umem)` (confirmed in `drivers/infiniband/core/umem.c` lines
284-298).

Record: Double-free of `ib_umem` object. The second `ib_umem_release()`
dereferences freed memory and kfree's it again.

### Step 2.4: ASSESS THE FIX QUALITY
The fix is obviously correct: it sets `iwmr->region = NULL` after
freeing the object, which is the standard kernel pattern for preventing
double-frees. This **exactly matches** the existing pattern in the same
file — `irdma_rereg_user_mr()` already does this at lines 3775-3777:

```3775:3778:drivers/infiniband/hw/irdma/verbs.c
                if (iwmr->region) {
                        ib_umem_release(iwmr->region);
                        iwmr->region = NULL;
                }
```

Record: Fix is obviously correct, minimal, follows existing code
conventions, zero regression risk.

---

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: BLAME THE CHANGED LINES
Git blame confirms every line in `irdma_rereg_mr_trans()` (lines
3696-3723) was introduced by commit `5ac388db27c4` (Sindhu Devale,
2023-10-04). The bug has existed since the function was first written.

Record: Buggy code introduced in `5ac388db27c4`, first appeared in
v6.7-rc1.

### Step 3.2: FOLLOW THE FIXES: TAG
`git show 5ac388db27c4` confirms it added the entire MR re-registration
support to irdma, including `irdma_rereg_mr_trans()`,
`irdma_rereg_user_mr()`, and `.rereg_user_mr` in the device ops table.

`git describe --contains 5ac388db27c4` → `v6.7-rc1~96^2~21` — first
released in v6.7.

`git merge-base --is-ancestor 5ac388db27c4 v6.6` → exit 1 (NOT in v6.6).
`git merge-base --is-ancestor 5ac388db27c4 v6.7` → exit 0 (IS in v6.7).

`git grep irdma_rereg_mr_trans v6.6` → no match.
`git grep irdma_rereg_mr_trans v6.12` → match (3 references).

Record: Original buggy commit exists in v6.7+ stable trees. NOT in
v6.6.y or older. Bug present since inception of the function.

### Step 3.3: CHECK FILE HISTORY FOR RELATED CHANGES
Recent file history shows active irdma maintenance but no related fix
for this specific double-free. No prerequisite commits needed.

Record: Standalone fix, no dependencies.

### Step 3.4: CHECK THE AUTHOR'S OTHER COMMITS
Jacob Moroni has multiple RDMA commits including `40126bcbefa79
RDMA/umem: Fix double dma_buf_unpin in failure path` — another double-
free fix in RDMA umem handling. This demonstrates relevant domain
expertise.

Record: Author is an active RDMA contributor with prior double-free
fixes. Patch accepted by RDMA subsystem maintainer Leon Romanovsky.

### Step 3.5: CHECK FOR DEPENDENT/PREREQUISITE COMMITS
The fix is a single-line NULL assignment in an existing error path. No
dependencies.

Record: Fully standalone, clean apply expected.

---

## PHASE 4: MAILING LIST AND EXTERNAL RESEARCH

### Steps 4.1-4.4
Lore.kernel.org access was blocked by Anubis proof-of-work page. The
patch.msgid.link URL was also inaccessible. Web searches did not locate
a mirror of the exact patch discussion.

However, the patch was accepted through the standard RDMA maintainer
tree (Signed-off-by: Leon Romanovsky), indicating it passed normal
review.

Record: UNVERIFIED: Could not access mailing list discussion due to
anti-bot measures. No additional context about reviewer feedback or
stable nominations.

---

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1: IDENTIFY KEY FUNCTIONS
- `irdma_rereg_mr_trans()` — modified (error path)
- `irdma_rereg_user_mr()` — caller, wired as `.rereg_user_mr` in device
  ops
- `irdma_dereg_mr()` — site of the second (double) free, wired as
  `.dereg_mr`

### Step 5.2: TRACE CALLERS
- `irdma_rereg_user_mr()` is registered as `.rereg_user_mr` in the irdma
  device ops
- RDMA core's `ib_uverbs_rereg_mr()` (in
  `drivers/infiniband/core/uverbs_cmd.c`) calls
  `ib_dev->ops.rereg_user_mr()`
- This is reachable from userspace via RDMA uverbs

The double-free path:
- Userspace `ibv_dereg_mr` → RDMA core MR destroy → `ib_dereg_mr_user()`
  → `irdma_dereg_mr()` → `ib_umem_release(iwmr->region)` on dangling
  pointer

Record: Both entry points (rereg and dereg) are userspace-reachable
through RDMA uverbs.

### Step 5.3: TRACE CALLEES
`ib_umem_release()` (confirmed at `drivers/infiniband/core/umem.c:284`)
dereferences the `umem` object, unpins pages via `__ib_umem_release()`,
decrements `pinned_vm`, calls `mmdrop()`, and finally `kfree(umem)`. A
second call on the same freed pointer is a genuine double-free with
memory corruption.

### Step 5.4: CALL CHAIN REACHABILITY
Userspace → `ibv_rereg_mr` → `ib_uverbs_rereg_mr()` →
`irdma_rereg_user_mr()` → `irdma_rereg_mr_trans()` (fails) → returns
error to user → user calls `ibv_dereg_mr` → `irdma_dereg_mr()` → double
free.

Record: Fully userspace-reachable path on systems with irdma hardware.

### Step 5.5: SIMILAR PATTERNS
The caller `irdma_rereg_user_mr()` already correctly does
`ib_umem_release(iwmr->region); iwmr->region = NULL;` at lines
3775-3777, establishing the pattern. The omission in
`irdma_rereg_mr_trans()` is an inconsistency with the file's own
conventions.

---

## PHASE 6: CROSS-REFERENCING AND STABLE TREE ANALYSIS

### Step 6.1: DOES THE BUGGY CODE EXIST IN STABLE TREES?
- **v6.6.y**: NOT present (confirmed via `git grep` — no match for
  `irdma_rereg_mr_trans`)
- **v6.12.y**: Present (confirmed via `git grep` — 3 references found)
- **v6.7+**: All trees contain the buggy code

Record: Affects stable trees v6.7 and newer (including 6.12.y). NOT
applicable to v6.6.y or older.

### Step 6.2: BACKPORT COMPLICATIONS
The one-line fix in an unchanged error path should apply cleanly to all
trees containing the function.

Record: Expected clean apply, no conflicts.

### Step 6.3: CHECK IF RELATED FIXES ARE ALREADY IN STABLE
`git log --grep="double free" --grep="rereg_user_mr"` — no results. The
fix is not yet in any tree.

Record: No related fix already applied.

---

## PHASE 7: SUBSYSTEM AND MAINTAINER CONTEXT

### Step 7.1: SUBSYSTEM CRITICALITY
- Subsystem: RDMA / irdma driver (`drivers/infiniband/hw/irdma/`)
- Criticality: IMPORTANT for RDMA deployments — Intel iWARP hardware
  used in data centers, HPC, and cloud infrastructure. While not core-mm
  universal, a kernel memory-safety bug on a userspace-reachable path
  has security implications.

### Step 7.2: SUBSYSTEM ACTIVITY
Actively maintained — 15+ recent commits show ongoing bug fixes and
development.

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: WHO IS AFFECTED
Users of Intel RDMA (irdma) hardware who use MR re-registration with the
`IB_MR_REREG_TRANS` flag.

Record: Driver-specific (irdma users), but these are often production
data center systems.

### Step 8.2: TRIGGER CONDITIONS
1. Userspace calls `ibv_rereg_mr` with `IB_MR_REREG_TRANS`
2. `irdma_rereg_mr_trans()` fails after allocating the new umem (either
   `ib_umem_find_best_pgsz()` returns 0 or
   `irdma_reg_user_mr_type_mem()` fails)
3. User then correctly calls `ibv_dereg_mr` to clean up

This is a deterministic error-path trigger, not a timing race. Any
application hitting a registration failure and cleaning up properly will
trigger it.

Record: Deterministic trigger on error path. Userspace-reachable.

### Step 8.3: FAILURE MODE SEVERITY
Double-free of a `ib_umem` structure. `ib_umem_release()` dereferences
multiple fields and calls `kfree()`. A second call on freed memory
causes:
- Heap corruption (SLAB allocator corruption)
- Kernel crash / oops
- Potential security vulnerability (exploitable heap corruption)

Record: Severity: **CRITICAL** (double-free of kernel heap object on
userspace-triggerable path)

### Step 8.4: RISK-BENEFIT RATIO
- **Benefit:** HIGH — prevents a double-free / memory corruption on a
  userspace-reachable error path
- **Risk:** VERY LOW — single line `iwmr->region = NULL;` after free,
  follows existing code pattern, obviously correct
- **Ratio:** Extremely favorable for backporting

---

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: COMPILE THE EVIDENCE

**FOR backporting:**
- Verified double-free of `ib_umem` object on a userspace-reachable
  error path
- `ib_umem_release()` confirmed to dereference and `kfree()` the object
- Single-line, obviously correct fix (NULL-after-free)
- Matches existing code pattern in the same file (lines 3775-3777)
- Bug present since function was introduced in v6.7-rc1 (`5ac388db27c4`)
- Zero regression risk
- Author has prior RDMA double-free fix expertise
- Accepted by RDMA subsystem maintainer

**AGAINST backporting:**
- None.

**UNRESOLVED:**
- Could not access lore.kernel.org mailing list discussion (Anubis
  block)
- No independent crash report verified (no Reported-by tag)

### Step 9.2: STABLE RULES CHECKLIST
1. Obviously correct and tested? **YES** — single-line NULL assignment
   after free, matches existing pattern
2. Fixes a real bug? **YES** — verified double-free via code path
   analysis
3. Important issue? **YES** — double-free = crash/corruption/potential
   security vulnerability (CRITICAL)
4. Small and contained? **YES** — 1 line, 1 file, 1 function error path
5. No new features or APIs? **YES** — pure bug fix
6. Can apply to stable trees? **YES** — clean apply expected on v6.7+
   trees

### Step 9.3: EXCEPTION CATEGORIES
N/A — this is a standard bug fix meeting all criteria directly.

### Step 9.4: DECISION
This is a textbook stable backport candidate: a one-line fix for a
verified double-free on a userspace-reachable path, with zero regression
risk, applicable to stable trees v6.7 and newer (not v6.6.y or older,
where the code does not exist).

---

## Verification

- [Phase 1] Parsed all tags from commit message: `Fixed: 5ac388db27c4`,
  `Link:`, two `Signed-off-by:` (author + maintainer). No Reported-
  by/Tested-by/Cc:stable.
- [Phase 2] Read `verbs.c` lines 3690-3724: confirmed `iwmr->region =
  region` at line 3700, `err:` path at lines 3721-3723 releases region
  without NULLing `iwmr->region`.
- [Phase 2] Read `verbs.c` lines 3905-3938: confirmed `irdma_dereg_mr()`
  checks `if (iwmr->region)` at line 3932 and calls
  `ib_umem_release(iwmr->region)` — this is the second free.
- [Phase 2] Read `drivers/infiniband/core/umem.c` lines 284-298:
  confirmed `ib_umem_release()` dereferences umem fields and calls
  `kfree(umem)`.
- [Phase 2] Verified existing NULL-after-free pattern at lines 3775-3777
  in `irdma_rereg_user_mr()`.
- [Phase 3] `git blame -L 3696,3723`: all lines from `5ac388db27c4`
  (Sindhu Devale, 2023-10-04).
- [Phase 3] `git show 5ac388db27c4`: confirmed it adds MR re-
  registration support including the buggy function.
- [Phase 3] `git describe --contains 5ac388db27c4` → `v6.7-rc1~96^2~21`.
- [Phase 3] `git merge-base --is-ancestor 5ac388db27c4 v6.6` → exit 1
  (NOT in v6.6).
- [Phase 3] `git merge-base --is-ancestor 5ac388db27c4 v6.7` → exit 0
  (IS in v6.7).
- [Phase 3] `git log --author="Jacob Moroni"`: found 10 RDMA commits
  including `40126bcbefa79 RDMA/umem: Fix double dma_buf_unpin in
  failure path`.
- [Phase 4] UNVERIFIED: Lore/patch discussion blocked by Anubis anti-bot
  page.
- [Phase 5] Grep for `if (iwmr->region)` in verbs.c: found at lines
  3775, 3912, and 3932 — all three sites depend on `iwmr->region`
  accurately reflecting ownership.
- [Phase 6] `git grep irdma_rereg_mr_trans v6.6` → no match (code absent
  from v6.6).
- [Phase 6] `git grep irdma_rereg_mr_trans v6.12` → 3 matches (code
  present in v6.12).
- [Phase 6] `git log --grep="double free" --grep="rereg_user_mr"` → no
  results (fix not yet applied anywhere).
- [Phase 8] Failure mode: double-free of `ib_umem` → heap corruption,
  crash, potential security exploit. Severity CRITICAL.
- UNVERIFIED: Mailing list reviewer feedback and stable nominations
  (lore blocked).
- UNVERIFIED: Whether an independent crash report exists beyond the
  author's finding.

**YES**

 drivers/infiniband/hw/irdma/verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 68fb81b7bd221..18844d24973be 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3720,6 +3720,7 @@ static int irdma_rereg_mr_trans(struct irdma_mr *iwmr, u64 start, u64 len,
 
 err:
 	ib_umem_release(region);
+	iwmr->region = NULL;
 	return err;
 }
 
-- 
2.53.0


