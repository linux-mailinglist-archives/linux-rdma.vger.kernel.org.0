Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9456F10593A
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKUSPM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:15:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUSPL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:15:11 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E866C206CB;
        Thu, 21 Nov 2019 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360110;
        bh=ChyQy0qHh6OLei+VapxDBfb7hdq0L4HelfN63CaWDew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sShVEvCNDMGGfOjEoWTubWcqfDjz2N/VqFeTL8Jk28HY/tvJGGTmEPxsX9FyJbjrs
         crB7iBcS6POkefQ5/Sp8H59b5AOVROBexMADzJFVCl/HIMJeAciDLy7dwM/l6gxB7i
         rDIWnU/FQsqAADW+m7VTLCehJQ+tBtxbuVsnMOOY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 33/48] RDMA/cm: Convert REQ local ack timeout
Date:   Thu, 21 Nov 2019 20:12:58 +0200
Message-Id: <20191121181313.129430-34-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121181313.129430-1-leon@kernel.org>
References: <20191121181313.129430-1-leon@kernel.org>
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
 drivers/infiniband/core/cm.c      | 18 +++++++++---------
 drivers/infiniband/core/cm_msgs.h | 24 ------------------------
 2 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 1a5d5d401c72..e25629a910f0 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1325,9 +1325,9 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	req_msg->primary_hop_limit = pri_path->hop_limit;
 	IBA_SET(CM_REQ_PRIMARY_SL, req_msg, pri_path->sl);
 	IBA_SET(CM_REQ_PRIMARY_SUBNET_LOCAL, req_msg, (pri_path->hop_limit <= 1));
-	cm_req_set_primary_local_ack_timeout(req_msg,
-		cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
-			       pri_path->packet_life_time));
+	IBA_SET(CM_REQ_PRIMARY_LOCAL_ACK_TIMEOUT, req_msg,
+	       cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
+			      pri_path->packet_life_time));
 
 	if (alt_path) {
 		bool alt_ext = false;
@@ -1360,10 +1360,10 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 		req_msg->alt_hop_limit = alt_path->hop_limit;
 		IBA_SET(CM_REQ_ALTERNATE_SL, req_msg, alt_path->sl);
 		IBA_SET(CM_REQ_ALTERNATE_SUBNET_LOCAL, req_msg,
-			(alt_path->hop_limit <= 1));
-		cm_req_set_alt_local_ack_timeout(req_msg,
-			cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
-				       alt_path->packet_life_time));
+		       (alt_path->hop_limit <= 1));
+		IBA_SET(CM_REQ_ALTERNATE_LOCAL_ACK_TIMEOUT, req_msg,
+		       cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
+				      alt_path->packet_life_time));
 	}
 
 	if (param->private_data && param->private_data_len)
@@ -1584,7 +1584,7 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 	primary_path->rate = IBA_GET(CM_REQ_PRIMARY_PACKET_RATE, req_msg);
 	primary_path->packet_life_time_selector = IB_SA_EQ;
 	primary_path->packet_life_time =
-		cm_req_get_primary_local_ack_timeout(req_msg);
+		IBA_GET(CM_REQ_PRIMARY_LOCAL_ACK_TIMEOUT, req_msg);
 	primary_path->packet_life_time -= (primary_path->packet_life_time > 0);
 	primary_path->service_id = req_msg->service_id;
 	if (sa_path_is_roce(primary_path))
@@ -1606,7 +1606,7 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 		alt_path->rate = IBA_GET(CM_REQ_ALTERNATE_PACKET_RATE, req_msg);
 		alt_path->packet_life_time_selector = IB_SA_EQ;
 		alt_path->packet_life_time =
-			cm_req_get_alt_local_ack_timeout(req_msg);
+			IBA_GET(CM_REQ_ALTERNATE_LOCAL_ACK_TIMEOUT, req_msg);
 		alt_path->packet_life_time -= (alt_path->packet_life_time > 0);
 		alt_path->service_id = req_msg->service_id;
 
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 3933c29b569b..6f52a8f0bee3 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -70,30 +70,6 @@ struct cm_req_msg {
 
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

