Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E135EE6141
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfJ0HHO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:07:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HHO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:07:14 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86CF820578;
        Sun, 27 Oct 2019 07:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160033;
        bh=EpstzgCWfwvAbM605FIFKI4ZoRTO+kJD2tj7QMuPwLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0lT4UV5uq/33yev39vGVWNIRsndPOZJc+/VkrpZ/AbkZYHgVOkTP+6HN/tDaKC+V2
         j/dJXR4ogBTYL954IhVBZ9zNzohdVcqgGCKTayeqo94nSm3P6dB7yVY+LvSNLA27De
         F3wLTjSQt7lv6NO83UZ6PIkeq5vYuSgmxF1FkkrY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 14/43] RDMA/cm: Convert REQ responded resources to the new scheme
Date:   Sun, 27 Oct 2019 09:05:52 +0200
Message-Id: <20191027070621.11711-15-leon@kernel.org>
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

Use new scheme to get/set REQ responded resources.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  7 ++++---
 drivers/infiniband/core/cm_msgs.h | 12 ------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 81a67805b029..25cbc0860bd4 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1279,7 +1279,8 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	cm_req_set_max_cm_retries(req_msg, param->max_cm_retries);
 
 	if (param->qp_type != IB_QPT_XRC_INI) {
-		cm_req_set_resp_res(req_msg, param->responder_resources);
+		CM_SET(REQ_RESPONDED_RESOURCES, req_msg,
+		       param->responder_resources);
 		cm_req_set_retry_count(req_msg, param->retry_count);
 		cm_req_set_rnr_retry_count(req_msg, param->rnr_retry_count);
 		cm_req_set_srq(req_msg, param->srq);
@@ -1670,7 +1671,7 @@ static void cm_format_req_event(struct cm_work *work,
 	param->qp_type = cm_req_get_qp_type(req_msg);
 	param->starting_psn = be32_to_cpu(cm_req_get_starting_psn(req_msg));
 	param->responder_resources = cm_req_get_init_depth(req_msg);
-	param->initiator_depth = cm_req_get_resp_res(req_msg);
+	param->initiator_depth = CM_GET(REQ_RESPONDED_RESOURCES, req_msg);
 	param->local_cm_response_timeout =
 					cm_req_get_remote_resp_timeout(req_msg);
 	param->flow_control = cm_req_get_flow_ctrl(req_msg);
@@ -2004,7 +2005,7 @@ static int cm_req_handler(struct cm_work *work)
 					cm_req_get_local_resp_timeout(req_msg));
 	cm_id_priv->max_cm_retries = cm_req_get_max_cm_retries(req_msg);
 	cm_id_priv->remote_qpn = CM_GET(REQ_LOCAL_QPN, req_msg);
-	cm_id_priv->initiator_depth = cm_req_get_resp_res(req_msg);
+	cm_id_priv->initiator_depth = CM_GET(REQ_RESPONDED_RESOURCES, req_msg);
 	cm_id_priv->responder_resources = cm_req_get_init_depth(req_msg);
 	cm_id_priv->path_mtu = cm_req_get_path_mtu(req_msg);
 	cm_id_priv->pkey = req_msg->pkey;
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 4cef1fe58813..ab32f8cd98d0 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -400,18 +400,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline u8 cm_req_get_resp_res(struct cm_req_msg *req_msg)
-{
-	return (u8) be32_to_cpu(req_msg->offset32);
-}
-
-static inline void cm_req_set_resp_res(struct cm_req_msg *req_msg, u8 resp_res)
-{
-	req_msg->offset32 = cpu_to_be32(resp_res |
-					(be32_to_cpu(req_msg->offset32) &
-					 0xFFFFFF00));
-}
-
 static inline u8 cm_req_get_init_depth(struct cm_req_msg *req_msg)
 {
 	return (u8) be32_to_cpu(req_msg->offset36);
-- 
2.20.1

