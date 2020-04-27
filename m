Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790A61BA8F1
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 17:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgD0Psg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 11:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbgD0Psf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 11:48:35 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 636E3206B6;
        Mon, 27 Apr 2020 15:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588002515;
        bh=r4jxNMnk+eaQn5YS8d/bUsCYlE8qyvA7q3gSmhXitJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WccEWBjFK1NpNff3lBgX4BCQDGZtdOWuWIQBvVwrslwq6hdwzSTcjZ8Mv4LzlSh5G
         Ylpj+Hi5nGFiACFpXVj+pJK+qTLbgV+0U7NVDYXkcbNbiJ+1H5KuW3iQbfF5cXeMq+
         u1vz99W8DwH+0RWBb52oZU/MkXxe8Px0E7ikb3p0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1 31/36] RDMA/mlx5: Promote RSS RAW QP flags check to higher level
Date:   Mon, 27 Apr 2020 18:46:31 +0300
Message-Id: <20200427154636.381474-32-leon@kernel.org>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200427154636.381474-1-leon@kernel.org>
References: <20200427154636.381474-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Move check that user didn't supplied RSS RAW QP unsupported
command flags to the function that checks all such flags.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 3807e1687cb2..8daa8bc6b9c7 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1652,13 +1652,6 @@ static int create_rss_raw_qp_tir(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		return -EOPNOTSUPP;
 	}
 
-	if (ucmd->flags & ~(MLX5_QP_FLAG_TUNNEL_OFFLOADS |
-			   MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_UC |
-			   MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_MC)) {
-		mlx5_ib_dbg(dev, "invalid flags\n");
-		return -EOPNOTSUPP;
-	}
-
 	if (ucmd->rx_hash_fields_mask & MLX5_RX_HASH_INNER &&
 	    !(ucmd->flags & MLX5_QP_FLAG_TUNNEL_OFFLOADS)) {
 		mlx5_ib_dbg(dev, "Tunnel offloads must be set for inner RSS\n");
@@ -2687,11 +2680,20 @@ static int process_vendor_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	process_vendor_flag(dev, &flags, MLX5_QP_FLAG_BFREG_INDEX, true, qp);
 	process_vendor_flag(dev, &flags, MLX5_QP_FLAG_UAR_PAGE_INDEX, true, qp);
 
+	cond = qp->flags_en & ~(MLX5_QP_FLAG_TUNNEL_OFFLOADS |
+				MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_UC |
+				MLX5_QP_FLAG_TIR_ALLOW_SELF_LB_MC);
+	if (attr->rwq_ind_tbl && cond) {
+		mlx5_ib_dbg(dev, "RSS RAW QP has unsupported flags 0x%X\n",
+			    cond);
+		return -EINVAL;
+	}
+
 	if (flags)
 		mlx5_ib_dbg(dev, "udata has unsupported flags 0x%X\n", flags);
 
 	return (flags) ? -EINVAL : 0;
-}
+	}
 
 static void process_create_flag(struct mlx5_ib_dev *dev, int *flags, int flag,
 				bool cond, struct mlx5_ib_qp *qp)
-- 
2.25.3

