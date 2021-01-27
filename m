Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9A8305FBE
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 16:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhA0PfR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 10:35:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235516AbhA0PDf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Jan 2021 10:03:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8A2B2137B;
        Wed, 27 Jan 2021 15:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611759637;
        bh=xbtozgcP4p9018Ok8BMcwSdWh6sy1q1vVRuen6HmaDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFOrrstPFVENjJaGkybglmhewuLEyr4AjOGG8zBzHudD+SmL/Q2TfXx1ZwTxNNwqu
         /cTeRyNDGeXvBXMD4TfF7opE4KGFiQZik8YQPpUDR2T/u0eqleEiDoQLMefItTUfhX
         W9iduBL8N45JYKUtvmxyz+ZQcCbNioDldlfJXlEeJEP8hYmHkUSQ/FA2F5Q71+cRQ0
         3LWHZ5V6YQzPbHqCBBD4c2A/6hKwYvRFzC1MG8YFelXbMd4H09r0DFsv98SxTs09mP
         R3KrJOjKt5FTHI7bvK+vdbjiM4mVycADE6mMQzMmZxl1+GK6FJ7g0RHdE4IHbX+mMw
         MOvyCH6tzqeDQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Bloch <markb@mellanox.com>
Subject: [PATCH rdma-next 07/10] IB/mlx5: Return appropriate error code instead of ENOMEM
Date:   Wed, 27 Jan 2021 17:00:07 +0200
Message-Id: <20210127150010.1876121-8-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127150010.1876121-1-leon@kernel.org>
References: <20210127150010.1876121-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@nvidia.com>

When mlx5_ib_stage_init_init() fails, return the error code related to
failure instead of -ENOMEM.

Fixes: 16c1975f1032 ("IB/mlx5: Create profile infrastructure to add and remove stages")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 3 +--
 drivers/infiniband/hw/mlx5/odp.c  | 4 ----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index ad7bb37e501d..9e8b4d591138 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3952,8 +3952,7 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)

 err_mp:
 	mlx5_ib_cleanup_multiport_master(dev);
-
-	return -ENOMEM;
+	return err;
 }

 static int mlx5_ib_enable_driver(struct ib_device *dev)
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index f4b82daf1e22..a1be8fb2800e 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -484,10 +484,6 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	}

 	xa_lock(&imr->implicit_children);
-	/*
-	 * Once the store to either xarray completes any error unwind has to
-	 * use synchronize_srcu(). Avoid this with xa_reserve()
-	 */
 	ret = __xa_cmpxchg(&imr->implicit_children, idx, NULL, mr,
 			   GFP_KERNEL);
 	if (unlikely(ret)) {
--
2.29.2

