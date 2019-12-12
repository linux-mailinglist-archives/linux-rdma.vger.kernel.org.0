Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A80EC11C974
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfLLJjQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:39:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728427AbfLLJjQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:39:16 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95388214D8;
        Thu, 12 Dec 2019 09:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143555;
        bh=MywUgQYs3tI+fsLzBEbvhHq21Vz73iUYJrinWRabm4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kyE0iWyXe6my5cIryvCR89IBI34PrEp6WGYoC30F6wnQ/lvR06uwPh13SsHWWfpcw
         gFv7mqb4lf+I9MOjTH9hhi2nvQzRaN+YMTzOeNoUcK+7fIAEbjJZ1geGGxV2ydFKN3
         CAQANw5QDtiGv/dKvhi+RWJU3D5xf+T+DUGaeiUE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 12/48] RDMA/cm: Load Alternate Path (LAP) definitions
Date:   Thu, 12 Dec 2019 11:37:54 +0200
Message-Id: <20191212093830.316934-13-leon@kernel.org>
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

Add LAP message definitions as it is written in IBTA release 1.3 volume 1.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  4 ++--
 drivers/infiniband/core/cm_msgs.h |  2 +-
 include/rdma/ib_cm.h              |  1 -
 include/rdma/ibta_vol1_c12.h      | 26 ++++++++++++++++++++++++++
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index d11ca6bdf016..002904c03554 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3110,7 +3110,7 @@ int ib_send_cm_lap(struct ib_cm_id *cm_id,
 	unsigned long flags;
 	int ret;
 
-	if (private_data && private_data_len > IB_CM_LAP_PRIVATE_DATA_SIZE)
+	if (private_data && private_data_len > CM_LAP_PRIVATE_DATA_SIZE)
 		return -EINVAL;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
@@ -3224,7 +3224,7 @@ static int cm_lap_handler(struct cm_work *work)
 	param->alternate_path = &work->path[0];
 	cm_format_path_from_lap(cm_id_priv, param->alternate_path, lap_msg);
 	work->cm_event.private_data = &lap_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_LAP_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_LAP_PRIVATE_DATA_SIZE;
 
 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->id.state != IB_CM_ESTABLISHED)
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 98088a84f2fc..6c94d083c996 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -644,7 +644,7 @@ struct cm_lap_msg {
 	/* local ACK timeout:5, rsvd:3 */
 	u8 offset63;
 
-	u8 private_data[IB_CM_LAP_PRIVATE_DATA_SIZE];
+	u8 private_data[CM_LAP_PRIVATE_DATA_SIZE];
 } __packed;
 
 static inline __be32 cm_lap_get_remote_qpn(struct cm_lap_msg *lap_msg)
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index f1fccc8f387f..08d3217bdaf1 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -65,7 +65,6 @@ enum ib_cm_event_type {
 };
 
 enum ib_cm_data_size {
-	IB_CM_LAP_PRIVATE_DATA_SIZE	 = 168,
 	IB_CM_APR_PRIVATE_DATA_SIZE	 = 148,
 	IB_CM_APR_INFO_LENGTH		 = 72,
 	IB_CM_SIDR_REQ_PRIVATE_DATA_SIZE = 216,
diff --git a/include/rdma/ibta_vol1_c12.h b/include/rdma/ibta_vol1_c12.h
index 8d57e24534aa..d998cf0cde4c 100644
--- a/include/rdma/ibta_vol1_c12.h
+++ b/include/rdma/ibta_vol1_c12.h
@@ -145,4 +145,30 @@
 #define CM_DREP_PRIVATE_DATA CM_FIELD_MLOC(struct cm_drep_msg, 8, 1792)
 #define CM_DREP_PRIVATE_DATA_SIZE 224
 
+/* Table 115 LAP Message Contents */
+#define CM_LAP_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_lap_msg, 0, 32)
+#define CM_LAP_REMOTE_COMM_ID CM_FIELD32_LOC(struct cm_lap_msg, 4, 32)
+#define CM_LAP_REMOTE_QPN_EECN CM_FIELD32_LOC(struct cm_lap_msg, 12, 24)
+#define CM_LAP_REMOTE_CM_RESPONSE_TIMEOUT                                      \
+	CM_FIELD8_LOC(struct cm_lap_msg, 15, 5)
+#define CM_LAP_ALTERNATE_LOCAL_PORT_LID                                        \
+	CM_FIELD16_LOC(struct cm_lap_msg, 20, 16)
+#define CM_LAP_ALTERNATE_REMOTE_PORT_LID                                       \
+	CM_FIELD16_LOC(struct cm_lap_msg, 22, 16)
+#define CM_LAP_ALTERNATE_LOCAL_PORT_GID                                        \
+	CM_FIELD_MLOC(struct cm_lap_msg, 24, 128)
+#define CM_LAP_ALTERNATE_REMOTE_PORT_GID                                       \
+	CM_FIELD_MLOC(struct cm_lap_msg, 40, 128)
+#define CM_LAP_ALTERNATE_FLOW_LABEL CM_FIELD32_LOC(struct cm_lap_msg, 56, 20)
+#define CM_LAP_ALTERNATE_TRAFFIC_CLASS CM_FIELD8_LOC(struct cm_lap_msg, 59, 8)
+#define CM_LAP_ALTERNATE_HOP_LIMIT CM_FIELD8_LOC(struct cm_lap_msg, 60, 8)
+#define CM_LAP_ALTERNATE_PACKET_RATE CM_FIELD_BLOC(struct cm_lap_msg, 61, 2, 6)
+#define CM_LAP_ALTERNATE_SL CM_FIELD8_LOC(struct cm_lap_msg, 62, 4)
+#define CM_LAP_ALTERNATE_SUBNET_LOCAL                                          \
+	CM_FIELD_BLOC(struct cm_lap_msg, 62, 4, 1)
+#define CM_LAP_ALTERNATE_LOCAL_ACK_TIMEOUT                                     \
+	CM_FIELD8_LOC(struct cm_lap_msg, 63, 5)
+#define CM_LAP_PRIVATE_DATA CM_FIELD_MLOC(struct cm_lap_msg, 64, 1344)
+#define CM_LAP_PRIVATE_DATA_SIZE 168
+
 #endif /* _IBTA_VOL1_C12_H_ */
-- 
2.20.1

