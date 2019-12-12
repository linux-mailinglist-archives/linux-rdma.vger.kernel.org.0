Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF4B611C970
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfLLJjE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:39:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728391AbfLLJjD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:39:03 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F00FE24658;
        Thu, 12 Dec 2019 09:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143542;
        bh=tEpnAuH9ayv0PtHjnpsZNv2gr0idcNkG1PiAPiJS5cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HugBWU91xn4ZgeRemDOC+e/0KEHHMeJ7/8hBKENS7wjEO/s5GNX+zLJYmugIO+agx
         PPsNzMc+W3WZRWAZElEf1c7A6CPk31397wZwpa4QwfJMtB+/Vhr/0yMjXYeDSlYT8b
         knNgrzSwXGoAyajjFtPgVyZTGnn9XXdJdsk4Izv4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 08/48] RDMA/cm: Reply To Request for communication (REP) definitions
Date:   Thu, 12 Dec 2019 11:37:50 +0200
Message-Id: <20191212093830.316934-9-leon@kernel.org>
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

Add REP message definitions as it is written
in IBTA release 1.3 volume 1.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  4 ++--
 drivers/infiniband/core/cm_msgs.h |  2 +-
 drivers/infiniband/core/cma.c     |  2 +-
 include/rdma/ib_cm.h              |  1 -
 include/rdma/ibta_vol1_c12.h      | 19 +++++++++++++++++++
 5 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index f19c817ac99f..ffdca9d1c3f6 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2068,7 +2068,7 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
 	int ret;
 
 	if (param->private_data &&
-	    param->private_data_len > IB_CM_REP_PRIVATE_DATA_SIZE)
+	    param->private_data_len > CM_REP_PRIVATE_DATA_SIZE)
 		return -EINVAL;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
@@ -2197,7 +2197,7 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
 	param->srq = cm_rep_get_srq(rep_msg);
 	work->cm_event.private_data = &rep_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_REP_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_REP_PRIVATE_DATA_SIZE;
 }
 
 static void cm_dup_rep_handler(struct cm_work *work)
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 48c97ec4ae13..b66e9eaf9721 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -474,7 +474,7 @@ struct cm_rep_msg {
 	u8 offset27;
 	__be64 local_ca_guid;
 
-	u8 private_data[IB_CM_REP_PRIVATE_DATA_SIZE];
+	u8 private_data[CM_REP_PRIVATE_DATA_SIZE];
 
 } __packed;
 
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 8495ad001e92..ece92889aa88 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1882,7 +1882,7 @@ static void cma_set_rep_event_data(struct rdma_cm_event *event,
 				   void *private_data)
 {
 	event->param.conn.private_data = private_data;
-	event->param.conn.private_data_len = IB_CM_REP_PRIVATE_DATA_SIZE;
+	event->param.conn.private_data_len = CM_REP_PRIVATE_DATA_SIZE;
 	event->param.conn.responder_resources = rep_data->responder_resources;
 	event->param.conn.initiator_depth = rep_data->initiator_depth;
 	event->param.conn.flow_control = rep_data->flow_control;
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index a5b9bd49041b..ebfbf63388de 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -65,7 +65,6 @@ enum ib_cm_event_type {
 };
 
 enum ib_cm_data_size {
-	IB_CM_REP_PRIVATE_DATA_SIZE	 = 196,
 	IB_CM_RTU_PRIVATE_DATA_SIZE	 = 224,
 	IB_CM_DREQ_PRIVATE_DATA_SIZE	 = 220,
 	IB_CM_DREP_PRIVATE_DATA_SIZE	 = 224,
diff --git a/include/rdma/ibta_vol1_c12.h b/include/rdma/ibta_vol1_c12.h
index 08378eb4d6df..966517ed229d 100644
--- a/include/rdma/ibta_vol1_c12.h
+++ b/include/rdma/ibta_vol1_c12.h
@@ -107,4 +107,23 @@
 #define CM_REJ_PRIVATE_DATA CM_FIELD_MLOC(struct cm_rej_msg, 84, 1184)
 #define CM_REJ_PRIVATE_DATA_SIZE 148
 
+/* Table 110 REP Message Contents */
+#define CM_REP_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_rep_msg, 0, 32)
+#define CM_REP_REMOTE_COMM_ID CM_FIELD32_LOC(struct cm_rep_msg, 4, 32)
+#define CM_REP_LOCAL_Q_KEY CM_FIELD32_LOC(struct cm_rep_msg, 8, 32)
+#define CM_REP_LOCAL_QPN CM_FIELD32_LOC(struct cm_rep_msg, 12, 24)
+#define CM_REP_LOCAL_EE_CONTEXT_NUMBER CM_FIELD32_LOC(struct cm_rep_msg, 16, 24)
+#define CM_REP_STARTING_PSN CM_FIELD32_LOC(struct cm_rep_msg, 20, 24)
+#define CM_REP_RESPONDER_RESOURCES CM_FIELD8_LOC(struct cm_rep_msg, 24, 8)
+#define CM_REP_INITIATOR_DEPTH CM_FIELD8_LOC(struct cm_rep_msg, 25, 8)
+#define CM_REP_TARGET_ACK_DELAY CM_FIELD8_LOC(struct cm_rep_msg, 26, 5)
+#define CM_REP_FAILOVER_ACCEPTED CM_FIELD_BLOC(struct cm_rep_msg, 26, 5, 2)
+#define CM_REP_END_TO_END_FLOW_CONTROL                                         \
+	CM_FIELD_BLOC(struct cm_rep_msg, 26, 7, 1)
+#define CM_REP_RNR_RETRY_COUNT CM_FIELD8_LOC(struct cm_rep_msg, 27, 3)
+#define CM_REP_SRQ CM_FIELD_BLOC(struct cm_rep_msg, 27, 3, 1)
+#define CM_REP_LOCAL_CA_GUID CM_FIELD64_LOC(struct cm_rep_msg, 28, 64)
+#define CM_REP_PRIVATE_DATA CM_FIELD_MLOC(struct cm_rep_msg, 36, 1568)
+#define CM_REP_PRIVATE_DATA_SIZE 196
+
 #endif /* _IBTA_VOL1_C12_H_ */
-- 
2.20.1

