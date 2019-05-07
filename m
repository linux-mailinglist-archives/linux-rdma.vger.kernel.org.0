Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C87164B7
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 15:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfEGNis (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 09:38:48 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40359 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726608AbfEGNis (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 09:38:48 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 7 May 2019 16:38:40 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x47DcdF8021865;
        Tue, 7 May 2019 16:38:40 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com, maxg@mellanox.com
Subject: [PATCH 08/25] RDMA/mlx5: Pass UMR segment flags instead of boolean
Date:   Tue,  7 May 2019 16:38:22 +0300
Message-Id: <1557236319-9986-9-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

UMR ctrl segment flags can vary between UMR operations. for example,
using inline UMR or adding free/not-free checks for a memory key.
This is a preparation commit before adding new signature API that
will not need not-free checks for the internal memory key during the
UMR operation.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/infiniband/hw/mlx5/qp.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 8aafb2208899..d430f455ed04 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4089,15 +4089,13 @@ static __be64 sig_mkey_mask(void)
 }
 
 static void set_reg_umr_seg(struct mlx5_wqe_umr_ctrl_seg *umr,
-			    struct mlx5_ib_mr *mr, bool umr_inline)
+			    struct mlx5_ib_mr *mr, u8 flags)
 {
 	int size = mr->ndescs * mr->desc_size;
 
 	memset(umr, 0, sizeof(*umr));
 
-	umr->flags = MLX5_UMR_CHECK_NOT_FREE;
-	if (umr_inline)
-		umr->flags |= MLX5_UMR_INLINE;
+	umr->flags = flags;
 	umr->xlt_octowords = cpu_to_be16(get_xlt_octo(size));
 	umr->mkey_mask = frwr_mkey_mask();
 }
@@ -4678,12 +4676,14 @@ static int set_psv_wr(struct ib_sig_domain *domain,
 
 static int set_reg_wr(struct mlx5_ib_qp *qp,
 		      const struct ib_reg_wr *wr,
-		      void **seg, int *size, void **cur_edge)
+		      void **seg, int *size, void **cur_edge,
+		      bool check_not_free)
 {
 	struct mlx5_ib_mr *mr = to_mmr(wr->mr);
 	struct mlx5_ib_pd *pd = to_mpd(qp->ibqp.pd);
 	size_t mr_list_size = mr->ndescs * mr->desc_size;
 	bool umr_inline = mr_list_size <= MLX5_IB_SQ_UMR_INLINE_THRESHOLD;
+	u8 flags = 0;
 
 	if (unlikely(wr->wr.send_flags & IB_SEND_INLINE)) {
 		mlx5_ib_warn(to_mdev(qp->ibqp.device),
@@ -4691,7 +4691,12 @@ static int set_reg_wr(struct mlx5_ib_qp *qp,
 		return -EINVAL;
 	}
 
-	set_reg_umr_seg(*seg, mr, umr_inline);
+	if (check_not_free)
+		flags |= MLX5_UMR_CHECK_NOT_FREE;
+	if (umr_inline)
+		flags |= MLX5_UMR_INLINE;
+
+	set_reg_umr_seg(*seg, mr, flags);
 	*seg += sizeof(struct mlx5_wqe_umr_ctrl_seg);
 	*size += sizeof(struct mlx5_wqe_umr_ctrl_seg) / 16;
 	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
@@ -4923,7 +4928,7 @@ static int _mlx5_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 				qp->sq.wr_data[idx] = IB_WR_REG_MR;
 				ctrl->imm = cpu_to_be32(reg_wr(wr)->key);
 				err = set_reg_wr(qp, reg_wr(wr), &seg, &size,
-						 &cur_edge);
+						 &cur_edge, true);
 				if (err) {
 					*bad_wr = wr;
 					goto out;
-- 
2.16.3

