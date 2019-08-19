Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF35922B0
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 13:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfHSLpx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 07:45:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfHSLpx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 07:45:53 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95893206BB;
        Mon, 19 Aug 2019 11:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566215152;
        bh=Rkrx5M5r8C/2If8u+YP+IPxgS99cAHNfONNzYziXyYg=;
        h=From:To:Cc:Subject:Date:From;
        b=PF5HXZ5syijsJm/zKF/n8ugxxgv4ZsB0Chc+DQWJ8/v02uy6+FchR6lKuWopsrtMx
         Oht4J4AYD1659hsdtg6dtF9dugQWwM0BmwWmbankw0QdXR5bvHspK8vHD8//1aj7yH
         /KzJYf1pynoxfJx3Rp2PLPNuAYI04wVEnrvOINpc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next] RDMA: Delete DEBUG code
Date:   Mon, 19 Aug 2019 14:45:47 +0300
Message-Id: <20190819114547.20704-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

There is no need to keep DEBUG defines for out-of-the tree testing.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/fmr_pool.c | 13 -------------
 include/rdma/ib_verbs.h            |  3 ---
 2 files changed, 16 deletions(-)

diff --git a/drivers/infiniband/core/fmr_pool.c b/drivers/infiniband/core/fmr_pool.c
index 7d841b689a1e..e08aec427027 100644
--- a/drivers/infiniband/core/fmr_pool.c
+++ b/drivers/infiniband/core/fmr_pool.c
@@ -148,13 +148,6 @@ static void ib_fmr_batch_release(struct ib_fmr_pool *pool)
 		hlist_del_init(&fmr->cache_node);
 		fmr->remap_count = 0;
 		list_add_tail(&fmr->fmr->list, &fmr_list);
-
-#ifdef DEBUG
-		if (fmr->ref_count !=0) {
-			pr_warn(PFX "Unmapping FMR 0x%08x with ref count %d\n",
-				fmr, fmr->ref_count);
-		}
-#endif
 	}
 
 	list_splice_init(&pool->dirty_list, &unmap_list);
@@ -496,12 +489,6 @@ void ib_fmr_pool_unmap(struct ib_pool_fmr *fmr)
 		}
 	}
 
-#ifdef DEBUG
-	if (fmr->ref_count < 0)
-		pr_warn(PFX "FMR %p has ref count %d < 0\n",
-			fmr, fmr->ref_count);
-#endif
-
 	spin_unlock_irqrestore(&pool->pool_lock, flags);
 }
 EXPORT_SYMBOL(ib_fmr_pool_unmap);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 18a34888bbca..73529a10ea36 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -98,9 +98,6 @@ void ibdev_info(const struct ib_device *ibdev, const char *format, ...);
 #if defined(CONFIG_DYNAMIC_DEBUG)
 #define ibdev_dbg(__dev, format, args...)                       \
 	dynamic_ibdev_dbg(__dev, format, ##args)
-#elif defined(DEBUG)
-#define ibdev_dbg(__dev, format, args...)                       \
-	ibdev_printk(KERN_DEBUG, __dev, format, ##args)
 #else
 __printf(2, 3) __cold
 static inline
-- 
2.20.1

