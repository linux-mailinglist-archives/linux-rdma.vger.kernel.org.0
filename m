Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02FFC2FC48
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 15:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfE3NZw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 09:25:52 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:35109 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726716AbfE3NZw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 09:25:52 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 30 May 2019 16:25:34 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x4UDPVZj007883;
        Thu, 30 May 2019 16:25:33 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, sagi@grimberg.me, hch@lst.de,
        bvanassche@acm.org
Cc:     maxg@mellanox.com, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 17/20] RDMA/core: Remove unused IB_WR_REG_SIG_MR code
Date:   Thu, 30 May 2019 16:25:28 +0300
Message-Id: <1559222731-16715-18-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

IB_WR_REG_SIG_MR is not needed after IB_WR_REG_MR_INTEGRITY
was used.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mr.c           |  15 ++-
 drivers/infiniband/hw/mlx5/qp.c           | 154 ++----------------------------
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h |   2 +-
 include/rdma/ib_verbs.h                   |  19 ----
 4 files changed, 17 insertions(+), 173 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 6820d80c6a7f..3b29de88c729 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1760,8 +1760,7 @@ static struct ib_mr *__mlx5_ib_alloc_mr(struct ib_pd *pd,
 			goto err_free_in;
 		mr->desc_size = sizeof(struct mlx5_klm);
 		mr->max_descs = ndescs;
-	} else if (mr_type == IB_MR_TYPE_SIGNATURE ||
-		   mr_type == IB_MR_TYPE_INTEGRITY) {
+	} else if (mr_type == IB_MR_TYPE_INTEGRITY) {
 		u32 psv_index[2];
 
 		MLX5_SET(mkc, mkc, bsf_en, 1);
@@ -1787,13 +1786,11 @@ static struct ib_mr *__mlx5_ib_alloc_mr(struct ib_pd *pd,
 		mr->sig->sig_err_exists = false;
 		/* Next UMR, Arm SIGERR */
 		++mr->sig->sigerr_count;
-		if (mr_type == IB_MR_TYPE_INTEGRITY) {
-			mr->pi_mr = mlx5_ib_alloc_pi_mr(pd, max_num_sg,
-							max_num_meta_sg);
-			if (IS_ERR(mr->pi_mr)) {
-				err = PTR_ERR(mr->pi_mr);
-				goto err_destroy_psv;
-			}
+		mr->pi_mr = mlx5_ib_alloc_pi_mr(pd, max_num_sg,
+						max_num_meta_sg);
+		if (IS_ERR(mr->pi_mr)) {
+			err = PTR_ERR(mr->pi_mr);
+			goto err_destroy_psv;
 		}
 	} else {
 		mlx5_ib_warn(dev, "Invalid mr type %d\n", mr_type);
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index aa0c39acc4e3..8d65c88601ce 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4560,32 +4560,17 @@ static int set_sig_data_segment(const struct ib_send_wr *send_wr,
 	bool prot = false;
 	int ret;
 	int wqe_size;
+	struct mlx5_ib_mr *mr = to_mmr(sig_mr);
+	struct mlx5_ib_mr *pi_mr = mr->pi_mr;
 
-	if (send_wr->opcode == IB_WR_REG_SIG_MR) {
-		const struct ib_sig_handover_wr *wr = sig_handover_wr(send_wr);
-
-		data_len = wr->wr.sg_list->length;
-		data_key = wr->wr.sg_list->lkey;
-		data_va = wr->wr.sg_list->addr;
-		if (wr->prot) {
-			prot_len = wr->prot->length;
-			prot_key = wr->prot->lkey;
-			prot_va = wr->prot->addr;
-			prot = true;
-		}
-	} else {
-		struct mlx5_ib_mr *mr = to_mmr(sig_mr);
-		struct mlx5_ib_mr *pi_mr = mr->pi_mr;
-
-		data_len = pi_mr->data_length;
-		data_key = pi_mr->ibmr.lkey;
-		data_va = pi_mr->ibmr.iova;
-		if (pi_mr->meta_ndescs) {
-			prot_len = pi_mr->meta_length;
-			prot_key = pi_mr->ibmr.lkey;
-			prot_va = pi_mr->ibmr.iova + data_len;
-			prot = true;
-		}
+	data_len = pi_mr->data_length;
+	data_key = pi_mr->ibmr.lkey;
+	data_va = pi_mr->ibmr.iova;
+	if (pi_mr->meta_ndescs) {
+		prot_len = pi_mr->meta_length;
+		prot_key = pi_mr->ibmr.lkey;
+		prot_va = pi_mr->ibmr.iova + data_len;
+		prot = true;
 	}
 
 	if (!prot || (data_key == prot_key && data_va == prot_va &&
@@ -4751,57 +4736,6 @@ static int set_pi_umr_wr(const struct ib_send_wr *send_wr,
 	return 0;
 }
 
-static int set_sig_umr_wr(const struct ib_send_wr *send_wr,
-			  struct mlx5_ib_qp *qp, void **seg, int *size,
-			  void **cur_edge)
-{
-	const struct ib_sig_handover_wr *wr = sig_handover_wr(send_wr);
-	struct mlx5_ib_mr *sig_mr = to_mmr(wr->sig_mr);
-	u32 pdn = get_pd(qp)->pdn;
-	u32 xlt_size;
-	int region_len, ret;
-
-	if (unlikely(wr->wr.num_sge != 1) ||
-	    unlikely(wr->access_flags & IB_ACCESS_REMOTE_ATOMIC) ||
-	    unlikely(!sig_mr->sig) || unlikely(!qp->ibqp.signature_en) ||
-	    unlikely(!sig_mr->sig->sig_status_checked))
-		return -EINVAL;
-
-	/* length of the protected region, data + protection */
-	region_len = wr->wr.sg_list->length;
-	if (wr->prot &&
-	    (wr->prot->lkey != wr->wr.sg_list->lkey  ||
-	     wr->prot->addr != wr->wr.sg_list->addr  ||
-	     wr->prot->length != wr->wr.sg_list->length))
-		region_len += wr->prot->length;
-
-	/**
-	 * KLM octoword size - if protection was provided
-	 * then we use strided block format (3 octowords),
-	 * else we use single KLM (1 octoword)
-	 **/
-	xlt_size = wr->prot ? 0x30 : sizeof(struct mlx5_klm);
-
-	set_sig_umr_segment(*seg, xlt_size);
-	*seg += sizeof(struct mlx5_wqe_umr_ctrl_seg);
-	*size += sizeof(struct mlx5_wqe_umr_ctrl_seg) / 16;
-	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
-
-	set_sig_mkey_segment(*seg, wr->sig_mr, wr->access_flags, xlt_size,
-			     region_len, pdn);
-	*seg += sizeof(struct mlx5_mkey_seg);
-	*size += sizeof(struct mlx5_mkey_seg) / 16;
-	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
-
-	ret = set_sig_data_segment(send_wr, wr->sig_mr, wr->sig_attrs, qp, seg,
-				   size, cur_edge);
-	if (ret)
-		return ret;
-
-	sig_mr->sig->sig_status_checked = false;
-	return 0;
-}
-
 static int set_psv_wr(struct ib_sig_domain *domain,
 		      u32 psv_idx, void **seg, int *size)
 {
@@ -5190,74 +5124,6 @@ static int _mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 				num_sge = 0;
 				goto skip_psv;
 
-			case IB_WR_REG_SIG_MR:
-				qp->sq.wr_data[idx] = IB_WR_REG_SIG_MR;
-				mr = to_mmr(sig_handover_wr(wr)->sig_mr);
-
-				ctrl->imm = cpu_to_be32(mr->ibmr.rkey);
-				err = set_sig_umr_wr(wr, qp, &seg, &size,
-						     &cur_edge);
-				if (err) {
-					mlx5_ib_warn(dev, "\n");
-					*bad_wr = wr;
-					goto out;
-				}
-
-				finish_wqe(qp, ctrl, seg, size, cur_edge, idx,
-					   wr->wr_id, nreq, fence,
-					   MLX5_OPCODE_UMR);
-				/*
-				 * SET_PSV WQEs are not signaled and solicited
-				 * on error
-				 */
-				err = __begin_wqe(qp, &seg, &ctrl, wr, &idx,
-						  &size, &cur_edge, nreq, false,
-						  true);
-				if (err) {
-					mlx5_ib_warn(dev, "\n");
-					err = -ENOMEM;
-					*bad_wr = wr;
-					goto out;
-				}
-
-				err = set_psv_wr(&sig_handover_wr(wr)->sig_attrs->mem,
-						 mr->sig->psv_memory.psv_idx, &seg,
-						 &size);
-				if (err) {
-					mlx5_ib_warn(dev, "\n");
-					*bad_wr = wr;
-					goto out;
-				}
-
-				finish_wqe(qp, ctrl, seg, size, cur_edge, idx,
-					   wr->wr_id, nreq, fence,
-					   MLX5_OPCODE_SET_PSV);
-				err = __begin_wqe(qp, &seg, &ctrl, wr, &idx,
-						  &size, &cur_edge, nreq, false,
-						  true);
-				if (err) {
-					mlx5_ib_warn(dev, "\n");
-					err = -ENOMEM;
-					*bad_wr = wr;
-					goto out;
-				}
-
-				err = set_psv_wr(&sig_handover_wr(wr)->sig_attrs->wire,
-						 mr->sig->psv_wire.psv_idx, &seg,
-						 &size);
-				if (err) {
-					mlx5_ib_warn(dev, "\n");
-					*bad_wr = wr;
-					goto out;
-				}
-
-				finish_wqe(qp, ctrl, seg, size, cur_edge, idx,
-					   wr->wr_id, nreq, fence,
-					   MLX5_OPCODE_SET_PSV);
-				qp->next_fence = MLX5_FENCE_MODE_INITIATOR_SMALL;
-				num_sge = 0;
-				goto skip_psv;
-
 			default:
 				break;
 			}
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
index 3c633ab58052..c142f5e7f25f 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
@@ -456,7 +456,7 @@ static inline enum pvrdma_wr_opcode ib_wr_opcode_to_pvrdma(enum ib_wr_opcode op)
 		return PVRDMA_WR_MASKED_ATOMIC_CMP_AND_SWP;
 	case IB_WR_MASKED_ATOMIC_FETCH_AND_ADD:
 		return PVRDMA_WR_MASKED_ATOMIC_FETCH_AND_ADD;
-	case IB_WR_REG_SIG_MR:
+	case IB_WR_REG_MR_INTEGRITY:
 		return PVRDMA_WR_REG_SIG_MR;
 	default:
 		return PVRDMA_WR_ERROR;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index a0e6d721143c..427cdff58b56 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -787,9 +787,6 @@ __attribute_const__ int ib_rate_to_mbps(enum ib_rate rate);
  * enum ib_mr_type - memory region type
  * @IB_MR_TYPE_MEM_REG:       memory region that is used for
  *                            normal registration
- * @IB_MR_TYPE_SIGNATURE:     memory region that is used for
- *                            signature operations (data-integrity
- *                            capable regions)
  * @IB_MR_TYPE_SG_GAPS:       memory region that is capable to
  *                            register any arbitrary sg lists (without
  *                            the normal mr constraints - see
@@ -805,7 +802,6 @@ __attribute_const__ int ib_rate_to_mbps(enum ib_rate rate);
  */
 enum ib_mr_type {
 	IB_MR_TYPE_MEM_REG,
-	IB_MR_TYPE_SIGNATURE,
 	IB_MR_TYPE_SG_GAPS,
 	IB_MR_TYPE_DM,
 	IB_MR_TYPE_USER,
@@ -1246,7 +1242,6 @@ enum ib_wr_opcode {
 
 	/* These are kernel only and can not be issued by userspace */
 	IB_WR_REG_MR = 0x20,
-	IB_WR_REG_SIG_MR,
 	IB_WR_REG_MR_INTEGRITY,
 
 	/* reserve values for low level drivers' internal use.
@@ -1357,20 +1352,6 @@ static inline const struct ib_reg_wr *reg_wr(const struct ib_send_wr *wr)
 	return container_of(wr, struct ib_reg_wr, wr);
 }
 
-struct ib_sig_handover_wr {
-	struct ib_send_wr	wr;
-	struct ib_sig_attrs    *sig_attrs;
-	struct ib_mr	       *sig_mr;
-	int			access_flags;
-	struct ib_sge	       *prot;
-};
-
-static inline const struct ib_sig_handover_wr *
-sig_handover_wr(const struct ib_send_wr *wr)
-{
-	return container_of(wr, struct ib_sig_handover_wr, wr);
-}
-
 struct ib_recv_wr {
 	struct ib_recv_wr      *next;
 	union {
-- 
2.16.3

