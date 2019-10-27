Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E587E6156
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfJ0HI3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HI3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:08:29 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9542020578;
        Sun, 27 Oct 2019 07:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160108;
        bh=zEQvgpV9v7lFW94dh6By3t1e5tB0pOxxzq9iCTv3ORQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q2IPmobsbdLI4pIeO6WfIz+Na6bIjlla/CnmXI+M1R7yWngBhH9avAEsS9e1HVlzq
         ynMYeimInBKlOZmvHBsJhMzywutRE+E6wRTNYS02EGRLMNlEhANbyMhsvrJHRCn0Rq
         +iLc639MKbW1Kem+spC/lP2H4TBOBfQNoRNjx9xo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 30/43] RDMA/cm: Convert REQ local ack timeout
Date:   Sun, 27 Oct 2019 09:06:08 +0200
Message-Id: <20191027070621.11711-31-leon@kernel.org>
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

Convert REQ local ack timeout fields.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 16 ++++++++--------
 drivers/infiniband/core/cm_msgs.h | 24 ------------------------
 2 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 36abe43ad8a6..cb4b16a47e00 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1325,9 +1325,9 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	req_msg->primary_hop_limit = pri_path->hop_limit;
 	CM_SET(REQ_PRIMARY_SL, req_msg, pri_path->sl);
 	CM_SET(REQ_PRIMARY_SUBNET_LOCAL, req_msg, (pri_path->hop_limit <= 1));
-	cm_req_set_primary_local_ack_timeout(req_msg,
-		cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
-			       pri_path->packet_life_time));
+	CM_SET(REQ_PRIMARY_LOCAL_ACK_TIMEOUT, req_msg,
+	       cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
+			      pri_path->packet_life_time));
 
 	if (alt_path) {
 		bool alt_ext = false;
@@ -1361,9 +1361,9 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 		CM_SET(REQ_ALTERNATE_SL, req_msg, alt_path->sl);
 		CM_SET(REQ_ALTERNATE_SUBNET_LOCAL, req_msg,
 		       (alt_path->hop_limit <= 1));
-		cm_req_set_alt_local_ack_timeout(req_msg,
-			cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
-				       alt_path->packet_life_time));
+		CM_SET(REQ_ALTERNATE_LOCAL_ACK_TIMEOUT, req_msg,
+		       cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
+				      alt_path->packet_life_time));
 	}
 
 	if (param->private_data && param->private_data_len)
@@ -1584,7 +1584,7 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 	primary_path->rate = CM_GET(REQ_PRIMARY_PACKET_RATE, req_msg);
 	primary_path->packet_life_time_selector = IB_SA_EQ;
 	primary_path->packet_life_time =
-		cm_req_get_primary_local_ack_timeout(req_msg);
+		CM_GET(REQ_PRIMARY_LOCAL_ACK_TIMEOUT, req_msg);
 	primary_path->packet_life_time -= (primary_path->packet_life_time > 0);
 	primary_path->service_id = req_msg->service_id;
 	if (sa_path_is_roce(primary_path))
@@ -1606,7 +1606,7 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 		alt_path->rate = CM_GET(REQ_ALTERNATE_PACKET_RATE, req_msg);
 		alt_path->packet_life_time_selector = IB_SA_EQ;
 		alt_path->packet_life_time =
-			cm_req_get_alt_local_ack_timeout(req_msg);
+			CM_GET(REQ_ALTERNATE_LOCAL_ACK_TIMEOUT, req_msg);
 		alt_path->packet_life_time -= (alt_path->packet_life_time > 0);
 		alt_path->service_id = req_msg->service_id;
 
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 0faa48a51d7b..8a7c0a910618 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -400,30 +400,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline u8 cm_req_get_primary_local_ack_timeout(struct cm_req_msg *req_msg)
-{
-	return (u8) (req_msg->primary_offset95 >> 3);
-}
-
-static inline void cm_req_set_primary_local_ack_timeout(struct cm_req_msg *req_msg,
-							u8 local_ack_timeout)
-{
-	req_msg->primary_offset95 = (u8) ((req_msg->primary_offset95 & 0x07) |
-					  (local_ack_timeout << 3));
-}
-
-static inline u8 cm_req_get_alt_local_ack_timeout(struct cm_req_msg *req_msg)
-{
-	return (u8) (req_msg->alt_offset139 >> 3);
-}
-
-static inline void cm_req_set_alt_local_ack_timeout(struct cm_req_msg *req_msg,
-						    u8 local_ack_timeout)
-{
-	req_msg->alt_offset139 = (u8) ((req_msg->alt_offset139 & 0x07) |
-				       (local_ack_timeout << 3));
-}
-
 /* Message REJected or MRAed */
 enum cm_msg_response {
 	CM_MSG_RESPONSE_REQ = 0x0,
-- 
2.20.1

