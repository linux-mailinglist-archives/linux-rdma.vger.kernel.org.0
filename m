Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADA739A209
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 15:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFCNTx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 09:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhFCNTw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Jun 2021 09:19:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B12DB6101C;
        Thu,  3 Jun 2021 13:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622726288;
        bh=1V3djcZY5/Kw85378RpznVcFbpSn+TTtkji/F8oC9W4=;
        h=From:To:Cc:Subject:Date:From;
        b=DgG9LDHcjnf9Rp4+3qfmstd8UwMAUvbPHctMQ40s3EOEes5HsKB1GT/z8N4logLHU
         3RwQkzBHnxSMu/uclrj2RYyq2yhjWKeoRgouSxVmzLkdF5RzuldwDY37r39PRd5A0S
         MxKNX9snssVEtpvqiqJ+05qSXUKI9K0vBE+IwB/6uHGN67uTOn86HORBxVu1Y4g39j
         rXsTXJvpehOCS0+oMxMsKEDmp7BUr3ZHqQqxvM6m/sky1OP2BfbwgBqVnJJzgT7mq9
         oCgDffmWhoi9nI/lpmNWV/TljeSSkusl5HSuSbFaemrUekuRkb2C5k840Ii69tSb79
         GMDyWDL9Njs+A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/mlx5: Use different doorbell memory for different processes
Date:   Thu,  3 Jun 2021 16:18:03 +0300
Message-Id: <feacc23fe0bc6e1088c6824d5583798745e72405.1622726212.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

In fork scenario, the parent and child can have same virtual address.
That causes to the list_for_each_entry search return same doorbell location
for all processes.

This patch takes the mm_struct into consideration during search, to make
sure that different doorbell memory is used for the different processes.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/doorbell.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/doorbell.c b/drivers/infiniband/hw/mlx5/doorbell.c
index 40226c75406a..0333b0fe5d8a 100644
--- a/drivers/infiniband/hw/mlx5/doorbell.c
+++ b/drivers/infiniband/hw/mlx5/doorbell.c
@@ -41,6 +41,7 @@ struct mlx5_ib_user_db_page {
 	struct ib_umem	       *umem;
 	unsigned long		user_virt;
 	int			refcnt;
+	struct mm_struct	*mm;
 };
 
 int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
@@ -52,7 +53,8 @@ int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
 	mutex_lock(&context->db_page_mutex);
 
 	list_for_each_entry(page, &context->db_page_list, list)
-		if (page->user_virt == (virt & PAGE_MASK))
+		if ((current->mm == page->mm) &&
+		    (page->user_virt == (virt & PAGE_MASK)))
 			goto found;
 
 	page = kmalloc(sizeof(*page), GFP_KERNEL);
@@ -71,6 +73,8 @@ int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
 		kfree(page);
 		goto out;
 	}
+	mmgrab(current->mm);
+	page->mm = current->mm;
 
 	list_add(&page->list, &context->db_page_list);
 
@@ -91,6 +95,7 @@ void mlx5_ib_db_unmap_user(struct mlx5_ib_ucontext *context, struct mlx5_db *db)
 
 	if (!--db->u.user_page->refcnt) {
 		list_del(&db->u.user_page->list);
+		mmdrop(db->u.user_page->mm);
 		ib_umem_release(db->u.user_page->umem);
 		kfree(db->u.user_page);
 	}
-- 
2.31.1

