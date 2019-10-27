Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7879E6148
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfJ0HHj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:07:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HHj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:07:39 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A632920578;
        Sun, 27 Oct 2019 07:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160058;
        bh=hdQt20VSEzVlFoNujD+slwSemWNixms1rRgUmbzhG5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XajAx9BMf6oMmLZASWS3gHLX64s5OMBz8XL7qshdo0jxuuo56lOET91FIc+rtAZJs
         5s+Wh0WQk+OYLpXDB0n3eag62bSvjb2atn3xjypiNKqLJuk4fgiVOrWQpxL6t7kQF2
         em8w2LwlH+YUXvn6/gLCAZ0Oy439b+V3aUrNvGg4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 21/43] RDMA/cm: Convert REQ retry count to use new scheme
Date:   Sun, 27 Oct 2019 09:05:59 +0200
Message-Id: <20191027070621.11711-22-leon@kernel.org>
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

Convert REQ retry count to new CM_GET/CM_SET macros.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  6 +++---
 drivers/infiniband/core/cm_msgs.h | 12 ------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index b9eec4bf6419..ea3540cf9deb 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1295,7 +1295,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	if (param->qp_type != IB_QPT_XRC_INI) {
 		CM_SET(REQ_RESPONDED_RESOURCES, req_msg,
 		       param->responder_resources);
-		cm_req_set_retry_count(req_msg, param->retry_count);
+		CM_SET(REQ_RETRY_COUNT, req_msg, param->retry_count);
 		cm_req_set_rnr_retry_count(req_msg, param->rnr_retry_count);
 		cm_req_set_srq(req_msg, param->srq);
 	}
@@ -1702,7 +1702,7 @@ static void cm_format_req_event(struct cm_work *work,
 	param->flow_control = CM_GET(REQ_END_TO_END_FLOW_CONTROL, req_msg);
 	param->remote_cm_response_timeout =
 		CM_GET(REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg);
-	param->retry_count = cm_req_get_retry_count(req_msg);
+	param->retry_count = CM_GET(REQ_RETRY_COUNT, req_msg);
 	param->rnr_retry_count = cm_req_get_rnr_retry_count(req_msg);
 	param->srq = cm_req_get_srq(req_msg);
 	param->ppath_sgid_attr = cm_id_priv->av.ah_attr.grh.sgid_attr;
@@ -2035,7 +2035,7 @@ static int cm_req_handler(struct cm_work *work)
 	cm_id_priv->path_mtu = cm_req_get_path_mtu(req_msg);
 	cm_id_priv->pkey = req_msg->pkey;
 	cm_id_priv->sq_psn = CM_GET(REQ_STARTING_PSN, req_msg);
-	cm_id_priv->retry_count = cm_req_get_retry_count(req_msg);
+	cm_id_priv->retry_count = CM_GET(REQ_RETRY_COUNT, req_msg);
 	cm_id_priv->rnr_retry_count = cm_req_get_rnr_retry_count(req_msg);
 	cm_id_priv->qp_type = cm_req_get_qp_type(req_msg);
 
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 2deaed83c9eb..ff7d4e9da833 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -400,18 +400,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline u8 cm_req_get_retry_count(struct cm_req_msg *req_msg)
-{
-	return (u8) (be32_to_cpu(req_msg->offset44) & 0x7);
-}
-
-static inline void cm_req_set_retry_count(struct cm_req_msg *req_msg,
-					  u8 retry_count)
-{
-	req_msg->offset44 = cpu_to_be32((retry_count & 0x7) |
-			    (be32_to_cpu(req_msg->offset44) & 0xFFFFFFF8));
-}
-
 static inline u8 cm_req_get_path_mtu(struct cm_req_msg *req_msg)
 {
 	return req_msg->offset50 >> 4;
-- 
2.20.1

