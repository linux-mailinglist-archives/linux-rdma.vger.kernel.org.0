Return-Path: <linux-rdma+bounces-5957-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1EC9C6D87
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2024 12:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC6E3B26443
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2024 11:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E86D1FF60B;
	Wed, 13 Nov 2024 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdjdkxGw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB641FB728
	for <linux-rdma@vger.kernel.org>; Wed, 13 Nov 2024 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496389; cv=none; b=Owg1KngXjyvOsFkmEhrY9xsaGTCsTxuMgkP2MI4k9VmMZmD95laKma2F9x/sG1lH1Vx1/tBh2pge4cB6ALlm8TuGIRPYnT8QhGrZpwo/dLUAuACsU1hsX8yVUjO2HgBsZRzfPsTmUD7SykEl96W785isDiMUWcTb+/prvjRYtZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496389; c=relaxed/simple;
	bh=6dvjD1//nGuOZz9I0P9SdrrU0dEiF2LEG8t73pnIj0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8Gj/Awu3/DN2JgzCcjNnxBqEsTP48y9GwUhrTtoBWOyOl1JhxhuSXbZ/zrCvNPiEYGClxmdmxEZJeQgSuJNdALDIMFdOJ64f3fG+T2v3NHlv5nnZtosXhH9WMBJZ9tZ5/DDg3frbR8qErrZLAOSrDF9pEI3+fXVNF4VQgu3ttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdjdkxGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76ECC4CECD;
	Wed, 13 Nov 2024 11:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731496389;
	bh=6dvjD1//nGuOZz9I0P9SdrrU0dEiF2LEG8t73pnIj0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OdjdkxGwIaVZlGVz0xshv1nz0KSQnhp3/kKnP9LOaB05KkRqIUEkvfWujz1PQWoiv
	 s76K1bpQsKlTObOu1L+E4wiGm1BTQFKle4EJ01F+PCwxEDj2YbED79lPNOcXAUPH7G
	 dy5dRly1rn0KBet5lFSepMP7Sn7qEbTkupd0/88ys6HUF47fGqDRt42KTW1B+3gZ6g
	 h8usKFUJEskQrnwFMwIUwN0xo3kt1U4zvb8VRiPdIqJO3layNR8Kl3Izf1Tm8mQwhi
	 09ewev5Z87RE27vsrQaPIRfy3Fk74nxT54C8S+mqlJ/UfW9XiEsuPId7FCuIzZQwMh
	 BRbpfOyDFfXOA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Sean Hefty <shefty@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Or Har-Toov <ohartoov@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: [PATCH rdma-next 1/3] IB/cm: Explicitly mark if a response MAD is a retransmission
Date: Wed, 13 Nov 2024 13:12:54 +0200
Message-ID: <1ee6e2a68f8de1992b9da23aa1d7e3f9f25e0036.1731495873.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731495873.git.leon@kernel.org>
References: <cover.1731495873.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Hefty <shefty@nvidia.com>

In several situations the CM may send a reply to a received MAD
without the reply being directly linked with a cm_id.  For
example, it may send a REJ in response to a REQ which does not
match a listener.  Or, it may send a DREP in response to a DREQ
if the cm_id has already been destroyed.  This can happen if the
original DREP was lost and the DREQ was retried.

When such a response MAD completes, it updates a counter tracking
how many MADs were retried.  However, not all response MADs issued
directly by the CM may be retries.  The REJ mentioned in the example
above is such a case.  To distinguish between responses which were
retries versus those that are not, the send_handler performs the
following check: is a retry if the response is not associated with
a cm_id and the response is not a REJ message.

Replace this indirect method of checking if a response is a retry
with an explicit check.  Note that these retries are generated
directly by the CM, rather than retried by the MAD layer.

This change will be needed by later changes which would otherwise
break the indirect check.

Signed-off-by: Sean Hefty <shefty@nvidia.com>
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 51 ++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 07fb8d3c037f..99246e49dd3a 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -35,6 +35,8 @@ MODULE_DESCRIPTION("InfiniBand CM");
 MODULE_LICENSE("Dual BSD/GPL");
 
 #define CM_DESTROY_ID_WAIT_TIMEOUT 10000 /* msecs */
+#define CM_DIRECT_RETRY_CTX ((void *) 1UL)
+
 static const char * const ibcm_rej_reason_strs[] = {
 	[IB_CM_REJ_NO_QP]			= "no QP",
 	[IB_CM_REJ_NO_EEC]			= "no EEC",
@@ -358,13 +360,20 @@ static void cm_free_priv_msg(struct ib_mad_send_buf *msg)
 	ib_free_send_mad(msg);
 }
 
-static struct ib_mad_send_buf *cm_alloc_response_msg_no_ah(struct cm_port *port,
-							   struct ib_mad_recv_wc *mad_recv_wc)
+static struct ib_mad_send_buf *
+cm_alloc_response_msg_no_ah(struct cm_port *port,
+			    struct ib_mad_recv_wc *mad_recv_wc,
+			    bool direct_retry)
 {
-	return ib_create_send_mad(port->mad_agent, 1, mad_recv_wc->wc->pkey_index,
-				  0, IB_MGMT_MAD_HDR, IB_MGMT_MAD_DATA,
-				  GFP_ATOMIC,
-				  IB_MGMT_BASE_VERSION);
+	struct ib_mad_send_buf *m;
+
+	m = ib_create_send_mad(port->mad_agent, 1, mad_recv_wc->wc->pkey_index,
+			       0, IB_MGMT_MAD_HDR, IB_MGMT_MAD_DATA,
+			       GFP_ATOMIC, IB_MGMT_BASE_VERSION);
+	if (!IS_ERR(m))
+		m->context[0] = direct_retry ? CM_DIRECT_RETRY_CTX : NULL;
+
+	return m;
 }
 
 static int cm_create_response_msg_ah(struct cm_port *port,
@@ -384,12 +393,13 @@ static int cm_create_response_msg_ah(struct cm_port *port,
 
 static int cm_alloc_response_msg(struct cm_port *port,
 				 struct ib_mad_recv_wc *mad_recv_wc,
+				 bool direct_retry,
 				 struct ib_mad_send_buf **msg)
 {
 	struct ib_mad_send_buf *m;
 	int ret;
 
-	m = cm_alloc_response_msg_no_ah(port, mad_recv_wc);
+	m = cm_alloc_response_msg_no_ah(port, mad_recv_wc, direct_retry);
 	if (IS_ERR(m))
 		return PTR_ERR(m);
 
@@ -1598,7 +1608,7 @@ static int cm_issue_rej(struct cm_port *port,
 	struct cm_rej_msg *rej_msg, *rcv_msg;
 	int ret;
 
-	ret = cm_alloc_response_msg(port, mad_recv_wc, &msg);
+	ret = cm_alloc_response_msg(port, mad_recv_wc, false, &msg);
 	if (ret)
 		return ret;
 
@@ -1951,7 +1961,7 @@ static void cm_dup_req_handler(struct cm_work *work,
 	}
 	spin_unlock_irq(&cm_id_priv->lock);
 
-	ret = cm_alloc_response_msg(work->port, work->mad_recv_wc, &msg);
+	ret = cm_alloc_response_msg(work->port, work->mad_recv_wc, true, &msg);
 	if (ret)
 		return;
 
@@ -2444,7 +2454,7 @@ static void cm_dup_rep_handler(struct cm_work *work)
 
 	atomic_long_inc(
 		&work->port->counters[CM_RECV_DUPLICATES][CM_REP_COUNTER]);
-	ret = cm_alloc_response_msg(work->port, work->mad_recv_wc, &msg);
+	ret = cm_alloc_response_msg(work->port, work->mad_recv_wc, true, &msg);
 	if (ret)
 		goto deref;
 
@@ -2791,7 +2801,7 @@ static int cm_issue_drep(struct cm_port *port,
 	struct cm_drep_msg *drep_msg;
 	int ret;
 
-	ret = cm_alloc_response_msg(port, mad_recv_wc, &msg);
+	ret = cm_alloc_response_msg(port, mad_recv_wc, true, &msg);
 	if (ret)
 		return ret;
 
@@ -2856,7 +2866,8 @@ static int cm_dreq_handler(struct cm_work *work)
 	case IB_CM_TIMEWAIT:
 		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
 						     [CM_DREQ_COUNTER]);
-		msg = cm_alloc_response_msg_no_ah(work->port, work->mad_recv_wc);
+		msg = cm_alloc_response_msg_no_ah(work->port, work->mad_recv_wc,
+						  true);
 		if (IS_ERR(msg))
 			goto unlock;
 
@@ -3361,7 +3372,8 @@ static int cm_lap_handler(struct cm_work *work)
 	case IB_CM_MRA_LAP_SENT:
 		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
 						     [CM_LAP_COUNTER]);
-		msg = cm_alloc_response_msg_no_ah(work->port, work->mad_recv_wc);
+		msg = cm_alloc_response_msg_no_ah(work->port, work->mad_recv_wc,
+						  true);
 		if (IS_ERR(msg))
 			goto unlock;
 
@@ -3826,7 +3838,7 @@ static void cm_send_handler(struct ib_mad_agent *mad_agent,
 			    struct ib_mad_send_wc *mad_send_wc)
 {
 	struct ib_mad_send_buf *msg = mad_send_wc->send_buf;
-	struct cm_id_private *cm_id_priv = msg->context[0];
+	struct cm_id_private *cm_id_priv;
 	enum ib_cm_state state =
 		(enum ib_cm_state)(unsigned long)msg->context[1];
 	struct cm_port *port;
@@ -3836,13 +3848,12 @@ static void cm_send_handler(struct ib_mad_agent *mad_agent,
 	attr_index = be16_to_cpu(((struct ib_mad_hdr *)
 				  msg->mad)->attr_id) - CM_ATTR_ID_OFFSET;
 
-	/*
-	 * If the send was in response to a received message (context[0] is not
-	 * set to a cm_id), and is not a REJ, then it is a send that was
-	 * manually retried.
-	 */
-	if (!cm_id_priv && (attr_index != CM_REJ_COUNTER))
+	if (msg->context[0] == CM_DIRECT_RETRY_CTX) {
 		msg->retries = 1;
+		cm_id_priv = NULL;
+	} else {
+		cm_id_priv = msg->context[0];
+	}
 
 	atomic_long_add(1 + msg->retries, &port->counters[CM_XMIT][attr_index]);
 	if (msg->retries)
-- 
2.47.0


