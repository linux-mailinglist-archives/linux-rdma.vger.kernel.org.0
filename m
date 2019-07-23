Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 331F17122F
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 08:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbfGWG57 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 02:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729469AbfGWG57 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 02:57:59 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABF6D2190F;
        Tue, 23 Jul 2019 06:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563865078;
        bh=d837hmpH6DX+1yWsPMhBWYmip7pmmAhXEAUy8tdnV0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yAPXjKLTgY7xNTcmijg/5K+oM1Kvoba7o2vEJIc1yc4una0sy+ST1UgIiXKMeczmE
         Ez0I/HGhGWtIdPZ+sGcf9XsuAL+yRoFsJxYME7Gp9e/376mHahThhpMJsZw1ps/qIF
         TetnYWQKp71FmcOn2aFHwhwX9c+O1UV5rTnNjNvY=
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
Subject: [PATCH rdma-rc 07/10] IB/mlx5: Prevent concurrent MR updates during invalidation
Date:   Tue, 23 Jul 2019 09:57:30 +0300
Message-Id: <20190723065733.4899-8-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723065733.4899-1-leon@kernel.org>
References: <20190723065733.4899-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Moni Shoua <monis@mellanox.com>

Device requires that memory registration work requests that update the
address translation table of a MR will be fenced if posted together.
This scenario can happen when address ranges are invalidated by the
mmu in separate concurrent calls to the invalidation callback.

We prefer to block concurrent address updates for a single MR over
fencing since making the decision if a WQE needs fencing will be more
expensive and fencing all WQEs is a too radical choice.

Fixes: b4cfe447d47b ("IB/mlx5: Implement on demand paging by adding support for MMU notifiers")
Signed-off-by: Moni Shoua <monis@mellanox.com>
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 5b642d81e617..b54b851d54e8 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -246,7 +246,7 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 	 * overwrite the same MTTs.  Concurent invalidations might race us,
 	 * but they will write 0s as well, so no difference in the end result.
 	 */
-
+	mutex_lock(&umem_odp->umem_mutex);
 	for (addr = start; addr < end; addr += BIT(umem_odp->page_shift)) {
 		idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
 		/*
@@ -278,6 +278,7 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 				   idx - blk_start_idx + 1, 0,
 				   MLX5_IB_UPD_XLT_ZAP |
 				   MLX5_IB_UPD_XLT_ATOMIC);
+	mutex_unlock(&umem_odp->umem_mutex);
 	/*
 	 * We are now sure that the device will not access the
 	 * memory. We can safely unmap it, and mark it as dirty if
--
2.20.1

