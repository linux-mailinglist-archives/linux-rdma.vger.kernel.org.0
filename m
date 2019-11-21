Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E172F10592A
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfKUSO0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:14:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUSO0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:14:26 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49941206CB;
        Thu, 21 Nov 2019 18:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360064;
        bh=/hI0qvoQZqSwGz4lSCnw2joMweNIw+eAqLivtUx6nWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JBhB5ZRXgx+6Gp45AncxOMY8W8pay4TH8p4RHj6SMgbE1Km3NxGddXiNiWRIefCGC
         oxHnnDJA+dAmfUDWNCEX4vS7svmpuuDHiCSHMfl2+lhKp1GSJOnfPtelbUBcNJLKzu
         7xPUX+iSk97P79PDF2rb+8NsqrZQsAsgT7Lyroow=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 20/48] RDMA/cm: Simplify QP type to wire protocol translation
Date:   Thu, 21 Nov 2019 20:12:45 +0200
Message-Id: <20191121181313.129430-21-leon@kernel.org>
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

Simplify QP type to/from wire protocol logic and move it to be near
implementation and not in header file.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 25 +++++++++++++++++++++
 drivers/infiniband/core/cm_msgs.h | 37 -------------------------------
 2 files changed, 25 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 34654aba638e..f7ed4067743f 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1247,6 +1247,20 @@ static void cm_format_mad_hdr(struct ib_mad_hdr *hdr,
 	hdr->tid	   = tid;
 }
 
+static void cm_req_set_qp_type(struct cm_req_msg *req_msg,
+			       enum ib_qp_type qp_type)
+{
+	static const u8 qp_types[IB_QPT_MAX] = {
+		[IB_QPT_UC] = 1,
+		[IB_QPT_XRC_INI] = 3,
+	};
+
+	if (qp_type == IB_QPT_XRC_INI)
+		IBA_SET(CM_REQ_EXTENDED_TRANSPORT_TYPE, req_msg, 0x1);
+
+	IBA_SET(CM_REQ_TRANSPORT_SERVICE_TYPE, req_msg, qp_types[qp_type]);
+}
+
 static void cm_format_req(struct cm_req_msg *req_msg,
 			  struct cm_id_private *cm_id_priv,
 			  struct ib_cm_req_param *param)
@@ -1645,6 +1659,17 @@ static void cm_opa_to_ib_sgid(struct cm_work *work,
 	}
 }
 
+static enum ib_qp_type cm_req_get_qp_type(struct cm_req_msg *req_msg)
+{
+	static const enum ib_qp_type qp_type[] = { IB_QPT_RC, IB_QPT_UC, 0, 0 };
+	u8 transport_type = IBA_GET(CM_REQ_TRANSPORT_SERVICE_TYPE, req_msg);
+
+	if (transport_type == 3 &&
+	    (IBA_GET(CM_REQ_EXTENDED_TRANSPORT_TYPE, req_msg) == 1))
+		return IB_QPT_XRC_TGT;
+	return qp_type[transport_type];
+}
+
 static void cm_format_req_event(struct cm_work *work,
 				struct cm_id_private *cm_id_priv,
 				struct ib_cm_id *listen_id)
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index c348521040a6..5e6dd00c6018 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -70,43 +70,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline enum ib_qp_type cm_req_get_qp_type(struct cm_req_msg *req_msg)
-{
-	u8 transport_type = (u8) (be32_to_cpu(req_msg->offset40) & 0x06) >> 1;
-	switch(transport_type) {
-	case 0: return IB_QPT_RC;
-	case 1: return IB_QPT_UC;
-	case 3:
-		switch (req_msg->offset51 & 0x7) {
-		case 1: return IB_QPT_XRC_TGT;
-		default: return 0;
-		}
-	default: return 0;
-	}
-}
-
-static inline void cm_req_set_qp_type(struct cm_req_msg *req_msg,
-				      enum ib_qp_type qp_type)
-{
-	switch(qp_type) {
-	case IB_QPT_UC:
-		req_msg->offset40 = cpu_to_be32((be32_to_cpu(
-						  req_msg->offset40) &
-						   0xFFFFFFF9) | 0x2);
-		break;
-	case IB_QPT_XRC_INI:
-		req_msg->offset40 = cpu_to_be32((be32_to_cpu(
-						 req_msg->offset40) &
-						   0xFFFFFFF9) | 0x6);
-		req_msg->offset51 = (req_msg->offset51 & 0xF8) | 1;
-		break;
-	default:
-		req_msg->offset40 = cpu_to_be32(be32_to_cpu(
-						 req_msg->offset40) &
-						  0xFFFFFFF9);
-	}
-}
-
 static inline u8 cm_req_get_flow_ctrl(struct cm_req_msg *req_msg)
 {
 	return be32_to_cpu(req_msg->offset40) & 0x1;
-- 
2.20.1

