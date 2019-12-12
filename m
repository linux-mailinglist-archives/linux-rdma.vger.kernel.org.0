Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F6211C983
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfLLJjm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:39:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728382AbfLLJjm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:39:42 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 678F52173E;
        Thu, 12 Dec 2019 09:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143581;
        bh=BPx8jFeAKUihtwyKy0g2DjA1gKd2s7GmWiPF8SrJrnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xHz8j6o104fBmRQm2f7l4PUaJ1MLcFRmZcuy2flm0leeHzaSz5Rh6VEXttL2hRKDe
         dzWy2blLnfi40bT0fznShbbTG1ypY6I0xStZhYUVD1u114+T2wESvKj8w7flq6smDj
         kOFXPyOxtP2XfCR2ib7ras94efLUreDYXO7+iMA8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 15/48] RDMA/cm: Service ID Resolution Response (SIDR_REP) definitions
Date:   Thu, 12 Dec 2019 11:37:57 +0200
Message-Id: <20191212093830.316934-16-leon@kernel.org>
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

Add SIDR_REP message definitions as it is written
in IBTA release 1.3 volume 1.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  7 ++++---
 drivers/infiniband/core/cm_msgs.h |  4 ++--
 drivers/infiniband/core/cma.c     |  2 +-
 include/rdma/ib_cm.h              |  5 -----
 include/rdma/ibta_vol1_c12.h      | 14 ++++++++++++++
 5 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index db17421beeff..fd79605c9e8b 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3621,9 +3621,10 @@ int ib_send_cm_sidr_rep(struct ib_cm_id *cm_id,
 	unsigned long flags;
 	int ret;
 
-	if ((param->info && param->info_length > IB_CM_SIDR_REP_INFO_LENGTH) ||
+	if ((param->info &&
+	     param->info_length > CM_SIDR_REP_ADDITIONAL_INFORMATION_SIZE) ||
 	    (param->private_data &&
-	     param->private_data_len > IB_CM_SIDR_REP_PRIVATE_DATA_SIZE))
+	     param->private_data_len > CM_SIDR_REP_PRIVATE_DATA_SIZE))
 		return -EINVAL;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
@@ -3677,7 +3678,7 @@ static void cm_format_sidr_rep_event(struct cm_work *work,
 	param->info_len = sidr_rep_msg->info_length;
 	param->sgid_attr = cm_id_priv->av.ah_attr.grh.sgid_attr;
 	work->cm_event.private_data = &sidr_rep_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_SIDR_REP_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_SIDR_REP_PRIVATE_DATA_SIZE;
 }
 
 static int cm_sidr_rep_handler(struct cm_work *work)
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 47f7ce1ac143..ed887be775e3 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -778,9 +778,9 @@ struct cm_sidr_rep_msg {
 	__be32 offset8;
 	__be64 service_id;
 	__be32 qkey;
-	u8 info[IB_CM_SIDR_REP_INFO_LENGTH];
+	u8 info[CM_SIDR_REP_ADDITIONAL_INFORMATION_SIZE];
 
-	u8 private_data[IB_CM_SIDR_REP_PRIVATE_DATA_SIZE];
+	u8 private_data[CM_SIDR_REP_PRIVATE_DATA_SIZE];
 } __packed;
 
 static inline __be32 cm_sidr_rep_get_qpn(struct cm_sidr_rep_msg *sidr_rep_msg)
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index aeb528b2aa49..6c8beabc3363 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3706,7 +3706,7 @@ static int cma_sidr_rep_handler(struct ib_cm_id *cm_id,
 		break;
 	case IB_CM_SIDR_REP_RECEIVED:
 		event.param.ud.private_data = ib_event->private_data;
-		event.param.ud.private_data_len = IB_CM_SIDR_REP_PRIVATE_DATA_SIZE;
+		event.param.ud.private_data_len = CM_SIDR_REP_PRIVATE_DATA_SIZE;
 		if (rep->status != IB_SIDR_SUCCESS) {
 			event.event = RDMA_CM_EVENT_UNREACHABLE;
 			event.status = ib_event->param.sidr_rep_rcvd.status;
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index 8f0c377ad250..6237c369dbd6 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -64,11 +64,6 @@ enum ib_cm_event_type {
 	IB_CM_SIDR_REP_RECEIVED
 };
 
-enum ib_cm_data_size {
-	IB_CM_SIDR_REP_PRIVATE_DATA_SIZE = 136,
-	IB_CM_SIDR_REP_INFO_LENGTH	 = 72,
-};
-
 struct ib_cm_id;
 
 struct ib_cm_req_event_param {
diff --git a/include/rdma/ibta_vol1_c12.h b/include/rdma/ibta_vol1_c12.h
index 36aa3ab25b42..f937865fe6b5 100644
--- a/include/rdma/ibta_vol1_c12.h
+++ b/include/rdma/ibta_vol1_c12.h
@@ -189,4 +189,18 @@
 #define CM_SIDR_REQ_PRIVATE_DATA CM_FIELD_MLOC(struct cm_sidr_req_msg, 16, 1728)
 #define CM_SIDR_REQ_PRIVATE_DATA_SIZE 216
 
+/* Table 120 SIDR_REP Message Contents */
+#define CM_SIDR_REP_REQUESTID CM_FIELD32_LOC(struct cm_sidr_rep_msg, 0, 32)
+#define CM_SIDR_REP_STATUS CM_FIELD8_LOC(struct cm_sidr_rep_msg, 4, 8)
+#define CM_SIDR_REP_ADDITIONAL_INFORMATION_LENGTH                              \
+	CM_FIELD8_LOC(struct cm_sidr_rep_msg, 5, 8)
+#define CM_SIDR_REP_QPN CM_FIELD32_LOC(struct cm_sidr_rep_msg, 8, 24)
+#define CM_SIDR_REP_SERVICEID CM_FIELD64_LOC(struct cm_sidr_rep_msg, 12, 64)
+#define CM_SIDR_REP_Q_KEY CM_FIELD32_LOC(struct cm_sidr_rep_msg, 20, 32)
+#define CM_SIDR_REP_ADDITIONAL_INFORMATION                                     \
+	CM_FIELD_MLOC(struct cm_sidr_rep_msg, 24, 576)
+#define CM_SIDR_REP_ADDITIONAL_INFORMATION_SIZE 72
+#define CM_SIDR_REP_PRIVATE_DATA CM_FIELD_MLOC(struct cm_sidr_rep_msg, 96, 1088)
+#define CM_SIDR_REP_PRIVATE_DATA_SIZE 136
+
 #endif /* _IBTA_VOL1_C12_H_ */
-- 
2.20.1

