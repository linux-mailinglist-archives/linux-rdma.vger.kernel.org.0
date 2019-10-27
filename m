Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58303E614F
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfJ0HIE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HIE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:08:04 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D23F920578;
        Sun, 27 Oct 2019 07:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160083;
        bh=zdzlkoLl2ZdFUp16dl5itF1PyLS+PdGohttsxnlc55A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0Z71CjPBpbJRyLyXVfdE1sKZWg+9N6LoHpTTc0NVC2UfsSMHLnFCWg0YbgPsfn+S
         8UR2tlnjHJLQdIHQVk64fQ8Wh7zQ71P3yI8bSqrRTihlrnxxqShdBGV9hULWvmlAGd
         57N5rO6SRC5SAkoiyT3o42p4Oj1MVt8ry/8pi/0k=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 28/43] RDMA/cm: Convert REQ SL fields
Date:   Sun, 27 Oct 2019 09:06:06 +0200
Message-Id: <20191027070621.11711-29-leon@kernel.org>
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

Convert REQ SL fields.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 12 ++++++------
 drivers/infiniband/core/cm_msgs.h | 22 ----------------------
 2 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index a081eb5b1ac7..9f27dbc38707 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1323,7 +1323,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	CM_SET(REQ_PRIMARY_PACKET_RATE, req_msg, pri_path->rate);
 	req_msg->primary_traffic_class = pri_path->traffic_class;
 	req_msg->primary_hop_limit = pri_path->hop_limit;
-	cm_req_set_primary_sl(req_msg, pri_path->sl);
+	CM_SET(REQ_PRIMARY_SL, req_msg, pri_path->sl);
 	cm_req_set_primary_subnet_local(req_msg, (pri_path->hop_limit <= 1));
 	cm_req_set_primary_local_ack_timeout(req_msg,
 		cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
@@ -1358,7 +1358,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 		CM_SET(REQ_ALTERNATE_PACKET_RATE, req_msg, alt_path->rate);
 		req_msg->alt_traffic_class = alt_path->traffic_class;
 		req_msg->alt_hop_limit = alt_path->hop_limit;
-		cm_req_set_alt_sl(req_msg, alt_path->sl);
+		CM_SET(REQ_ALTERNATE_SL, req_msg, alt_path->sl);
 		cm_req_set_alt_subnet_local(req_msg, (alt_path->hop_limit <= 1));
 		cm_req_set_alt_local_ack_timeout(req_msg,
 			cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
@@ -1576,7 +1576,7 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 	primary_path->traffic_class = req_msg->primary_traffic_class;
 	primary_path->reversible = 1;
 	primary_path->pkey = req_msg->pkey;
-	primary_path->sl = cm_req_get_primary_sl(req_msg);
+	primary_path->sl = CM_GET(REQ_PRIMARY_SL, req_msg);
 	primary_path->mtu_selector = IB_SA_EQ;
 	primary_path->mtu = CM_GET(REQ_PATH_PACKET_PAYLOAD_MTU, req_msg);
 	primary_path->rate_selector = IB_SA_EQ;
@@ -1598,7 +1598,7 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 		alt_path->traffic_class = req_msg->alt_traffic_class;
 		alt_path->reversible = 1;
 		alt_path->pkey = req_msg->pkey;
-		alt_path->sl = cm_req_get_alt_sl(req_msg);
+		alt_path->sl = CM_GET(REQ_ALTERNATE_SL, req_msg);
 		alt_path->mtu_selector = IB_SA_EQ;
 		alt_path->mtu = CM_GET(REQ_PATH_PACKET_PAYLOAD_MTU, req_msg);
 		alt_path->rate_selector = IB_SA_EQ;
@@ -1910,7 +1910,7 @@ static void cm_process_routed_req(struct cm_req_msg *req_msg, struct ib_wc *wc)
 	if (!cm_req_get_primary_subnet_local(req_msg)) {
 		if (req_msg->primary_local_lid == IB_LID_PERMISSIVE) {
 			req_msg->primary_local_lid = ib_lid_be16(wc->slid);
-			cm_req_set_primary_sl(req_msg, wc->sl);
+			CM_SET(REQ_PRIMARY_SL, req_msg, wc->sl);
 		}
 
 		if (req_msg->primary_remote_lid == IB_LID_PERMISSIVE)
@@ -1920,7 +1920,7 @@ static void cm_process_routed_req(struct cm_req_msg *req_msg, struct ib_wc *wc)
 	if (!cm_req_get_alt_subnet_local(req_msg)) {
 		if (req_msg->alt_local_lid == IB_LID_PERMISSIVE) {
 			req_msg->alt_local_lid = ib_lid_be16(wc->slid);
-			cm_req_set_alt_sl(req_msg, wc->sl);
+			CM_SET(REQ_ALTERNATE_SL, req_msg, wc->sl);
 		}
 
 		if (req_msg->alt_remote_lid == IB_LID_PERMISSIVE)
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index b272587ee226..3ed35a44481d 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -400,17 +400,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline u8 cm_req_get_primary_sl(struct cm_req_msg *req_msg)
-{
-	return (u8) (req_msg->primary_offset94 >> 4);
-}
-
-static inline void cm_req_set_primary_sl(struct cm_req_msg *req_msg, u8 sl)
-{
-	req_msg->primary_offset94 = (u8) ((req_msg->primary_offset94 & 0x0F) |
-					  (sl << 4));
-}
-
 static inline u8 cm_req_get_primary_subnet_local(struct cm_req_msg *req_msg)
 {
 	return (u8) ((req_msg->primary_offset94 & 0x08) >> 3);
@@ -435,17 +424,6 @@ static inline void cm_req_set_primary_local_ack_timeout(struct cm_req_msg *req_m
 					  (local_ack_timeout << 3));
 }
 
-static inline u8 cm_req_get_alt_sl(struct cm_req_msg *req_msg)
-{
-	return (u8) (req_msg->alt_offset138 >> 4);
-}
-
-static inline void cm_req_set_alt_sl(struct cm_req_msg *req_msg, u8 sl)
-{
-	req_msg->alt_offset138 = (u8) ((req_msg->alt_offset138 & 0x0F) |
-				       (sl << 4));
-}
-
 static inline u8 cm_req_get_alt_subnet_local(struct cm_req_msg *req_msg)
 {
 	return (u8) ((req_msg->alt_offset138 & 0x08) >> 3);
-- 
2.20.1

