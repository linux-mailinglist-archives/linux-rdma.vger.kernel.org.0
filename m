Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD0254CCE7
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 17:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbiFOP3h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 11:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356518AbiFOP2w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 11:28:52 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7EA5F49
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 08:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=FD38N1rEoSNqADxad3fE1dhfLCQObqO1yEbFX66mI9I=; b=MKoUPJBOWDl8wgCASlL0k47fI7
        RRfrRQSUpK8/Zi23YPXV6nEHtLC8qBAIEoG3gT5fw5PM1UvyEwvlmftcxL31/DkOngB0V2Ixam0m3
        GAkUdrHDPw+7PRg45OGySpPU2ZUdHPtxGXeR8n0TRW6ISqRgV1WfNdjwIrUng7B/7fSSNNjMvPaVZ
        YBLc2Ix04xv97802rhLvsihbbBj+FG11/hq1yQ7JM5oLGIG9dup3yZrIcfAHalLYcFgBdlbtpNpLT
        leO5WLFcpDE/a26OLVV9fPd+SFLwfea9f7OjSItdVgexqNCV21Z09yqzmSeVhZMh/MkyJEJtzD7J3
        y9+LVFMIecYMSNlLsmyveTR/rFnlI9Kt86BD0qW2jGyKRgk1z4XNtjFvuiVgw6+tMQff+BF/bAyrh
        Sy0Zikr/CZa7LfTJvqfcJo5731HQrWVdLhWg58cWUFlEPsnlTMZ8pWVpoFQSOpy/WKxW97JRfQCzd
        wElSqUNCROflv/xAgj4MLt2T;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1Uwg-005rwN-2b; Wed, 15 Jun 2022 15:28:38 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH v2 14/14] rdma/siw: implement non-blocking connect.
Date:   Wed, 15 Jun 2022 17:26:52 +0200
Message-Id: <34d8ab3e8cadd922bc000beda9d567217ebbdbd3.1655305567.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655305567.git.metze@samba.org>
References: <cover.1655305567.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

First rdma_connect() holds id_priv->handler_mutex and deadlocks
rdma_destroy_id().

And iw_cm_connect() called from within rdma_connect() sets
IWCM_F_CONNECT_WAIT during the call to cm_id->device->ops.iw_connect(),
siw_connect() in this case. It means that iw_cm_disconnect()
and iw_destroy_cm_id() will both deadlock waiting for
IWCM_F_CONNECT_WAIT being cleared.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 125 ++++++++++++++++++++++-------
 drivers/infiniband/sw/siw/siw_cm.h |   1 +
 2 files changed, 96 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 74ed2a5a8f47..5b051aaa3fec 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -37,6 +37,7 @@ static void siw_cm_llp_write_space(struct sock *s);
 static void siw_cm_llp_error_report(struct sock *s);
 static int siw_cm_upcall(struct siw_cep *cep, enum iw_cm_event_type reason,
 			 int status);
+static void siw_connected(struct siw_cep *cep);
 
 static void siw_sk_assign_cm_upcalls(struct sock *sk)
 {
@@ -1074,6 +1075,10 @@ static void siw_cm_work_handler(struct work_struct *w)
 		siw_accept_newconn(cep);
 		break;
 
+	case SIW_CM_WORK_CONNECTED:
+		siw_connected(cep);
+		break;
+
 	case SIW_CM_WORK_READ_MPAHDR:
 		if (cep->state == SIW_EPSTATE_AWAIT_MPAREQ) {
 			if (cep->listen_cep) {
@@ -1239,6 +1244,7 @@ static void siw_cm_llp_data_ready(struct sock *sk)
 	switch (cep->state) {
 	case SIW_EPSTATE_RDMA_MODE:
 	case SIW_EPSTATE_LISTENING:
+	case SIW_EPSTATE_CONNECTING:
 		break;
 
 	case SIW_EPSTATE_AWAIT_MPAREQ:
@@ -1292,12 +1298,26 @@ static void siw_cm_llp_state_change(struct sock *sk)
 
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
+		fallthrough;
 
 	case TCP_CLOSE:
 	case TCP_CLOSE_WAIT:
@@ -1316,7 +1336,7 @@ static void siw_cm_llp_state_change(struct sock *sk)
 static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 			      struct sockaddr *raddr, bool afonly)
 {
-	int rv, flags = 0;
+	int rv;
 	size_t size = laddr->sa_family == AF_INET ?
 		sizeof(struct sockaddr_in) : sizeof(struct sockaddr_in6);
 
@@ -1335,7 +1355,18 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 	if (rv < 0)
 		return rv;
 
-	rv = kernel_connect(s, raddr, size, flags);
+	/*
+	 * Yes, this is really O_NONBLOCK instead of
+	 * SOCK_NONBLOCK.
+	 *
+	 * __sys_connect_file() passes
+	 * sock->file->f_flags | file_flags to
+	 * sock->ops->connect().
+	 *
+	 * Also io_connect() from io_uring forces
+	 * file_flags=O_NONBLOCK to __sys_connect_file().
+	 */
+	rv = kernel_connect(s, raddr, size, O_NONBLOCK);
 
 	return rv < 0 ? rv : 0;
 }
@@ -1482,36 +1513,27 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
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
@@ -1549,6 +1571,49 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
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
index 8c59cb3e2868..c01bdc8e64ee 100644
--- a/drivers/infiniband/sw/siw/siw_cm.h
+++ b/drivers/infiniband/sw/siw/siw_cm.h
@@ -76,6 +76,7 @@ struct siw_cep {
 
 enum siw_work_type {
 	SIW_CM_WORK_ACCEPT = 1,
+	SIW_CM_WORK_CONNECTED,
 	SIW_CM_WORK_READ_MPAHDR,
 	SIW_CM_WORK_CLOSE_LLP, /* close socket */
 	SIW_CM_WORK_PEER_CLOSE, /* socket indicated peer close */
-- 
2.34.1

