Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE1FE6151
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfJ0HIL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HIL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:08:11 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C13720578;
        Sun, 27 Oct 2019 07:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160090;
        bh=+LFg6Y6L+80I3AttvkfxnWpkD7Dsa1JoG8uHftfYi10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UDwnpTWgYgpX/BxFRtolx7asjV4lGKMo9JoBNLIb5OIsmTak6dSs36sOndXwm9xCo
         Tauo8cXNeCTUPP/MdFlD6XryVJvIPnO4iERkWNvbCXQg0bgbu+mMzVWxI14xAfgY2Z
         5mNLP3PIgv9AkW5evbI2qL3bxvjrHFfYDaOL312M=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 24/43] RDMA/cm: Convert REQ MAX CM retries
Date:   Sun, 27 Oct 2019 09:06:02 +0200
Message-Id: <20191027070621.11711-25-leon@kernel.org>
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

Convert REQ MAX CM retries to new scheme.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  4 ++--
 drivers/infiniband/core/cm_msgs.h | 11 -----------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 64b416e7f183..0450d75f8d53 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1290,7 +1290,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	       param->local_cm_response_timeout);
 	req_msg->pkey = param->primary_path->pkey;
 	CM_SET(REQ_PATH_PACKET_PAYLOAD_MTU, req_msg, param->primary_path->mtu);
-	cm_req_set_max_cm_retries(req_msg, param->max_cm_retries);
+	CM_SET(REQ_MAX_CM_RETRIES, req_msg, param->max_cm_retries);
 
 	if (param->qp_type != IB_QPT_XRC_INI) {
 		CM_SET(REQ_RESPONDED_RESOURCES, req_msg,
@@ -2028,7 +2028,7 @@ static int cm_req_handler(struct cm_work *work)
 	cm_id_priv->tid = req_msg->hdr.tid;
 	cm_id_priv->timeout_ms = cm_convert_to_ms(
 		CM_GET(REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg));
-	cm_id_priv->max_cm_retries = cm_req_get_max_cm_retries(req_msg);
+	cm_id_priv->max_cm_retries = CM_GET(REQ_MAX_CM_RETRIES, req_msg);
 	cm_id_priv->remote_qpn = CM_GET(REQ_LOCAL_QPN, req_msg);
 	cm_id_priv->initiator_depth = CM_GET(REQ_RESPONDED_RESOURCES, req_msg);
 	cm_id_priv->responder_resources = CM_GET(REQ_INITIATOR_DEPTH, req_msg);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 37e9bf512940..677b61a85e1f 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -400,17 +400,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline u8 cm_req_get_max_cm_retries(struct cm_req_msg *req_msg)
-{
-	return req_msg->offset51 >> 4;
-}
-
-static inline void cm_req_set_max_cm_retries(struct cm_req_msg *req_msg,
-					     u8 retries)
-{
-	req_msg->offset51 = (u8) ((req_msg->offset51 & 0xF) | (retries << 4));
-}
-
 static inline u8 cm_req_get_srq(struct cm_req_msg *req_msg)
 {
 	return (req_msg->offset51 & 0x8) >> 3;
-- 
2.20.1

