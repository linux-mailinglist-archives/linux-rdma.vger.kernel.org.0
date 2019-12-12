Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0BE511C96B
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfLLJiz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:38:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:38834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728561AbfLLJiy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:38:54 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CCC722527;
        Thu, 12 Dec 2019 09:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143533;
        bh=Z7sAxmI/gCKYL9O+Sh07OeB9+39/2BkV0zdmdmFLjBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VY3h2ZS6syYvRieEEO8YP0EFijJe2efnBQ2i7Mt9n1LSUUfxGVhiBsoRve8ftgMpW
         TExivww+6STyOZPyYgLqVwoRHmRuPa/XwQjaVGftF+nnAcMT9XgovHRZT4li8+zFOm
         99uuBxWpZ85o87g7QJjUGY9RFjcf8OGKaMyXHdcs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 05/48] RDMA/cm: Request For Communication (REQ) message definitions
Date:   Thu, 12 Dec 2019 11:37:47 +0200
Message-Id: <20191212093830.316934-6-leon@kernel.org>
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

Add Request For Communication (REQ) message definitions as it is written
in IBTA release 1.3 volume 1.

There are three types of definitions:
1. Regular ones with offset and mask, they will be accessible
   by IBA_GET()/IBA_SET().
2. GIDs and private data will be accessible by IBA_GET_MEM()/IBA_SET_MEM().

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  4 +-
 drivers/infiniband/core/cm_msgs.h |  4 +-
 drivers/infiniband/core/cma.c     |  3 +-
 include/rdma/ib_cm.h              |  1 -
 include/rdma/ibta_vol1_c12.h      | 91 +++++++++++++++++++++++++++++++
 5 files changed, 97 insertions(+), 6 deletions(-)
 create mode 100644 include/rdma/ibta_vol1_c12.h

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index efa2d329da30..3c0cbdc748ac 100644
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
index 9bc468833831..9e50da044c43 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -8,7 +8,7 @@
 #ifndef CM_MSGS_H
 #define CM_MSGS_H
 
-#include <rdma/iba.h>
+#include <rdma/ibta_vol1_c12.h>
 #include <rdma/ib_mad.h>
 #include <rdma/ib_cm.h>
 
@@ -66,7 +66,7 @@ struct cm_req_msg {
 	/* local ACK timeout:5, rsvd:3 */
 	u8 alt_offset139;
 
-	u32 private_data[IB_CM_REQ_PRIVATE_DATA_SIZE / sizeof(u32)];
+	u32 private_data[CM_REQ_PRIVATE_DATA_SIZE / sizeof(u32)];
 
 } __packed;
 
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 25f2b70fd8ef..02490a3c11f3 100644
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
diff --git a/include/rdma/ibta_vol1_c12.h b/include/rdma/ibta_vol1_c12.h
new file mode 100644
index 000000000000..2db7f736379e
--- /dev/null
+++ b/include/rdma/ibta_vol1_c12.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright (c) 2019, Mellanox Technologies inc. All rights reserved.
+ *
+ * This file is IBTA volume 1, chapter 12 declarations:
+ * * CHAPTER 12: C OMMUNICATION MANAGEMENT
+ */
+#ifndef _IBTA_VOL1_C12_H_
+#define _IBTA_VOL1_C12_H_
+
+#include <rdma/iba.h>
+
+#define CM_FIELD_BLOC(field_struct, byte_offset, bits_offset, width)           \
+	IBA_FIELD_BLOC(field_struct,                                           \
+		       (byte_offset + sizeof(struct ib_mad_hdr)), bits_offset, \
+		       width)
+#define CM_FIELD8_LOC(field_struct, byte_offset, width)                        \
+	IBA_FIELD8_LOC(field_struct,                                           \
+		       (byte_offset + sizeof(struct ib_mad_hdr)), width)
+#define CM_FIELD16_LOC(field_struct, byte_offset, width)                       \
+	IBA_FIELD16_LOC(field_struct,                                          \
+			(byte_offset + sizeof(struct ib_mad_hdr)), width)
+#define CM_FIELD32_LOC(field_struct, byte_offset, width)                       \
+	IBA_FIELD32_LOC(field_struct,                                          \
+			(byte_offset + sizeof(struct ib_mad_hdr)), width)
+#define CM_FIELD64_LOC(field_struct, byte_offset, width)                       \
+	IBA_FIELD64_LOC(field_struct,                                          \
+			(byte_offset + sizeof(struct ib_mad_hdr)), width)
+#define CM_FIELD_MLOC(field_struct, byte_offset, width)                        \
+	IBA_FIELD_MLOC(field_struct,                                           \
+		       (byte_offset + sizeof(struct ib_mad_hdr)), width)
+
+/* Table 106 REQ Message Contents */
+#define CM_REQ_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_req_msg, 0, 32)
+#define CM_REQ_SERVICE_ID CM_FIELD64_LOC(struct cm_req_msg, 8, 64)
+#define CM_REQ_LOCAL_CA_GUID CM_FIELD64_LOC(struct cm_req_msg, 16, 64)
+#define CM_REQ_LOCAL_Q_KEY CM_FIELD32_LOC(struct cm_req_msg, 28, 32)
+#define CM_REQ_LOCAL_QPN CM_FIELD32_LOC(struct cm_req_msg, 32, 24)
+#define CM_REQ_RESPONDED_RESOURCES CM_FIELD8_LOC(struct cm_req_msg, 35, 8)
+#define CM_REQ_LOCAL_EECN CM_FIELD32_LOC(struct cm_req_msg, 36, 24)
+#define CM_REQ_INITIATOR_DEPTH CM_FIELD8_LOC(struct cm_req_msg, 39, 8)
+#define CM_REQ_REMOTE_EECN CM_FIELD32_LOC(struct cm_req_msg, 40, 24)
+#define CM_REQ_REMOTE_CM_RESPONSE_TIMEOUT                                      \
+	CM_FIELD8_LOC(struct cm_req_msg, 43, 5)
+#define CM_REQ_TRANSPORT_SERVICE_TYPE CM_FIELD_BLOC(struct cm_req_msg, 43, 5, 2)
+#define CM_REQ_END_TO_END_FLOW_CONTROL                                         \
+	CM_FIELD_BLOC(struct cm_req_msg, 43, 7, 1)
+#define CM_REQ_STARTING_PSN CM_FIELD32_LOC(struct cm_req_msg, 44, 24)
+#define CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT CM_FIELD8_LOC(struct cm_req_msg, 47, 5)
+#define CM_REQ_RETRY_COUNT CM_FIELD_BLOC(struct cm_req_msg, 47, 5, 3)
+#define CM_REQ_PARTITION_KEY CM_FIELD16_LOC(struct cm_req_msg, 48, 16)
+#define CM_REQ_PATH_PACKET_PAYLOAD_MTU CM_FIELD8_LOC(struct cm_req_msg, 50, 4)
+#define CM_REQ_RDC_EXISTS CM_FIELD_BLOC(struct cm_req_msg, 50, 4, 1)
+#define CM_REQ_RNR_RETRY_COUNT CM_FIELD_BLOC(struct cm_req_msg, 50, 5, 3)
+#define CM_REQ_MAX_CM_RETRIES CM_FIELD8_LOC(struct cm_req_msg, 51, 4)
+#define CM_REQ_SRQ CM_FIELD_BLOC(struct cm_req_msg, 51, 4, 1)
+#define CM_REQ_EXTENDED_TRANSPORT_TYPE                                         \
+	CM_FIELD_BLOC(struct cm_req_msg, 51, 5, 3)
+#define CM_REQ_PRIMARY_LOCAL_PORT_LID CM_FIELD16_LOC(struct cm_req_msg, 52, 16)
+#define CM_REQ_PRIMARY_REMOTE_PORT_LID CM_FIELD16_LOC(struct cm_req_msg, 54, 16)
+#define CM_REQ_PRIMARY_LOCAL_PORT_GID CM_FIELD_MLOC(struct cm_req_msg, 56, 128)
+#define CM_REQ_PRIMARY_REMOTE_PORT_GID CM_FIELD_MLOC(struct cm_req_msg, 72, 128)
+#define CM_REQ_PRIMARY_FLOW_LABEL CM_FIELD32_LOC(struct cm_req_msg, 88, 20)
+#define CM_REQ_PRIMARY_PACKET_RATE CM_FIELD_BLOC(struct cm_req_msg, 91, 2, 2)
+#define CM_REQ_PRIMARY_TRAFFIC_CLASS CM_FIELD8_LOC(struct cm_req_msg, 92, 8)
+#define CM_REQ_PRIMARY_HOP_LIMIT CM_FIELD8_LOC(struct cm_req_msg, 93, 8)
+#define CM_REQ_PRIMARY_SL CM_FIELD8_LOC(struct cm_req_msg, 94, 4)
+#define CM_REQ_PRIMARY_SUBNET_LOCAL CM_FIELD_BLOC(struct cm_req_msg, 94, 4, 1)
+#define CM_REQ_PRIMARY_LOCAL_ACK_TIMEOUT CM_FIELD8_LOC(struct cm_req_msg, 95, 5)
+#define CM_REQ_ALTERNATE_LOCAL_PORT_LID                                        \
+	CM_FIELD16_LOC(struct cm_req_msg, 96, 16)
+#define CM_REQ_ALTERNATE_REMOTE_PORT_LID                                       \
+	CM_FIELD16_LOC(struct cm_req_msg, 98, 16)
+#define CM_REQ_ALTERNATE_LOCAL_PORT_GID                                        \
+	CM_FIELD_MLOC(struct cm_req_msg, 100, 128)
+#define CM_REQ_ALTERNATE_REMOTE_PORT_GID                                       \
+	CM_FIELD_MLOC(struct cm_req_msg, 116, 128)
+#define CM_REQ_ALTERNATE_FLOW_LABEL CM_FIELD32_LOC(struct cm_req_msg, 132, 20)
+#define CM_REQ_ALTERNATE_PACKET_RATE CM_FIELD_BLOC(struct cm_req_msg, 135, 2, 6)
+#define CM_REQ_ALTERNATE_TRAFFIC_CLASS CM_FIELD8_LOC(struct cm_req_msg, 136, 8)
+#define CM_REQ_ALTERNATE_HOP_LIMIT CM_FIELD8_LOC(struct cm_req_msg, 137, 8)
+#define CM_REQ_ALTERNATE_SL CM_FIELD8_LOC(struct cm_req_msg, 138, 4)
+#define CM_REQ_ALTERNATE_SUBNET_LOCAL                                          \
+	CM_FIELD_BLOC(struct cm_req_msg, 138, 4, 1)
+#define CM_REQ_ALTERNATE_LOCAL_ACK_TIMEOUT                                     \
+	CM_FIELD8_LOC(struct cm_req_msg, 139, 5)
+#define CM_REQ_SAP_SUPPORTED CM_FIELD_BLOC(struct cm_req_msg, 139, 5, 1)
+#define CM_REQ_PRIVATE_DATA CM_FIELD_MLOC(struct cm_req_msg, 140, 736)
+#define CM_REQ_PRIVATE_DATA_SIZE 92
+
+#endif /* _IBTA_VOL1_C12_H_ */
-- 
2.20.1

