Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E48E613C
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfJ0HG4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HG4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:06:56 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8E1C20578;
        Sun, 27 Oct 2019 07:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160015;
        bh=9eIOSNni1P/vlFGbNH0DO+NwcadPZu1MtaN45Gmb6OM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjp4t9tueZ07lDz6FOCNZcSXF2RMP7HRyYaWqLP0n/okfG18GAZtDuMaRaiPIKRhT
         Zsrlk8uzXg5kj1uG9HeCS1gWaTTCzJx9tsYLb+v1M/TDDrZJdnW59lYTcxaKn9q/+P
         dXkFhsKkwsMJxYkFwr0LNNhDJ8IIMjVacSzLwAGA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 09/43] RDMA/cm: Load Alternate Path (LAP) definitions
Date:   Sun, 27 Oct 2019 09:05:47 +0200
Message-Id: <20191027070621.11711-10-leon@kernel.org>
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

Add LAP message definitions as it is written in IBTA release 1.3 volume 1.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  4 ++--
 drivers/infiniband/core/cm_msgs.h | 37 ++++++++++++++++++++++++++++++-
 include/rdma/ib_cm.h              |  1 -
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 4858b6aaac7f..a735481d85f0 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3107,7 +3107,7 @@ int ib_send_cm_lap(struct ib_cm_id *cm_id,
 	unsigned long flags;
 	int ret;
 
-	if (private_data && private_data_len > IB_CM_LAP_PRIVATE_DATA_SIZE)
+	if (private_data && private_data_len > CM_LAP_PRIVATE_DATA_SIZE)
 		return -EINVAL;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
@@ -3221,7 +3221,7 @@ static int cm_lap_handler(struct cm_work *work)
 	param->alternate_path = &work->path[0];
 	cm_format_path_from_lap(cm_id_priv, param->alternate_path, lap_msg);
 	work->cm_event.private_data = &lap_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_LAP_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_LAP_PRIVATE_DATA_SIZE;
 
 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->id.state != IB_CM_ESTABLISHED)
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index a7ccd27a2f19..76a5053933e9 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -267,6 +267,41 @@
 #define CM_DREP_PRIVATE_DATA_OFFSET 8
 #define CM_DREP_PRIVATE_DATA_SIZE 224
 
+#define CM_LAP_LOCAL_COMM_ID_OFFSET 0
+#define CM_LAP_LOCAL_COMM_ID_MASK GENMASK(31, 0)
+#define CM_LAP_REMOTE_COMM_ID_OFFSET 4
+#define CM_LAP_REMOTE_COMM_ID_MASK GENMASK(31, 0)
+#define CM_LAP_REMOTE_QPN_EECN_OFFSET 12
+#define CM_LAP_REMOTE_QPN_EECN_MASK GENMASK(23, 0)
+#define CM_LAP_REMOTE_CM_RESPONSE_TIMEOUT_OFFSET 15
+#define CM_LAP_REMOTE_CM_RESPONSE_TIMEOUT_MASK GENMASK(4, 0)
+#define CM_LAP_ALTERNATE_LOCAL_PORT_LID_OFFSET 20
+#define CM_LAP_ALTERNATE_LOCAL_PORT_LID_MASK GENMASK(15, 0)
+#define CM_LAP_ALTERNATE_REMOTE_PORT_LID_OFFSET 22
+#define CM_LAP_ALTERNATE_REMOTE_PORT_LID_MASK GENMASK(15, 0)
+#define CM_LAP_ALTERNATE_LOCAL_PORT_GID_OFFSET 24
+#define CM_LAP_ALTERNATE_REMOTE_PORT_GID_OFFSET 40
+#define CM_LAP_ALTERNATE_FLOW_LABEL_OFFSET 56
+#define CM_LAP_ALTERNATE_FLOW_LABEL_MASK GENMASK(19, 0)
+
+#define CM_LAP_ALTERNATE_TRAFFIC_CLASS_OFFSET 59
+#define CM_LAP_ALTERNATE_TRAFFIC_CLASS_MASK GENMASK(7, 0)
+#define CM_LAP_ALTERNATE_HOP_LIMIT_OFFSET 60
+#define CM_LAP_ALTERNATE_HOP_LIMIT_MASK GENMASK(7, 0)
+#define CM_LAP_ALTERNATE_PACKET_RATE_OFFSET 61
+#define CM_LAP_ALTERNATE_PACKET_RATE_MASK GENMASK(7, 2)
+#define CM_LAP_ALTERNATE_SL_OFFSET 62
+#define CM_LAP_ALTERNATE_SL_MASK GENMASK(3, 0)
+
+#define CM_LAP_ALTERNATE_SUBNET_LOCAL_OFFSET 62
+#define CM_LAP_ALTERNATE_SUBNET_LOCAL_MASK GENMASK(4, 4)
+
+#define CM_LAP_ALTERNATE_LOCAL_ACK_TIMEOUT_OFFSET 63
+#define CM_LAP_ALTERNATE_LOCAL_ACK_TIMEOUT_MASK GENMASK(4, 0)
+
+#define CM_LAP_PRIVATE_DATA_OFFSET 64
+#define CM_LAP_PRIVATE_DATA_SIZE 168
+
 struct cm_req_msg {
 	struct ib_mad_hdr hdr;
 
@@ -897,7 +932,7 @@ struct cm_lap_msg {
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
-- 
2.20.1

