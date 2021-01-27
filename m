Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78919305F0F
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 16:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhA0PFY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 10:05:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235441AbhA0PCz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Jan 2021 10:02:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC39B208B3;
        Wed, 27 Jan 2021 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611759630;
        bh=F++xEC2kbt1gRz9scugUdV9UkbEBJS5JHrs44aGonn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJro+EU8J3pLW1dAgejNt/mafpevJefziVIrta0RDIsMYpesJzW5pM/wzPyniOHyt
         gqcVDKN/g25qfhQ3Q9yHDvT91Rki9uX9LLMXY9D5Qg9F8GLATc1tfoR/qjTmc95fD6
         IX4bBGZIn2RlE6wFzaJ7KmcODqaR6GsVY1iClr9QiqHHlgTKCaCq6KaAZfdEM6CTa8
         TA9iMAG1NsGeGxsCyIueMRqD3ji3QfrqM0QH2yC9434tUbD88/GyfVnvcIIAkPCgqM
         owyhjaMWLI7ArdRs2uD+mxX6bRUGJw9LzuCB7nunCBL5mqKoB5Y02vjcV9WrU9E7no
         nJGp/os2wqXbw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 04/10] IB/mlx5: Improve query port for representor port
Date:   Wed, 27 Jan 2021 17:00:04 +0200
Message-Id: <20210127150010.1876121-5-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127150010.1876121-1-leon@kernel.org>
References: <20210127150010.1876121-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@nvidia.com>

Improve query port functionality for representor port as below.

1. RoCE Qkey violation counters are not applicable for representor
port.
2. Avoid setting gid_tbl_len twice for representor port.
3. Avoid setting ip_gids and IB_PORT_CM_SUP property for representor
port as GID table is empty and CM support is not present in
representor mode.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 6f2c03230c49..5a7f8fa2f452 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -462,7 +462,6 @@ static int mlx5_query_port_roce(struct ib_device *device, u8 port_num,
 	struct net_device *ndev, *upper;
 	enum ib_mtu ndev_ib_mtu;
 	bool put_mdev = true;
-	u16 qkey_viol_cntr;
 	u32 eth_prot_oper;
 	u8 mdev_port_num;
 	bool ext;
@@ -500,20 +499,22 @@ static int mlx5_query_port_roce(struct ib_device *device, u8 port_num,
 	translate_eth_proto_oper(eth_prot_oper, &props->active_speed,
 				 &props->active_width, ext);

-	props->port_cap_flags |= IB_PORT_CM_SUP;
-	props->ip_gids = true;
+	if (!dev->is_rep && mlx5_is_roce_enabled(mdev)) {
+		u16 qkey_viol_cntr;

-	props->gid_tbl_len      = MLX5_CAP_ROCE(dev->mdev,
-						roce_address_table_size);
+		props->port_cap_flags |= IB_PORT_CM_SUP;
+		props->ip_gids = true;
+		props->gid_tbl_len = MLX5_CAP_ROCE(dev->mdev,
+						   roce_address_table_size);
+		mlx5_query_nic_vport_qkey_viol_cntr(mdev, &qkey_viol_cntr);
+		props->qkey_viol_cntr = qkey_viol_cntr;
+	}
 	props->max_mtu          = IB_MTU_4096;
 	props->max_msg_sz       = 1 << MLX5_CAP_GEN(dev->mdev, log_max_msg);
 	props->pkey_tbl_len     = 1;
 	props->state            = IB_PORT_DOWN;
 	props->phys_state       = IB_PORT_PHYS_STATE_DISABLED;

-	mlx5_query_nic_vport_qkey_viol_cntr(mdev, &qkey_viol_cntr);
-	props->qkey_viol_cntr = qkey_viol_cntr;
-
 	/* If this is a stub query for an unaffiliated port stop here */
 	if (!put_mdev)
 		goto out;
@@ -1383,19 +1384,7 @@ int mlx5_ib_query_port(struct ib_device *ibdev, u8 port,
 static int mlx5_ib_rep_query_port(struct ib_device *ibdev, u8 port,
 				  struct ib_port_attr *props)
 {
-	int ret;
-
-	/* Only link layer == ethernet is valid for representors
-	 * and we always use port 1
-	 */
-	ret = mlx5_query_port_roce(ibdev, port, props);
-	if (ret || !props)
-		return ret;
-
-	/* We don't support GIDS */
-	props->gid_tbl_len = 0;
-
-	return ret;
+	return mlx5_query_port_roce(ibdev, port, props);
 }

 static int mlx5_ib_rep_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
--
2.29.2

