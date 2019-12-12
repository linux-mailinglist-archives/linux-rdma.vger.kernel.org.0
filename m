Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E36111C976
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfLLJjo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:39:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbfLLJjo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:39:44 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 997CF24658;
        Thu, 12 Dec 2019 09:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143584;
        bh=B87y17E+ryryoV4t72zk3yTwxNcFA1u9cEHi5OK3/0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=juT4yMimxHcJJ3ZJcKmTV7M3NYzKymQuZ0SOzJKiAeZ953RQiDRZQqNCDpEJRTJiQ
         n4+Ax1YZ/KZknqKUqedlOknRNZ+DxSAwX4jyEqGGw5Hqx7YtNw8evNKzayOi3AGD9C
         c8kDLlZRfTCngvHzVgVee9quIC4FTyvCqaI3C2iY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 21/48] RDMA/cm: Convert REQ flow control
Date:   Thu, 12 Dec 2019 11:38:03 +0200
Message-Id: <20191212093830.316934-22-leon@kernel.org>
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

Use IBA_GET/IBA_SET for REQ flow control field.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  4 ++--
 drivers/infiniband/core/cm_msgs.h | 13 -------------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index f7ed4067743f..c60ec7967744 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1284,7 +1284,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	IBA_SET(CM_REQ_REMOTE_CM_RESPONSE_TIMEOUT, req_msg,
 		param->remote_cm_response_timeout);
 	cm_req_set_qp_type(req_msg, param->qp_type);
-	cm_req_set_flow_ctrl(req_msg, param->flow_control);
+	IBA_SET(CM_REQ_END_TO_END_FLOW_CONTROL, req_msg, param->flow_control);
 	cm_req_set_starting_psn(req_msg, cpu_to_be32(param->starting_psn));
 	cm_req_set_local_resp_timeout(req_msg,
 				      param->local_cm_response_timeout);
@@ -1699,7 +1699,7 @@ static void cm_format_req_event(struct cm_work *work,
 	param->initiator_depth = IBA_GET(CM_REQ_RESPONDED_RESOURCES, req_msg);
 	param->local_cm_response_timeout =
 		IBA_GET(CM_REQ_REMOTE_CM_RESPONSE_TIMEOUT, req_msg);
-	param->flow_control = cm_req_get_flow_ctrl(req_msg);
+	param->flow_control = IBA_GET(CM_REQ_END_TO_END_FLOW_CONTROL, req_msg);
 	param->remote_cm_response_timeout =
 					cm_req_get_local_resp_timeout(req_msg);
 	param->retry_count = cm_req_get_retry_count(req_msg);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 5e6dd00c6018..fc05a42e125d 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -70,19 +70,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline u8 cm_req_get_flow_ctrl(struct cm_req_msg *req_msg)
-{
-	return be32_to_cpu(req_msg->offset40) & 0x1;
-}
-
-static inline void cm_req_set_flow_ctrl(struct cm_req_msg *req_msg,
-					u8 flow_ctrl)
-{
-	req_msg->offset40 = cpu_to_be32((flow_ctrl & 0x1) |
-					 (be32_to_cpu(req_msg->offset40) &
-					  0xFFFFFFFE));
-}
-
 static inline __be32 cm_req_get_starting_psn(struct cm_req_msg *req_msg)
 {
 	return cpu_to_be32(be32_to_cpu(req_msg->offset44) >> 8);
-- 
2.20.1

