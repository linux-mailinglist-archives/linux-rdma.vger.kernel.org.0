Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685A61A67AD
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 16:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbgDMOP6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 10:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730417AbgDMOP5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 10:15:57 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A78652075E;
        Mon, 13 Apr 2020 14:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586787357;
        bh=TS3Nv/0eudYMFcl8DRFARMo0DGxMAFm3mGpjELkwPB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fEYU9OwLjvov8ltAU3+pRGNrOvD2nmc/oXPaYykCQKr35evNDmvuAVVk+eSb1RNDp
         zXwkoWlO4wRnGQ0zoXkGvOn5eMf0892YtUelFHYiRq4xzJHRuxjZGzMvdyWiyPzXi4
         hm6u2eurT3PY6sni7Unb0goNnu8yyhtVU+E7aVw8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 4/7] RDMA/ucma: Deliver ECE parameters through UCMA events
Date:   Mon, 13 Apr 2020 17:15:35 +0300
Message-Id: <20200413141538.935574-5-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200413141538.935574-1-leon@kernel.org>
References: <20200413141538.935574-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Passive side of CMID connection receives ECE request through
REQ message and needs to respond with relevant REP message which
will be forwarded to active side.

The UCMA events interface is responsible for such communication
with the user space (librdmacm). Extend it to provide ECE wire
data.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/ucma.c | 6 +++++-
 include/rdma/rdma_cm.h         | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index f7415d8d2140..ed2c17046ee1 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -360,6 +360,9 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
 		ucma_copy_conn_event(&uevent->resp.param.conn,
 				     &event->param.conn);
 
+	uevent->resp.ece.vendor_id = event->ece.vendor_id;
+	uevent->resp.ece.attr_mod = event->ece.attr_mod;
+
 	if (event->event == RDMA_CM_EVENT_CONNECT_REQUEST) {
 		if (!ctx->backlog) {
 			ret = -ENOMEM;
@@ -404,7 +407,8 @@ static ssize_t ucma_get_event(struct ucma_file *file, const char __user *inbuf,
 	 * Old 32 bit user space does not send the 4 byte padding in the
 	 * reserved field. We don't care, allow it to keep working.
 	 */
-	if (out_len < sizeof(uevent->resp) - sizeof(uevent->resp.reserved))
+	if (out_len < sizeof(uevent->resp) - sizeof(uevent->resp.reserved) -
+			      sizeof(uevent->resp.ece))
 		return -ENOSPC;
 
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index 86a849214c84..761168c41848 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -111,6 +111,7 @@ struct rdma_cm_event {
 		struct rdma_conn_param	conn;
 		struct rdma_ud_param	ud;
 	} param;
+	struct rdma_ucm_ece ece;
 };
 
 struct rdma_cm_id;
-- 
2.25.2

