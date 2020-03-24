Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA5A419056B
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2020 07:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgCXGCF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Mar 2020 02:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgCXGCF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Mar 2020 02:02:05 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 281622073E;
        Tue, 24 Mar 2020 06:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585029724;
        bh=LFuNmi3SJNV+4oLUm2d4w1E/a6biq/zrTTjEii8FL60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2aZtnTXurGtjQQVB5ZWzDj3eIbm3YMkTUiSekUOsWl5SLqY7dnnSX+Y0K0OqunFx
         pjkVmXSWmOpFCNoStmNjuw9yVwMv9OW4fXJITnKOCSds6X874i6CRT0kVhcfiz9bT4
         rT0T8zhP5my7VUkpE+KftBXHY95aZbaQ6qnCrAhw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@mellanox.com>
Subject: [PATCH rdma-next v1 3/5] IB/mlx5: Extend QP creation to get uar page index from user space
Date:   Tue, 24 Mar 2020 08:01:41 +0200
Message-Id: <20200324060143.1569116-4-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200324060143.1569116-1-leon@kernel.org>
References: <20200324060143.1569116-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Extend QP creation to get uar page index from user space, this mode can
be used with the UAR dynamic mode APIs to allocate/destroy a UAR object.

As part of enabling this option blocked the weird/un-supported cross
channel option which uses index 0 hard-coded.

This QP flag wasn't exposed to user space as part of any formal upstream
release, the dynamic option can allow having valid UAR page index
instead.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Reviewed-by: Michael Guralnik <michaelgur@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 27 +++++++++++++++++----------
 include/uapi/rdma/mlx5-abi.h    |  1 +
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index cf44c5a21f18..3acdc31d75d3 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -919,6 +919,7 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	void *qpc;
 	int err;
 	u16 uid;
+	u32 uar_flags;
 
 	err = ib_copy_from_udata(&ucmd, udata, sizeof(ucmd));
 	if (err) {
@@ -928,24 +929,29 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 
 	context = rdma_udata_to_drv_context(udata, struct mlx5_ib_ucontext,
 					    ibucontext);
-	if (ucmd.flags & MLX5_QP_FLAG_BFREG_INDEX) {
+	uar_flags = ucmd.flags & (MLX5_QP_FLAG_UAR_PAGE_INDEX |
+				  MLX5_QP_FLAG_BFREG_INDEX);
+	switch (uar_flags) {
+	case MLX5_QP_FLAG_UAR_PAGE_INDEX:
+		uar_index = ucmd.bfreg_index;
+		bfregn = MLX5_IB_INVALID_BFREG;
+		break;
+	case MLX5_QP_FLAG_BFREG_INDEX:
 		uar_index = bfregn_to_uar_index(dev, &context->bfregi,
 						ucmd.bfreg_index, true);
 		if (uar_index < 0)
 			return uar_index;
-
 		bfregn = MLX5_IB_INVALID_BFREG;
-	} else if (qp->flags & MLX5_IB_QP_CROSS_CHANNEL) {
-		/*
-		 * TBD: should come from the verbs when we have the API
-		 */
-		/* In CROSS_CHANNEL CQ and QP must use the same UAR */
-		bfregn = MLX5_CROSS_CHANNEL_BFREG;
-	}
-	else {
+		break;
+	case 0:
+		if (qp->flags & MLX5_IB_QP_CROSS_CHANNEL)
+			return -EINVAL;
 		bfregn = alloc_bfreg(dev, &context->bfregi);
 		if (bfregn < 0)
 			return bfregn;
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	mlx5_ib_dbg(dev, "bfregn 0x%x, uar_index 0x%x\n", bfregn, uar_index);
@@ -2100,6 +2106,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 				      MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_MC |
 				      MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_UC |
 				      MLX5_QP_FLAG_TUNNEL_OFFLOADS |
+				      MLX5_QP_FLAG_UAR_PAGE_INDEX |
 				      MLX5_QP_FLAG_TYPE_DCI |
 				      MLX5_QP_FLAG_TYPE_DCT))
 			return -EINVAL;
diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
index e900f9a64feb..a65d60b44829 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -49,6 +49,7 @@ enum {
 	MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_MC = 1 << 7,
 	MLX5_QP_FLAG_ALLOW_SCATTER_CQE	= 1 << 8,
 	MLX5_QP_FLAG_PACKET_BASED_CREDIT_MODE	= 1 << 9,
+	MLX5_QP_FLAG_UAR_PAGE_INDEX = 1 << 10,
 };
 
 enum {
-- 
2.24.1

