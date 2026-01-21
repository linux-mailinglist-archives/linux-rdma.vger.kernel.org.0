Return-Path: <linux-rdma+bounces-15864-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONFPOBFYcmkpiwAAu9opvQ
	(envelope-from <linux-rdma+bounces-15864-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 18:02:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1DC6A9F8
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 18:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5366AAD387
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 20:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF7B3B530C;
	Wed, 21 Jan 2026 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="DW/RogCX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEE835B13D;
	Wed, 21 Jan 2026 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026075; cv=none; b=hoaWBgrZ1nN0RdBAHNab6JC04LygPEgBFpyhpsYpNH9APum01NtJJkT2gcFFCrt3r2d1zIFRsVZbjKBqAdbX1d8CqrcFR09U1yai0zVvodi04tkCEFeyM56Wt4hprBYJuUbQZOHr7fab8lp5AeYLTaEwDPwDPe/4Q4AqvmAm778=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026075; c=relaxed/simple;
	bh=qKqgBxsymAgfgU0zQXSZWapNvJf8szk0XUIdyQDMA+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBKq5fvr8LPktrqdVCXEZSzyIO4fK2YCG5xfnWD0BURNoQHICkt5M1udhI57mqPgqj5odCu2BMP8ZXvAELkwCWL4wuJfuNd96aFx3F02F1M95Crl7cH9OFYcd8A6M7KD6+/zaV5pStfhxLolXHYZvUBRsz/aBT14UbgNQc/dvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=DW/RogCX; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=+I3JhLzJTCC4NOeTMSI3WFI9XK0T/byLkHHoVmgnaFw=; b=DW/RogCXIke5/fwVZjoI2l5VMu
	JRn6QQQfWDNZIzZDAi6hbaIAVldDNbshexhg2b9i8VkUSBvkB6c/DVmbZscIj7o5AfI7vpSocR/27
	M9ZGCsiS5aFNXfi/LRt5L/qSCA10LGd0gKnOP0jSHM4x9KGSPlLK5u/+eCHMsj4IhdbuMxWlQwvun
	dwYrguM99k6BDVrUTaAXDRs2Q3TeU4I3xYn1SAS927u5si39Wtta+x8ostuqoEhspP3ZlO8HfWZfZ
	IYOMfDYA7lx4CM5sLhH5msrclCE0nVB4zNDPgTazAXua9tZJgavGYf1gGUiJ5sDehbcllmQCwUegd
	YwY4Uts0FvsJIIh8H/zG0yT+J752J8TcsDYwqsoxILOO/mJhpJxilcKY55vSJYx9wqkopRBT3qdCP
	dSeyisELgZunRJnCZQ249nR0XB1EQZeW0grFsm/Vjri9z6LPm9BUOnMeUtaGhUdqDCyz4R7W/pdV/
	rb8FXzfDoJXtpwSMNFhr3t4r;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vieUV-00000001ekQ-2l6p;
	Wed, 21 Jan 2026 20:07:48 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-rdma@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [RFC PATCH 3/3] smb: server: make use of rdma_restrict_node_type()
Date: Wed, 21 Jan 2026 21:07:13 +0100
Message-ID: <617d10f51178bd43065d88ec3c3bfc25f6e9098c.1769025321.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769025321.git.metze@samba.org>
References: <cover.1769025321.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[samba.org,ziepe.ca,kernel.org,gmail.com,talpey.com,microsoft.com];
	TAGGED_FROM(0.00)[bounces-15864-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[samba.org:s=42];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[samba.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samba.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: AF1DC6A9F8
X-Rspamd-Action: add header
X-Spam: Yes

For smbdirect it required to use different ports depending
on the RDMA protocol. E.g. for iWarp 5445 is needed
(as tcp port 445 already used by the raw tcp transport for SMB),
while InfiniBand, RoCEv1 and RoCEv2 use port 445, as they
use an independent port range (even for RoCEv2, which uses udp
port 4791 itself).

Currently ksmbd is not able to function correctly at
all if the system has iWarp (RDMA_NODE_RNIC) interface(s)
and any InfiniBand, RoCEv1 and/or RoCEv2 interface(s)
at the same time.

Now we do a wildcard listen on port 5445 only
for iWarp devices and another wildcard listen
on port 445 of any InfiniBand, RoCEv1 and/or RoCEv2
devices.

The wildcard listeners also work if there is
no device of the requested node_type, this
is the same logic as we had before, but before
we had to decide between port 5445 or 445
and now both are possible at the same time.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-rdma@vger.kernel.org
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 fs/smb/server/transport_rdma.c | 108 ++++++++++++++++++++++++---------
 1 file changed, 80 insertions(+), 28 deletions(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 541e51a7c0ce..675194a24e36 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -61,9 +61,6 @@
  * Those may change after a SMB_DIRECT negotiation
  */
 
-/* Set 445 port to SMB Direct port by default */
-static int smb_direct_port = SMB_DIRECT_PORT_INFINIBAND;
-
 /* The local peer's maximum number of credits to grant to the peer */
 static int smb_direct_receive_credit_max = 255;
 
@@ -90,8 +87,9 @@ struct smb_direct_device {
 };
 
 static struct smb_direct_listener {
+	int			port;
 	struct rdma_cm_id	*cm_id;
-} smb_direct_listener;
+} smb_direct_ib_listener, smb_direct_iw_listener;
 
 static struct workqueue_struct *smb_direct_wq;
 
@@ -2621,6 +2619,7 @@ static bool rdma_frwr_is_supported(struct ib_device_attr *attrs)
 static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id,
 					     struct rdma_cm_event *event)
 {
+	struct smb_direct_listener *listener = new_cm_id->context;
 	struct smb_direct_transport *t;
 	struct smbdirect_socket *sc;
 	struct smbdirect_socket_parameters *sp;
@@ -2709,7 +2708,7 @@ static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id,
 
 	handler = kthread_run(ksmbd_conn_handler_loop,
 			      KSMBD_TRANS(t)->conn, "ksmbd:r%u",
-			      smb_direct_port);
+			      listener->port);
 	if (IS_ERR(handler)) {
 		ret = PTR_ERR(handler);
 		pr_err("Can't start thread\n");
@@ -2746,39 +2745,73 @@ static int smb_direct_listen_handler(struct rdma_cm_id *cm_id,
 	return 0;
 }
 
-static int smb_direct_listen(int port)
+static int smb_direct_listen(struct smb_direct_listener *listener,
+			     int port)
 {
 	int ret;
 	struct rdma_cm_id *cm_id;
+	u8 node_type = RDMA_NODE_UNSPECIFIED;
 	struct sockaddr_in sin = {
 		.sin_family		= AF_INET,
 		.sin_addr.s_addr	= htonl(INADDR_ANY),
 		.sin_port		= htons(port),
 	};
 
+	switch (port) {
+	case SMB_DIRECT_PORT_IWARP:
+		/*
+		 * only allow iWarp devices
+		 * for port 5445.
+		 */
+		node_type = RDMA_NODE_RNIC;
+		break;
+	case SMB_DIRECT_PORT_INFINIBAND:
+		/*
+		 * only allow InfiniBand, RoCEv1 or RoCEv2
+		 * devices for port 445.
+		 *
+		 * (Basically don't allow iWarp devices)
+		 */
+		node_type = RDMA_NODE_IB_CA;
+		break;
+	default:
+		pr_err("unsupported smbdirect port=%d!\n", port);
+		return -ENODEV;
+	}
+
 	cm_id = rdma_create_id(&init_net, smb_direct_listen_handler,
-			       &smb_direct_listener, RDMA_PS_TCP, IB_QPT_RC);
+			       listener, RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(cm_id)) {
 		pr_err("Can't create cm id: %ld\n", PTR_ERR(cm_id));
 		return PTR_ERR(cm_id);
 	}
 
+	ret = rdma_restrict_node_type(cm_id, node_type);
+	if (ret) {
+		pr_err("rdma_restrict_node_type(%u) failed %d\n",
+		       node_type, ret);
+		goto err;
+	}
+
 	ret = rdma_bind_addr(cm_id, (struct sockaddr *)&sin);
 	if (ret) {
 		pr_err("Can't bind: %d\n", ret);
 		goto err;
 	}
 
-	smb_direct_listener.cm_id = cm_id;
-
 	ret = rdma_listen(cm_id, 10);
 	if (ret) {
 		pr_err("Can't listen: %d\n", ret);
 		goto err;
 	}
+
+	listener->port = port;
+	listener->cm_id = cm_id;
+
 	return 0;
 err:
-	smb_direct_listener.cm_id = NULL;
+	listener->port = 0;
+	listener->cm_id = NULL;
 	rdma_destroy_id(cm_id);
 	return ret;
 }
@@ -2787,10 +2820,6 @@ static int smb_direct_ib_client_add(struct ib_device *ib_dev)
 {
 	struct smb_direct_device *smb_dev;
 
-	/* Set 5445 port if device type is iWARP(No IB) */
-	if (ib_dev->node_type != RDMA_NODE_IB_CA)
-		smb_direct_port = SMB_DIRECT_PORT_IWARP;
-
 	if (!rdma_frwr_is_supported(&ib_dev->attrs))
 		return 0;
 
@@ -2833,8 +2862,9 @@ int ksmbd_rdma_init(void)
 {
 	int ret;
 
-	smb_direct_port = SMB_DIRECT_PORT_INFINIBAND;
-	smb_direct_listener.cm_id = NULL;
+	smb_direct_ib_listener = smb_direct_iw_listener = (struct smb_direct_listener) {
+		.cm_id = NULL,
+	};
 
 	ret = ib_register_client(&smb_direct_ib_client);
 	if (ret) {
@@ -2850,31 +2880,53 @@ int ksmbd_rdma_init(void)
 	smb_direct_wq = alloc_workqueue("ksmbd-smb_direct-wq",
 					WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_PERCPU,
 					0);
-	if (!smb_direct_wq)
-		return -ENOMEM;
+	if (!smb_direct_wq) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
-	ret = smb_direct_listen(smb_direct_port);
+	ret = smb_direct_listen(&smb_direct_ib_listener,
+				SMB_DIRECT_PORT_INFINIBAND);
 	if (ret) {
-		destroy_workqueue(smb_direct_wq);
-		smb_direct_wq = NULL;
-		pr_err("Can't listen: %d\n", ret);
-		return ret;
+		pr_err("Can't listen on InfiniBand/RoCEv1/RoCEv2: %d\n", ret);
+		goto err;
 	}
 
-	ksmbd_debug(RDMA, "init RDMA listener. cm_id=%p\n",
-		    smb_direct_listener.cm_id);
+	ksmbd_debug(RDMA, "InfiniBand/RoCEv1/RoCEv2 RDMA listener. cm_id=%p\n",
+		    smb_direct_ib_listener.cm_id);
+
+	ret = smb_direct_listen(&smb_direct_iw_listener,
+				SMB_DIRECT_PORT_IWARP);
+	if (ret) {
+		pr_err("Can't listen on iWarp: %d\n", ret);
+		goto err;
+	}
+
+	ksmbd_debug(RDMA, "iWarp RDMA listener. cm_id=%p\n",
+		    smb_direct_iw_listener.cm_id);
+
 	return 0;
+err:
+	ksmbd_rdma_stop_listening();
+	ksmbd_rdma_destroy();
+	return ret;
 }
 
 void ksmbd_rdma_stop_listening(void)
 {
-	if (!smb_direct_listener.cm_id)
+	if (!smb_direct_ib_listener.cm_id && !smb_direct_iw_listener.cm_id)
 		return;
 
 	ib_unregister_client(&smb_direct_ib_client);
-	rdma_destroy_id(smb_direct_listener.cm_id);
 
-	smb_direct_listener.cm_id = NULL;
+	if (smb_direct_ib_listener.cm_id)
+		rdma_destroy_id(smb_direct_ib_listener.cm_id);
+	if (smb_direct_iw_listener.cm_id)
+		rdma_destroy_id(smb_direct_iw_listener.cm_id);
+
+	smb_direct_ib_listener = smb_direct_iw_listener = (struct smb_direct_listener) {
+		.cm_id = NULL,
+	};
 }
 
 void ksmbd_rdma_destroy(void)
-- 
2.43.0


