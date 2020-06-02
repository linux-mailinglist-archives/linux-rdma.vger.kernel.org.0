Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C001EBC27
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2020 14:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgFBM4F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jun 2020 08:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgFBM4F (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Jun 2020 08:56:05 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A040620663;
        Tue,  2 Jun 2020 12:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591102565;
        bh=unVZinT2gOU7hsvGVZzqxKhEy6rv8KylXMvMylvWtn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snqXsQqBm+XLfkVmClAMt5X7Y5RmlvI7ClfoH5C6VthUw0/FKH0wRtAytsBcsygyb
         FG6TyW4wgMCozdZwE7u+TCYsxnJg2TAv1LArnxYI26gFdlH49pUL6zk0MhfXQDnhAm
         WDhu5f83otchg6OatfvKyqSOaMVcXA/5QfMoHi/0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next 2/3] RDMA/mlx5: Don't rely on FW to set zeros in ECE response
Date:   Tue,  2 Jun 2020 15:55:47 +0300
Message-Id: <20200602125548.172654-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602125548.172654-1-leon@kernel.org>
References: <20200602125548.172654-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The FW returns zeros in case feature is not enabled, but it is better
to have the capability check and ensure that returned result is cleared.

Fixes: 3e09a427ae7a ("RDMA/mlx5: Get ECE options from FW during create QP")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index e8427231cf15..494e305cf761 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1906,7 +1906,8 @@ static int create_xrc_tgt_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 
 	base->container_mibqp = qp;
 	base->mqp.event = mlx5_ib_qp_event;
-	params->resp.ece_options = MLX5_GET(create_qp_out, out, ece);
+	if (MLX5_CAP_GEN(mdev, ece_support))
+		params->resp.ece_options = MLX5_GET(create_qp_out, out, ece);
 
 	spin_lock_irqsave(&dev->reset_flow_resource_lock, flags);
 	list_add_tail(&qp->qps_list, &dev->qp_list);
@@ -2082,7 +2083,8 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 
 	base->container_mibqp = qp;
 	base->mqp.event = mlx5_ib_qp_event;
-	params->resp.ece_options = MLX5_GET(create_qp_out, out, ece);
+	if (MLX5_CAP_GEN(mdev, ece_support))
+		params->resp.ece_options = MLX5_GET(create_qp_out, out, ece);
 
 	get_cqs(qp->type, init_attr->send_cq, init_attr->recv_cq,
 		&send_cq, &recv_cq);
-- 
2.26.2

