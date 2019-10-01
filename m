Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91EB1C393D
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 17:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfJAPih (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 11:38:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41394 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfJAPih (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 11:38:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id d16so1558018qtq.8
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 08:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VjSimegOVv1mcHQrf53Oma0EmyHc2zoY77haYmlOcRw=;
        b=PyNMT3WBMuzQrCaWKCocLuFA42oL/lFhDZz2ZKJ+DN4FWOtA7GA4YABlo/yUeDORxe
         HgS1geoXhpVYtqXTsM3YkAdXBW9LIGghhnQgVC8qPheM0sn1thmbUO2mx5wbMFK/cXN4
         gMO15CwTYKPgUimOai7JciKkKHqorXrxHxrLrxyYf+PHZAX4nHitJzgy22GjESNj0FDH
         Eo5WjoV4CE5CTNJAq9cV3yCq5llZis2YApsNO8YjIrjj94ww2PJctCCm4b4TS7FnUlk3
         W9D55QauWJ9PvWLAKl7L8mC3kLg792jTJRTCT0jcGlVLRWnsJCCW1EIhK5yEVPXFGMf+
         6J3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VjSimegOVv1mcHQrf53Oma0EmyHc2zoY77haYmlOcRw=;
        b=nAqUSpDD6+xhjroERf3k4DuQ76jYmqIp4nhP+EOfj2vJjl4DTsqk9yZjlxqJWhcKXR
         /OZ8LxbAbJD829V87Qyav6QxyaBLCgVBOVggCNncFCC2mgBdTICTcNSDbwb/Ty0/J8R3
         ZeTU82aU9bSFymaoZYXxmaXRwMsqjHhKwBEkLbd4fOy9i84YGO8nfv/MBAPf0r/CmUZ7
         BNiZKlB7hBd6RsuwSMQ0pEXE7vmUrNW4hri3Ay5oJ+6p8qJZ5xfAZVpLpQ+yck6OAWuw
         qvDn8b0wYOEJ4/J0M8JQPHtOJclg3PHXvXw2Qnq1vhSaaJMRQDU/4ZCCfJN0vS3YRsKd
         NjnQ==
X-Gm-Message-State: APjAAAVOPKu0g5JijmyR8ZYLbg2AtF6HN61XzoDulV1e1Y1YFZv++Xrd
        mJtUuvQg4SAFGXKoBTRw5O+Lz+W7uE0=
X-Google-Smtp-Source: APXvYqyKs13ZaPqNEFDqX83BTo/jcQ5zBDKEno2PoY8HZjUtGtSnWob3Pc0YclC5jSZnICXS5FtA1w==
X-Received: by 2002:a0c:eb89:: with SMTP id x9mr25228054qvo.18.1569944316517;
        Tue, 01 Oct 2019 08:38:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 199sm7850089qkk.112.2019.10.01.08.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 08:38:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFKEU-0006Ej-2j; Tue, 01 Oct 2019 12:38:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 3/6] RDMA/odp: Lift umem_mutex out of ib_umem_odp_unmap_dma_pages()
Date:   Tue,  1 Oct 2019 12:38:18 -0300
Message-Id: <20191001153821.23621-4-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001153821.23621-1-jgg@ziepe.ca>
References: <20191001153821.23621-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This fixes a race of the form:
    CPU0                               CPU1
mlx5_ib_invalidate_range()     mlx5_ib_invalidate_range()
				 // This one actually makes npages == 0
				 ib_umem_odp_unmap_dma_pages()
				 if (npages == 0 && !dying)
  // This one does nothing
  ib_umem_odp_unmap_dma_pages()
  if (npages == 0 && !dying)
     dying = 1;
                                    dying = 1;
				    schedule_work(&umem_odp->work);
     // Double schedule of the same work
     schedule_work(&umem_odp->work);  // BOOM

npages and dying must be read and written under the umem_mutex lock.

Since whenever ib_umem_odp_unmap_dma_pages() is called mlx5 must also call
mlx5_ib_update_xlt, and both need to be done in the same locking region,
hoist the lock out of unmap.

This avoids an expensive double critical section in
mlx5_ib_invalidate_range().

Fixes: 81713d3788d2 ("IB/mlx5: Add implicit MR support")
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/umem_odp.c |  6 ++++--
 drivers/infiniband/hw/mlx5/odp.c   | 12 ++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index f67a30fda1ed9a..163ff7ba92b7f1 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -451,8 +451,10 @@ void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 	 * that the hardware will not attempt to access the MR any more.
 	 */
 	if (!umem_odp->is_implicit_odp) {
+		mutex_lock(&umem_odp->umem_mutex);
 		ib_umem_odp_unmap_dma_pages(umem_odp, ib_umem_start(umem_odp),
 					    ib_umem_end(umem_odp));
+		mutex_unlock(&umem_odp->umem_mutex);
 		kvfree(umem_odp->dma_list);
 		kvfree(umem_odp->page_list);
 	}
@@ -719,6 +721,8 @@ void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 virt,
 	u64 addr;
 	struct ib_device *dev = umem_odp->umem.ibdev;
 
+	lockdep_assert_held(&umem_odp->umem_mutex);
+
 	virt = max_t(u64, virt, ib_umem_start(umem_odp));
 	bound = min_t(u64, bound, ib_umem_end(umem_odp));
 	/* Note that during the run of this function, the
@@ -726,7 +730,6 @@ void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 virt,
 	 * faults from completion. We might be racing with other
 	 * invalidations, so we must make sure we free each page only
 	 * once. */
-	mutex_lock(&umem_odp->umem_mutex);
 	for (addr = virt; addr < bound; addr += BIT(umem_odp->page_shift)) {
 		idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
 		if (umem_odp->page_list[idx]) {
@@ -757,7 +760,6 @@ void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 virt,
 			umem_odp->npages--;
 		}
 	}
-	mutex_unlock(&umem_odp->umem_mutex);
 }
 EXPORT_SYMBOL(ib_umem_odp_unmap_dma_pages);
 
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 3401c06b7e54f5..1930d78c3091cb 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -308,7 +308,6 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 				   idx - blk_start_idx + 1, 0,
 				   MLX5_IB_UPD_XLT_ZAP |
 				   MLX5_IB_UPD_XLT_ATOMIC);
-	mutex_unlock(&umem_odp->umem_mutex);
 	/*
 	 * We are now sure that the device will not access the
 	 * memory. We can safely unmap it, and mark it as dirty if
@@ -319,10 +318,11 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 
 	if (unlikely(!umem_odp->npages && mr->parent &&
 		     !umem_odp->dying)) {
-		WRITE_ONCE(umem_odp->dying, 1);
+		umem_odp->dying = 1;
 		atomic_inc(&mr->parent->num_leaf_free);
 		schedule_work(&umem_odp->work);
 	}
+	mutex_unlock(&umem_odp->umem_mutex);
 }
 
 void mlx5_ib_internal_fill_odp_caps(struct mlx5_ib_dev *dev)
@@ -585,15 +585,19 @@ void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *imr)
 		if (mr->parent != imr)
 			continue;
 
+		mutex_lock(&umem_odp->umem_mutex);
 		ib_umem_odp_unmap_dma_pages(umem_odp, ib_umem_start(umem_odp),
 					    ib_umem_end(umem_odp));
 
-		if (umem_odp->dying)
+		if (umem_odp->dying) {
+			mutex_unlock(&umem_odp->umem_mutex);
 			continue;
+		}
 
-		WRITE_ONCE(umem_odp->dying, 1);
+		umem_odp->dying = 1;
 		atomic_inc(&imr->num_leaf_free);
 		schedule_work(&umem_odp->work);
+		mutex_unlock(&umem_odp->umem_mutex);
 	}
 	up_read(&per_mm->umem_rwsem);
 
-- 
2.23.0

