Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9DD692202
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 13:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfHSLRp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 07:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfHSLRp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 07:17:45 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2389E20989;
        Mon, 19 Aug 2019 11:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566213464;
        bh=jnhFEIv0WTsidHF5RwVsbhsevggyj9R2LaHndN85PkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7Pk1XCbR2g7prH/a/YutATkTQZEkMIFCygzcBSZv1K2gbFNka0LwIjKP2Zj8m+r5
         QuSnp3aRdR3GZ6AD72DctExQsgnZHvpE8ayE05zlEQYJfg4FzX/39BI5EX8A0hrZgY
         PE/W4LyrbvT8Ju3aXfkssJQrwOTqF8pAHfhWdjeA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-next 09/12] RDMA/odp: Use kvcalloc for the dma_list and page_list
Date:   Mon, 19 Aug 2019 14:17:07 +0300
Message-Id: <20190819111710.18440-10-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819111710.18440-1-leon@kernel.org>
References: <20190819111710.18440-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

There is no specific need for these to be in the valloc space, let the
system decide automatically how to do the allocation.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem_odp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 46ae9962fae3..f1b298575b4c 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -321,13 +321,13 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 		 */
 		umem_odp->interval_tree.last--;
 
-		umem_odp->page_list = vzalloc(
-			array_size(sizeof(*umem_odp->page_list), pages));
+		umem_odp->page_list = kvcalloc(
+			pages, sizeof(*umem_odp->page_list), GFP_KERNEL);
 		if (!umem_odp->page_list)
 			return -ENOMEM;
 
-		umem_odp->dma_list =
-			vzalloc(array_size(sizeof(*umem_odp->dma_list), pages));
+		umem_odp->dma_list = kvcalloc(
+			pages, sizeof(*umem_odp->dma_list), GFP_KERNEL);
 		if (!umem_odp->dma_list) {
 			ret = -ENOMEM;
 			goto out_page_list;
@@ -361,9 +361,9 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 
 out_unlock:
 	mutex_unlock(&ctx->per_mm_list_lock);
-	vfree(umem_odp->dma_list);
+	kvfree(umem_odp->dma_list);
 out_page_list:
-	vfree(umem_odp->page_list);
+	kvfree(umem_odp->page_list);
 	return ret;
 }
 
@@ -539,8 +539,8 @@ void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 		ib_umem_odp_unmap_dma_pages(umem_odp, ib_umem_start(umem_odp),
 					    ib_umem_end(umem_odp));
 		remove_umem_from_per_mm(umem_odp);
-		vfree(umem_odp->dma_list);
-		vfree(umem_odp->page_list);
+		kvfree(umem_odp->dma_list);
+		kvfree(umem_odp->page_list);
 	}
 	put_per_mm(umem_odp);
 	mmdrop(umem_odp->umem.owning_mm);
-- 
2.20.1

