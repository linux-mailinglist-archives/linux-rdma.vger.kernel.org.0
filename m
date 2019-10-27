Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37F6FE6145
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfJ0HH2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HH2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:07:28 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA7CD21726;
        Sun, 27 Oct 2019 07:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160047;
        bh=TzjXQ/LxJHq0eBVRdW3pycf3G2gPkomNfyaJCWfcyBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWxzAyq7SN2dHjjNhj6gppifaNmvW/X6tRq5/yVuyWgu/SAS6pLgzkahdUdZbbf/5
         b2qJDoyWYpfHMbZf2rhs27ju3eK7sEWfCiUhWFGYj0K8UzWqYJbFctJX8d5QBAUfkQ
         SpTj/pG17Ul+iVlABf3/ZNSVs2mn5lc8p7FwV4Fo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 12/43] RDMA/cm: Service ID Resolution Response (SIDR_REP) definitions
Date:   Sun, 27 Oct 2019 09:05:50 +0200
Message-Id: <20191027070621.11711-13-leon@kernel.org>
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

Add SIDR_REP message definitions as it is written
in IBTA release 1.3 volume 1.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  7 ++++---
 drivers/infiniband/core/cm_msgs.h | 21 +++++++++++++++++++--
 drivers/infiniband/core/cma.c     |  2 +-
 include/rdma/ib_cm.h              |  5 -----
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 55a14acaa333..d07a5f141720 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3618,9 +3618,10 @@ int ib_send_cm_sidr_rep(struct ib_cm_id *cm_id,
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
@@ -3674,7 +3675,7 @@ static void cm_format_sidr_rep_event(struct cm_work *work,
 	param->info_len = sidr_rep_msg->info_length;
 	param->sgid_attr = cm_id_priv->av.ah_attr.grh.sgid_attr;
 	work->cm_event.private_data = &sidr_rep_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_SIDR_REP_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_SIDR_REP_PRIVATE_DATA_SIZE;
 }
 
 static int cm_sidr_rep_handler(struct cm_work *work)
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 9d32b84bdcb0..08b337551775 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -327,6 +327,23 @@
 #define CM_SIDR_REQ_PRIVATE_DATA_OFFSET 16
 #define CM_SIDR_REQ_PRIVATE_DATA_SIZE 216
 
+#define CM_SIDR_REP_REQUESTID_OFFSET 0
+#define CM_SIDR_REP_REQUESTID_MASK GENMASK(31, 0)
+#define CM_SIDR_REP_STATUS_OFFSET 4
+#define CM_SIDR_REP_STATUS_MASK GENMASK(7, 0)
+#define CM_SIDR_REP_ADDITIONAL_INFORMATION_LENGTH_OFFSET 5
+#define CM_SIDR_REP_ADDITIONAL_INFORMATION_LENGTH_MASK GENMASK(7, 0)
+#define CM_SIDR_REP_QPN_OFFSET 8
+#define CM_SIDR_REP_QPN_MASK GENMASK(23, 0)
+#define CM_SIDR_REP_SERVICEID_OFFSET 12
+#define CM_SIDR_REP_SERVICEID_MASK GENMASK_ULL(63, 0)
+#define CM_SIDR_REP_Q_KEY_OFFSET 20
+#define CM_SIDR_REP_Q_KEY_MASK GENMASK(31, 0)
+#define CM_SIDR_REP_ADDITIONAL_INFORMATION_OFFSET 24
+#define CM_SIDR_REP_ADDITIONAL_INFORMATION_SIZE 72
+#define CM_SIDR_REP_PRIVATE_DATA_OFFSET 96
+#define CM_SIDR_REP_PRIVATE_DATA_SIZE 136
+
 struct cm_req_msg {
 	struct ib_mad_hdr hdr;
 
@@ -1091,9 +1108,9 @@ struct cm_sidr_rep_msg {
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
index d3bbca5b61e3..4a54cf561a95 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3694,7 +3694,7 @@ static int cma_sidr_rep_handler(struct ib_cm_id *cm_id,
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
-- 
2.20.1

