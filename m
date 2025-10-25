Return-Path: <linux-rdma+bounces-14042-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB7EC0964D
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Oct 2025 18:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9C8B34E37D
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Oct 2025 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2521230E85D;
	Sat, 25 Oct 2025 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fL/dblZA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8BC30DEBD;
	Sat, 25 Oct 2025 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409163; cv=none; b=U8u9BSLPQhhQE8geKba5IFmIWsP6euQ/fePRg2fj+Hu9R89/n5Azt7JrLX+1paWcjggVqZs/eJxqt0SuUdh9rEZA/Gh4fKAzGXAQG+l/AKxglP3c/QkYGwy1NqnXl0mFLtIwGzMBd+ftr53T5sxgrWcdDD11ZETqNCjW1henYLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409163; c=relaxed/simple;
	bh=+30FKIxEdVTz0B4kDF4g4b+6ckiJoxjBf4wxOUt1m8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nG8jGWVfW05Gi2QdavP5+PWKws6gt7Nv7pfpDJjNccFZqKK7z5yLdFdsuali/2XwPge47m52MDWVtCOOqTNKS4o6n7bPoAZeP1WyE3decCHSxSLtvjs4aD+6mTglCxJmxTZgvphOCERO6o0QNVS883l/2PGPTXkGhtKL9VDNSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fL/dblZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2DBC4CEF5;
	Sat, 25 Oct 2025 16:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409163;
	bh=+30FKIxEdVTz0B4kDF4g4b+6ckiJoxjBf4wxOUt1m8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fL/dblZAbcnvrsK5M1mm2DBZ7rFU5hVfzdJNrpLdSdLtqrQOG1ejIyo+EW25boRIr
	 x73pof3RaOeUtABMdsla8sRHoxcLF6nzIUmibpNOdw9u3Ze3kzikVVsYDEnosauQOK
	 XInguzg8b2zM+38HoBDSyjgC+ERIa6NtDSopupJjoWuBMy0vHyJykBd+knKxLl2TUC
	 i51/ywEMezVkHMM5/+DyrljeW/6etJKK8zwQcaa6e7idbJTyqrTq+V53mK9Pn4EcZN
	 jRVJNSBSo+3oVPRQQ/vQzZSlw0XR2TV1TgRS9WWltOCiTvZTTAOxbNlU1p71PU0BBH
	 DGoFpfi4nbVkA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ujwal Kundur <ujwal.kundur@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com
Subject: [PATCH AUTOSEL 6.17-5.4] rds: Fix endianness annotation for RDS_MPATH_HASH
Date: Sat, 25 Oct 2025 11:57:37 -0400
Message-ID: <20251025160905.3857885-226-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ujwal Kundur <ujwal.kundur@gmail.com>

[ Upstream commit 77907a068717fbefb25faf01fecca553aca6ccaa ]

jhash_1word accepts host endian inputs while rs_bound_port is a be16
value (sockaddr_in6.sin6_port). Use ntohs() for consistency.

Flagged by Sparse.

Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
Link: https://patch.msgid.link/20250820175550.498-4-ujwal.kundur@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## BACKPORT RECOMMENDATION: YES (Low Priority)

## Executive Summary

This commit fixes a **real but subtle endianness bug** in the RDS
(Reliable Datagram Sockets) multipath hashing mechanism that has existed
since multipath support was introduced in Linux 4.10 (July 2016). The
fix adds a single `ntohs()` call to properly convert network byte order
to host byte order before hashing, ensuring correct behavior across all
architectures.

## Detailed Technical Analysis

### The Bug (net/rds/rds.h:96)

**Before (incorrect):**
```c
#define RDS_MPATH_HASH(rs, n) (jhash_1word((rs)->rs_bound_port, \
                               (rs)->rs_hash_initval) & ((n) - 1))
```

**After (correct):**
```c
#define RDS_MPATH_HASH(rs, n) (jhash_1word(ntohs((rs)->rs_bound_port), \
                               (rs)->rs_hash_initval) & ((n) - 1))
```

### Root Cause Analysis

Using semcode tools, I verified that:

1. **`rs_bound_port` is `__be16`** (net/rds/rds.h:600):
   - Defined as `rs_bound_sin6.sin6_port` from `struct sockaddr_in6`
   - Stored in network byte order (big-endian) as confirmed in
     net/rds/bind.c:126: `rs->rs_bound_port = cpu_to_be16(rover);`

2. **`jhash_1word()` expects `u32` in host byte order**
   (tools/include/linux/jhash.h:170):
  ```c
  static inline u32 jhash_1word(u32 a, u32 initval)
  ```

3. **The macro violates type safety** by passing `__be16` where `u32`
   (host endian) is expected

### Functional Impact

**On Little-Endian Systems (x86, x86_64, ARM-LE):**
- Port 80 (0x0050 in network order) → hashed as 0x5000 (20480) ❌
- Port 443 (0x01BB in network order) → hashed as 0xBB01 (47873) ❌
- Results in **incorrect hash values** and **wrong multipath selection**

**On Big-Endian Systems (SPARC, PowerPC in BE mode):**
- Port 80 → hashed correctly as 80 ✓
- Port 443 → hashed correctly as 443 ✓

**Cross-Architecture Implications:**
- Heterogeneous clusters (mixing LE and BE systems) would compute
  different hashes for the same port
- This violates the fundamental assumption that the same port should
  select the same path consistently

### Code Location and Usage

The `RDS_MPATH_HASH` macro is used in **net/rds/send.c:1050-1052**:
```c
static int rds_send_mprds_hash(struct rds_sock *rs,
                               struct rds_connection *conn, int
nonblock)
{
    int hash;

    if (conn->c_npaths == 0)
        hash = RDS_MPATH_HASH(rs, RDS_MPATH_WORKERS);
    else
        hash = RDS_MPATH_HASH(rs, conn->c_npaths);
    // ... path selection logic
}
```

This function is called from `rds_sendmsg()` to determine which
connection path to use for multipath RDS, affecting all RDS multipath
traffic.

### Historical Context

- **Introduced:** July 14, 2016 in commit 5916e2c1554f3 ("RDS: TCP:
  Enable multipath RDS for TCP")
- **Bug duration:** ~9 years (2016-2025)
- **Affected kernels:** All versions from v4.10 onwards
- **Discovery method:** Sparse static analysis tool
- **No Fixes: tag:** Indicating maintainer didn't consider it critical
- **No Cc: stable tag:** Not marked for automatic stable backporting

### Why This Bug Went Unnoticed

1. **Limited Deployment Scope:**
   - RDS is primarily used in Oracle RAC (Real Application Clusters)
   - Niche protocol with specialized use cases
   - Not commonly deployed in general-purpose environments

2. **Homogeneous Architectures:**
   - Most RDS deployments use identical hardware (typically x86_64)
   - Within a single architecture, the bug is **consistent** (always
     wrong, but deterministically wrong)
   - Same port always selects the same path (even if it's the "wrong"
     path)

3. **Subtle Impact:**
   - Doesn't cause crashes or data corruption
   - Only affects multipath load distribution
   - Performance impact may be attributed to other factors

### Comparison with Correct Usage

Looking at similar kernel code in **include/net/ip.h:714**, I found the
correct pattern:
```c
static inline u32 ipv4_portaddr_hash(const struct net *net,
                                     __be32 saddr,
                                     unsigned int port)
{
    return jhash_1word((__force u32)saddr, net_hash_mix(net)) ^ port;
}
```

Note the explicit `(__force u32)` cast to convert big-endian to host
endian before passing to `jhash_1word()`.

## Backporting Assessment

### Criteria Evaluation

| Criterion | Assessment | Details |
|-----------|-----------|---------|
| **Fixes a real bug** | ✅ YES | Endianness type mismatch causing
incorrect hash on LE systems |
| **Affects users** | ⚠️ LIMITED | RDS is niche; most deployments
homogeneous |
| **Small change** | ✅ YES | Single line, one function call added |
| **Obviously correct** | ✅ YES | Standard byte order conversion;
matches kernel patterns |
| **No side effects** | ⚠️ MINOR | Hash values change on LE systems;
path selection may differ |
| **Architectural change** | ✅ NO | Correctness fix only |
| **Risk of regression** | 🟡 LOW | Minimal; changes observable behavior
but fixes incorrect behavior |

### Benefits of Backporting

1. **Correctness:** Fixes architecturally incorrect code that violates
   API contracts
2. **Sparse-clean:** Brings code in line with kernel coding standards
3. **Cross-architecture consistency:** Ensures LE and BE systems hash
   identically
4. **Future-proofing:** Prevents potential issues in heterogeneous
   deployments
5. **Long-term stability:** Eliminates subtle load-balancing issues

### Risks of Backporting

1. **Behavior Change on LE Systems:**
   - Hash values will change for all ports
   - Existing multipath connections may select different paths after
     upgrade
   - Could cause brief connection disruption during kernel update

2. **Limited Testing:**
   - RDS multipath is not widely deployed
   - Difficult to predict impact on production systems
   - No specific bug reports to validate the fix against

3. **Low Severity:**
   - No CVE assigned
   - No security implications
   - Hasn't caused reported user-facing issues in 9 years

## Related Commits

This is part of a series of endianness annotation fixes by Ujwal Kundur:
- **92b925297a2f** "rds: Fix endianness annotation of jhash wrappers"
  (companion fix)
- **5e9e8e376ae19** "rds: Fix endianness annotations for RDS extension
  headers"

These related commits further support the importance of proper
endianness handling in the RDS subsystem.

## Recommendation Rationale

**YES, this commit should be backported**, but as a **low-priority
correctness fix** rather than a critical bugfix:

1. **It's the right thing to do technically:** The code is objectively
   incorrect and violates the jhash_1word() API contract
2. **Minimal risk:** One-line change with obvious semantics
3. **Long-term benefit:** Prevents future issues and aligns with kernel
   standards
4. **Completeness:** Part of a broader effort to fix RDS endianness
   issues
5. **Stable kernel compatibility:** Follows stable tree rules (small,
   obvious, no ABI change)

**However, prioritization should be LOW because:**
- No reported user issues in 9 years
- Limited real-world impact (niche protocol, homogeneous deployments)
- Maintainer didn't mark as Cc: stable
- Behavior change (hash values) could surprise users

## Suggested Backport Scope

Backport to all **actively maintained stable kernels** where RDS
multipath exists:
- v6.x series (current)
- v5.15+ LTS series
- v5.10 LTS (if still maintained)

**Do NOT backport to:**
- EOL kernels (maintenance overhead not justified)
- Kernels older than v4.10 (RDS_MPATH_HASH doesn't exist)

## Final Verdict

**Backport Status: YES**

This is a **valid correctness fix** for a real architectural bug that
should be backported to stable trees. While the practical impact is
limited due to RDS's specialized usage, the fix is minimal, obviously
correct, and brings the code in line with kernel standards. The small
risk of path selection changes on little-endian systems is outweighed by
the long-term benefits of having correct, Sparse-clean code that behaves
consistently across all architectures.

 net/rds/rds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/rds.h b/net/rds/rds.h
index dc360252c5157..5b1c072e2e7ff 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -93,7 +93,7 @@ enum {
 
 /* Max number of multipaths per RDS connection. Must be a power of 2 */
 #define	RDS_MPATH_WORKERS	8
-#define	RDS_MPATH_HASH(rs, n) (jhash_1word((rs)->rs_bound_port, \
+#define	RDS_MPATH_HASH(rs, n) (jhash_1word(ntohs((rs)->rs_bound_port), \
 			       (rs)->rs_hash_initval) & ((n) - 1))
 
 #define IS_CANONICAL(laddr, faddr) (htonl(laddr) < htonl(faddr))
-- 
2.51.0


