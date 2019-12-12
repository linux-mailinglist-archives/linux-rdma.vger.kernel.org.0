Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E825811C9A1
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfLLJlA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:41:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:41884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbfLLJky (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:40:54 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA24F2173E;
        Thu, 12 Dec 2019 09:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143654;
        bh=PtbjPcOwG9K2QireNN2IoOKfh/9B32K6y+mvcdupIwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4VGvTdNnYQRW6QERorsAQc1s58eGeMauuQ2wbMrIYbOYaOgFR4L/dTYFHRzd6uNM
         gUE3eyKMa2zaRiTjq/UxTYfQ6kx+/jdPiN1wXAEdoHlk/m/K5O6iVWnVsqAK4r/x2v
         qF88Gea5WPyb0f/CQswsaRzFqE5h2uHCK+fr5K2k=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 38/48] RDMA/cm: Convert REP failover accepted field
Date:   Thu, 12 Dec 2019 11:38:20 +0200
Message-Id: <20191212093830.316934-39-leon@kernel.org>
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

