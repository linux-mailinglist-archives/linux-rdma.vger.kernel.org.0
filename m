Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04D03402AC
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Mar 2021 11:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhCRKDs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Mar 2021 06:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhCRKDX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Mar 2021 06:03:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08A2864F3B;
        Thu, 18 Mar 2021 10:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616061802;
        bh=nKXaFG7CEQgPbr9HmwcqAETQPyqHa3890qAzEWorSeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YI6u+6Z8z1VX67Ir2vN1NJSsIrkWYuPYDo74snjdVXPAYczltHl92FpcPkdG/nUYJ
         vThUDuGjPgtThYvtDqILrFuRZE9msNb5lI1PvjhrMqyi7JO/Qr155vCMkLfVVb6KWK
         wbB03orXJjSm3u89xpiky+wFWqI1G/3yfLHNSO4rZ1KwopP8PNdrNjEavlsm1u71Pp
         w+LrLpzvqiS408JA9I5MjpZS3PXEOTWIHxbcLPPVYCRe3WK0pD33JwMJE6ZuwZPOZh
         79Pw9pMY/pbbgrw56ygRQQOvuW4ZFN//5SP5lo906mlXsYSYmoti36+Ry/6jcSb2/s
         sLugFKXAZJsRg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 3/6] IB/cm: Remove "mad_agent" parameter of ib_modify_mad
Date:   Thu, 18 Mar 2021 12:03:06 +0200
Message-Id: <20210318100309.670344-4-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318100309.670344-1-leon@kernel.org>
References: <20210318100309.670344-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

The mad_agent parameter is redundant since the struct ib_mad_send_buf
already has a pointer of it.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c  | 29 +++++++++++++++++++++--------
 drivers/infiniband/core/mad.c | 10 ++++++----
 include/rdma/ib_mad.h         |  6 ++----
 3 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 2cee5352c620..d481ebd281e1 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3128,16 +3128,14 @@ static int cm_mra_handler(struct cm_work *work)
 	case IB_CM_REQ_SENT:
 		if (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg) !=
 			    CM_MSG_RESPONSE_REQ ||
-		    ib_modify_mad(cm_id_priv->av.port->mad_agent,
-				  cm_id_priv->msg, timeout))
+		    ib_modify_mad(cm_id_priv->msg, timeout))
 			goto out;
 		cm_id_priv->id.state = IB_CM_MRA_REQ_RCVD;
 		break;
 	case IB_CM_REP_SENT:
 		if (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg) !=
 			    CM_MSG_RESPONSE_REP ||
-		    ib_modify_mad(cm_id_priv->av.port->mad_agent,
-				  cm_id_priv->msg, timeout))
+		    ib_modify_mad(cm_id_priv->msg, timeout))
 			goto out;
 		cm_id_priv->id.state = IB_CM_MRA_REP_RCVD;
 		break;
@@ -3145,8 +3143,7 @@ static int cm_mra_handler(struct cm_work *work)
 		if (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg) !=
 			    CM_MSG_RESPONSE_OTHER ||
 		    cm_id_priv->id.lap_state != IB_CM_LAP_SENT ||
-		    ib_modify_mad(cm_id_priv->av.port->mad_agent,
-				  cm_id_priv->msg, timeout)) {
+		    ib_modify_mad(cm_id_priv->msg, timeout)) {
 			if (cm_id_priv->id.lap_state == IB_CM_MRA_LAP_RCVD)
 				atomic_long_inc(&work->port->
 						counter_group[CM_RECV_DUPLICATES].
@@ -3737,6 +3734,22 @@ static void cm_process_send_error(struct ib_mad_send_buf *msg,
 	cm_free_msg(msg);
 }
 
+static void cm_send_free_msg(struct ib_mad_send_buf *msg)
+{
+	struct cm_id_private *cm_id_priv;
+
+	cm_id_priv = msg->context[0];
+	if (!cm_id_priv || cm_id_priv->msg != msg) {
+		cm_free_msg(msg);
+		return;
+	}
+
+	spin_lock_irq(&cm_id_priv->lock);
+	cm_free_msg(msg);
+	cm_id_priv->msg = NULL;
+	spin_unlock_irq(&cm_id_priv->lock);
+}
+
 static void cm_send_handler(struct ib_mad_agent *mad_agent,
 			    struct ib_mad_send_wc *mad_send_wc)
 {
@@ -3766,13 +3779,13 @@ static void cm_send_handler(struct ib_mad_agent *mad_agent,
 	switch (mad_send_wc->status) {
 	case IB_WC_SUCCESS:
 	case IB_WC_WR_FLUSH_ERR:
-		cm_free_msg(msg);
+		cm_send_free_msg(msg);
 		break;
 	default:
 		if (msg->context[0] && msg->context[1])
 			cm_process_send_error(msg, mad_send_wc->status);
 		else
-			cm_free_msg(msg);
+			cm_send_free_msg(msg);
 		break;
 	}
 }
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 31a97cf1ef81..e7ff4420777e 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2464,16 +2464,18 @@ find_send_wr(struct ib_mad_agent_private *mad_agent_priv,
 	return NULL;
 }
 
-int ib_modify_mad(struct ib_mad_agent *mad_agent,
-		  struct ib_mad_send_buf *send_buf, u32 timeout_ms)
+int ib_modify_mad(struct ib_mad_send_buf *send_buf, u32 timeout_ms)
 {
 	struct ib_mad_agent_private *mad_agent_priv;
 	struct ib_mad_send_wr_private *mad_send_wr;
 	unsigned long flags;
 	int active;
 
-	mad_agent_priv = container_of(mad_agent, struct ib_mad_agent_private,
-				      agent);
+	if (!send_buf)
+		return -EINVAL;
+
+	mad_agent_priv = container_of(send_buf->mad_agent,
+				      struct ib_mad_agent_private, agent);
 	spin_lock_irqsave(&mad_agent_priv->lock, flags);
 	mad_send_wr = find_send_wr(mad_agent_priv, send_buf);
 	if (!mad_send_wr || mad_send_wr->status != IB_WC_SUCCESS) {
diff --git a/include/rdma/ib_mad.h b/include/rdma/ib_mad.h
index 69b824dc7820..465b0d0bdaf8 100644
--- a/include/rdma/ib_mad.h
+++ b/include/rdma/ib_mad.h
@@ -719,15 +719,13 @@ void ib_free_recv_mad(struct ib_mad_recv_wc *mad_recv_wc);
 
 /**
  * ib_modify_mad - Modifies an outstanding send MAD operation.
- * @mad_agent: Specifies the registration associated with sent MAD.
  * @send_buf: Indicates the MAD to modify.
  * @timeout_ms: New timeout value for sent MAD.
  *
  * This call will reset the timeout value for a sent MAD to the specified
  * value.
  */
-int ib_modify_mad(struct ib_mad_agent *mad_agent,
-		  struct ib_mad_send_buf *send_buf, u32 timeout_ms);
+int ib_modify_mad(struct ib_mad_send_buf *send_buf, u32 timeout_ms);
 
 /**
  * ib_cancel_mad - Cancels an outstanding send MAD operation.
@@ -738,7 +736,7 @@ int ib_modify_mad(struct ib_mad_agent *mad_agent,
  */
 static inline void ib_cancel_mad(struct ib_mad_send_buf *send_buf)
 {
-	ib_modify_mad(send_buf->mad_agent, send_buf, 0);
+	ib_modify_mad(send_buf, 0);
 }
 
 /**
-- 
2.30.2

