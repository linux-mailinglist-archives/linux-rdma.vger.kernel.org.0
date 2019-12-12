Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2973411C991
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfLLJkg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:40:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbfLLJkf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:40:35 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57C9E22527;
        Thu, 12 Dec 2019 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143634;
        bh=q0/YF26BON0iMMz4vVwdz2zwBXq9pn+iJkbp2AqNCaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s9PEZgQEKAfeMICRjBaalbqq5wDhDpzV9S62qFbbxaS/Sm4bhaof2+TfpMPbGlbdl
         z5JUn5kQzCDlhOzQG1e8iX4kYRIAbOAyamyt5xFEaLrzxxEVjw+0JfZB0AelCiGTA/
         xnqRGmQ7AhnYKOu4AjIV99DOmyVHHbu39LjuLPSs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 37/48] RDMA/cm: Convert REP target ack delay field
Date:   Thu, 12 Dec 2019 11:38:19 +0200
Message-Id: <20191212093830.316934-38-leon@kernel.org>
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

Convert REP target ack delay field.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  8 ++++----
 drivers/infiniband/core/cm_msgs.h | 12 ------------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index b69611c088b8..ca2d50a3c7da 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2067,8 +2067,8 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 	rep_msg->remote_comm_id = cm_id_priv->id.remote_id;
 	IBA_SET(CM_REP_STARTING_PSN, rep_msg, param->starting_psn);
 	rep_msg->resp_resources = param->responder_resources;
-	cm_rep_set_target_ack_delay(rep_msg,
-				    cm_id_priv->av.port->cm_dev->ack_delay);
+	IBA_SET(CM_REP_TARGET_ACK_DELAY, rep_msg,
+	       cm_id_priv->av.port->cm_dev->ack_delay);
 	cm_rep_set_failover(rep_msg, param->failover_accepted);
 	cm_rep_set_rnr_retry_count(rep_msg, param->rnr_retry_count);
 	rep_msg->local_ca_guid = cm_id_priv->id.device->node_guid;
@@ -2225,7 +2225,7 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param->starting_psn = IBA_GET(CM_REP_STARTING_PSN, rep_msg);
 	param->responder_resources = rep_msg->initiator_depth;
 	param->initiator_depth = rep_msg->resp_resources;
-	param->target_ack_delay = cm_rep_get_target_ack_delay(rep_msg);
+	param->target_ack_delay = IBA_GET(CM_REP_TARGET_ACK_DELAY, rep_msg);
 	param->failover_accepted = cm_rep_get_failover(rep_msg);
 	param->flow_control = cm_rep_get_flow_ctrl(rep_msg);
 	param->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
@@ -2371,7 +2371,7 @@ static int cm_rep_handler(struct cm_work *work)
 	cm_id_priv->responder_resources = rep_msg->initiator_depth;
 	cm_id_priv->sq_psn = IBA_GET(CM_REP_STARTING_PSN, rep_msg);
 	cm_id_priv->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
-	cm_id_priv->target_ack_delay = cm_rep_get_target_ack_delay(rep_msg);
+	cm_id_priv->target_ack_delay = IBA_GET(CM_REP_TARGET_ACK_DELAY, rep_msg);
 	cm_id_priv->av.timeout =
 			cm_ack_timeout(cm_id_priv->target_ack_delay,
 				       cm_id_priv->av.timeout - 1);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 5a76b63dde12..0536f827fd8e 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -132,18 +132,6 @@ struct cm_rep_msg {
 
 } __packed;
 
-static inline u8 cm_rep_get_target_ack_delay(struct cm_rep_msg *rep_msg)
-{
-	return (u8) (rep_msg->offset26 >> 3);
-}
-
-static inline void cm_rep_set_target_ack_delay(struct cm_rep_msg *rep_msg,
-					       u8 target_ack_delay)
-{
-	rep_msg->offset26 = (u8) ((rep_msg->offset26 & 0x07) |
-				  (target_ack_delay << 3));
-}
-
 static inline u8 cm_rep_get_failover(struct cm_rep_msg *rep_msg)
 {
 	return (u8) ((rep_msg->offset26 & 0x06) >> 1);
-- 
2.20.1

