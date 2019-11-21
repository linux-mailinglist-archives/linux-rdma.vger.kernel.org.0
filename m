Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A375105930
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKUSOq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:14:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUSOq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:14:46 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 484982068E;
        Thu, 21 Nov 2019 18:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360086;
        bh=+LsPaH2jIxW7nbre660RK1jeEaE+IL/OO5bq7xQ7tO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqntwRyqLjirjbqQB/9TRFjBOYEeO9EVHxOYrMdW2x0tHTQq1PN3uZX/x6ZYUKXe+
         lhZra9oPRSjNEKsfb7wr9QGL2Z6BSZg+P/vh7kuMUjsluaRS4qvjaaSXtqEhURTxDA
         qkHcBzBYbhQZaoXFOaf+waYboIQk7UitoIR+dFs8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 26/48] RDMA/cm: Convert REQ RNR retry timeout counter
Date:   Thu, 21 Nov 2019 20:12:51 +0200
Message-Id: <20191121181313.129430-27-leon@kernel.org>
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

Convert REQ RNR retry timeout counter to new scheme.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  6 +++---
 drivers/infiniband/core/cm_msgs.h | 12 ------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index d7f0b929147b..549ea886f0de 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1296,7 +1296,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 		IBA_SET(CM_REQ_RESPONDED_RESOURCES, req_msg,
 		       param->responder_resources);
 		IBA_SET(CM_REQ_RETRY_COUNT, req_msg, param->retry_count);
-		cm_req_set_rnr_retry_count(req_msg, param->rnr_retry_count);
+		IBA_SET(CM_REQ_RNR_RETRY_COUNT, req_msg, param->rnr_retry_count);
 		cm_req_set_srq(req_msg, param->srq);
 	}
 
@@ -1703,7 +1703,7 @@ static void cm_format_req_event(struct cm_work *work,
 	param->remote_cm_response_timeout =
 		IBA_GET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg);
 	param->retry_count = IBA_GET(CM_REQ_RETRY_COUNT, req_msg);
-	param->rnr_retry_count = cm_req_get_rnr_retry_count(req_msg);
+	param->rnr_retry_count = IBA_GET(CM_REQ_RNR_RETRY_COUNT, req_msg);
 	param->srq = cm_req_get_srq(req_msg);
 	param->ppath_sgid_attr = cm_id_priv->av.ah_attr.grh.sgid_attr;
 	work->cm_event.private_data = &req_msg->private_data;
@@ -2036,7 +2036,7 @@ static int cm_req_handler(struct cm_work *work)
 	cm_id_priv->pkey = req_msg->pkey;
 	cm_id_priv->sq_psn = IBA_GET(CM_REQ_STARTING_PSN, req_msg);
 	cm_id_priv->retry_count = IBA_GET(CM_REQ_RETRY_COUNT, req_msg);
-	cm_id_priv->rnr_retry_count = cm_req_get_rnr_retry_count(req_msg);
+	cm_id_priv->rnr_retry_count = IBA_GET(CM_REQ_RNR_RETRY_COUNT, req_msg);
 	cm_id_priv->qp_type = cm_req_get_qp_type(req_msg);
 
 	cm_format_req_event(work, cm_id_priv, &listen_cm_id_priv->id);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index dbc5acdd7a71..a754c7fa4fc0 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -70,18 +70,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline u8 cm_req_get_rnr_retry_count(struct cm_req_msg *req_msg)
-{
-	return req_msg->offset50 & 0x7;
-}
-
-static inline void cm_req_set_rnr_retry_count(struct cm_req_msg *req_msg,
-					      u8 rnr_retry_count)
-{
-	req_msg->offset50 = (u8) ((req_msg->offset50 & 0xF8) |
-				  (rnr_retry_count & 0x7));
-}
-
 static inline u8 cm_req_get_max_cm_retries(struct cm_req_msg *req_msg)
 {
 	return req_msg->offset51 >> 4;
-- 
2.20.1

