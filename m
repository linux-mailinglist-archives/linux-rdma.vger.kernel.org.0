Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42CCF10593B
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKUSPO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:15:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUSPO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:15:14 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BB102068E;
        Thu, 21 Nov 2019 18:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360114;
        bh=ifNojsfKCtNpTk2w/LKvUybkISqNnunGuoNgrB38J7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z0HXECkIxOaqcVRY66KDswueF6bSrxTjk8eNXCCwas56IITj3aGMPv4Cw9thLNyAw
         mn7Ck71w9ZYMrC9pGyjwclMVIEqAK5sCCMbCKmctRczKEjjIUdRfgRZ9YXI1+uofoC
         67xQtLJVZpbQE3EIWFYbudYlvBjLVhIQ1d/fXEXs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 34/48] RDMA/cm: Convert MRA MRAed field
Date:   Thu, 21 Nov 2019 20:12:59 +0200
Message-Id: <20191121181313.129430-35-leon@kernel.org>
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

Convert MRA MRAed field.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 11 ++++++-----
 drivers/infiniband/core/cm_msgs.h | 10 ----------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index e25629a910f0..080c4411ae16 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1745,7 +1745,7 @@ static void cm_format_mra(struct cm_mra_msg *mra_msg,
 			  const void *private_data, u8 private_data_len)
 {
 	cm_format_mad_hdr(&mra_msg->hdr, CM_MRA_ATTR_ID, cm_id_priv->tid);
-	cm_mra_set_msg_mraed(mra_msg, msg_mraed);
+	IBA_SET(CM_MRA_MESSAGE_MRAED, mra_msg, msg_mraed);
 	mra_msg->local_comm_id = cm_id_priv->id.local_id;
 	mra_msg->remote_comm_id = cm_id_priv->id.remote_id;
 	cm_mra_set_service_timeout(mra_msg, service_timeout);
@@ -3010,7 +3010,7 @@ EXPORT_SYMBOL(ib_send_cm_mra);
 
 static struct cm_id_private * cm_acquire_mraed_id(struct cm_mra_msg *mra_msg)
 {
-	switch (cm_mra_get_msg_mraed(mra_msg)) {
+	switch (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg)) {
 	case CM_MSG_RESPONSE_REQ:
 		return cm_acquire_id(mra_msg->remote_comm_id, 0);
 	case CM_MSG_RESPONSE_REP:
@@ -3043,21 +3043,22 @@ static int cm_mra_handler(struct cm_work *work)
 	spin_lock_irq(&cm_id_priv->lock);
 	switch (cm_id_priv->id.state) {
 	case IB_CM_REQ_SENT:
-		if (cm_mra_get_msg_mraed(mra_msg) != CM_MSG_RESPONSE_REQ ||
+		if (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg) != CM_MSG_RESPONSE_REQ ||
 		    ib_modify_mad(cm_id_priv->av.port->mad_agent,
 				  cm_id_priv->msg, timeout))
 			goto out;
 		cm_id_priv->id.state = IB_CM_MRA_REQ_RCVD;
 		break;
 	case IB_CM_REP_SENT:
-		if (cm_mra_get_msg_mraed(mra_msg) != CM_MSG_RESPONSE_REP ||
+		if (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg) != CM_MSG_RESPONSE_REP ||
 		    ib_modify_mad(cm_id_priv->av.port->mad_agent,
 				  cm_id_priv->msg, timeout))
 			goto out;
 		cm_id_priv->id.state = IB_CM_MRA_REP_RCVD;
 		break;
 	case IB_CM_ESTABLISHED:
-		if (cm_mra_get_msg_mraed(mra_msg) != CM_MSG_RESPONSE_OTHER ||
+		if (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg) !=
+			    CM_MSG_RESPONSE_OTHER ||
 		    cm_id_priv->id.lap_state != IB_CM_LAP_SENT ||
 		    ib_modify_mad(cm_id_priv->av.port->mad_agent,
 				  cm_id_priv->msg, timeout)) {
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 6f52a8f0bee3..e096b1f572bc 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -91,16 +91,6 @@ enum cm_msg_response {
 
 } __packed;
 
-static inline u8 cm_mra_get_msg_mraed(struct cm_mra_msg *mra_msg)
-{
-	return (u8) (mra_msg->offset8 >> 6);
-}
-
-static inline void cm_mra_set_msg_mraed(struct cm_mra_msg *mra_msg, u8 msg)
-{
-	mra_msg->offset8 = (u8) ((mra_msg->offset8 & 0x3F) | (msg << 6));
-}
-
 static inline u8 cm_mra_get_service_timeout(struct cm_mra_msg *mra_msg)
 {
 	return (u8) (mra_msg->offset9 >> 3);
-- 
2.20.1

