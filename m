Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B53911C971
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfLLJjH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:39:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728391AbfLLJjG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:39:06 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A8A92465A;
        Thu, 12 Dec 2019 09:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143545;
        bh=9dpnPKouONJcsK7rILddoiGoJHU5HQ+1FG57ZwYnIfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z1gIBTuuQaMaF4zNNios4WGAMzpiPllWdMUmCnGxVWIheU9bp4u5kQJPxBhY/rIeq
         lFsmeF5c2t8qFOmF9NqZ5aQiOOOEVtS9m4yv8o4Zn8CqMOBiBXwGc4FHEHEOaDE4gu
         fg4eOpv9A0gYmlj1oQoxiUf1duXBxI9gAhj2ENRo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 09/48] RDMA/cm: Ready To Use (RTU) definitions
Date:   Thu, 12 Dec 2019 11:37:51 +0200
Message-Id: <20191212093830.316934-10-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212093830.316934-1-leon@kernel.org>
References: <20191212093830.316934-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Add RTU message definitions as it is written in IBTA release 1.3 volume 1.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 4 ++--
 drivers/infiniband/core/cm_msgs.h | 2 +-
 include/rdma/ib_cm.h              | 1 -
 include/rdma/ibta_vol1_c12.h      | 6 ++++++
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index ffdca9d1c3f6..73f93e354d8b 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2135,7 +2135,7 @@ int ib_send_cm_rtu(struct ib_cm_id *cm_id,
 	void *data;
 	int ret;
 
-	if (private_data && private_data_len > IB_CM_RTU_PRIVATE_DATA_SIZE)
+	if (private_data && private_data_len > CM_RTU_PRIVATE_DATA_SIZE)
 		return -EINVAL;
 
 	data = cm_copy_private_data(private_data, private_data_len);
@@ -2400,7 +2400,7 @@ static int cm_rtu_handler(struct cm_work *work)
 		return -EINVAL;
 
 	work->cm_event.private_data = &rtu_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_RTU_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_RTU_PRIVATE_DATA_SIZE;
 
 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->id.state != IB_CM_REP_SENT &&
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index b66e9eaf9721..d36e90ccaeb7 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -582,7 +582,7 @@ struct cm_rtu_msg {
 	__be32 local_comm_id;
 	__be32 remote_comm_id;
 
-	u8 private_data[IB_CM_RTU_PRIVATE_DATA_SIZE];
+	u8 private_data[CM_RTU_PRIVATE_DATA_SIZE];
 
 } __packed;
 
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index ebfbf63388de..34dc12b30399 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -65,7 +65,6 @@ enum ib_cm_event_type {
 };
 
 enum ib_cm_data_size {
-	IB_CM_RTU_PRIVATE_DATA_SIZE	 = 224,
 	IB_CM_DREQ_PRIVATE_DATA_SIZE	 = 220,
 	IB_CM_DREP_PRIVATE_DATA_SIZE	 = 224,
 	IB_CM_LAP_PRIVATE_DATA_SIZE	 = 168,
diff --git a/include/rdma/ibta_vol1_c12.h b/include/rdma/ibta_vol1_c12.h
index 966517ed229d..892d3122023c 100644
--- a/include/rdma/ibta_vol1_c12.h
+++ b/include/rdma/ibta_vol1_c12.h
@@ -126,4 +126,10 @@
 #define CM_REP_PRIVATE_DATA CM_FIELD_MLOC(struct cm_rep_msg, 36, 1568)
 #define CM_REP_PRIVATE_DATA_SIZE 196
 
+/* Table 111 RTU Message Contents */
+#define CM_RTU_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_rtu_msg, 0, 32)
+#define CM_RTU_REMOTE_COMM_ID CM_FIELD32_LOC(struct cm_rtu_msg, 4, 32)
+#define CM_RTU_PRIVATE_DATA CM_FIELD_MLOC(struct cm_rtu_msg, 8, 1792)
+#define CM_RTU_PRIVATE_DATA_SIZE 224
+
 #endif /* _IBTA_VOL1_C12_H_ */
-- 
2.20.1

