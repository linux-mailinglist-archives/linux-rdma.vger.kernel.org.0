Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C09CA3D16D
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 17:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391832AbfFKPxL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 11:53:11 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33119 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391827AbfFKPxK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 11:53:10 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 11 Jun 2019 18:53:00 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x5BFqxLC023036;
        Tue, 11 Jun 2019 18:53:00 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     maxg@mellanox.com, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 10/21] RDMA/mlx5: Introduce and implement new IB_WR_REG_MR_INTEGRITY work request
Date:   Tue, 11 Jun 2019 18:52:46 +0300
Message-Id: <1560268377-26560-11-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
References: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This new WR will be used to perform PI (protection information) handover
using the new API. Using the new API, the user will post a single WR that
will internally perform all the needed actions to complete PI operation.
This new WR will use a memory region that was allocated as
IB_MR_TYPE_INTEGRITY and was mapped using ib_map_mr_sg_pi to perform the
registration. In the old API, in order to perform a signature handover
operation, each ULP should perform the following:
1. Map and register the data buffers.
2. Map and register the protection buffers.
3. Post a special reg WR to configure the signature handover operation
   layout.
4. Invalidate the signature memory key.
5. Invalidate protection buffers memory key.
6. Invalidate data buffers memory key.

In the new API, the mapping of both data and protection buffers is
performed using a single call to ib_map_mr_sg_pi function. Also the
registration of the buffers and the configuration of the signature
operation layout is done by a single new work request called
IB_WR_REG_MR_INTEGRITY.
This patch implements this operation for mlx5 devices that are capable to
offload data integrity generation/validation while performing the actual
buffer transfer.
This patch will not remove the old signature API that is used by the iSER
initiator and target drivers. This will be done in the future.

In the internal implementation, for each IB_WR_REG_MR_INTEGRITY work
request, we are using a single UMR operation to register both data and
protection buffers using KLM's.
Afterwards, another UMR operation will describe the strided block format.
These will be followed by 2 SET_PSV operations to set the memory/wire
domains initial signature parameters passed by the user.
In the end of the whole transaction, only the signature memory key
(the one that exposed for the RDMA operation) will be invalidated.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/infiniband/hw/mlx5/qp.c | 218 ++++++++++++++++++++++++++++++++++++----
 include/linux/mlx5/qp.h         |   3 +-
 include/rdma/ib_verbs.h         |   1 +
 3 files changed, 201 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 65d82e40871c..7c9fd335d43d 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4172,7 +4172,7 @@ static __be64 sig_mkey_mask(void)
 static void set_reg_umr_seg(struct mlx5_wqe_umr_ctrl_seg *umr,
 			    struct mlx5_ib_mr *mr, u8 flags)
 {
-	int size = mr->ndescs * mr->desc_size;
+	int size = (mr->ndescs + mr->meta_ndescs) * mr->desc_size;
 
 	memset(umr, 0, sizeof(*umr));
 
@@ -4303,7 +4303,7 @@ static void set_reg_mkey_seg(struct mlx5_mkey_seg *seg,
 			     struct mlx5_ib_mr *mr,
 			     u32 key, int access)
 {
-	int ndescs = ALIGN(mr->ndescs, 8) >> 1;
+	int ndescs = ALIGN(mr->ndescs + mr->meta_ndescs, 8) >> 1;
 
 	memset(seg, 0, sizeof(*seg));
 
@@ -4354,7 +4354,7 @@ static void set_reg_data_seg(struct mlx5_wqe_data_seg *dseg,
 			     struct mlx5_ib_mr *mr,
 			     struct mlx5_ib_pd *pd)
 {
-	int bcount = mr->desc_size * mr->ndescs;
+	int bcount = mr->desc_size * (mr->ndescs + mr->meta_ndescs);
 
 	dseg->addr = cpu_to_be64(mr->desc_map);
 	dseg->byte_count = cpu_to_be32(ALIGN(bcount, 64));
@@ -4547,23 +4547,52 @@ static int mlx5_set_bsf(struct ib_mr *sig_mr,
 	return 0;
 }
 
-static int set_sig_data_segment(const struct ib_sig_handover_wr *wr,
-				struct mlx5_ib_qp *qp, void **seg,
-				int *size, void **cur_edge)
+static int set_sig_data_segment(const struct ib_send_wr *send_wr,
+				struct ib_mr *sig_mr,
+				struct ib_sig_attrs *sig_attrs,
+				struct mlx5_ib_qp *qp, void **seg, int *size,
+				void **cur_edge)
 {
-	struct ib_sig_attrs *sig_attrs = wr->sig_attrs;
-	struct ib_mr *sig_mr = wr->sig_mr;
 	struct mlx5_bsf *bsf;
-	u32 data_len = wr->wr.sg_list->length;
-	u32 data_key = wr->wr.sg_list->lkey;
-	u64 data_va = wr->wr.sg_list->addr;
+	u32 data_len;
+	u32 data_key;
+	u64 data_va;
+	u32 prot_len = 0;
+	u32 prot_key = 0;
+	u64 prot_va = 0;
+	bool prot = false;
 	int ret;
 	int wqe_size;
 
-	if (!wr->prot ||
-	    (data_key == wr->prot->lkey &&
-	     data_va == wr->prot->addr &&
-	     data_len == wr->prot->length)) {
+	if (send_wr->opcode == IB_WR_REG_SIG_MR) {
+		const struct ib_sig_handover_wr *wr = sig_handover_wr(send_wr);
+
+		data_len = wr->wr.sg_list->length;
+		data_key = wr->wr.sg_list->lkey;
+		data_va = wr->wr.sg_list->addr;
+		if (wr->prot) {
+			prot_len = wr->prot->length;
+			prot_key = wr->prot->lkey;
+			prot_va = wr->prot->addr;
+			prot = true;
+		}
+	} else {
+		struct mlx5_ib_mr *mr = to_mmr(sig_mr);
+		struct mlx5_ib_mr *pi_mr = mr->pi_mr;
+
+		data_len = pi_mr->data_length;
+		data_key = pi_mr->ibmr.lkey;
+		data_va = pi_mr->ibmr.iova;
+		if (pi_mr->meta_ndescs) {
+			prot_len = pi_mr->meta_length;
+			prot_key = pi_mr->ibmr.lkey;
+			prot_va = pi_mr->ibmr.iova + data_len;
+			prot = true;
+		}
+	}
+
+	if (!prot || (data_key == prot_key && data_va == prot_va &&
+		      data_len == prot_len)) {
 		/**
 		 * Source domain doesn't contain signature information
 		 * or data and protection are interleaved in memory.
@@ -4597,8 +4626,6 @@ static int set_sig_data_segment(const struct ib_sig_handover_wr *wr,
 		struct mlx5_stride_block_ctrl_seg *sblock_ctrl;
 		struct mlx5_stride_block_entry *data_sentry;
 		struct mlx5_stride_block_entry *prot_sentry;
-		u32 prot_key = wr->prot->lkey;
-		u64 prot_va = wr->prot->addr;
 		u16 block_size = sig_attrs->mem.sig.dif.pi_interval;
 		int prot_size;
 
@@ -4676,6 +4703,56 @@ static void set_sig_umr_segment(struct mlx5_wqe_umr_ctrl_seg *umr,
 	umr->mkey_mask = sig_mkey_mask();
 }
 
+static int set_pi_umr_wr(const struct ib_send_wr *send_wr,
+			 struct mlx5_ib_qp *qp, void **seg, int *size,
+			 void **cur_edge)
+{
+	const struct ib_reg_wr *wr = reg_wr(send_wr);
+	struct mlx5_ib_mr *sig_mr = to_mmr(wr->mr);
+	struct mlx5_ib_mr *pi_mr = sig_mr->pi_mr;
+	struct ib_sig_attrs *sig_attrs = sig_mr->ibmr.sig_attrs;
+	u32 pdn = get_pd(qp)->pdn;
+	u32 xlt_size;
+	int region_len, ret;
+
+	if (unlikely(send_wr->num_sge != 0) ||
+	    unlikely(wr->access & IB_ACCESS_REMOTE_ATOMIC) ||
+	    unlikely(!sig_mr->sig) || unlikely(!qp->signature_en) ||
+	    unlikely(!sig_mr->sig->sig_status_checked))
+		return -EINVAL;
+
+	/* length of the protected region, data + protection */
+	region_len = pi_mr->ibmr.length;
+
+	/**
+	 * KLM octoword size - if protection was provided
+	 * then we use strided block format (3 octowords),
+	 * else we use single KLM (1 octoword)
+	 **/
+	if (sig_attrs->mem.sig_type != IB_SIG_TYPE_NONE)
+		xlt_size = 0x30;
+	else
+		xlt_size = sizeof(struct mlx5_klm);
+
+	set_sig_umr_segment(*seg, xlt_size);
+	*seg += sizeof(struct mlx5_wqe_umr_ctrl_seg);
+	*size += sizeof(struct mlx5_wqe_umr_ctrl_seg) / 16;
+	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
+
+	set_sig_mkey_segment(*seg, wr->mr, wr->access, xlt_size, region_len,
+			     pdn);
+	*seg += sizeof(struct mlx5_mkey_seg);
+	*size += sizeof(struct mlx5_mkey_seg) / 16;
+	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
+
+	ret = set_sig_data_segment(send_wr, wr->mr, sig_attrs, qp, seg, size,
+				   cur_edge);
+	if (ret)
+		return ret;
+
+	sig_mr->sig->sig_status_checked = false;
+	return 0;
+}
 
 static int set_sig_umr_wr(const struct ib_send_wr *send_wr,
 			  struct mlx5_ib_qp *qp, void **seg, int *size,
@@ -4719,7 +4796,8 @@ static int set_sig_umr_wr(const struct ib_send_wr *send_wr,
 	*size += sizeof(struct mlx5_mkey_seg) / 16;
 	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
 
-	ret = set_sig_data_segment(wr, qp, seg, size, cur_edge);
+	ret = set_sig_data_segment(send_wr, wr->sig_mr, wr->sig_attrs, qp, seg,
+				   size, cur_edge);
 	if (ret)
 		return ret;
 
@@ -4761,7 +4839,7 @@ static int set_reg_wr(struct mlx5_ib_qp *qp,
 {
 	struct mlx5_ib_mr *mr = to_mmr(wr->mr);
 	struct mlx5_ib_pd *pd = to_mpd(qp->ibqp.pd);
-	size_t mr_list_size = mr->ndescs * mr->desc_size;
+	int mr_list_size = (mr->ndescs + mr->meta_ndescs) * mr->desc_size;
 	bool umr_inline = mr_list_size <= MLX5_IB_SQ_UMR_INLINE_THRESHOLD;
 	u8 flags = 0;
 
@@ -4902,8 +4980,11 @@ static int _mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	struct mlx5_wqe_ctrl_seg *ctrl = NULL;  /* compiler warning */
 	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
 	struct mlx5_core_dev *mdev = dev->mdev;
+	struct ib_reg_wr reg_pi_wr;
 	struct mlx5_ib_qp *qp;
 	struct mlx5_ib_mr *mr;
+	struct mlx5_ib_mr *pi_mr;
+	struct ib_sig_attrs *sig_attrs;
 	struct mlx5_wqe_xrc_seg *xrc;
 	struct mlx5_bf *bf;
 	void *cur_edge;
@@ -4957,7 +5038,8 @@ static int _mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 			goto out;
 		}
 
-		if (wr->opcode == IB_WR_REG_MR) {
+		if (wr->opcode == IB_WR_REG_MR ||
+		    wr->opcode == IB_WR_REG_MR_INTEGRITY) {
 			fence = dev->umr_fence;
 			next_fence = MLX5_FENCE_MODE_INITIATOR_SMALL;
 		} else  {
@@ -5015,6 +5097,102 @@ static int _mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 				num_sge = 0;
 				break;
 
+			case IB_WR_REG_MR_INTEGRITY:
+				memset(&reg_pi_wr, 0, sizeof(struct ib_reg_wr));
+
+				mr = to_mmr(reg_wr(wr)->mr);
+				pi_mr = mr->pi_mr;
+
+				reg_pi_wr.mr = &pi_mr->ibmr;
+				reg_pi_wr.access = reg_wr(wr)->access;
+				reg_pi_wr.key = pi_mr->ibmr.rkey;
+
+				qp->sq.wr_data[idx] = IB_WR_REG_MR_INTEGRITY;
+				ctrl->imm = cpu_to_be32(reg_pi_wr.key);
+				/* UMR for data + protection registration */
+				err = set_reg_wr(qp, &reg_pi_wr, &seg, &size,
+						 &cur_edge, false);
+				if (err) {
+					*bad_wr = wr;
+					goto out;
+				}
+				finish_wqe(qp, ctrl, seg, size, cur_edge, idx,
+					   wr->wr_id, nreq, fence,
+					   MLX5_OPCODE_UMR);
+
+				err = begin_wqe(qp, &seg, &ctrl, wr, &idx,
+						&size, &cur_edge, nreq);
+				if (err) {
+					mlx5_ib_warn(dev, "\n");
+					err = -ENOMEM;
+					*bad_wr = wr;
+					goto out;
+				}
+				ctrl->imm = cpu_to_be32(mr->ibmr.rkey);
+				/* UMR for sig MR */
+				err = set_pi_umr_wr(wr, qp, &seg, &size,
+						    &cur_edge);
+				if (err) {
+					mlx5_ib_warn(dev, "\n");
+					*bad_wr = wr;
+					goto out;
+				}
+				finish_wqe(qp, ctrl, seg, size, cur_edge, idx,
+					   wr->wr_id, nreq, fence,
+					   MLX5_OPCODE_UMR);
+
+				/*
+				 * SET_PSV WQEs are not signaled and solicited
+				 * on error
+				 */
+				sig_attrs = mr->ibmr.sig_attrs;
+				err = __begin_wqe(qp, &seg, &ctrl, wr, &idx,
+						  &size, &cur_edge, nreq, false,
+						  true);
+				if (err) {
+					mlx5_ib_warn(dev, "\n");
+					err = -ENOMEM;
+					*bad_wr = wr;
+					goto out;
+				}
+				err = set_psv_wr(&sig_attrs->mem,
+						 mr->sig->psv_memory.psv_idx,
+						 &seg, &size);
+				if (err) {
+					mlx5_ib_warn(dev, "\n");
+					*bad_wr = wr;
+					goto out;
+				}
+				finish_wqe(qp, ctrl, seg, size, cur_edge, idx,
+					   wr->wr_id, nreq, next_fence,
+					   MLX5_OPCODE_SET_PSV);
+
+				err = __begin_wqe(qp, &seg, &ctrl, wr, &idx,
+						  &size, &cur_edge, nreq, false,
+						  true);
+				if (err) {
+					mlx5_ib_warn(dev, "\n");
+					err = -ENOMEM;
+					*bad_wr = wr;
+					goto out;
+				}
+				err = set_psv_wr(&sig_attrs->wire,
+						 mr->sig->psv_wire.psv_idx,
+						 &seg, &size);
+				if (err) {
+					mlx5_ib_warn(dev, "\n");
+					*bad_wr = wr;
+					goto out;
+				}
+				finish_wqe(qp, ctrl, seg, size, cur_edge, idx,
+					   wr->wr_id, nreq, next_fence,
+					   MLX5_OPCODE_SET_PSV);
+
+				qp->next_fence =
+					MLX5_FENCE_MODE_INITIATOR_SMALL;
+				num_sge = 0;
+				goto skip_psv;
+
 			case IB_WR_REG_SIG_MR:
 				qp->sq.wr_data[idx] = IB_WR_REG_SIG_MR;
 				mr = to_mmr(sig_handover_wr(wr)->sig_mr);
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index 3ba4edbd17a6..08e43cd9e742 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -37,7 +37,8 @@
 #include <linux/mlx5/driver.h>
 
 #define MLX5_INVALID_LKEY	0x100
-#define MLX5_SIG_WQE_SIZE	(MLX5_SEND_WQE_BB * 5)
+/* UMR (3 WQE_BB's) + SIG (3 WQE_BB's) + PSV (mem) + PSV (wire) */
+#define MLX5_SIG_WQE_SIZE	(MLX5_SEND_WQE_BB * 8)
 #define MLX5_DIF_SIZE		8
 #define MLX5_STRIDE_BLOCK_OP	0x400
 #define MLX5_CPY_GRD_MASK	0xc0
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 3ca33bf12b30..8fd13356c12b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1247,6 +1247,7 @@ enum ib_wr_opcode {
 	/* These are kernel only and can not be issued by userspace */
 	IB_WR_REG_MR = 0x20,
 	IB_WR_REG_SIG_MR,
+	IB_WR_REG_MR_INTEGRITY,
 
 	/* reserve values for low level drivers' internal use.
 	 * These values will not be used at all in the ib core layer.
-- 
2.16.3

