Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA92E1B0F65
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 17:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgDTPLT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 11:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730109AbgDTPLS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 11:11:18 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A55292074F;
        Mon, 20 Apr 2020 15:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587395478;
        bh=EGC45ZxRaJvr9nxFWsV9x/zMGmLFLJZscGKoT+UzS0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V3IhCBD8UvbHa6IUpvLm3CN6DE5FBsMJGIm9cA7KEAVlCeM33PzQSvlVL5L+T/Uie
         0e6pMLazaQrLhqmVEZ9lrMBk48mN7T60QNsTDIV/ktZgI7+3G7T4C/I+ctDam+rv9U
         raekx4E8W8xLB7PAQLnDVwuAPHmssOJvlv7lR5xQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 02/18] RDMA/mlx5: Delete impossible GSI port check
Date:   Mon, 20 Apr 2020 18:10:49 +0300
Message-Id: <20200420151105.282848-3-leon@kernel.org>
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

GSI QP is created in the kernel with very strict parameters,
there is no possible way that port number will be wrong in
such flow.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/gsi.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/gsi.c b/drivers/infiniband/hw/mlx5/gsi.c
index fbae1c094fe2..40d418153891 100644
--- a/drivers/infiniband/hw/mlx5/gsi.c
+++ b/drivers/infiniband/hw/mlx5/gsi.c
@@ -122,8 +122,6 @@ struct ib_qp *mlx5_ib_gsi_create_qp(struct ib_pd *pd,
 	int num_qps = 0;
 	int ret;
 
-	mlx5_ib_dbg(dev, "creating GSI QP\n");
-
 	if (mlx5_ib_deth_sqpn_cap(dev)) {
 		if (MLX5_CAP_GEN(dev->mdev,
 				 port_type) == MLX5_CAP_PORT_TYPE_IB)
@@ -132,14 +130,6 @@ struct ib_qp *mlx5_ib_gsi_create_qp(struct ib_pd *pd,
 			num_qps = MLX5_MAX_PORTS;
 	}
 
-
-	if (port_num > ARRAY_SIZE(dev->devr.ports) || port_num < 1) {
-		mlx5_ib_warn(dev,
-			     "invalid port number %d during GSI QP creation\n",
-			     port_num);
-		return ERR_PTR(-EINVAL);
-	}
-
 	gsi = kzalloc(sizeof(*gsi), GFP_KERNEL);
 	if (!gsi)
 		return ERR_PTR(-ENOMEM);
-- 
2.25.2

