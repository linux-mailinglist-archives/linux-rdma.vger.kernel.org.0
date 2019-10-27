Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87DEEE614B
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfJ0HHu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HHt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:07:49 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DD7A20578;
        Sun, 27 Oct 2019 07:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160069;
        bh=NHeoiD2v4BdbVujpzbtvJAde0EU+EdfCsi4ifOx5aZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ewBBtWwry+7sWFuVGhUG3jYYPCPyp/Z9hdQAecM9Oh/zXJIXSHiz7t7tLoLtjP0PV
         UWBBwzp9XKmWZzpT/c2OzGtVR8520U3GURSqaoKRTJwtlDKB3lOT3DYnmRgPh0pgD/
         htoaAdu+sUnz8osKgGAL9KWmjXrFrizvuKvx4G4o=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 18/43] RDMA/cm: Convert REQ flow control
Date:   Sun, 27 Oct 2019 09:05:56 +0200
Message-Id: <20191027070621.11711-19-leon@kernel.org>
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

Use CM_GET/CM_SET for REQ flow control field.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  4 ++--
 drivers/infiniband/core/cm_msgs.h | 13 -------------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 17954b71cf09..3e2eb096b2f9 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1284,7 +1284,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	CM_SET(REQ_REMOTE_CM_RESPONSE_TIMEOUT, req_msg,
 	       param->remote_cm_response_timeout);
 	cm_req_set_qp_type(req_msg, param->qp_type);
-	cm_req_set_flow_ctrl(req_msg, param->flow_control);
+	CM_SET(REQ_END_TO_END_FLOW_CONTROL, req_msg, param->flow_control);
 	cm_req_set_starting_psn(req_msg, cpu_to_be32(param->starting_psn));
 	cm_req_set_local_resp_timeout(req_msg,
 				      param->local_cm_response_timeout);
@@ -1699,7 +1699,7 @@ static void cm_format_req_event(struct cm_work *work,
 	param->initiator_depth = CM_GET(REQ_RESPONDED_RESOURCES, req_msg);
 	param->local_cm_response_timeout =
 		CM_GET(REQ_REMOTE_CM_RESPONSE_TIMEOUT, req_msg);
-	param->flow_control = cm_req_get_flow_ctrl(req_msg);
+	param->flow_control = CM_GET(REQ_END_TO_END_FLOW_CONTROL, req_msg);
 	param->remote_cm_response_timeout =
 					cm_req_get_local_resp_timeout(req_msg);
 	param->retry_count = cm_req_get_retry_count(req_msg);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index e073308dad09..538ce42b97c3 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -400,19 +400,6 @@ struct cm_req_msg {
 
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

