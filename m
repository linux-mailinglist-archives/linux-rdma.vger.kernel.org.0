Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24E3248469
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 14:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHRMGR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 08:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgHRMGR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Aug 2020 08:06:17 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A5DC20786;
        Tue, 18 Aug 2020 12:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597752376;
        bh=mv3xcIipahEWdyjZ0Cn5dOLoL/Gdt6vswNZUBhh061c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=shofpekAsubo2rIlXZ/mjzTID5oOonP+AsQq7DgVmv0lQ2sQm5jg47kb/FBLGkjhm
         uEhdYt6uIXXbt2wupIxFg25PFhx1w26FMYPdKl4c24OMV6fqlAFopFumAEOu4Dwj5F
         S08Q14AclhWIK2Bjy80pZJB7nu9uVVLR9ridN57c=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 12/14] RDMA/ucma: Narrow file->mut in ucma_event_handler()
Date:   Tue, 18 Aug 2020 15:05:24 +0300
Message-Id: <20200818120526.702120-13-leon@kernel.org>
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

Since the backlog is now an atomic the file->mut is now only protecting
the event_list and ctx_list. Narrow its scope to make it clear

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/ucma.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 8be8ff14ab62..32e82bcffccd 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -283,7 +283,6 @@ static void ucma_set_event_context(struct ucma_context *ctx,
 	}
 }
 
-/* Called with file->mut locked for the relevant context. */
 static void ucma_removal_event_handler(struct rdma_cm_id *cm_id)
 {
 	struct ucma_context *ctx = cm_id->context;
@@ -307,6 +306,7 @@ static void ucma_removal_event_handler(struct rdma_cm_id *cm_id)
 		return;
 	}
 
+	mutex_lock(&ctx->file->mut);
 	list_for_each_entry(con_req_eve, &ctx->file->event_list, list) {
 		if (con_req_eve->cm_id == cm_id &&
 		    con_req_eve->resp.event == RDMA_CM_EVENT_CONNECT_REQUEST) {
@@ -317,6 +317,7 @@ static void ucma_removal_event_handler(struct rdma_cm_id *cm_id)
 			break;
 		}
 	}
+	mutex_unlock(&ctx->file->mut);
 	if (!event_found)
 		pr_err("ucma_removal_event_handler: warning: connect request event wasn't found\n");
 }
@@ -326,13 +327,11 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
 {
 	struct ucma_event *uevent;
 	struct ucma_context *ctx = cm_id->context;
-	int ret = 0;
 
 	uevent = kzalloc(sizeof(*uevent), GFP_KERNEL);
 	if (!uevent)
 		return event->event == RDMA_CM_EVENT_CONNECT_REQUEST;
 
-	mutex_lock(&ctx->file->mut);
 	uevent->cm_id = cm_id;
 	ucma_set_event_context(ctx, event, uevent);
 	uevent->resp.event = event->event;
@@ -349,9 +348,8 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
 
 	if (event->event == RDMA_CM_EVENT_CONNECT_REQUEST) {
 		if (!atomic_add_unless(&ctx->backlog, -1, 0)) {
-			ret = -ENOMEM;
 			kfree(uevent);
-			goto out;
+			return -ENOMEM;
 		}
 	} else if (!ctx->uid || ctx->cm_id != cm_id) {
 		/*
@@ -366,16 +364,16 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
 			ucma_removal_event_handler(cm_id);
 
 		kfree(uevent);
-		goto out;
+		return 0;
 	}
 
+	mutex_lock(&ctx->file->mut);
 	list_add_tail(&uevent->list, &ctx->file->event_list);
+	mutex_unlock(&ctx->file->mut);
 	wake_up_interruptible(&ctx->file->poll_wait);
 	if (event->event == RDMA_CM_EVENT_DEVICE_REMOVAL)
 		ucma_removal_event_handler(cm_id);
-out:
-	mutex_unlock(&ctx->file->mut);
-	return ret;
+	return 0;
 }
 
 static ssize_t ucma_get_event(struct ucma_file *file, const char __user *inbuf,
-- 
2.26.2

