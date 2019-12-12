Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1566E11C8E5
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfLLJM1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:12:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728147AbfLLJM0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:12:26 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2D63214D8;
        Thu, 12 Dec 2019 09:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576141945;
        bh=nOvqCIr1zkJKaAaw1jgCqcFCfADixbZOl3kgPkCh4hM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IcvgXvuCoIDxYwsDnYlPAqV/qB7dU9xeT5dJeaF+MXB0GFeAHM6qBxe1UEGCSYCsj
         I7KKG7M2BMcqgqevWF5SPwviDAAqxWSe1oMW65gSmXk/AoLUSeAvCUa2t8hUU8ifhG
         H9ITjPt4nJYGjnCpEcl+qKq9jACby+rrFF/C8Sio=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Eli Cohen <eli@mellanox.co.il>, Ido Kalir <idok@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Raed Salem <raeds@mellanox.com>
Subject: [PATCH rdma-rc 2/3] IB/mlx4: Follow mirror sequence of device add during device removal
Date:   Thu, 12 Dec 2019 11:12:13 +0200
Message-Id: <20191212091214.315005-3-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212091214.315005-1-leon@kernel.org>
References: <20191212091214.315005-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

Current code device add sequence is:

ib_register_device()
ib_mad_init()
init_sriov_init()
register_netdev_notifier()

Therefore, the remove sequence should be,

unregister_netdev_notifier()
close_sriov()
mad_cleanup()
ib_unregister_device()

However it is not above.
Hence, make do above remove sequence.

Fixes: fa417f7b520ee ("IB/mlx4: Add support for IBoE")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx4/main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 0b5dc1d5928f..34055cbab38c 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -3018,16 +3018,17 @@ static void mlx4_ib_remove(struct mlx4_dev *dev, void *ibdev_ptr)
 	ibdev->ib_active = false;
 	flush_workqueue(wq);
 
-	mlx4_ib_close_sriov(ibdev);
-	mlx4_ib_mad_cleanup(ibdev);
-	ib_unregister_device(&ibdev->ib_dev);
-	mlx4_ib_diag_cleanup(ibdev);
 	if (ibdev->iboe.nb.notifier_call) {
 		if (unregister_netdevice_notifier(&ibdev->iboe.nb))
 			pr_warn("failure unregistering notifier\n");
 		ibdev->iboe.nb.notifier_call = NULL;
 	}
 
+	mlx4_ib_close_sriov(ibdev);
+	mlx4_ib_mad_cleanup(ibdev);
+	ib_unregister_device(&ibdev->ib_dev);
+	mlx4_ib_diag_cleanup(ibdev);
+
 	mlx4_qp_release_range(dev, ibdev->steer_qpn_base,
 			      ibdev->steer_qpn_count);
 	kfree(ibdev->ib_uc_qpns_bitmap);
-- 
2.20.1

