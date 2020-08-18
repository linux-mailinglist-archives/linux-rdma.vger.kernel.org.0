Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74543248462
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 14:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHRMFy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 08:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:32862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgHRMFy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Aug 2020 08:05:54 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03238204EA;
        Tue, 18 Aug 2020 12:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597752353;
        bh=XkM01OZLPHdKUeH/5h2qMkm/s2n9vvE0ozAicjgEAE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYao+NXSW6cexzMlrjYuD+sr65o6ZYbpXKm/toGyeIq7QSNeaS6wKWhSGBCNUXV/c
         AQhO7QgzwZ96aOLxUUJmTVBFBJad53q3oOM/1Z5CJHwgHDYfkZyF+X9jt5E0lixfAU
         kE9Iypl3Xk2wLam8DyRza5lxtOD4E1+r8o3H0shU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 02/14] RDMA/ucma: Remove unnecessary locking of file->ctx_list in close
Date:   Tue, 18 Aug 2020 15:05:14 +0300
Message-Id: <20200818120526.702120-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818120526.702120-1-leon@kernel.org>
References: <20200818120526.702120-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

During the file_operations release function it is already not possible
that write() can be running concurrently, remove the extra locking
around the ctx_list.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/ucma.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 625168563443..9b019f31743d 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1824,12 +1824,17 @@ static int ucma_close(struct inode *inode, struct file *filp)
 	struct ucma_file *file = filp->private_data;
 	struct ucma_context *ctx, *tmp;
 
-	mutex_lock(&file->mut);
+	/*
+	 * ctx_list can only be mutated under the write(), which is no longer
+	 * possible, so no locking needed.
+	 */
 	list_for_each_entry_safe(ctx, tmp, &file->ctx_list, list) {
+		xa_erase(&ctx_table, ctx->id);
+
+		mutex_lock(&file->mut);
 		ctx->destroying = 1;
 		mutex_unlock(&file->mut);
 
-		xa_erase(&ctx_table, ctx->id);
 		flush_workqueue(file->close_wq);
 		/* At that step once ctx was marked as destroying and workqueue
 		 * was flushed we are safe from any inflights handlers that
@@ -1849,9 +1854,7 @@ static int ucma_close(struct inode *inode, struct file *filp)
 		}
 
 		ucma_free_ctx(ctx);
-		mutex_lock(&file->mut);
 	}
-	mutex_unlock(&file->mut);
 	destroy_workqueue(file->close_wq);
 	kfree(file);
 	return 0;
-- 
2.26.2

