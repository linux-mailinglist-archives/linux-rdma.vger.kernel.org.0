Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8DFB11C979
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfLLJjv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:39:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbfLLJjv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:39:51 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E648022527;
        Thu, 12 Dec 2019 09:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143590;
        bh=Vjg+afCtDC0qb8YXaa+rFJR6qqYWZQZ4WpgtOCDIKOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6m4C09CrsWh2Efn+apbEohDLEMHVEB6qmKF2PHIgUGU6O8REuvRgdld1/qjkz+4u
         QwlTRP5TwEZiM8CgisKvEFUqTUkvl10/JlEQhWVit20EPL6D3L99F7/B6NY9BlY3kN
         gf3qRHbGvSOVyuQePqvjSM9LI35Oi9l13SlWkG1k=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 23/48] RDMA/cm: Update REQ local response timeout
Date:   Thu, 12 Dec 2019 11:38:05 +0200
Message-Id: <20191212093830.316934-24-leon@kernel.org>
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

Use newly introduces IBA_GET/IBA_SET to add access REQ local response
timeout.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  8 ++++----
 drivers/infiniband/core/cm_msgs.h | 12 ------------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index e9123f3b8f43..062579d43c56 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1286,8 +1286,8 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	cm_req_set_qp_type(req_msg, param->qp_type);
 	IBA_SET(CM_REQ_END_TO_END_FLOW_CONTROL, req_msg, param->flow_control);
 	IBA_SET(CM_REQ_STARTING_PSN, req_msg, param->starting_psn);
-	cm_req_set_local_resp_timeout(req_msg,
-				      param->local_cm_response_timeout);
+	IBA_SET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg,
+		param->local_cm_response_timeout);
 	req_msg->pkey = param->primary_path->pkey;
 	cm_req_set_path_mtu(req_msg, param->primary_path->mtu);
 	cm_req_set_max_cm_retries(req_msg, param->max_cm_retries);
@@ -1701,7 +1701,7 @@ static void cm_format_req_event(struct cm_work *work,
 		IBA_GET(CM_REQ_REMOTE_CM_RESPONSE_TIMEOUT, req_msg);
 	param->flow_control = IBA_GET(CM_REQ_END_TO_END_FLOW_CONTROL, req_msg);
 	param->remote_cm_response_timeout =
-					cm_req_get_local_resp_timeout(req_msg);
+		IBA_GET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg);
 	param->retry_count = cm_req_get_retry_count(req_msg);
 	param->rnr_retry_count = cm_req_get_rnr_retry_count(req_msg);
 	param->srq = cm_req_get_srq(req_msg);
@@ -2027,7 +2027,7 @@ static int cm_req_handler(struct cm_work *work)
 	}
 	cm_id_priv->tid = req_msg->hdr.tid;
 	cm_id_priv->timeout_ms = cm_convert_to_ms(
-					cm_req_get_local_resp_timeout(req_msg));
+		IBA_GET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg));
 	cm_id_priv->max_cm_retries = cm_req_get_max_cm_retries(req_msg);
 	cm_id_priv->remote_qpn = IBA_GET(CM_REQ_LOCAL_QPN, req_msg);
 	cm_id_priv->initiator_depth = IBA_GET(CM_REQ_RESPONDED_RESOURCES, req_msg);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 47f66c1793a7..56832e9a0692 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -70,18 +70,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline u8 cm_req_get_local_resp_timeout(struct cm_req_msg *req_msg)
-{
-	return (u8) ((be32_to_cpu(req_msg->offset44) & 0xF8) >> 3);
-}
-
-static inline void cm_req_set_local_resp_timeout(struct cm_req_msg *req_msg,
-						 u8 resp_timeout)
-{
-	req_msg->offset44 = cpu_to_be32((resp_timeout << 3) |
-			    (be32_to_cpu(req_msg->offset44) & 0xFFFFFF07));
-}
-
 static inline u8 cm_req_get_retry_count(struct cm_req_msg *req_msg)
 {
 	return (u8) (be32_to_cpu(req_msg->offset44) & 0x7);
-- 
2.20.1

