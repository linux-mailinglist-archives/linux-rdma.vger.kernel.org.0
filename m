Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD4738CED9
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 22:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhEUUUq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 16:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhEUUUp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 16:20:45 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA3CC0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 13:19:20 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id s24-20020a4aead80000b02901fec6deb28aso4848585ooh.11
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cMvBAEQuMBFtNREjn+AvA1qtn5/GXMySLD9mvP59vxI=;
        b=OcwJc1PXCRguDhUNgFK4ibyI2awq5BKM05h1PwlyfyObscJ5qZiSZG3BlPmdnfiqww
         iU3GsFIMSLWeI+XD4GWg1rGTLG6FOZAq/ukB74ZeAjvbka/z60QtY+StwrKxGtf106dp
         prmcKP4DZP/FygHoA/fhndn6cEoVMoUAfDsFUC851cGIe0sG3u6SyyuYrKq5XbRRvi5g
         aDgF7T7qkJk/cA4BLsJCZWKTTauxTSkimWTeuHZNlxqI2Qv+vJceIfzmbmCJqdy161Qy
         6ydAqKjNw6acEmTYH4PgO4kf+Sy6iKzCBMl1GVupxg+CiwXPn7H0bHHeFn4Vk1HjlsvT
         L9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cMvBAEQuMBFtNREjn+AvA1qtn5/GXMySLD9mvP59vxI=;
        b=sgFlj3Za7LJMAxvQBzxoJ+Dl7h5ThsCl83SkU27+zaPH37C/pXkUeSOsTPubrkbplg
         Pq5LQoBQw7/lugGhyn4suegJKIl6NeqU9GmdGQQExhTwqBhsGRCNEjq+oBKBMnbNQbW8
         73TP0UECiwJVc/rG2Naaw8+p2mXqqQKHA/jH5UvkmJbDQb5HCMIn/axjufryRFBbRqwy
         iz2IuMkrFVxEsL88SFNQ6tsSMGGRPCCcU2Af5qkl26rKpIFZaA1LHXlbEdrDOEbDiebH
         Mr/2apsuCMDo6ff6rHH8aBvCPms0IqiArM7PFhpoN3jmB3vBKph7RXK+aTMICAORH7Lj
         9Q0Q==
X-Gm-Message-State: AOAM532lCDXQggnNkkNHoqiY9W/E1kkjt5wvR9GRUDZl4isAQx00y1tp
        ZeAcVDcL89xEqO6R0lnLlpQbaE73QH2L6g==
X-Google-Smtp-Source: ABdhPJyR6HZ4Qs28GW5G047skyyjTYe6fTOg/UxvvspcU3UpIZJ6M7QAp9CMalKMtaM1JtXLCqFHuQ==
X-Received: by 2002:a4a:8241:: with SMTP id t1mr9462216oog.17.1621628359959;
        Fri, 21 May 2021 13:19:19 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-7300-72eb-72bd-e6db.res6.spectrum.com. [2603:8081:140c:1a00:7300:72eb:72bd:e6db])
        by smtp.gmail.com with ESMTPSA id f9sm1483822otq.27.2021.05.21.13.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:19:19 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v7 09/10] RDMA/rxe: Implement memory access through MWs
Date:   Fri, 21 May 2021 15:18:24 -0500
Message-Id: <20210521201824.659565-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210521201824.659565-1-rpearsonhpe@gmail.com>
References: <20210521201824.659565-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add code to implement memory access through memory windows.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
 drivers/infiniband/sw/rxe/rxe_mw.c    | 23 +++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c  | 55 +++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_verbs.h | 11 ++++++
 4 files changed, 75 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 8a4633aeb2a8..6e4b5e22541e 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -94,6 +94,7 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);
+struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey);
 void rxe_mw_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_net.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 594f8cef0a08..5ba77df7598e 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -312,6 +312,29 @@ int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
 	return ret;
 }
 
+struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
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
+	if (unlikely((rxe_mw_rkey(mw) != rkey) || rxe_mw_pd(mw) != pd ||
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
index 759e9789cd4d..1ea576d42882 100644
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
+		mw = rxe_lookup_mw(qp, access, rkey);
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
index 74fcd871757d..cf8cae64f7df 100644
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
 
+static inline struct rxe_pd *rxe_mw_pd(struct rxe_mw *mw)
+{
+	return to_rpd(mw->ibmw.pd);
+}
+
+static inline u32 rxe_mw_rkey(struct rxe_mw *mw)
+{
+	return mw->ibmw.rkey;
+}
+
 int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name);
 
 void rxe_mc_cleanup(struct rxe_pool_entry *arg);
-- 
2.30.2

