Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37BB911C973
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfLLJjN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:39:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:39402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728427AbfLLJjN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:39:13 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64FFD24658;
        Thu, 12 Dec 2019 09:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143552;
        bh=4oSh45tk7GMq9y7eBVzjTgs4Wa2Ozwau6RsA6aDNDi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iErSsLikqSsyapbUHe+DQIvbBZmFk9JIZOy0/IBVuxOGXPWyLXDUQWY1gMTxP/zMP
         ZGEU6kmeILEccP8a+WnhMfo23cHkWmoOTXRlP9tGaqR+NkFQcWzPj77KoSKAzWlKIw
         v5YUpuO0jRXwyEXZlF8x47Ox/TvndS/Lsj7JoGfY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 07/48] RDMA/cm: Reject (REJ) message definitions
Date:   Thu, 12 Dec 2019 11:37:49 +0200
Message-Id: <20191212093830.316934-8-leon@kernel.org>
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

Add Reject (REJ) definitions as it is written
in IBTA release 1.3 volume 1.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  6 +++---
 drivers/infiniband/core/cm_msgs.h |  4 ++--
 drivers/infiniband/core/cma.c     |  2 +-
 include/rdma/ib_cm.h              |  2 --
 include/rdma/ibta_vol1_c12.h      | 11 +++++++++++
 5 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 5a0ee9e46ff9..f19c817ac99f 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2716,8 +2716,8 @@ int ib_send_cm_rej(struct ib_cm_id *cm_id,
 	unsigned long flags;
 	int ret;
 
-	if ((private_data && private_data_len > IB_CM_REJ_PRIVATE_DATA_SIZE) ||
-	    (ari && ari_length > IB_CM_REJ_ARI_LENGTH))
+	if ((private_data && private_data_len > CM_REJ_PRIVATE_DATA_SIZE) ||
+	    (ari && ari_length > CM_REJ_ARI_SIZE))
 		return -EINVAL;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
@@ -2778,7 +2778,7 @@ static void cm_format_rej_event(struct cm_work *work)
 	param->ari_length = cm_rej_get_reject_info_len(rej_msg);
 	param->reason = __be16_to_cpu(rej_msg->reason);
 	work->cm_event.private_data = &rej_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_REJ_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_REJ_PRIVATE_DATA_SIZE;
 }
 
 static struct cm_id_private * cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 888209ec058d..48c97ec4ae13 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -427,9 +427,9 @@ struct cm_rej_msg {
 	/* reject info length:7, rsvd:1. */
 	u8 offset9;
 	__be16 reason;
-	u8 ari[IB_CM_REJ_ARI_LENGTH];
+	u8 ari[CM_REJ_ARI_SIZE];
 
-	u8 private_data[IB_CM_REJ_PRIVATE_DATA_SIZE];
+	u8 private_data[CM_REJ_PRIVATE_DATA_SIZE];
 
 } __packed;
 
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 02490a3c11f3..8495ad001e92 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1951,7 +1951,7 @@ static int cma_ib_handler(struct ib_cm_id *cm_id,
 		event.status = ib_event->param.rej_rcvd.reason;
 		event.event = RDMA_CM_EVENT_REJECTED;
 		event.param.conn.private_data = ib_event->private_data;
-		event.param.conn.private_data_len = IB_CM_REJ_PRIVATE_DATA_SIZE;
+		event.param.conn.private_data_len = CM_REJ_PRIVATE_DATA_SIZE;
 		break;
 	default:
 		pr_err("RDMA CMA: unexpected IB CM event: %d\n",
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index 6d73316be651..a5b9bd49041b 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -65,12 +65,10 @@ enum ib_cm_event_type {
 };
 
 enum ib_cm_data_size {
-	IB_CM_REJ_PRIVATE_DATA_SIZE	 = 148,
 	IB_CM_REP_PRIVATE_DATA_SIZE	 = 196,
 	IB_CM_RTU_PRIVATE_DATA_SIZE	 = 224,
 	IB_CM_DREQ_PRIVATE_DATA_SIZE	 = 220,
 	IB_CM_DREP_PRIVATE_DATA_SIZE	 = 224,
-	IB_CM_REJ_ARI_LENGTH		 = 72,
 	IB_CM_LAP_PRIVATE_DATA_SIZE	 = 168,
 	IB_CM_APR_PRIVATE_DATA_SIZE	 = 148,
 	IB_CM_APR_INFO_LENGTH		 = 72,
diff --git a/include/rdma/ibta_vol1_c12.h b/include/rdma/ibta_vol1_c12.h
index 52dbc80a0d1b..08378eb4d6df 100644
--- a/include/rdma/ibta_vol1_c12.h
+++ b/include/rdma/ibta_vol1_c12.h
@@ -96,4 +96,15 @@
 #define CM_MRA_PRIVATE_DATA CM_FIELD_MLOC(struct cm_mra_msg, 10, 1776)
 #define CM_MRA_PRIVATE_DATA_SIZE 222
 
+/* Table 108 REJ Message Contents */
+#define CM_REJ_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_rej_msg, 0, 32)
+#define CM_REJ_REMOTE_COMM_ID CM_FIELD32_LOC(struct cm_rej_msg, 4, 32)
+#define CM_REJ_MESSAGE_REJECTED CM_FIELD8_LOC(struct cm_rej_msg, 8, 2)
+#define CM_REJ_REJECTED_INFO_LENGTH CM_FIELD8_LOC(struct cm_rej_msg, 9, 7)
+#define CM_REJ_REASON CM_FIELD16_LOC(struct cm_rej_msg, 10, 16)
+#define CM_REJ_ARI CM_FIELD_MLOC(struct cm_rej_msg, 12, 576)
+#define CM_REJ_ARI_SIZE 72
+#define CM_REJ_PRIVATE_DATA CM_FIELD_MLOC(struct cm_rej_msg, 84, 1184)
+#define CM_REJ_PRIVATE_DATA_SIZE 148
+
 #endif /* _IBTA_VOL1_C12_H_ */
-- 
2.20.1

