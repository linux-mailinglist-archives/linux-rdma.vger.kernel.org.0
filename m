Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDC2F105949
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKUSPd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:15:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbfKUSPc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:15:32 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 133502068E;
        Thu, 21 Nov 2019 18:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360131;
        bh=1MUaeCQCqDeb3pyieL5IHACYtN3paRyQK9IRSQC418I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6gdfGFIZ34ngZ5VzeTpWNm45cCcU5Yhon4/dhbi3RnPyx/rZE4vmTsdaRQYlJ0/c
         TVj+hMCJlWmOgzyiqqr3N50QSenBLOp1js7cCWjVdaFXUv3QzzY7zLaMym28ZtJyhL
         Zpez4cEzW7+ajxR3r2EpEpUah4erMr0voyoMZjO8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 32/48] RDMA/cm: Convert REQ subnet local fields
Date:   Thu, 21 Nov 2019 20:12:57 +0200
Message-Id: <20191121181313.129430-33-leon@kernel.org>
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

Convert REQ subnet local fields.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  9 +++++----
 drivers/infiniband/core/cm_msgs.h | 24 ------------------------
 2 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index b6da28d43b46..1a5d5d401c72 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1324,7 +1324,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	req_msg->primary_traffic_class = pri_path->traffic_class;
 	req_msg->primary_hop_limit = pri_path->hop_limit;
 	IBA_SET(CM_REQ_PRIMARY_SL, req_msg, pri_path->sl);
-	cm_req_set_primary_subnet_local(req_msg, (pri_path->hop_limit <= 1));
+	IBA_SET(CM_REQ_PRIMARY_SUBNET_LOCAL, req_msg, (pri_path->hop_limit <= 1));
 	cm_req_set_primary_local_ack_timeout(req_msg,
 		cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
 			       pri_path->packet_life_time));
@@ -1359,7 +1359,8 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 		req_msg->alt_traffic_class = alt_path->traffic_class;
 		req_msg->alt_hop_limit = alt_path->hop_limit;
 		IBA_SET(CM_REQ_ALTERNATE_SL, req_msg, alt_path->sl);
-		cm_req_set_alt_subnet_local(req_msg, (alt_path->hop_limit <= 1));
+		IBA_SET(CM_REQ_ALTERNATE_SUBNET_LOCAL, req_msg,
+			(alt_path->hop_limit <= 1));
 		cm_req_set_alt_local_ack_timeout(req_msg,
 			cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
 				       alt_path->packet_life_time));
@@ -1907,7 +1908,7 @@ static struct cm_id_private * cm_match_req(struct cm_work *work,
  */
 static void cm_process_routed_req(struct cm_req_msg *req_msg, struct ib_wc *wc)
 {
-	if (!cm_req_get_primary_subnet_local(req_msg)) {
+	if (!IBA_GET(CM_REQ_PRIMARY_SUBNET_LOCAL, req_msg)) {
 		if (req_msg->primary_local_lid == IB_LID_PERMISSIVE) {
 			req_msg->primary_local_lid = ib_lid_be16(wc->slid);
 			IBA_SET(CM_REQ_PRIMARY_SL, req_msg, wc->sl);
@@ -1917,7 +1918,7 @@ static void cm_process_routed_req(struct cm_req_msg *req_msg, struct ib_wc *wc)
 			req_msg->primary_remote_lid = cpu_to_be16(wc->dlid_path_bits);
 	}
 
-	if (!cm_req_get_alt_subnet_local(req_msg)) {
+	if (!IBA_GET(CM_REQ_ALTERNATE_SUBNET_LOCAL, req_msg)) {
 		if (req_msg->alt_local_lid == IB_LID_PERMISSIVE) {
 			req_msg->alt_local_lid = ib_lid_be16(wc->slid);
 			IBA_SET(CM_REQ_ALTERNATE_SL, req_msg, wc->sl);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index b82eb10e22f6..3933c29b569b 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -70,18 +70,6 @@ struct cm_req_msg {
 
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
@@ -94,18 +82,6 @@ static inline void cm_req_set_primary_local_ack_timeout(struct cm_req_msg *req_m
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

