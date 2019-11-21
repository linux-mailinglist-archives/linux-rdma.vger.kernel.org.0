Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63A3F10593F
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKUSP2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:15:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUSP2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:15:28 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8319B2068E;
        Thu, 21 Nov 2019 18:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360128;
        bh=PtbjPcOwG9K2QireNN2IoOKfh/9B32K6y+mvcdupIwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iTAWP1eYysYv1wCpcV6qZL4HECtfRG2DIdt/6+gud6aX0APYRYzyB4SJyL1BF/WGg
         jf6frRWK52WV71WFwv+ZNw9/r6XJ0HkDxgJOakwCtLbsLG6qwVJgfn37U/LxWJ5xUT
         NCZTpXXDZhRgOX0v/DuYMJzehvWsaPBm3lRHDLII=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 38/48] RDMA/cm: Convert REP failover accepted field
Date:   Thu, 21 Nov 2019 20:13:03 +0200
Message-Id: <20191121181313.129430-39-leon@kernel.org>
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

Update REP failover accepted field to the new scheme.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  4 ++--
 drivers/infiniband/core/cm_msgs.h | 11 -----------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index ca2d50a3c7da..23e2c54d51dd 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2069,7 +2069,7 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 	rep_msg->resp_resources = param->responder_resources;
 	IBA_SET(CM_REP_TARGET_ACK_DELAY, rep_msg,
 	       cm_id_priv->av.port->cm_dev->ack_delay);
-	cm_rep_set_failover(rep_msg, param->failover_accepted);
+	IBA_SET(CM_REP_FAILOVER_ACCEPTED, rep_msg, param->failover_accepted);
 	cm_rep_set_rnr_retry_count(rep_msg, param->rnr_retry_count);
 	rep_msg->local_ca_guid = cm_id_priv->id.device->node_guid;
 
@@ -2226,7 +2226,7 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param->responder_resources = rep_msg->initiator_depth;
 	param->initiator_depth = rep_msg->resp_resources;
 	param->target_ack_delay = IBA_GET(CM_REP_TARGET_ACK_DELAY, rep_msg);
-	param->failover_accepted = cm_rep_get_failover(rep_msg);
+	param->failover_accepted = IBA_GET(CM_REP_FAILOVER_ACCEPTED, rep_msg);
 	param->flow_control = cm_rep_get_flow_ctrl(rep_msg);
 	param->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
 	param->srq = cm_rep_get_srq(rep_msg);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 0536f827fd8e..566bc868e120 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -132,17 +132,6 @@ struct cm_rep_msg {
 
 } __packed;
 
-static inline u8 cm_rep_get_failover(struct cm_rep_msg *rep_msg)
-{
-	return (u8) ((rep_msg->offset26 & 0x06) >> 1);
-}
-
-static inline void cm_rep_set_failover(struct cm_rep_msg *rep_msg, u8 failover)
-{
-	rep_msg->offset26 = (u8) ((rep_msg->offset26 & 0xF9) |
-				  ((failover & 0x3) << 1));
-}
-
 static inline u8 cm_rep_get_flow_ctrl(struct cm_rep_msg *rep_msg)
 {
 	return (u8) (rep_msg->offset26 & 0x01);
-- 
2.20.1

