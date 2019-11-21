Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 742DD105948
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKUSPj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfKUSPj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:15:39 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1898D206CC;
        Thu, 21 Nov 2019 18:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360138;
        bh=dOmbbPy5eqEY8uq+xCGP7R8L5pYgsNAXl3fTRVuICks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V2cRxOLpVTD+Xnj6W5ohyMXel6XSNnZbebRaNsznKrBA/5gutYp9Oqs63iay8lmP2
         qEDu3SLEQgGLK+uTgjevFDlRuFW/xEN/42XO519i+18Lfdl8cn1svwuGurHwpvJ0jm
         k3a+izpaBm8i9/USbzK3mt4F6hgkTfWwYuAb6xsY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 41/48] RDMA/cm: Convert REP SRQ field
Date:   Thu, 21 Nov 2019 20:13:06 +0200
Message-Id: <20191121181313.129430-42-leon@kernel.org>
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

Convert REP SRQ field.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      |  6 +++---
 drivers/infiniband/core/cm_msgs.h | 11 -----------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 77199078d276..454650f3ec7d 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2077,10 +2077,10 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 		rep_msg->initiator_depth = param->initiator_depth;
 		IBA_SET(CM_REP_END_TO_END_FLOW_CONTROL, rep_msg,
 		       param->flow_control);
-		cm_rep_set_srq(rep_msg, param->srq);
+		IBA_SET(CM_REP_SRQ, rep_msg, param->srq);
 		IBA_SET(CM_REP_LOCAL_QPN, rep_msg, param->qp_num);
 	} else {
-		cm_rep_set_srq(rep_msg, 1);
+		IBA_SET(CM_REP_SRQ, rep_msg, 1);
 		IBA_SET(CM_REP_LOCAL_EE_CONTEXT_NUMBER, rep_msg, param->qp_num);
 	}
 
@@ -2230,7 +2230,7 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param->failover_accepted = IBA_GET(CM_REP_FAILOVER_ACCEPTED, rep_msg);
 	param->flow_control = IBA_GET(CM_REP_END_TO_END_FLOW_CONTROL, rep_msg);
 	param->rnr_retry_count = IBA_GET(CM_REP_RNR_RETRY_COUNT, rep_msg);
-	param->srq = cm_rep_get_srq(rep_msg);
+	param->srq = IBA_GET(CM_REP_SRQ, rep_msg);
 	work->cm_event.private_data = &rep_msg->private_data;
 	work->cm_event.private_data_len = CM_REP_PRIVATE_DATA_SIZE;
 }
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 209e19197693..cdd7e96e6355 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -132,17 +132,6 @@ struct cm_rep_msg {
 
 } __packed;
 
-static inline u8 cm_rep_get_srq(struct cm_rep_msg *rep_msg)
-{
-	return (u8) ((rep_msg->offset27 >> 4) & 0x1);
-}
-
-static inline void cm_rep_set_srq(struct cm_rep_msg *rep_msg, u8 srq)
-{
-	rep_msg->offset27 = (u8) ((rep_msg->offset27 & 0xEF) |
-				  ((srq & 0x1) << 4));
-}
-
 struct cm_rtu_msg {
 	struct ib_mad_hdr hdr;
 
-- 
2.20.1

