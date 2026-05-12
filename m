Return-Path: <linux-rdma+bounces-20526-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGLCIGqKA2pN7AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20526-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 22:15:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D883B529035
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 22:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5734430BBB12
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27433AE193;
	Tue, 12 May 2026 20:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSu5Ma5s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811BB3AD500
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616902; cv=none; b=FmkgzxCJ6VaOSbYdOqTxM22D4I5VkCwlE9TACHI8Hrn9dUIyWGdH9zpxfChswsfimPmMILGnox6n5R3kaVUHxlps8UptDl8Cz/Ne2mEi88T98hVwW187ngGJy/rCh18nWUD1AZ4ep7iQfMtcKQDax6rgz9HyFA2pA9zjkaNXafY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616902; c=relaxed/simple;
	bh=zfIW3SWBWkGjyw2N/9XJJ/fBo/zN+ESmBUF1nU+dO8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oCpp6vwhQM0DhYwGX2ZvDhIn+L+j8v0Syf/iPxCYavaSJIbpED/SPNPP0Bit7vN1B9ttxfFdcvHjUeEge5EtiHmjmPH5FZpajiezsUhDTiPBz4pnX0SILUj0o+2OO+2Ltouz2OD0sAd4I4NvKcJ/+GC592oYviLiKvsYSnxrShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSu5Ma5s; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-47c941f7213so3649834b6e.1
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778616898; x=1779221698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3v4lmT0LIyVJwbA8rQHi/i9UgyWWjq/btGUpulIz2qM=;
        b=nSu5Ma5sREYr8Uiik5cG+7MgdPsaHlXo+usxUhcTfltjuoJ5Ru3s3sDXtm4x/4U3YT
         fH8K1VjoYL/Yl5PlXvrP5YAP/M93pF1z4kb/h+1QecbwQhieWcP7WuP2n5hEo4NxjMFr
         8FuEMbtf6p74DTRjgoEAiqWrpninIOvRETJCxgNY/dOqjg9nTWVhFzB77gP0ZvM8MS6/
         joQi4cgQu73KufHjjyVT335XdAFqybNcqydxjo5bsSwWnk8pfddQc6yVzxl4bFwCORhU
         ZHDxRRBqfwXv7L0hMpBkn8yl5GvxvEjuW/oCfMk7JchceoU2CGeCYa2OFnPeGOxBpyiJ
         sVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616898; x=1779221698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3v4lmT0LIyVJwbA8rQHi/i9UgyWWjq/btGUpulIz2qM=;
        b=Kj6696T7MAsxAGvwIthCgnaT1GBLD6tanjA8Fd+97V3yPiXeTmUazhF8VB0qemAp6c
         OuG/5Z4wF9AGMgZuzoGP5DTClwOy9JYnIAT2Jfr5oGR7LNb4G8XKCs1ObjBA7nu2tzcc
         IL9koMjPq05NfopnVdj9u98t8C2uduJkO/n8NMEadFyFoLDLz4mFRKhH9oRc9hGO+K1r
         OLIkkb5WInBq05WU/IbBF0qrLmptZKdew5R6GAtB5WMrsOS43IvmGbl8YPW4YIOrCi5X
         g6BXdheYzxkHZNl927NG6FUCVQ3F5BfjnMcLjkX6cuEFHaZ1otmBnXeKCQm/9X03ihBM
         LhWA==
X-Gm-Message-State: AOJu0YyhGzia5Kr+v8ijKwVGU190n/rZ2nRlFr+l1S3eP+LgxpGjwRBa
	SIU2i4UNMOmKeEFFkaW820sqWyizLbrPLjSDEacd/VPBxzcGT5sIM+QBo9U1crAf
X-Gm-Gg: Acq92OGYG0/3KUfHCI5zL6gorPjDrLgQTiugct2wNNo7Ru3yYHKr1o+GJg1kNGJshl7
	tXU/vWI0Kqz1eNbDe6eOWriZwaKydpw98onderxGH8pFydWruDgXSnKTESBnY4WUV7v6Ed0gDrL
	ibBqQqUjJGtwTD1BxDPBYMk3Lfffh+4QwiK/KFeS7dV9qzJ386fKTqMu2kpqmuwsUDJfkXsfSIK
	9xa5Q/OUkySsUTsa2rfDVlwlC/7Lgy6gtsm9t5eOQYQLH+2fhB7UTTBkiZLouMe4OGoK14QQ8So
	VHBD6uXyc/GzGax+YNFfiBJWm6vK4zchuIG5Rzc9LSSyObCdEndxTxiW7MFUcIEBCS4JGMv4lJZ
	zNyUBLrqKWK75L6vQmcgbaXtnbSKasDsvNtaJmr8DGJkpQJAa5Noq7NRQWpHeE7crizKShTZSdP
	RViHM31GLj15L7uc6s+wrpDgrZ7JUBhodJgaBPSNq6G6oOZoXVeNfSVnZs
X-Received: by 2002:a05:6808:5142:b0:47c:34fd:d3b3 with SMTP id 5614622812f47-482b2d7f543mr347939b6e.36.1778616897471;
        Tue, 12 May 2026 13:14:57 -0700 (PDT)
Received: from localhost.localdomain ([2600:1014:b0b0:a3c6:a82b:c292:fd90:24d0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76935904sm22800623b6e.11.2026.05.12.13.14.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 May 2026 13:14:57 -0700 (PDT)
From: Liibaan Egal <liibaegal@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH rdma-next 1/2] RDMA/rxe: add local implicit ODP MR support
Date: Tue, 12 May 2026 15:14:52 -0500
Message-Id: <20260512201453.21156-2-liibaegal@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260512201453.21156-1-liibaegal@gmail.com>
References: <20260512201453.21156-1-liibaegal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D883B529035
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20526-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[liibaegal@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

RXE already supports explicit ODP MRs. The implicit registration form
(addr == 0, length == U64_MAX, IB_ACCESS_ON_DEMAND) is recognized but
not implemented: the implicit branch in rxe_odp_mr_init_user() returns
-EINVAL through a placeholder block, and no path creates child umems
for SGE accesses on an implicit MR.

Wire the implicit registration case through ib_umem_odp_alloc_implicit()
and route the local SGE walker through per-chunk child umems.

Registration. rxe_odp_mr_init_implicit() rejects remote access bits
(-EOPNOTSUPP), allocates the empty parent umem via
ib_umem_odp_alloc_implicit(), and initializes mr->implicit_children via
xa_init(). rxe_odp_init_pages() is skipped because there are no pages
to fault at registration time.

Chunking. Implicit MRs split the address space into fixed-size chunks
defined by RXE_ODP_CHILD_SHIFT (21, 2 MiB). Each chunk is backed by at
most one child ib_umem_odp allocated on demand. The chunk size keeps
the child count bounded while limiting the amount of VA covered by
each child; whether the size should be fixed, derived, or configurable
is an open design question.

SGE fault path. rxe_odp_umem_for_iova() returns the parent for
explicit MRs and rxe_odp_get_child() for implicit MRs. The child
lookup is xa_load -> ib_umem_odp_alloc_child -> xa_cmpxchg(GFP_KERNEL);
a racing insertion drops the loser. rxe_odp_chunk_len_at() reports how
many bytes of an access can be served by one umem; for explicit MRs
that is the full request, for implicit it is the bytes remaining in
the current chunk. rxe_odp_mr_copy() loops across chunks, resolving,
locking, copying, and unlocking each child independently. Explicit
MRs run the loop exactly once with identical behavior to the pre-patch
path.

Prefetch. rxe_odp_prefetch_one() uses the same chunk loop. Async
prefetch walks per chunk under short-held mutexes so a long range
does not stall concurrent invalidators.

Atomic, flush, and atomic-write paths reject implicit MRs at the top
of each helper. These walk mr->umem->pfn_list directly which is empty
for an implicit parent; extending them is not in this series.

Lifetime. rxe_mr_cleanup walks mr->implicit_children with xa_for_each
and releases each child via ib_umem_odp_release() before releasing
the parent via ib_umem_release(), so each child's
mmu_interval_notifier tears down while the parent's per_mm is alive.
The xarray is xa_destroy()ed afterwards.

Per-transport ODP caps are unchanged: they describe RC/UD behavior on
explicit ODP MRs. Advertising IB_ODP_SUPPORT_IMPLICIT to userspace is
a separate patch, since whether the existing capability bit is the
right surface for a local-access-only operation matrix is an open
question for review.

Limitations. The xarray grows monotonically per MR: a child is not
reclaimed until MR destroy. Long-lived MRs that touch a sparse address
space accumulate children. A reclaim mechanism is the natural
follow-up.

Tested on Linux 7.1-rc2 (arm64, Soft-RoCE over loopback):
- five-case registration accept/reject matrix passes
- single-chunk 64 KiB RDMA WRITE through an implicit lkey delivers
- two-chunk multi test (two 1 MiB WRITEs from buffers in different
  2 MiB chunks of one implicit MR) delivers
- cross-chunk single-SGE test (128 KiB WRITE spanning a 2 MiB
  boundary) delivers

Benchmark measures registration latency and RSS only; first-touch and
steady-state data path costs are not characterized in this series.

Signed-off-by: Liibaan Egal <liibaegal@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    |  19 ++
 drivers/infiniband/sw/rxe/rxe_odp.c   | 288 +++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.h |  18 ++
 3 files changed, 269 insertions(+), 56 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index c696ff8749..c429bf0e6f 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -6,6 +6,8 @@
 
 #include <linux/libnvdimm.h>
 
+#include <rdma/ib_umem_odp.h>
+
 #include "rxe.h"
 #include "rxe_loc.h"
 
@@ -809,6 +811,23 @@ void rxe_mr_cleanup(struct rxe_pool_elem *elem)
 	struct rxe_mr *mr = container_of(elem, typeof(*mr), elem);
 
 	rxe_put(mr_pd(mr));
+
+	/* Implicit ODP MRs may have created child umems on demand for each
+	 * accessed 2 MiB chunk. Release them before the parent so each
+	 * child's mmu_interval_notifier tears down while the parent's
+	 * per_mm is still alive. The xarray is empty for explicit MRs, so
+	 * walking it is a no-op there.
+	 */
+	if (mr->umem && mr->umem->is_odp &&
+	    to_ib_umem_odp(mr->umem)->is_implicit_odp) {
+		struct ib_umem_odp *child;
+		unsigned long key;
+
+		xa_for_each(&mr->implicit_children, key, child)
+			ib_umem_odp_release(child);
+		xa_destroy(&mr->implicit_children);
+	}
+
 	ib_umem_release(mr->umem);
 
 	if (mr->ibmr.type != IB_MR_TYPE_DMA)
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index ff904d5e54..b90cb8f64f 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -5,6 +5,7 @@
 
 #include <linux/hmm.h>
 #include <linux/libnvdimm.h>
+#include <linux/xarray.h>
 
 #include <rdma/ib_umem_odp.h>
 
@@ -41,9 +42,14 @@ const struct mmu_interval_notifier_ops rxe_mn_ops = {
 #define RXE_PAGEFAULT_DEFAULT 0
 #define RXE_PAGEFAULT_RDONLY BIT(0)
 #define RXE_PAGEFAULT_SNAPSHOT BIT(1)
-static int rxe_odp_do_pagefault_and_lock(struct rxe_mr *mr, u64 user_va, int bcnt, u32 flags)
+
+/* Low-level fault helper. Operates directly on a umem_odp (parent for
+ * explicit MRs, child for implicit). On success the caller holds
+ * umem_odp->umem_mutex via ib_umem_odp_map_dma_and_lock.
+ */
+static int rxe_odp_do_pagefault_and_lock(struct ib_umem_odp *umem_odp,
+					 u64 user_va, int bcnt, u32 flags)
 {
-	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
 	bool fault = !(flags & RXE_PAGEFAULT_SNAPSHOT);
 	u64 access_mask = 0;
 	int np;
@@ -51,11 +57,6 @@ static int rxe_odp_do_pagefault_and_lock(struct rxe_mr *mr, u64 user_va, int bcn
 	if (umem_odp->umem.writable && !(flags & RXE_PAGEFAULT_RDONLY))
 		access_mask |= HMM_PFN_WRITE;
 
-	/*
-	 * ib_umem_odp_map_dma_and_lock() locks umem_mutex on success.
-	 * Callers must release the lock later to let invalidation handler
-	 * do its work again.
-	 */
 	np = ib_umem_odp_map_dma_and_lock(umem_odp, user_va, bcnt,
 					  access_mask, fault);
 	return np;
@@ -66,7 +67,8 @@ static int rxe_odp_init_pages(struct rxe_mr *mr)
 	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
 	int ret;
 
-	ret = rxe_odp_do_pagefault_and_lock(mr, mr->umem->address,
+	/* Explicit MR only: snapshot the page table at registration. */
+	ret = rxe_odp_do_pagefault_and_lock(umem_odp, mr->umem->address,
 					    mr->umem->length,
 					    RXE_PAGEFAULT_SNAPSHOT);
 
@@ -76,6 +78,50 @@ static int rxe_odp_init_pages(struct rxe_mr *mr)
 	return ret >= 0 ? 0 : ret;
 }
 
+/* Remote access on an implicit MR is intentionally out of scope. A
+ * remote rkey on a full-VA-shaped MR would let a peer drive faults
+ * against arbitrary process memory, and that surface needs separate
+ * thinking. Reject up front.
+ */
+#define RXE_REMOTE_ACCESS_MASK (IB_ACCESS_REMOTE_READ |	\
+				IB_ACCESS_REMOTE_WRITE |	\
+				IB_ACCESS_REMOTE_ATOMIC)
+
+static int rxe_odp_mr_init_implicit(struct rxe_dev *rxe, int access_flags,
+				    struct rxe_mr *mr)
+{
+	struct ib_umem_odp *umem_odp;
+
+	if (access_flags & RXE_REMOTE_ACCESS_MASK)
+		return -EOPNOTSUPP;
+
+	umem_odp = ib_umem_odp_alloc_implicit(&rxe->ib_dev, access_flags);
+	if (IS_ERR(umem_odp)) {
+		rxe_dbg_mr(mr, "implicit umem alloc failed err=%d\n",
+			   (int)PTR_ERR(umem_odp));
+		return PTR_ERR(umem_odp);
+	}
+
+	umem_odp->private = mr;
+	mr->umem = &umem_odp->umem;
+	mr->access = access_flags;
+	mr->ibmr.length = U64_MAX;
+	mr->ibmr.iova = 0;
+
+	/* Init the per-MR child xarray here so the cleanup path can
+	 * unconditionally xa_destroy() regardless of MR mode. Explicit MRs
+	 * never touch this xarray, so it stays empty for them. The xarray
+	 * allocator is invoked under GFP_KERNEL on the cmpxchg insertion
+	 * path below.
+	 */
+	xa_init(&mr->implicit_children);
+
+	mr->state = RXE_MR_STATE_VALID;
+	mr->ibmr.type = IB_MR_TYPE_USER;
+
+	return 0;
+}
+
 int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 			 u64 iova, int access_flags, struct rxe_mr *mr)
 {
@@ -93,7 +139,7 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 		if (!(rxe->attr.odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
 			return -EINVAL;
 
-		/* Never reach here, for implicit ODP is not implemented. */
+		return rxe_odp_mr_init_implicit(rxe, access_flags, mr);
 	}
 
 	umem_odp = ib_umem_odp_get(&rxe->ib_dev, start, length, access_flags,
@@ -123,6 +169,73 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 	return err;
 }
 
+/* Look up or create the child umem covering the chunk that contains iova.
+ * Each chunk is RXE_ODP_CHILD_SIZE aligned. A cmpxchg insertion avoids
+ * leaking a child if a concurrent fault wins the race.
+ */
+static struct ib_umem_odp *rxe_odp_get_child(struct rxe_mr *mr, u64 iova)
+{
+	struct ib_umem_odp *parent = to_ib_umem_odp(mr->umem);
+	struct ib_umem_odp *child, *existing;
+	unsigned long aligned_start = iova & ~RXE_ODP_CHILD_MASK;
+	unsigned long key = aligned_start >> RXE_ODP_CHILD_SHIFT;
+
+	child = xa_load(&mr->implicit_children, key);
+	if (child)
+		return child;
+
+	child = ib_umem_odp_alloc_child(parent, aligned_start,
+					RXE_ODP_CHILD_SIZE, &rxe_mn_ops);
+	if (IS_ERR(child))
+		return child;
+	child->private = mr;
+
+	existing = xa_cmpxchg(&mr->implicit_children, key, NULL, child,
+			      GFP_KERNEL);
+	if (xa_is_err(existing)) {
+		ib_umem_odp_release(child);
+		return ERR_PTR(xa_err(existing));
+	}
+	if (existing) {
+		/* Another thread inserted while this allocation was in
+		 * flight. Drop the loser and use the winner.
+		 */
+		ib_umem_odp_release(child);
+		return existing;
+	}
+	return child;
+}
+
+/* Pick the umem_odp to use for an operation on mr at iova. For explicit
+ * MRs that is mr->umem. For implicit MRs it is the chunk's child. The
+ * caller is responsible for clamping the access length to one chunk via
+ * rxe_odp_chunk_len_at(); each call here returns one child.
+ */
+static struct ib_umem_odp *rxe_odp_umem_for_iova(struct rxe_mr *mr, u64 iova)
+{
+	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+
+	if (!umem_odp->is_implicit_odp)
+		return umem_odp;
+	return rxe_odp_get_child(mr, iova);
+}
+
+/* How many bytes of an access starting at iova can be served by a single
+ * umem? For explicit MRs the answer is "the whole request" (bounded by
+ * mr length elsewhere). For implicit MRs it is the bytes remaining in
+ * the current chunk.
+ */
+static int rxe_odp_chunk_len_at(struct rxe_mr *mr, u64 iova, int length)
+{
+	u64 next_boundary;
+
+	if (!to_ib_umem_odp(mr->umem)->is_implicit_odp)
+		return length;
+
+	next_boundary = (iova & ~RXE_ODP_CHILD_MASK) + RXE_ODP_CHILD_SIZE;
+	return min_t(u64, (u64)length, next_boundary - iova);
+}
+
 static inline bool rxe_check_pagefault(struct ib_umem_odp *umem_odp, u64 iova,
 				       int length)
 {
@@ -132,7 +245,6 @@ static inline bool rxe_check_pagefault(struct ib_umem_odp *umem_odp, u64 iova,
 
 	addr = iova & (~(BIT(umem_odp->page_shift) - 1));
 
-	/* Skim through all pages that are to be accessed. */
 	while (addr < iova + length) {
 		idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
 
@@ -156,23 +268,32 @@ static unsigned long rxe_odp_iova_to_page_offset(struct ib_umem_odp *umem_odp, u
 	return iova & (BIT(umem_odp->page_shift) - 1);
 }
 
-static int rxe_odp_map_range_and_lock(struct rxe_mr *mr, u64 iova, int length, u32 flags)
+/* Resolve, lock, and fault one chunk worth of access. On success the
+ * caller holds umem_odp->umem_mutex and gets the chosen umem_odp via
+ * *out_umem_odp. length must already be clamped via rxe_odp_chunk_len_at.
+ */
+static int rxe_odp_map_range_and_lock(struct rxe_mr *mr, u64 iova, int length,
+				      u32 flags,
+				      struct ib_umem_odp **out_umem_odp)
 {
-	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	struct ib_umem_odp *umem_odp;
 	bool need_fault;
 	int err;
 
 	if (unlikely(length < 1))
 		return -EINVAL;
 
+	umem_odp = rxe_odp_umem_for_iova(mr, iova);
+	if (IS_ERR(umem_odp))
+		return PTR_ERR(umem_odp);
+
 	mutex_lock(&umem_odp->umem_mutex);
 
 	need_fault = rxe_check_pagefault(umem_odp, iova, length);
 	if (need_fault) {
 		mutex_unlock(&umem_odp->umem_mutex);
 
-		/* umem_mutex is locked on success. */
-		err = rxe_odp_do_pagefault_and_lock(mr, iova, length,
+		err = rxe_odp_do_pagefault_and_lock(umem_odp, iova, length,
 						    flags);
 		if (err < 0)
 			return err;
@@ -184,13 +305,14 @@ static int rxe_odp_map_range_and_lock(struct rxe_mr *mr, u64 iova, int length, u
 		}
 	}
 
+	*out_umem_odp = umem_odp;
 	return 0;
 }
 
-static int __rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
-			     int length, enum rxe_mr_copy_dir dir)
+static int __rxe_odp_mr_copy_one(struct ib_umem_odp *umem_odp, u64 iova,
+				 void *addr, int length,
+				 enum rxe_mr_copy_dir dir)
 {
-	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
 	struct page *page;
 	int idx, bytes;
 	size_t offset;
@@ -226,8 +348,10 @@ static int __rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		    enum rxe_mr_copy_dir dir)
 {
-	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
 	u32 flags = RXE_PAGEFAULT_DEFAULT;
+	u64 cur_iova = iova;
+	u8 *cur_addr = addr;
+	int remaining = length;
 	int err;
 
 	if (length == 0)
@@ -248,15 +372,43 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		return -EINVAL;
 	}
 
-	err = rxe_odp_map_range_and_lock(mr, iova, length, flags);
-	if (err)
-		return err;
+	/* Walk one chunk at a time. For explicit MRs the chunk-length helper
+	 * returns the full remaining length, so this loop runs exactly once
+	 * and is identical to the pre-implicit behavior.
+	 */
+	while (remaining > 0) {
+		struct ib_umem_odp *umem_odp;
+		int this_len = rxe_odp_chunk_len_at(mr, cur_iova, remaining);
 
-	err =  __rxe_odp_mr_copy(mr, iova, addr, length, dir);
+		err = rxe_odp_map_range_and_lock(mr, cur_iova, this_len, flags,
+						 &umem_odp);
+		if (err)
+			return err;
 
-	mutex_unlock(&umem_odp->umem_mutex);
+		err = __rxe_odp_mr_copy_one(umem_odp, cur_iova, cur_addr,
+					    this_len, dir);
+		mutex_unlock(&umem_odp->umem_mutex);
+		if (err)
+			return err;
 
-	return err;
+		cur_iova += this_len;
+		cur_addr += this_len;
+		remaining -= this_len;
+	}
+
+	return 0;
+}
+
+/* Atomic, flush, and atomic-write paths assume mr->umem itself holds the
+ * pfn_list. That is true for explicit MRs only. The implicit parent has
+ * no pages of its own. Reject those operations on implicit MRs rather
+ * than extend them: remote access on implicit is already out of scope,
+ * so the only way these helpers could be reached is via a local atomic
+ * or flush, which the test matrix does not exercise.
+ */
+static inline bool rxe_odp_mr_is_implicit(struct rxe_mr *mr)
+{
+	return to_ib_umem_odp(mr->umem)->is_implicit_odp;
 }
 
 static enum resp_states rxe_odp_do_atomic_op(struct rxe_mr *mr, u64 iova,
@@ -313,11 +465,16 @@ static enum resp_states rxe_odp_do_atomic_op(struct rxe_mr *mr, u64 iova,
 enum resp_states rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 				   u64 compare, u64 swap_add, u64 *orig_val)
 {
-	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	struct ib_umem_odp *umem_odp;
 	int err;
 
+	if (rxe_odp_mr_is_implicit(mr)) {
+		rxe_dbg_mr(mr, "atomic op not supported on implicit ODP MR\n");
+		return RESPST_ERR_RKEY_VIOLATION;
+	}
+
 	err = rxe_odp_map_range_and_lock(mr, iova, sizeof(char),
-					 RXE_PAGEFAULT_DEFAULT);
+					 RXE_PAGEFAULT_DEFAULT, &umem_odp);
 	if (err < 0)
 		return RESPST_ERR_RKEY_VIOLATION;
 
@@ -331,7 +488,7 @@ enum resp_states rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
 			    unsigned int length)
 {
-	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	struct ib_umem_odp *umem_odp;
 	unsigned int page_offset;
 	unsigned long index;
 	struct page *page;
@@ -339,8 +496,11 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
 	int err;
 	u8 *va;
 
+	if (rxe_odp_mr_is_implicit(mr))
+		return -EOPNOTSUPP;
+
 	err = rxe_odp_map_range_and_lock(mr, iova, length,
-					 RXE_PAGEFAULT_DEFAULT);
+					 RXE_PAGEFAULT_DEFAULT, &umem_odp);
 	if (err)
 		return err;
 
@@ -368,13 +528,16 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
 
 enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 {
-	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
+	struct ib_umem_odp *umem_odp;
 	unsigned int page_offset;
 	unsigned long index;
 	struct page *page;
 	int err;
 	u64 *va;
 
+	if (rxe_odp_mr_is_implicit(mr))
+		return RESPST_ERR_RKEY_VIOLATION;
+
 	/* See IBA oA19-28 */
 	err = mr_check_range(mr, iova, sizeof(value));
 	if (unlikely(err)) {
@@ -383,7 +546,7 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 	}
 
 	err = rxe_odp_map_range_and_lock(mr, iova, sizeof(value),
-					 RXE_PAGEFAULT_DEFAULT);
+					 RXE_PAGEFAULT_DEFAULT, &umem_odp);
 	if (err)
 		return RESPST_ERR_RKEY_VIOLATION;
 
@@ -419,6 +582,38 @@ struct prefetch_mr_work {
 	} frags[];
 };
 
+/* Prefetch one SGE range. For implicit MRs the range may span multiple
+ * chunks; fault each chunk separately and drop the lock between them
+ * so concurrent invalidators are not blocked across the whole range.
+ */
+static int rxe_odp_prefetch_one(struct rxe_mr *mr, u64 io_virt, size_t length,
+				u32 pf_flags)
+{
+	u64 cur = io_virt;
+	size_t remaining = length;
+	int ret;
+
+	while (remaining > 0) {
+		struct ib_umem_odp *umem_odp;
+		int this_len = rxe_odp_chunk_len_at(mr, cur, remaining);
+
+		umem_odp = rxe_odp_umem_for_iova(mr, cur);
+		if (IS_ERR(umem_odp))
+			return PTR_ERR(umem_odp);
+
+		ret = rxe_odp_do_pagefault_and_lock(umem_odp, cur, this_len,
+						    pf_flags);
+		if (ret < 0)
+			return ret;
+
+		mutex_unlock(&umem_odp->umem_mutex);
+
+		cur += this_len;
+		remaining -= this_len;
+	}
+	return 0;
+}
+
 static void rxe_ib_prefetch_mr_work(struct work_struct *w)
 {
 	struct prefetch_mr_work *work =
@@ -426,28 +621,16 @@ static void rxe_ib_prefetch_mr_work(struct work_struct *w)
 	int ret;
 	u32 i;
 
-	/*
-	 * We rely on IB/core that work is executed
-	 * if we have num_sge != 0 only.
-	 */
 	WARN_ON(!work->num_sge);
 	for (i = 0; i < work->num_sge; ++i) {
-		struct ib_umem_odp *umem_odp;
-
-		ret = rxe_odp_do_pagefault_and_lock(work->frags[i].mr,
-						    work->frags[i].io_virt,
-						    work->frags[i].length,
-						    work->pf_flags);
-		if (ret < 0) {
+		ret = rxe_odp_prefetch_one(work->frags[i].mr,
+					   work->frags[i].io_virt,
+					   work->frags[i].length,
+					   work->pf_flags);
+		if (ret < 0)
 			rxe_dbg_mr(work->frags[i].mr,
 				   "failed to prefetch the mr\n");
-			goto deref;
-		}
-
-		umem_odp = to_ib_umem_odp(work->frags[i].mr->umem);
-		mutex_unlock(&umem_odp->umem_mutex);
 
-deref:
 		rxe_put(work->frags[i].mr);
 	}
 
@@ -465,7 +648,6 @@ static int rxe_ib_prefetch_sg_list(struct ib_pd *ibpd,
 
 	for (i = 0; i < num_sge; ++i) {
 		struct rxe_mr *mr;
-		struct ib_umem_odp *umem_odp;
 
 		mr = lookup_mr(pd, IB_ACCESS_LOCAL_WRITE,
 			       sg_list[i].lkey, RXE_LOOKUP_LOCAL);
@@ -483,17 +665,14 @@ static int rxe_ib_prefetch_sg_list(struct ib_pd *ibpd,
 			return -EPERM;
 		}
 
-		ret = rxe_odp_do_pagefault_and_lock(
-			mr, sg_list[i].addr, sg_list[i].length, pf_flags);
+		ret = rxe_odp_prefetch_one(mr, sg_list[i].addr,
+					   sg_list[i].length, pf_flags);
 		if (ret < 0) {
 			rxe_dbg_mr(mr, "failed to prefetch the mr\n");
 			rxe_put(mr);
 			return ret;
 		}
 
-		umem_odp = to_ib_umem_odp(mr->umem);
-		mutex_unlock(&umem_odp->umem_mutex);
-
 		rxe_put(mr);
 	}
 
@@ -517,7 +696,6 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
 	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
 		pf_flags |= RXE_PAGEFAULT_SNAPSHOT;
 
-	/* Synchronous call */
 	if (flags & IB_UVERBS_ADVISE_MR_FLAG_FLUSH)
 		return rxe_ib_prefetch_sg_list(ibpd, advice, pf_flags, sg_list,
 					       num_sge);
@@ -532,7 +710,6 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
 	work->num_sge = num_sge;
 
 	for (i = 0; i < num_sge; ++i) {
-		/* Takes a reference, which will be released in the queued work */
 		mr = lookup_mr(pd, IB_ACCESS_LOCAL_WRITE,
 			       sg_list[i].lkey, RXE_LOOKUP_LOCAL);
 		if (!mr) {
@@ -550,7 +727,6 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
 	return 0;
 
  err:
-	/* rollback reference counts for the invalid request */
 	while (i > 0) {
 		i--;
 		rxe_put(work->frags[i].mr);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index d92f80d16f..a783dee95d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -341,12 +341,30 @@ struct rxe_mr_page {
 	unsigned int		offset; /* offset in system page */
 };
 
+/* For implicit ODP MRs the virtual address space is split into fixed-size
+ * chunks. Each chunk is backed by at most one child umem allocated on
+ * first access. The 2 MiB chunk size keeps the child count bounded while
+ * limiting the amount of VA covered by each child. Whether the chunk
+ * size should be fixed, derived from page_shift, or configurable is an
+ * open design question for review.
+ */
+#define RXE_ODP_CHILD_SHIFT 21
+#define RXE_ODP_CHILD_SIZE  (BIT(RXE_ODP_CHILD_SHIFT))
+#define RXE_ODP_CHILD_MASK  (RXE_ODP_CHILD_SIZE - 1)
+
 struct rxe_mr {
 	struct rxe_pool_elem	elem;
 	struct ib_mr		ibmr;
 
 	struct ib_umem		*umem;
 
+	/* For implicit ODP MRs only: xarray of child umems keyed by
+	 * (aligned_start >> RXE_ODP_CHILD_SHIFT). Each entry covers one
+	 * RXE_ODP_CHILD_SIZE-aligned chunk and is created lazily on first
+	 * access. Unused (xa_empty) for explicit MRs.
+	 */
+	struct xarray		implicit_children;
+
 	u32			lkey;
 	u32			rkey;
 	enum rxe_mr_state	state;
-- 
2.43.0


