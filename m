Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B43B358F60
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 23:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhDHVl2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 17:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbhDHVl0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 17:41:26 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59C6C061764
        for <linux-rdma@vger.kernel.org>; Thu,  8 Apr 2021 14:41:10 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id c24-20020a9d6c980000b02902662e210895so3756387otr.9
        for <linux-rdma@vger.kernel.org>; Thu, 08 Apr 2021 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OGRHMNrX4kk94C7FIEMu11y8iyJ0opRhQGpJlsGlVhg=;
        b=KlT5eLfBDUCPBkMg9PcQZLG0ibnI6EwgotKmlQomGs5FrzK8AHnz6LOwQfuAlj1aVr
         Jur2OyvV4UdCiNP50LBFW1EFcsXcwaE5PvuA5Dehy9SXn0sfNknX2B7IGCUqm1shSwLT
         QaUD+41o1pj41/HzyxMlfa5+WqmyQfmhvQiuxI0zpe1uRRqKulDtJoEgpSQA7SDivA7R
         fo2mNM6CIYC71Bkh5kPu/OYNNcMM3rX2PuawTd9Qr9RMcVjc0K08OwKk/9QfA8Weyc3u
         ZJrXYv8G+ml+KbixK+t7ircWzigvadIUog8R0MPft7JeNYUvdbTxGVmKpEfZaPcBED60
         oVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OGRHMNrX4kk94C7FIEMu11y8iyJ0opRhQGpJlsGlVhg=;
        b=Nh1DrkwmiOgbDydWaI0w/dBt7F9NZpj4VEcXDSaZ6P/1Afpp5WSlK/nFPekQzi6GJG
         5E+3VP87FPXN+wWJ7trx8K1gRDFyNgmV1Mx9JYcQUknP7yJEzCU04UOrZ03I6RrKo4Mh
         i2t1jSlz0AH0OSASQVvL1fPNHZ2Dz2DTl4Lt//3WBwKiLanvO7rJVhFFw1wLZ5Wq7plc
         ChCABl8EC0oAeNFh/VRMvA9IwyF4Os4gpFm+r66+I4HCP0AQM9Jm4UieEZXLY1no+0oJ
         mu3Jz/x+xZ2y6bdcQN7hbhUUGpk7vHqvkTqaM13rvUUrw1Zco9Vz96IAR/CuuZfCNnH+
         1nbA==
X-Gm-Message-State: AOAM530qNmjcxtCob0vkZ/eVQvEz2PI0JqTdj3J88SmFCL5AA6gz6pxR
        YsGWNI5xhb2J4Re4TRnrL2T9dHKK0Ag=
X-Google-Smtp-Source: ABdhPJySrs4hHZKm6FgLCBg9JbnCPxLRPtUh80Avi8Bi+aITZxwexrXHAm/WhZetjJhmBGJtrO0cDQ==
X-Received: by 2002:a9d:3437:: with SMTP id v52mr9551875otb.55.1617918070184;
        Thu, 08 Apr 2021 14:41:10 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-9d4e-47e2-9152-a38a.res6.spectrum.com. [2603:8081:140c:1a00:9d4e:47e2:9152:a38a])
        by smtp.gmail.com with ESMTPSA id r15sm148532ote.27.2021.04.08.14.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 14:41:09 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, xyzxyz2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 9/9] RDMA/rxe: Implement memory access through MWs
Date:   Thu,  8 Apr 2021 16:40:41 -0500
Message-Id: <20210408214040.2956-10-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210408214040.2956-1-rpearson@hpe.com>
References: <20210408214040.2956-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add code to implement memory access through memory windows.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
 drivers/infiniband/sw/rxe/rxe_mw.c    | 23 +++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c  | 58 +++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_verbs.h | 11 +++++
 4 files changed, 77 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 7f1117c51e30..99158d11dae7 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -104,6 +104,7 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);
+struct rxe_mw *lookup_mw(struct rxe_qp *qp, int access, u32 rkey);
 void rxe_mw_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_net.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 7b39670f32cd..5c26de154c6e 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -325,6 +325,29 @@ int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
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
index 8834f8a23644..dd0b4cb9dde0 100644
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
 
-	mr = lookup_mr(qp->pd, access, rkey, lookup_remote);
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
+		mr = lookup_mr(qp->pd, access, rkey, lookup_remote);
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
-			  to_mr_obj, NULL);
+	err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
+			  payload_addr(pkt), data_len, to_mr_obj, NULL);
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
 
@@ -835,7 +860,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 
 	if (unlikely(!wqe))
-		return RESPST_CLEANUP;
+		goto done;
 
 	memset(&cqe, 0, sizeof(cqe));
 
@@ -925,6 +950,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	if (qp->resp.state == QP_STATE_ERROR)
 		return RESPST_CHK_RESOURCE;
 
+done:
 	if (!pkt)
 		return RESPST_DONE;
 	else if (qp_type(qp) == IB_QPT_RC)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index b286a14ec282..9f35e2c042d0 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -183,6 +183,7 @@ struct rxe_resp_info {
 
 	/* RDMA read / atomic only */
 	u64			va;
+	u64			offset;
 	struct rxe_mr		*mr;
 	u32			resid;
 	u32			rkey;
@@ -470,6 +471,16 @@ static inline u32 mr_rkey(struct rxe_mr *mr)
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

