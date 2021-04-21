Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A89366A05
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 13:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbhDULlg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 07:41:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237751AbhDULlg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Apr 2021 07:41:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 725EF61445;
        Wed, 21 Apr 2021 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619005263;
        bh=8am32TTFLzbfknKCaTS2cLsZ8tabibm6/ytz0lZhm6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rOA3/QlO4grnRqQixxyy256JZwHfIQAUwjgeNyoAk1vx1FyD6fZO9eUEqWqHukxOQ
         kciR+RGe8j54AVmZ+slI60YLK2D5BadQ1F/o8hadh08hmJWdns5ee8S+Fuem10+cIW
         rWR5OWHXEfkeB5cUoRCmYQvfYdtpfpVEN/B0KG4uwe95M3jiorJU7kj1hLKrmnVd9y
         3TYjsE8YNPPGjQ16gO8PHjSVOyQwMShGpiqk83suBRnxyBfG8PCPS9Lnv8AQkcFrEa
         FQqSBqkqVcdqGxiRp5gTbeBHh1b9vMaMw/+VHpiJUkjCotx0RLoqAo2h3siKx0aa3J
         RacjN1reqzpgw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 3/9] IB/cm: Call the correct message free functions in cm_send_handler()
Date:   Wed, 21 Apr 2021 14:40:33 +0300
Message-Id: <6438dcc0d26e2d46fae28a6dee0f7bfa68de1eff.1619004798.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619004798.git.leonro@nvidia.com>
References: <cover.1619004798.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

There are now three destroy functions for the cm_msg, and all places
except the general send completion handler use the correct function.

Fix cm_send_handler() to detect which kind of message is being completed
and destroy it using the correct function with the correct locking.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 52 +++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 94613275edcc..8dbc39ea4612 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3795,22 +3795,26 @@ static int cm_sidr_rep_handler(struct cm_work *work)
 	return -EINVAL;
 }
 
-static void cm_process_send_error(struct ib_mad_send_buf *msg,
+static void cm_process_send_error(struct cm_id_private *cm_id_priv,
+				  struct ib_mad_send_buf *msg,
+				  enum ib_cm_state state,
 				  enum ib_wc_status wc_status)
 {
-	struct cm_id_private *cm_id_priv;
-	struct ib_cm_event cm_event;
-	enum ib_cm_state state;
+	struct ib_cm_event cm_event = {};
 	int ret;
 
-	memset(&cm_event, 0, sizeof cm_event);
-	cm_id_priv = msg->context[0];
-
 	/* Discard old sends or ones without a response. */
 	spin_lock_irq(&cm_id_priv->lock);
-	state = (enum ib_cm_state) (unsigned long) msg->context[1];
-	if (msg != cm_id_priv->msg || state != cm_id_priv->id.state)
-		goto discard;
+	if (msg != cm_id_priv->msg) {
+		spin_unlock_irq(&cm_id_priv->lock);
+		cm_free_msg(msg);
+		return;
+	}
+	cm_free_priv_msg(msg);
+
+	if (state != cm_id_priv->id.state || wc_status == IB_WC_SUCCESS ||
+	    wc_status == IB_WC_WR_FLUSH_ERR)
+		goto out_unlock;
 
 	trace_icm_mad_send_err(state, wc_status);
 	switch (state) {
@@ -3833,26 +3837,27 @@ static void cm_process_send_error(struct ib_mad_send_buf *msg,
 		cm_event.event = IB_CM_SIDR_REQ_ERROR;
 		break;
 	default:
-		goto discard;
+		goto out_unlock;
 	}
 	spin_unlock_irq(&cm_id_priv->lock);
 	cm_event.param.send_status = wc_status;
 
 	/* No other events can occur on the cm_id at this point. */
 	ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, &cm_event);
-	cm_free_msg(msg);
 	if (ret)
 		ib_destroy_cm_id(&cm_id_priv->id);
 	return;
-discard:
+out_unlock:
 	spin_unlock_irq(&cm_id_priv->lock);
-	cm_free_msg(msg);
 }
 
 static void cm_send_handler(struct ib_mad_agent *mad_agent,
 			    struct ib_mad_send_wc *mad_send_wc)
 {
 	struct ib_mad_send_buf *msg = mad_send_wc->send_buf;
+	struct cm_id_private *cm_id_priv = msg->context[0];
+	enum ib_cm_state state =
+		(enum ib_cm_state)(unsigned long)msg->context[1];
 	struct cm_port *port;
 	u16 attr_index;
 
@@ -3865,7 +3870,7 @@ static void cm_send_handler(struct ib_mad_agent *mad_agent,
 	 * set to a cm_id), and is not a REJ, then it is a send that was
 	 * manually retried.
 	 */
-	if (!msg->context[0] && (attr_index != CM_REJ_COUNTER))
+	if (!cm_id_priv && (attr_index != CM_REJ_COUNTER))
 		msg->retries = 1;
 
 	atomic_long_add(1 + msg->retries,
@@ -3875,18 +3880,11 @@ static void cm_send_handler(struct ib_mad_agent *mad_agent,
 				&port->counter_group[CM_XMIT_RETRIES].
 				counter[attr_index]);
 
-	switch (mad_send_wc->status) {
-	case IB_WC_SUCCESS:
-	case IB_WC_WR_FLUSH_ERR:
-		cm_free_msg(msg);
-		break;
-	default:
-		if (msg->context[0] && msg->context[1])
-			cm_process_send_error(msg, mad_send_wc->status);
-		else
-			cm_free_msg(msg);
-		break;
-	}
+	if (cm_id_priv)
+		cm_process_send_error(cm_id_priv, msg, state,
+				      mad_send_wc->status);
+	else
+		cm_free_response_msg(msg);
 }
 
 static void cm_work_handler(struct work_struct *_work)
-- 
2.30.2

