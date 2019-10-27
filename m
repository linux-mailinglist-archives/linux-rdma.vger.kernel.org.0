Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96C40E6138
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfJ0HGm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HGl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:06:41 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7104C20873;
        Sun, 27 Oct 2019 07:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160001;
        bh=ERlIZaA2ZdT005hfnlVkQBiaolPnHYAbefaBZFXfbYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UdT8p+PJ7ACmleasfqmBDs7/sdSSaPRttRAVYe0LOZaNqYf7jpH0eXjiAJjNVq2hM
         cJ2NsgqAK6k8VuDF6TmM4mkEVqq5y08ixv4L4mhygjlmKfSRx6kTpcyrk3o3KJSnYf
         jl0WYmnYN0uf94VCTZy+cvDpdWFPcpF0v3mmi7O8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 04/43] RDMA/cm: Reject (REJ) message definitions
Date:   Sun, 27 Oct 2019 09:05:42 +0200
Message-Id: <20191027070621.11711-5-leon@kernel.org>
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

Add Reject (REJ) definitions as it is written
in IBTA release 1.3 volume 1.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  6 +++---
 drivers/infiniband/core/cm_msgs.h | 19 +++++++++++++++++--
 drivers/infiniband/core/cma.c     |  2 +-
 include/rdma/ib_cm.h              |  2 --
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index c477629f5106..d8e28c15b9d8 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2713,8 +2713,8 @@ int ib_send_cm_rej(struct ib_cm_id *cm_id,
 	unsigned long flags;
 	int ret;
 
-	if ((private_data && private_data_len > IB_CM_REJ_PRIVATE_DATA_SIZE) ||
-	    (ari && ari_length > IB_CM_REJ_ARI_LENGTH))
+	if ((private_data && private_data_len > CM_REJ_PRIVATE_DATA_SIZE) ||
+	    (ari && ari_length > CM_REJ_ARI_SIZE))
 		return -EINVAL;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
@@ -2775,7 +2775,7 @@ static void cm_format_rej_event(struct cm_work *work)
 	param->ari_length = cm_rej_get_reject_info_len(rej_msg);
 	param->reason = __be16_to_cpu(rej_msg->reason);
 	work->cm_event.private_data = &rej_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_REJ_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_REJ_PRIVATE_DATA_SIZE;
 }
 
 static struct cm_id_private * cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 20784b0fa4af..448f9ba39564 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -197,6 +197,21 @@
 #define CM_MRA_PRIVATE_DATA_OFFSET 10
 #define CM_MRA_PRIVATE_DATA_SIZE 222
 
+#define CM_REJ_LOCAL_COMM_ID_OFFSET 0
+#define CM_REJ_LOCAL_COMM_ID_MASK GENMASK(31, 0)
+#define CM_REJ_REMOTE_COMM_ID_OFFSET 4
+#define CM_REJ_REMOTE_COMM_ID__MASK GENMASK(31, 0)
+#define CM_REJ_MESSAGE_REJECTED_OFFSET 8
+#define CM_REJ_MESSAGE_REJECTED_MASK GENMASK(1, 0)
+#define CM_REJ_REJECTED_INFO_LENGTH_OFFSET 9
+#define CM_REJ_REJECTED_INFO_LENGTH_MASK GENMASK(6, 0)
+#define CM_REJ_REASON_OFFSET 10
+#define CM_REJ_REASON_MASK GENMASK(15, 0)
+#define CM_REJ_ARI_OFFSET 12
+#define CM_REJ_ARI_SIZE 72
+#define CM_REJ_PRIVATE_DATA_OFFSET 84
+#define CM_REJ_PRIVATE_DATA_SIZE 148
+
 struct cm_req_msg {
 	struct ib_mad_hdr hdr;
 
@@ -610,9 +625,9 @@ struct cm_rej_msg {
 	/* reject info length:7, rsvd:1. */
 	u8 offset9;
 	__be16 reason;
-	u8 ari[IB_CM_REJ_ARI_LENGTH];
+	u8 ari[CM_REJ_ARI_SIZE];
 
-	u8 private_data[IB_CM_REJ_PRIVATE_DATA_SIZE];
+	u8 private_data[CM_REJ_PRIVATE_DATA_SIZE];
 
 } __packed;
 
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 8e98faf071cf..38909e4835d5 100644
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
-- 
2.20.1

