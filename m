Return-Path: <linux-rdma+bounces-19436-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPdUDMor5mkDswEAu9opvQ
	(envelope-from <linux-rdma+bounces-19436-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 15:36:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 045D342C09C
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 15:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D3933044F69
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4943B47F4;
	Mon, 20 Apr 2026 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjBuRiMI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0849F3B47D0;
	Mon, 20 Apr 2026 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691011; cv=none; b=mWV4MOwQOxslbxIP/BHmRrhdbQJdz2lI47P0goeLjKjtaDJ55IeNZ8l5hx+fjQlEdlltvacz7mLJj+FfbijBU5fKHxcrWAQf9mANawtmDL//9JEIvb7QP4J/wYuCLJnq72i54NMlbsTOnft4AYMFoKqMEpZ39uofe4rPdUdU7NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691011; c=relaxed/simple;
	bh=4gTvX7O9br1VZImbOTMo+Dzd9gKTs5QG74I3oFZs8ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hynIYt3V2jJld/PPSYs68RXslP+QmsLyQra73t2YLwpzNsa0pwYQgZn+U5hFwSxbXHbuDBi7lce9fTkrJsJRnmw5Bynob/uJPrjevUEl4E0LwrAyhEkPBYh6f86Gg5nOXlrYqxQBnOh0ryCqG87NEp7gj3NfQzAKJkKSjo7oQ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjBuRiMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0F4C2BCB7;
	Mon, 20 Apr 2026 13:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691010;
	bh=4gTvX7O9br1VZImbOTMo+Dzd9gKTs5QG74I3oFZs8ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EjBuRiMICi1uHkGQjt/2WtWIkb8JoT8qr5dH5jK5sXxJE8BqPq7PHqKUkE1OLxTON
	 5jDUVot+8IoMjPY/l3rxfaZWZvXlHNnHW9vB746xv/hwGsJ/X858mVfk/1UoYwVYCF
	 qRloeQt5cYXtpT1A3rB/DkGHPS9B4FMMoQ1VuvzoOl5ixfMnmVZrvGwJLq6foshNsI
	 mhegSrpW2QOw4t8D/HyWh1eT8SK7sbhz6VlzQcuBCOe+5FRDJOurLp98817jyH6J8O
	 h/Q5ioxfWqRHG6bplJACBuI3Mff/XM6KL9r8wcMKdtZAXWDkJOEG5RWQTKx8z6Tghm
	 pOgKKhNUnEKAg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	mbloch@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.1] net/mlx5e: XSK, Increase size for chunk_size param
Date: Mon, 20 Apr 2026 09:08:27 -0400
Message-ID: <20260420131539.986432-41-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420131539.986432-1-sashal@kernel.org>
References: <20260420131539.986432-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 7.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19436-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,nvidia.com:email]
X-Rspamd-Queue-Id: 045D342C09C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dragos Tatulea <dtatulea@nvidia.com>

[ Upstream commit 1047e14b44edecbbab02a86514a083b8db9fde4d ]

When 64K pages are used, chunk_size can take the 64K value
which doesn't fit in u16. This results in overflows that
are detected in mlx5e_mpwrq_log_wqe_sz().

Increase the type to u32 to fix this.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20260403090927.139042-2-tariqt@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a comprehensive picture. Let me compile the full analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem: `net/mlx5e` (Mellanox ConnectX Ethernet driver, XSK
  subsystem)
- Action verb: "Increase" (but the intent is clearly to fix an overflow
  bug)
- Summary: Widen `chunk_size` from u16 to u32 to prevent integer
  overflow on 64K page systems.

Record: [net/mlx5e XSK] [increase/fix] [type widening to prevent
overflow when chunk_size=65536]

**Step 1.2: Tags**
- Reviewed-by: Carolina Jubran (Nvidia engineer)
- Signed-off-by: Tariq Toukan (mlx5 submaintainer at Nvidia)
- Link:
  https://patch.msgid.link/20260403090927.139042-2-tariqt@nvidia.com
  (patch 2 in a series)
- Signed-off-by: Paolo Abeni (netdev maintainer)
- No Fixes: tag (expected for autosel candidates)
- No Cc: stable (expected)

Record: Reviewed by Nvidia staff. Merged through standard netdev tree.
Patch 2/N series.

**Step 1.3: Commit Body**
- Bug: On systems with 64K pages (ARM64), `chunk_size` can be 65536.
  Stored in u16, this overflows to 0.
- Symptom: "overflows that are detected in `mlx5e_mpwrq_log_wqe_sz()`"
- Root cause: u16 type is too narrow for the value 65536 (0x10000).

**Step 1.4: Hidden Bug Fix Detection**
This is explicitly described as fixing overflows. The word "Increase"
obscures the fix nature, but the body clearly explains the overflow bug.

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- 1 file changed: `drivers/net/ethernet/mellanox/mlx5/core/en/params.h`
- 1 line changed: `u16 chunk_size` -> `u32 chunk_size`
- Scope: Single-file, single-line, surgical fix

**Step 2.2: Code Flow Change**
Before: `chunk_size` stored as u16 (max 65535). When set to 65536 (1 <<
16 on 64K page systems), it silently wraps to 0.
After: `chunk_size` stored as u32 (max ~4 billion). Value 65536 is
stored correctly.

**Step 2.3: Bug Mechanism**
Category: **Integer overflow / type size bug**

The overflow is triggered in `params.c` lines 1125-1131, where a
temporary `mlx5e_xsk_param` is constructed:

```1125:1131:drivers/net/ethernet/mellanox/mlx5/core/en/params.c
for (frame_shift = XDP_UMEM_MIN_CHUNK_SHIFT;
     frame_shift <= PAGE_SHIFT; frame_shift++) {
    struct mlx5e_xsk_param xsk = {
        .chunk_size = 1 << frame_shift,
        .unaligned = false,
    };
```

On 64K page systems (`PAGE_SHIFT=16`), `1 << 16 = 65536` overflows u16
to 0. This then propagates to `order_base_2(0)` in
`mlx5e_mpwrq_page_shift()`, which is undefined behavior.

**Step 2.4: Fix Quality**
- Obviously correct: widening u16 to u32 cannot break anything
- Minimal/surgical: exactly one type change
- Regression risk: effectively zero - u32 holds all values u16 can, plus
  the needed 65536
- The struct padding change is negligible (4 bytes -> 4 bytes due to
  existing alignment)

## PHASE 3: GIT HISTORY INVESTIGATION

**Step 3.1: Blame**
The `u16 chunk_size` field was introduced in commit `a069e977d6d8f2` by
Maxim Mikityanskiy on 2019-06-26, first in v5.3-rc1. The bug has been
present since then - approximately 7 years.

**Step 3.2: Prior Related Fixes**
Commit `a5535e5336943` ("mlx5: stop warning for 64KB pages", 2024-03-28)
was a workaround for a compiler warning about this exact issue. It added
`(size_t)` cast in `mlx5e_validate_xsk_param()` to suppress the warning,
but didn't fix the underlying type issue. That commit's message even
noted "64KB chunks are really not all that useful, so just shut up the
warning by adding a cast."

**Step 3.3: File History**
8 changes to params.h since v6.1. The struct itself has remained stable
- `chunk_size` field unchanged since its introduction.

**Step 3.4: Author Context**
Dragos Tatulea is a regular contributor to mlx5 at Nvidia, with multiple
fixes for 64K page issues (SHAMPO fixes). The submitter Tariq Toukan is
the mlx5e submaintainer. Paolo Abeni (netdev maintainer) merged it.

**Step 3.5: Dependencies**
The diff context shows a `struct mlx5e_rq_opt_param` that doesn't exist
in the v7.0 tree. This means the patch was made against a slightly newer
codebase. However, the actual change (u16->u32 on line 11 of the struct)
is independent and applies with trivial context adjustment.

## PHASE 4: MAILING LIST RESEARCH

**Step 4.1-4.2:** Lore is blocked by Anubis protection. From b4 dig on
the related commit `a5535e5336943`, I confirmed the earlier fix was
patch 8/9 in Arnd Bergmann's series. The current commit appears to be
the proper type-level fix.

**Step 4.3:** No external bug report references. The bug was found
internally by the mlx5 team.

**Step 4.4:** Patch 2/N series (from message-id `-2-`). The companion
patches likely include the `mlx5e_rq_opt_param` struct addition and
possibly removal of the `<= 0xffff` sanity check in
`mlx5e_xsk_is_pool_sane()`. This type-widening patch is standalone for
fixing the overflow.

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1:** The modified struct `mlx5e_xsk_param` is used across the
entire mlx5e XSK/MPWRQ subsystem.

**Step 5.2: Callers of chunk_size**
- `mlx5e_mpwrq_page_shift()` - calls `order_base_2(xsk->chunk_size)` →
  undefined on 0
- `mlx5e_mpwrq_umr_mode()` - compares chunk_size with page_shift
- `mlx5e_validate_xsk_param()` - bounds check
- `mlx5e_build_xsk_param()` - stores pool chunk_size into struct
- Internal calculation loop in params.c - creates temporary structs
- `mlx5e_create_rq_umr_mkey()` in en_main.c - passes to hardware

**Step 5.4: Reachability**
The overflow triggers when ANY XDP program is loaded on an mlx5
interface on a 64K page system. The calculation loop runs during channel
configuration, not just when XSK is explicitly used. This is a common
scenario for ARM64 servers.

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1:** The buggy code (`u16 chunk_size` in `mlx5e_xsk_param`)
exists in all stable trees from v5.3 onward (introduced 2019-06-26).

**Step 6.2:** Minor context adjustment needed (surrounding struct
differs). The one-line change itself is trivially backportable.

**Step 6.3:** The earlier workaround (`a5535e5336943`) only suppressed a
compiler warning but didn't fix the runtime overflow.

## PHASE 7: SUBSYSTEM CONTEXT

**Step 7.1:** Subsystem: drivers/net (networking, Mellanox ConnectX).
Criticality: IMPORTANT - widely used enterprise network hardware.

**Step 7.2:** Very active subsystem with frequent fixes, especially for
64K page support issues (multiple SHAMPO fixes by the same author).

## PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1: Affected Users**
ARM64 systems with 64K pages running mlx5 (Mellanox ConnectX) NICs with
XDP programs. This includes ARM64 servers in data centers.

**Step 8.2: Trigger Conditions**
Loading any XDP program on an mlx5 interface on a 64K page system
triggers the internal calculation loop. The overflow happens during
channel parameter computation.

**Step 8.3: Failure Mode**
- `order_base_2(0)` is undefined behavior, potentially returning garbage
- Wrong `page_shift` propagates through `mlx5e_mpwrq_log_wqe_sz()`,
  detected as overflow
- At minimum: WARN_ON triggers and incorrect hardware configuration
- At worst: incorrect WQE sizes could cause hardware errors, packet
  loss, or crashes
- Severity: **HIGH**

**Step 8.4: Risk-Benefit Ratio**
- Benefit: HIGH - fixes undefined behavior and incorrect calculations on
  64K page ARM64 systems
- Risk: VERY LOW - changing u16 to u32 is trivially correct, cannot
  introduce regression
- Ratio: Strongly favorable for backporting

## PHASE 9: FINAL SYNTHESIS

**Evidence FOR backporting:**
- Fixes a real integer overflow bug causing undefined behavior
- Affects 64K page ARM64 systems with widely-used enterprise hardware
- One-line, obviously correct fix (type widening)
- Zero regression risk
- Bug present since v5.3 (7 years)
- Author is a known mlx5 contributor, reviewed by Nvidia staff, merged
  by netdev maintainer
- The earlier workaround (compiler warning fix) acknowledged the problem
  existed

**Evidence AGAINST backporting:**
- Needs minor context adjustment (surrounding struct differs)
- 64K page systems are a subset of users
- The `mlx5e_xsk_is_pool_sane()` check may prevent user-facing triggers
  (but NOT the internal calculation path)

**Stable Rules Checklist:**
1. Obviously correct and tested? YES - trivial type widening
2. Fixes a real bug? YES - integer overflow causing undefined behavior
3. Important issue? YES - undefined behavior, potential incorrect
   hardware config
4. Small and contained? YES - one line change
5. No new features or APIs? CORRECT - just a type fix
6. Can apply to stable trees? YES with trivial context adjustment

**Verification:**
- [Phase 1] Parsed tags: Reviewed-by Nvidia, merged by netdev
  maintainer. Patch 2/N series.
- [Phase 2] Diff analysis: single line type change u16->u32 in struct
  mlx5e_xsk_param
- [Phase 3] git blame: chunk_size as u16 introduced in a069e977d6d8f2
  (v5.3-rc1, 2019), present in all active stable trees
- [Phase 3] git show a5535e5336943: prior workaround only added a cast,
  didn't fix the type
- [Phase 4] b4 dig for related commit found lore thread; Anubis blocked
  direct access
- [Phase 5] Traced callers: overflow at params.c:1129 feeds into
  order_base_2(0) in mpwrq_page_shift()
- [Phase 5] Verified xsk_pool_get_chunk_size() returns u32, truncated
  when stored in u16
- [Phase 6] Code exists in all stable trees from v5.3+; 8 changes to
  file since v6.1
- [Phase 6] Minor context conflict (mlx5e_rq_opt_param not in stable),
  trivially resolvable
- [Phase 8] Trigger: loading any XDP program on mlx5 on 64K page system;
  severity HIGH
- UNVERIFIED: Could not access lore.kernel.org to read full mailing list
  discussion

The fix is minimal, obviously correct, and addresses a real integer
overflow that causes undefined behavior on ARM64 systems with 64K pages.
The risk is negligible and the benefit is clear.

**YES**

 drivers/net/ethernet/mellanox/mlx5/core/en/params.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index 00617c65fe3cd..c5aaaa4ac3648 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -8,7 +8,7 @@
 
 struct mlx5e_xsk_param {
 	u16 headroom;
-	u16 chunk_size;
+	u32 chunk_size;
 	bool unaligned;
 };
 
-- 
2.53.0


