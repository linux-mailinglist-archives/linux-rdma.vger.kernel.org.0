Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA1B2F4B2C
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jan 2021 13:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbhAMMSb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jan 2021 07:18:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbhAMMSa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Jan 2021 07:18:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB5D5233FB;
        Wed, 13 Jan 2021 12:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610540244;
        bh=CbktahbK99utKTVn4CU8vpNPvsoHlJP+PdzkQQuZyXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VZUX+xWkE26rd4X5E0exBj6uhBww6BY61LDf4PEqR6yHFE7Yo0ebqN3DctHiFYqzf
         +AhqupAxlShHOhe4G9/EyjCjJ3kz3A4hvPVKCWDH09HVFJE+77h0hUkaQ1KOXF19cU
         y+geDLZQkwO1VkOuBiSLt5tWzZP446tom52gBjhTfxTUtlGIw9nqRcDJxIz1ixIjpV
         K4+LKUz1hu75x3r8pLp8PNvZh0fFU6GxCFHwfYLdbXGA74trmfQ5fYlUmn0orB9uvp
         P1ITV823RoZkAfMQNgBu5YY43/WV7yJ8CcI/yGgpeKxmB6qyPMtEoR5FhnPwkdULEv
         Pvfo56espPomQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Bloch <mbloch@nvidia.com>, Aharon Landau <aharonl@nvidia.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Parav Pandit <parav@nvidia.com>,
        Hans Petter Selasky <hanss@nvidia.com>
Subject: [PATCH rdma-next 5/5] RDMA/mlx5: Fix wrong free of blue flame register on error
Date:   Wed, 13 Jan 2021 14:17:03 +0200
Message-Id: <20210113121703.559778-6-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113121703.559778-1-leon@kernel.org>
References: <20210113121703.559778-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Bloch <mbloch@nvidia.com>

If the allocation of the fast path blue flame register fails, the driver
should free the regular blue flame register.

Fixes: 16c1975f1032 ("IB/mlx5: Create profile infrastructure to add and remove stage")
Reported-by: Hans Petter Selasky <hanss@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 84309bcd67d5..427221a13fbc 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4340,7 +4340,7 @@ static int mlx5_ib_stage_bfrag_init(struct mlx5_ib_dev *dev)

 	err = mlx5_alloc_bfreg(dev->mdev, &dev->fp_bfreg, false, true);
 	if (err)
-		mlx5_free_bfreg(dev->mdev, &dev->fp_bfreg);
+		mlx5_free_bfreg(dev->mdev, &dev->bfreg);

 	return err;
 }
--
2.29.2

