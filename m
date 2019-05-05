Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B50011400F
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 16:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfEEOHe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 10:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfEEOHd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 5 May 2019 10:07:33 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D17AE204FD;
        Sun,  5 May 2019 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557065253;
        bh=bOYd9856chqHXKjUAaqoAzaLyWngOUBL8k+EVXsoUJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vuGxWokidfrOwEZnQ9UzEu4XogXJwbvMdwd2FPVVUQgziq3vFd6N4a/B16VP2YMH8
         kKkMJcor6HYzzzqYO6c3xTaaBS2tsTKkBx2ERtxY5DBqeOxtpmbcqhrWanHZv9k51S
         FVvWPH/yn9HrLuJ/r3bBelIIwnzsPPgrZYYSDBfI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Ariel Levkovich <lariel@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, Mark Bloch <markb@mellanox.com>
Subject: [PATCH rdma-next 4/4] IB/mlx5: Device resource control for privileged DEVX user
Date:   Sun,  5 May 2019 17:07:14 +0300
Message-Id: <20190505140714.8741-5-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190505140714.8741-1-leon@kernel.org>
References: <20190505140714.8741-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Ariel Levkovich <lariel@mellanox.com>

For DEVX users who have SYS_RAWIO capability, we set the
internal device resources capability when creating the UCTX.
This will allow the device to restrict the allocation of internal
device resources such as SW ICM memory to privileged DEVX users
only.

Signed-off-by: Ariel Levkovich <lariel@mellanox.com>
Reviewed-by: Eli Cohen <eli@mellanox.com>
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index d627f44bc84d..169ffffcf5ed 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -85,6 +85,10 @@ int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user)
 	if (is_user && capable(CAP_NET_RAW) &&
 	    (MLX5_CAP_GEN(dev->mdev, uctx_cap) & MLX5_UCTX_CAP_RAW_TX))
 		cap |= MLX5_UCTX_CAP_RAW_TX;
+	if (is_user && capable(CAP_SYS_RAWIO) &&
+	    (MLX5_CAP_GEN(dev->mdev, uctx_cap) &
+	     MLX5_UCTX_CAP_INTERNAL_DEV_RES))
+		cap |= MLX5_UCTX_CAP_INTERNAL_DEV_RES;
 
 	MLX5_SET(create_uctx_in, in, opcode, MLX5_CMD_OP_CREATE_UCTX);
 	MLX5_SET(uctx, uctx, cap, cap);
-- 
2.20.1

