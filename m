Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219DF1C697C
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 08:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgEFGzb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 02:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgEFGzb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 02:55:31 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4352D206F9;
        Wed,  6 May 2020 06:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588748130;
        bh=P6shAgSrXZqKKxQqtKzAZ+CN6xy8Dv5Bejhr2oTk6Mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r7G7BGwUP0wWIE3z3TVhDwSAGlzN+LqdlOPC5rneKpofIRDjGEqlQajay/ly/sdPX
         hyn0C5otVd/1SywCJRfWZWaYS9+iiKYrmwfPbejJw1LH9rYkJ3NVi+ggftl+i2P6E/
         zXjGED31zBIsXJrzUIIjytaiLI7SDqYQB009s5+s=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/3] RDMA/mlx5: Refactor mlx5_post_send() to improve readability
Date:   Wed,  6 May 2020 09:55:12 +0300
Message-Id: <20200506065513.4668-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506065513.4668-1-leon@kernel.org>
References: <20200506065513.4668-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Max Gurtovoy <maxg@mellanox.com>

Add small helpers in order to avoid code duplication and improve code
readability. Decrease the amount of code in the gigantic post_send
function and divide it to readable methods that will help in code
maintenance in the future.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 490 ++++++++++++++++++--------------
 1 file changed, 276 insertions(+), 214 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index e624886bcf85..1e3dcfd1b230 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -5234,18 +5234,279 @@ static void finish_wqe(struct mlx5_ib_qp *qp,
 			  cur_edge;
 }
 
+static void handle_rdma_op(const struct ib_send_wr *wr, void **seg, int *size)
+{
+	set_raddr_seg(*seg, rdma_wr(wr)->remote_addr, rdma_wr(wr)->rkey);
+	*seg += sizeof(struct mlx5_wqe_raddr_seg);
+	*size += sizeof(struct mlx5_wqe_raddr_seg) / 16;
+}
+
+static void handle_local_inv(struct mlx5_ib_qp *qp, const struct ib_send_wr *wr,
+			     struct mlx5_wqe_ctrl_seg **ctrl, void **seg,
+			     int *size, void **cur_edge, unsigned int idx)
+{
+	qp->sq.wr_data[idx] = IB_WR_LOCAL_INV;
+	(*ctrl)->imm = cpu_to_be32(wr->ex.invalidate_rkey);
+	set_linv_wr(qp, seg, size, cur_edge);
+}
+
+static int handle_reg_mr(struct mlx5_ib_qp *qp, const struct ib_send_wr *wr,
+			 struct mlx5_wqe_ctrl_seg **ctrl, void **seg, int *size,
+			 void **cur_edge, unsigned int idx)
+{
+	qp->sq.wr_data[idx] = IB_WR_REG_MR;
+	(*ctrl)->imm = cpu_to_be32(reg_wr(wr)->key);
+	return set_reg_wr(qp, reg_wr(wr), seg, size, cur_edge, true);
+}
+
+static int handle_psv(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
+		      const struct ib_send_wr *wr,
+		      struct mlx5_wqe_ctrl_seg **ctrl, void **seg, int *size,
+		      void **cur_edge, unsigned int *idx, int nreq,
+		      struct ib_sig_domain *domain, u32 psv_index,
+		      u8 next_fence)
+{
+	int err;
+
+	/*
+	 * SET_PSV WQEs are not signaled and solicited on error.
+	 */
+	err = __begin_wqe(qp, seg, ctrl, wr, idx, size, cur_edge, nreq,
+			  false, true);
+	if (unlikely(err)) {
+		mlx5_ib_warn(dev, "\n");
+		err = -ENOMEM;
+		goto out;
+	}
+	err = set_psv_wr(domain, psv_index, seg, size);
+	if (unlikely(err)) {
+		mlx5_ib_warn(dev, "\n");
+		goto out;
+	}
+	finish_wqe(qp, *ctrl, *seg, *size, *cur_edge, *idx, wr->wr_id, nreq,
+		   next_fence, MLX5_OPCODE_SET_PSV);
+
+out:
+	return err;
+}
+
+static int handle_reg_mr_integrity(struct mlx5_ib_dev *dev,
+		struct mlx5_ib_qp *qp, const struct ib_send_wr *wr,
+		struct mlx5_wqe_ctrl_seg **ctrl, void **seg, int *size,
+		void **cur_edge, unsigned int *idx, int nreq, u8 fence,
+		u8 next_fence)
+{
+	struct mlx5_ib_mr *mr;
+	struct mlx5_ib_mr *pi_mr;
+	struct mlx5_ib_mr pa_pi_mr;
+	struct ib_sig_attrs *sig_attrs;
+	struct ib_reg_wr reg_pi_wr;
+	int err;
+
+	qp->sq.wr_data[*idx] = IB_WR_REG_MR_INTEGRITY;
+
+	mr = to_mmr(reg_wr(wr)->mr);
+	pi_mr = mr->pi_mr;
+
+	if (pi_mr) {
+		memset(&reg_pi_wr, 0,
+		       sizeof(struct ib_reg_wr));
+
+		reg_pi_wr.mr = &pi_mr->ibmr;
+		reg_pi_wr.access = reg_wr(wr)->access;
+		reg_pi_wr.key = pi_mr->ibmr.rkey;
+
+		(*ctrl)->imm = cpu_to_be32(reg_pi_wr.key);
+		/* UMR for data + prot registration */
+		err = set_reg_wr(qp, &reg_pi_wr, seg, size, cur_edge, false);
+		if (unlikely(err))
+			goto out;
+
+		finish_wqe(qp, *ctrl, *seg, *size, *cur_edge, *idx, wr->wr_id,
+			   nreq, fence, MLX5_OPCODE_UMR);
+
+		err = begin_wqe(qp, seg, ctrl, wr, idx, size, cur_edge, nreq);
+		if (unlikely(err)) {
+			mlx5_ib_warn(dev, "\n");
+			err = -ENOMEM;
+			goto out;
+		}
+	} else {
+		memset(&pa_pi_mr, 0, sizeof(struct mlx5_ib_mr));
+		/* No UMR, use local_dma_lkey */
+		pa_pi_mr.ibmr.lkey = mr->ibmr.pd->local_dma_lkey;
+		pa_pi_mr.ndescs = mr->ndescs;
+		pa_pi_mr.data_length = mr->data_length;
+		pa_pi_mr.data_iova = mr->data_iova;
+		if (mr->meta_ndescs) {
+			pa_pi_mr.meta_ndescs = mr->meta_ndescs;
+			pa_pi_mr.meta_length = mr->meta_length;
+			pa_pi_mr.pi_iova = mr->pi_iova;
+		}
+
+		pa_pi_mr.ibmr.length = mr->ibmr.length;
+		mr->pi_mr = &pa_pi_mr;
+	}
+	(*ctrl)->imm = cpu_to_be32(mr->ibmr.rkey);
+	/* UMR for sig MR */
+	err = set_pi_umr_wr(wr, qp, seg, size, cur_edge);
+	if (unlikely(err)) {
+		mlx5_ib_warn(dev, "\n");
+		goto out;
+	}
+	finish_wqe(qp, *ctrl, *seg, *size, *cur_edge, *idx, wr->wr_id, nreq,
+		   fence, MLX5_OPCODE_UMR);
+
+	sig_attrs = mr->ibmr.sig_attrs;
+	err = handle_psv(dev, qp, wr, ctrl, seg, size, cur_edge, idx, nreq,
+			 &sig_attrs->mem, mr->sig->psv_memory.psv_idx,
+			 next_fence);
+	if (unlikely(err))
+		goto out;
+
+	err = handle_psv(dev, qp, wr, ctrl, seg, size, cur_edge, idx, nreq,
+			 &sig_attrs->wire, mr->sig->psv_wire.psv_idx,
+			 next_fence);
+	if (unlikely(err))
+		goto out;
+
+	qp->next_fence = MLX5_FENCE_MODE_INITIATOR_SMALL;
+
+out:
+	return err;
+}
+
+static int handle_qpt_rc(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
+			 const struct ib_send_wr *wr,
+			 struct mlx5_wqe_ctrl_seg **ctrl, void **seg, int *size,
+			 void **cur_edge, unsigned int *idx, int nreq, u8 fence,
+			 u8 next_fence, int *num_sge)
+{
+	int err = 0;
+
+	switch (wr->opcode) {
+	case IB_WR_RDMA_READ:
+	case IB_WR_RDMA_WRITE:
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		handle_rdma_op(wr, seg, size);
+		break;
+
+	case IB_WR_ATOMIC_CMP_AND_SWP:
+	case IB_WR_ATOMIC_FETCH_AND_ADD:
+	case IB_WR_MASKED_ATOMIC_CMP_AND_SWP:
+		mlx5_ib_warn(dev, "Atomic operations are not supported yet\n");
+		err = -EOPNOTSUPP;
+		goto out;
+
+	case IB_WR_LOCAL_INV:
+		handle_local_inv(qp, wr, ctrl, seg, size, cur_edge, *idx);
+		*num_sge = 0;
+		break;
+
+	case IB_WR_REG_MR:
+		err = handle_reg_mr(qp, wr, ctrl, seg, size, cur_edge, *idx);
+		if (unlikely(err))
+			goto out;
+		*num_sge = 0;
+		break;
+
+	case IB_WR_REG_MR_INTEGRITY:
+		err = handle_reg_mr_integrity(dev, qp, wr, ctrl, seg, size,
+					      cur_edge, idx, nreq, fence,
+					      next_fence);
+		if (unlikely(err))
+			goto out;
+		*num_sge = 0;
+		break;
+
+	default:
+		break;
+	}
+
+out:
+	return err;
+}
+
+static void handle_qpt_uc(const struct ib_send_wr *wr, void **seg, int *size)
+{
+	switch (wr->opcode) {
+	case IB_WR_RDMA_WRITE:
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		handle_rdma_op(wr, seg, size);
+		break;
+	default:
+		break;
+	}
+}
+
+static void handle_qpt_hw_gsi(struct mlx5_ib_qp *qp,
+			      const struct ib_send_wr *wr, void **seg,
+			      int *size, void **cur_edge)
+{
+	set_datagram_seg(*seg, wr);
+	*seg += sizeof(struct mlx5_wqe_datagram_seg);
+	*size += sizeof(struct mlx5_wqe_datagram_seg) / 16;
+	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
+}
+
+static void handle_qpt_ud(struct mlx5_ib_qp *qp, const struct ib_send_wr *wr,
+			  void **seg, int *size, void **cur_edge)
+{
+	set_datagram_seg(*seg, wr);
+	*seg += sizeof(struct mlx5_wqe_datagram_seg);
+	*size += sizeof(struct mlx5_wqe_datagram_seg) / 16;
+	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
+
+	/* handle qp that supports ud offload */
+	if (qp->flags & IB_QP_CREATE_IPOIB_UD_LSO) {
+		struct mlx5_wqe_eth_pad *pad;
+
+		pad = *seg;
+		memset(pad, 0, sizeof(struct mlx5_wqe_eth_pad));
+		*seg += sizeof(struct mlx5_wqe_eth_pad);
+		*size += sizeof(struct mlx5_wqe_eth_pad) / 16;
+		set_eth_seg(wr, qp, seg, size, cur_edge);
+		handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
+	}
+}
+
+static int handle_qpt_reg_umr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
+			      const struct ib_send_wr *wr,
+			      struct mlx5_wqe_ctrl_seg **ctrl, void **seg,
+			      int *size, void **cur_edge, unsigned int idx)
+{
+	int err = 0;
+
+	if (unlikely(wr->opcode != MLX5_IB_WR_UMR)) {
+		err = -EINVAL;
+		mlx5_ib_warn(dev, "bad opcode %d\n", wr->opcode);
+		goto out;
+	}
+
+	qp->sq.wr_data[idx] = MLX5_IB_WR_UMR;
+	(*ctrl)->imm = cpu_to_be32(umr_wr(wr)->mkey);
+	err = set_reg_umr_segment(dev, *seg, wr,
+				  !!(MLX5_CAP_GEN(dev->mdev, atomic)));
+	if (unlikely(err))
+		goto out;
+	*seg += sizeof(struct mlx5_wqe_umr_ctrl_seg);
+	*size += sizeof(struct mlx5_wqe_umr_ctrl_seg) / 16;
+	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
+	set_reg_mkey_segment(*seg, wr);
+	*seg += sizeof(struct mlx5_mkey_seg);
+	*size += sizeof(struct mlx5_mkey_seg) / 16;
+	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
+out:
+	return err;
+}
+
 static int _mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 			      const struct ib_send_wr **bad_wr, bool drain)
 {
 	struct mlx5_wqe_ctrl_seg *ctrl = NULL;  /* compiler warning */
 	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
 	struct mlx5_core_dev *mdev = dev->mdev;
-	struct ib_reg_wr reg_pi_wr;
 	struct mlx5_ib_qp *qp;
-	struct mlx5_ib_mr *mr;
-	struct mlx5_ib_mr *pi_mr;
-	struct mlx5_ib_mr pa_pi_mr;
-	struct ib_sig_attrs *sig_attrs;
 	struct mlx5_wqe_xrc_seg *xrc;
 	struct mlx5_bf *bf;
 	void *cur_edge;
@@ -5321,186 +5582,20 @@ static int _mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 			size += sizeof(*xrc) / 16;
 			/* fall through */
 		case IB_QPT_RC:
-			switch (wr->opcode) {
-			case IB_WR_RDMA_READ:
-			case IB_WR_RDMA_WRITE:
-			case IB_WR_RDMA_WRITE_WITH_IMM:
-				set_raddr_seg(seg, rdma_wr(wr)->remote_addr,
-					      rdma_wr(wr)->rkey);
-				seg += sizeof(struct mlx5_wqe_raddr_seg);
-				size += sizeof(struct mlx5_wqe_raddr_seg) / 16;
-				break;
-
-			case IB_WR_ATOMIC_CMP_AND_SWP:
-			case IB_WR_ATOMIC_FETCH_AND_ADD:
-			case IB_WR_MASKED_ATOMIC_CMP_AND_SWP:
-				mlx5_ib_warn(dev, "Atomic operations are not supported yet\n");
-				err = -ENOSYS;
+			err = handle_qpt_rc(dev, qp, wr, &ctrl, &seg, &size,
+					    &cur_edge, &idx, nreq, fence,
+					    next_fence, &num_sge);
+			if (unlikely(err)) {
 				*bad_wr = wr;
 				goto out;
-
-			case IB_WR_LOCAL_INV:
-				qp->sq.wr_data[idx] = IB_WR_LOCAL_INV;
-				ctrl->imm = cpu_to_be32(wr->ex.invalidate_rkey);
-				set_linv_wr(qp, &seg, &size, &cur_edge);
-				num_sge = 0;
-				break;
-
-			case IB_WR_REG_MR:
-				qp->sq.wr_data[idx] = IB_WR_REG_MR;
-				ctrl->imm = cpu_to_be32(reg_wr(wr)->key);
-				err = set_reg_wr(qp, reg_wr(wr), &seg, &size,
-						 &cur_edge, true);
-				if (err) {
-					*bad_wr = wr;
-					goto out;
-				}
-				num_sge = 0;
-				break;
-
-			case IB_WR_REG_MR_INTEGRITY:
-				qp->sq.wr_data[idx] = IB_WR_REG_MR_INTEGRITY;
-
-				mr = to_mmr(reg_wr(wr)->mr);
-				pi_mr = mr->pi_mr;
-
-				if (pi_mr) {
-					memset(&reg_pi_wr, 0,
-					       sizeof(struct ib_reg_wr));
-
-					reg_pi_wr.mr = &pi_mr->ibmr;
-					reg_pi_wr.access = reg_wr(wr)->access;
-					reg_pi_wr.key = pi_mr->ibmr.rkey;
-
-					ctrl->imm = cpu_to_be32(reg_pi_wr.key);
-					/* UMR for data + prot registration */
-					err = set_reg_wr(qp, &reg_pi_wr, &seg,
-							 &size, &cur_edge,
-							 false);
-					if (err) {
-						*bad_wr = wr;
-						goto out;
-					}
-					finish_wqe(qp, ctrl, seg, size,
-						   cur_edge, idx, wr->wr_id,
-						   nreq, fence,
-						   MLX5_OPCODE_UMR);
-
-					err = begin_wqe(qp, &seg, &ctrl, wr,
-							&idx, &size, &cur_edge,
-							nreq);
-					if (err) {
-						mlx5_ib_warn(dev, "\n");
-						err = -ENOMEM;
-						*bad_wr = wr;
-						goto out;
-					}
-				} else {
-					memset(&pa_pi_mr, 0,
-					       sizeof(struct mlx5_ib_mr));
-					/* No UMR, use local_dma_lkey */
-					pa_pi_mr.ibmr.lkey =
-						mr->ibmr.pd->local_dma_lkey;
-
-					pa_pi_mr.ndescs = mr->ndescs;
-					pa_pi_mr.data_length = mr->data_length;
-					pa_pi_mr.data_iova = mr->data_iova;
-					if (mr->meta_ndescs) {
-						pa_pi_mr.meta_ndescs =
-							mr->meta_ndescs;
-						pa_pi_mr.meta_length =
-							mr->meta_length;
-						pa_pi_mr.pi_iova = mr->pi_iova;
-					}
-
-					pa_pi_mr.ibmr.length = mr->ibmr.length;
-					mr->pi_mr = &pa_pi_mr;
-				}
-				ctrl->imm = cpu_to_be32(mr->ibmr.rkey);
-				/* UMR for sig MR */
-				err = set_pi_umr_wr(wr, qp, &seg, &size,
-						    &cur_edge);
-				if (err) {
-					mlx5_ib_warn(dev, "\n");
-					*bad_wr = wr;
-					goto out;
-				}
-				finish_wqe(qp, ctrl, seg, size, cur_edge, idx,
-					   wr->wr_id, nreq, fence,
-					   MLX5_OPCODE_UMR);
-
-				/*
-				 * SET_PSV WQEs are not signaled and solicited
-				 * on error
-				 */
-				sig_attrs = mr->ibmr.sig_attrs;
-				err = __begin_wqe(qp, &seg, &ctrl, wr, &idx,
-						  &size, &cur_edge, nreq, false,
-						  true);
-				if (err) {
-					mlx5_ib_warn(dev, "\n");
-					err = -ENOMEM;
-					*bad_wr = wr;
-					goto out;
-				}
-				err = set_psv_wr(&sig_attrs->mem,
-						 mr->sig->psv_memory.psv_idx,
-						 &seg, &size);
-				if (err) {
-					mlx5_ib_warn(dev, "\n");
-					*bad_wr = wr;
-					goto out;
-				}
-				finish_wqe(qp, ctrl, seg, size, cur_edge, idx,
-					   wr->wr_id, nreq, next_fence,
-					   MLX5_OPCODE_SET_PSV);
-
-				err = __begin_wqe(qp, &seg, &ctrl, wr, &idx,
-						  &size, &cur_edge, nreq, false,
-						  true);
-				if (err) {
-					mlx5_ib_warn(dev, "\n");
-					err = -ENOMEM;
-					*bad_wr = wr;
-					goto out;
-				}
-				err = set_psv_wr(&sig_attrs->wire,
-						 mr->sig->psv_wire.psv_idx,
-						 &seg, &size);
-				if (err) {
-					mlx5_ib_warn(dev, "\n");
-					*bad_wr = wr;
-					goto out;
-				}
-				finish_wqe(qp, ctrl, seg, size, cur_edge, idx,
-					   wr->wr_id, nreq, next_fence,
-					   MLX5_OPCODE_SET_PSV);
-
-				qp->next_fence =
-					MLX5_FENCE_MODE_INITIATOR_SMALL;
-				num_sge = 0;
+			} else if (wr->opcode == IB_WR_REG_MR_INTEGRITY) {
 				goto skip_psv;
-
-			default:
-				break;
 			}
 			break;
 
 		case IB_QPT_UC:
-			switch (wr->opcode) {
-			case IB_WR_RDMA_WRITE:
-			case IB_WR_RDMA_WRITE_WITH_IMM:
-				set_raddr_seg(seg, rdma_wr(wr)->remote_addr,
-					      rdma_wr(wr)->rkey);
-				seg  += sizeof(struct mlx5_wqe_raddr_seg);
-				size += sizeof(struct mlx5_wqe_raddr_seg) / 16;
-				break;
-
-			default:
-				break;
-			}
+			handle_qpt_uc(wr, &seg, &size);
 			break;
-
 		case IB_QPT_SMI:
 			if (unlikely(!mdev->port_caps[qp->port - 1].has_smi)) {
 				mlx5_ib_warn(dev, "Send SMP MADs is not allowed\n");
@@ -5510,49 +5605,16 @@ static int _mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 			}
 			/* fall through */
 		case MLX5_IB_QPT_HW_GSI:
-			set_datagram_seg(seg, wr);
-			seg += sizeof(struct mlx5_wqe_datagram_seg);
-			size += sizeof(struct mlx5_wqe_datagram_seg) / 16;
-			handle_post_send_edge(&qp->sq, &seg, size, &cur_edge);
-
+			handle_qpt_hw_gsi(qp, wr, &seg, &size, &cur_edge);
 			break;
 		case IB_QPT_UD:
-			set_datagram_seg(seg, wr);
-			seg += sizeof(struct mlx5_wqe_datagram_seg);
-			size += sizeof(struct mlx5_wqe_datagram_seg) / 16;
-			handle_post_send_edge(&qp->sq, &seg, size, &cur_edge);
-
-			/* handle qp that supports ud offload */
-			if (qp->flags & IB_QP_CREATE_IPOIB_UD_LSO) {
-				struct mlx5_wqe_eth_pad *pad;
-
-				pad = seg;
-				memset(pad, 0, sizeof(struct mlx5_wqe_eth_pad));
-				seg += sizeof(struct mlx5_wqe_eth_pad);
-				size += sizeof(struct mlx5_wqe_eth_pad) / 16;
-				set_eth_seg(wr, qp, &seg, &size, &cur_edge);
-				handle_post_send_edge(&qp->sq, &seg, size,
-						      &cur_edge);
-			}
+			handle_qpt_ud(qp, wr, &seg, &size, &cur_edge);
 			break;
 		case MLX5_IB_QPT_REG_UMR:
-			if (wr->opcode != MLX5_IB_WR_UMR) {
-				err = -EINVAL;
-				mlx5_ib_warn(dev, "bad opcode\n");
-				goto out;
-			}
-			qp->sq.wr_data[idx] = MLX5_IB_WR_UMR;
-			ctrl->imm = cpu_to_be32(umr_wr(wr)->mkey);
-			err = set_reg_umr_segment(dev, seg, wr, !!(MLX5_CAP_GEN(mdev, atomic)));
+			err = handle_qpt_reg_umr(dev, qp, wr, &ctrl, &seg,
+						       &size, &cur_edge, idx);
 			if (unlikely(err))
 				goto out;
-			seg += sizeof(struct mlx5_wqe_umr_ctrl_seg);
-			size += sizeof(struct mlx5_wqe_umr_ctrl_seg) / 16;
-			handle_post_send_edge(&qp->sq, &seg, size, &cur_edge);
-			set_reg_mkey_segment(seg, wr);
-			seg += sizeof(struct mlx5_mkey_seg);
-			size += sizeof(struct mlx5_mkey_seg) / 16;
-			handle_post_send_edge(&qp->sq, &seg, size, &cur_edge);
 			break;
 
 		default:
-- 
2.26.2

