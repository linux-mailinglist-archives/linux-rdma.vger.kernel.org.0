Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21201195C43
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2020 18:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgC0RP4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Mar 2020 13:15:56 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:44847 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727655AbgC0RPz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Mar 2020 13:15:55 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 27 Mar 2020 20:15:48 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02RHFjjK004869;
        Fri, 27 Mar 2020 20:15:48 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     idanb@mellanox.com, axboe@kernel.dk, maxg@mellanox.com,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
Subject: [PATCH 17/17] nvmet-rdma: Add metadata/T10-PI support
Date:   Fri, 27 Mar 2020 20:15:45 +0300
Message-Id: <20200327171545.98970-19-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200327171545.98970-1-maxg@mellanox.com>
References: <20200327171545.98970-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For capable HCAs (e.g. ConnectX-5/ConnectX-6) this will allow end-to-end
protection information passthrough and validation for NVMe over RDMA
transport. Metadata support was implemented over the new RDMA signature
verbs API.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/target/rdma.c | 245 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 227 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 9e1b8c6..ec250bd 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -33,6 +33,7 @@
 
 /* Assume mpsmin == device_page_size == 4KB */
 #define NVMET_RDMA_MAX_MDTS			8
+#define NVMET_RDMA_MAX_MD_MDTS			5
 
 struct nvmet_rdma_cmd {
 	struct ib_sge		sge[NVMET_RDMA_MAX_INLINE_SGE + 1];
@@ -57,6 +58,7 @@ struct nvmet_rdma_rsp {
 	struct nvmet_rdma_queue	*queue;
 
 	struct ib_cqe		read_cqe;
+	struct ib_cqe		write_cqe;
 	struct rdma_rw_ctx	rw;
 
 	struct nvmet_req	req;
@@ -132,6 +134,9 @@ struct nvmet_rdma_device {
 static void nvmet_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc);
 static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc);
 static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc);
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc);
+#endif
 static void nvmet_rdma_qp_event(struct ib_event *event, void *priv);
 static void nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue);
 static void nvmet_rdma_free_rsp(struct nvmet_rdma_device *ndev,
@@ -389,6 +394,10 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
 
 	/* Data In / RDMA READ */
 	r->read_cqe.done = nvmet_rdma_read_data_done;
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	/* Data Out / RDMA WRITE */
+	r->write_cqe.done = nvmet_rdma_write_data_done;
+#endif
 	return 0;
 
 out_free_rsp:
@@ -498,6 +507,138 @@ static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *queue)
 	spin_unlock(&queue->rsp_wr_wait_lock);
 }
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+static u16 nvmet_rdma_check_pi_status(struct ib_mr *sig_mr)
+{
+	struct ib_mr_status mr_status;
+	int ret;
+	u16 status = 0;
+
+	ret = ib_check_mr_status(sig_mr, IB_MR_CHECK_SIG_STATUS, &mr_status);
+	if (ret) {
+		pr_err("ib_check_mr_status failed, ret %d\n", ret);
+		return NVME_SC_INVALID_PI;
+	}
+
+	if (mr_status.fail_status & IB_MR_CHECK_SIG_STATUS) {
+		switch (mr_status.sig_err.err_type) {
+		case IB_SIG_BAD_GUARD:
+			status = NVME_SC_GUARD_CHECK;
+			break;
+		case IB_SIG_BAD_REFTAG:
+			status = NVME_SC_REFTAG_CHECK;
+			break;
+		case IB_SIG_BAD_APPTAG:
+			status = NVME_SC_APPTAG_CHECK;
+			break;
+		}
+		pr_err("PI error found type %d expected 0x%x vs actual 0x%x\n",
+		       mr_status.sig_err.err_type,
+		       mr_status.sig_err.expected,
+		       mr_status.sig_err.actual);
+	}
+
+	return status;
+}
+
+static void nvmet_rdma_set_sig_domain(struct blk_integrity *bi,
+		struct nvme_command *cmd, struct ib_sig_domain *domain,
+		u16 control)
+{
+	domain->sig_type = IB_SIG_TYPE_T10_DIF;
+	domain->sig.dif.bg_type = IB_T10DIF_CRC;
+	domain->sig.dif.pi_interval = 1 << bi->interval_exp;
+	domain->sig.dif.ref_tag = le32_to_cpu(cmd->rw.reftag);
+
+	/*
+	 * At the moment we hard code those, but in the future
+	 * we will take them from cmd.
+	 */
+	domain->sig.dif.apptag_check_mask = 0xffff;
+	domain->sig.dif.app_escape = true;
+	domain->sig.dif.ref_escape = true;
+	if (control & NVME_RW_PRINFO_PRCHK_REF)
+		domain->sig.dif.ref_remap = true;
+}
+
+static void nvmet_rdma_set_sig_attrs(struct nvmet_req *req,
+				     struct ib_sig_attrs *sig_attrs)
+{
+	struct nvme_command *cmd = req->cmd;
+	struct blk_integrity *bi = bdev_get_integrity(req->ns->bdev);
+	u16 control = le16_to_cpu(cmd->rw.control);
+
+	WARN_ON(bi == NULL);
+
+	memset(sig_attrs, 0, sizeof(*sig_attrs));
+
+	if (control & NVME_RW_PRINFO_PRACT) {
+		/* for WRITE_INSERT/READ_STRIP no wire domain */
+		sig_attrs->wire.sig_type = IB_SIG_TYPE_NONE;
+		nvmet_rdma_set_sig_domain(bi, cmd, &sig_attrs->mem, control);
+		/* Clear the PRACT bit since HCA will generate/verify the PI */
+		control &= ~NVME_RW_PRINFO_PRACT;
+		cmd->rw.control = cpu_to_le16(control);
+		/* PI is added by the HW */
+		req->transfer_len += req->md_len;
+	} else {
+		/* for WRITE_PASS/READ_PASS both wire/memory domains exist */
+		nvmet_rdma_set_sig_domain(bi, cmd, &sig_attrs->wire, control);
+		nvmet_rdma_set_sig_domain(bi, cmd, &sig_attrs->mem, control);
+	}
+
+	if (control & NVME_RW_PRINFO_PRCHK_REF)
+		sig_attrs->check_mask |= IB_SIG_CHECK_REFTAG;
+	if (control & NVME_RW_PRINFO_PRCHK_GUARD)
+		sig_attrs->check_mask |= IB_SIG_CHECK_GUARD;
+	if (control & NVME_RW_PRINFO_PRCHK_APP)
+		sig_attrs->check_mask |= IB_SIG_CHECK_APPTAG;
+}
+#else
+static u16 nvmet_rdma_check_pi_status(struct ib_mr *sig_mr)
+{
+	return 0;
+}
+
+static void nvmet_rdma_set_sig_attrs(struct nvmet_req *req,
+				     struct ib_sig_attrs *sig_attrs)
+{
+}
+#endif /* CONFIG_BLK_DEV_INTEGRITY */
+
+static int nvmet_rdma_rw_ctx_init(struct nvmet_rdma_rsp *rsp, u64 addr, u32 key,
+				  struct ib_sig_attrs *sig_attrs)
+{
+	struct rdma_cm_id *cm_id = rsp->queue->cm_id;
+	struct nvmet_req *req = &rsp->req;
+	int ret;
+
+	if (req->use_md)
+		ret = rdma_rw_ctx_signature_init(&rsp->rw, cm_id->qp,
+			cm_id->port_num, req->sg, req->sg_cnt, req->md_sg,
+			req->md_sg_cnt, sig_attrs, addr, key,
+			nvmet_data_dir(req));
+	else
+		ret = rdma_rw_ctx_init(&rsp->rw, cm_id->qp, cm_id->port_num,
+				       req->sg, req->sg_cnt, 0, addr, key,
+				       nvmet_data_dir(req));
+
+	return ret;
+}
+
+static void nvmet_rdma_rw_ctx_destroy(struct nvmet_rdma_rsp *rsp)
+{
+	struct rdma_cm_id *cm_id = rsp->queue->cm_id;
+	struct nvmet_req *req = &rsp->req;
+
+	if (req->use_md)
+		rdma_rw_ctx_destroy_signature(&rsp->rw, cm_id->qp,
+			cm_id->port_num, req->sg, req->sg_cnt, req->md_sg,
+			req->md_sg_cnt, nvmet_data_dir(req));
+	else
+		rdma_rw_ctx_destroy(&rsp->rw, cm_id->qp, cm_id->port_num,
+				    req->sg, req->sg_cnt, nvmet_data_dir(req));
+}
 
 static void nvmet_rdma_release_rsp(struct nvmet_rdma_rsp *rsp)
 {
@@ -505,11 +646,8 @@ static void nvmet_rdma_release_rsp(struct nvmet_rdma_rsp *rsp)
 
 	atomic_add(1 + rsp->n_rdma, &queue->sq_wr_avail);
 
-	if (rsp->n_rdma) {
-		rdma_rw_ctx_destroy(&rsp->rw, queue->cm_id->qp,
-				queue->cm_id->port_num, rsp->req.sg,
-				rsp->req.sg_cnt, nvmet_data_dir(&rsp->req));
-	}
+	if (rsp->n_rdma)
+		nvmet_rdma_rw_ctx_destroy(rsp);
 
 	if (rsp->req.sg != rsp->cmd->inline_sg)
 		nvmet_req_free_sgl(&rsp->req);
@@ -564,11 +702,16 @@ static void nvmet_rdma_queue_response(struct nvmet_req *req)
 		rsp->send_wr.opcode = IB_WR_SEND;
 	}
 
-	if (nvmet_rdma_need_data_out(rsp))
-		first_wr = rdma_rw_ctx_wrs(&rsp->rw, cm_id->qp,
-				cm_id->port_num, NULL, &rsp->send_wr);
-	else
+	if (nvmet_rdma_need_data_out(rsp)) {
+		if (rsp->req.use_md)
+			first_wr = rdma_rw_ctx_wrs(&rsp->rw, cm_id->qp,
+					cm_id->port_num, &rsp->write_cqe, NULL);
+		else
+			first_wr = rdma_rw_ctx_wrs(&rsp->rw, cm_id->qp,
+					cm_id->port_num, NULL, &rsp->send_wr);
+	} else {
 		first_wr = &rsp->send_wr;
+	}
 
 	nvmet_rdma_post_recv(rsp->queue->dev, rsp->cmd);
 
@@ -587,15 +730,14 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct nvmet_rdma_rsp *rsp =
 		container_of(wc->wr_cqe, struct nvmet_rdma_rsp, read_cqe);
 	struct nvmet_rdma_queue *queue = cq->cq_context;
+	u16 status = 0;
 
 	WARN_ON(rsp->n_rdma <= 0);
 	atomic_add(rsp->n_rdma, &queue->sq_wr_avail);
-	rdma_rw_ctx_destroy(&rsp->rw, queue->cm_id->qp,
-			queue->cm_id->port_num, rsp->req.sg,
-			rsp->req.sg_cnt, nvmet_data_dir(&rsp->req));
 	rsp->n_rdma = 0;
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
+		nvmet_rdma_rw_ctx_destroy(rsp);
 		nvmet_req_uninit(&rsp->req);
 		nvmet_rdma_release_rsp(rsp);
 		if (wc->status != IB_WC_WR_FLUSH_ERR) {
@@ -606,9 +748,59 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 		return;
 	}
 
-	rsp->req.execute(&rsp->req);
+	if (rsp->req.use_md)
+		status = nvmet_rdma_check_pi_status(rsp->rw.reg->mr);
+	nvmet_rdma_rw_ctx_destroy(rsp);
+
+	if (unlikely(status))
+		nvmet_req_complete(&rsp->req, status);
+	else
+		rsp->req.execute(&rsp->req);
 }
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	struct nvmet_rdma_rsp *rsp =
+		container_of(wc->wr_cqe, struct nvmet_rdma_rsp, write_cqe);
+	struct nvmet_rdma_queue *queue = cq->cq_context;
+	struct rdma_cm_id *cm_id = rsp->queue->cm_id;
+	u16 status;
+
+	WARN_ON(rsp->n_rdma <= 0);
+	atomic_add(rsp->n_rdma, &queue->sq_wr_avail);
+	rsp->n_rdma = 0;
+
+	if (unlikely(wc->status != IB_WC_SUCCESS)) {
+		nvmet_rdma_rw_ctx_destroy(rsp);
+		nvmet_req_uninit(&rsp->req);
+		nvmet_rdma_release_rsp(rsp);
+		if (wc->status != IB_WC_WR_FLUSH_ERR) {
+			pr_info("RDMA WRITE for CQE 0x%p failed with status %s (%d).\n",
+				wc->wr_cqe, ib_wc_status_msg(wc->status),
+				wc->status);
+			nvmet_rdma_error_comp(queue);
+		}
+		return;
+	}
+
+	/*
+	 * Upon RDMA completion check the signature status
+	 * - if succeeded send good NVMe response
+	 * - if failed send bad NVMe response with appropriate error
+	 */
+	status = nvmet_rdma_check_pi_status(rsp->rw.reg->mr);
+	if (unlikely(status))
+		rsp->req.cqe->status = cpu_to_le16(status << 1);
+	nvmet_rdma_rw_ctx_destroy(rsp);
+
+	if (unlikely(ib_post_send(cm_id->qp, &rsp->send_wr, NULL))) {
+		pr_err("sending cmd response failed\n");
+		nvmet_rdma_release_rsp(rsp);
+	}
+}
+#endif /* CONFIG_BLK_DEV_INTEGRITY */
+
 static void nvmet_rdma_use_inline_sg(struct nvmet_rdma_rsp *rsp, u32 len,
 		u64 off)
 {
@@ -663,9 +855,9 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
 static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
 		struct nvme_keyed_sgl_desc *sgl, bool invalidate)
 {
-	struct rdma_cm_id *cm_id = rsp->queue->cm_id;
 	u64 addr = le64_to_cpu(sgl->addr);
 	u32 key = get_unaligned_le32(sgl->key);
+	struct ib_sig_attrs sig_attrs;
 	int ret;
 
 	rsp->req.transfer_len = get_unaligned_le24(sgl->length);
@@ -674,13 +866,14 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
 	if (!rsp->req.transfer_len)
 		return 0;
 
+	if (rsp->req.use_md)
+		nvmet_rdma_set_sig_attrs(&rsp->req, &sig_attrs);
+
 	ret = nvmet_req_alloc_sgl(&rsp->req);
 	if (unlikely(ret < 0))
 		goto error_out;
 
-	ret = rdma_rw_ctx_init(&rsp->rw, cm_id->qp, cm_id->port_num,
-			rsp->req.sg, rsp->req.sg_cnt, 0, addr, key,
-			nvmet_data_dir(&rsp->req));
+	ret = nvmet_rdma_rw_ctx_init(rsp, addr, key, &sig_attrs);
 	if (unlikely(ret < 0))
 		goto error_out;
 	rsp->n_rdma += ret;
@@ -959,6 +1152,9 @@ static void nvmet_rdma_free_dev(struct kref *ref)
 			goto out_free_pd;
 	}
 
+	port->pi_capable = ndev->device->attrs.device_cap_flags &
+			IB_DEVICE_INTEGRITY_HANDOVER ? true : false;
+
 	list_add(&ndev->entry, &device_list);
 out_unlock:
 	mutex_unlock(&device_list_mutex);
@@ -1025,6 +1221,10 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 		qp_attr.cap.max_recv_sge = 1 + ndev->inline_page_count;
 	}
 
+	if (queue->port->pi_capable && queue->port->pi_enable &&
+	    queue->host_qid)
+		qp_attr.create_flags |= IB_QP_CREATE_INTEGRITY_EN;
+
 	ret = rdma_create_qp(queue->cm_id, ndev->pd, &qp_attr);
 	if (ret) {
 		pr_err("failed to create_qp ret= %d\n", ret);
@@ -1169,6 +1369,7 @@ static int nvmet_rdma_cm_reject(struct rdma_cm_id *cm_id,
 	INIT_WORK(&queue->release_work, nvmet_rdma_release_queue_work);
 	queue->dev = ndev;
 	queue->cm_id = cm_id;
+	queue->port = cm_id->context;
 
 	spin_lock_init(&queue->state_lock);
 	queue->state = NVMET_RDMA_Q_CONNECTING;
@@ -1287,7 +1488,6 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 		ret = -ENOMEM;
 		goto put_device;
 	}
-	queue->port = cm_id->context;
 
 	if (queue->host_qid == 0) {
 		/* Let inflight controller teardown complete */
@@ -1609,6 +1809,15 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 
 static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
 {
+	struct nvmet_port *port = ctrl->port;
+	struct rdma_cm_id *cm_id = port->priv;
+
+	if (ctrl->pi_support) {
+		u32 max_pages = rdma_rw_fr_page_list_len(cm_id->device, true);
+
+		return min(ilog2(max_pages), NVMET_RDMA_MAX_MD_MDTS);
+	}
+
 	return NVMET_RDMA_MAX_MDTS;
 }
 
-- 
1.8.3.1

