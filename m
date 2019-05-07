Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1214E164BB
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 15:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfEGNjF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 09:39:05 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40551 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726808AbfEGNjE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 09:39:04 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 7 May 2019 16:38:42 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x47DcdFP021865;
        Tue, 7 May 2019 16:38:42 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com, maxg@mellanox.com
Subject: [PATCH 25/25] RDMA/mlx5: Use PA mapping for PI handover
Date:   Tue,  7 May 2019 16:38:39 +0300
Message-Id: <1557236319-9986-26-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If possibe, avoid doing a UMR operation to register data and protection
buffers (via MTT/KLM mkeys). Instead, use the local DMA key and map the
SG lists using PA access. This is safe, since the internal key for data
and protection never exposed to the remote server (only signature key
might be exposed). If PA mappings are not possible, perform mapping
using MTT/KLM descriptors.

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
512   1266.4K/1262.4K    1720.1K/1732.1K
4k    793139/570902      1129.6K/773982
32k   72660/72086        97229/96164

Using write_generate=0 and read_verify=0 (w/w.o patch):
bs      IOPS(read)        IOPS(write)
----    ----------        ----------
512   1590.2K/1600.1K    1828.2K/1830.3K
4k    1078.1K/937272     1142.1K/815304
32k   77012/77369        98125/97435

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Suggested-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
 drivers/infiniband/hw/mlx5/mr.c      | 58 ++++++++++++++++++++++++--
 drivers/infiniband/hw/mlx5/qp.c      | 80 ++++++++++++++++++++++++------------
 3 files changed, 110 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 5bc18256b71a..220971fd17aa 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -590,6 +590,7 @@ struct mlx5_ib_mr {
 	struct mlx5_ib_mr      *pi_mr;
 	struct mlx5_ib_mr      *klm_mr;
 	struct mlx5_ib_mr      *mtt_mr;
+	u64			data_iova;
 	u64			pi_iova;
 
 	atomic_t		num_leaf_free;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index f94c47b87426..2cc9f64c9ec0 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1988,6 +1988,39 @@ int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
 	return ret;
 }
 
+static int
+mlx5_ib_map_pa_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
+			int data_sg_nents, unsigned int *data_sg_offset,
+			struct scatterlist *meta_sg, int meta_sg_nents,
+			unsigned int *meta_sg_offset)
+{
+	struct mlx5_ib_mr *mr = to_mmr(ibmr);
+	unsigned int sg_offset = 0;
+	int n = 0;
+
+	if (data_sg_nents == 1) {
+		n++;
+		mr->ndescs = 1;
+		if (data_sg_offset)
+			sg_offset = *data_sg_offset;
+		mr->data_length = sg_dma_len(data_sg) - sg_offset;
+		mr->data_iova = sg_dma_address(data_sg) + sg_offset;
+		if (meta_sg_nents && meta_sg_nents == 1) {
+			n++;
+			mr->meta_ndescs = 1;
+			if (meta_sg_offset)
+				sg_offset = *meta_sg_offset;
+			else
+				sg_offset = 0;
+			mr->meta_length = sg_dma_len(meta_sg) - sg_offset;
+			mr->pi_iova = sg_dma_address(meta_sg) + sg_offset;
+		}
+		mr->ibmr.length = mr->data_length + mr->meta_length;
+	}
+
+	return n;
+}
+
 static int
 mlx5_ib_sg_to_klms(struct mlx5_ib_mr *mr,
 		   struct scatterlist *sgl,
@@ -2086,7 +2119,6 @@ mlx5_ib_map_mtt_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
 	struct mlx5_ib_mr *mr = to_mmr(ibmr);
 	struct mlx5_ib_mr *pi_mr = mr->mtt_mr;
 	int n;
-	u64 iova;
 
 	pi_mr->ndescs = 0;
 	pi_mr->meta_ndescs = 0;
@@ -2101,13 +2133,14 @@ mlx5_ib_map_mtt_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
 	if (n != data_sg_nents)
 		return n;
 
-	iova = pi_mr->ibmr.iova;
+	pi_mr->data_iova = pi_mr->ibmr.iova;
 	pi_mr->data_length = pi_mr->ibmr.length;
 	pi_mr->ibmr.length = pi_mr->data_length;
 	ibmr->length = pi_mr->data_length;
 
 	if (meta_sg_nents) {
 		u64 page_mask = ~((u64)ibmr->page_size - 1);
+		u64 iova = pi_mr->data_iova;
 
 		n += ib_sg_to_pages(&pi_mr->ibmr, meta_sg, meta_sg_nents,
 				    meta_sg_offset, mlx5_set_page_pi);
@@ -2166,6 +2199,7 @@ mlx5_ib_map_klm_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
 				      DMA_TO_DEVICE);
 
 	/* This is zero-based memory region */
+	pi_mr->data_iova = 0;
 	pi_mr->ibmr.iova = 0;
 	pi_mr->pi_iova = pi_mr->data_length;
 	ibmr->length = pi_mr->ibmr.length;
@@ -2179,11 +2213,28 @@ int mlx5_ib_map_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
 			 unsigned int *meta_sg_offset)
 {
 	struct mlx5_ib_mr *mr = to_mmr(ibmr);
-	struct mlx5_ib_mr *pi_mr = mr->mtt_mr;
+	struct mlx5_ib_mr *pi_mr = NULL;
 	int n;
 
 	WARN_ON(ibmr->type != IB_MR_TYPE_INTEGRITY);
 
+	mr->ndescs = 0;
+	mr->data_length = 0;
+	mr->data_iova = 0;
+	mr->meta_ndescs = 0;
+	mr->meta_length = 0;
+	mr->pi_iova = 0;
+	/*
+	 * As a performance optimization, if possible, there is no need to
+	 * perform UMR operation to register the data/metadata buffers.
+	 * First try to map the sg lists to PA descriptors with local_dma_lkey.
+	 * Fallback to UMR only in case of a failure.
+	 */
+	n = mlx5_ib_map_pa_mr_sg_pi(ibmr, data_sg, data_sg_nents,
+				    data_sg_offset, meta_sg, meta_sg_nents,
+				    meta_sg_offset);
+	if (n == data_sg_nents + meta_sg_nents)
+		goto out;
 	/*
 	 * As a performance optimization, if possible, there is no need to map
 	 * the sg lists to KLM descriptors. First try to map the sg lists to MTT
@@ -2192,6 +2243,7 @@ int mlx5_ib_map_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
 	 * (especially in high load).
 	 * Use KLM (indirect access) only if it's mandatory.
 	 */
+	pi_mr = mr->mtt_mr;
 	n = mlx5_ib_map_mtt_mr_sg_pi(ibmr, data_sg, data_sg_nents,
 				     data_sg_offset, meta_sg, meta_sg_nents,
 				     meta_sg_offset);
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 4fb816712c29..24c7dc43f39d 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4484,7 +4484,7 @@ static int set_sig_data_segment(const struct ib_send_wr *send_wr,
 
 	data_len = pi_mr->data_length;
 	data_key = pi_mr->ibmr.lkey;
-	data_va = pi_mr->ibmr.iova;
+	data_va = pi_mr->data_iova;
 	if (pi_mr->meta_ndescs) {
 		prot_len = pi_mr->meta_length;
 		prot_key = pi_mr->ibmr.lkey;
@@ -4835,6 +4835,7 @@ static int _mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	struct mlx5_ib_qp *qp;
 	struct mlx5_ib_mr *mr;
 	struct mlx5_ib_mr *pi_mr;
+	struct mlx5_ib_mr pa_pi_mr;
 	struct ib_sig_attrs *sig_attrs;
 	struct mlx5_wqe_xrc_seg *xrc;
 	struct mlx5_bf *bf;
@@ -4949,35 +4950,62 @@ static int _mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 				break;
 
 			case IB_WR_REG_MR_INTEGRITY:
-				memset(&reg_pi_wr, 0, sizeof(struct ib_reg_wr));
+				qp->sq.wr_data[idx] = IB_WR_REG_MR_INTEGRITY;
 
 				mr = to_mmr(reg_wr(wr)->mr);
 				pi_mr = mr->pi_mr;
 
-				reg_pi_wr.mr = &pi_mr->ibmr;
-				reg_pi_wr.access = reg_wr(wr)->access;
-				reg_pi_wr.key = pi_mr->ibmr.rkey;
-
-				qp->sq.wr_data[idx] = IB_WR_REG_MR_INTEGRITY;
-				ctrl->imm = cpu_to_be32(reg_pi_wr.key);
-				/* UMR for data + protection registration */
-				err = set_reg_wr(qp, &reg_pi_wr, &seg, &size,
-						 &cur_edge, false);
-				if (err) {
-					*bad_wr = wr;
-					goto out;
-				}
-				finish_wqe(qp, ctrl, seg, size, cur_edge, idx,
-					   wr->wr_id, nreq, fence,
-					   MLX5_OPCODE_UMR);
-
-				err = begin_wqe(qp, &seg, &ctrl, wr, &idx,
-						&size, &cur_edge, nreq);
-				if (err) {
-					mlx5_ib_warn(dev, "\n");
-					err = -ENOMEM;
-					*bad_wr = wr;
-					goto out;
+				if (pi_mr) {
+					memset(&reg_pi_wr, 0,
+					       sizeof(struct ib_reg_wr));
+
+					reg_pi_wr.mr = &pi_mr->ibmr;
+					reg_pi_wr.access = reg_wr(wr)->access;
+					reg_pi_wr.key = pi_mr->ibmr.rkey;
+
+					ctrl->imm = cpu_to_be32(reg_pi_wr.key);
+					/* UMR for data + prot registration */
+					err = set_reg_wr(qp, &reg_pi_wr, &seg,
+							 &size, &cur_edge,
+							 false);
+					if (err) {
+						*bad_wr = wr;
+						goto out;
+					}
+					finish_wqe(qp, ctrl, seg, size,
+						   cur_edge, idx, wr->wr_id,
+						   nreq, fence,
+						   MLX5_OPCODE_UMR);
+
+					err = begin_wqe(qp, &seg, &ctrl, wr,
+							&idx, &size, &cur_edge,
+							nreq);
+					if (err) {
+						mlx5_ib_warn(dev, "\n");
+						err = -ENOMEM;
+						*bad_wr = wr;
+						goto out;
+					}
+				} else {
+					memset(&pa_pi_mr, 0,
+					       sizeof(struct mlx5_ib_mr));
+					/* No UMR, use local_dma_lkey */
+					pa_pi_mr.ibmr.lkey =
+						mr->ibmr.pd->local_dma_lkey;
+
+					pa_pi_mr.ndescs = mr->ndescs;
+					pa_pi_mr.data_length = mr->data_length;
+					pa_pi_mr.data_iova = mr->data_iova;
+					if (mr->meta_ndescs) {
+						pa_pi_mr.meta_ndescs =
+							mr->meta_ndescs;
+						pa_pi_mr.meta_length =
+							mr->meta_length;
+						pa_pi_mr.pi_iova = mr->pi_iova;
+					}
+
+					pa_pi_mr.ibmr.length = mr->ibmr.length;
+					mr->pi_mr = &pa_pi_mr;
 				}
 				ctrl->imm = cpu_to_be32(mr->ibmr.rkey);
 				/* UMR for sig MR */
-- 
2.16.3

