Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C413EE6143
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfJ0HHV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HHV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:07:21 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE1B221726;
        Sun, 27 Oct 2019 07:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160040;
        bh=Q2l9RcC9Toe0xy4W9dRZpz3d56Z7zoDk6mukyaBLjSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DbOXnkFy/T8/5aekrUX1YbxK+slaRRpYSSI91Jc+EmEL7q+w9HpyrUm8AllWE2Fp7
         7LDDd/GrY38QyMekerq1Z7jaBWvutxzuESFWOVS1UfH+zmdBaaVUfuxKFkexXBwPea
         6YSboGex9oFPRREK3swK1qhhRuTD6WX144yQ7qLQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 16/43] RDMA/cm: Convert REQ remote response timeout
Date:   Sun, 27 Oct 2019 09:05:54 +0200
Message-Id: <20191027070621.11711-17-leon@kernel.org>
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

Use new get/set macros to access REQ remote response timeout.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  6 +++---
 drivers/infiniband/core/cm_msgs.h | 13 -------------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 519a025773ff..4e5c2ad1532e 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1267,8 +1267,8 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	req_msg->local_ca_guid = cm_id_priv->id.device->node_guid;
 	CM_SET(REQ_LOCAL_QPN, req_msg, param->qp_num);
 	CM_SET(REQ_INITIATOR_DEPTH, req_msg, param->initiator_depth);
-	cm_req_set_remote_resp_timeout(req_msg,
-				       param->remote_cm_response_timeout);
+	CM_SET(REQ_REMOTE_CM_RESPONSE_TIMEOUT, req_msg,
+	       param->remote_cm_response_timeout);
 	cm_req_set_qp_type(req_msg, param->qp_type);
 	cm_req_set_flow_ctrl(req_msg, param->flow_control);
 	cm_req_set_starting_psn(req_msg, cpu_to_be32(param->starting_psn));
@@ -1673,7 +1673,7 @@ static void cm_format_req_event(struct cm_work *work,
 	param->responder_resources = CM_GET(REQ_INITIATOR_DEPTH, req_msg);
 	param->initiator_depth = CM_GET(REQ_RESPONDED_RESOURCES, req_msg);
 	param->local_cm_response_timeout =
-					cm_req_get_remote_resp_timeout(req_msg);
+		CM_GET(REQ_REMOTE_CM_RESPONSE_TIMEOUT, req_msg);
 	param->flow_control = cm_req_get_flow_ctrl(req_msg);
 	param->remote_cm_response_timeout =
 					cm_req_get_local_resp_timeout(req_msg);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 4f4531d38535..955a9a5ceeb7 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -400,19 +400,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline u8 cm_req_get_remote_resp_timeout(struct cm_req_msg *req_msg)
-{
-	return (u8) ((be32_to_cpu(req_msg->offset40) & 0xF8) >> 3);
-}
-
-static inline void cm_req_set_remote_resp_timeout(struct cm_req_msg *req_msg,
-						  u8 resp_timeout)
-{
-	req_msg->offset40 = cpu_to_be32((resp_timeout << 3) |
-					 (be32_to_cpu(req_msg->offset40) &
-					  0xFFFFFF07));
-}
-
 static inline enum ib_qp_type cm_req_get_qp_type(struct cm_req_msg *req_msg)
 {
 	u8 transport_type = (u8) (be32_to_cpu(req_msg->offset40) & 0x06) >> 1;
-- 
2.20.1

