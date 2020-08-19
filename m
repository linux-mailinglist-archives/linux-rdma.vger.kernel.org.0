Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180E32493AA
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 05:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgHSDu2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 23:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgHSDu1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 23:50:27 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258FBC061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:50:27 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id n128so16035784oif.0
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1LhZK0VDQcZkHOrD/SJMf+vOdRSfCcqDu8uv33tNunU=;
        b=DXX5ZQ171sBcbU66fZiMpP3vjcdITCTAwUfc4y3EJnEFgJDnK7IpCLQYVXUnBKOVQu
         llDL9AF27RsQ/VwX9BeU7KSEDZEq/tx5MMs2hHpy6OEN7fZmWiyxgYD76ueJsikixvRT
         VvS5YBXVhdIeAcjd16Tf24hFKAl4BbCJlQJpOHM4IIdAAy0ytx+NFLTsE0RoZ5tEsEhZ
         TsEdzON4DCOT2VdSvHucYRXDOCY95HGhFNtB0pvv8mgQ1nJ3ZpQfboAwRuGDREUcl0W6
         g0sqAcHiYTdiy8D2rUpT5/fuel8Pg3G/etb73ZLkfjD50mVgkHUOp+RtjkHeWYJ7N7RJ
         Sysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LhZK0VDQcZkHOrD/SJMf+vOdRSfCcqDu8uv33tNunU=;
        b=dOFsGeeSG5aXSQ1fFULzIMa3pkBU+Fj7vAY0yJXL+EswZbVAKDatQd8T2lDeyPwFg9
         A+fT3TsIzXwV8L+8Bw3w0k2UnWlKFs4OQDYu6SatIp7xClUzoLsEhe2FJ52FoAaxPv+2
         a0MrlWdrfGqY5Gkf2eSJMI+2uDumpFkKnjrz5zdfpLnmAgVdJ92bWgLfV7COcUUUrWos
         6YZUkysSi298MaKWID+Tg3awfn/PjykXoeJ3An8hTxhjqJ/2S/Lqn+XYe7V0zwbXa5O7
         K32Y4CobJR7eU1lRRwU4A//sMPIqXOEIqI1q+MUdlutazqQQ4yg9qGIz4ruaXuDGx7x7
         YfaA==
X-Gm-Message-State: AOAM533KMfeJDYcdJDl1+XLySuBWG7sOmIUZ1Eftc63KYbIV2XkEPswt
        ltt0THq4reYfu6bLw3gS86U=
X-Google-Smtp-Source: ABdhPJxvsG0kXZLtqoDJT1ak6c2vNmbPxKmckELwt2PygFM3kNzwaqhpFEm5ObF6LB1K9BTWVFm6Bw==
X-Received: by 2002:aca:42c1:: with SMTP id p184mr2162124oia.3.1597809026310;
        Tue, 18 Aug 2020 20:50:26 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:2731:80e6:14c6:1150])
        by smtp.gmail.com with ESMTPSA id s18sm4227684ooq.24.2020.08.18.20.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 20:50:26 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH] rdma-core/providers/rxe: Implement MW commands
Date:   Tue, 18 Aug 2020 22:49:52 -0500
Message-Id: <20200819034952.9036-2-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819034952.9036-1-rpearson@hpe.com>
References: <20200819034952.9036-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implemented
	ibv_alloc_mw
	ibv_dealloc_mw
	ibv_bind_mw
	post bind mw operations
	post invalidate rkey commands
	access MW and MR rkeys for RDMA write, read, and atomic

Depends on matching kernel patch set

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 kernel-headers/rdma/rdma_user_rxe.h |  38 +++-
 providers/rxe/CMakeLists.txt        |   2 +
 providers/rxe/rxe-abi.h             |   4 +
 providers/rxe/rxe.c                 | 293 +++++--------------------
 providers/rxe/rxe.h                 |  44 ++++
 providers/rxe/rxe_mw.c              | 149 +++++++++++++
 providers/rxe/rxe_sq.c              | 319 ++++++++++++++++++++++++++++
 7 files changed, 613 insertions(+), 236 deletions(-)
 create mode 100644 providers/rxe/rxe_mw.c
 create mode 100644 providers/rxe/rxe_sq.c

diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
index aae2e696..05fe8bef 100644
--- a/kernel-headers/rdma/rdma_user_rxe.h
+++ b/kernel-headers/rdma/rdma_user_rxe.h
@@ -93,7 +93,33 @@ struct rxe_send_wr {
 			__u32	remote_qkey;
 			__u16	pkey_index;
 		} ud;
-		/* reg is only used by the kernel and is not part of the uapi */
+		struct {
+			__aligned_u64	addr;
+			__aligned_u64	length;
+			__u32	mr_index;
+			__u32   pad1;
+			__u32	mw_index;
+			__u32   pad2;
+			__u32	rkey;
+			__u32	access;
+			__u32	flags;
+		} umw;
+		/* below are only used by the kernel */
+		struct {
+			__aligned_u64	addr;
+			__aligned_u64	length;
+			union {
+				struct ib_mr	*ibmr;
+				__aligned_u64   reserved1;
+			};
+			union {
+				struct ib_mw	*ibmw;
+				__aligned_u64   reserved2;
+			};
+			__u32	rkey;
+			__u32	access;
+			__u32	flags;
+		} kmw;
 		struct {
 			union {
 				struct ib_mr *mr;
@@ -175,4 +201,14 @@ struct rxe_modify_srq_cmd {
 	__aligned_u64 mmap_info_addr;
 };
 
+struct rxe_reg_mr_resp {
+	__u32 index;
+	__u32 reserved;
+};
+
+struct rxe_alloc_mw_resp {
+	__u32 index;
+	__u32 reserved;
+};
+
 #endif /* RDMA_USER_RXE_H */
diff --git a/providers/rxe/CMakeLists.txt b/providers/rxe/CMakeLists.txt
index d8f32651..ec4f005d 100644
--- a/providers/rxe/CMakeLists.txt
+++ b/providers/rxe/CMakeLists.txt
@@ -1,3 +1,5 @@
 rdma_provider(rxe
   rxe.c
+  rxe_sq.c
+  rxe_mw.c
   )
diff --git a/providers/rxe/rxe-abi.h b/providers/rxe/rxe-abi.h
index b4680a24..2fc09483 100644
--- a/providers/rxe/rxe-abi.h
+++ b/providers/rxe/rxe-abi.h
@@ -49,5 +49,9 @@ DECLARE_DRV_CMD(urxe_modify_srq, IB_USER_VERBS_CMD_MODIFY_SRQ,
 		rxe_modify_srq_cmd, empty);
 DECLARE_DRV_CMD(urxe_resize_cq, IB_USER_VERBS_CMD_RESIZE_CQ,
 		empty, rxe_resize_cq_resp);
+DECLARE_DRV_CMD(urxe_reg_mr, IB_USER_VERBS_CMD_REG_MR,
+		empty, rxe_reg_mr_resp);
+DECLARE_DRV_CMD(urxe_alloc_mw, IB_USER_VERBS_CMD_ALLOC_MW,
+		empty, rxe_alloc_mw_resp);
 
 #endif /* RXE_ABI_H */
diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 3af58bfb..ff4285f2 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -69,11 +69,11 @@ static int rxe_query_device(struct ibv_context *context,
 {
 	struct ibv_query_device cmd;
 	uint64_t raw_fw_ver;
-	unsigned major, minor, sub_minor;
+	unsigned int major, minor, sub_minor;
 	int ret;
 
 	ret = ibv_cmd_query_device(context, attr, &raw_fw_ver,
-				   &cmd, sizeof cmd);
+				   &cmd, sizeof(cmd));
 	if (ret)
 		return ret;
 
@@ -81,7 +81,7 @@ static int rxe_query_device(struct ibv_context *context,
 	minor = (raw_fw_ver >> 16) & 0xffff;
 	sub_minor = raw_fw_ver & 0xffff;
 
-	snprintf(attr->fw_ver, sizeof attr->fw_ver,
+	snprintf(attr->fw_ver, sizeof(attr->fw_ver),
 		 "%d.%d.%d", major, minor, sub_minor);
 
 	return 0;
@@ -92,7 +92,7 @@ static int rxe_query_port(struct ibv_context *context, uint8_t port,
 {
 	struct ibv_query_port cmd;
 
-	return ibv_cmd_query_port(context, port, attr, &cmd, sizeof cmd);
+	return ibv_cmd_query_port(context, port, attr, &cmd, sizeof(cmd));
 }
 
 static struct ibv_pd *rxe_alloc_pd(struct ibv_context *context)
@@ -101,11 +101,12 @@ static struct ibv_pd *rxe_alloc_pd(struct ibv_context *context)
 	struct ib_uverbs_alloc_pd_resp resp;
 	struct ibv_pd *pd;
 
-	pd = malloc(sizeof *pd);
+	pd = malloc(sizeof(*pd));
 	if (!pd)
 		return NULL;
 
-	if (ibv_cmd_alloc_pd(context, pd, &cmd, sizeof cmd, &resp, sizeof resp)) {
+	if (ibv_cmd_alloc_pd(context, pd, &cmd, sizeof(cmd), &resp,
+				sizeof(resp))) {
 		free(pd);
 		return NULL;
 	}
@@ -127,34 +128,38 @@ static int rxe_dealloc_pd(struct ibv_pd *pd)
 static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 				 uint64_t hca_va, int access)
 {
-	struct verbs_mr *vmr;
-	struct ibv_reg_mr cmd;
-	struct ib_uverbs_reg_mr_resp resp;
+	struct rxe_mr *mr;
+	struct ibv_reg_mr cmd = {};
+	struct urxe_reg_mr_resp resp = {};
 	int ret;
 
-	vmr = malloc(sizeof(*vmr));
-	if (!vmr)
+	mr = calloc(1, sizeof(*mr));
+	if (!mr)
 		return NULL;
 
-	ret = ibv_cmd_reg_mr(pd, addr, length, hca_va, access, vmr, &cmd,
-			     sizeof(cmd), &resp, sizeof(resp));
+	ret = ibv_cmd_reg_mr(pd, addr, length, hca_va, access,
+			     &mr->verbs_mr, &cmd, sizeof(cmd),
+			     &resp.ibv_resp, sizeof(resp));
 	if (ret) {
-		free(vmr);
+		free(mr);
 		return NULL;
 	}
 
-	return &vmr->ibv_mr;
+	mr->index = resp.index;
+
+	return &mr->verbs_mr.ibv_mr;
 }
 
 static int rxe_dereg_mr(struct verbs_mr *vmr)
 {
 	int ret;
+	struct rxe_mr *mr = to_rmr(&vmr->ibv_mr);
 
-	ret = ibv_cmd_dereg_mr(vmr);
+	ret = ibv_cmd_dereg_mr(&mr->verbs_mr);
 	if (ret)
 		return ret;
 
-	free(vmr);
+	free(mr);
 	return 0;
 }
 
@@ -166,14 +171,13 @@ static struct ibv_cq *rxe_create_cq(struct ibv_context *context, int cqe,
 	struct urxe_create_cq_resp resp;
 	int ret;
 
-	cq = malloc(sizeof *cq);
-	if (!cq) {
+	cq = malloc(sizeof(*cq));
+	if (!cq)
 		return NULL;
-	}
 
 	ret = ibv_cmd_create_cq(context, cqe, channel, comp_vector,
 				&cq->ibv_cq, NULL, 0,
-				&resp.ibv_resp, sizeof resp);
+				&resp.ibv_resp, sizeof(resp));
 	if (ret) {
 		free(cq);
 		return NULL;
@@ -202,8 +206,8 @@ static int rxe_resize_cq(struct ibv_cq *ibcq, int cqe)
 
 	pthread_spin_lock(&cq->lock);
 
-	ret = ibv_cmd_resize_cq(ibcq, cqe, &cmd, sizeof cmd,
-				&resp.ibv_resp, sizeof resp);
+	ret = ibv_cmd_resize_cq(ibcq, cqe, &cmd, sizeof(cmd),
+				&resp.ibv_resp, sizeof(resp));
 	if (ret) {
 		pthread_spin_unlock(&cq->lock);
 		return ret;
@@ -277,13 +281,12 @@ static struct ibv_srq *rxe_create_srq(struct ibv_pd *pd,
 	struct urxe_create_srq_resp resp;
 	int ret;
 
-	srq = malloc(sizeof *srq);
-	if (srq == NULL) {
+	srq = malloc(sizeof(*srq));
+	if (srq == NULL)
 		return NULL;
-	}
 
-	ret = ibv_cmd_create_srq(pd, &srq->ibv_srq, attr, &cmd, sizeof cmd,
-				 &resp.ibv_resp, sizeof resp);
+	ret = ibv_cmd_create_srq(pd, &srq->ibv_srq, attr, &cmd, sizeof(cmd),
+				 &resp.ibv_resp, sizeof(resp));
 	if (ret) {
 		free(srq);
 		return NULL;
@@ -298,6 +301,7 @@ static struct ibv_srq *rxe_create_srq(struct ibv_pd *pd,
 		return NULL;
 	}
 
+	srq->srq_num = resp.srq_num;
 	srq->mmap_info = resp.mi;
 	srq->rq.max_sge = attr->attr.max_sge;
 	pthread_spin_init(&srq->rq.lock, PTHREAD_PROCESS_PRIVATE);
@@ -305,6 +309,15 @@ static struct ibv_srq *rxe_create_srq(struct ibv_pd *pd,
 	return &srq->ibv_srq;
 }
 
+static int rxe_get_srq_num(struct ibv_srq *ibsrq, uint32_t *srq_num)
+{
+	struct rxe_srq *srq = to_rsrq(ibsrq);
+
+	*srq_num = srq->srq_num;
+
+	return 0;
+}
+
 static int rxe_modify_srq(struct ibv_srq *ibsrq,
 		   struct ibv_srq_attr *attr, int attr_mask)
 {
@@ -319,9 +332,9 @@ static int rxe_modify_srq(struct ibv_srq *ibsrq,
 	if (attr_mask & IBV_SRQ_MAX_WR)
 		pthread_spin_lock(&srq->rq.lock);
 
-	cmd.mmap_info_addr = (__u64)(uintptr_t) & mi;
+	cmd.mmap_info_addr = (__u64)(uintptr_t) &mi;
 	rc = ibv_cmd_modify_srq(ibsrq, attr, attr_mask,
-				&cmd.ibv_cmd, sizeof cmd);
+				&cmd.ibv_cmd, sizeof(cmd));
 	if (rc)
 		goto out;
 
@@ -351,7 +364,7 @@ static int rxe_query_srq(struct ibv_srq *srq, struct ibv_srq_attr *attr)
 {
 	struct ibv_query_srq cmd;
 
-	return ibv_cmd_query_srq(srq, attr, &cmd, sizeof cmd);
+	return ibv_cmd_query_srq(srq, attr, &cmd, sizeof(cmd));
 }
 
 static int rxe_destroy_srq(struct ibv_srq *ibvsrq)
@@ -396,9 +409,8 @@ static int rxe_post_one_recv(struct rxe_wq *rq, struct ibv_recv_wr *recv_wr)
 	memcpy(wqe->dma.sge, recv_wr->sg_list,
 	       wqe->num_sge*sizeof(*wqe->dma.sge));
 
-	for (i = 0; i < wqe->num_sge; i++) {
+	for (i = 0; i < wqe->num_sge; i++)
 		length += wqe->dma.sge[i].length;
-	}
 
 	wqe->dma.length = length;
 	wqe->dma.resid = length;
@@ -444,13 +456,12 @@ static struct ibv_qp *rxe_create_qp(struct ibv_pd *pd,
 	struct rxe_qp *qp;
 	int ret;
 
-	qp = malloc(sizeof *qp);
-	if (!qp) {
+	qp = malloc(sizeof(*qp));
+	if (!qp)
 		return NULL;
-	}
 
-	ret = ibv_cmd_create_qp(pd, &qp->ibv_qp, attr, &cmd, sizeof cmd,
-				&resp.ibv_resp, sizeof resp);
+	ret = ibv_cmd_create_qp(pd, &qp->ibv_qp, attr, &cmd, sizeof(cmd),
+				&resp.ibv_resp, sizeof(resp));
 	if (ret) {
 		free(qp);
 		return NULL;
@@ -501,7 +512,7 @@ static int rxe_query_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr,
 	struct ibv_query_qp cmd;
 
 	return ibv_cmd_query_qp(qp, attr, attr_mask, init_attr,
-				&cmd, sizeof cmd);
+				&cmd, sizeof(cmd));
 }
 
 static int rxe_modify_qp(struct ibv_qp *ibvqp,
@@ -510,7 +521,7 @@ static int rxe_modify_qp(struct ibv_qp *ibvqp,
 {
 	struct ibv_modify_qp cmd = {};
 
-	return ibv_cmd_modify_qp(ibvqp, attr, attr_mask, &cmd, sizeof cmd);
+	return ibv_cmd_modify_qp(ibvqp, attr, attr_mask, &cmd, sizeof(cmd));
 }
 
 static int rxe_destroy_qp(struct ibv_qp *ibv_qp)
@@ -531,199 +542,6 @@ static int rxe_destroy_qp(struct ibv_qp *ibv_qp)
 	return ret;
 }
 
-/* basic sanity checks for send work request */
-static int validate_send_wr(struct rxe_wq *sq, struct ibv_send_wr *ibwr,
-			    unsigned int length)
-{
-	enum ibv_wr_opcode opcode = ibwr->opcode;
-
-	if (ibwr->num_sge > sq->max_sge)
-		return -EINVAL;
-
-	if ((opcode == IBV_WR_ATOMIC_CMP_AND_SWP)
-	    || (opcode == IBV_WR_ATOMIC_FETCH_AND_ADD))
-		if (length < 8 || ibwr->wr.atomic.remote_addr & 0x7)
-			return -EINVAL;
-
-	if ((ibwr->send_flags & IBV_SEND_INLINE) && (length > sq->max_inline))
-		return -EINVAL;
-
-	return 0;
-}
-
-static void convert_send_wr(struct rxe_send_wr *kwr, struct ibv_send_wr *uwr)
-{
-	memset(kwr, 0, sizeof(*kwr));
-
-	kwr->wr_id		= uwr->wr_id;
-	kwr->num_sge		= uwr->num_sge;
-	kwr->opcode		= uwr->opcode;
-	kwr->send_flags		= uwr->send_flags;
-	kwr->ex.imm_data	= uwr->imm_data;
-
-	switch(uwr->opcode) {
-	case IBV_WR_RDMA_WRITE:
-	case IBV_WR_RDMA_WRITE_WITH_IMM:
-	case IBV_WR_RDMA_READ:
-		kwr->wr.rdma.remote_addr	= uwr->wr.rdma.remote_addr;
-		kwr->wr.rdma.rkey		= uwr->wr.rdma.rkey;
-		break;
-
-	case IBV_WR_SEND:
-	case IBV_WR_SEND_WITH_IMM:
-		kwr->wr.ud.remote_qpn		= uwr->wr.ud.remote_qpn;
-		kwr->wr.ud.remote_qkey		= uwr->wr.ud.remote_qkey;
-		break;
-
-	case IBV_WR_ATOMIC_CMP_AND_SWP:
-	case IBV_WR_ATOMIC_FETCH_AND_ADD:
-		kwr->wr.atomic.remote_addr	= uwr->wr.atomic.remote_addr;
-		kwr->wr.atomic.compare_add	= uwr->wr.atomic.compare_add;
-		kwr->wr.atomic.swap		= uwr->wr.atomic.swap;
-		kwr->wr.atomic.rkey		= uwr->wr.atomic.rkey;
-		break;
-
-	case IBV_WR_LOCAL_INV:
-	case IBV_WR_BIND_MW:
-	case IBV_WR_SEND_WITH_INV:
-	case IBV_WR_TSO:
-	case IBV_WR_DRIVER1:
-		break;
-	}
-}
-
-static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
-		  struct ibv_send_wr *ibwr, unsigned int length,
-		  struct rxe_send_wqe *wqe)
-{
-	int num_sge = ibwr->num_sge;
-	int i;
-	unsigned int opcode = ibwr->opcode;
-
-	convert_send_wr(&wqe->wr, ibwr);
-
-	if (qp_type(qp) == IBV_QPT_UD)
-		memcpy(&wqe->av, &to_rah(ibwr->wr.ud.ah)->av,
-		       sizeof(struct rxe_av));
-
-	if (ibwr->send_flags & IBV_SEND_INLINE) {
-		uint8_t *inline_data = wqe->dma.inline_data;
-
-		for (i = 0; i < num_sge; i++) {
-			memcpy(inline_data,
-			       (uint8_t *)(long)ibwr->sg_list[i].addr,
-			       ibwr->sg_list[i].length);
-			inline_data += ibwr->sg_list[i].length;
-		}
-	} else
-		memcpy(wqe->dma.sge, ibwr->sg_list,
-		       num_sge*sizeof(struct ibv_sge));
-
-	if ((opcode == IBV_WR_ATOMIC_CMP_AND_SWP)
-	    || (opcode == IBV_WR_ATOMIC_FETCH_AND_ADD))
-		wqe->iova	= ibwr->wr.atomic.remote_addr;
-	else
-		wqe->iova	= ibwr->wr.rdma.remote_addr;
-	wqe->dma.length		= length;
-	wqe->dma.resid		= length;
-	wqe->dma.num_sge	= num_sge;
-	wqe->dma.cur_sge	= 0;
-	wqe->dma.sge_offset	= 0;
-	wqe->state		= 0;
-	wqe->ssn		= qp->ssn++;
-
-	return 0;
-}
-
-static int post_one_send(struct rxe_qp *qp, struct rxe_wq *sq,
-			 struct ibv_send_wr *ibwr)
-{
-	int err;
-	struct rxe_send_wqe *wqe;
-	unsigned int length = 0;
-	int i;
-
-	for (i = 0; i < ibwr->num_sge; i++)
-		length += ibwr->sg_list[i].length;
-
-	err = validate_send_wr(sq, ibwr, length);
-	if (err) {
-		printf("validate send failed\n");
-		return err;
-	}
-
-	wqe = (struct rxe_send_wqe *)producer_addr(sq->queue);
-
-	err = init_send_wqe(qp, sq, ibwr, length, wqe);
-	if (err)
-		return err;
-
-	if (queue_full(sq->queue))
-		return -ENOMEM;
-
-	advance_producer(sq->queue);
-
-	return 0;
-}
-
-/* send a null post send as a doorbell */
-static int post_send_db(struct ibv_qp *ibqp)
-{
-	struct ibv_post_send cmd;
-	struct ib_uverbs_post_send_resp resp;
-
-	cmd.hdr.command	= IB_USER_VERBS_CMD_POST_SEND;
-	cmd.hdr.in_words = sizeof(cmd) / 4;
-	cmd.hdr.out_words = sizeof(resp) / 4;
-	cmd.response	= (uintptr_t)&resp;
-	cmd.qp_handle	= ibqp->handle;
-	cmd.wr_count	= 0;
-	cmd.sge_count	= 0;
-	cmd.wqe_size	= sizeof(struct ibv_send_wr);
-
-	if (write(ibqp->context->cmd_fd, &cmd, sizeof(cmd)) != sizeof(cmd))
-		return errno;
-
-	return 0;
-}
-
-/* this API does not make a distinction between
-   restartable and non-restartable errors */
-static int rxe_post_send(struct ibv_qp *ibqp,
-			 struct ibv_send_wr *wr_list,
-			 struct ibv_send_wr **bad_wr)
-{
-	int rc = 0;
-	int err;
-	struct rxe_qp *qp = to_rqp(ibqp);
-	struct rxe_wq *sq = &qp->sq;
-
-	if (!bad_wr)
-		return EINVAL;
-
-	*bad_wr = NULL;
-
-	if (!sq || !wr_list || !sq->queue)
-	 	return EINVAL;
-
-	pthread_spin_lock(&sq->lock);
-
-	while (wr_list) {
-		rc = post_one_send(qp, sq, wr_list);
-		if (rc) {
-			*bad_wr = wr_list;
-			break;
-		}
-
-		wr_list = wr_list->next;
-	}
-
-	pthread_spin_unlock(&sq->lock);
-
-	err =  post_send_db(ibqp);
-	return err ? err : rc;
-}
-
 static int rxe_post_recv(struct ibv_qp *ibqp,
 			 struct ibv_recv_wr *recv_wr,
 			 struct ibv_recv_wr **bad_wr)
@@ -792,7 +610,7 @@ static struct ibv_ah *rxe_create_ah(struct ibv_pd *pd, struct ibv_ah_attr *attr)
 		return NULL;
 	}
 
-	ah = malloc(sizeof *ah);
+	ah = malloc(sizeof(*ah));
 	if (ah == NULL)
 		return NULL;
 
@@ -860,6 +678,10 @@ static const struct verbs_context_ops rxe_ctx_ops = {
 	.attach_mcast = ibv_cmd_attach_mcast,
 	.detach_mcast = ibv_cmd_detach_mcast,
 	.free_context = rxe_free_context,
+	.alloc_mw = rxe_alloc_mw,
+	.bind_mw = rxe_bind_mw,
+	.dealloc_mw = rxe_dealloc_mw,
+	.get_srq_num = rxe_get_srq_num,
 };
 
 static struct verbs_context *rxe_alloc_context(struct ibv_device *ibdev,
@@ -876,7 +698,7 @@ static struct verbs_context *rxe_alloc_context(struct ibv_device *ibdev,
 		return NULL;
 
 	if (ibv_cmd_get_context(&context->ibv_ctx, &cmd,
-				sizeof cmd, &resp, sizeof resp))
+				sizeof(cmd), &resp, sizeof(resp)))
 		goto out;
 
 	verbs_set_ops(&context->ibv_ctx, &rxe_ctx_ops);
@@ -907,6 +729,7 @@ static void rxe_uninit_device(struct verbs_device *verbs_device)
 static struct verbs_device *rxe_device_alloc(struct verbs_sysfs_dev *sysfs_dev)
 {
 	struct rxe_device *dev;
+
 	dev = calloc(1, sizeof(*dev));
 	if (!dev)
 		return NULL;
diff --git a/providers/rxe/rxe.h b/providers/rxe/rxe.h
index 96f4ee9c..6dfca0ab 100644
--- a/providers/rxe/rxe.h
+++ b/providers/rxe/rxe.h
@@ -94,6 +94,25 @@ struct rxe_srq {
 	uint32_t		srq_num;
 };
 
+struct rxe_mr {
+	struct verbs_mr		verbs_mr;
+	uint32_t		index;
+};
+
+/* private flags to rxe_post_one_send */
+enum rxe_send_flags {
+	/* used to tell bind calls that
+	 * used the verbs API from user
+	 * posted send wr
+	 */
+	RXE_BIND_MW		= (1 << 0),
+};
+
+struct rxe_mw {
+	struct ibv_mw		ibv_mw;
+	uint32_t		index;
+};
+
 #define to_rxxx(xxx, type) container_of(ib##xxx, struct rxe_##type, ibv_##xxx)
 
 static inline struct rxe_context *to_rctx(struct ibv_context *ibctx)
@@ -126,4 +145,29 @@ static inline struct rxe_ah *to_rah(struct ibv_ah *ibah)
 	return to_rxxx(ah, ah);
 }
 
+static inline struct rxe_mr *to_rmr(struct ibv_mr *ibmr)
+{
+	return container_of(ibmr, struct rxe_mr, verbs_mr.ibv_mr);
+}
+
+static inline struct rxe_mw *to_rmw(struct ibv_mw *ibmw)
+{
+	return to_rxxx(mw, mw);
+}
+
+/* rxe_mw.c */
+struct ibv_mw *rxe_alloc_mw(struct ibv_pd *pd, enum ibv_mw_type type);
+int rxe_dealloc_mw(struct ibv_mw *mw);
+int rxe_bind_mw(struct ibv_qp *qp, struct ibv_mw *mw,
+		struct ibv_mw_bind *mw_bind);
+
+/* rxe_sq.c */
+int rxe_post_one_send(struct rxe_qp *qp, struct ibv_send_wr *ibwr,
+		      unsigned int length, enum rxe_send_flags flags);
+
+int rxe_post_send_db(struct ibv_qp *ibqp);
+
+int rxe_post_send(struct ibv_qp *ibqp, struct ibv_send_wr *wr_list,
+		  struct ibv_send_wr **bad_wr);
+
 #endif /* RXE_H */
diff --git a/providers/rxe/rxe_mw.c b/providers/rxe/rxe_mw.c
new file mode 100644
index 00000000..8520a0fa
--- /dev/null
+++ b/providers/rxe/rxe_mw.c
@@ -0,0 +1,149 @@
+/*
+ * Copyright (c) 2020 Hewlett Packard Enterprise, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *	- Redistributions of source code must retain the above
+ *	  copyright notice, this list of conditions and the following
+ *	  disclaimer.
+ *
+ *	- Redistributions in binary form must reproduce the above
+ *	  copyright notice, this list of conditions and the following
+ *	  disclaimer in the documentation and/or other materials
+ *	  provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <config.h>
+
+#include <endian.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <pthread.h>
+#include <netinet/in.h>
+#include <sys/mman.h>
+#include <errno.h>
+
+#include <endian.h>
+#include <pthread.h>
+#include <stddef.h>
+
+#include "rxe.h"
+#include "rxe_queue.h"
+#include <rdma/rdma_user_rxe.h>
+#include "rxe-abi.h"
+
+struct ibv_mw *rxe_alloc_mw(struct ibv_pd *ibpd, enum ibv_mw_type type)
+{
+	int ret;
+	struct rxe_mw *mw;
+	struct ibv_alloc_mw cmd = {};
+	struct urxe_alloc_mw_resp resp = {};
+
+	mw = calloc(1, sizeof(*mw));
+	if (!mw)
+		return NULL;
+
+	ret = ibv_cmd_alloc_mw(ibpd, type, &mw->ibv_mw, &cmd, sizeof(cmd),
+			       &resp.ibv_resp, sizeof(resp));
+	if (ret) {
+		free(mw);
+		return NULL;
+	}
+
+	mw->index = resp.index;
+
+	return &mw->ibv_mw;
+}
+
+static int next_rkey(int rkey)
+{
+	return (rkey & 0xffffff00) | ((rkey + 1) & 0x000000ff);
+}
+
+/* private version of rxe_post_one_send to set flags field in wqe */
+int rxe_bind_mw(struct ibv_qp *ibqp, struct ibv_mw *ibmw,
+		struct ibv_mw_bind *mw_bind)
+{
+	int ret;
+	struct rxe_qp *qp = to_rqp(ibqp);
+	struct ibv_mw_bind_info	*bind_info = &mw_bind->bind_info;
+	struct ibv_send_wr ibwr;
+
+	if (!bind_info->mr && (bind_info->addr || bind_info->length)) {
+		ret = EINVAL;
+		goto err;
+	}
+
+	if (bind_info->mw_access_flags & IBV_ACCESS_ZERO_BASED) {
+		ret = EINVAL;
+		goto err;
+	}
+
+	if (bind_info->mr) {
+		/* more to do here see mlx5 */
+		if (ibmw->pd != bind_info->mr->pd) {
+			ret = EPERM;
+			goto err;
+		}
+	}
+
+	memset(&ibwr, 0, sizeof(ibwr));
+
+	ibwr.opcode		= IBV_WR_BIND_MW;
+	ibwr.next		= NULL;
+	ibwr.wr_id		= mw_bind->wr_id;
+	ibwr.send_flags		= mw_bind->send_flags;
+	ibwr.bind_mw.bind_info	= mw_bind->bind_info;
+	ibwr.bind_mw.mw		= ibmw;
+	ibwr.bind_mw.rkey	= next_rkey(ibmw->rkey);
+
+	pthread_spin_lock(&qp->sq.lock);
+	ret = rxe_post_one_send(qp, &ibwr, 0, RXE_BIND_MW);
+	pthread_spin_unlock(&qp->sq.lock);
+
+	if (!ret)
+		ret =  rxe_post_send_db(ibqp);
+
+	if (ret)
+		goto err;
+
+	/* user has to undo this if he gets an error wc */
+	ibmw->rkey = ibwr.bind_mw.rkey;
+
+	return 0;
+err:
+	errno = ret;
+	return errno;
+}
+
+int rxe_dealloc_mw(struct ibv_mw *ibmw)
+{
+	struct rxe_mw *mw = to_rmw(ibmw);
+	int ret;
+
+	ret = ibv_cmd_dealloc_mw(ibmw);
+	if (ret)
+		return ret;
+
+	free(mw);
+	return 0;
+}
diff --git a/providers/rxe/rxe_sq.c b/providers/rxe/rxe_sq.c
new file mode 100644
index 00000000..7232891b
--- /dev/null
+++ b/providers/rxe/rxe_sq.c
@@ -0,0 +1,319 @@
+/*
+ * Copyright (c) 2020 Hewlett Packard Entrprise, Inc. All rights reserved.
+ * Copyright (c) 2009 Mellanox Technologies Ltd. All rights reserved.
+ * Copyright (c) 2009 System Fabric Works, Inc. All rights reserved.
+ * Copyright (C) 2006-2007 QLogic Corporation, All rights reserved.
+ * Copyright (c) 2005. PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *	- Redistributions of source code must retain the above
+ *	  copyright notice, this list of conditions and the following
+ *	  disclaimer.
+ *
+ *	- Redistributions in binary form must reproduce the above
+ *	  copyright notice, this list of conditions and the following
+ *	  disclaimer in the documentation and/or other materials
+ *	  provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <config.h>
+
+#include <endian.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <pthread.h>
+#include <netinet/in.h>
+#include <sys/mman.h>
+#include <errno.h>
+
+#include <endian.h>
+#include <pthread.h>
+#include <stddef.h>
+
+#include "rxe.h"
+#include "rxe_queue.h"
+#include <rdma/rdma_user_rxe.h>
+#include "rxe-abi.h"
+
+/* basic sanity checks for send work request */
+static int validate_send_wr(struct rxe_qp *qp,
+			    struct ibv_send_wr *ibwr,
+			    unsigned int length)
+{
+	struct rxe_wq *sq = &qp->sq;
+	enum ibv_wr_opcode opcode = ibwr->opcode;
+
+	if (ibwr->num_sge > sq->max_sge)
+		goto err;
+
+	if ((opcode == IBV_WR_ATOMIC_CMP_AND_SWP)
+	    || (opcode == IBV_WR_ATOMIC_FETCH_AND_ADD))
+		if (length < 8 || ibwr->wr.atomic.remote_addr & 0x7)
+			goto err;
+
+	if ((ibwr->send_flags & IBV_SEND_INLINE) &&
+	    (length > sq->max_inline))
+		goto err;
+
+	if (ibwr->opcode == IBV_WR_BIND_MW) {
+		if (length)
+			goto err;
+		if (ibwr->num_sge)
+			goto err;
+		if (ibwr->imm_data)
+			goto err;
+		if ((qp_type(qp) != IBV_QPT_RC) &&
+		    (qp_type(qp) != IBV_QPT_UC) &&
+		    (qp_type(qp) != IBV_QPT_XRC_SEND))
+			goto err;
+		/* only type 2 MWs may use post send bind
+		 * we skip this test for ibv_bind_mw by
+		 * calling post_one_send
+		 */
+		if (ibwr->bind_mw.mw->type == 1)
+			goto err;
+	}
+
+	return 0;
+err:
+	errno = EINVAL;
+	return errno;
+}
+
+static int convert_send_wr(struct rxe_send_wr *kwr, struct ibv_send_wr *uwr)
+{
+	struct rxe_mr *mr;
+	struct rxe_mw *mw;
+
+	memset(kwr, 0, sizeof(*kwr));
+
+	kwr->wr_id		= uwr->wr_id;
+	kwr->num_sge		= uwr->num_sge;
+	kwr->opcode		= uwr->opcode;
+	kwr->send_flags		= uwr->send_flags;
+	kwr->ex.imm_data	= uwr->imm_data;
+
+	switch (uwr->opcode) {
+	case IBV_WR_RDMA_WRITE:
+	case IBV_WR_RDMA_WRITE_WITH_IMM:
+	case IBV_WR_RDMA_READ:
+		kwr->wr.rdma.remote_addr	= uwr->wr.rdma.remote_addr;
+		kwr->wr.rdma.rkey		= uwr->wr.rdma.rkey;
+		break;
+
+	case IBV_WR_SEND:
+	case IBV_WR_SEND_WITH_IMM:
+		kwr->wr.ud.remote_qpn		= uwr->wr.ud.remote_qpn;
+		kwr->wr.ud.remote_qkey		= uwr->wr.ud.remote_qkey;
+		break;
+
+	case IBV_WR_ATOMIC_CMP_AND_SWP:
+	case IBV_WR_ATOMIC_FETCH_AND_ADD:
+		kwr->wr.atomic.remote_addr	= uwr->wr.atomic.remote_addr;
+		kwr->wr.atomic.compare_add	= uwr->wr.atomic.compare_add;
+		kwr->wr.atomic.swap		= uwr->wr.atomic.swap;
+		kwr->wr.atomic.rkey		= uwr->wr.atomic.rkey;
+		break;
+
+	case IBV_WR_BIND_MW:
+		mr = to_rmr(uwr->bind_mw.bind_info.mr);
+		mw = to_rmw(uwr->bind_mw.mw);
+
+		kwr->wr.umw.addr		= uwr->bind_mw.bind_info.addr;
+		kwr->wr.umw.length		= uwr->bind_mw.bind_info.length;
+		kwr->wr.umw.mr_index		= mr->index;
+		kwr->wr.umw.mw_index		= mw->index;
+		kwr->wr.umw.rkey		= uwr->bind_mw.rkey;
+		kwr->wr.umw.access		= uwr->bind_mw.bind_info.mw_access_flags;
+		break;
+
+	case IBV_WR_LOCAL_INV:
+	case IBV_WR_SEND_WITH_INV:
+	case IBV_WR_TSO:
+	case IBV_WR_DRIVER1:
+		break;
+	default:
+		errno = EINVAL;
+		return errno;
+	}
+
+	return 0;
+}
+
+static int init_send_wqe(struct rxe_qp *qp, struct ibv_send_wr *ibwr,
+			 unsigned int length, struct rxe_send_wqe *wqe,
+			 enum rxe_send_flags flags)
+{
+	int i;
+	int ret;
+	int num_sge = ibwr->num_sge;
+	unsigned int opcode = ibwr->opcode;
+
+	ret = convert_send_wr(&wqe->wr, ibwr);
+	if (ret)
+		return ret;
+
+	wqe->dma.length		= length;
+	wqe->dma.resid		= length;
+	wqe->dma.num_sge	= num_sge;
+	wqe->dma.cur_sge	= 0;
+	wqe->dma.sge_offset	= 0;
+	wqe->state		= 0;
+	wqe->ssn		= qp->ssn++;
+
+	if (qp_type(qp) == IBV_QPT_UD)
+		memcpy(&wqe->av, &to_rah(ibwr->wr.ud.ah)->av,
+		       sizeof(struct rxe_av));
+
+	if (ibwr->send_flags & IBV_SEND_INLINE) {
+		uint8_t *inline_data = wqe->dma.inline_data;
+
+		wqe->dma.resid = 0;
+
+		for (i = 0; i < num_sge; i++) {
+			memcpy(inline_data,
+			       (uint8_t *)(long)ibwr->sg_list[i].addr,
+			       ibwr->sg_list[i].length);
+			inline_data += ibwr->sg_list[i].length;
+		}
+	} else {
+		memcpy(wqe->dma.sge, ibwr->sg_list,
+		       num_sge*sizeof(struct ibv_sge));
+	}
+
+	if ((opcode == IBV_WR_ATOMIC_CMP_AND_SWP) ||
+	    (opcode == IBV_WR_ATOMIC_FETCH_AND_ADD))
+		wqe->iova	= ibwr->wr.atomic.remote_addr;
+	else
+		wqe->iova	= ibwr->wr.rdma.remote_addr;
+
+	/* let the kernel know we came through the verbs API */
+	if (flags & RXE_BIND_MW)
+		wqe->wr.wr.umw.flags = RXE_BIND_MW;
+
+	return 0;
+}
+
+/* call with qp->sq->lock held */
+int rxe_post_one_send(struct rxe_qp *qp, struct ibv_send_wr *ibwr,
+		      unsigned int length, enum rxe_send_flags flags)
+{
+	int err;
+	struct rxe_send_wqe *wqe;
+	struct rxe_wq *sq = &qp->sq;
+
+	if (queue_full(sq->queue)) {
+		err = ENOMEM;
+		goto err;
+	}
+
+	wqe = (struct rxe_send_wqe *)producer_addr(sq->queue);
+
+	err = init_send_wqe(qp, ibwr, length, wqe, flags);
+	if (err)
+		goto err;
+
+	advance_producer(qp->sq.queue);
+
+	return 0;
+err:
+	errno = err;
+	return errno;
+}
+
+/* send a null post send as a doorbell */
+int rxe_post_send_db(struct ibv_qp *ibqp)
+{
+	int ret;
+
+	ret = ibv_cmd_post_send(ibqp, NULL, NULL);
+	if (ret)
+		goto err;
+	return 0;
+err:
+	errno = ret;
+	return errno;
+}
+
+/* this API does not make a distinction between
+ * restartable and non-restartable errors
+ */
+int rxe_post_send(struct ibv_qp *ibqp, struct ibv_send_wr *wr_list,
+		  struct ibv_send_wr **bad_wr)
+{
+	int i;
+	int ret = 0;
+	int err = 0;
+	unsigned int length = 0;
+	int work_to_do = 0;
+	struct rxe_qp *qp = to_rqp(ibqp);
+	struct ibv_send_wr *ibwr;
+
+	if (!wr_list || !bad_wr) {
+		err = EINVAL;
+		goto err;
+	}
+
+	*bad_wr = NULL;
+
+	pthread_spin_lock(&qp->sq.lock);
+
+	while (wr_list) {
+		ibwr = wr_list;
+
+		for (i = 0; i < ibwr->num_sge; i++)
+			length += ibwr->sg_list[i].length;
+
+		/* moved here from post_one_send to allow
+		 * calling post_one_send without checking
+		 */
+		ret = validate_send_wr(qp, ibwr, length);
+		if (ret) {
+			*bad_wr = ibwr;
+			break;
+		}
+
+		ret = rxe_post_one_send(qp, ibwr, length, 0);
+		if (ret) {
+			*bad_wr = ibwr;
+			break;
+		}
+
+		work_to_do++;
+		wr_list = wr_list->next;
+	}
+
+	pthread_spin_unlock(&qp->sq.lock);
+
+	if (work_to_do)
+		err =  rxe_post_send_db(ibqp);
+
+	err = err ? err : ret;
+	if (err)
+		goto err;
+
+	return 0;
+err:
+	errno = err;
+	return errno;
+}
-- 
2.25.1

