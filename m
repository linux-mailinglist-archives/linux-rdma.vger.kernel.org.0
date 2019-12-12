Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE0E11C97E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfLLJjc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:39:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbfLLJjc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:39:32 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0BDC2173E;
        Thu, 12 Dec 2019 09:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143571;
        bh=3x+rg8sJs9gCLLyJRyCedQdhZup8Nor0xiHxZ3ZpFlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UvD/NbULkMs3EwKLwPjO16QDzWzVvdTj6DtdQhUQ8tvdmJY2J2q6gAI5aEDIBzsz8
         P/NRspV40I2b/htlM84qDdyzfPWOzlLjmDs0XFRe+v/HAaUd/sKNPGcJrzdFHsQsUh
         J3JFBWa5dB+xBjkzAD5vWH6TbB3I9hK/GW+ZN0jc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 17/48] RDMA/cm: Convert REQ responded resources to the new scheme
Date:   Thu, 12 Dec 2019 11:37:59 +0200
Message-Id: <20191212093830.316934-18-leon@kernel.org>
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

Use new scheme to get/set REQ responded resources.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  7 ++++---
 drivers/infiniband/core/cm_msgs.h | 12 ------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 247238469af1..26718d25564c 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1279,7 +1279,8 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	cm_req_set_max_cm_retries(req_msg, param->max_cm_retries);
 
 	if (param->qp_type != IB_QPT_XRC_INI) {
-		cm_req_set_resp_res(req_msg, param->responder_resources);
+		IBA_SET(CM_REQ_RESPONDED_RESOURCES, req_msg,
+		       param->responder_resources);
 		cm_req_set_retry_count(req_msg, param->retry_count);
 		cm_req_set_rnr_retry_count(req_msg, param->rnr_retry_count);
 		cm_req_set_srq(req_msg, param->srq);
@@ -1670,7 +1671,7 @@ static void cm_format_req_event(struct cm_work *work,
 	param->qp_type = cm_req_get_qp_type(req_msg);
 	param->starting_psn = be32_to_cpu(cm_req_get_starting_psn(req_msg));
 	param->responder_resources = cm_req_get_init_depth(req_msg);
-	param->initiator_depth = cm_req_get_resp_res(req_msg);
+	param->initiator_depth = IBA_GET(CM_REQ_RESPONDED_RESOURCES, req_msg);
 	param->local_cm_response_timeout =
 					cm_req_get_remote_resp_timeout(req_msg);
 	param->flow_control = cm_req_get_flow_ctrl(req_msg);
@@ -2004,7 +2005,7 @@ static int cm_req_handler(struct cm_work *work)
 					cm_req_get_local_resp_timeout(req_msg));
 	cm_id_priv->max_cm_retries = cm_req_get_max_cm_retries(req_msg);
 	cm_id_priv->remote_qpn = IBA_GET(CM_REQ_LOCAL_QPN, req_msg);
-	cm_id_priv->initiator_depth = cm_req_get_resp_res(req_msg);
+	cm_id_priv->initiator_depth = IBA_GET(CM_REQ_RESPONDED_RESOURCES, req_msg);
 	cm_id_priv->responder_resources = cm_req_get_init_depth(req_msg);
 	cm_id_priv->path_mtu = cm_req_get_path_mtu(req_msg);
 	cm_id_priv->pkey = req_msg->pkey;
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 650d6fb312c8..7909100dc9eb 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -70,18 +70,6 @@ struct cm_req_msg {
 
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

