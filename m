Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F58A375D95
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhEFXkJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhEFXkI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:40:08 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A64C061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=sKDhMddpDYwMlZNTFJg3BqdaHlziQfuLC+vCF31iEe8=; b=HgMdaQ9BaiIOMdOub8NjS3HmZx
        vFWND01R9IvDantjhmguzm9bBarkjUw5HkzRdOeZVECeZP1GbHE1YhXk6nUYISMO2X4yKFhSqg5r6
        cpYEohlwsT8jyEil+pAsvZl0J/u+KIKoxs2na/m/EcsFDnGl+wrGB8fQvuZMpZNePTNxY1zl6Od+n
        ROlb0MSxwzNibTcDreK1rjks/iyxmQ7q4Cq8gNmz8GICpwYcpUBqUHShKfCxG7DNl2TXXD0uPOs5X
        KPPx54I4X2+uO5+oisqeo4PPjG/2XZujn5gnsYJKuo3KDnuJHwErJsTgQnjzF627YTTxKfFXqDKw6
        UcntuoOmOPRHWYMzMjiB7SmDJKBK1yziaoBr5WLMItBXS/M8d+wCUNuD93HVSkjHCmWfn8WCkXPkf
        /3fNJfbT9HeEE0SoTccWpJ0sa1pu8ZFH5Jmw3WD/PivJ327MnUB8/33jzan2mAdsIRwvGFmWKwZw8
        /DeT3nCAMeNXLRCxidWjjoLA;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenaF-0004MW-QW; Thu, 06 May 2021 23:39:07 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 20/31] rdma/siw: implement non-blocking connect.
Date:   Fri,  7 May 2021 01:36:26 +0200
Message-Id: <80a82b4d3029d1a63042910e3ac4c3731561967e.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is very important in order to prevent deadlocks.

The RDMA application layer expects rdma_connect() to be non-blocking
as the completion is handled via RDMA_CM_EVENT_ESTABLISHED and
other async events. It's not unlikely to hold a lock during
the rdma_connect() call.

Without out this a connection attempt to a non-existing/reachable
server block until the very long tcp timeout hits.
The application layer had no chance to have its own timeout handler
as that would just deadlock with the already blocking rdma_connect().

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 114 +++++++++++++++++++++--------
 drivers/infiniband/sw/siw/siw_cm.h |   1 +
 2 files changed, 85 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index cf0f881c6793..9a550f040678 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -37,6 +37,7 @@ static void siw_cm_llp_write_space(struct sock *s);
 static void siw_cm_llp_error_report(struct sock *s);
 static int siw_cm_upcall(struct siw_cep *cep, enum iw_cm_event_type reason,
 			 int status);
+static void siw_connected(struct siw_cep *cep);
 
 static void siw_sk_assign_cm_upcalls(struct sock *sk)
 {
@@ -1141,6 +1142,10 @@ static void siw_cm_work_handler(struct work_struct *w)
 		siw_accept_newconn(cep);
 		break;
 
+	case SIW_CM_WORK_CONNECTED:
+		siw_connected(cep);
+		break;
+
 	case SIW_CM_WORK_READ_MPAHDR:
 		if (cep->state == SIW_EPSTATE_AWAIT_MPAREQ) {
 			if (cep->listen_cep) {
@@ -1306,6 +1311,7 @@ static void siw_cm_llp_data_ready(struct sock *sk)
 	switch (cep->state) {
 	case SIW_EPSTATE_RDMA_MODE:
 	case SIW_EPSTATE_LISTENING:
+	case SIW_EPSTATE_CONNECTING:
 		break;
 
 	case SIW_EPSTATE_AWAIT_MPAREQ:
@@ -1359,12 +1365,26 @@ static void siw_cm_llp_state_change(struct sock *sk)
 
 	switch (sk->sk_state) {
 	case TCP_ESTABLISHED:
-		/*
-		 * handle accepting socket as special case where only
-		 * new connection is possible
-		 */
-		siw_cm_queue_work(cep, SIW_CM_WORK_ACCEPT);
-		break;
+		if (cep->state == SIW_EPSTATE_CONNECTING) {
+			/*
+			 * handle accepting socket as special case where only
+			 * new connection is possible
+			 */
+			siw_cm_queue_work(cep, SIW_CM_WORK_CONNECTED);
+			break;
+
+		} else if (cep->state == SIW_EPSTATE_LISTENING) {
+			/*
+			 * handle accepting socket as special case where only
+			 * new connection is possible
+			 */
+			siw_cm_queue_work(cep, SIW_CM_WORK_ACCEPT);
+			break;
+		}
+		siw_dbg_cep(cep,
+			    "unexpected socket state %d with cep state %d\n",
+			    sk->sk_state, cep->state);
+		/* fall through */
 
 	case TCP_CLOSE:
 	case TCP_CLOSE_WAIT:
@@ -1383,7 +1403,7 @@ static void siw_cm_llp_state_change(struct sock *sk)
 static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 			      struct sockaddr *raddr, bool afonly)
 {
-	int rv, flags = 0;
+	int rv;
 	size_t size = laddr->sa_family == AF_INET ?
 		sizeof(struct sockaddr_in) : sizeof(struct sockaddr_in6);
 
@@ -1402,7 +1422,7 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 	if (rv < 0)
 		return rv;
 
-	rv = kernel_connect(s, raddr, size, flags);
+	rv = kernel_connect(s, raddr, size, O_NONBLOCK);
 
 	return rv < 0 ? rv : 0;
 }
@@ -1547,36 +1567,27 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		goto error;
 	}
 
-	/*
-	 * NOTE: For simplification, connect() is called in blocking
-	 * mode. Might be reconsidered for async connection setup at
-	 * TCP level.
-	 */
 	rv = kernel_bindconnect(s, laddr, raddr, id->afonly);
+	if (rv == -EINPROGRESS) {
+		siw_dbg_qp(qp, "kernel_bindconnect: EINPROGRESS\n");
+		rv = 0;
+	}
 	if (rv != 0) {
 		siw_dbg_qp(qp, "kernel_bindconnect: error %d\n", rv);
 		goto error;
 	}
-	if (siw_tcp_nagle == false)
-		tcp_sock_set_nodelay(s->sk);
-
-	cep->state = SIW_EPSTATE_AWAIT_MPAREP;
 
-	rv = siw_send_mpareqrep(cep, cep->mpa.pdata,
-				cep->mpa.hdr.params.pd_len);
 	/*
-	 * Reset private data.
+	 * The rest will be done by siw_connected()
+	 *
+	 * siw_cm_llp_state_change() will detect
+	 * TCP_ESTABLISHED and schedules SIW_CM_WORK_CONNECTED,
+	 * which will finally call siw_connected().
+	 *
+	 * As siw_cm_llp_state_change() handles everything
+	 * siw_cm_llp_data_ready() can be a noop for
+	 * SIW_EPSTATE_CONNECTING.
 	 */
-	if (cep->mpa.hdr.params.pd_len) {
-		cep->mpa.hdr.params.pd_len = 0;
-		kfree(cep->mpa.pdata);
-		cep->mpa.pdata = NULL;
-	}
-
-	if (rv < 0) {
-		goto error;
-	}
-
 	siw_dbg_cep(cep, "[QP %u]: exit\n", qp_id(qp));
 	siw_cep_set_free(cep);
 	return 0;
@@ -1604,6 +1615,49 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	return rv;
 }
 
+static void siw_connected(struct siw_cep *cep)
+{
+	struct siw_qp *qp = cep->qp;
+	struct socket *s = cep->sock;
+	int rv = -ECONNABORTED;
+
+	/*
+	 * already called with
+	 * siw_cep_set_inuse(cep);
+	 */
+
+	if (cep->state != SIW_EPSTATE_CONNECTING)
+		goto error;
+
+	if (siw_tcp_nagle == false)
+		tcp_sock_set_nodelay(s->sk);
+
+	cep->state = SIW_EPSTATE_AWAIT_MPAREP;
+
+	rv = siw_send_mpareqrep(cep, cep->mpa.pdata,
+				cep->mpa.hdr.params.pd_len);
+	/*
+	 * Reset private data.
+	 */
+	if (cep->mpa.hdr.params.pd_len) {
+		cep->mpa.hdr.params.pd_len = 0;
+		kfree(cep->mpa.pdata);
+		cep->mpa.pdata = NULL;
+	}
+
+	if (rv < 0) {
+		goto error;
+	}
+
+	siw_dbg_cep(cep, "[QP %u]: exit\n", qp_id(qp));
+	return;
+
+error:
+	siw_dbg_cep(cep, "[QP %u]: exit, error %d\n", qp_id(qp), rv);
+	siw_qp_cm_drop(qp, 1);
+	return;
+}
+
 /*
  * siw_accept - Let SoftiWARP accept an RDMA connection request
  *
diff --git a/drivers/infiniband/sw/siw/siw_cm.h b/drivers/infiniband/sw/siw/siw_cm.h
index 4f6219bd746b..62c9947999ac 100644
--- a/drivers/infiniband/sw/siw/siw_cm.h
+++ b/drivers/infiniband/sw/siw/siw_cm.h
@@ -78,6 +78,7 @@ struct siw_cep {
 
 enum siw_work_type {
 	SIW_CM_WORK_ACCEPT = 1,
+	SIW_CM_WORK_CONNECTED,
 	SIW_CM_WORK_READ_MPAHDR,
 	SIW_CM_WORK_CLOSE_LLP, /* close socket */
 	SIW_CM_WORK_PEER_CLOSE, /* socket indicated peer close */
-- 
2.25.1

