Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D00028E708
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 10:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfHOIjI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 04:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfHOIjI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Aug 2019 04:39:08 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4957A2235C;
        Thu, 15 Aug 2019 08:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565858346;
        bh=dbN+XXnlU1qrx6bVOtm2DUsShhgBs0OtQPX9viZgMjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jycaABpmgxXrkzaVTd6seURo7XP8cqIx8OuAWxaPjnpy2KPGTN4vfKB1l4AV8MAXW
         AFST4T2w+D29jFLrmzeSlV8FQfX7ydL8q9ZmXIANahdZQOq6hfSJghkBqqdHuWE6Ip
         PDHb/xjyc9BUJBQyquqFCie0aoMRthjfYfHLHgDA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Ido Kalir <idok@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-rc 8/8] IB/mlx5: Block MR WR if UMR is not possible
Date:   Thu, 15 Aug 2019 11:38:34 +0300
Message-Id: <20190815083834.9245-9-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815083834.9245-1-leon@kernel.org>
References: <20190815083834.9245-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Moni Shoua <monis@mellanox.com>

Check conditions that are mandatory to post_send UMR WQEs.
1. Modifying page size.
2. Modifying remote atomic permissions if atomic access is required.

If either condition is not fulfilled then fail to post_send() flow.

Fixes: c8d75a980fab ("IB/mlx5: Respect new UMR capabilities")
Signed-off-by: Moni Shoua <monis@mellanox.com>
Reviewed-by: Guy Levi <guyle@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 379328b2598f..72869ff4a334 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4162,7 +4162,7 @@ static u64 get_xlt_octo(u64 bytes)
 	       MLX5_IB_UMR_OCTOWORD;
 }

-static __be64 frwr_mkey_mask(void)
+static __be64 frwr_mkey_mask(bool atomic)
 {
 	u64 result;

@@ -4175,10 +4175,12 @@ static __be64 frwr_mkey_mask(void)
 		MLX5_MKEY_MASK_LW		|
 		MLX5_MKEY_MASK_RR		|
 		MLX5_MKEY_MASK_RW		|
-		MLX5_MKEY_MASK_A		|
 		MLX5_MKEY_MASK_SMALL_FENCE	|
 		MLX5_MKEY_MASK_FREE;

+	if (atomic)
+		result |= MLX5_MKEY_MASK_A;
+
 	return cpu_to_be64(result);
 }

@@ -4204,7 +4206,7 @@ static __be64 sig_mkey_mask(void)
 }

 static void set_reg_umr_seg(struct mlx5_wqe_umr_ctrl_seg *umr,
-			    struct mlx5_ib_mr *mr, u8 flags)
+			    struct mlx5_ib_mr *mr, u8 flags, bool atomic)
 {
 	int size = (mr->ndescs + mr->meta_ndescs) * mr->desc_size;

@@ -4212,7 +4214,7 @@ static void set_reg_umr_seg(struct mlx5_wqe_umr_ctrl_seg *umr,

 	umr->flags = flags;
 	umr->xlt_octowords = cpu_to_be16(get_xlt_octo(size));
-	umr->mkey_mask = frwr_mkey_mask();
+	umr->mkey_mask = frwr_mkey_mask(atomic);
 }

 static void set_linv_umr_seg(struct mlx5_wqe_umr_ctrl_seg *umr)
@@ -4811,10 +4813,22 @@ static int set_reg_wr(struct mlx5_ib_qp *qp,
 {
 	struct mlx5_ib_mr *mr = to_mmr(wr->mr);
 	struct mlx5_ib_pd *pd = to_mpd(qp->ibqp.pd);
+	struct mlx5_ib_dev *dev = to_mdev(pd->ibpd.device);
 	int mr_list_size = (mr->ndescs + mr->meta_ndescs) * mr->desc_size;
 	bool umr_inline = mr_list_size <= MLX5_IB_SQ_UMR_INLINE_THRESHOLD;
+	bool atomic = wr->access & IB_ACCESS_REMOTE_ATOMIC;
 	u8 flags = 0;

+	if (!mlx5_ib_can_use_umr(dev, atomic)) {
+		mlx5_ib_warn(to_mdev(qp->ibqp.device),
+			     "Fast update of %s for MR is disabled\n",
+			     (MLX5_CAP_GEN(dev->mdev,
+					   umr_modify_entity_size_disabled)) ?
+				     "entity size" :
+				     "atomic access");
+		return -EINVAL;
+	}
+
 	if (unlikely(wr->wr.send_flags & IB_SEND_INLINE)) {
 		mlx5_ib_warn(to_mdev(qp->ibqp.device),
 			     "Invalid IB_SEND_INLINE send flag\n");
@@ -4826,7 +4840,7 @@ static int set_reg_wr(struct mlx5_ib_qp *qp,
 	if (umr_inline)
 		flags |= MLX5_UMR_INLINE;

-	set_reg_umr_seg(*seg, mr, flags);
+	set_reg_umr_seg(*seg, mr, flags, atomic);
 	*seg += sizeof(struct mlx5_wqe_umr_ctrl_seg);
 	*size += sizeof(struct mlx5_wqe_umr_ctrl_seg) / 16;
 	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
--
2.20.1

