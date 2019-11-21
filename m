Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4027D105934
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKUSPB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:15:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:53388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUSPB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:15:01 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C9D42068E;
        Thu, 21 Nov 2019 18:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360100;
        bh=mdZ/svik/ZnMyMqdHBHNFHOQLjbJv3j/pdNqOQQ3wKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P4+yjnrDtDznh4ExNK5nn15pRy0Ag4SC3qF+vjiE0WbvmdnyevtTcjrcyZCyBMkg9
         M9k/kX+lkvuWk5902fEiwZZzX57W9mUYvjL84ZpvhwF+oofdMxheoqmupvAJOSDet2
         gArOLyaZ1DLRm1GD4GUbX7vZwSPkxOu38qROwOOY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 29/48] RDMA/cm: Convert REQ flow label field
Date:   Thu, 21 Nov 2019 20:12:54 +0200
Message-Id: <20191121181313.129430-30-leon@kernel.org>
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

Use new IBA_GET/IBA_SET macros.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 13 ++++++++-----
 drivers/infiniband/core/cm_msgs.h | 28 ----------------------------
 2 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 673ff1da05bd..eebb98b48ec4 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1318,7 +1318,8 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 		req_msg->primary_local_lid = IB_LID_PERMISSIVE;
 		req_msg->primary_remote_lid = IB_LID_PERMISSIVE;
 	}
-	cm_req_set_primary_flow_label(req_msg, pri_path->flow_label);
+	IBA_SET(CM_REQ_PRIMARY_FLOW_LABEL, req_msg,
+	       be32_to_cpu(pri_path->flow_label));
 	cm_req_set_primary_packet_rate(req_msg, pri_path->rate);
 	req_msg->primary_traffic_class = pri_path->traffic_class;
 	req_msg->primary_hop_limit = pri_path->hop_limit;
@@ -1352,8 +1353,8 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 			req_msg->alt_local_lid = IB_LID_PERMISSIVE;
 			req_msg->alt_remote_lid = IB_LID_PERMISSIVE;
 		}
-		cm_req_set_alt_flow_label(req_msg,
-					  alt_path->flow_label);
+		IBA_SET(CM_REQ_ALTERNATE_FLOW_LABEL, req_msg,
+		       be32_to_cpu(alt_path->flow_label));
 		cm_req_set_alt_packet_rate(req_msg, alt_path->rate);
 		req_msg->alt_traffic_class = alt_path->traffic_class;
 		req_msg->alt_hop_limit = alt_path->hop_limit;
@@ -1569,7 +1570,8 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 {
 	primary_path->dgid = req_msg->primary_local_gid;
 	primary_path->sgid = req_msg->primary_remote_gid;
-	primary_path->flow_label = cm_req_get_primary_flow_label(req_msg);
+	primary_path->flow_label =
+		cpu_to_be32(IBA_GET(CM_REQ_PRIMARY_FLOW_LABEL, req_msg));
 	primary_path->hop_limit = req_msg->primary_hop_limit;
 	primary_path->traffic_class = req_msg->primary_traffic_class;
 	primary_path->reversible = 1;
@@ -1590,7 +1592,8 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 	if (cm_req_has_alt_path(req_msg)) {
 		alt_path->dgid = req_msg->alt_local_gid;
 		alt_path->sgid = req_msg->alt_remote_gid;
-		alt_path->flow_label = cm_req_get_alt_flow_label(req_msg);
+		alt_path->flow_label = cpu_to_be32(
+			IBA_GET(CM_REQ_ALTERNATE_FLOW_LABEL, req_msg));
 		alt_path->hop_limit = req_msg->alt_hop_limit;
 		alt_path->traffic_class = req_msg->alt_traffic_class;
 		alt_path->reversible = 1;
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 23a48211d15e..09c6a393b6a1 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -70,20 +70,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline __be32 cm_req_get_primary_flow_label(struct cm_req_msg *req_msg)
-{
-	return cpu_to_be32(be32_to_cpu(req_msg->primary_offset88) >> 12);
-}
-
-static inline void cm_req_set_primary_flow_label(struct cm_req_msg *req_msg,
-						 __be32 flow_label)
-{
-	req_msg->primary_offset88 = cpu_to_be32(
-				    (be32_to_cpu(req_msg->primary_offset88) &
-				     0x00000FFF) |
-				     (be32_to_cpu(flow_label) << 12));
-}
-
 static inline u8 cm_req_get_primary_packet_rate(struct cm_req_msg *req_msg)
 {
 	return (u8) (be32_to_cpu(req_msg->primary_offset88) & 0x3F);
@@ -132,20 +118,6 @@ static inline void cm_req_set_primary_local_ack_timeout(struct cm_req_msg *req_m
 					  (local_ack_timeout << 3));
 }
 
-static inline __be32 cm_req_get_alt_flow_label(struct cm_req_msg *req_msg)
-{
-	return cpu_to_be32(be32_to_cpu(req_msg->alt_offset132) >> 12);
-}
-
-static inline void cm_req_set_alt_flow_label(struct cm_req_msg *req_msg,
-					     __be32 flow_label)
-{
-	req_msg->alt_offset132 = cpu_to_be32(
-				 (be32_to_cpu(req_msg->alt_offset132) &
-				  0x00000FFF) |
-				  (be32_to_cpu(flow_label) << 12));
-}
-
 static inline u8 cm_req_get_alt_packet_rate(struct cm_req_msg *req_msg)
 {
 	return (u8) (be32_to_cpu(req_msg->alt_offset132) & 0x3F);
-- 
2.20.1

