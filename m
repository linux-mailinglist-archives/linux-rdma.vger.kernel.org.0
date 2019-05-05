Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C5E1400D
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 16:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfEEOH1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 10:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfEEOH1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 5 May 2019 10:07:27 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AB64204FD;
        Sun,  5 May 2019 14:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557065246;
        bh=4LRa9zBkDkvPZce6iG5806680XX2e3mnOEbRqqX0bao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pc/sWKmUAnQYDqOZLtqXaFV0o/KTxkSEmNUWHd+/DsHA5LA85aIO/g118qjirXeiX
         PjS0XzeuyxcC5Bt3FYItuAbi8aOUEg2wC9OQ1G/jPrjuGmEVBQBGKkUQvDN7Me9uBZ
         CoOUjgFiAKJ/J/SsoqfvfoBew/0n28/zuh6JygEw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Ariel Levkovich <lariel@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, Mark Bloch <markb@mellanox.com>
Subject: [PATCH rdma-next 2/4] IB/mlx5: Warn on allocated MEMIC buffers during cleanup
Date:   Sun,  5 May 2019 17:07:12 +0300
Message-Id: <20190505140714.8741-3-leon@kernel.org>
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

Adding a warning on allocated MEMIC buffers that weren't
freed prior to driver tear down.

Signed-off-by: Ariel Levkovich <lariel@mellanox.com>
Reviewed-by: Eli Cohen <eli@mellanox.com>
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 06c4bb9e13db..2c03ea1a9dc3 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6011,6 +6011,8 @@ static void mlx5_ib_stage_init_cleanup(struct mlx5_ib_dev *dev)
 		srcu_barrier(&dev->mr_srcu);
 		cleanup_srcu_struct(&dev->mr_srcu);
 	}
+
+	WARN_ON(!bitmap_empty(dev->dm.memic_alloc_pages, MLX5_MAX_MEMIC_PAGES));
 }
 
 static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
-- 
2.20.1

