Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28B924FC35
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 13:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHXLCf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 07:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgHXLCe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 07:02:34 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01994206B5;
        Mon, 24 Aug 2020 11:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598266953;
        bh=0oenFxZulSNc+bX1cTIr3mQ/9Mg1MqJ5FbwLuXpGMl0=;
        h=From:To:Cc:Subject:Date:From;
        b=AtgxWip4/V+4oBvcoqFO7YkQKf08nimELvlQEF15phLBAZ90CXJzeyENvygYCKzYn
         8KN0/QEiDlyPKkGvYpL61IhEdXPJUuGaSGvM7Y1KR59CUadBvtVWV797DekbsU/FaX
         vLyRXd8OOvvswAT4SnKHZZf1pGvUNWRNCYVABcOM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Bloch <markb@mellanox.com>, Eli Cohen <eli@mellanox.co.il>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Roland Dreier <rolandd@cisco.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-rc v1] RDMA/mlx4: Read pkey table length instead of hardcoded value
Date:   Mon, 24 Aug 2020 14:02:29 +0300
Message-Id: <20200824110229.1094376-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Bloch <markb@mellanox.com>

If the pkey_table is not available (which is the case when RoCE is not
supported), the cited commit caused a regression where mlx4_devices
without RoCE are not created.

Fix this by returning a pkey table length of zero in procedure
eth_link_query_port() if the pkey-table length reported by the device
is zero.

Cc: <stable@vger.kernel.org>
Cc: Long Li <longli@microsoft.com>
Fixes: 1901b91f9982 ("IB/core: Fix potential NULL pointer dereference in pkey cache")
Fixes: fa417f7b520e ("IB/mlx4: Add support for IBoE")
Signed-off-by: Mark Bloch <markb@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changelog:
v1: Used commit message suggested by Jack
v0:
https://lore.kernel.org/linux-rdma/20200823061754.573919-1-leon@kernel.org
---
 drivers/infiniband/hw/mlx4/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 5e7910a517da..bd4f975e7f9a 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -784,7 +784,8 @@ static int eth_link_query_port(struct ib_device *ibdev, u8 port,
 	props->ip_gids = true;
 	props->gid_tbl_len	= mdev->dev->caps.gid_table_len[port];
 	props->max_msg_sz	= mdev->dev->caps.max_msg_sz;
-	props->pkey_tbl_len	= 1;
+	if (mdev->dev->caps.pkey_table_len[port])
+		props->pkey_tbl_len = 1;
 	props->max_mtu		= IB_MTU_4096;
 	props->max_vl_num	= 2;
 	props->state		= IB_PORT_DOWN;
--
2.26.2

