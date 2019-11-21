Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69B24105954
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfKUSQE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:16:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbfKUSQE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:16:04 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB0572068E;
        Thu, 21 Nov 2019 18:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360163;
        bh=wG5L5HwOMqAAZB33ZsvjvACS6eOQQVhwkmSzp6LIuJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HbvoUSlHmytgNLYS/gGsj0uVxYfWvNbC1SjlYkAiyzwvylUga8Xm3Vp0YocVbobiG
         mAKiH46NPzohcWm67awXyKoHl77ZR4b0cJ0BJk2Dm2O4Egh97tS+VXXKkoG39w3jUN
         dUN4klIEZcAyl3eWsoJU+NVwz3GmV8me38YGipLk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 48/48] RDMA/cm: Convert private_date access
Date:   Thu, 21 Nov 2019 20:13:13 +0200
Message-Id: <20191121181313.129430-49-leon@kernel.org>
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

Reuse existing IBA accessors to set private data.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 43 +++++++++++++++---------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index f197f9740362..d42a3887057b 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1366,9 +1366,8 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 				      alt_path->packet_life_time));
 	}
 
-	if (param->private_data && param->private_data_len)
-		memcpy(req_msg->private_data, param->private_data,
-		       param->private_data_len);
+	IBA_SET_MEM(CM_REQ_PRIVATE_DATA, req_msg, param->private_data,
+		    param->private_data_len);
 }
 
 static int cm_validate_req_param(struct ib_cm_req_param *param)
@@ -1750,8 +1749,8 @@ static void cm_format_mra(struct cm_mra_msg *mra_msg,
 	mra_msg->remote_comm_id = cm_id_priv->id.remote_id;
 	IBA_SET(CM_MRA_SERVICE_TIMEOUT, mra_msg, service_timeout);
 
-	if (private_data && private_data_len)
-		memcpy(mra_msg->private_data, private_data, private_data_len);
+	IBA_SET_MEM(CM_MRA_PRIVATE_DATA, mra_msg, private_data,
+		    private_data_len);
 }
 
 static void cm_format_rej(struct cm_rej_msg *rej_msg,
@@ -1791,8 +1790,8 @@ static void cm_format_rej(struct cm_rej_msg *rej_msg,
 		memcpy(rej_msg->ari, ari, ari_length);
 	}
 
-	if (private_data && private_data_len)
-		memcpy(rej_msg->private_data, private_data, private_data_len);
+	IBA_SET_MEM(CM_REJ_PRIVATE_DATA, rej_msg, private_data,
+		    private_data_len);
 }
 
 static void cm_dup_req_handler(struct cm_work *work,
@@ -2084,9 +2083,8 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 		IBA_SET(CM_REP_LOCAL_EE_CONTEXT_NUMBER, rep_msg, param->qp_num);
 	}
 
-	if (param->private_data && param->private_data_len)
-		memcpy(rep_msg->private_data, param->private_data,
-		       param->private_data_len);
+	IBA_SET_MEM(CM_REP_PRIVATE_DATA, rep_msg, param->private_data,
+		    param->private_data_len);
 }
 
 int ib_send_cm_rep(struct ib_cm_id *cm_id,
@@ -2152,8 +2150,8 @@ static void cm_format_rtu(struct cm_rtu_msg *rtu_msg,
 	rtu_msg->local_comm_id = cm_id_priv->id.local_id;
 	rtu_msg->remote_comm_id = cm_id_priv->id.remote_id;
 
-	if (private_data && private_data_len)
-		memcpy(rtu_msg->private_data, private_data, private_data_len);
+	IBA_SET_MEM(CM_RTU_PRIVATE_DATA, rtu_msg, private_data,
+		    private_data_len);
 }
 
 int ib_send_cm_rtu(struct ib_cm_id *cm_id,
@@ -2482,9 +2480,8 @@ static void cm_format_dreq(struct cm_dreq_msg *dreq_msg,
 	dreq_msg->local_comm_id = cm_id_priv->id.local_id;
 	dreq_msg->remote_comm_id = cm_id_priv->id.remote_id;
 	IBA_SET(CM_DREQ_REMOTE_QPN_EECN, dreq_msg, cm_id_priv->remote_qpn);
-
-	if (private_data && private_data_len)
-		memcpy(dreq_msg->private_data, private_data, private_data_len);
+	IBA_SET_MEM(CM_DREQ_PRIVATE_DATA, dreq_msg, private_data,
+		    private_data_len);
 }
 
 int ib_send_cm_dreq(struct ib_cm_id *cm_id,
@@ -2546,9 +2543,8 @@ static void cm_format_drep(struct cm_drep_msg *drep_msg,
 	cm_format_mad_hdr(&drep_msg->hdr, CM_DREP_ATTR_ID, cm_id_priv->tid);
 	drep_msg->local_comm_id = cm_id_priv->id.local_id;
 	drep_msg->remote_comm_id = cm_id_priv->id.remote_id;
-
-	if (private_data && private_data_len)
-		memcpy(drep_msg->private_data, private_data, private_data_len);
+	IBA_SET_MEM(CM_DREP_PRIVATE_DATA, drep_msg, private_data,
+		    private_data_len);
 }
 
 int ib_send_cm_drep(struct ib_cm_id *cm_id,
@@ -3487,13 +3483,10 @@ static void cm_format_sidr_rep(struct cm_sidr_rep_msg *sidr_rep_msg,
 	IBA_SET(CM_SIDR_REP_QPN, sidr_rep_msg, param->qp_num);
 	sidr_rep_msg->service_id = cm_id_priv->id.service_id;
 	IBA_SET(CM_SIDR_REP_Q_KEY, sidr_rep_msg, param->qkey);
-
-	if (param->info && param->info_length)
-		memcpy(sidr_rep_msg->info, param->info, param->info_length);
-
-	if (param->private_data && param->private_data_len)
-		memcpy(sidr_rep_msg->private_data, param->private_data,
-		       param->private_data_len);
+	IBA_SET_MEM(CM_SIDR_REP_ADDITIONAL_INFORMATION, sidr_rep_msg,
+		    param->info, param->info_length);
+	IBA_SET_MEM(CM_SIDR_REP_PRIVATE_DATA, sidr_rep_msg, param->private_data,
+		    param->private_data_len);
 }
 
 int ib_send_cm_sidr_rep(struct ib_cm_id *cm_id,
-- 
2.20.1

