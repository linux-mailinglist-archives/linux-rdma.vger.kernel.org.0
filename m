Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4509368494
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 18:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbhDVQO2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 12:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDVQO2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Apr 2021 12:14:28 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0C9C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 22 Apr 2021 09:13:53 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id y14-20020a056830208eb02902a1c9fa4c64so6162937otq.9
        for <linux-rdma@vger.kernel.org>; Thu, 22 Apr 2021 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UqsVNRlw2jugYsmyMyJ50jHqXC8y9obWc6arRVR7Eps=;
        b=Edw63CaMgPstNnLtrQv7TbQFDBVEl8bdGv21P5lx+WuZJGb01D1QydyePQwWVQOqNm
         tUEJoHRqexGR7jxwLvB+sdq6f1RHtYcsR0p2BA59wylbUM563FUag/IzSR0FLo0ma3W7
         WmowwKuCohEWB0Uwz7obpHID6P2uKs7j819j6zMt7UfanZEL/KBqzVo7eExJK9znUhzr
         QT6Skkp2cNcvtH+QI3+ms7evJiOUVEmWCoBIfkR/j8bq4koTeQFBMZSwWAydiWyRQySJ
         1/2mZmznXrFQsqEc0sy8hKMt4Az5t9bl+GMsbmuODsr8LX7aCbfiFOgVtpiK/FVcmp7z
         n2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UqsVNRlw2jugYsmyMyJ50jHqXC8y9obWc6arRVR7Eps=;
        b=hSe9tam7B1/k1SpsPYVcmYZ/5p0I1RZoKLR9RY+AYilCnjK+xXwm6imSPYziJGHMg6
         HlMlOmAebnSDrOcXaGSzIARXJlQdZiPaUacVB7j2EeGI3awWLlGFSy06sAqedYb5kORb
         zLOukHrN5IsQ3rjPCw14hNfb0gjkStmnhEEWQ8GQAXM1BEdPmXi6IMqiBcxYKuEPar1E
         82cK1yzQIjFwQo28a+eBu8oNaxy5D7fLET4tdaj8YOyIocHw9+bhwvwurM2tMIueKT5I
         Do2zRiviNrgGIhUiiooONvRsw3xCSeVNKGXh5L5eHbinGUK8q3x0oQR6JjNVj3ELo52k
         bk2g==
X-Gm-Message-State: AOAM532udOH5BCtfdKQh3E2N++cKLfaeuqGbKjmJBMvQ7rGwZib+O7Tv
        YV88VbMUeyZVM+Ed8jeO19E=
X-Google-Smtp-Source: ABdhPJyOY6C/bQRQ+OVtfeTzSKiwcn5wK5CkYFkRyH3MRLTai1ZrkiDw8Eyde10CxYu5l4oDy04hfg==
X-Received: by 2002:a05:6830:1204:: with SMTP id r4mr3453007otp.358.1619108032970;
        Thu, 22 Apr 2021 09:13:52 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e336-c4b4-ca5e-5b3f.res6.spectrum.com. [2603:8081:140c:1a00:e336:c4b4:ca5e:5b3f])
        by smtp.gmail.com with ESMTPSA id k24sm633230oop.30.2021.04.22.09.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 09:13:52 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v5 09/10] RDMA/rxe: Implement memory access through MWs
Date:   Thu, 22 Apr 2021 11:13:40 -0500
Message-Id: <20210422161341.41929-10-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210422161341.41929-1-rpearson@hpe.com>
References: <20210422161341.41929-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add code to implement memory access through memory windows.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
v3:
  Adjusted patch for collisions with v3 of "RDMA/rxe: Implement
  invalidate MW operations" patch.
v2:
  Removed a copy of changes in ea4922518940 "Fix missing acks from responder"
  that was submitted separately.
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
 drivers/infiniband/sw/rxe/rxe_mw.c    | 23 +++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c  | 55 +++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_verbs.h | 11 ++++++
 4 files changed, 75 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index bc0e484f8cde..076e1460577f 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -94,6 +94,7 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);
+struct rxe_mw *lookup_mw(struct rxe_qp *qp, int access, u32 rkey);
 void rxe_mw_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_net.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 00490f232fde..6ed36845c693 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -312,6 +312,29 @@ int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
 	return ret;
 }
 
+struct rxe_mw *lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_pd *pd = to_rpd(qp->ibqp.pd);
+	struct rxe_mw *mw;
+	int index = rkey >> 8;
+
+	mw = rxe_pool_get_index(&rxe->mw_pool, index);
+	if (!mw)
+		return NULL;
+
+	if (unlikely((mw_rkey(mw) != rkey) || mw_pd(mw) != pd ||
+		     (mw->ibmw.type == IB_MW_TYPE_2 && mw->qp != qp) ||
+		     (mw->length == 0) ||
+		     (access && !(access & mw->access)) ||
+		     mw->state != RXE_MW_STATE_VALID)) {
+		rxe_drop_ref(mw);
+		return NULL;
+	}
+
+	return mw;
+}
+
 void rxe_mw_cleanup(struct rxe_pool_entry *elem)
 {
 	struct rxe_mw *mw = container_of(elem, typeof(*mw), pelem);
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 759e9789cd4d..9c8cbfbc8820 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -394,6 +394,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 				   struct rxe_pkt_info *pkt)
 {
 	struct rxe_mr *mr = NULL;
+	struct rxe_mw *mw = NULL;
 	u64 va;
 	u32 rkey;
 	u32 resid;
@@ -405,6 +406,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	if (pkt->mask & (RXE_READ_MASK | RXE_WRITE_MASK)) {
 		if (pkt->mask & RXE_RETH_MASK) {
 			qp->resp.va = reth_va(pkt);
+			qp->resp.offset = 0;
 			qp->resp.rkey = reth_rkey(pkt);
 			qp->resp.resid = reth_len(pkt);
 			qp->resp.length = reth_len(pkt);
@@ -413,6 +415,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 						     : IB_ACCESS_REMOTE_WRITE;
 	} else if (pkt->mask & RXE_ATOMIC_MASK) {
 		qp->resp.va = atmeth_va(pkt);
+		qp->resp.offset = 0;
 		qp->resp.rkey = atmeth_rkey(pkt);
 		qp->resp.resid = sizeof(u64);
 		access = IB_ACCESS_REMOTE_ATOMIC;
@@ -432,18 +435,36 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	resid	= qp->resp.resid;
 	pktlen	= payload_size(pkt);
 
-	mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
-	if (!mr) {
-		state = RESPST_ERR_RKEY_VIOLATION;
-		goto err;
-	}
+	if (rkey_is_mw(rkey)) {
+		mw = lookup_mw(qp, access, rkey);
+		if (!mw) {
+			pr_err("%s: no MW matches rkey %#x\n", __func__, rkey);
+			state = RESPST_ERR_RKEY_VIOLATION;
+			goto err;
+		}
 
-	if (unlikely(mr->state == RXE_MR_STATE_FREE)) {
-		state = RESPST_ERR_RKEY_VIOLATION;
-		goto err;
+		mr = mw->mr;
+		if (!mr) {
+			pr_err("%s: MW doesn't have an MR\n", __func__);
+			state = RESPST_ERR_RKEY_VIOLATION;
+			goto err;
+		}
+
+		if (mw->access & IB_ZERO_BASED)
+			qp->resp.offset = mw->addr;
+
+		rxe_drop_ref(mw);
+		rxe_add_ref(mr);
+	} else {
+		mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
+		if (!mr) {
+			pr_err("%s: no MR matches rkey %#x\n", __func__, rkey);
+			state = RESPST_ERR_RKEY_VIOLATION;
+			goto err;
+		}
 	}
 
-	if (mr_check_range(mr, va, resid)) {
+	if (mr_check_range(mr, va + qp->resp.offset, resid)) {
 		state = RESPST_ERR_RKEY_VIOLATION;
 		goto err;
 	}
@@ -477,6 +498,9 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 err:
 	if (mr)
 		rxe_drop_ref(mr);
+	if (mw)
+		rxe_drop_ref(mw);
+
 	return state;
 }
 
@@ -501,8 +525,8 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 	int	err;
 	int data_len = payload_size(pkt);
 
-	err = rxe_mr_copy(qp->resp.mr, qp->resp.va, payload_addr(pkt), data_len,
-			  RXE_TO_MR_OBJ, NULL);
+	err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
+			  payload_addr(pkt), data_len, RXE_TO_MR_OBJ, NULL);
 	if (err) {
 		rc = RESPST_ERR_RKEY_VIOLATION;
 		goto out;
@@ -521,7 +545,6 @@ static DEFINE_SPINLOCK(atomic_ops_lock);
 static enum resp_states process_atomic(struct rxe_qp *qp,
 				       struct rxe_pkt_info *pkt)
 {
-	u64 iova = atmeth_va(pkt);
 	u64 *vaddr;
 	enum resp_states ret;
 	struct rxe_mr *mr = qp->resp.mr;
@@ -531,7 +554,7 @@ static enum resp_states process_atomic(struct rxe_qp *qp,
 		goto out;
 	}
 
-	vaddr = iova_to_vaddr(mr, iova, sizeof(u64));
+	vaddr = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, sizeof(u64));
 
 	/* check vaddr is 8 bytes aligned. */
 	if (!vaddr || (uintptr_t)vaddr & 7) {
@@ -655,8 +678,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		res->type		= RXE_READ_MASK;
 		res->replay		= 0;
 
-		res->read.va		= qp->resp.va;
-		res->read.va_org	= qp->resp.va;
+		res->read.va		= qp->resp.va +
+					  qp->resp.offset;
+		res->read.va_org	= qp->resp.va +
+					  qp->resp.offset;
 
 		res->first_psn		= req_pkt->psn;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 74fcd871757d..f426bf30f86a 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -183,6 +183,7 @@ struct rxe_resp_info {
 
 	/* RDMA read / atomic only */
 	u64			va;
+	u64			offset;
 	struct rxe_mr		*mr;
 	u32			resid;
 	u32			rkey;
@@ -480,6 +481,16 @@ static inline u32 mr_rkey(struct rxe_mr *mr)
 	return mr->ibmr.rkey;
 }
 
+static inline struct rxe_pd *mw_pd(struct rxe_mw *mw)
+{
+	return to_rpd(mw->ibmw.pd);
+}
+
+static inline u32 mw_rkey(struct rxe_mw *mw)
+{
+	return mw->ibmw.rkey;
+}
+
 int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name);
 
 void rxe_mc_cleanup(struct rxe_pool_entry *arg);
-- 
2.27.0

