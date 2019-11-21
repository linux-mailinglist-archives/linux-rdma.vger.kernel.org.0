Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF39E105929
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKUSOW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:14:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUSOW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:14:22 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D296F2068E;
        Thu, 21 Nov 2019 18:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360061;
        bh=ft2P2R+4z2YcD7Wa4yjkDQ33vLAm1igD+/GjkqRcGGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zMSE7fLuKK3jefLdZ21ggoMxi2bDAuKLgYzKuoKO66n9uDqj/J68Y9LQThocEYhY7
         CA12bSp0NH1gkgxqDyU3FTUrGoIf/My6jplDs/iMHbkM2B7LyLv3LDqAZpjwuLNDd0
         cATh223heRp86IAcWeobB1ck6qs9xmdIfMrG2X1E=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 19/48] RDMA/cm: Convert REQ remote response timeout
Date:   Thu, 21 Nov 2019 20:12:44 +0200
Message-Id: <20191121181313.129430-20-leon@kernel.org>
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

