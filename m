Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F13C279858
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Sep 2020 12:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgIZKZH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Sep 2020 06:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgIZKZH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 26 Sep 2020 06:25:07 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20477238E6;
        Sat, 26 Sep 2020 10:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601115906;
        bh=NBRIFt2oxpBRZQQ0dTyeugnvbikzSQEm0YGfiX1eZ9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMPhHefad1BIVhLSPNWpLcOTnnORvUbbTTSbzLSHTqYUoT2P1nto0CGwhGmAXuPnV
         fr8YKBrlFYVE28iMb/HS8P4+ijnT8H1Srn1NsUQx7Dawj+YiBlImsUYo2PgouBRF1S
         ffKmFXrJiFIwrNQw0Vd5facUy2cul2bwYjJV4zYg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 04/10] RDMA/mlx5: Delete not needed GSI QP signal QP type
Date:   Sat, 26 Sep 2020 13:24:44 +0300
Message-Id: <20200926102450.2966017-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200926102450.2966017-1-leon@kernel.org>
References: <20200926102450.2966017-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

GSI QP doesn't need signal QP type because it is initialized statically
to zero, which is IB_SIGNAL_ALL_WR also wr->send_flags isn't set too.
This means that the GSI QP signal QP type can be removed.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/gsi.c     | 8 +-------
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 1 -
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/gsi.c b/drivers/infiniband/hw/mlx5/gsi.c
index f5aa1167cb9c..7fcad9135276 100644
--- a/drivers/infiniband/hw/mlx5/gsi.c
+++ b/drivers/infiniband/hw/mlx5/gsi.c
@@ -35,7 +35,6 @@
 struct mlx5_ib_gsi_wr {
 	struct ib_cqe cqe;
 	struct ib_wc wc;
-	int send_flags;
 	bool completed:1;
 };
 
@@ -59,10 +58,7 @@ static void generate_completions(struct mlx5_ib_qp *mqp)
 		if (!wr->completed)
 			break;
 
-		if (gsi->sq_sig_type == IB_SIGNAL_ALL_WR ||
-		    wr->send_flags & IB_SEND_SIGNALED)
-			WARN_ON_ONCE(mlx5_ib_generate_wc(gsi_cq, &wr->wc));
-
+		WARN_ON_ONCE(mlx5_ib_generate_wc(gsi_cq, &wr->wc));
 		wr->completed = false;
 	}
 
@@ -132,7 +128,6 @@ int mlx5_ib_create_gsi(struct ib_pd *pd, struct mlx5_ib_qp *mqp,
 	spin_lock_init(&gsi->lock);
 
 	gsi->cap = attr->cap;
-	gsi->sq_sig_type = attr->sq_sig_type;
 	gsi->port_num = port_num;
 
 	gsi->cq = ib_alloc_cq(pd->device, gsi, attr->cap.max_send_wr, 0,
@@ -236,7 +231,6 @@ static struct ib_qp *create_gsi_ud_qp(struct mlx5_ib_gsi_qp *gsi)
 			.max_send_sge = gsi->cap.max_send_sge,
 			.max_inline_data = gsi->cap.max_inline_data,
 		},
-		.sq_sig_type = gsi->sq_sig_type,
 		.qp_type = IB_QPT_UD,
 		.create_flags = MLX5_IB_QP_CREATE_SQPN_QP1,
 	};
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 3261720d40e3..6ab3efb75b21 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -388,7 +388,6 @@ struct mlx5_ib_gsi_qp {
 	struct ib_qp *rx_qp;
 	u8 port_num;
 	struct ib_qp_cap cap;
-	enum ib_sig_type sq_sig_type;
 	struct ib_cq *cq;
 	struct mlx5_ib_gsi_wr *outstanding_wrs;
 	u32 outstanding_pi, outstanding_ci;
-- 
2.26.2

