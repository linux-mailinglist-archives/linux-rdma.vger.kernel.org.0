Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAFD105938
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKUSPE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:53516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUSPE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:15:04 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6AA1206CB;
        Thu, 21 Nov 2019 18:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360103;
        bh=8jEvlL+8YZjhC1OX4lrU8Xa0hjOqb2ft0jWTB5C2v+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o9AviR+bviyQxxgDV3f2KdBQZd0uslXkfNf5VqIZI3qiV9mETN3wMgf6VoeB8EakA
         lpoVufIqFLhB9IDDJu38iG256WK59grNGnpjaJbRr6nViRsfdy0H1e2TOWOpSKtspa
         dtBB6hNvN2fShl3hNlZn3p2QRzUlPgyjONAaLDJw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 30/48] RDMA/cm: Convert REQ packet rate
Date:   Thu, 21 Nov 2019 20:12:55 +0200
Message-Id: <20191121181313.129430-31-leon@kernel.org>
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

Change primary and alternate packet rate fields to use newly
introduced macros.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  8 ++++----
 drivers/infiniband/core/cm_msgs.h | 26 --------------------------
 2 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index eebb98b48ec4..a8b98dc0d50c 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1320,7 +1320,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	}
 	IBA_SET(CM_REQ_PRIMARY_FLOW_LABEL, req_msg,
 	       be32_to_cpu(pri_path->flow_label));
-	cm_req_set_primary_packet_rate(req_msg, pri_path->rate);
+	IBA_SET(CM_REQ_PRIMARY_PACKET_RATE, req_msg, pri_path->rate);
 	req_msg->primary_traffic_class = pri_path->traffic_class;
 	req_msg->primary_hop_limit = pri_path->hop_limit;
 	cm_req_set_primary_sl(req_msg, pri_path->sl);
@@ -1355,7 +1355,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 		}
 		IBA_SET(CM_REQ_ALTERNATE_FLOW_LABEL, req_msg,
 		       be32_to_cpu(alt_path->flow_label));
-		cm_req_set_alt_packet_rate(req_msg, alt_path->rate);
+		IBA_SET(CM_REQ_ALTERNATE_PACKET_RATE, req_msg, alt_path->rate);
 		req_msg->alt_traffic_class = alt_path->traffic_class;
 		req_msg->alt_hop_limit = alt_path->hop_limit;
 		cm_req_set_alt_sl(req_msg, alt_path->sl);
@@ -1580,7 +1580,7 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 	primary_path->mtu_selector = IB_SA_EQ;
 	primary_path->mtu = IBA_GET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, req_msg);
 	primary_path->rate_selector = IB_SA_EQ;
-	primary_path->rate = cm_req_get_primary_packet_rate(req_msg);
+	primary_path->rate = IBA_GET(CM_REQ_PRIMARY_PACKET_RATE, req_msg);
 	primary_path->packet_life_time_selector = IB_SA_EQ;
 	primary_path->packet_life_time =
 		cm_req_get_primary_local_ack_timeout(req_msg);
@@ -1602,7 +1602,7 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 		alt_path->mtu_selector = IB_SA_EQ;
 		alt_path->mtu = IBA_GET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, req_msg);
 		alt_path->rate_selector = IB_SA_EQ;
-		alt_path->rate = cm_req_get_alt_packet_rate(req_msg);
+		alt_path->rate = IBA_GET(CM_REQ_ALTERNATE_PACKET_RATE, req_msg);
 		alt_path->packet_life_time_selector = IB_SA_EQ;
 		alt_path->packet_life_time =
 			cm_req_get_alt_local_ack_timeout(req_msg);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 09c6a393b6a1..620d344651ae 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -70,19 +70,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline u8 cm_req_get_primary_packet_rate(struct cm_req_msg *req_msg)
-{
-	return (u8) (be32_to_cpu(req_msg->primary_offset88) & 0x3F);
-}
-
-static inline void cm_req_set_primary_packet_rate(struct cm_req_msg *req_msg,
-						  u8 rate)
-{
-	req_msg->primary_offset88 = cpu_to_be32(
-				    (be32_to_cpu(req_msg->primary_offset88) &
-				     0xFFFFFFC0) | (rate & 0x3F));
-}
-
 static inline u8 cm_req_get_primary_sl(struct cm_req_msg *req_msg)
 {
 	return (u8) (req_msg->primary_offset94 >> 4);
@@ -118,19 +105,6 @@ static inline void cm_req_set_primary_local_ack_timeout(struct cm_req_msg *req_m
 					  (local_ack_timeout << 3));
 }
 
-static inline u8 cm_req_get_alt_packet_rate(struct cm_req_msg *req_msg)
-{
-	return (u8) (be32_to_cpu(req_msg->alt_offset132) & 0x3F);
-}
-
-static inline void cm_req_set_alt_packet_rate(struct cm_req_msg *req_msg,
-					      u8 rate)
-{
-	req_msg->alt_offset132 = cpu_to_be32(
-				 (be32_to_cpu(req_msg->alt_offset132) &
-				  0xFFFFFFC0) | (rate & 0x3F));
-}
-
 static inline u8 cm_req_get_alt_sl(struct cm_req_msg *req_msg)
 {
 	return (u8) (req_msg->alt_offset138 >> 4);
-- 
2.20.1

