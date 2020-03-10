Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC6717F333
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgCJJPG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgCJJPG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:15:06 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 801CC20674;
        Tue, 10 Mar 2020 09:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583831706;
        bh=SZZlSd7JhVMxlX8MKvUIfWUsEB4/MjplU/y6r67uVm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yhqb2U3XJPeuCLLpUtbyBCuB9ELbqRIYoefIBkkQjfgb09ZKRl7O9qcmc/yHl8cYt
         6KGDQT8KQR6uDYiGVyYZNzzTMn7zmqiQGivlwY5xkdmVmswi4vkfNQGhVLY1Mr8GF0
         RpwRqIaUFTRh4Bn6UwLp6PpEmthnpKjAnkHg6ObY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 08/11] RDMA/ucma: Deliver ECE parameters through UCMA events
Date:   Tue, 10 Mar 2020 11:14:35 +0200
Message-Id: <20200310091438.248429-9-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310091438.248429-1-leon@kernel.org>
References: <20200310091438.248429-1-leon@kernel.org>
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
2.24.1

