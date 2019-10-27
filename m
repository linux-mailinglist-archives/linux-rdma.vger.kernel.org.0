Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A18B6E615C
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfJ0HIu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:08:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HIu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:08:50 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D162220578;
        Sun, 27 Oct 2019 07:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160129;
        bh=eQLT6tcdC+M3RuGLUj9JzvVIzztohg+oXRZCLBhCJd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NN08vOrn5IvMW8SAwxKd7TorCxAUHm3mIE0DNqQf+YI91GL7MFITf7BOHgXRJGZEW
         V05LWMyAgInGpSme/lxYkkUlblKRBWEKkCSvk7fHSremFMhVe8jLmfA8aWkgD51Hi3
         kxhgfFSMvfhdropc+ZvqyQd5uV2dFKYCR3hEXnDQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 35/43] RDMA/cm: Convert REP failover accepted field
Date:   Sun, 27 Oct 2019 09:06:13 +0200
Message-Id: <20191027070621.11711-36-leon@kernel.org>
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

Update REP failover accepted field to the new scheme.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  4 ++--
 drivers/infiniband/core/cm_msgs.h | 11 -----------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 596be796f7bc..4b1f90ba4ec9 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2069,7 +2069,7 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 	rep_msg->resp_resources = param->responder_resources;
 	CM_SET(REP_TARGET_ACK_DELAY, rep_msg,
 	       cm_id_priv->av.port->cm_dev->ack_delay);
-	cm_rep_set_failover(rep_msg, param->failover_accepted);
+	CM_SET(REP_FAILOVER_ACCEPTED, rep_msg, param->failover_accepted);
 	cm_rep_set_rnr_retry_count(rep_msg, param->rnr_retry_count);
 	rep_msg->local_ca_guid = cm_id_priv->id.device->node_guid;
 
@@ -2223,7 +2223,7 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param->responder_resources = rep_msg->initiator_depth;
 	param->initiator_depth = rep_msg->resp_resources;
 	param->target_ack_delay = CM_GET(REP_TARGET_ACK_DELAY, rep_msg);
-	param->failover_accepted = cm_rep_get_failover(rep_msg);
+	param->failover_accepted = CM_GET(REP_FAILOVER_ACCEPTED, rep_msg);
 	param->flow_control = cm_rep_get_flow_ctrl(rep_msg);
 	param->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
 	param->srq = cm_rep_get_srq(rep_msg);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index a3207f984c32..fdc3cd9d2f88 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -462,17 +462,6 @@ struct cm_rep_msg {
 
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

