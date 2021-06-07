Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEF139D6AE
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 10:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFGIFI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 04:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhFGIFH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 04:05:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D9A5611BE;
        Mon,  7 Jun 2021 08:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623052996;
        bh=aj+fvLYqw/IXHwAH00GXLxoGmLXQ2dqDlFdQq3Ic+ao=;
        h=From:To:Cc:Subject:Date:From;
        b=RbyZI1C88s2SAQFsfwiXiSkUSfgo+l+cO2iN/NZIdm3GwkrpNSiuCuCTUQIw6zAs7
         S10OWl9Osg4Wh31o7jB0evRS60FyW8nZEfW0qgJmbZuaVlFMQ5k0BXI5UGOw5B/ute
         szW66o/l0PbdQqBh35DceCRpJIs1fMBYs32uAb6Hgdahj7FvbnKBFnp9sZxfTSuwLC
         AlT1nBCabxvFQh6rbzeJQrnp57ylY8Q7iqUPA/i+3THS1DtmRJ7Yyc4T3sKqEl657m
         vqsepnsVuD5SVECl87/RjMP5ud/0g2kCW0M4QyXJd+DP9JHGEIv2XqPuXOzONia5Am
         YpKHs7Pm9yDUw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Bloch <mbloch@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Block FDB rules when not in switchdev mode
Date:   Mon,  7 Jun 2021 11:03:12 +0300
Message-Id: <e928ae7c58d07f104716a2a8d730963d1bd01204.1623052923.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Bloch <mbloch@nvidia.com>

Allow creating FDB steering rules only when in switchdev mode.

The only software model where a userspace application can manipulate
FDB entries is when it manages the eswitch. This is only possible in
switchdev mode where we expose a single RDMA device with representors
for all the vports that are connected to the eswitch.

Fixes: 52438be44112 ("RDMA/mlx5: Allow inserting a steering rule to the FDB")
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/fs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 2fc6a60c4e77..f84441ff0c81 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -2134,6 +2134,12 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_FLOW_MATCHER_CREATE)(
 	if (err)
 		goto end;
 
+	if (obj->ns_type == MLX5_FLOW_NAMESPACE_FDB &&
+	    mlx5_eswitch_mode(dev->mdev) != MLX5_ESWITCH_OFFLOADS) {
+		err = -EINVAL;
+		goto end;
+	}
+
 	uobj->object = obj;
 	obj->mdev = dev->mdev;
 	atomic_set(&obj->usecnt, 0);
-- 
2.31.1

