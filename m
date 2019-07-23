Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 683EF71230
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 08:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfGWG6C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 02:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731708AbfGWG6C (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 02:58:02 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B3D12239E;
        Tue, 23 Jul 2019 06:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563865081;
        bh=e1Kz+ZcVRy8eSbut5fcop8RdMMT0kAKkR/GBM9Ieyg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=toKGWWHy3M0IiPnebudfCt6jB3wid5XVL5yc/yc2SDgj7fSnNO6iK6Kn3UpgkAOPc
         zEyZDFW7p1OlBljIEWz63ji1WBKWyNXFSuQDCUcCuQKscIFtT0tLChgZMbzeU7zr37
         /1OSfUn/G76JpS6xSWOL3Lgxki67tprQlROfa5EI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Alex Vainman <alexv@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagig@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc 08/10] IB/mlx5: Avoid unnecessary typecast
Date:   Tue, 23 Jul 2019 09:57:31 +0300
Message-Id: <20190723065733.4899-9-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723065733.4899-1-leon@kernel.org>
References: <20190723065733.4899-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

IB device pointer is already available while deallocating IB device,
Hence do not typecast it.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index c2a5780cb394..6cdd98ec9c1e 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6933,7 +6933,7 @@ static void *mlx5_ib_add(struct mlx5_core_dev *mdev)
 	dev->port = kcalloc(num_ports, sizeof(*dev->port),
 			     GFP_KERNEL);
 	if (!dev->port) {
-		ib_dealloc_device((struct ib_device *)dev);
+		ib_dealloc_device(&dev->ib_dev);
 		return NULL;
 	}

--
2.20.1

