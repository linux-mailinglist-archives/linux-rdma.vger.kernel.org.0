Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC7D248468
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 14:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgHRMGN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 08:06:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgHRMGN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Aug 2020 08:06:13 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C7CB20786;
        Tue, 18 Aug 2020 12:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597752372;
        bh=rl/Z2odzEWhcaq+O4fQ8wGyfGXYO8QiRItaan/mRMcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=niFQvlXSgVKmkqbX6Rd6Zg7ja1haspgvYjbJ3gqHiKunJv+X6jLu5hDIy5BBW6nEv
         WRwxcwSmS621wkGGAkRoeAtsqhf6OX8T45PX4BF0Q4GeCyRRk+U6hz/fZ46z8Sj/z7
         lN0ZcljEkWpCAAMsRZwyaWzWG2jW2f5gq5En64/A=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 11/14] RDMA/ucma: Change backlog into an atomic
Date:   Tue, 18 Aug 2020 15:05:23 +0300
Message-Id: <20200818120526.702120-12-leon@kernel.org>
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

There is no reason to grab the file->mut just to do this inc/dec work. Use
an atomic.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/ucma.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index ad78b05de656..8be8ff14ab62 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -88,7 +88,7 @@ struct ucma_context {
 	struct completion	comp;
 	refcount_t		ref;
 	int			events_reported;
-	int			backlog;
+	atomic_t		backlog;
 
 	struct ucma_file	*file;
 	struct rdma_cm_id	*cm_id;
@@ -348,12 +348,11 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
 	uevent->resp.ece.attr_mod = event->ece.attr_mod;
 
 	if (event->event == RDMA_CM_EVENT_CONNECT_REQUEST) {
-		if (!ctx->backlog) {
+		if (!atomic_add_unless(&ctx->backlog, -1, 0)) {
 			ret = -ENOMEM;
 			kfree(uevent);
 			goto out;
 		}
-		ctx->backlog--;
 	} else if (!ctx->uid || ctx->cm_id != cm_id) {
 		/*
 		 * We ignore events for new connections until userspace has set
@@ -432,7 +431,7 @@ static ssize_t ucma_get_event(struct ucma_file *file, const char __user *inbuf,
 	}
 
 	if (ctx) {
-		uevent->ctx->backlog++;
+		atomic_inc(&uevent->ctx->backlog);
 		uevent->cm_id->context = ctx;
 		ucma_finish_ctx(ctx);
 	}
@@ -1136,10 +1135,12 @@ static ssize_t ucma_listen(struct ucma_file *file, const char __user *inbuf,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	ctx->backlog = cmd.backlog > 0 && cmd.backlog < max_backlog ?
-		       cmd.backlog : max_backlog;
+	if (cmd.backlog <= 0 || cmd.backlog > max_backlog)
+		cmd.backlog = max_backlog;
+	atomic_set(&ctx->backlog, cmd.backlog);
+
 	mutex_lock(&ctx->mutex);
-	ret = rdma_listen(ctx->cm_id, ctx->backlog);
+	ret = rdma_listen(ctx->cm_id, cmd.backlog);
 	mutex_unlock(&ctx->mutex);
 	ucma_put_ctx(ctx);
 	return ret;
-- 
2.26.2

