Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E68DD10592E
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfKUSOk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:14:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUSOk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:14:40 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45DED2068E;
        Thu, 21 Nov 2019 18:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360078;
        bh=3x+rg8sJs9gCLLyJRyCedQdhZup8Nor0xiHxZ3ZpFlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JE3RnC6TDSvZN3pQ2GeKK07YWcvBcs1bFiAa9h/sYMFkqOWRMIht+YTiqBgFpgwox
         EgTr33ciuVs9QGY0cQJEjFEMWMyawnbE6/tI+V5nm3QDUSiivyfkDkZ1cGbaBV20Fz
         X5sXjY+KJ1Mk4i53YkUjzBGTh1oqgCAhaisz6AVE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 17/48] RDMA/cm: Convert REQ responded resources to the new scheme
Date:   Thu, 21 Nov 2019 20:12:42 +0200
Message-Id: <20191121181313.129430-18-leon@kernel.org>
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

