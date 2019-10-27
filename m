Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF89BE614E
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfJ0HIB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HIB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:08:01 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C8A320578;
        Sun, 27 Oct 2019 07:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160080;
        bh=axzq+YjhsilhCbuS3HYMNrEf4RYJbTeakaSG9TiWJ9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NZ8Px50YoN9oJxGGn8qYGvJN0+XJHMp/HNhrRQh5hcF9RInQ060inG5mu/Iw8DMZp
         oVFC99dfYNZwwTCRr8Dcwzs7DGv4EpmgE07R+yysM2TXBC6lzysNDkpRohOYlBuRIv
         3fIPtm0qow37hnNVZQGVN1RuU1ZlAhEDEuL7AsN8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 27/43] RDMA/cm: Convert REQ packet rate
Date:   Sun, 27 Oct 2019 09:06:05 +0200
Message-Id: <20191027070621.11711-28-leon@kernel.org>
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

Change primary and alternate packet rate fields to use newly
introduced macros.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  8 ++++----
 drivers/infiniband/core/cm_msgs.h | 26 --------------------------
 2 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index a1bee95ba9bd..a081eb5b1ac7 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1320,7 +1320,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	}
 	CM_SET(REQ_PRIMARY_FLOW_LABEL, req_msg,
 	       be32_to_cpu(pri_path->flow_label));
-	cm_req_set_primary_packet_rate(req_msg, pri_path->rate);
+	CM_SET(REQ_PRIMARY_PACKET_RATE, req_msg, pri_path->rate);
 	req_msg->primary_traffic_class = pri_path->traffic_class;
 	req_msg->primary_hop_limit = pri_path->hop_limit;
 	cm_req_set_primary_sl(req_msg, pri_path->sl);
@@ -1355,7 +1355,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 		}
 		CM_SET(REQ_ALTERNATE_FLOW_LABEL, req_msg,
 		       be32_to_cpu(alt_path->flow_label));
-		cm_req_set_alt_packet_rate(req_msg, alt_path->rate);
+		CM_SET(REQ_ALTERNATE_PACKET_RATE, req_msg, alt_path->rate);
 		req_msg->alt_traffic_class = alt_path->traffic_class;
 		req_msg->alt_hop_limit = alt_path->hop_limit;
 		cm_req_set_alt_sl(req_msg, alt_path->sl);
@@ -1580,7 +1580,7 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 	primary_path->mtu_selector = IB_SA_EQ;
 	primary_path->mtu = CM_GET(REQ_PATH_PACKET_PAYLOAD_MTU, req_msg);
 	primary_path->rate_selector = IB_SA_EQ;
-	primary_path->rate = cm_req_get_primary_packet_rate(req_msg);
+	primary_path->rate = CM_GET(REQ_PRIMARY_PACKET_RATE, req_msg);
 	primary_path->packet_life_time_selector = IB_SA_EQ;
 	primary_path->packet_life_time =
 		cm_req_get_primary_local_ack_timeout(req_msg);
@@ -1602,7 +1602,7 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 		alt_path->mtu_selector = IB_SA_EQ;
 		alt_path->mtu = CM_GET(REQ_PATH_PACKET_PAYLOAD_MTU, req_msg);
 		alt_path->rate_selector = IB_SA_EQ;
-		alt_path->rate = cm_req_get_alt_packet_rate(req_msg);
+		alt_path->rate = CM_GET(REQ_ALTERNATE_PACKET_RATE, req_msg);
 		alt_path->packet_life_time_selector = IB_SA_EQ;
 		alt_path->packet_life_time =
 			cm_req_get_alt_local_ack_timeout(req_msg);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index dfcdfe2cd5ba..b272587ee226 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -400,19 +400,6 @@ struct cm_req_msg {
 
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
@@ -448,19 +435,6 @@ static inline void cm_req_set_primary_local_ack_timeout(struct cm_req_msg *req_m
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

