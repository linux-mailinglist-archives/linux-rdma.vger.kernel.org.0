Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44839432DF7
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Oct 2021 08:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbhJSGST (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 02:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234157AbhJSGSS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Oct 2021 02:18:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA11260FD8;
        Tue, 19 Oct 2021 06:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634624166;
        bh=mx/BkxT0o8Xb5VpFFH8AkWfA1dK+acaE7dGk1O65ts8=;
        h=From:To:Cc:Subject:Date:From;
        b=qF1riMWAcm6LnyBf8yBTOGBE7s10q4a++uW/BehxggTqrejzar0Wh2HguhQeb4TK4
         ofRPU0EOWCva3d5EQzEqRQrptw5FEnSZYPiem3xcchgaOErjGcn2SM0ONQhn0dJAmk
         3uIGb3+JLq6sQJ+XNz1g+I8knEf9PpM5CmvOYsfw7bJdkACWcX3oEb2lTgokK31Y9s
         ++q+QO4piqpm20AvgxF9kTfMCBJZnRb+1Si7gGwj6yH9rD6pNmM24HrBkJUuUoXs9U
         ygcD8VsVvvLmOtH/KXdrR2ok4YzKuE400e++vKCy0KQA2LmwA6l7jQcs21n4wWtP6L
         J47d2HdpBUY5w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>,
        Mark Zhang <markzhang@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Mark Bloch <mbloch@nvidia.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] RDMA/mlx5: fix build error with INFINIBAND_USER_ACCESS=n
Date:   Tue, 19 Oct 2021 08:15:45 +0200
Message-Id: <20211019061602.3062196-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The mlx5_ib_fs_add_op_fc/mlx5_ib_fs_remove_op_fc functions are
only available when user access is enabled, without that we
run into a link error:

ERROR: modpost: "mlx5_ib_fs_add_op_fc" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
ERROR: modpost: "mlx5_ib_fs_remove_op_fc" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!

Conditionally compiling the newly added code section makes
it build, though this is probably not a correct fix.

Fixes: a29b934ceb4c ("RDMA/mlx5: Add modify_op_stat() support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/hw/mlx5/counters.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 6f1c4b57110e..945758f39523 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -641,9 +641,9 @@ static void mlx5_ib_dealloc_counters(struct mlx5_ib_dev *dev)
 			if (!dev->port[i].cnts.opfcs[j].fc)
 				continue;
 
-			mlx5_ib_fs_remove_op_fc(dev,
-						&dev->port[i].cnts.opfcs[j],
-						j);
+			if (IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS))
+				mlx5_ib_fs_remove_op_fc(dev,
+					&dev->port[i].cnts.opfcs[j], j);
 			mlx5_fc_destroy(dev->mdev,
 					dev->port[i].cnts.opfcs[j].fc);
 			dev->port[i].cnts.opfcs[j].fc = NULL;
@@ -885,7 +885,8 @@ static const struct ib_device_ops hw_stats_ops = {
 	.counter_dealloc = mlx5_ib_counter_dealloc,
 	.counter_alloc_stats = mlx5_ib_counter_alloc_stats,
 	.counter_update_stats = mlx5_ib_counter_update_stats,
-	.modify_hw_stat = mlx5_ib_modify_stat,
+	.modify_hw_stat = IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS) ?
+			  mlx5_ib_modify_stat : NULL,
 };
 
 static const struct ib_device_ops hw_switchdev_stats_ops = {
-- 
2.29.2

