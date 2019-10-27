Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 002E5E6139
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfJ0HGq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HGq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:06:46 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0784A20578;
        Sun, 27 Oct 2019 07:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160004;
        bh=1CPFkJvyF/ZhPrvKl1hyujPuVKV+rS7AkUlNbANZne4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=giSn8BFGSaoznyQgajvJFsOoHBLNuiJxgD1xI0fmBVNHG49sGrI85GAyVW+aWj0D9
         7tO8Yw7+FEuUDZYJampdANCBXerbrEFulBsbtV6yRzPgohyHTiIUErU0jV4BAgKw4R
         TW6Fp8w9pSMAXxJvuBwBR77Pn2/ceH3Ye366l8as=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 05/43] RDMA/cm: Reply To Request for communication (REP) definitions
Date:   Sun, 27 Oct 2019 09:05:43 +0200
Message-Id: <20191027070621.11711-6-leon@kernel.org>
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

Add REP message definitions as it is written
in IBTA release 1.3 volume 1.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  4 ++--
 drivers/infiniband/core/cm_msgs.h | 34 ++++++++++++++++++++++++++++++-
 drivers/infiniband/core/cma.c     |  2 +-
 include/rdma/ib_cm.h              |  1 -
 4 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index d8e28c15b9d8..85836f8e5c67 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2068,7 +2068,7 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
 	int ret;
 
 	if (param->private_data &&
-	    param->private_data_len > IB_CM_REP_PRIVATE_DATA_SIZE)
+	    param->private_data_len > CM_REP_PRIVATE_DATA_SIZE)
 		return -EINVAL;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
@@ -2194,7 +2194,7 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
 	param->srq = cm_rep_get_srq(rep_msg);
 	work->cm_event.private_data = &rep_msg->private_data;
-	work->cm_event.private_data_len = IB_CM_REP_PRIVATE_DATA_SIZE;
+	work->cm_event.private_data_len = CM_REP_PRIVATE_DATA_SIZE;
 }
 
 static void cm_dup_rep_handler(struct cm_work *work)
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 448f9ba39564..39fcd1231378 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -212,6 +212,38 @@
 #define CM_REJ_PRIVATE_DATA_OFFSET 84
 #define CM_REJ_PRIVATE_DATA_SIZE 148
 
+#define CM_REP_LOCAL_COMM_ID_OFFSET 0
+#define CM_REP_LOCAL_COMM_ID_MASK GENMASK(31, 0)
+#define CM_REP_REMOTE_COMM_ID_OFFSET 4
+#define CM_REP_REMOTE_COMM_ID_MASK GENMASK(31, 0)
+#define CM_REP_LOCAL_Q_KEY_OFFSET 8
+#define CM_REP_LOCAL_Q_KEY_MASK GENMASK(31, 0)
+#define CM_REP_LOCAL_QPN_OFFSET 12
+#define CM_REP_LOCAL_QPN_MASK GENMASK(23, 0)
+#define CM_REP_LOCAL_EE_CONTEXT_NUMBER_OFFSET 16
+#define CM_REP_LOCAL_EE_CONTEXT_NUMBER_MASK GENMASK(23, 0)
+#define CM_REP_STARTING_PSN_OFFSET 20
+#define CM_REP_STARTING_PSN_MASK GENMASK(23, 0)
+#define CM_REP_RESPONDER_RESOURCES_OFFSET 24
+#define CM_REP_RESPONDED_RESOURCES_MASK GENMASK(7, 0)
+#define CM_REP_INITIATOR_DEPTH_OFFSET 25
+#define CM_REP_INITIATOR_DEPTH_MASK GENMASK(7, 0)
+#define CM_REP_TARGET_ACK_DELAY_OFFSET 26
+#define CM_REP_TARGET_ACK_DELAY_MASK GENMASK(4, 0)
+
+#define CM_REP_FAILOVER_ACCEPTED_OFFSET 26
+#define CM_REP_FAILOVER_ACCEPTED_MASK GENMASK(6, 5)
+#define CM_REP_END_TO_END_FLOW_CONTROL_OFFSET 26
+#define CM_REP_END_TO_END_FLOW_CONTROL_MASK GENMASK(7, 7)
+#define CM_REP_RNR_RETRY_COUNT_OFFSET 27
+#define CM_REP_RNR_RETRY_COUNT_MASK GENMASK(2, 0)
+#define CM_REP_SRQ_OFFSET 27
+#define CM_REP_SRQ_MASK GENMASK(3, 3)
+#define CM_REP_LOCAL_CA_GUID_OFFSET 28
+#define CM_REP_LOCAL_CA_GUID_MASK GENMASK_ULL(63, 0)
+#define CM_REP_PRIVATE_DATA_OFFSET 36
+#define CM_REP_PRIVATE_DATA_SIZE 196
+
 struct cm_req_msg {
 	struct ib_mad_hdr hdr;
 
@@ -672,7 +704,7 @@ struct cm_rep_msg {
 	u8 offset27;
 	__be64 local_ca_guid;
 
-	u8 private_data[IB_CM_REP_PRIVATE_DATA_SIZE];
+	u8 private_data[CM_REP_PRIVATE_DATA_SIZE];
 
 } __packed;
 
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 38909e4835d5..997f8c29e34e 100644
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
-- 
2.20.1

