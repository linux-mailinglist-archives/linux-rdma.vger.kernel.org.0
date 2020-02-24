Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C6116ABF1
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 17:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgBXQpz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 11:45:55 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:59484 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727890AbgBXQpz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 11:45:55 -0500
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 24 Feb 2020 18:45:46 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 01OGji9U013647;
        Mon, 24 Feb 2020 18:45:45 +0200
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me,
        linux-rdma@vger.kernel.org, kbusch@kernel.org, hch@lst.de,
        martin.petersen@oracle.com
Cc:     vladimirk@mellanox.com, idanb@mellanox.com, maxg@mellanox.com,
        israelr@mellanox.com, axboe@kernel.dk, shlomin@mellanox.com
Subject: [PATCH 08/19] nvme-rdma: Add metadata/T10-PI support
Date:   Mon, 24 Feb 2020 18:45:33 +0200
Message-Id: <20200224164544.219438-10-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200224164544.219438-1-maxg@mellanox.com>
References: <20200224164544.219438-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For capable HCAs (e.g. ConnectX-4/ConnectX-5) this will allow end-to-end
protection information passthrough and validation for NVMe over RDMA
transport. Metadata offload support was implemented over the new RDMA
signature verbs API and it is enabled per controller by using nvme-cli.

usage example:
nvme connect --pi_enable --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/nvme/host/rdma.c | 330 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 296 insertions(+), 34 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index b6dd9f5..ad860ec 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -67,6 +67,9 @@ struct nvme_rdma_request {
 	struct ib_cqe		reg_cqe;
 	struct nvme_rdma_queue  *queue;
 	struct nvme_rdma_sgl	data_sgl;
+	/* Metadata (T10-PI) support */
+	struct nvme_rdma_sgl	*pi_sgl;
+	bool			use_pi;
 };
 
 enum nvme_rdma_queue_flags {
@@ -88,6 +91,7 @@ struct nvme_rdma_queue {
 	struct rdma_cm_id	*cm_id;
 	int			cm_error;
 	struct completion	cm_done;
+	bool			pi_support;
 };
 
 struct nvme_rdma_ctrl {
@@ -115,6 +119,7 @@ struct nvme_rdma_ctrl {
 	struct nvme_ctrl	ctrl;
 	bool			use_inline_data;
 	u32			io_queues[HCTX_MAX_TYPES];
+	bool			pi_support;
 };
 
 static inline struct nvme_rdma_ctrl *to_rdma_ctrl(struct nvme_ctrl *ctrl)
@@ -272,6 +277,8 @@ static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
 	init_attr.qp_type = IB_QPT_RC;
 	init_attr.send_cq = queue->ib_cq;
 	init_attr.recv_cq = queue->ib_cq;
+	if (queue->pi_support)
+		init_attr.create_flags |= IB_QP_CREATE_INTEGRITY_EN;
 
 	ret = rdma_create_qp(queue->cm_id, dev->pd, &init_attr);
 
@@ -287,6 +294,18 @@ static void nvme_rdma_exit_request(struct blk_mq_tag_set *set,
 	kfree(req->sqe.data);
 }
 
+static unsigned int nvme_rdma_cmd_size(bool has_pi)
+{
+	/*
+	 * nvme rdma command consists of struct nvme_rdma_request, data SGL,
+	 * PI nvme_rdma_sgl struct and then PI SGL.
+	 */
+	return sizeof(struct nvme_rdma_request) +
+	       sizeof(struct scatterlist) * NVME_INLINE_SG_CNT +
+	       has_pi * (sizeof(struct nvme_rdma_sgl) +
+			 sizeof(struct scatterlist) * NVME_INLINE_PROT_SG_CNT);
+}
+
 static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
 		struct request *rq, unsigned int hctx_idx,
 		unsigned int numa_node)
@@ -301,6 +320,10 @@ static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
 	if (!req->sqe.data)
 		return -ENOMEM;
 
+	/* PI nvme_rdma_sgl struct is located after command's data SGL */
+	if (queue->pi_support)
+		req->pi_sgl = (void *)nvme_req(rq) + nvme_rdma_cmd_size(false);
+
 	req->queue = queue;
 
 	return 0;
@@ -411,6 +434,8 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 	dev = queue->device;
 	ibdev = dev->dev;
 
+	if (queue->pi_support)
+		ib_mr_pool_destroy(queue->qp, &queue->qp->sig_mrs);
 	ib_mr_pool_destroy(queue->qp, &queue->qp->rdma_mrs);
 
 	/*
@@ -427,10 +452,13 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 	nvme_rdma_dev_put(dev);
 }
 
-static int nvme_rdma_get_max_fr_pages(struct ib_device *ibdev)
+static int nvme_rdma_get_max_fr_pages(struct ib_device *ibdev, bool pi_support)
 {
-	return min_t(u32, NVME_RDMA_MAX_SEGMENTS,
-		     ibdev->attrs.max_fast_reg_page_list_len - 1);
+	u32 max_page_list_len =
+		pi_support ? ibdev->attrs.max_pi_fast_reg_page_list_len :
+			     ibdev->attrs.max_fast_reg_page_list_len;
+
+	return min_t(u32, NVME_RDMA_MAX_SEGMENTS, max_page_list_len - 1);
 }
 
 static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
@@ -487,7 +515,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	 * misaligned we'll end up using two entries for a single data page,
 	 * so one additional entry is required.
 	 */
-	pages_per_mr = nvme_rdma_get_max_fr_pages(ibdev) + 1;
+	pages_per_mr = nvme_rdma_get_max_fr_pages(ibdev, queue->pi_support) + 1;
 	ret = ib_mr_pool_init(queue->qp, &queue->qp->rdma_mrs,
 			      queue->queue_size,
 			      IB_MR_TYPE_MEM_REG,
@@ -499,10 +527,24 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 		goto out_destroy_ring;
 	}
 
+	if (queue->pi_support) {
+		ret = ib_mr_pool_init(queue->qp, &queue->qp->sig_mrs,
+				      queue->queue_size, IB_MR_TYPE_INTEGRITY,
+				      pages_per_mr, pages_per_mr);
+		if (ret) {
+			dev_err(queue->ctrl->ctrl.device,
+				"failed to initialize PI MR pool sized %d for QID %d\n",
+				queue->queue_size, idx);
+			goto out_destroy_mr_pool;
+		}
+	}
+
 	set_bit(NVME_RDMA_Q_TR_READY, &queue->flags);
 
 	return 0;
 
+out_destroy_mr_pool:
+	ib_mr_pool_destroy(queue->qp, &queue->qp->rdma_mrs);
 out_destroy_ring:
 	nvme_rdma_free_ring(ibdev, queue->rsp_ring, queue->queue_size,
 			    sizeof(struct nvme_completion), DMA_FROM_DEVICE);
@@ -524,6 +566,7 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 
 	queue = &ctrl->queues[idx];
 	queue->ctrl = ctrl;
+	queue->pi_support = idx && ctrl->pi_support;
 	init_completion(&queue->cm_done);
 
 	if (idx > 0)
@@ -733,8 +776,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 		set->reserved_tags = 2; /* connect + keep-alive */
 		set->numa_node = nctrl->numa_node;
-		set->cmd_size = sizeof(struct nvme_rdma_request) +
-			NVME_INLINE_SG_CNT * sizeof(struct scatterlist);
+		set->cmd_size = nvme_rdma_cmd_size(false);
 		set->driver_data = ctrl;
 		set->nr_hw_queues = 1;
 		set->timeout = ADMIN_TIMEOUT;
@@ -747,8 +789,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->reserved_tags = 1; /* fabric connect */
 		set->numa_node = nctrl->numa_node;
 		set->flags = BLK_MQ_F_SHOULD_MERGE;
-		set->cmd_size = sizeof(struct nvme_rdma_request) +
-			NVME_INLINE_SG_CNT * sizeof(struct scatterlist);
+		set->cmd_size = nvme_rdma_cmd_size(ctrl->pi_support);
 		set->driver_data = ctrl;
 		set->nr_hw_queues = nctrl->queue_count - 1;
 		set->timeout = NVME_IO_TIMEOUT;
@@ -790,7 +831,21 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	ctrl->device = ctrl->queues[0].device;
 	ctrl->ctrl.numa_node = dev_to_node(ctrl->device->dev->dma_device);
 
-	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev);
+	/* T10-PI support */
+	if (ctrl->ctrl.opts->pi_enable) {
+		if (!(ctrl->device->dev->attrs.device_cap_flags &
+		      IB_DEVICE_INTEGRITY_HANDOVER)) {
+			dev_warn(ctrl->ctrl.device,
+				 "T10-PI requested but not supported on %s, continue without T10-PI\n",
+				 ctrl->device->dev->name);
+			ctrl->ctrl.opts->pi_enable = false;
+		} else {
+			ctrl->pi_support = true;
+		}
+	}
+
+	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev,
+							ctrl->pi_support);
 
 	/*
 	 * Bind the async event SQE DMA mapping to the admin queue lifetime.
@@ -832,6 +887,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	ctrl->ctrl.max_segments = ctrl->max_fr_pages;
 	ctrl->ctrl.max_hw_sectors = ctrl->max_fr_pages << (ilog2(SZ_4K) - 9);
+	if (ctrl->pi_support)
+		ctrl->ctrl.max_integrity_segments = ctrl->max_fr_pages;
 
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 
@@ -1157,8 +1214,19 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 	if (!blk_rq_nr_phys_segments(rq))
 		return;
 
+	if (blk_integrity_rq(rq)) {
+		ib_dma_unmap_sg(ibdev, req->pi_sgl->sg_table.sgl,
+				req->pi_sgl->nents, rq_dma_dir(rq));
+		sg_free_table_chained(&req->pi_sgl->sg_table,
+				      NVME_INLINE_PROT_SG_CNT);
+	}
+
 	if (req->mr) {
-		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);
+		if (req->use_pi)
+			ib_mr_pool_put(queue->qp, &queue->qp->sig_mrs, req->mr);
+		else
+			ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs,
+				       req->mr);
 		req->mr = NULL;
 	}
 
@@ -1215,34 +1283,112 @@ static int nvme_rdma_map_sg_single(struct nvme_rdma_queue *queue,
 	return 0;
 }
 
-static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
-		struct nvme_rdma_request *req, struct nvme_command *c,
-		int count)
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+static void nvme_rdma_set_sig_domain(struct blk_integrity *bi,
+		struct nvme_command *cmd, struct ib_sig_domain *domain,
+		u16 control)
 {
-	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
-	int nr;
-
-	req->mr = ib_mr_pool_get(queue->qp, &queue->qp->rdma_mrs);
-	if (WARN_ON_ONCE(!req->mr))
-		return -EAGAIN;
+	domain->sig_type = IB_SIG_TYPE_T10_DIF;
+	domain->sig.dif.bg_type = IB_T10DIF_CRC;
+	domain->sig.dif.pi_interval = 1 << bi->interval_exp;
+	domain->sig.dif.ref_tag = le32_to_cpu(cmd->rw.reftag);
 
 	/*
-	 * Align the MR to a 4K page size to match the ctrl page size and
-	 * the block virtual boundary.
+	 * At the moment we hard code those, but in the future
+	 * we will take them from cmd.
 	 */
-	nr = ib_map_mr_sg(req->mr, req->data_sgl.sg_table.sgl, count, NULL,
-			  SZ_4K);
-	if (unlikely(nr < count)) {
-		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);
-		req->mr = NULL;
-		if (nr < 0)
-			return nr;
-		return -EINVAL;
+	domain->sig.dif.apptag_check_mask = 0xffff;
+	domain->sig.dif.app_escape = true;
+	domain->sig.dif.ref_escape = true;
+	if (control & NVME_RW_PRINFO_PRCHK_REF)
+		domain->sig.dif.ref_remap = true;
+}
+
+static void nvme_rdma_set_sig_attrs(struct blk_integrity *bi,
+		struct nvme_command *cmd, struct ib_sig_attrs *sig_attrs)
+{
+	u16 control = le16_to_cpu(cmd->rw.control);
+
+	WARN_ON(bi == NULL);
+
+	memset(sig_attrs, 0, sizeof(*sig_attrs));
+
+	if (control & NVME_RW_PRINFO_PRACT) {
+		/* for WRITE_INSERT/READ_STRIP no memory domain */
+		sig_attrs->mem.sig_type = IB_SIG_TYPE_NONE;
+		nvme_rdma_set_sig_domain(bi, cmd, &sig_attrs->wire, control);
+		/* Clear the PRACT bit since HCA will generate/verify the PI */
+		control &= ~NVME_RW_PRINFO_PRACT;
+		cmd->rw.control = cpu_to_le16(control);
+	} else {
+		/* for WRITE_PASS/READ_PASS both wire/memory domains exist */
+		nvme_rdma_set_sig_domain(bi, cmd, &sig_attrs->wire, control);
+		nvme_rdma_set_sig_domain(bi, cmd, &sig_attrs->mem, control);
 	}
+}
+
+static void nvme_rdma_set_prot_checks(struct nvme_command *cmd, u8 *mask)
+{
+	*mask = 0;
+	if (le16_to_cpu(cmd->rw.control) & NVME_RW_PRINFO_PRCHK_REF)
+		*mask |= IB_SIG_CHECK_REFTAG;
+	if (le16_to_cpu(cmd->rw.control) & NVME_RW_PRINFO_PRCHK_GUARD)
+		*mask |= IB_SIG_CHECK_GUARD;
+}
+
+static void nvme_rdma_sig_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	if (unlikely(wc->status != IB_WC_SUCCESS))
+		nvme_rdma_wr_error(cq, wc, "SIG");
+}
+
+static void nvme_rdma_set_pi_wr(struct nvme_rdma_request *req,
+				struct nvme_command *c)
+{
+	struct ib_sig_attrs *sig_attrs = req->mr->sig_attrs;
+	struct ib_reg_wr *wr = &req->reg_wr;
+	struct request *rq = blk_mq_rq_from_pdu(req);
+	struct bio *bio = rq->bio;
+	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
+
+	nvme_rdma_set_sig_attrs(blk_get_integrity(bio->bi_disk), c, sig_attrs);
+
+	nvme_rdma_set_prot_checks(c, &sig_attrs->check_mask);
 
 	ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
 
+	req->reg_cqe.done = nvme_rdma_sig_done;
+
+	memset(wr, 0, sizeof(*wr));
+	wr->wr.opcode = IB_WR_REG_MR_INTEGRITY;
+	wr->wr.wr_cqe = &req->reg_cqe;
+	wr->wr.num_sge = 0;
+	wr->wr.send_flags = 0;
+	wr->mr = req->mr;
+	wr->key = req->mr->rkey;
+	wr->access = IB_ACCESS_LOCAL_WRITE |
+		     IB_ACCESS_REMOTE_READ |
+		     IB_ACCESS_REMOTE_WRITE;
+
+	sg->addr = cpu_to_le64(req->mr->iova);
+	put_unaligned_le24(req->mr->length, sg->length);
+	put_unaligned_le32(req->mr->rkey, sg->key);
+	sg->type = (NVME_KEY_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_INVALIDATE;
+}
+#else
+static void nvme_rdma_set_pi_wr(struct nvme_rdma_request *req,
+				struct nvme_command *c)
+{
+}
+#endif /* CONFIG_BLK_DEV_INTEGRITY */
+
+static void nvme_rdma_set_reg_wr(struct nvme_rdma_request *req,
+				 struct nvme_command *c)
+{
+	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
+
 	req->reg_cqe.done = nvme_rdma_memreg_done;
+
 	memset(&req->reg_wr, 0, sizeof(req->reg_wr));
 	req->reg_wr.wr.opcode = IB_WR_REG_MR;
 	req->reg_wr.wr.wr_cqe = &req->reg_cqe;
@@ -1258,8 +1404,52 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
 	put_unaligned_le32(req->mr->rkey, sg->key);
 	sg->type = (NVME_KEY_SGL_FMT_DATA_DESC << 4) |
 			NVME_SGL_FMT_INVALIDATE;
+}
+
+static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
+		struct nvme_rdma_request *req, struct nvme_command *c,
+		int count, int pi_count)
+{
+	struct nvme_rdma_sgl *sgl = &req->data_sgl;
+	int nr;
+
+	if (req->use_pi) {
+		req->mr = ib_mr_pool_get(queue->qp, &queue->qp->sig_mrs);
+		if (WARN_ON_ONCE(!req->mr))
+			return -EAGAIN;
+
+		nr = ib_map_mr_sg_pi(req->mr, sgl->sg_table.sgl, count, 0,
+				     req->pi_sgl->sg_table.sgl, pi_count, 0,
+				     SZ_4K);
+		if (unlikely(nr))
+			goto mr_put;
+
+		nvme_rdma_set_pi_wr(req, c);
+	} else {
+		req->mr = ib_mr_pool_get(queue->qp, &queue->qp->rdma_mrs);
+		if (WARN_ON_ONCE(!req->mr))
+			return -EAGAIN;
+		/*
+		 * Align the MR to a 4K page size to match the ctrl page size
+		 * and the block virtual boundary.
+		 */
+		nr = ib_map_mr_sg(req->mr, sgl->sg_table.sgl, count, 0, SZ_4K);
+		if (unlikely(nr < count))
+			goto mr_put;
+
+		nvme_rdma_set_reg_wr(req, c);
+	}
 
 	return 0;
+mr_put:
+	if (req->use_pi)
+		ib_mr_pool_put(queue->qp, &queue->qp->sig_mrs, req->mr);
+	else
+		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);
+	req->mr = NULL;
+	if (nr < 0)
+		return nr;
+	return -EINVAL;
 }
 
 static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
@@ -1268,6 +1458,7 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_rdma_device *dev = queue->device;
 	struct ib_device *ibdev = dev->dev;
+	int pi_count = 0;
 	int count, ret;
 
 	req->num_sge = 1;
@@ -1295,7 +1486,30 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 		goto out_free_table;
 	}
 
-	if (count <= dev->num_inline_segments) {
+	if (blk_integrity_rq(rq)) {
+		memset(req->pi_sgl, 0, sizeof(struct nvme_rdma_sgl));
+		req->pi_sgl->sg_table.sgl =
+			(struct scatterlist *)(req->pi_sgl + 1);
+		ret = sg_alloc_table_chained(&req->pi_sgl->sg_table,
+				blk_rq_count_integrity_sg(rq->q, rq->bio),
+				req->pi_sgl->sg_table.sgl,
+				NVME_INLINE_PROT_SG_CNT);
+		if (unlikely(ret)) {
+			ret = -ENOMEM;
+			goto out_unmap_sg;
+		}
+
+		req->pi_sgl->nents = blk_rq_map_integrity_sg(rq->q, rq->bio,
+					req->pi_sgl->sg_table.sgl);
+		pi_count = ib_dma_map_sg(ibdev, req->pi_sgl->sg_table.sgl,
+					 req->pi_sgl->nents, rq_dma_dir(rq));
+		if (unlikely(pi_count <= 0)) {
+			ret = -EIO;
+			goto out_free_pi_table;
+		}
+	}
+
+	if (count <= dev->num_inline_segments && !req->use_pi) {
 		if (rq_data_dir(rq) == WRITE && nvme_rdma_queue_idx(queue) &&
 		    queue->ctrl->use_inline_data &&
 		    blk_rq_payload_bytes(rq) <=
@@ -1310,13 +1524,21 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 		}
 	}
 
-	ret = nvme_rdma_map_sg_fr(queue, req, c, count);
+	ret = nvme_rdma_map_sg_fr(queue, req, c, count, pi_count);
 out:
 	if (unlikely(ret))
-		goto out_unmap_sg;
+		goto out_unmap_pi_sg;
 
 	return 0;
 
+out_unmap_pi_sg:
+	if (blk_integrity_rq(rq))
+		ib_dma_unmap_sg(ibdev, req->pi_sgl->sg_table.sgl,
+				req->pi_sgl->nents, rq_dma_dir(rq));
+out_free_pi_table:
+	if (blk_integrity_rq(rq))
+		sg_free_table_chained(&req->pi_sgl->sg_table,
+				      NVME_INLINE_PROT_SG_CNT);
 out_unmap_sg:
 	ib_dma_unmap_sg(ibdev, req->data_sgl.sg_table.sgl, req->data_sgl.nents,
 			rq_dma_dir(rq));
@@ -1769,6 +1991,8 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(rq);
 
+	req->use_pi = queue->pi_support && nvme_req(rq)->has_pi;
+
 	err = nvme_rdma_map_data(queue, rq, c);
 	if (unlikely(err < 0)) {
 		dev_err(queue->ctrl->ctrl.device,
@@ -1809,12 +2033,50 @@ static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx)
 	return ib_process_cq_direct(queue->ib_cq, -1);
 }
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+static void nvme_rdma_check_pi_status(struct nvme_rdma_request *req)
+{
+	struct request *rq = blk_mq_rq_from_pdu(req);
+	struct ib_mr_status mr_status;
+	int ret;
+
+	ret = ib_check_mr_status(req->mr, IB_MR_CHECK_SIG_STATUS, &mr_status);
+	if (ret) {
+		pr_err("ib_check_mr_status failed, ret %d\n", ret);
+		nvme_req(rq)->status = NVME_SC_INVALID_PI;
+		return;
+	}
+
+	if (mr_status.fail_status & IB_MR_CHECK_SIG_STATUS) {
+		switch (mr_status.sig_err.err_type) {
+		case IB_SIG_BAD_GUARD:
+			nvme_req(rq)->status = NVME_SC_GUARD_CHECK;
+			break;
+		case IB_SIG_BAD_REFTAG:
+			nvme_req(rq)->status = NVME_SC_REFTAG_CHECK;
+			break;
+		case IB_SIG_BAD_APPTAG:
+			nvme_req(rq)->status = NVME_SC_APPTAG_CHECK;
+			break;
+		}
+		pr_err("PI error found type %d expected 0x%x vs actual 0x%x\n",
+		       mr_status.sig_err.err_type, mr_status.sig_err.expected,
+		       mr_status.sig_err.actual);
+	}
+}
+#endif
+
 static void nvme_rdma_complete_rq(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_rdma_queue *queue = req->queue;
 	struct ib_device *ibdev = queue->device->dev;
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	if (req->use_pi)
+		nvme_rdma_check_pi_status(req);
+#endif
+
 	nvme_rdma_unmap_data(queue, rq);
 	ib_dma_unmap_single(ibdev, req->sqe.dma, sizeof(struct nvme_command),
 			    DMA_TO_DEVICE);
@@ -1934,7 +2196,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.name			= "rdma",
 	.module			= THIS_MODULE,
-	.flags			= NVME_F_FABRICS,
+	.flags			= NVME_F_FABRICS | NVME_F_METADATA_SUPPORTED,
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
@@ -2078,7 +2340,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
-			  NVMF_OPT_TOS,
+			  NVMF_OPT_TOS | NVMF_OPT_PI_ENABLE,
 	.create_ctrl	= nvme_rdma_create_ctrl,
 };
 
-- 
1.8.3.1

