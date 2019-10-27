Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E96E613B
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfJ0HGw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HGw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:06:52 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 281B420578;
        Sun, 27 Oct 2019 07:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160011;
        bh=lGSqvEeF5EXYNynXI8/iLdnGx2TbiG6rNc3JRwCvLlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fd5kmKjI6mC+KAX6jNiy3gNReEU+4kJ7pJvGPo1mu6mt0qHcbNNGaY9DerMB/7JQM
         Wby2oVL0fQje5PL2clB+y174Jm1Rq3ubB5g31zxtT2gPu0l6CPZTdTFtMKvv/8i9Ki
         NL1eYIh1wGSjNWuxn9i79EBe6nMbvyEEkcsOeS6c=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 08/43] RDMA/cm: Reply To Request For Communication Release (DREP) definitions
Date:   Sun, 27 Oct 2019 09:05:46 +0200
Message-Id: <20191027070621.11711-9-leon@kernel.org>
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

Add DREP definitions as it is written in IBTA release 1.3 volume 1.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 4 ++--
 drivers/infiniband/core/cm_msgs.h | 9 ++++++++-
 include/rdma/ib_cm.h              | 1 -
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 7f3cc66372eb..4858b6aaac7f 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2514,7 +2514,7 @@ int ib_send_cm_drep(struct ib_cm_id *cm_id,
 	void *data;
 	int ret;
 
-	if (private_data && private_data_len > IB_CM_DREP_PRIVATE_DATA_SIZE)
+	if (private_data && private_data_len > CM_DREP_PRIVATE_DATA_SIZE)
 		return -EINVAL;
 
 	data = cm_copy_private_data(private_data, private_data_len);
@@ -2675,7 +2675,7 @@ static int cm_drep_handler(struct cm_work *work)
 		return -EINVAL;
 
 	work->cm_event.private_data = &drep_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_DREP_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_DREP_PRIVATE_DATA_SIZE;
 
 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->id.state != IB_CM_DREQ_SENT &&
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index dded0bd59479..a7ccd27a2f19 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -260,6 +260,13 @@
 #define CM_DREQ_PRIVATE_DATA_OFFSET 12
 #define CM_DREQ_PRIVATE_DATA_SIZE 220
 
+#define CM_DREP_LOCAL_COMM_ID_OFFSET 0
+#define CM_DREP_LOCAL_COMM_ID_MASK GENMASK(31, 0)
+#define CM_DREP_REMOTE_COMM_ID_OFFSET 4
+#define CM_DREP_REMOTE_COMM_ID_MASK GENMASK(31, 0)
+#define CM_DREP_PRIVATE_DATA_OFFSET 8
+#define CM_DREP_PRIVATE_DATA_SIZE 224
+
 struct cm_req_msg {
 	struct ib_mad_hdr hdr;
 
@@ -861,7 +868,7 @@ struct cm_drep_msg {
 	__be32 local_comm_id;
 	__be32 remote_comm_id;
 
-	u8 private_data[IB_CM_DREP_PRIVATE_DATA_SIZE];
+	u8 private_data[CM_DREP_PRIVATE_DATA_SIZE];
 
 } __packed;
 
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index 77f4818aaf10..f1fccc8f387f 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -65,7 +65,6 @@ enum ib_cm_event_type {
 };
 
 enum ib_cm_data_size {
-	IB_CM_DREP_PRIVATE_DATA_SIZE	 = 224,
 	IB_CM_LAP_PRIVATE_DATA_SIZE	 = 168,
 	IB_CM_APR_PRIVATE_DATA_SIZE	 = 148,
 	IB_CM_APR_INFO_LENGTH		 = 72,
-- 
2.20.1

