Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 958843D173
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 17:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391836AbfFKPxQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 11:53:16 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33201 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388958AbfFKPxQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 11:53:16 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 11 Jun 2019 18:53:01 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x5BFqxLJ023036;
        Tue, 11 Jun 2019 18:53:01 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     maxg@mellanox.com, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 17/21] RDMA/rw: Use IB_WR_REG_MR_INTEGRITY for PI handover
Date:   Tue, 11 Jun 2019 18:52:53 +0300
Message-Id: <1560268377-26560-18-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
References: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

Replace the old signature handover API with the new one. The new API
simplifes PI handover code complexity for ULPs and improve performance.
For RW API it will reduce the maximum number of work requests per task
and the need of dealing with multiple MRs (and their registrations and
invalidations) per task. All the mappings and registration of the data
and the protection buffers is done by the LLD using a single WR and a
special MR type (IB_MR_TYPE_INTEGRITY) for the PI handover operation.

The setup of the tested benchmark (using iSER ULP):
 - 2 servers with 24 cores (1 initiator and 1 target)
 - ConnectX-4/ConnectX-5 adapters
 - 24 target sessions with 1 LUN each
 - ramdisk backstore
 - PI active

Performance results running fio (24 jobs, 128 iodepth) using
write_generate=1 and read_verify=1 (w/w.o patch):

bs      IOPS(read)        IOPS(write)
----    ----------        ----------
512   1243.3K/1182.3K    1725.1K/1680.2K
4k    571233/528835      743293/748259
32k   72388/71086        71789/93573

Using write_generate=0 and read_verify=0 (w/w.o patch):
bs      IOPS(read)        IOPS(write)
----    ----------        ----------
512   1572.1K/1427.2K    1823.5K/1724.3K
4k    921992/916194      753772/768267
32k   75052/73960        73180/95484

There is a performance degradation when writing big block sizes.
Degradation is caused by the complexity of combining multiple
indirections and perform RDMA READ operation from it. This will be
fixed in the following patches by reducing the indirections if
possible.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/core/rw.c            | 167 +++++++++++++-------------------
 drivers/infiniband/ulp/isert/ib_isert.c |   4 +-
 include/rdma/rw.h                       |   9 --
 3 files changed, 72 insertions(+), 108 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 096fafec1047..dce06108c8c3 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -51,10 +51,18 @@ static inline bool rdma_rw_io_needs_mr(struct ib_device *dev, u8 port_num,
 	return false;
 }
 
-static inline u32 rdma_rw_fr_page_list_len(struct ib_device *dev)
+static inline u32 rdma_rw_fr_page_list_len(struct ib_device *dev,
+					   bool pi_support)
 {
+	u32 max_pages;
+
+	if (pi_support)
+		max_pages = dev->attrs.max_pi_fast_reg_page_list_len;
+	else
+		max_pages = dev->attrs.max_fast_reg_page_list_len;
+
 	/* arbitrary limit to avoid allocating gigantic resources */
-	return min_t(u32, dev->attrs.max_fast_reg_page_list_len, 256);
+	return min_t(u32, max_pages, 256);
 }
 
 static inline int rdma_rw_inv_key(struct rdma_rw_reg_ctx *reg)
@@ -78,7 +86,8 @@ static int rdma_rw_init_one_mr(struct ib_qp *qp, u8 port_num,
 		struct rdma_rw_reg_ctx *reg, struct scatterlist *sg,
 		u32 sg_cnt, u32 offset)
 {
-	u32 pages_per_mr = rdma_rw_fr_page_list_len(qp->pd->device);
+	u32 pages_per_mr = rdma_rw_fr_page_list_len(qp->pd->device,
+						    qp->integrity_en);
 	u32 nents = min(sg_cnt, pages_per_mr);
 	int count = 0, ret;
 
@@ -111,7 +120,8 @@ static int rdma_rw_init_mr_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
 {
 	struct rdma_rw_reg_ctx *prev = NULL;
-	u32 pages_per_mr = rdma_rw_fr_page_list_len(qp->pd->device);
+	u32 pages_per_mr = rdma_rw_fr_page_list_len(qp->pd->device,
+						    qp->integrity_en);
 	int i, j, ret = 0, count = 0;
 
 	ctx->nr_ops = (sg_cnt + pages_per_mr - 1) / pages_per_mr;
@@ -352,9 +362,9 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
 {
 	struct ib_device *dev = qp->pd->device;
-	u32 pages_per_mr = rdma_rw_fr_page_list_len(qp->pd->device);
+	u32 pages_per_mr = rdma_rw_fr_page_list_len(qp->pd->device,
+						    qp->integrity_en);
 	struct ib_rdma_wr *rdma_wr;
-	struct ib_send_wr *prev_wr = NULL;
 	int count = 0, ret;
 
 	if (sg_cnt > pages_per_mr || prot_sg_cnt > pages_per_mr) {
@@ -368,75 +378,58 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		return -ENOMEM;
 	sg_cnt = ret;
 
-	ret = ib_dma_map_sg(dev, prot_sg, prot_sg_cnt, dir);
-	if (!ret) {
-		ret = -ENOMEM;
-		goto out_unmap_sg;
+	if (prot_sg_cnt) {
+		ret = ib_dma_map_sg(dev, prot_sg, prot_sg_cnt, dir);
+		if (!ret) {
+			ret = -ENOMEM;
+			goto out_unmap_sg;
+		}
+		prot_sg_cnt = ret;
 	}
-	prot_sg_cnt = ret;
 
 	ctx->type = RDMA_RW_SIG_MR;
 	ctx->nr_ops = 1;
-	ctx->sig = kcalloc(1, sizeof(*ctx->sig), GFP_KERNEL);
-	if (!ctx->sig) {
+	ctx->reg = kcalloc(1, sizeof(*ctx->reg), GFP_KERNEL);
+	if (!ctx->reg) {
 		ret = -ENOMEM;
 		goto out_unmap_prot_sg;
 	}
 
-	ret = rdma_rw_init_one_mr(qp, port_num, &ctx->sig->data, sg, sg_cnt, 0);
-	if (ret < 0)
-		goto out_free_ctx;
-	count += ret;
-	prev_wr = &ctx->sig->data.reg_wr.wr;
-
-	ret = rdma_rw_init_one_mr(qp, port_num, &ctx->sig->prot,
-				  prot_sg, prot_sg_cnt, 0);
-	if (ret < 0)
-		goto out_destroy_data_mr;
-	count += ret;
-
-	if (ctx->sig->prot.inv_wr.next)
-		prev_wr->next = &ctx->sig->prot.inv_wr;
-	else
-		prev_wr->next = &ctx->sig->prot.reg_wr.wr;
-	prev_wr = &ctx->sig->prot.reg_wr.wr;
-
-	ctx->sig->sig_mr = ib_mr_pool_get(qp, &qp->sig_mrs);
-	if (!ctx->sig->sig_mr) {
+	ctx->reg->mr = ib_mr_pool_get(qp, &qp->sig_mrs);
+	if (!ctx->reg->mr) {
 		ret = -EAGAIN;
-		goto out_destroy_prot_mr;
+		goto out_free_ctx;
 	}
 
-	if (ctx->sig->sig_mr->need_inval) {
-		memset(&ctx->sig->sig_inv_wr, 0, sizeof(ctx->sig->sig_inv_wr));
+	count += rdma_rw_inv_key(ctx->reg);
 
-		ctx->sig->sig_inv_wr.opcode = IB_WR_LOCAL_INV;
-		ctx->sig->sig_inv_wr.ex.invalidate_rkey = ctx->sig->sig_mr->rkey;
+	memcpy(ctx->reg->mr->sig_attrs, sig_attrs, sizeof(struct ib_sig_attrs));
 
-		prev_wr->next = &ctx->sig->sig_inv_wr;
-		prev_wr = &ctx->sig->sig_inv_wr;
+	ret = ib_map_mr_sg_pi(ctx->reg->mr, sg, sg_cnt, NULL, prot_sg,
+			      prot_sg_cnt, NULL, SZ_4K);
+	if (unlikely(ret)) {
+		pr_err("failed to map PI sg (%d)\n", sg_cnt + prot_sg_cnt);
+		goto out_destroy_sig_mr;
 	}
 
-	ctx->sig->sig_wr.wr.opcode = IB_WR_REG_SIG_MR;
-	ctx->sig->sig_wr.wr.wr_cqe = NULL;
-	ctx->sig->sig_wr.wr.sg_list = &ctx->sig->data.sge;
-	ctx->sig->sig_wr.wr.num_sge = 1;
-	ctx->sig->sig_wr.access_flags = IB_ACCESS_LOCAL_WRITE;
-	ctx->sig->sig_wr.sig_attrs = sig_attrs;
-	ctx->sig->sig_wr.sig_mr = ctx->sig->sig_mr;
-	if (prot_sg_cnt)
-		ctx->sig->sig_wr.prot = &ctx->sig->prot.sge;
-	prev_wr->next = &ctx->sig->sig_wr.wr;
-	prev_wr = &ctx->sig->sig_wr.wr;
+	ctx->reg->reg_wr.wr.opcode = IB_WR_REG_MR_INTEGRITY;
+	ctx->reg->reg_wr.wr.wr_cqe = NULL;
+	ctx->reg->reg_wr.wr.num_sge = 0;
+	ctx->reg->reg_wr.wr.send_flags = 0;
+	ctx->reg->reg_wr.access = IB_ACCESS_LOCAL_WRITE;
+	if (rdma_protocol_iwarp(qp->device, port_num))
+		ctx->reg->reg_wr.access |= IB_ACCESS_REMOTE_WRITE;
+	ctx->reg->reg_wr.mr = ctx->reg->mr;
+	ctx->reg->reg_wr.key = ctx->reg->mr->lkey;
 	count++;
 
-	ctx->sig->sig_sge.addr = 0;
-	ctx->sig->sig_sge.length = ctx->sig->data.sge.length;
-	if (sig_attrs->wire.sig_type != IB_SIG_TYPE_NONE)
-		ctx->sig->sig_sge.length += ctx->sig->prot.sge.length;
+	ctx->reg->sge.addr = ctx->reg->mr->iova;
+	ctx->reg->sge.length = ctx->reg->mr->length;
+	if (sig_attrs->wire.sig_type == IB_SIG_TYPE_NONE)
+		ctx->reg->sge.length -= ctx->reg->mr->sig_attrs->meta_length;
 
-	rdma_wr = &ctx->sig->data.wr;
-	rdma_wr->wr.sg_list = &ctx->sig->sig_sge;
+	rdma_wr = &ctx->reg->wr;
+	rdma_wr->wr.sg_list = &ctx->reg->sge;
 	rdma_wr->wr.num_sge = 1;
 	rdma_wr->remote_addr = remote_addr;
 	rdma_wr->rkey = rkey;
@@ -444,21 +437,18 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		rdma_wr->wr.opcode = IB_WR_RDMA_WRITE;
 	else
 		rdma_wr->wr.opcode = IB_WR_RDMA_READ;
-	prev_wr->next = &rdma_wr->wr;
-	prev_wr = &rdma_wr->wr;
+	ctx->reg->reg_wr.wr.next = &rdma_wr->wr;
 	count++;
 
 	return count;
 
-out_destroy_prot_mr:
-	if (prot_sg_cnt)
-		ib_mr_pool_put(qp, &qp->rdma_mrs, ctx->sig->prot.mr);
-out_destroy_data_mr:
-	ib_mr_pool_put(qp, &qp->rdma_mrs, ctx->sig->data.mr);
+out_destroy_sig_mr:
+	ib_mr_pool_put(qp, &qp->sig_mrs, ctx->reg->mr);
 out_free_ctx:
-	kfree(ctx->sig);
+	kfree(ctx->reg);
 out_unmap_prot_sg:
-	ib_dma_unmap_sg(dev, prot_sg, prot_sg_cnt, dir);
+	if (prot_sg_cnt)
+		ib_dma_unmap_sg(dev, prot_sg, prot_sg_cnt, dir);
 out_unmap_sg:
 	ib_dma_unmap_sg(dev, sg, sg_cnt, dir);
 	return ret;
@@ -501,22 +491,8 @@ struct ib_send_wr *rdma_rw_ctx_wrs(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 
 	switch (ctx->type) {
 	case RDMA_RW_SIG_MR:
-		rdma_rw_update_lkey(&ctx->sig->data, true);
-		if (ctx->sig->prot.mr)
-			rdma_rw_update_lkey(&ctx->sig->prot, true);
-	
-		ctx->sig->sig_mr->need_inval = true;
-		ib_update_fast_reg_key(ctx->sig->sig_mr,
-			ib_inc_rkey(ctx->sig->sig_mr->lkey));
-		ctx->sig->sig_sge.lkey = ctx->sig->sig_mr->lkey;
-
-		if (ctx->sig->data.inv_wr.next)
-			first_wr = &ctx->sig->data.inv_wr;
-		else
-			first_wr = &ctx->sig->data.reg_wr.wr;
-		last_wr = &ctx->sig->data.wr.wr;
-		break;
 	case RDMA_RW_MR:
+		/* fallthrough */
 		for (i = 0; i < ctx->nr_ops; i++) {
 			rdma_rw_update_lkey(&ctx->reg[i],
 				ctx->reg[i].wr.wr.opcode !=
@@ -633,16 +609,12 @@ void rdma_rw_ctx_destroy_signature(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	if (WARN_ON_ONCE(ctx->type != RDMA_RW_SIG_MR))
 		return;
 
-	ib_mr_pool_put(qp, &qp->rdma_mrs, ctx->sig->data.mr);
-	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
+	ib_mr_pool_put(qp, &qp->sig_mrs, ctx->reg->mr);
+	kfree(ctx->reg);
 
-	if (ctx->sig->prot.mr) {
-		ib_mr_pool_put(qp, &qp->rdma_mrs, ctx->sig->prot.mr);
+	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
+	if (prot_sg_cnt)
 		ib_dma_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
-	}
-
-	ib_mr_pool_put(qp, &qp->sig_mrs, ctx->sig->sig_mr);
-	kfree(ctx->sig);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy_signature);
 
@@ -663,7 +635,7 @@ unsigned int rdma_rw_mr_factor(struct ib_device *device, u8 port_num,
 	unsigned int mr_pages;
 
 	if (rdma_rw_can_use_mr(device, port_num))
-		mr_pages = rdma_rw_fr_page_list_len(device);
+		mr_pages = rdma_rw_fr_page_list_len(device, false);
 	else
 		mr_pages = device->attrs.max_sge_rd;
 	return DIV_ROUND_UP(maxpages, mr_pages);
@@ -689,9 +661,8 @@ void rdma_rw_init_qp(struct ib_device *dev, struct ib_qp_init_attr *attr)
 	 * we'll need two additional MRs for the registrations and the
 	 * invalidation.
 	 */
-	if (attr->create_flags & IB_QP_CREATE_INTEGRITY_EN)
-		factor += 6;	/* (inv + reg) * (data + prot + sig) */
-	else if (rdma_rw_can_use_mr(dev, attr->port_num))
+	if (attr->create_flags & IB_QP_CREATE_INTEGRITY_EN ||
+	    rdma_rw_can_use_mr(dev, attr->port_num))
 		factor += 2;	/* inv + reg */
 
 	attr->cap.max_send_wr += factor * attr->cap.max_rdma_ctxs;
@@ -707,20 +678,22 @@ void rdma_rw_init_qp(struct ib_device *dev, struct ib_qp_init_attr *attr)
 int rdma_rw_init_mrs(struct ib_qp *qp, struct ib_qp_init_attr *attr)
 {
 	struct ib_device *dev = qp->pd->device;
-	u32 nr_mrs = 0, nr_sig_mrs = 0;
+	u32 nr_mrs = 0, nr_sig_mrs = 0, max_num_sg = 0;
 	int ret = 0;
 
 	if (attr->create_flags & IB_QP_CREATE_INTEGRITY_EN) {
 		nr_sig_mrs = attr->cap.max_rdma_ctxs;
-		nr_mrs = attr->cap.max_rdma_ctxs * 2;
+		nr_mrs = attr->cap.max_rdma_ctxs;
+		max_num_sg = rdma_rw_fr_page_list_len(dev, true);
 	} else if (rdma_rw_can_use_mr(dev, attr->port_num)) {
 		nr_mrs = attr->cap.max_rdma_ctxs;
+		max_num_sg = rdma_rw_fr_page_list_len(dev, false);
 	}
 
 	if (nr_mrs) {
 		ret = ib_mr_pool_init(qp, &qp->rdma_mrs, nr_mrs,
 				IB_MR_TYPE_MEM_REG,
-				rdma_rw_fr_page_list_len(dev), 0);
+				max_num_sg, 0);
 		if (ret) {
 			pr_err("%s: failed to allocated %d MRs\n",
 				__func__, nr_mrs);
@@ -730,7 +703,7 @@ int rdma_rw_init_mrs(struct ib_qp *qp, struct ib_qp_init_attr *attr)
 
 	if (nr_sig_mrs) {
 		ret = ib_mr_pool_init(qp, &qp->sig_mrs, nr_sig_mrs,
-				IB_MR_TYPE_SIGNATURE, 2, 0);
+				IB_MR_TYPE_INTEGRITY, max_num_sg, max_num_sg);
 		if (ret) {
 			pr_err("%s: failed to allocated %d SIG MRs\n",
 				__func__, nr_sig_mrs);
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index df6c303103d5..a1a035270cab 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -1669,7 +1669,7 @@ isert_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	isert_dbg("Cmd %p\n", isert_cmd);
 
-	ret = isert_check_pi_status(cmd, isert_cmd->rw.sig->sig_mr);
+	ret = isert_check_pi_status(cmd, isert_cmd->rw.reg->mr);
 	isert_rdma_rw_ctx_destroy(isert_cmd, isert_conn);
 
 	if (ret) {
@@ -1715,7 +1715,7 @@ isert_rdma_read_done(struct ib_cq *cq, struct ib_wc *wc)
 	iscsit_stop_dataout_timer(cmd);
 
 	if (isert_prot_cmd(isert_conn, se_cmd))
-		ret = isert_check_pi_status(se_cmd, isert_cmd->rw.sig->sig_mr);
+		ret = isert_check_pi_status(se_cmd, isert_cmd->rw.reg->mr);
 	isert_rdma_rw_ctx_destroy(isert_cmd, isert_conn);
 	cmd->write_data_done = 0;
 
diff --git a/include/rdma/rw.h b/include/rdma/rw.h
index 494f79ca3e62..6ad9dc836c10 100644
--- a/include/rdma/rw.h
+++ b/include/rdma/rw.h
@@ -39,15 +39,6 @@ struct rdma_rw_ctx {
 			struct ib_send_wr	inv_wr;
 			struct ib_mr		*mr;
 		} *reg;
-
-		struct {
-			struct rdma_rw_reg_ctx	data;
-			struct rdma_rw_reg_ctx	prot;
-			struct ib_send_wr	sig_inv_wr;
-			struct ib_mr		*sig_mr;
-			struct ib_sge		sig_sge;
-			struct ib_sig_handover_wr sig_wr;
-		} *sig;
 	};
 };
 
-- 
2.16.3

