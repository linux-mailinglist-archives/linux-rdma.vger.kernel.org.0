Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5921248463
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 14:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHRMF6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 08:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:32900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgHRMF5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Aug 2020 08:05:57 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD9E4204EA;
        Tue, 18 Aug 2020 12:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597752357;
        bh=i8RR5RA2Zl3WuDcI0skyy2WYj6rHWClrfNZLtN3pvno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j1seGX/2pUGCVr+ayIjm3tzwshP6UD3m92fdmIywY0hRaS+E3SE+WMNXmRuIHb+Uy
         4VdI8RPb4NlNVOWoovwS0w/EIsMyf/HAqe04kRpZMKzpyKJP4GqBDsq+ANYf50Vq1U
         V4hLjG9QFjHLitVimfiFm+H9IbAxHNdCkxJ2kWTI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 07/14] RDMA/ucma: Do not use file->mut to lock destroying
Date:   Tue, 18 Aug 2020 15:05:19 +0300
Message-Id: <20200818120526.702120-8-leon@kernel.org>
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

The only reader of destroying is inside a handler under the handler_mutex,
so directly use the handler_mutex when setting it instead of the larger
file->mut.

As the refcount could be zero here, and the cm_id already freed, and
additional refcount grab around the locking is required to touch the
cm_id.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/ucma.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index add1ece38739..18285941aec3 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -602,9 +602,17 @@ static int ucma_free_ctx(struct ucma_context *ctx)
 
 static int __destroy_id(struct ucma_context *ctx)
 {
-	mutex_lock(&ctx->file->mut);
-	ctx->destroying = 1;
-	mutex_unlock(&ctx->file->mut);
+	/*
+	 * If the refcount is already 0 then ucma_close_id() has already
+	 * destroyed the cm_id, otherwise holding the refcount keeps cm_id
+	 * valid. Prevent queue_work() from being called.
+	 */
+	if (refcount_inc_not_zero(&ctx->ref)) {
+		rdma_lock_handler(ctx->cm_id);
+		ctx->destroying = 1;
+		rdma_unlock_handler(ctx->cm_id);
+		ucma_put_ctx(ctx);
+	}
 
 	flush_workqueue(ctx->file->close_wq);
 	/* At this point it's guaranteed that there is no inflight closing task */
-- 
2.26.2

