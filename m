Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8261D11C989
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfLLJkL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728383AbfLLJkK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:40:10 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2997022527;
        Thu, 12 Dec 2019 09:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143609;
        bh=I+UjwzleSz+069wAm3s0vncKS044UhY+KCLGn27Ba50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zuBD4lNNN3XAw+lvK//iAt0c8P5pBuDz+5E93r9KOVlzFsE7Tv8x6Fd+adrMFqQjV
         naYoD1p/Y1sWRz/KtGcE9IrWy/v1jjDAVTGwgdCp8aSPGtfSY/xTOZkDc2MnRn7RKi
         aKHBnDM4O5FoJ/bo/TDVkxEh+wbiWWZ1d6a4mnJk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 25/48] RDMA/cm: Update REQ path MTU field
Date:   Thu, 12 Dec 2019 11:38:07 +0200
Message-Id: <20191212093830.316934-26-leon@kernel.org>
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

Convert REQ path MTU field to use IBA_GET/IBA_SET macros.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  8 ++++----
 drivers/infiniband/core/cm_msgs.h | 10 ----------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 3e5b06c98808..d7f0b929147b 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1289,7 +1289,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	IBA_SET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg,
 		param->local_cm_response_timeout);
 	req_msg->pkey = param->primary_path->pkey;
-	cm_req_set_path_mtu(req_msg, param->primary_path->mtu);
+	IBA_SET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, req_msg, param->primary_path->mtu);
 	cm_req_set_max_cm_retries(req_msg, param->max_cm_retries);
 
 	if (param->qp_type != IB_QPT_XRC_INI) {
@@ -1576,7 +1576,7 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 	primary_path->pkey = req_msg->pkey;
 	primary_path->sl = cm_req_get_primary_sl(req_msg);
 	primary_path->mtu_selector = IB_SA_EQ;
-	primary_path->mtu = cm_req_get_path_mtu(req_msg);
+	primary_path->mtu = IBA_GET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, req_msg);
 	primary_path->rate_selector = IB_SA_EQ;
 	primary_path->rate = cm_req_get_primary_packet_rate(req_msg);
 	primary_path->packet_life_time_selector = IB_SA_EQ;
@@ -1597,7 +1597,7 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 		alt_path->pkey = req_msg->pkey;
 		alt_path->sl = cm_req_get_alt_sl(req_msg);
 		alt_path->mtu_selector = IB_SA_EQ;
-		alt_path->mtu = cm_req_get_path_mtu(req_msg);
+		alt_path->mtu = IBA_GET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, req_msg);
 		alt_path->rate_selector = IB_SA_EQ;
 		alt_path->rate = cm_req_get_alt_packet_rate(req_msg);
 		alt_path->packet_life_time_selector = IB_SA_EQ;
@@ -2032,7 +2032,7 @@ static int cm_req_handler(struct cm_work *work)
 	cm_id_priv->remote_qpn = IBA_GET(CM_REQ_LOCAL_QPN, req_msg);
 	cm_id_priv->initiator_depth = IBA_GET(CM_REQ_RESPONDED_RESOURCES, req_msg);
 	cm_id_priv->responder_resources = IBA_GET(CM_REQ_INITIATOR_DEPTH, req_msg);
-	cm_id_priv->path_mtu = cm_req_get_path_mtu(req_msg);
+	cm_id_priv->path_mtu = IBA_GET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, req_msg);
 	cm_id_priv->pkey = req_msg->pkey;
 	cm_id_priv->sq_psn = IBA_GET(CM_REQ_STARTING_PSN, req_msg);
 	cm_id_priv->retry_count = IBA_GET(CM_REQ_RETRY_COUNT, req_msg);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index d3f1caf07db5..dbc5acdd7a71 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -70,16 +70,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline u8 cm_req_get_path_mtu(struct cm_req_msg *req_msg)
-{
-	return req_msg->offset50 >> 4;
-}
-
-static inline void cm_req_set_path_mtu(struct cm_req_msg *req_msg, u8 path_mtu)
-{
-	req_msg->offset50 = (u8) ((req_msg->offset50 & 0xF) | (path_mtu << 4));
-}
-
 static inline u8 cm_req_get_rnr_retry_count(struct cm_req_msg *req_msg)
 {
 	return req_msg->offset50 & 0x7;
-- 
2.20.1

