Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 971717122B
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 08:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfGWG5q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 02:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729469AbfGWG5p (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 02:57:45 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 479E72190F;
        Tue, 23 Jul 2019 06:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563865064;
        bh=sZr034tUfJRLNdTwSHE4kz0qQKlA6rbSz6skp3ytAwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p3a1W3sb/QfCsgC8McrWb2bI0dZvyiyt5SSHs8qpq38RPgBvJ99n1aQpEuYsA+og7
         ILRlqf5+ZnzdHOwQF0UVzu/k+3iIPJsS8/ivIfw3Tw/imQl8aVBiTswn9w/DwZ9nD6
         NLR+MfZ7BPGoXGNtc/LCZ1LjYIhl7lAk7av6JuKw=
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
Subject: [PATCH rdma-rc 03/10] IB/mlx5: Use direct mkey destroy command upon UMR unreg failure
Date:   Tue, 23 Jul 2019 09:57:26 +0300
Message-Id: <20190723065733.4899-4-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723065733.4899-1-leon@kernel.org>
References: <20190723065733.4899-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Use direct firmware command to destroy the mkey in case the unreg UMR
operation has failed.

This prevents a case that an mkey will leak out from the cache post a
failure to be destroyed by a UMR WR.

In case the MR cache limit didn't reach a call to add another entry to
the cache instead of the destroyed one is issued.

In addition, replaced a warn message to WARN_ON() as this flow is fatal
and can't happen unless some bug around.

Cc: <stable@vger.kernel.org> # 4.10
Fixes: 49780d42dfc9 ("IB/mlx5: Expose MR cache for mlx5_ib")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 266edaf8029d..b83361aebf28 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -545,13 +545,16 @@ void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 		return;

 	c = order2idx(dev, mr->order);
-	if (c < 0 || c >= MAX_MR_CACHE_ENTRIES) {
-		mlx5_ib_warn(dev, "order %d, cache index %d\n", mr->order, c);
-		return;
-	}
+	WARN_ON(c < 0 || c >= MAX_MR_CACHE_ENTRIES);

-	if (unreg_umr(dev, mr))
+	if (unreg_umr(dev, mr)) {
+		mr->allocated_from_cache = false;
+		destroy_mkey(dev, mr);
+		ent = &cache->ent[c];
+		if (ent->cur < ent->limit)
+			queue_work(cache->wq, &ent->work);
 		return;
+	}

 	ent = &cache->ent[c];
 	spin_lock_irq(&ent->lock);
--
2.20.1

