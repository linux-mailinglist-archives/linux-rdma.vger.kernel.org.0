Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A50E24EBC5
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Aug 2020 08:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgHWGSC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Aug 2020 02:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgHWGSB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 23 Aug 2020 02:18:01 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 541A32074D;
        Sun, 23 Aug 2020 06:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598163481;
        bh=2Pkh2X4bfMNu3m5ZcuHhJBFAa0Vakxx+nmDKAinOJAw=;
        h=From:To:Cc:Subject:Date:From;
        b=Gv8965i2tomfRkioD1dKNehk6y3kMpu/WH7xapFWf/C8VEa5DTeJrA9FiUYq1Cz/c
         6UudrbcNPghaVlN6ruttE52VY2zSvcy15FG6Bhm4h2pMCG6AxVckLqOU9ejSmHJnlJ
         GEB2lV6Octgcn4et146gHTVFcVb6e47DUjhi8SQg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Bloch <markb@mellanox.com>, Eli Cohen <eli@mellanox.co.il>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Roland Dreier <rolandd@cisco.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-rc] RDMA/mlx4: Read pkey table length instead of hardcoded value
Date:   Sun, 23 Aug 2020 09:17:54 +0300
Message-Id: <20200823061754.573919-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Bloch <markb@mellanox.com>

The driver shouldn't assume that a pkey table is available, this
can happen if RoCE isn't supported by the device.

Use the pkey table length reported by the device. This together with the
cited commit from Jack caused a regression where mlx4 devices without
RoCE aren't created.

Cc: <stable@vger.kernel.org>
Cc: Long Li <longli@microsoft.com>
Fixes: 1901b91f9982 ("IB/core: Fix potential NULL pointer dereference in pkey cache")
Fixes: fa417f7b520e ("IB/mlx4: Add support for IBoE")
Signed-off-by: Mark Bloch <markb@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
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

