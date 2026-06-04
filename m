Return-Path: <linux-rdma+bounces-21787-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mbpPGoSmIWp7KgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21787-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 18:23:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 443BE641CCC
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 18:23:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=bWKf7v6v;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21787-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21787-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C54E300609C
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 16:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A39D33C1B4;
	Thu,  4 Jun 2026 16:09:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98003274B4A
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 16:08:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589339; cv=none; b=Eex6fML3ijZtyq02KZTOhAvxcD8NhbiqlinVjCL6uC008/xS8qEKXGBZBLobKy4M/q/PTWrrDZCmEKUBsj0TYiejoC52U45VXEhAopnwIcOubE2DCkuAeqHxXCKZ5Vb4e2QME6X8gPCC5Gu/Qk1j4opAGLjAxd7EeFA/s0QYO7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589339; c=relaxed/simple;
	bh=TCRzvQt7ohKQaWYJZxIA3vd/LUwfw28eHxpXPyCm/lE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gL00fIuLtDJ08moqhC/P/7hXgVtd0qFnqb14JO5Q6UlnygWWpLYh9H7zDW6VuKLfHwd7VD36+BK7Tgx6YM6PJIBSdjL2xhoFST5aQtovQgrcIIFCzmgbd8zfdcgPJisR3J6qcePXZPDJmn8WRoZSmiHqaNSL/XIe0dCvipBoTco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bWKf7v6v; arc=none smtp.client-ip=95.215.58.178
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780589335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bn6zw735ltpEmMfMUoJjWv5x2cFueJuoIKiTR8INrrI=;
	b=bWKf7v6vn4JW+TPWSYImx4BC6O9Ze+z8iIycVjCNmvHc+31CjIVTAoOrbd3ux63ScO1uOr
	S7z9w8i1tkQFOdOfskUBY7j2HxSOpl1TowWaZj7/H/6uH8rvKveJL7iP4l+N8TlURxFR/2
	3NAcY+0t5CoAIlS+acifmRJFMhsDxtE=
From: bernard.metzler@linux.dev
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH] RDMA/siw: Fix endpoint/socket association handling.
Date: Thu,  4 Jun 2026 18:08:08 +0200
Message-ID: <20260604160808.30948-1-bernard.metzler@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21787-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:bernard.metzler@linux.dev,m:shuangpeng.kernel@gmail.com,m:shuangpengkernel@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,gmail.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 443BE641CCC

From: Bernard Metzler <bernard.metzler@linux.dev>

Disassociating a socket from an endpoint via
siw_socket_disassoc() may release the last reference on that
endpoint and free it. Therefore, don't clear the endpoints
socket pointer after calling that function, but within.

This fixes a

BUG: KASAN: slab-use-after-free in siw_cm_work_handler (drivers/infiniband/sw/siw/siw_cm.c:1053 drivers/infiniband/sw/siw/siw_cm.c:1075)

which occurred after processing a malformed MPA request
during connection establishment, causing the new endpoint
to be closed.

Fixes: 6c52fdc244b5c ("rdma/siw: connection management")
Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Signed-off-by: Bernard Metzler <bernard.metzler@linux.dev>
---
 drivers/infiniband/sw/siw/siw_cm.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index f7ac81c0f267..87c79527ac09 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -138,6 +138,7 @@ static void siw_socket_disassoc(struct socket *s)
 		cep = sk_to_cep(sk);
 		if (cep) {
 			siw_sk_restore_upcalls(sk, cep);
+			cep->sock = NULL;
 			siw_cep_put(cep);
 		} else {
 			pr_warn("siw: cannot restore sk callbacks: no ep\n");
@@ -418,10 +419,11 @@ static void siw_free_cm_id(struct siw_cep *cep)
 
 static void siw_destroy_cep_sock(struct siw_cep *cep)
 {
-	if (cep->sock) {
-		siw_socket_disassoc(cep->sock);
-		sock_release(cep->sock);
-		cep->sock = NULL;
+	struct socket *s = cep->sock;
+
+	if (s) {
+		siw_socket_disassoc(s);
+		sock_release(s);
 	}
 }
 
@@ -1050,7 +1052,6 @@ static void siw_accept_newconn(struct siw_cep *cep)
 	if (new_s) {
 		siw_socket_disassoc(new_s);
 		sock_release(new_s);
-		new_cep->sock = NULL;
 	}
 	siw_dbg_cep(cep, "error %d\n", rv);
 }
@@ -1202,6 +1203,8 @@ static void siw_cm_work_handler(struct work_struct *w)
 		WARN(1, "Undefined CM work type: %d\n", work->type);
 	}
 	if (release_cep) {
+		struct socket *s = cep->sock;
+
 		siw_dbg_cep(cep,
 			    "release: timer=%s, QP[%u]\n",
 			    cep->mpa_timer ? "y" : "n",
@@ -1227,10 +1230,9 @@ static void siw_cm_work_handler(struct work_struct *w)
 			cep->qp = NULL;
 			siw_qp_put(qp);
 		}
-		if (cep->sock) {
-			siw_socket_disassoc(cep->sock);
-			sock_release(cep->sock);
-			cep->sock = NULL;
+		if (s) {
+			siw_socket_disassoc(s);
+			sock_release(s);
 		}
 		if (cep->cm_id) {
 			siw_free_cm_id(cep);
@@ -1561,7 +1563,6 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	if (cep) {
 		siw_socket_disassoc(s);
 		sock_release(s);
-		cep->sock = NULL;
 
 		cep->qp = NULL;
 
@@ -1937,7 +1938,6 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		siw_cep_set_inuse(cep);
 
 		siw_free_cm_id(cep);
-		cep->sock = NULL;
 		siw_socket_disassoc(s);
 		cep->state = SIW_EPSTATE_CLOSED;
 
@@ -1959,6 +1959,7 @@ static void siw_drop_listeners(struct iw_cm_id *id)
 	 */
 	list_for_each_safe(p, tmp, (struct list_head *)id->provider_data) {
 		struct siw_cep *cep = list_entry(p, struct siw_cep, listenq);
+		struct socket *s = cep->sock;
 
 		list_del(p);
 
@@ -1967,10 +1968,9 @@ static void siw_drop_listeners(struct iw_cm_id *id)
 		siw_cep_set_inuse(cep);
 
 		siw_free_cm_id(cep);
-		if (cep->sock) {
-			siw_socket_disassoc(cep->sock);
-			sock_release(cep->sock);
-			cep->sock = NULL;
+		if (s) {
+			siw_socket_disassoc(s);
+			sock_release(s);
 		}
 		cep->state = SIW_EPSTATE_CLOSED;
 		siw_cep_set_free_and_put(cep);
-- 
2.50.0


