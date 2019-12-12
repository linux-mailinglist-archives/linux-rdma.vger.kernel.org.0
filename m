Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB5EE11C981
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfLLJjf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:39:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728435AbfLLJjf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:39:35 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA5C82173E;
        Thu, 12 Dec 2019 09:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143574;
        bh=TXT5vXhVanahK+Bvi7IVHNo7qoNd5GqPYyYKvb0+5ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Y0wzfqXKlYS9ukR1g3IenZcrH0z63dpJRUEZEHhDFHuuOSmS/5Gz/atVaXzbJlYg
         sW/BJZpo4bf1iZcksCGkmWQ5ELmFGbNUp6zom1jmWtUVWUZvmh2MRP6QaugDybmo1D
         oSzokyaIwHWgBgwQC9IrkJHfsZCYt0tvrtuLUhCo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 18/48] RDMA/cm: Convert REQ initiator depth to the new scheme
Date:   Thu, 12 Dec 2019 11:38:00 +0200
Message-Id: <20191212093830.316934-19-leon@kernel.org>
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

Adapt REQ initiator depth to new get/set macros.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  6 +++---
 drivers/infiniband/core/cm_msgs.h | 13 -------------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 26718d25564c..1f80db6b24e7 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1266,7 +1266,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	req_msg->service_id = param->service_id;
 	req_msg->local_ca_guid = cm_id_priv->id.device->node_guid;
 	IBA_SET(CM_REQ_LOCAL_QPN, req_msg, param->qp_num);
-	cm_req_set_init_depth(req_msg, param->initiator_depth);
+	IBA_SET(CM_REQ_INITIATOR_DEPTH, req_msg, param->initiator_depth);
 	cm_req_set_remote_resp_timeout(req_msg,
 				       param->remote_cm_response_timeout);
 	cm_req_set_qp_type(req_msg, param->qp_type);
@@ -1670,7 +1670,7 @@ static void cm_format_req_event(struct cm_work *work,
 	param->remote_qpn = IBA_GET(CM_REQ_LOCAL_QPN, req_msg);
 	param->qp_type = cm_req_get_qp_type(req_msg);
 	param->starting_psn = be32_to_cpu(cm_req_get_starting_psn(req_msg));
-	param->responder_resources = cm_req_get_init_depth(req_msg);
+	param->responder_resources = IBA_GET(CM_REQ_INITIATOR_DEPTH, req_msg);
 	param->initiator_depth = IBA_GET(CM_REQ_RESPONDED_RESOURCES, req_msg);
 	param->local_cm_response_timeout =
 					cm_req_get_remote_resp_timeout(req_msg);
@@ -2006,7 +2006,7 @@ static int cm_req_handler(struct cm_work *work)
 	cm_id_priv->max_cm_retries = cm_req_get_max_cm_retries(req_msg);
 	cm_id_priv->remote_qpn = IBA_GET(CM_REQ_LOCAL_QPN, req_msg);
 	cm_id_priv->initiator_depth = IBA_GET(CM_REQ_RESPONDED_RESOURCES, req_msg);
-	cm_id_priv->responder_resources = cm_req_get_init_depth(req_msg);
+	cm_id_priv->responder_resources = IBA_GET(CM_REQ_INITIATOR_DEPTH, req_msg);
 	cm_id_priv->path_mtu = cm_req_get_path_mtu(req_msg);
 	cm_id_priv->pkey = req_msg->pkey;
 	cm_id_priv->sq_psn = cm_req_get_starting_psn(req_msg);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 7909100dc9eb..4adf107f07f0 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -70,19 +70,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline u8 cm_req_get_init_depth(struct cm_req_msg *req_msg)
-{
-	return (u8) be32_to_cpu(req_msg->offset36);
-}
-
-static inline void cm_req_set_init_depth(struct cm_req_msg *req_msg,
-					 u8 init_depth)
-{
-	req_msg->offset36 = cpu_to_be32(init_depth |
-					(be32_to_cpu(req_msg->offset36) &
-					 0xFFFFFF00));
-}
-
 static inline u8 cm_req_get_remote_resp_timeout(struct cm_req_msg *req_msg)
 {
 	return (u8) ((be32_to_cpu(req_msg->offset40) & 0xF8) >> 3);
-- 
2.20.1

