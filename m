Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A62B367948
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 07:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhDVF3a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 01:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhDVF33 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Apr 2021 01:29:29 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CB0C06138B
        for <linux-rdma@vger.kernel.org>; Wed, 21 Apr 2021 22:28:55 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso39177347otb.13
        for <linux-rdma@vger.kernel.org>; Wed, 21 Apr 2021 22:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SGI2Qhy8XrG3Orok6L5E1F5D9+ITvQuIsRlnPWij0HM=;
        b=I0SGy61g+OSUTQmejeuoBcu1CvhNex3DYC+wSFf2A6DsX7ndpTevHJeBLTQrppzQV+
         nmsYlT/DohHsdb1BUl9Zz7m8ITiPbcJJhKBHZJA+hlVwFtoO9yWN2ha5+Zts2SPgja2e
         4zWY9GOeEjLyXbIgB3U6nc+zO8rN8FiZJIJ71l9s68L9VqZ12HsKDlGrad1lbhrjyYVO
         u6q+usj+CtVaABuoTs7EmWmDcOIbomBJKGMoDn35cDVgPL3wI9c34gvnHs6TdygUGSY0
         CpkJaudPOENKSvwFPOZpTZ4qPfdKurDY9QI3lstRhd5qD5zf/nhT7dRXojrOOLVuIVQX
         Je7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SGI2Qhy8XrG3Orok6L5E1F5D9+ITvQuIsRlnPWij0HM=;
        b=T/Es5eTXhQ14Sn4oWCYXPk1Q278bQrsUfqe+3QjsFZe8afHnIs364Fw7bWlLee/oKI
         CLv1ZUhT8tou2V93VS82dJT9nZkAcZZHt2ssmHzzYth1IDY9JJH/SeSx32TC6Qjz6a77
         YZnObI8gE+yC4IpIpk/nXKXZCNUczbMrzTe/JHGxRqsBlBdfuyBRY7Hp5s4P96xTh1CI
         dDBHtVbyYMHqTHOHH8Glh+brMFLYToZigg+OkIsRHnALR/ae0B3W31qgSpsiLFMm/3Lt
         c5PnoTOOEKSfktQf3p6+wHMhTD1MCCVfBqogX9A0bMwG2M62zCCO7pk+w4Vp4ZVebr9B
         tiCg==
X-Gm-Message-State: AOAM531GaEPbypqhLJw3FZB18FwxSAi6F9dicx9Hs4TW7MDMhtaexoq3
        DZH9zV67xuGzscpAs3g+EA0=
X-Google-Smtp-Source: ABdhPJxq/YT1buJi5aL7mO6tANChFvSQug2BOeseTzOP/dIviqLmc2P59jJQPFQymX31wQY8T5SzQA==
X-Received: by 2002:a9d:615a:: with SMTP id c26mr1421233otk.54.1619069334680;
        Wed, 21 Apr 2021 22:28:54 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e336-c4b4-ca5e-5b3f.res6.spectrum.com. [2603:8081:140c:1a00:e336:c4b4:ca5e:5b3f])
        by smtp.gmail.com with ESMTPSA id r63sm348906oia.43.2021.04.21.22.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 22:28:54 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v4 08/10] RDMA/rxe: Implement invalidate MW operations
Date:   Thu, 22 Apr 2021 00:28:21 -0500
Message-Id: <20210422052822.36527-9-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210422052822.36527-1-rpearson@hpe.com>
References: <20210422052822.36527-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement invalidate MW and cleaned up invalidate MR operations.

Added code to perform remote invalidate for send with invalidate.
Added code to perform local invalidation.
Deleted some blank lines in rxe_loc.h.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
v3:
  Replaced enums in lower case with upper case and moved to
  rxe_verbs.h which is where enums live.
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |  4 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   | 29 ++--------
 drivers/infiniband/sw/rxe/rxe_mr.c    | 81 ++++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_mw.c    | 67 ++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_req.c   | 24 ++++----
 drivers/infiniband/sw/rxe/rxe_resp.c  | 60 ++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_verbs.h | 33 ++++++++---
 7 files changed, 204 insertions(+), 94 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index bc5488af5f55..207aa7ef52c4 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -346,7 +346,7 @@ static inline enum comp_state do_read(struct rxe_qp *qp,
 
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, payload_addr(pkt),
-			payload_size(pkt), to_mr_obj, NULL);
+			payload_size(pkt), RXE_TO_MR_OBJ, NULL);
 	if (ret)
 		return COMPST_ERROR;
 
@@ -366,7 +366,7 @@ static inline enum comp_state do_atomic(struct rxe_qp *qp,
 
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, &atomic_orig,
-			sizeof(u64), to_mr_obj, NULL);
+			sizeof(u64), RXE_TO_MR_OBJ, NULL);
 	if (ret)
 		return COMPST_ERROR;
 	else
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index e6f574973298..bc0e484f8cde 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -71,46 +71,29 @@ struct rxe_mmap_info *rxe_create_mmap_info(struct rxe_dev *dev, u32 size,
 int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 
 /* rxe_mr.c */
-enum copy_direction {
-	to_mr_obj,
-	from_mr_obj,
-};
-
 u8 rxe_get_next_key(u32 last_key);
 void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr);
-
 int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		     int access, struct ib_udata *udata, struct rxe_mr *mr);
-
 int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr);
-
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
-		enum copy_direction dir, u32 *crcp);
-
+		enum rxe_mr_copy_dir dir, u32 *crcp);
 int copy_data(struct rxe_pd *pd, int access,
 	      struct rxe_dma_info *dma, void *addr, int length,
-	      enum copy_direction dir, u32 *crcp);
-
+	      enum rxe_mr_copy_dir dir, u32 *crcp);
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
-
-enum lookup_type {
-	lookup_local,
-	lookup_remote,
-};
-
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
-			 enum lookup_type type);
-
+			 enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
-
-void rxe_mr_cleanup(struct rxe_pool_entry *arg);
-
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
+int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
+void rxe_mr_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_mw.c */
 int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
+int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);
 void rxe_mw_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_net.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 7f2cfc1ce659..f871879e5f80 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -55,21 +55,6 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	mr->map_shift = ilog2(RXE_BUF_PER_MAP);
 }
 
-void rxe_mr_cleanup(struct rxe_pool_entry *arg)
-{
-	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
-	int i;
-
-	ib_umem_release(mr->umem);
-
-	if (mr->map) {
-		for (i = 0; i < mr->num_map; i++)
-			kfree(mr->map[i]);
-
-		kfree(mr->map);
-	}
-}
-
 static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
 {
 	int i;
@@ -298,7 +283,7 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
  * crc32 if crcp is not zero. caller must hold a reference to mr
  */
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
-		enum copy_direction dir, u32 *crcp)
+		enum rxe_mr_copy_dir dir, u32 *crcp)
 {
 	int			err;
 	int			bytes;
@@ -316,9 +301,9 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 	if (mr->type == RXE_MR_TYPE_DMA) {
 		u8 *src, *dest;
 
-		src = (dir == to_mr_obj) ? addr : ((void *)(uintptr_t)iova);
+		src = (dir == RXE_TO_MR_OBJ) ? addr : ((void *)(uintptr_t)iova);
 
-		dest = (dir == to_mr_obj) ? ((void *)(uintptr_t)iova) : addr;
+		dest = (dir == RXE_TO_MR_OBJ) ? ((void *)(uintptr_t)iova) : addr;
 
 		memcpy(dest, src, length);
 
@@ -346,8 +331,8 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		u8 *src, *dest;
 
 		va	= (u8 *)(uintptr_t)buf->addr + offset;
-		src = (dir == to_mr_obj) ? addr : va;
-		dest = (dir == to_mr_obj) ? va : addr;
+		src = (dir == RXE_TO_MR_OBJ) ? addr : va;
+		dest = (dir == RXE_TO_MR_OBJ) ? va : addr;
 
 		bytes	= buf->size - offset;
 
@@ -392,7 +377,7 @@ int copy_data(
 	struct rxe_dma_info	*dma,
 	void			*addr,
 	int			length,
-	enum copy_direction	dir,
+	enum rxe_mr_copy_dir	dir,
 	u32			*crcp)
 {
 	int			bytes;
@@ -412,7 +397,7 @@ int copy_data(
 	}
 
 	if (sge->length && (offset < sge->length)) {
-		mr = lookup_mr(pd, access, sge->lkey, lookup_local);
+		mr = lookup_mr(pd, access, sge->lkey, RXE_LOOKUP_LOCAL);
 		if (!mr) {
 			err = -EINVAL;
 			goto err1;
@@ -438,7 +423,7 @@ int copy_data(
 
 			if (sge->length) {
 				mr = lookup_mr(pd, access, sge->lkey,
-					       lookup_local);
+					       RXE_LOOKUP_LOCAL);
 				if (!mr) {
 					err = -EINVAL;
 					goto err1;
@@ -520,7 +505,7 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
  * (4) verify that mr state is valid
  */
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
-			 enum lookup_type type)
+			 enum rxe_mr_lookup_type type)
 {
 	struct rxe_mr *mr;
 	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
@@ -530,8 +515,8 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 	if (!mr)
 		return NULL;
 
-	if (unlikely((type == lookup_local && mr_lkey(mr) != key) ||
-		     (type == lookup_remote && mr_rkey(mr) != key) ||
+	if (unlikely((type == RXE_LOOKUP_LOCAL && mr_lkey(mr) != key) ||
+		     (type == RXE_LOOKUP_REMOTE && mr_rkey(mr) != key) ||
 		     mr_pd(mr) != pd || (access && !(access & mr->access)) ||
 		     mr->state != RXE_MR_STATE_VALID)) {
 		rxe_drop_ref(mr);
@@ -540,3 +525,47 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 
 	return mr;
 }
+
+int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_mr *mr;
+	int ret;
+
+	mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
+	if (!mr) {
+		pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (rkey != mr->ibmr.rkey) {
+		pr_err("%s: rkey (%#x) doesn't match mr->ibmr.rkey (%#x)\n",
+			__func__, rkey, mr->ibmr.rkey);
+		ret = -EINVAL;
+		goto err_drop_ref;
+	}
+
+	mr->state = RXE_MR_STATE_FREE;
+	ret = 0;
+
+err_drop_ref:
+	rxe_drop_ref(mr);
+err:
+	return ret;
+}
+
+void rxe_mr_cleanup(struct rxe_pool_entry *arg)
+{
+	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
+	int i;
+
+	ib_umem_release(mr->umem);
+
+	if (mr->map) {
+		for (i = 0; i < mr->num_map; i++)
+			kfree(mr->map[i]);
+
+		kfree(mr->map);
+	}
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index c018e8865876..00490f232fde 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -245,6 +245,73 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	return ret;
 }
 
+static int check_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
+{
+	if (unlikely(mw->state == RXE_MW_STATE_INVALID))
+		return -EINVAL;
+
+	/* o10-37.2.26 */
+	if (unlikely(mw->ibmw.type == IB_MW_TYPE_1))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void do_invalidate_mw(struct rxe_mw *mw)
+{
+	struct rxe_qp *qp;
+	struct rxe_mr *mr;
+
+	/* valid type 2 MW will always have a QP pointer */
+	qp = mw->qp;
+	mw->qp = NULL;
+	rxe_drop_ref(qp);
+
+	/* valid type 2 MW will always have an MR pointer */
+	mr = mw->mr;
+	mw->mr = NULL;
+	atomic_dec(&mr->num_mw);
+	rxe_drop_ref(mr);
+
+	mw->access = 0;
+	mw->addr = 0;
+	mw->length = 0;
+	mw->state = RXE_MW_STATE_FREE;
+}
+
+int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	unsigned long flags;
+	struct rxe_mw *mw;
+	int ret;
+
+	mw = rxe_pool_get_index(&rxe->mw_pool, rkey >> 8);
+	if (!mw) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (rkey != mw->ibmw.rkey) {
+		ret = -EINVAL;
+		goto err_drop_ref;
+	}
+
+	spin_lock_irqsave(&mw->lock, flags);
+
+	ret = check_invalidate_mw(qp, mw);
+	if (ret)
+		goto err_unlock;
+
+	do_invalidate_mw(mw);
+err_unlock:
+	spin_unlock_irqrestore(&mw->lock, flags);
+err_drop_ref:
+	rxe_drop_ref(mw);
+err:
+	return ret;
+}
+
 void rxe_mw_cleanup(struct rxe_pool_entry *elem)
 {
 	struct rxe_mw *mw = container_of(elem, typeof(*mw), pelem);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 243602584a28..61d681cc7bc3 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -464,7 +464,7 @@ static int fill_packet(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		} else {
 			err = copy_data(qp->pd, 0, &wqe->dma,
 					payload_addr(pkt), paylen,
-					from_mr_obj,
+					RXE_FROM_MR_OBJ,
 					&crc);
 			if (err)
 				return err;
@@ -558,25 +558,25 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 static int do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 {
 	u8 opcode = wqe->wr.opcode;
-	struct rxe_dev *rxe;
 	struct rxe_mr *mr;
-	u32 rkey;
 	int ret;
+	u32 rkey;
 
 	switch (opcode) {
 	case IB_WR_LOCAL_INV:
-		rxe = to_rdev(qp->ibqp.device);
 		rkey = wqe->wr.ex.invalidate_rkey;
-		mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
-		if (!mr) {
-			pr_err("No MR for rkey %#x\n", rkey);
+		if (rkey_is_mw(rkey))
+			ret = rxe_invalidate_mw(qp, rkey);
+		else
+			ret = rxe_invalidate_mr(qp, rkey);
+
+		if (ret) {
 			wqe->state = wqe_state_error;
 			wqe->status = IB_WC_LOC_QP_OP_ERR;
-			return -EINVAL;
+			return ret;
 		}
-		mr->state = RXE_MR_STATE_FREE;
-		rxe_drop_ref(mr);
 		break;
+
 	case IB_WR_REG_MR:
 		mr = to_rmr(wqe->wr.wr.reg.mr);
 
@@ -588,14 +588,16 @@ static int do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 		mr->iova = wqe->wr.wr.reg.mr->iova;
 		rxe_drop_ref(mr);
 		break;
+
 	case IB_WR_BIND_MW:
 		ret = rxe_bind_mw(qp, wqe);
 		if (ret) {
 			wqe->state = wqe_state_error;
 			wqe->status = IB_WC_MW_BIND_ERR;
-			return -EINVAL;
+			return ret;
 		}
 		break;
+
 	default:
 		pr_err("Unexpected send wqe opcode %d\n", opcode);
 		wqe->state = wqe_state_error;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 2b220659bddb..759e9789cd4d 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -35,6 +35,7 @@ enum resp_states {
 	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
 	RESPST_ERR_RNR,
 	RESPST_ERR_RKEY_VIOLATION,
+	RESPST_ERR_INVALIDATE_RKEY,
 	RESPST_ERR_LENGTH,
 	RESPST_ERR_CQ_OVERFLOW,
 	RESPST_ERROR,
@@ -68,6 +69,7 @@ static char *resp_state_name[] = {
 	[RESPST_ERR_TOO_MANY_RDMA_ATM_REQ]	= "ERR_TOO_MANY_RDMA_ATM_REQ",
 	[RESPST_ERR_RNR]			= "ERR_RNR",
 	[RESPST_ERR_RKEY_VIOLATION]		= "ERR_RKEY_VIOLATION",
+	[RESPST_ERR_INVALIDATE_RKEY]		= "ERR_INVALIDATE_RKEY_VIOLATION",
 	[RESPST_ERR_LENGTH]			= "ERR_LENGTH",
 	[RESPST_ERR_CQ_OVERFLOW]		= "ERR_CQ_OVERFLOW",
 	[RESPST_ERROR]				= "ERROR",
@@ -430,7 +432,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	resid	= qp->resp.resid;
 	pktlen	= payload_size(pkt);
 
-	mr = lookup_mr(qp->pd, access, rkey, lookup_remote);
+	mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
 	if (!mr) {
 		state = RESPST_ERR_RKEY_VIOLATION;
 		goto err;
@@ -484,7 +486,7 @@ static enum resp_states send_data_in(struct rxe_qp *qp, void *data_addr,
 	int err;
 
 	err = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE, &qp->resp.wqe->dma,
-			data_addr, data_len, to_mr_obj, NULL);
+			data_addr, data_len, RXE_TO_MR_OBJ, NULL);
 	if (unlikely(err))
 		return (err == -ENOSPC) ? RESPST_ERR_LENGTH
 					: RESPST_ERR_MALFORMED_WQE;
@@ -500,7 +502,7 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 	int data_len = payload_size(pkt);
 
 	err = rxe_mr_copy(qp->resp.mr, qp->resp.va, payload_addr(pkt), data_len,
-			  to_mr_obj, NULL);
+			  RXE_TO_MR_OBJ, NULL);
 	if (err) {
 		rc = RESPST_ERR_RKEY_VIOLATION;
 		goto out;
@@ -701,7 +703,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		return RESPST_ERR_RNR;
 
 	err = rxe_mr_copy(res->read.mr, res->read.va, payload_addr(&ack_pkt),
-			  payload, from_mr_obj, &icrc);
+			  payload, RXE_FROM_MR_OBJ, &icrc);
 	if (err)
 		pr_err("Failed copying memory\n");
 
@@ -751,6 +753,14 @@ static void build_rdma_network_hdr(union rdma_network_hdr *hdr,
 		memcpy(&hdr->ibgrh, ipv6_hdr(skb), sizeof(hdr->ibgrh));
 }
 
+static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
+{
+	if (rkey_is_mw(rkey))
+		return rxe_invalidate_mw(qp, rkey);
+	else
+		return rxe_invalidate_mr(qp, rkey);
+}
+
 /* Executes a new request. A retried request never reach that function (send
  * and writes are discarded, and reads and atomics are retried elsewhere.
  */
@@ -790,6 +800,14 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		WARN_ON_ONCE(1);
 	}
 
+	if (pkt->mask & RXE_IETH_MASK) {
+		u32 rkey = ieth_rkey(pkt);
+
+		err = invalidate_rkey(qp, rkey);
+		if (err)
+			return RESPST_ERR_INVALIDATE_RKEY;
+	}
+
 	/* next expected psn, read handles this separately */
 	qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
 	qp->resp.ack_psn = qp->resp.psn;
@@ -822,13 +840,13 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	memset(&cqe, 0, sizeof(cqe));
 
 	if (qp->rcq->is_user) {
-		uwc->status             = qp->resp.status;
-		uwc->qp_num             = qp->ibqp.qp_num;
-		uwc->wr_id              = wqe->wr_id;
+		uwc->status		= qp->resp.status;
+		uwc->qp_num		= qp->ibqp.qp_num;
+		uwc->wr_id		= wqe->wr_id;
 	} else {
-		wc->status              = qp->resp.status;
-		wc->qp                  = &qp->ibqp;
-		wc->wr_id               = wqe->wr_id;
+		wc->status		= qp->resp.status;
+		wc->qp			= &qp->ibqp;
+		wc->wr_id		= wqe->wr_id;
 	}
 
 	if (wc->status == IB_WC_SUCCESS) {
@@ -883,27 +901,14 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 			}
 
 			if (pkt->mask & RXE_IETH_MASK) {
-				struct rxe_mr *rmr;
-
 				wc->wc_flags |= IB_WC_WITH_INVALIDATE;
 				wc->ex.invalidate_rkey = ieth_rkey(pkt);
-
-				rmr = rxe_pool_get_index(&rxe->mr_pool,
-							 wc->ex.invalidate_rkey >> 8);
-				if (unlikely(!rmr)) {
-					pr_err("Bad rkey %#x invalidation\n",
-					       wc->ex.invalidate_rkey);
-					return RESPST_ERROR;
-				}
-				rmr->state = RXE_MR_STATE_FREE;
-				rxe_drop_ref(rmr);
 			}
 
-			wc->qp			= &qp->ibqp;
-
 			if (pkt->mask & RXE_DETH_MASK)
 				wc->src_qp = deth_sqp(pkt);
 
+			wc->qp			= &qp->ibqp;
 			wc->port_num		= qp->attr.port_num;
 		}
 	}
@@ -1314,6 +1319,13 @@ int rxe_responder(void *arg)
 			}
 			break;
 
+		case RESPST_ERR_INVALIDATE_RKEY:
+			/* RC - Class J. */
+			qp->resp.goto_error = 1;
+			qp->resp.status = IB_WC_REM_INV_REQ_ERR;
+			state = RESPST_COMPLETE;
+			break;
+
 		case RESPST_ERR_LENGTH:
 			if (qp_type(qp) == IB_QPT_RC) {
 				/* Class C */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 7da47b8c707b..74fcd871757d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -275,6 +275,16 @@ enum rxe_mr_type {
 	RXE_MR_TYPE_MR,
 };
 
+enum rxe_mr_copy_dir {
+	RXE_TO_MR_OBJ,
+	RXE_FROM_MR_OBJ,
+};
+
+enum rxe_mr_lookup_type {
+	RXE_LOOKUP_LOCAL,
+	RXE_LOOKUP_REMOTE,
+};
+
 #define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(struct rxe_phys_buf))
 
 struct rxe_phys_buf {
@@ -286,6 +296,13 @@ struct rxe_map {
 	struct rxe_phys_buf	buf[RXE_BUF_PER_MAP];
 };
 
+static inline int rkey_is_mw(u32 rkey)
+{
+	u32 index = rkey >> 8;
+
+	return (index >= RXE_MIN_MW_INDEX) && (index <= RXE_MAX_MW_INDEX);
+}
+
 struct rxe_mr {
 	struct rxe_pool_entry	pelem;
 	struct ib_mr		ibmr;
@@ -311,23 +328,23 @@ struct rxe_mr {
 	u32			max_buf;
 	u32			num_map;
 
-	struct rxe_map		**map;
-
 	atomic_t		num_mw;
+
+	struct rxe_map		**map;
 };
 
 enum rxe_mw_state {
-	RXE_MW_STATE_INVALID = RXE_MR_STATE_INVALID,
-	RXE_MW_STATE_FREE = RXE_MR_STATE_FREE,
-	RXE_MW_STATE_VALID = RXE_MR_STATE_VALID,
+	RXE_MW_STATE_INVALID	= RXE_MR_STATE_INVALID,
+	RXE_MW_STATE_FREE	= RXE_MR_STATE_FREE,
+	RXE_MW_STATE_VALID	= RXE_MR_STATE_VALID,
 };
 
 struct rxe_mw {
-	struct			ib_mw ibmw;
-	struct			rxe_pool_entry pelem;
+	struct ib_mw		ibmw;
+	struct rxe_pool_entry	pelem;
 	spinlock_t		lock;
 	enum rxe_mw_state	state;
-	struct rxe_qp		*qp;	/* Type 2 only */
+	struct rxe_qp		*qp; /* Type 2 only */
 	struct rxe_mr		*mr;
 	int			access;
 	u64			addr;
-- 
2.27.0

