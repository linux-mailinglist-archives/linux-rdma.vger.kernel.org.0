Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49DD273E32
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 11:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgIVJLQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 05:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgIVJLQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 05:11:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D82DF20C09;
        Tue, 22 Sep 2020 09:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600765875;
        bh=EzqJ7VUWwmXig0zSu7HibRzW6Vq4SKBW7qep/hsQ4RE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0+8U44a0/wztZGIQCKko8JOesPf36qjpHigIesx4oAdmJO8yCu4gUIDWWWjbaeYq
         dWUJegwm0AafjNaCbYv2Ckco5r3LBG3C6V/LLb0nDwFdp7dZtoJqxBkFvzyKMze4z1
         qlXS4E/XJ7JMZMX5anqlwYjLklaFix/93gaHZzBo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@nvidia.com>
Subject: [PATCH rdma-next v3 2/5] RDMA/mlx5: Don't call to restrack recursively
Date:   Tue, 22 Sep 2020 12:11:03 +0300
Message-Id: <20200922091106.2152715-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200922091106.2152715-1-leon@kernel.org>
References: <20200922091106.2152715-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The restrack is going to manage memory of all IB objects and must be
called before object is created. GSI QP in the mlx5_ib separated between
creating dummy interface and HW object beneath. This was achieved by
double call to ib_create_qp().

In order to skip such reentry call to internal driver create_qp code.

Reviewed-by: Mark Zhang <markz@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/gsi.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/gsi.c b/drivers/infiniband/hw/mlx5/gsi.c
index 40d418153891..d9f300f78a82 100644
--- a/drivers/infiniband/hw/mlx5/gsi.c
+++ b/drivers/infiniband/hw/mlx5/gsi.c
@@ -182,13 +182,25 @@ struct ib_qp *mlx5_ib_gsi_create_qp(struct ib_pd *pd,
 		hw_init_attr.cap.max_send_sge = 0;
 		hw_init_attr.cap.max_inline_data = 0;
 	}
-	gsi->rx_qp = ib_create_qp(pd, &hw_init_attr);
+
+	gsi->rx_qp = mlx5_ib_create_qp(pd, &hw_init_attr, NULL);
 	if (IS_ERR(gsi->rx_qp)) {
 		mlx5_ib_warn(dev, "unable to create hardware GSI QP. error %ld\n",
 			     PTR_ERR(gsi->rx_qp));
 		ret = PTR_ERR(gsi->rx_qp);
 		goto err_destroy_cq;
 	}
+	gsi->rx_qp->device = pd->device;
+	gsi->rx_qp->pd = pd;
+	gsi->rx_qp->real_qp = gsi->rx_qp;
+
+	gsi->rx_qp->qp_type = hw_init_attr.qp_type;
+	gsi->rx_qp->send_cq = hw_init_attr.send_cq;
+	gsi->rx_qp->recv_cq = hw_init_attr.recv_cq;
+	gsi->rx_qp->event_handler = hw_init_attr.event_handler;
+	spin_lock_init(&gsi->rx_qp->mr_lock);
+	INIT_LIST_HEAD(&gsi->rx_qp->rdma_mrs);
+	INIT_LIST_HEAD(&gsi->rx_qp->sig_mrs);
 
 	dev->devr.ports[init_attr->port_num - 1].gsi = gsi;
 
@@ -219,7 +231,7 @@ int mlx5_ib_gsi_destroy_qp(struct ib_qp *qp)
 	mlx5_ib_dbg(dev, "destroying GSI QP\n");
 
 	mutex_lock(&dev->devr.mutex);
-	ret = ib_destroy_qp(gsi->rx_qp);
+	ret = mlx5_ib_destroy_qp(gsi->rx_qp, NULL);
 	if (ret) {
 		mlx5_ib_warn(dev, "unable to destroy hardware GSI QP. error %d\n",
 			     ret);
-- 
2.26.2

