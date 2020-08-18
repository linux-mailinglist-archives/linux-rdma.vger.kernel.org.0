Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C89F248464
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 14:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHRMGC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 08:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:32924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgHRMGC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Aug 2020 08:06:02 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3637204EA;
        Tue, 18 Aug 2020 12:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597752361;
        bh=h8/5myLkru2mgyrKQinkYqlpTlsF3TD1h26Tw2uoo+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LILQghar7B6cAN0IeMIoZQbxWH6tMBC7DqMNtwSc73O1LRo/e4gLJi5RDbOxAgcBO
         M+eCadpqYsKosZilSVtXm3Cb/J0nytNlFeplBmYW1TlAq3pWFekzCkeQItiKb1/9uL
         zucXg+0EUpTO1qFkn97Sma1ExAsGmYnBOXt6eOBk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 08/14] RDMA/ucma: Fix the locking of ctx->file
Date:   Tue, 18 Aug 2020 15:05:20 +0300
Message-Id: <20200818120526.702120-9-leon@kernel.org>
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

ctx->file is changed under the file->mut lock by ucma_migrate_id(), which
is impossible to lock correctly. Instead change ctx->file under the
handler_lock and ctx_table lock and revise all places touching ctx->file
to use this locking when reading ctx->file.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/ucma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 18285941aec3..f7ec71225e87 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -547,6 +547,7 @@ static void ucma_cleanup_mc_events(struct ucma_multicast *mc)
 {
 	struct ucma_event *uevent, *tmp;
 
+	rdma_lock_handler(mc->ctx->cm_id);
 	mutex_lock(&mc->ctx->file->mut);
 	list_for_each_entry_safe(uevent, tmp, &mc->ctx->file->event_list, list) {
 		if (uevent->mc != mc)
@@ -556,6 +557,7 @@ static void ucma_cleanup_mc_events(struct ucma_multicast *mc)
 		kfree(uevent);
 	}
 	mutex_unlock(&mc->ctx->file->mut);
+	rdma_unlock_handler(mc->ctx->cm_id);
 }
 
 /*
@@ -1600,7 +1602,7 @@ static ssize_t ucma_leave_multicast(struct ucma_file *file,
 	mc = xa_load(&multicast_table, cmd.id);
 	if (!mc)
 		mc = ERR_PTR(-ENOENT);
-	else if (mc->ctx->file != file)
+	else if (READ_ONCE(mc->ctx->file) != file)
 		mc = ERR_PTR(-EINVAL);
 	else if (!refcount_inc_not_zero(&mc->ctx->ref))
 		mc = ERR_PTR(-ENXIO);
@@ -1692,6 +1694,7 @@ static ssize_t ucma_migrate_id(struct ucma_file *new_file,
 		goto file_put;
 	}
 
+	rdma_lock_handler(ctx->cm_id);
 	cur_file = ctx->file;
 	if (cur_file == new_file) {
 		resp.events_reported = ctx->events_reported;
@@ -1718,6 +1721,7 @@ static ssize_t ucma_migrate_id(struct ucma_file *new_file,
 			 &resp, sizeof(resp)))
 		ret = -EFAULT;
 
+	rdma_unlock_handler(ctx->cm_id);
 	ucma_put_ctx(ctx);
 file_put:
 	fdput(f);
-- 
2.26.2

