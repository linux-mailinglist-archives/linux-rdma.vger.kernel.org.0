Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C112E6155
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfJ0HIZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HIZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:08:25 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 081E721726;
        Sun, 27 Oct 2019 07:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160104;
        bh=mp1v7oNHMJeEgqB8hznytKyxcgIVIpgnQsYScAoc5D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXUxQe+s2zG+eX43nwolwONU9IVJDCAN4yMAnM8NO+7ZSyi/TxtNiXZsvK32MCtaP
         wgqj3UYGgAyp/JM+QYwks/xafIfqqC76SW5igCMD9dJCJ3zRzU4KOSMUdNz7b0WzeJ
         Ua3Ly0TlHaFfO6Vfc/2BKOVQInYllW6bkdWC1Dtk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 34/43] RDMA/cm: Convert REP target ack delay field
Date:   Sun, 27 Oct 2019 09:06:12 +0200
Message-Id: <20191027070621.11711-35-leon@kernel.org>
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

Convert REP target ack delay field.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  8 ++++----
 drivers/infiniband/core/cm_msgs.h | 12 ------------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index af32d1e68b11..596be796f7bc 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2067,8 +2067,8 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 	rep_msg->remote_comm_id = cm_id_priv->id.remote_id;
 	CM_SET(REP_STARTING_PSN, rep_msg, param->starting_psn);
 	rep_msg->resp_resources = param->responder_resources;
-	cm_rep_set_target_ack_delay(rep_msg,
-				    cm_id_priv->av.port->cm_dev->ack_delay);
+	CM_SET(REP_TARGET_ACK_DELAY, rep_msg,
+	       cm_id_priv->av.port->cm_dev->ack_delay);
 	cm_rep_set_failover(rep_msg, param->failover_accepted);
 	cm_rep_set_rnr_retry_count(rep_msg, param->rnr_retry_count);
 	rep_msg->local_ca_guid = cm_id_priv->id.device->node_guid;
@@ -2222,7 +2222,7 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param->starting_psn = CM_GET(REP_STARTING_PSN, rep_msg);
 	param->responder_resources = rep_msg->initiator_depth;
 	param->initiator_depth = rep_msg->resp_resources;
-	param->target_ack_delay = cm_rep_get_target_ack_delay(rep_msg);
+	param->target_ack_delay = CM_GET(REP_TARGET_ACK_DELAY, rep_msg);
 	param->failover_accepted = cm_rep_get_failover(rep_msg);
 	param->flow_control = cm_rep_get_flow_ctrl(rep_msg);
 	param->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
@@ -2368,7 +2368,7 @@ static int cm_rep_handler(struct cm_work *work)
 	cm_id_priv->responder_resources = rep_msg->initiator_depth;
 	cm_id_priv->sq_psn = CM_GET(REP_STARTING_PSN, rep_msg);
 	cm_id_priv->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
-	cm_id_priv->target_ack_delay = cm_rep_get_target_ack_delay(rep_msg);
+	cm_id_priv->target_ack_delay = CM_GET(REP_TARGET_ACK_DELAY, rep_msg);
 	cm_id_priv->av.timeout =
 			cm_ack_timeout(cm_id_priv->target_ack_delay,
 				       cm_id_priv->av.timeout - 1);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 6dc1a1086820..a3207f984c32 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -462,18 +462,6 @@ struct cm_rep_msg {
 
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

