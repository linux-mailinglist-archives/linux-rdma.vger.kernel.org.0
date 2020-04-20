Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937F81B0F81
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 17:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgDTPLw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 11:11:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgDTPLw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 11:11:52 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB1392074F;
        Mon, 20 Apr 2020 15:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587395511;
        bh=DUmkt6Lrha8wJQHIBM3kRyTc4vQe7zG0ZQ5TZFlH7yM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vrjh49Nn9j1o7JrHSKg32ZgPEZTzp1iHGLPIeB/K1Qs9F/pODkmOYCdlZ1UXPT1Ho
         lVTdxfhCPDpNRggvUUZqprBpI9VD0HgR9SDa2IXUEHaaYYt7y8mQe1KWX63guNw19D
         DmjjrrSFDXzDwoJDdRRla8Z9YHlk1fwCkLCXNFU8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 12/18] RDMA/mlx5: Initial separation of RAW_PACKET QP from common flow
Date:   Mon, 20 Apr 2020 18:10:59 +0300
Message-Id: <20200420151105.282848-13-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200420151105.282848-1-leon@kernel.org>
References: <20200420151105.282848-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Create initial function for IB_QPT_RAW_PACKET flow.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index ac65fc37b805..f50a006472c2 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1634,13 +1634,13 @@ static void destroy_rss_raw_qp_tir(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *q
 			     to_mpd(qp->ibqp.pd)->uid);
 }
 
-static int create_rss_raw_qp_tir(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
-				 struct ib_pd *pd,
+static int create_rss_raw_qp_tir(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 				 struct ib_qp_init_attr *init_attr,
 				 struct ib_udata *udata)
 {
 	struct mlx5_ib_ucontext *mucontext = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
+	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_ib_create_qp_resp resp = {};
 	int inlen;
 	int outlen;
@@ -1996,9 +1996,6 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (mlx5_st < 0)
 		return -EINVAL;
 
-	if (init_attr->rwq_ind_tbl)
-		return create_rss_raw_qp_tir(dev, qp, pd, init_attr, udata);
-
 	if (init_attr->create_flags & IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK) {
 		if (!MLX5_CAP_GEN(mdev, block_lb_mc)) {
 			mlx5_ib_dbg(dev, "block multicast loopback isn't supported\n");
@@ -2712,6 +2709,18 @@ static size_t process_udata_size(struct ib_qp_init_attr *attr,
 	return ucmd;
 }
 
+static int create_raw_qp(struct ib_pd *pd, struct mlx5_ib_qp *qp,
+			 struct ib_qp_init_attr *attr,
+			 struct mlx5_ib_create_qp *ucmd, struct ib_udata *udata)
+{
+	struct mlx5_ib_dev *dev = to_mdev(pd->device);
+
+	if (attr->rwq_ind_tbl)
+		return create_rss_raw_qp_tir(pd, qp, attr, udata);
+
+	return create_qp_common(dev, pd, attr, ucmd, udata, qp);
+}
+
 struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 				struct ib_qp_init_attr *init_attr,
 				struct ib_udata *udata)
@@ -2768,6 +2777,9 @@ struct ib_qp *mlx5_ib_create_qp(struct ib_pd *pd,
 	case IB_QPT_DRIVER:
 		err = create_driver_qp(pd, qp, init_attr, &ucmd, udata);
 		break;
+	case IB_QPT_RAW_PACKET:
+		err = create_raw_qp(pd, qp, init_attr, &ucmd, udata);
+		break;
 	default:
 		err = create_qp_common(dev, pd, init_attr,
 				       (udata) ? &ucmd : NULL, udata, qp);
-- 
2.25.2

