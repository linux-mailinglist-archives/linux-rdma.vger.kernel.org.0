Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F1E10591B
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKUSNk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:13:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUSNk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:13:40 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A006A2068E;
        Thu, 21 Nov 2019 18:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360019;
        bh=8RJm8u3Cssnd6mwlVXD96s1eaomKa/ReoD5ePuIROKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f7mID57XO9QhV3D7szZKcToBgCFivHNyLnT5bGOuwCXXrZeSrZwv0u5V2D/FNAObN
         QbRvl5KBgBIrQ0FhqjXBYMMZSSqRbWWASrUYfeb7kOrIiIFrNI6+HrRo0e1Tq2GFgb
         zNldU++7GlygZtpRWtKCQvEQrYcdPzZzX4wXqswQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 07/48] RDMA/cm: Reject (REJ) message definitions
Date:   Thu, 21 Nov 2019 20:12:32 +0200
Message-Id: <20191121181313.129430-8-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121181313.129430-1-leon@kernel.org>
References: <20191121181313.129430-1-leon@kernel.org>
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
index a9389957d375..abd5b4d3b2ba 100644
--- a/include/rdma/ibta_vol1_c12.h
+++ b/include/rdma/ibta_vol1_c12.h
@@ -93,4 +93,15 @@
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

