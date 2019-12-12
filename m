Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4832111C982
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfLLJji (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:39:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbfLLJji (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:39:38 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33DC222527;
        Thu, 12 Dec 2019 09:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143577;
        bh=ft2P2R+4z2YcD7Wa4yjkDQ33vLAm1igD+/GjkqRcGGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TbQv/whovaXVkq/RXd/dxEy+Md5LxALND4Hk9X7iJAqgU77J6D4w4pDi3T5eT69mr
         FKdUPagutv79Ovm5Cfq6ywPlMw6x/+tc2oghCXyx8KotC5JS9BU41MjNztNhHvAj96
         Zr/Shv5BEmJPCKjV4f3pJ4Qol4Y+Gy+qXinESi3E=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 19/48] RDMA/cm: Convert REQ remote response timeout
Date:   Thu, 12 Dec 2019 11:38:01 +0200
Message-Id: <20191212093830.316934-20-leon@kernel.org>
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

Use new get/set macros to access REQ remote response timeout.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  6 +++---
 drivers/infiniband/core/cm_msgs.h | 13 -------------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 1f80db6b24e7..34654aba638e 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1267,8 +1267,8 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	req_msg->local_ca_guid = cm_id_priv->id.device->node_guid;
 	IBA_SET(CM_REQ_LOCAL_QPN, req_msg, param->qp_num);
 	IBA_SET(CM_REQ_INITIATOR_DEPTH, req_msg, param->initiator_depth);
-	cm_req_set_remote_resp_timeout(req_msg,
-				       param->remote_cm_response_timeout);
+	IBA_SET(CM_REQ_REMOTE_CM_RESPONSE_TIMEOUT, req_msg,
+		param->remote_cm_response_timeout);
 	cm_req_set_qp_type(req_msg, param->qp_type);
 	cm_req_set_flow_ctrl(req_msg, param->flow_control);
 	cm_req_set_starting_psn(req_msg, cpu_to_be32(param->starting_psn));
@@ -1673,7 +1673,7 @@ static void cm_format_req_event(struct cm_work *work,
 	param->responder_resources = IBA_GET(CM_REQ_INITIATOR_DEPTH, req_msg);
 	param->initiator_depth = IBA_GET(CM_REQ_RESPONDED_RESOURCES, req_msg);
 	param->local_cm_response_timeout =
-					cm_req_get_remote_resp_timeout(req_msg);
+		IBA_GET(CM_REQ_REMOTE_CM_RESPONSE_TIMEOUT, req_msg);
 	param->flow_control = cm_req_get_flow_ctrl(req_msg);
 	param->remote_cm_response_timeout =
 					cm_req_get_local_resp_timeout(req_msg);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 4adf107f07f0..c348521040a6 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -70,19 +70,6 @@ struct cm_req_msg {
 
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

