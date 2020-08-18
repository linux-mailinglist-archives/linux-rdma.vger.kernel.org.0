Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912F1248465
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 14:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHRMGH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 08:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgHRMGF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Aug 2020 08:06:05 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56F0B204EA;
        Tue, 18 Aug 2020 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597752365;
        bh=ZtbGxd5ePE3ZfpfKfEvHXxhqorpfEQaB2XcZXm4UfsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NGdrXRoly+HaD4saK3YkOGybQlsH7MX8C0Mwf7RfxY1EMqqaYh510q+SJFJR8Dxk2
         XQsqZopAJNbVYKI0g4BBT6P66neu5P60o5r/uE3x3+Qi28UubZVh3Cm0uHWP8JO2fb
         Hw5Hu9aLCTRZlfO95rMeTux5YuViX6E/jKDvD8gQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Roland Dreier <rolandd@cisco.com>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next 09/14] RDMA/ucma: Fix locking for ctx->events_reported
Date:   Tue, 18 Aug 2020 15:05:21 +0300
Message-Id: <20200818120526.702120-10-leon@kernel.org>
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

This value is locked under the file->mut, ensure it is held whenever
touching it.

The case in ucma_migrate_id() is a race, while in ucma_free_uctx() it is
already not possible for the write side to run, the movement is just for
clarity.

Fixes: 88314e4dda1e ("RDMA/cma: add support for rdma_migrate_id()")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/ucma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index f7ec71225e87..ca5c44cac48c 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -587,6 +587,7 @@ static int ucma_free_ctx(struct ucma_context *ctx)
 			list_move_tail(&uevent->list, &list);
 	}
 	list_del(&ctx->list);
+	events_reported = ctx->events_reported;
 	mutex_unlock(&ctx->file->mut);
 
 	list_for_each_entry_safe(uevent, tmp, &list, list) {
@@ -596,7 +597,6 @@ static int ucma_free_ctx(struct ucma_context *ctx)
 		kfree(uevent);
 	}
 
-	events_reported = ctx->events_reported;
 	mutex_destroy(&ctx->mutex);
 	kfree(ctx);
 	return events_reported;
@@ -1697,7 +1697,9 @@ static ssize_t ucma_migrate_id(struct ucma_file *new_file,
 	rdma_lock_handler(ctx->cm_id);
 	cur_file = ctx->file;
 	if (cur_file == new_file) {
+		mutex_lock(&cur_file->mut);
 		resp.events_reported = ctx->events_reported;
+		mutex_unlock(&cur_file->mut);
 		goto response;
 	}
 
-- 
2.26.2

