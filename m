Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17450E6136
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfJ0HGf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HGf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:06:35 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67FB020873;
        Sun, 27 Oct 2019 07:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572159994;
        bh=R/UPUule6CmZ4QfBhIm69oqoQ/nVXLLU69NsX1Oo3DU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8wsv/+WLxzfRDst2ARNCHzCVd/9zvQ+GzdZDtLOvPLwzzRn+WTDAb4kVEa/EEKAQ
         e2KHan04wJk3Br6MOjdMfDLIcV6oXv9W2/ecoXtNv2fyI73KY/h8MBya2SH/Eg91Eo
         SUWzaA3y9um0TFx42V8E1VbwfuVUfhRZBRDR1OG4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 02/43] RDMA/cm: Request For Communication (REQ) message definitions
Date:   Sun, 27 Oct 2019 09:05:40 +0200
Message-Id: <20191027070621.11711-3-leon@kernel.org>
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

Add Request For Communication (REQ) message definitions as it is written
in IBTA release 1.3 volume 1.

There are three types of definitions:
1. Regular ones with offset and mask, they will be accessible
   by CM_GET()/CM_SET().
2. GIDs with offset only, they will be accessible
   by CM_GET_GID()/CM_SET_GID().
3. Private data with offset and length in bytes.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  4 +-
 drivers/infiniband/core/cm_msgs.h | 99 ++++++++++++++++++++++++++++++-
 drivers/infiniband/core/cma.c     |  3 +-
 include/rdma/ib_cm.h              |  1 -
 4 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index ecd868954958..7163a5782bea 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1368,7 +1368,7 @@ static int cm_validate_req_param(struct ib_cm_req_param *param)
 		return -EINVAL;
 
 	if (param->private_data &&
-	    param->private_data_len > IB_CM_REQ_PRIVATE_DATA_SIZE)
+	    param->private_data_len > CM_REQ_PRIVATE_DATA_SIZE)
 		return -EINVAL;
 
 	if (param->alternate_path &&
@@ -1681,7 +1681,7 @@ static void cm_format_req_event(struct cm_work *work,
 	param->srq = cm_req_get_srq(req_msg);
 	param->ppath_sgid_attr = cm_id_priv->av.ah_attr.grh.sgid_attr;
 	work->cm_event.private_data = &req_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_REQ_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_REQ_PRIVATE_DATA_SIZE;
 }
 
 static void cm_process_work(struct cm_id_private *cm_id_priv,
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 99e35a4610f1..a9112af2b325 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -89,6 +89,103 @@
 		a | (b << 32);                                                 \
 	})
 
+#define CM_REQ_LOCAL_COMM_ID_OFFSET 0
+#define CM_REQ_LOCAL_COMM_ID_MASK GENMASK(31, 0)
+#define CM_REQ_SERVICE_ID_OFFSET 8
+#define CM_REQ_SERVICE_ID_MASK GENMASK_ULL(63, 0)
+#define CM_REQ_LOCAL_CA_GUID_OFFSET 16
+#define CM_REQ_LOCAL_CA_GUID_MASK GENMASK_ULL(63, 0)
+#define CM_REQ_LOCAL_Q_KEY_OFFSET 28
+#define CM_REQ_LOCAL_Q_KEY_MASK GENMASK(31, 0)
+#define CM_REQ_LOCAL_QPN_OFFSET 32
+#define CM_REQ_LOCAL_QPN_MASK GENMASK(23, 0)
+#define CM_REQ_RESPONDED_RESOURCES_OFFSET 35
+#define CM_REQ_RESPONDED_RESOURCES_MASK GENMASK(7, 0)
+#define CM_REQ_LOCAL_EECN_OFFSET 36
+#define CM_REQ_LOCAL_EECN_MASK GENMASK(24, 0)
+#define CM_REQ_INITIATOR_DEPTH_OFFSET 39
+#define CM_REQ_INITIATOR_DEPTH_MASK GENMASK(7, 0)
+#define CM_REQ_REMOTE_EECN_OFFSET 40
+#define CM_REQ_REMOTE_EECN_MASK GENMASK(23, 0)
+#define CM_REQ_REMOTE_CM_RESPONSE_TIMEOUT_OFFSET 43
+#define CM_REQ_REMOTE_CM_RESPONSE_TIMEOUT_MASK GENMASK(4, 0)
+#define CM_REQ_TRANSPORT_SERVICE_TYPE_OFFSET 43
+#define CM_REQ_TRANSPORT_SERVICE_TYPE_MASK GENMASK(6, 5)
+#define CM_REQ_END_TO_END_FLOW_CONTROL_OFFSET 43
+#define CM_REQ_END_TO_END_FLOW_CONTROL_MASK GENMASK(7, 7)
+#define CM_REQ_STARTING_PSN_OFFSET 44
+#define CM_REQ_STARTING_PSN_MASK GENMASK(23, 0)
+#define CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT_OFFSET 47
+#define CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT_MASK GENMASK(4, 0)
+#define CM_REQ_RETRY_COUNT_OFFSET 47
+#define CM_REQ_RETRY_COUNT_MASK GENMASK(7, 5)
+#define CM_REQ_PARTITION_KEY_OFFSET 48
+#define CM_REQ_PARTITION_KEY_MASK GENMASK(15, 0)
+#define CM_REQ_PATH_PACKET_PAYLOAD_MTU_OFFSET  50
+#define CM_REQ_PATH_PACKET_PAYLOAD_MTU_MASK GENMASK(3, 0)
+#define CM_REQ_RDC_EXISTS_OFFSET 50
+#define CM_REQ_RDC_EXISTS_MASK GENMASK(4, 4)
+#define CM_REQ_RNR_RETRY_COUNT_OFFSET 50
+#define CM_REQ_RNR_RETRY_COUNT_MASK GENMASK(7, 5)
+#define CM_REQ_MAX_CM_RETRIES_OFFSET 51
+#define CM_REQ_MAX_CM_RETRIES_MASK GENMASK(3, 0)
+#define CM_REQ_SRQ_OFFSET 51
+#define CM_REQ_SRQ_MASK GENMASK(4, 4)
+#define CM_REQ_EXTENDED_TRANSPORT_TYPE_OFFSET 51
+#define CM_REQ_EXTENDED_TRANSPORT_TYPE_MASK GENMASK(7, 5)
+
+#define CM_REQ_PRIMARY_LOCAL_PORT_LID_OFFSET 52
+#define CM_REQ_PRIMARY_LOCAL_PORT_LID_MASK GENMASK(15, 0)
+#define CM_REQ_PRIMARY_REMOTE_PORT_LID_OFFSET 54
+#define CM_REQ_PRIMARY_REMOTE_PORT_LID_MASK GENMASK(15, 0)
+
+#define CM_REQ_PRIMARY_LOCAL_PORT_GID_OFFSET 56
+#define CM_REQ_PRIMARY_REMOTE_PORT_GID_OFFSET 72
+
+#define CM_REQ_PRIMARY_FLOW_LABEL_OFFSET 88
+#define CM_REQ_PRIMARY_FLOW_LABEL_MASK GENMASK(19, 0)
+#define CM_REQ_PRIMARY_PACKET_RATE_OFFSET 91
+#define CM_REQ_PRIMARY_PACKET_RATE_MASK GENMASK(3, 2)
+#define CM_REQ_PRIMARY_TRAFFIC_CLASS_OFFSET 92
+#define CM_REQ_PRIMARY_TRAFFIC_CLASS_MASK GENMASK(7, 0)
+#define CM_REQ_PRIMARY_HOP_LIMIT_OFFSET 93
+#define CM_REQ_PRIMARY_HOP_LIMIT_MASK GENMASK(7, 0)
+#define CM_REQ_PRIMARY_SL_OFFSET 94
+#define CM_REQ_PRIMARY_SL_MASK GENMASK(3, 0)
+#define CM_REQ_PRIMARY_SUBNET_LOCAL_OFFSET 94
+#define CM_REQ_PRIMARY_SUBNET_LOCAL_MASK GENMASK(4, 4)
+#define CM_REQ_PRIMARY_LOCAL_ACK_TIMEOUT_OFFSET 95
+#define CM_REQ_PRIMARY_LOCAL_ACK_TIMEOUT_MASK GENMASK(4, 0)
+
+#define CM_REQ_ALTERNATE_LOCAL_PORT_LID_OFFSET 96
+#define CM_REQ_ALTERNATE_LOCAL_PORT_LID_MASK GENMASK(15, 0)
+#define CM_REQ_ALTERNATE_REMOTE_PORT_LID_OFFSET 98
+#define CM_REQ_ALTERNATE_REMOTE_PORT_LID_MASK GENMASK(15, 0)
+
+#define CM_REQ_ALTERNATE_LOCAL_PORT_GID_OFFSET 100
+#define CM_REQ_ALTERNATE_REMOTE_PORT_GID_OFFSET 116
+
+#define CM_REQ_ALTERNATE_FLOW_LABEL_OFFSET 132
+#define CM_REQ_ALTERNATE_FLOW_LABEL_MASK GENMASK(19, 0)
+#define CM_REQ_ALTERNATE_PACKET_RATE_OFFSET 135
+#define CM_REQ_ALTERNATE_PACKET_RATE_MASK GENMASK(7, 2)
+#define CM_REQ_ALTERNATE_TRAFFIC_CLASS_OFFSET 136
+#define CM_REQ_ALTERNATE_TRAFFIC_CLASS_MASK GENMASK(7, 0)
+#define CM_REQ_ALTERNATE_HOP_LIMIT_OFFSET 137
+#define CM_REQ_ALTERNATE_HOP_LIMIT_MASK GENMASK(7, 0)
+#define CM_REQ_ALTERNATE_SL_OFFSET 138
+#define CM_REQ_ALTERNATE_SL_MASK GENMASK(3, 0)
+#define CM_REQ_ALTERNATE_SUBNET_LOCAL_OFFSET 138
+#define CM_REQ_ALTERNATE_SUBNET_LOCAL_MASK GENMASK(4, 4)
+#define CM_REQ_ALTERNATE_LOCAL_ACK_TIMEOUT_OFFSET 139
+#define CM_REQ_ALTERNATE_LOCAL_ACK_TIMEOUT_MASK GENMASK(4, 0)
+
+#define CM_REQ_SAP_SUPPORTED_OFFSET 139
+#define CM_REQ_SAP_SUPPORTED_MASK GENMASK(5, 5)
+
+#define CM_REQ_PRIVATE_DATA_OFFSET 140
+#define CM_REQ_PRIVATE_DATA_SIZE 92
+
 struct cm_req_msg {
 	struct ib_mad_hdr hdr;
 
@@ -141,7 +238,7 @@ struct cm_req_msg {
 	/* local ACK timeout:5, rsvd:3 */
 	u8 alt_offset139;
 
-	u32 private_data[IB_CM_REQ_PRIVATE_DATA_SIZE / sizeof(u32)];
+	u32 private_data[CM_REQ_PRIVATE_DATA_SIZE / sizeof(u32)];
 
 } __packed;
 
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 8f318928f29d..8e98faf071cf 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -36,6 +36,7 @@
 
 #include "core_priv.h"
 #include "cma_priv.h"
+#include "cm_msgs.h"
 
 MODULE_AUTHOR("Sean Hefty");
 MODULE_DESCRIPTION("Generic RDMA CM Agent");
@@ -2085,7 +2086,7 @@ static void cma_set_req_event_data(struct rdma_cm_event *event,
 				   void *private_data, int offset)
 {
 	event->param.conn.private_data = private_data + offset;
-	event->param.conn.private_data_len = IB_CM_REQ_PRIVATE_DATA_SIZE - offset;
+	event->param.conn.private_data_len = CM_REQ_PRIVATE_DATA_SIZE - offset;
 	event->param.conn.responder_resources = req_data->responder_resources;
 	event->param.conn.initiator_depth = req_data->initiator_depth;
 	event->param.conn.flow_control = req_data->flow_control;
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index b476e0e27ec9..956256b2fc5d 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -65,7 +65,6 @@ enum ib_cm_event_type {
 };
 
 enum ib_cm_data_size {
-	IB_CM_REQ_PRIVATE_DATA_SIZE	 = 92,
 	IB_CM_MRA_PRIVATE_DATA_SIZE	 = 222,
 	IB_CM_REJ_PRIVATE_DATA_SIZE	 = 148,
 	IB_CM_REP_PRIVATE_DATA_SIZE	 = 196,
-- 
2.20.1

