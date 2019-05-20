Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8301122C66
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 08:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbfETGzd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 02:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730826AbfETGzc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 02:55:32 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A30920859;
        Mon, 20 May 2019 06:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558335331;
        bh=X6YN1ee5OR/2PMGbO2GiHWqeRyDb6hLd5D/EcJTk/2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vSw8eOJSNVALYZaHVVC7uA4a7YxdQtj3gP0Nkjp9MyQNDu4OqlBPSr86ZMJSf7ZxG
         qBNSLXJ7VlKvvJGUcEyJFNKIeF2PPiJhaU4P0GsMtkeU1RBLnz9B1/BVCk/YHx40Gh
         OWPycFbeKiOr9EDcYeLDmd2hPOUktvAeUq+Pgrps=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rdma-next 13/15] RDMA/cxgb4: Use sizeof() notation
Date:   Mon, 20 May 2019 09:54:31 +0300
Message-Id: <20190520065433.8734-14-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520065433.8734-1-leon@kernel.org>
References: <20190520065433.8734-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Convert various sizeof call sites to be written
in standard format sizeof().

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/cxgb4/cm.c       | 12 ++++----
 drivers/infiniband/hw/cxgb4/cq.c       |  8 ++---
 drivers/infiniband/hw/cxgb4/device.c   |  9 +++---
 drivers/infiniband/hw/cxgb4/mem.c      |  2 +-
 drivers/infiniband/hw/cxgb4/provider.c |  1 -
 drivers/infiniband/hw/cxgb4/qp.c       | 41 +++++++++++++-------------
 drivers/infiniband/hw/cxgb4/resource.c | 16 +++++-----
 7 files changed, 43 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 0f3b1193d5f8..374a2ee4546d 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -953,7 +953,7 @@ static int send_mpa_req(struct c4iw_ep *ep, struct sk_buff *skb,
 	mpalen = sizeof(*mpa) + ep->plen;
 	if (mpa_rev_to_use == 2)
 		mpalen += sizeof(struct mpa_v2_conn_params);
-	wrlen = roundup(mpalen + sizeof *req, 16);
+	wrlen = roundup(mpalen + sizeof(*req), 16);
 	skb = get_skb(skb, wrlen, GFP_KERNEL);
 	if (!skb) {
 		connect_reply_upcall(ep, -ENOMEM);
@@ -998,7 +998,7 @@ static int send_mpa_req(struct c4iw_ep *ep, struct sk_buff *skb,
 
 	if (mpa_rev_to_use == 2) {
 		mpa->private_data_size = htons(ntohs(mpa->private_data_size) +
-					       sizeof (struct mpa_v2_conn_params));
+					       sizeof(struct mpa_v2_conn_params));
 		pr_debug("initiator ird %u ord %u\n", ep->ird,
 			 ep->ord);
 		mpa_v2_params.ird = htons((u16)ep->ird);
@@ -1057,7 +1057,7 @@ static int send_mpa_reject(struct c4iw_ep *ep, const void *pdata, u8 plen)
 	mpalen = sizeof(*mpa) + plen;
 	if (ep->mpa_attr.version == 2 && ep->mpa_attr.enhanced_rdma_conn)
 		mpalen += sizeof(struct mpa_v2_conn_params);
-	wrlen = roundup(mpalen + sizeof *req, 16);
+	wrlen = roundup(mpalen + sizeof(*req), 16);
 
 	skb = get_skb(NULL, wrlen, GFP_KERNEL);
 	if (!skb) {
@@ -1089,7 +1089,7 @@ static int send_mpa_reject(struct c4iw_ep *ep, const void *pdata, u8 plen)
 	if (ep->mpa_attr.version == 2 && ep->mpa_attr.enhanced_rdma_conn) {
 		mpa->flags |= MPA_ENHANCED_RDMA_CONN;
 		mpa->private_data_size = htons(ntohs(mpa->private_data_size) +
-					       sizeof (struct mpa_v2_conn_params));
+					       sizeof(struct mpa_v2_conn_params));
 		mpa_v2_params.ird = htons(((u16)ep->ird) |
 					  (peer2peer ? MPA_V2_PEER2PEER_MODEL :
 					   0));
@@ -1136,7 +1136,7 @@ static int send_mpa_reply(struct c4iw_ep *ep, const void *pdata, u8 plen)
 	mpalen = sizeof(*mpa) + plen;
 	if (ep->mpa_attr.version == 2 && ep->mpa_attr.enhanced_rdma_conn)
 		mpalen += sizeof(struct mpa_v2_conn_params);
-	wrlen = roundup(mpalen + sizeof *req, 16);
+	wrlen = roundup(mpalen + sizeof(*req), 16);
 
 	skb = get_skb(NULL, wrlen, GFP_KERNEL);
 	if (!skb) {
@@ -1172,7 +1172,7 @@ static int send_mpa_reply(struct c4iw_ep *ep, const void *pdata, u8 plen)
 	if (ep->mpa_attr.version == 2 && ep->mpa_attr.enhanced_rdma_conn) {
 		mpa->flags |= MPA_ENHANCED_RDMA_CONN;
 		mpa->private_data_size = htons(ntohs(mpa->private_data_size) +
-					       sizeof (struct mpa_v2_conn_params));
+					       sizeof(struct mpa_v2_conn_params));
 		mpa_v2_params.ird = htons((u16)ep->ird);
 		mpa_v2_params.ord = htons((u16)ep->ord);
 		if (peer2peer && (ep->mpa_attr.p2p_type !=
diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 2b8c7ab62bb6..ea4a263e5a58 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -42,7 +42,7 @@ static void destroy_cq(struct c4iw_rdev *rdev, struct t4_cq *cq,
 	struct fw_ri_res *res;
 	int wr_len;
 
-	wr_len = sizeof *res_wr + sizeof *res;
+	wr_len = sizeof(*res_wr) + sizeof(*res);
 	set_wr_txq(skb, CPL_PRIORITY_CONTROL, 0);
 
 	res_wr = __skb_put_zero(skb, wr_len);
@@ -115,7 +115,7 @@ static int create_cq(struct c4iw_rdev *rdev, struct t4_cq *cq,
 	}
 
 	/* build fw_ri_res_wr */
-	wr_len = sizeof *res_wr + sizeof *res;
+	wr_len = sizeof(*res_wr) + sizeof(*res);
 
 	skb = alloc_skb(wr_len, GFP_KERNEL);
 	if (!skb) {
@@ -1092,10 +1092,10 @@ struct ib_cq *c4iw_create_cq(struct ib_device *ibdev,
 
 	if (ucontext) {
 		ret = -ENOMEM;
-		mm = kmalloc(sizeof *mm, GFP_KERNEL);
+		mm = kmalloc(sizeof(*mm), GFP_KERNEL);
 		if (!mm)
 			goto err_remove_handle;
-		mm2 = kmalloc(sizeof *mm2, GFP_KERNEL);
+		mm2 = kmalloc(sizeof(*mm2), GFP_KERNEL);
 		if (!mm2)
 			goto err_free_mm;
 
diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
index 4c0d925c5ff5..a8b9548bd1a2 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -327,7 +327,7 @@ static int qp_open(struct inode *inode, struct file *file)
 	unsigned long index;
 	int count = 1;
 
-	qpd = kmalloc(sizeof *qpd, GFP_KERNEL);
+	qpd = kmalloc(sizeof(*qpd), GFP_KERNEL);
 	if (!qpd)
 		return -ENOMEM;
 
@@ -421,7 +421,7 @@ static int stag_open(struct inode *inode, struct file *file)
 	int ret = 0;
 	int count = 1;
 
-	stagd = kmalloc(sizeof *stagd, GFP_KERNEL);
+	stagd = kmalloc(sizeof(*stagd), GFP_KERNEL);
 	if (!stagd) {
 		ret = -ENOMEM;
 		goto out;
@@ -1075,7 +1075,7 @@ static void *c4iw_uld_add(const struct cxgb4_lld_info *infop)
 		pr_info("Chelsio T4/T5 RDMA Driver - version %s\n",
 			DRV_VERSION);
 
-	ctx = kzalloc(sizeof *ctx, GFP_KERNEL);
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx) {
 		ctx = ERR_PTR(-ENOMEM);
 		goto out;
@@ -1243,10 +1243,9 @@ static int c4iw_uld_state_change(void *handle, enum cxgb4_state new_state)
 	case CXGB4_STATE_START_RECOVERY:
 		pr_info("%s: Fatal Error\n", pci_name(ctx->lldi.pdev));
 		if (ctx->dev) {
-			struct ib_event event;
+			struct ib_event event = {};
 
 			ctx->dev->rdev.flags |= T4_FATAL_ERROR;
-			memset(&event, 0, sizeof event);
 			event.event  = IB_EVENT_DEVICE_FATAL;
 			event.device = &ctx->dev->ibdev;
 			ib_dispatch_event(&event);
diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index 811c0c8c5b16..afb7ecae4ab2 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -130,7 +130,7 @@ static int _c4iw_write_mem_inline(struct c4iw_rdev *rdev, u32 addr, u32 len,
 
 		copy_len = len > C4IW_MAX_INLINE_SIZE ? C4IW_MAX_INLINE_SIZE :
 			   len;
-		wr_len = roundup(sizeof *req + sizeof *sc +
+		wr_len = roundup(sizeof(*req) + sizeof(*sc) +
 				 roundup(copy_len, T4_ULPTX_MIN_IO), 16);
 
 		if (!skb) {
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 74b795642fca..8ed75b141521 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -271,7 +271,6 @@ static int c4iw_query_device(struct ib_device *ibdev, struct ib_device_attr *pro
 		return -EINVAL;
 
 	dev = to_c4iw_dev(ibdev);
-	memset(props, 0, sizeof *props);
 	memcpy(&props->sys_image_guid, dev->rdev.lldi.ports[0]->dev_addr, 6);
 	props->hw_ver = CHELSIO_CHIP_RELEASE(dev->rdev.lldi.adapter_type);
 	props->fw_ver = dev->rdev.lldi.fw_vers;
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index e92b9544357a..0179f7483654 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -303,7 +303,7 @@ static int create_qp(struct c4iw_rdev *rdev, struct t4_wq *wq,
 	wq->rq.msn = 1;
 
 	/* build fw_ri_res_wr */
-	wr_len = sizeof *res_wr + 2 * sizeof *res;
+	wr_len = sizeof(*res_wr) + 2 * sizeof(*res);
 	if (need_rq)
 		wr_len += sizeof(*res);
 	skb = alloc_skb(wr_len, GFP_KERNEL);
@@ -439,7 +439,7 @@ static int build_immd(struct t4_sq *sq, struct fw_ri_immd *immdp,
 			rem -= len;
 		}
 	}
-	len = roundup(plen + sizeof *immdp, 16) - (plen + sizeof *immdp);
+	len = roundup(plen + sizeof(*immdp), 16) - (plen + sizeof(*immdp));
 	if (len)
 		memset(dstp, 0, len);
 	immdp->op = FW_RI_DATA_IMMD;
@@ -528,7 +528,7 @@ static int build_rdma_send(struct t4_sq *sq, union t4_wr *wqe,
 					 T4_MAX_SEND_INLINE, &plen);
 			if (ret)
 				return ret;
-			size = sizeof wqe->send + sizeof(struct fw_ri_immd) +
+			size = sizeof(wqe->send) + sizeof(struct fw_ri_immd) +
 			       plen;
 		} else {
 			ret = build_isgl((__be64 *)sq->queue,
@@ -537,7 +537,7 @@ static int build_rdma_send(struct t4_sq *sq, union t4_wr *wqe,
 					 wr->sg_list, wr->num_sge, &plen);
 			if (ret)
 				return ret;
-			size = sizeof wqe->send + sizeof(struct fw_ri_isgl) +
+			size = sizeof(wqe->send) + sizeof(struct fw_ri_isgl) +
 			       wr->num_sge * sizeof(struct fw_ri_sge);
 		}
 	} else {
@@ -545,7 +545,7 @@ static int build_rdma_send(struct t4_sq *sq, union t4_wr *wqe,
 		wqe->send.u.immd_src[0].r1 = 0;
 		wqe->send.u.immd_src[0].r2 = 0;
 		wqe->send.u.immd_src[0].immdlen = 0;
-		size = sizeof wqe->send + sizeof(struct fw_ri_immd);
+		size = sizeof(wqe->send) + sizeof(struct fw_ri_immd);
 		plen = 0;
 	}
 	*len16 = DIV_ROUND_UP(size, 16);
@@ -579,7 +579,7 @@ static int build_rdma_write(struct t4_sq *sq, union t4_wr *wqe,
 					 T4_MAX_WRITE_INLINE, &plen);
 			if (ret)
 				return ret;
-			size = sizeof wqe->write + sizeof(struct fw_ri_immd) +
+			size = sizeof(wqe->write) + sizeof(struct fw_ri_immd) +
 			       plen;
 		} else {
 			ret = build_isgl((__be64 *)sq->queue,
@@ -588,7 +588,7 @@ static int build_rdma_write(struct t4_sq *sq, union t4_wr *wqe,
 					 wr->sg_list, wr->num_sge, &plen);
 			if (ret)
 				return ret;
-			size = sizeof wqe->write + sizeof(struct fw_ri_isgl) +
+			size = sizeof(wqe->write) + sizeof(struct fw_ri_isgl) +
 			       wr->num_sge * sizeof(struct fw_ri_sge);
 		}
 	} else {
@@ -596,7 +596,7 @@ static int build_rdma_write(struct t4_sq *sq, union t4_wr *wqe,
 		wqe->write.u.immd_src[0].r1 = 0;
 		wqe->write.u.immd_src[0].r2 = 0;
 		wqe->write.u.immd_src[0].immdlen = 0;
-		size = sizeof wqe->write + sizeof(struct fw_ri_immd);
+		size = sizeof(wqe->write) + sizeof(struct fw_ri_immd);
 		plen = 0;
 	}
 	*len16 = DIV_ROUND_UP(size, 16);
@@ -683,7 +683,7 @@ static int build_rdma_read(union t4_wr *wqe, const struct ib_send_wr *wr,
 	}
 	wqe->read.r2 = 0;
 	wqe->read.r5 = 0;
-	*len16 = DIV_ROUND_UP(sizeof wqe->read, 16);
+	*len16 = DIV_ROUND_UP(sizeof(wqe->read), 16);
 	return 0;
 }
 
@@ -766,7 +766,7 @@ static int build_rdma_recv(struct c4iw_qp *qhp, union t4_recv_wr *wqe,
 			 &wqe->recv.isgl, wr->sg_list, wr->num_sge, NULL);
 	if (ret)
 		return ret;
-	*len16 = DIV_ROUND_UP(sizeof wqe->recv +
+	*len16 = DIV_ROUND_UP(sizeof(wqe->recv) +
 			      wr->num_sge * sizeof(struct fw_ri_sge), 16);
 	return 0;
 }
@@ -886,7 +886,7 @@ static int build_inv_stag(union t4_wr *wqe, const struct ib_send_wr *wr,
 {
 	wqe->inv.stag_inv = cpu_to_be32(wr->ex.invalidate_rkey);
 	wqe->inv.r2 = 0;
-	*len16 = DIV_ROUND_UP(sizeof wqe->inv, 16);
+	*len16 = DIV_ROUND_UP(sizeof(wqe->inv), 16);
 	return 0;
 }
 
@@ -1606,7 +1606,7 @@ static void post_terminate(struct c4iw_qp *qhp, struct t4_cqe *err_cqe,
 		FW_WR_LEN16_V(DIV_ROUND_UP(sizeof(*wqe), 16)));
 
 	wqe->u.terminate.type = FW_RI_TYPE_TERMINATE;
-	wqe->u.terminate.immdlen = cpu_to_be32(sizeof *term);
+	wqe->u.terminate.immdlen = cpu_to_be32(sizeof(*term));
 	term = (struct terminate_message *)wqe->u.terminate.termmsg;
 	if (qhp->attr.layer_etype == (LAYER_MPA|DDP_LLP)) {
 		term->layer_etype = qhp->attr.layer_etype;
@@ -1751,14 +1751,14 @@ static int rdma_fini(struct c4iw_dev *rhp, struct c4iw_qp *qhp,
 static void build_rtr_msg(u8 p2p_type, struct fw_ri_init *init)
 {
 	pr_debug("p2p_type = %d\n", p2p_type);
-	memset(&init->u, 0, sizeof init->u);
+	memset(&init->u, 0, sizeof(init->u));
 	switch (p2p_type) {
 	case FW_RI_INIT_P2PTYPE_RDMA_WRITE:
 		init->u.write.opcode = FW_RI_RDMA_WRITE_WR;
 		init->u.write.stag_sink = cpu_to_be32(1);
 		init->u.write.to_sink = cpu_to_be64(1);
 		init->u.write.u.immd_src[0].op = FW_RI_DATA_IMMD;
-		init->u.write.len16 = DIV_ROUND_UP(sizeof init->u.write +
+		init->u.write.len16 = DIV_ROUND_UP(sizeof(init->u.write) +
 						   sizeof(struct fw_ri_immd),
 						   16);
 		break;
@@ -1768,7 +1768,7 @@ static void build_rtr_msg(u8 p2p_type, struct fw_ri_init *init)
 		init->u.read.to_src_lo = cpu_to_be32(1);
 		init->u.read.stag_sink = cpu_to_be32(1);
 		init->u.read.to_sink_lo = cpu_to_be32(1);
-		init->u.read.len16 = DIV_ROUND_UP(sizeof init->u.read, 16);
+		init->u.read.len16 = DIV_ROUND_UP(sizeof(init->u.read), 16);
 		break;
 	}
 }
@@ -1782,7 +1782,7 @@ static int rdma_init(struct c4iw_dev *rhp, struct c4iw_qp *qhp)
 	pr_debug("qhp %p qid 0x%x tid %u ird %u ord %u\n", qhp,
 		 qhp->wq.sq.qid, qhp->ep->hwtid, qhp->ep->ird, qhp->ep->ord);
 
-	skb = alloc_skb(sizeof *wqe, GFP_KERNEL);
+	skb = alloc_skb(sizeof(*wqe), GFP_KERNEL);
 	if (!skb) {
 		ret = -ENOMEM;
 		goto out;
@@ -2302,7 +2302,7 @@ struct ib_qp *c4iw_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attrs,
 			ucontext->key += PAGE_SIZE;
 		}
 		spin_unlock(&ucontext->mmap_lock);
-		ret = ib_copy_to_udata(udata, &uresp, sizeof uresp);
+		ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
 		if (ret)
 			goto err_free_ma_sync_key;
 		sq_key_mm->key = uresp.sq_key;
@@ -2386,7 +2386,7 @@ int c4iw_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	struct c4iw_dev *rhp;
 	struct c4iw_qp *qhp;
 	enum c4iw_qp_attr_mask mask = 0;
-	struct c4iw_qp_attributes attrs;
+	struct c4iw_qp_attributes attrs = {};
 
 	pr_debug("ib_qp %p\n", ibqp);
 
@@ -2398,7 +2398,6 @@ int c4iw_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	if (!attr_mask)
 		return 0;
 
-	memset(&attrs, 0, sizeof attrs);
 	qhp = to_c4iw_qp(ibqp);
 	rhp = qhp->rhp;
 
@@ -2482,8 +2481,8 @@ int c4iw_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 {
 	struct c4iw_qp *qhp = to_c4iw_qp(ibqp);
 
-	memset(attr, 0, sizeof *attr);
-	memset(init_attr, 0, sizeof *init_attr);
+	memset(attr, 0, sizeof(*attr));
+	memset(init_attr, 0, sizeof(*init_attr));
 	attr->qp_state = to_ib_qp_state(qhp->attr.state);
 	init_attr->cap.max_send_wr = qhp->attr.sq_num_entries;
 	init_attr->cap.max_recv_wr = qhp->attr.rq_num_entries;
diff --git a/drivers/infiniband/hw/cxgb4/resource.c b/drivers/infiniband/hw/cxgb4/resource.c
index 57ed26b3cc21..5c95c789f302 100644
--- a/drivers/infiniband/hw/cxgb4/resource.c
+++ b/drivers/infiniband/hw/cxgb4/resource.c
@@ -126,7 +126,7 @@ u32 c4iw_get_cqid(struct c4iw_rdev *rdev, struct c4iw_dev_ucontext *uctx)
 		rdev->stats.qid.cur += rdev->qpmask + 1;
 		mutex_unlock(&rdev->stats.lock);
 		for (i = qid+1; i & rdev->qpmask; i++) {
-			entry = kmalloc(sizeof *entry, GFP_KERNEL);
+			entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 			if (!entry)
 				goto out;
 			entry->qid = i;
@@ -137,13 +137,13 @@ u32 c4iw_get_cqid(struct c4iw_rdev *rdev, struct c4iw_dev_ucontext *uctx)
 		 * now put the same ids on the qp list since they all
 		 * map to the same db/gts page.
 		 */
-		entry = kmalloc(sizeof *entry, GFP_KERNEL);
+		entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 		if (!entry)
 			goto out;
 		entry->qid = qid;
 		list_add_tail(&entry->entry, &uctx->qpids);
 		for (i = qid+1; i & rdev->qpmask; i++) {
-			entry = kmalloc(sizeof *entry, GFP_KERNEL);
+			entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 			if (!entry)
 				goto out;
 			entry->qid = i;
@@ -165,7 +165,7 @@ void c4iw_put_cqid(struct c4iw_rdev *rdev, u32 qid,
 {
 	struct c4iw_qid_list *entry;
 
-	entry = kmalloc(sizeof *entry, GFP_KERNEL);
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
 		return;
 	pr_debug("qid 0x%x\n", qid);
@@ -200,7 +200,7 @@ u32 c4iw_get_qpid(struct c4iw_rdev *rdev, struct c4iw_dev_ucontext *uctx)
 		rdev->stats.qid.cur += rdev->qpmask + 1;
 		mutex_unlock(&rdev->stats.lock);
 		for (i = qid+1; i & rdev->qpmask; i++) {
-			entry = kmalloc(sizeof *entry, GFP_KERNEL);
+			entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 			if (!entry)
 				goto out;
 			entry->qid = i;
@@ -211,13 +211,13 @@ u32 c4iw_get_qpid(struct c4iw_rdev *rdev, struct c4iw_dev_ucontext *uctx)
 		 * now put the same ids on the cq list since they all
 		 * map to the same db/gts page.
 		 */
-		entry = kmalloc(sizeof *entry, GFP_KERNEL);
+		entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 		if (!entry)
 			goto out;
 		entry->qid = qid;
 		list_add_tail(&entry->entry, &uctx->cqids);
 		for (i = qid; i & rdev->qpmask; i++) {
-			entry = kmalloc(sizeof *entry, GFP_KERNEL);
+			entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 			if (!entry)
 				goto out;
 			entry->qid = i;
@@ -239,7 +239,7 @@ void c4iw_put_qpid(struct c4iw_rdev *rdev, u32 qid,
 {
 	struct c4iw_qid_list *entry;
 
-	entry = kmalloc(sizeof *entry, GFP_KERNEL);
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
 		return;
 	pr_debug("qid 0x%x\n", qid);
-- 
2.20.1

