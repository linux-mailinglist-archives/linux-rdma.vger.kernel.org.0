Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA3BE6150
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfJ0HII (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HII (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:08:08 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F50420578;
        Sun, 27 Oct 2019 07:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160087;
        bh=Y9+Ze/2ahHog199UzaLgqh1KayyqdBkIv+/4h4OMjFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A/RMXykAT1WiOgtsPrar8Prl37MTX8lSI0twc+xNGaFhZ8Ic3q5vBKX/5JXyZrAiQ
         7k+Ry/YJ0WOcnaWEQP2HsJC2LGXsjbLTxX8eFEKUxw3RwZGNGc6BjRdEfxT/xqkAO8
         OtER6kXjLTQEe4UV/aX9Cw/VMrtpEJaUfASYmh4E=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 29/43] RDMA/cm: Convert REQ subnet local fields
Date:   Sun, 27 Oct 2019 09:06:07 +0200
Message-Id: <20191027070621.11711-30-leon@kernel.org>
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

Convert REQ subnet local fields.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  9 +++++----
 drivers/infiniband/core/cm_msgs.h | 24 ------------------------
 2 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 9f27dbc38707..36abe43ad8a6 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1324,7 +1324,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	req_msg->primary_traffic_class = pri_path->traffic_class;
 	req_msg->primary_hop_limit = pri_path->hop_limit;
 	CM_SET(REQ_PRIMARY_SL, req_msg, pri_path->sl);
-	cm_req_set_primary_subnet_local(req_msg, (pri_path->hop_limit <= 1));
+	CM_SET(REQ_PRIMARY_SUBNET_LOCAL, req_msg, (pri_path->hop_limit <= 1));
 	cm_req_set_primary_local_ack_timeout(req_msg,
 		cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
 			       pri_path->packet_life_time));
@@ -1359,7 +1359,8 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 		req_msg->alt_traffic_class = alt_path->traffic_class;
 		req_msg->alt_hop_limit = alt_path->hop_limit;
 		CM_SET(REQ_ALTERNATE_SL, req_msg, alt_path->sl);
-		cm_req_set_alt_subnet_local(req_msg, (alt_path->hop_limit <= 1));
+		CM_SET(REQ_ALTERNATE_SUBNET_LOCAL, req_msg,
+		       (alt_path->hop_limit <= 1));
 		cm_req_set_alt_local_ack_timeout(req_msg,
 			cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
 				       alt_path->packet_life_time));
@@ -1907,7 +1908,7 @@ static struct cm_id_private * cm_match_req(struct cm_work *work,
  */
 static void cm_process_routed_req(struct cm_req_msg *req_msg, struct ib_wc *wc)
 {
-	if (!cm_req_get_primary_subnet_local(req_msg)) {
+	if (!CM_GET(REQ_PRIMARY_SUBNET_LOCAL, req_msg)) {
 		if (req_msg->primary_local_lid == IB_LID_PERMISSIVE) {
 			req_msg->primary_local_lid = ib_lid_be16(wc->slid);
 			CM_SET(REQ_PRIMARY_SL, req_msg, wc->sl);
@@ -1917,7 +1918,7 @@ static void cm_process_routed_req(struct cm_req_msg *req_msg, struct ib_wc *wc)
 			req_msg->primary_remote_lid = cpu_to_be16(wc->dlid_path_bits);
 	}
 
-	if (!cm_req_get_alt_subnet_local(req_msg)) {
+	if (!CM_GET(REQ_ALTERNATE_SUBNET_LOCAL, req_msg)) {
 		if (req_msg->alt_local_lid == IB_LID_PERMISSIVE) {
 			req_msg->alt_local_lid = ib_lid_be16(wc->slid);
 			CM_SET(REQ_ALTERNATE_SL, req_msg, wc->sl);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 3ed35a44481d..0faa48a51d7b 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -400,18 +400,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline u8 cm_req_get_primary_subnet_local(struct cm_req_msg *req_msg)
-{
-	return (u8) ((req_msg->primary_offset94 & 0x08) >> 3);
-}
-
-static inline void cm_req_set_primary_subnet_local(struct cm_req_msg *req_msg,
-						   u8 subnet_local)
-{
-	req_msg->primary_offset94 = (u8) ((req_msg->primary_offset94 & 0xF7) |
-					  ((subnet_local & 0x1) << 3));
-}
-
 static inline u8 cm_req_get_primary_local_ack_timeout(struct cm_req_msg *req_msg)
 {
 	return (u8) (req_msg->primary_offset95 >> 3);
@@ -424,18 +412,6 @@ static inline void cm_req_set_primary_local_ack_timeout(struct cm_req_msg *req_m
 					  (local_ack_timeout << 3));
 }
 
-static inline u8 cm_req_get_alt_subnet_local(struct cm_req_msg *req_msg)
-{
-	return (u8) ((req_msg->alt_offset138 & 0x08) >> 3);
-}
-
-static inline void cm_req_set_alt_subnet_local(struct cm_req_msg *req_msg,
-					       u8 subnet_local)
-{
-	req_msg->alt_offset138 = (u8) ((req_msg->alt_offset138 & 0xF7) |
-				       ((subnet_local & 0x1) << 3));
-}
-
 static inline u8 cm_req_get_alt_local_ack_timeout(struct cm_req_msg *req_msg)
 {
 	return (u8) (req_msg->alt_offset139 >> 3);
-- 
2.20.1

