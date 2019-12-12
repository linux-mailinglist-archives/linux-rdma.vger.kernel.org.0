Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E54A711C97A
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfLLJjy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:39:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbfLLJjy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:39:54 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 142762173E;
        Thu, 12 Dec 2019 09:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143593;
        bh=XNIcEkgdkUhvB6T6uLyH4IJFxWIqk5KheXhuulsxMjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2vtzqoLXgkrDFfqev8gMjqHI6z/401CqgfwMLM/CnrUQ5fTYBR49p6Yc/J++MjN0
         /j11Z9A3WW1tzE5e6nxVNBeKHZz43LrDoOg5Fguz5dc9J66TRMOMnJbrT9A3imSf2r
         YXrwOsG4A/BVcvauTMDGFDxvfoq+mVRSH9/R/rB8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 24/48] RDMA/cm: Convert REQ retry count to use new scheme
Date:   Thu, 12 Dec 2019 11:38:06 +0200
Message-Id: <20191212093830.316934-25-leon@kernel.org>
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

Convert REQ retry count to new IBA_GET/IBA_SET macros.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  6 +++---
 drivers/infiniband/core/cm_msgs.h | 12 ------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 062579d43c56..3e5b06c98808 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1295,7 +1295,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	if (param->qp_type != IB_QPT_XRC_INI) {
 		IBA_SET(CM_REQ_RESPONDED_RESOURCES, req_msg,
 		       param->responder_resources);
-		cm_req_set_retry_count(req_msg, param->retry_count);
+		IBA_SET(CM_REQ_RETRY_COUNT, req_msg, param->retry_count);
 		cm_req_set_rnr_retry_count(req_msg, param->rnr_retry_count);
 		cm_req_set_srq(req_msg, param->srq);
 	}
@@ -1702,7 +1702,7 @@ static void cm_format_req_event(struct cm_work *work,
 	param->flow_control = IBA_GET(CM_REQ_END_TO_END_FLOW_CONTROL, req_msg);
 	param->remote_cm_response_timeout =
 		IBA_GET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg);
-	param->retry_count = cm_req_get_retry_count(req_msg);
+	param->retry_count = IBA_GET(CM_REQ_RETRY_COUNT, req_msg);
 	param->rnr_retry_count = cm_req_get_rnr_retry_count(req_msg);
 	param->srq = cm_req_get_srq(req_msg);
 	param->ppath_sgid_attr = cm_id_priv->av.ah_attr.grh.sgid_attr;
@@ -2035,7 +2035,7 @@ static int cm_req_handler(struct cm_work *work)
 	cm_id_priv->path_mtu = cm_req_get_path_mtu(req_msg);
 	cm_id_priv->pkey = req_msg->pkey;
 	cm_id_priv->sq_psn = IBA_GET(CM_REQ_STARTING_PSN, req_msg);
-	cm_id_priv->retry_count = cm_req_get_retry_count(req_msg);
+	cm_id_priv->retry_count = IBA_GET(CM_REQ_RETRY_COUNT, req_msg);
 	cm_id_priv->rnr_retry_count = cm_req_get_rnr_retry_count(req_msg);
 	cm_id_priv->qp_type = cm_req_get_qp_type(req_msg);
 
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 56832e9a0692..d3f1caf07db5 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -70,18 +70,6 @@ struct cm_req_msg {
 
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

