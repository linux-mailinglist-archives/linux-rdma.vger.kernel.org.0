Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E231D0D75
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 11:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbgEMJxK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 05:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387896AbgEMJxJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 05:53:09 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E77120740;
        Wed, 13 May 2020 09:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363589;
        bh=Ex2dLttya9xF9UGQgq3Dtgh4sGbKhqOHRz+Cc+4c78A=;
        h=From:To:Cc:Subject:Date:From;
        b=eF+i5yVW0u121E5uVBN3Q5QeGa1nKdGTXkpowgQc+eiV8CXP/xn5BHrD2U5Le6dI2
         zfaKitbg5GWEoShfEhXyohtaH7x7VHe9NJf7ATcPFyFbTkcumUXAlzEfYtZT7vHY9Q
         oQlqgnXLbWK8sLSsmmXPFjpHFbx7zJsNeFHMVhXY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Shay Drory <shayd@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Update mlx5_ib driver name
Date:   Wed, 13 May 2020 12:53:04 +0300
Message-Id: <20200513095304.210240-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shay Drory <shayd@mellanox.com>

Current description doesn't include new devices, change it
by updating to have more generic description and remove
DRIVER_NAME and DRIVER_VERSION defines.

Signed-off-by: Shay Drory <shayd@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index a707576a8337..3a9dde1f4bd9 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -72,17 +72,10 @@
 #define UVERBS_MODULE_NAME mlx5_ib
 #include <rdma/uverbs_named_ioctl.h>

-#define DRIVER_NAME "mlx5_ib"
-#define DRIVER_VERSION "5.0-0"
-
 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
-MODULE_DESCRIPTION("Mellanox Connect-IB HCA IB driver");
+MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) IB driver");
 MODULE_LICENSE("Dual BSD/GPL");

-static char mlx5_version[] =
-	DRIVER_NAME ": Mellanox Connect-IB Infiniband driver v"
-	DRIVER_VERSION "\n";
-
 struct mlx5_ib_event_work {
 	struct work_struct	work;
 	union {
@@ -7316,8 +7309,6 @@ static void *mlx5_ib_add(struct mlx5_core_dev *mdev)
 	int port_type_cap;
 	int num_ports;

-	printk_once(KERN_INFO "%s", mlx5_version);
-
 	if (MLX5_ESWITCH_MANAGER(mdev) &&
 	    mlx5_ib_eswitch_mode(mdev->priv.eswitch) == MLX5_ESWITCH_OFFLOADS) {
 		if (!mlx5_core_mp_enabled(mdev))
--
2.26.2

