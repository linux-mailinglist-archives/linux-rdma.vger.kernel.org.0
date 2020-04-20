Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B301B0F9B
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 17:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgDTPMH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 11:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbgDTPMG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 11:12:06 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9402A2074F;
        Mon, 20 Apr 2020 15:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587395526;
        bh=7CYBQKQ0BJYXCPb0cJRhoykCbiEiKdbzlBGUYToAruc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXTZ0qx7wdp/6mHXgLhK7XuZprooDsuefIG+SzSbYcubMFpk0vgqF+tQM/+zcEMvJ
         U0oSIaO5Qi4Dph6FxlJmZSmLrsLj6ySGzKjeoij1NdrT9mPjkARkMtC8FHcuyDdXy4
         SuEHW45pLT6XfBfJ1EahPo4o4THSyxjoqmMwd0Yo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 16/18] RDMA/mlx5: Change scatter CQE flag to be set like other vendor flags
Date:   Mon, 20 Apr 2020 18:11:03 +0300
Message-Id: <20200420151105.282848-17-leon@kernel.org>
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

In similar way to wqe_sig, the scat_cqe was treated differently from
other create QP vendor flags. Change it to be similar to other flags
and use flags_en mechanism.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 -
 drivers/infiniband/hw/mlx5/qp.c      | 17 ++++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 251380ff5706..9451aa836df0 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -446,7 +446,6 @@ struct mlx5_ib_qp {
 	u32			flags;
 	u8			port;
 	u8			state;
-	int			scat_cqe;
 	int			max_inline_data;
 	struct mlx5_bf	        bf;
 	u8			has_rq:1;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index a3c693ce1865..8facbaa0ce5a 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2019,9 +2019,10 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 
 		if (ucmd->flags & MLX5_QP_FLAG_SIGNATURE)
 			qp->flags_en |= MLX5_QP_FLAG_SIGNATURE;
-		if (MLX5_CAP_GEN(dev->mdev, sctr_data_cqe))
-			qp->scat_cqe =
-				!!(ucmd->flags & MLX5_QP_FLAG_SCATTER_CQE);
+		if (ucmd->flags & MLX5_QP_FLAG_SCATTER_CQE &&
+		    MLX5_CAP_GEN(dev->mdev, sctr_data_cqe))
+			qp->flags_en |= MLX5_QP_FLAG_SCATTER_CQE;
+
 		if (ucmd->flags & MLX5_QP_FLAG_TUNNEL_OFFLOADS) {
 			if (init_attr->qp_type != IB_QPT_RAW_PACKET ||
 			    !tunnel_offload_supported(mdev)) {
@@ -2137,8 +2138,9 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		MLX5_SET(qpc, qpc, cd_slave_receive, 1);
 	if (qp->flags_en & MLX5_QP_FLAG_PACKET_BASED_CREDIT_MODE)
 		MLX5_SET(qpc, qpc, req_e2e_credit_mode, 1);
-	if (qp->scat_cqe && (init_attr->qp_type == IB_QPT_RC ||
-			     init_attr->qp_type == IB_QPT_UC)) {
+	if ((qp->flags_en & MLX5_QP_FLAG_SCATTER_CQE) &&
+	    (init_attr->qp_type == IB_QPT_RC ||
+	     init_attr->qp_type == IB_QPT_UC)) {
 		int rcqe_sz = rcqe_sz =
 			mlx5_ib_get_cqe_size(init_attr->recv_cq);
 
@@ -2146,8 +2148,9 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			 rcqe_sz == 128 ? MLX5_RES_SCAT_DATA64_CQE :
 					  MLX5_RES_SCAT_DATA32_CQE);
 	}
-	if (qp->scat_cqe && (qp->qp_sub_type == MLX5_IB_QPT_DCI ||
-			     init_attr->qp_type == IB_QPT_RC))
+	if ((qp->flags_en & MLX5_QP_FLAG_SCATTER_CQE) &&
+	    (qp->qp_sub_type == MLX5_IB_QPT_DCI ||
+	     init_attr->qp_type == IB_QPT_RC))
 		configure_requester_scat_cqe(dev, init_attr, ucmd, qpc);
 
 	if (qp->rq.wqe_cnt) {
-- 
2.25.2

