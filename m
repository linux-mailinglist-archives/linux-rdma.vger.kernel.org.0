Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9881B4FD65F
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 12:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346524AbiDLJ5Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 05:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359463AbiDLHnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 03:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF0612AE3
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 00:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BB2D614FA
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 07:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC43C385A1;
        Tue, 12 Apr 2022 07:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649748281;
        bh=S3smLdABGn1zXzTyX86DMkDISHKjxJSHU+LICImXBo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXqVkoelMfH9PDlb69M3XRRsZwLKvHZLvpxEMvGWhTOCio7PiDpzdIdzPW3BKPxBs
         rLWt5szNzyn50IAVeTWtMpM7o9shZLDYxP0M6O48o6mpadwRw/3W4t41bXmW8hnbvc
         PetkkLPgeezkdhCV13/6oCYbPWyNoj16phaFsEjMEgPXuVklZLzri52aS/wuhFuYLb
         IIUsSWPJJr2uMS5qwv+H/KI8VhATfJM8vHGx6GUlQL892IMIpt4rHWXet2xN7n72zi
         swDvbvB4atYQdwI5+ccDNh63VcDlsnXSd6OnKBTuS4LNP+QWvf/PuIa0+FCBs7yb/U
         Y1eYNnAyED5zg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 05/12] RDMA/mlx5: Expose wqe posting helpers outside of wr.c
Date:   Tue, 12 Apr 2022 10:24:00 +0300
Message-Id: <a2b0f6cd96f0405a65d38e82c6ae7ef34dcb34bc.1649747695.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649747695.git.leonro@nvidia.com>
References: <cover.1649747695.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

Split posting WQEs logic to helpers, generalize it and expose for future
use in the UMR post send.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/wr.c | 172 +++++++++++---------------------
 drivers/infiniband/hw/mlx5/wr.h |  60 +++++++++++
 2 files changed, 121 insertions(+), 111 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/wr.c b/drivers/infiniband/hw/mlx5/wr.c
index 24457eb5e4b7..7949f83b2cd2 100644
--- a/drivers/infiniband/hw/mlx5/wr.c
+++ b/drivers/infiniband/hw/mlx5/wr.c
@@ -26,58 +26,7 @@ static const u32 mlx5_ib_opcode[] = {
 	[MLX5_IB_WR_UMR]			= MLX5_OPCODE_UMR,
 };
 
-/* handle_post_send_edge - Check if we get to SQ edge. If yes, update to the
- * next nearby edge and get new address translation for current WQE position.
- * @sq - SQ buffer.
- * @seg: Current WQE position (16B aligned).
- * @wqe_sz: Total current WQE size [16B].
- * @cur_edge: Updated current edge.
- */
-static inline void handle_post_send_edge(struct mlx5_ib_wq *sq, void **seg,
-					 u32 wqe_sz, void **cur_edge)
-{
-	u32 idx;
-
-	if (likely(*seg != *cur_edge))
-		return;
-
-	idx = (sq->cur_post + (wqe_sz >> 2)) & (sq->wqe_cnt - 1);
-	*cur_edge = get_sq_edge(sq, idx);
-
-	*seg = mlx5_frag_buf_get_wqe(&sq->fbc, idx);
-}
-
-/* memcpy_send_wqe - copy data from src to WQE and update the relevant WQ's
- * pointers. At the end @seg is aligned to 16B regardless the copied size.
- * @sq - SQ buffer.
- * @cur_edge: Updated current edge.
- * @seg: Current WQE position (16B aligned).
- * @wqe_sz: Total current WQE size [16B].
- * @src: Pointer to copy from.
- * @n: Number of bytes to copy.
- */
-static inline void memcpy_send_wqe(struct mlx5_ib_wq *sq, void **cur_edge,
-				   void **seg, u32 *wqe_sz, const void *src,
-				   size_t n)
-{
-	while (likely(n)) {
-		size_t leftlen = *cur_edge - *seg;
-		size_t copysz = min_t(size_t, leftlen, n);
-		size_t stride;
-
-		memcpy(*seg, src, copysz);
-
-		n -= copysz;
-		src += copysz;
-		stride = !n ? ALIGN(copysz, 16) : copysz;
-		*seg += stride;
-		*wqe_sz += stride >> 4;
-		handle_post_send_edge(sq, seg, *wqe_sz, cur_edge);
-	}
-}
-
-static int mlx5_wq_overflow(struct mlx5_ib_wq *wq, int nreq,
-			    struct ib_cq *ib_cq)
+int mlx5r_wq_overflow(struct mlx5_ib_wq *wq, int nreq, struct ib_cq *ib_cq)
 {
 	struct mlx5_ib_cq *cq;
 	unsigned int cur;
@@ -123,9 +72,9 @@ static void set_eth_seg(const struct ib_send_wr *wr, struct mlx5_ib_qp *qp,
 		eseg->mss = cpu_to_be16(ud_wr->mss);
 		eseg->inline_hdr.sz = cpu_to_be16(left);
 
-		/* memcpy_send_wqe should get a 16B align address. Hence, we
-		 * first copy up to the current edge and then, if needed,
-		 * continue to memcpy_send_wqe.
+		/* mlx5r_memcpy_send_wqe should get a 16B align address. Hence,
+		 * we first copy up to the current edge and then, if needed,
+		 * continue to mlx5r_memcpy_send_wqe.
 		 */
 		copysz = min_t(u64, *cur_edge - (void *)eseg->inline_hdr.start,
 			       left);
@@ -139,8 +88,8 @@ static void set_eth_seg(const struct ib_send_wr *wr, struct mlx5_ib_qp *qp,
 			handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
 			left -= copysz;
 			pdata += copysz;
-			memcpy_send_wqe(&qp->sq, cur_edge, seg, size, pdata,
-					left);
+			mlx5r_memcpy_send_wqe(&qp->sq, cur_edge, seg, size,
+					      pdata, left);
 		}
 
 		return;
@@ -766,8 +715,8 @@ static int set_reg_wr(struct mlx5_ib_qp *qp,
 	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
 
 	if (umr_inline) {
-		memcpy_send_wqe(&qp->sq, cur_edge, seg, size, mr->descs,
-				mr_list_size);
+		mlx5r_memcpy_send_wqe(&qp->sq, cur_edge, seg, size, mr->descs,
+				      mr_list_size);
 		*size = ALIGN(*size, MLX5_SEND_WQE_BB >> 4);
 	} else {
 		set_reg_data_seg(*seg, mr, pd);
@@ -809,23 +758,22 @@ static void dump_wqe(struct mlx5_ib_qp *qp, u32 idx, int size_16)
 	}
 }
 
-static int __begin_wqe(struct mlx5_ib_qp *qp, void **seg,
-		       struct mlx5_wqe_ctrl_seg **ctrl,
-		       const struct ib_send_wr *wr, unsigned int *idx,
-		       int *size, void **cur_edge, int nreq,
-		       bool send_signaled, bool solicited)
+int mlx5r_begin_wqe(struct mlx5_ib_qp *qp, void **seg,
+		    struct mlx5_wqe_ctrl_seg **ctrl, unsigned int *idx,
+		    int *size, void **cur_edge, int nreq, __be32 general_id,
+		    bool send_signaled, bool solicited)
 {
-	if (unlikely(mlx5_wq_overflow(&qp->sq, nreq, qp->ibqp.send_cq)))
+	if (unlikely(mlx5r_wq_overflow(&qp->sq, nreq, qp->ibqp.send_cq)))
 		return -ENOMEM;
 
 	*idx = qp->sq.cur_post & (qp->sq.wqe_cnt - 1);
 	*seg = mlx5_frag_buf_get_wqe(&qp->sq.fbc, *idx);
 	*ctrl = *seg;
 	*(uint32_t *)(*seg + 8) = 0;
-	(*ctrl)->imm = send_ieth(wr);
+	(*ctrl)->general_id = general_id;
 	(*ctrl)->fm_ce_se = qp->sq_signal_bits |
-		(send_signaled ? MLX5_WQE_CTRL_CQ_UPDATE : 0) |
-		(solicited ? MLX5_WQE_CTRL_SOLICITED : 0);
+			    (send_signaled ? MLX5_WQE_CTRL_CQ_UPDATE : 0) |
+			    (solicited ? MLX5_WQE_CTRL_SOLICITED : 0);
 
 	*seg += sizeof(**ctrl);
 	*size = sizeof(**ctrl) / 16;
@@ -839,16 +787,14 @@ static int begin_wqe(struct mlx5_ib_qp *qp, void **seg,
 		     const struct ib_send_wr *wr, unsigned int *idx, int *size,
 		     void **cur_edge, int nreq)
 {
-	return __begin_wqe(qp, seg, ctrl, wr, idx, size, cur_edge, nreq,
-			   wr->send_flags & IB_SEND_SIGNALED,
-			   wr->send_flags & IB_SEND_SOLICITED);
+	return mlx5r_begin_wqe(qp, seg, ctrl, idx, size, cur_edge, nreq,
+			       send_ieth(wr), wr->send_flags & IB_SEND_SIGNALED,
+			       wr->send_flags & IB_SEND_SOLICITED);
 }
 
-static void finish_wqe(struct mlx5_ib_qp *qp,
-		       struct mlx5_wqe_ctrl_seg *ctrl,
-		       void *seg, u8 size, void *cur_edge,
-		       unsigned int idx, u64 wr_id, int nreq, u8 fence,
-		       u32 mlx5_opcode)
+void mlx5r_finish_wqe(struct mlx5_ib_qp *qp, struct mlx5_wqe_ctrl_seg *ctrl,
+		      void *seg, u8 size, void *cur_edge, unsigned int idx,
+		      u64 wr_id, int nreq, u8 fence, u32 mlx5_opcode)
 {
 	u8 opmod = 0;
 
@@ -912,8 +858,8 @@ static int handle_psv(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	/*
 	 * SET_PSV WQEs are not signaled and solicited on error.
 	 */
-	err = __begin_wqe(qp, seg, ctrl, wr, idx, size, cur_edge, nreq,
-			  false, true);
+	err = mlx5r_begin_wqe(qp, seg, ctrl, idx, size, cur_edge, nreq,
+			      send_ieth(wr), false, true);
 	if (unlikely(err)) {
 		mlx5_ib_warn(dev, "\n");
 		err = -ENOMEM;
@@ -924,8 +870,8 @@ static int handle_psv(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 		mlx5_ib_warn(dev, "\n");
 		goto out;
 	}
-	finish_wqe(qp, *ctrl, *seg, *size, *cur_edge, *idx, wr->wr_id, nreq,
-		   next_fence, MLX5_OPCODE_SET_PSV);
+	mlx5r_finish_wqe(qp, *ctrl, *seg, *size, *cur_edge, *idx, wr->wr_id,
+			 nreq, next_fence, MLX5_OPCODE_SET_PSV);
 
 out:
 	return err;
@@ -965,8 +911,8 @@ static int handle_reg_mr_integrity(struct mlx5_ib_dev *dev,
 		if (unlikely(err))
 			goto out;
 
-		finish_wqe(qp, *ctrl, *seg, *size, *cur_edge, *idx, wr->wr_id,
-			   nreq, fence, MLX5_OPCODE_UMR);
+		mlx5r_finish_wqe(qp, *ctrl, *seg, *size, *cur_edge, *idx,
+				 wr->wr_id, nreq, fence, MLX5_OPCODE_UMR);
 
 		err = begin_wqe(qp, seg, ctrl, wr, idx, size, cur_edge, nreq);
 		if (unlikely(err)) {
@@ -997,8 +943,8 @@ static int handle_reg_mr_integrity(struct mlx5_ib_dev *dev,
 		mlx5_ib_warn(dev, "\n");
 		goto out;
 	}
-	finish_wqe(qp, *ctrl, *seg, *size, *cur_edge, *idx, wr->wr_id, nreq,
-		   fence, MLX5_OPCODE_UMR);
+	mlx5r_finish_wqe(qp, *ctrl, *seg, *size, *cur_edge, *idx, wr->wr_id,
+			 nreq, fence, MLX5_OPCODE_UMR);
 
 	sig_attrs = mr->ibmr.sig_attrs;
 	err = handle_psv(dev, qp, wr, ctrl, seg, size, cur_edge, idx, nreq,
@@ -1142,6 +1088,32 @@ static int handle_qpt_reg_umr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	return err;
 }
 
+void mlx5r_ring_db(struct mlx5_ib_qp *qp, unsigned int nreq,
+		   struct mlx5_wqe_ctrl_seg *ctrl)
+{
+	struct mlx5_bf *bf = &qp->bf;
+
+	qp->sq.head += nreq;
+
+	/* Make sure that descriptors are written before
+	 * updating doorbell record and ringing the doorbell
+	 */
+	wmb();
+
+	qp->db.db[MLX5_SND_DBR] = cpu_to_be32(qp->sq.cur_post);
+
+	/* Make sure doorbell record is visible to the HCA before
+	 * we hit doorbell.
+	 */
+	wmb();
+
+	mlx5_write64((__be32 *)ctrl, bf->bfreg->map + bf->offset);
+	/* Make sure doorbells don't leak out of SQ spinlock
+	 * and reach the HCA out of order.
+	 */
+	bf->offset ^= bf->buf_size;
+}
+
 int mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 		      const struct ib_send_wr **bad_wr, bool drain)
 {
@@ -1150,7 +1122,6 @@ int mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	struct mlx5_core_dev *mdev = dev->mdev;
 	struct mlx5_ib_qp *qp = to_mqp(ibqp);
 	struct mlx5_wqe_xrc_seg *xrc;
-	struct mlx5_bf *bf;
 	void *cur_edge;
 	int size;
 	unsigned long flags;
@@ -1172,8 +1143,6 @@ int mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	if (qp->type == IB_QPT_GSI)
 		return mlx5_ib_gsi_post_send(ibqp, wr, bad_wr);
 
-	bf = &qp->bf;
-
 	spin_lock_irqsave(&qp->sq.lock, flags);
 
 	for (nreq = 0; wr; nreq++, wr = wr->next) {
@@ -1285,35 +1254,16 @@ int mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 		}
 
 		qp->next_fence = next_fence;
-		finish_wqe(qp, ctrl, seg, size, cur_edge, idx, wr->wr_id, nreq,
-			   fence, mlx5_ib_opcode[wr->opcode]);
+		mlx5r_finish_wqe(qp, ctrl, seg, size, cur_edge, idx, wr->wr_id,
+				 nreq, fence, mlx5_ib_opcode[wr->opcode]);
 skip_psv:
 		if (0)
 			dump_wqe(qp, idx, size);
 	}
 
 out:
-	if (likely(nreq)) {
-		qp->sq.head += nreq;
-
-		/* Make sure that descriptors are written before
-		 * updating doorbell record and ringing the doorbell
-		 */
-		wmb();
-
-		qp->db.db[MLX5_SND_DBR] = cpu_to_be32(qp->sq.cur_post);
-
-		/* Make sure doorbell record is visible to the HCA before
-		 * we hit doorbell.
-		 */
-		wmb();
-
-		mlx5_write64((__be32 *)ctrl, bf->bfreg->map + bf->offset);
-		/* Make sure doorbells don't leak out of SQ spinlock
-		 * and reach the HCA out of order.
-		 */
-		bf->offset ^= bf->buf_size;
-	}
+	if (likely(nreq))
+		mlx5r_ring_db(qp, nreq, ctrl);
 
 	spin_unlock_irqrestore(&qp->sq.lock, flags);
 
@@ -1353,7 +1303,7 @@ int mlx5_ib_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 	ind = qp->rq.head & (qp->rq.wqe_cnt - 1);
 
 	for (nreq = 0; wr; nreq++, wr = wr->next) {
-		if (mlx5_wq_overflow(&qp->rq, nreq, qp->ibqp.recv_cq)) {
+		if (mlx5r_wq_overflow(&qp->rq, nreq, qp->ibqp.recv_cq)) {
 			err = -ENOMEM;
 			*bad_wr = wr;
 			goto out;
diff --git a/drivers/infiniband/hw/mlx5/wr.h b/drivers/infiniband/hw/mlx5/wr.h
index 4f0057516402..2dc89438000d 100644
--- a/drivers/infiniband/hw/mlx5/wr.h
+++ b/drivers/infiniband/hw/mlx5/wr.h
@@ -41,6 +41,66 @@ static inline void *get_sq_edge(struct mlx5_ib_wq *sq, u32 idx)
 	return fragment_end + MLX5_SEND_WQE_BB;
 }
 
+/* handle_post_send_edge - Check if we get to SQ edge. If yes, update to the
+ * next nearby edge and get new address translation for current WQE position.
+ * @sq: SQ buffer.
+ * @seg: Current WQE position (16B aligned).
+ * @wqe_sz: Total current WQE size [16B].
+ * @cur_edge: Updated current edge.
+ */
+static inline void handle_post_send_edge(struct mlx5_ib_wq *sq, void **seg,
+					 u32 wqe_sz, void **cur_edge)
+{
+	u32 idx;
+
+	if (likely(*seg != *cur_edge))
+		return;
+
+	idx = (sq->cur_post + (wqe_sz >> 2)) & (sq->wqe_cnt - 1);
+	*cur_edge = get_sq_edge(sq, idx);
+
+	*seg = mlx5_frag_buf_get_wqe(&sq->fbc, idx);
+}
+
+/* mlx5r_memcpy_send_wqe - copy data from src to WQE and update the relevant
+ * WQ's pointers. At the end @seg is aligned to 16B regardless the copied size.
+ * @sq: SQ buffer.
+ * @cur_edge: Updated current edge.
+ * @seg: Current WQE position (16B aligned).
+ * @wqe_sz: Total current WQE size [16B].
+ * @src: Pointer to copy from.
+ * @n: Number of bytes to copy.
+ */
+static inline void mlx5r_memcpy_send_wqe(struct mlx5_ib_wq *sq, void **cur_edge,
+					 void **seg, u32 *wqe_sz,
+					 const void *src, size_t n)
+{
+	while (likely(n)) {
+		size_t leftlen = *cur_edge - *seg;
+		size_t copysz = min_t(size_t, leftlen, n);
+		size_t stride;
+
+		memcpy(*seg, src, copysz);
+
+		n -= copysz;
+		src += copysz;
+		stride = !n ? ALIGN(copysz, 16) : copysz;
+		*seg += stride;
+		*wqe_sz += stride >> 4;
+		handle_post_send_edge(sq, seg, *wqe_sz, cur_edge);
+	}
+}
+
+int mlx5r_wq_overflow(struct mlx5_ib_wq *wq, int nreq, struct ib_cq *ib_cq);
+int mlx5r_begin_wqe(struct mlx5_ib_qp *qp, void **seg,
+		    struct mlx5_wqe_ctrl_seg **ctrl, unsigned int *idx,
+		    int *size, void **cur_edge, int nreq, __be32 general_id,
+		    bool send_signaled, bool solicited);
+void mlx5r_finish_wqe(struct mlx5_ib_qp *qp, struct mlx5_wqe_ctrl_seg *ctrl,
+		      void *seg, u8 size, void *cur_edge, unsigned int idx,
+		      u64 wr_id, int nreq, u8 fence, u32 mlx5_opcode);
+void mlx5r_ring_db(struct mlx5_ib_qp *qp, unsigned int nreq,
+		   struct mlx5_wqe_ctrl_seg *ctrl);
 int mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 		      const struct ib_send_wr **bad_wr, bool drain);
 int mlx5_ib_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
-- 
2.35.1

