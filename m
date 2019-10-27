Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB60E6137
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfJ0HGi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HGi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:06:38 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7DF320873;
        Sun, 27 Oct 2019 07:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572159997;
        bh=KVKJPW7zV4bL2jFLGEpFVVfsUTJQvcY5YqRcXcv72Fo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ChwI5LYwITZLlHjBulv4G7CaZLWNgdUMP7kviUdFrRP/ijF6qjUQkD/98Xtal3bcO
         ckYPUI4EwNaa5tRxy4VaFR40PhuvzkEdxqOsD/Z4j+5DRJxhK4KYWTD/7J+dsJtxnd
         B4cImd7/2DUwpszNCwxgp92f1+PW7uSpNp4RAhxM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 03/43] RDMA/cm: Message Receipt Acknowledgment (MRA) message definitions
Date:   Sun, 27 Oct 2019 09:05:41 +0200
Message-Id: <20191027070621.11711-4-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191027070621.11711-1-leon@kernel.org>
References: <20191027070621.11711-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Add Message Receipt Acknowledgment (MRA) definitions as it is written
in IBTA release 1.3 volume 1.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  4 ++--
 drivers/infiniband/core/cm_msgs.h | 13 ++++++++++++-
 include/rdma/ib_cm.h              |  1 -
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 7163a5782bea..c477629f5106 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2894,7 +2894,7 @@ int ib_send_cm_mra(struct ib_cm_id *cm_id,
 	unsigned long flags;
 	int ret;
 
-	if (private_data && private_data_len > IB_CM_MRA_PRIVATE_DATA_SIZE)
+	if (private_data && private_data_len > CM_MRA_PRIVATE_DATA_SIZE)
 		return -EINVAL;
 
 	data = cm_copy_private_data(private_data, private_data_len);
@@ -2988,7 +2988,7 @@ static int cm_mra_handler(struct cm_work *work)
 		return -EINVAL;
 
 	work->cm_event.private_data = &mra_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_MRA_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_MRA_PRIVATE_DATA_SIZE;
 	work->cm_event.param.mra_rcvd.service_timeout =
 					cm_mra_get_service_timeout(mra_msg);
 	timeout = cm_convert_to_ms(cm_mra_get_service_timeout(mra_msg)) +
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index a9112af2b325..20784b0fa4af 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -186,6 +186,17 @@
 #define CM_REQ_PRIVATE_DATA_OFFSET 140
 #define CM_REQ_PRIVATE_DATA_SIZE 92
 
+#define CM_MRA_LOCAL_COMM_ID_OFFSET 0
+#define CM_MRA_LOCAL_COMM_ID_MASK GENMASK(31, 0)
+#define CM_MRA_REMOTE_COMM_ID_OFFSET 4
+#define CM_MRA_REMOTE_COMM_ID_MASK GENMASK(31, 0)
+#define CM_MRA_MESSAGE_MRAED_OFFSET 8
+#define CM_MRA_MESSAGE_MRAED_MASK GENMASK(1, 0)
+#define CM_MRA_SERVICE_TIMEOUT_OFFSET 9
+#define CM_MRA_SERVICE_TIMEOUT_MASK GENMASK(4, 0)
+#define CM_MRA_PRIVATE_DATA_OFFSET 10
+#define CM_MRA_PRIVATE_DATA_SIZE 222
+
 struct cm_req_msg {
 	struct ib_mad_hdr hdr;
 
@@ -563,7 +574,7 @@ enum cm_msg_response {
 	/* service timeout:5, rsvd:3 */
 	u8 offset9;
 
-	u8 private_data[IB_CM_MRA_PRIVATE_DATA_SIZE];
+	u8 private_data[CM_MRA_PRIVATE_DATA_SIZE];
 
 } __packed;
 
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index 956256b2fc5d..6d73316be651 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -65,7 +65,6 @@ enum ib_cm_event_type {
 };
 
 enum ib_cm_data_size {
-	IB_CM_MRA_PRIVATE_DATA_SIZE	 = 222,
 	IB_CM_REJ_PRIVATE_DATA_SIZE	 = 148,
 	IB_CM_REP_PRIVATE_DATA_SIZE	 = 196,
 	IB_CM_RTU_PRIVATE_DATA_SIZE	 = 224,
-- 
2.20.1

