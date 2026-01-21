Return-Path: <linux-rdma+bounces-15862-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE9XF7lEcWn2fgAAu9opvQ
	(envelope-from <linux-rdma+bounces-15862-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 22:27:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D143A5E073
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 22:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 40091788F21
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 20:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE163A4AD0;
	Wed, 21 Jan 2026 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="Lx8ae5hk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0357435B13D;
	Wed, 21 Jan 2026 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026061; cv=none; b=cJdHH5RcIT4WsDg5i/0H2F8kpzwh28MeG0Faxg0wOGXutKgoliZ002iuFIYn2uJLvt84NpohDUSoMNi2rZrQpfGl2U8Ok5pFfPhUkMZUSPZPcMVgE0/D94SL10VlLQtC3Nf3ksPn9o0dxjm7pIjjWxcRDB73oNZXMZlh5ybWKfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026061; c=relaxed/simple;
	bh=hi74L5yHHCaf5vRzYYIsRvDzPLk0JKcUj7ppODQDCTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pd19dBQLV/bhS6bBR54ywSxbp8VI314LeVgtTse1R86OVx1C8yLkLUwbojzrSSsifbOcL9KgY4uqnQYpL0in1oEpsvbvZPnrGkzm8uQde4GJZO3b5RmANSuKtiS7phBmncA4uB6kDjgc1ptSj6eqE9kN3N9CpjANn9G2HSWBFHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=Lx8ae5hk; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=Bt4OcMGPq9sVjwH2/rwceia6oHw3t8bpoNG19Le9ojM=; b=Lx8ae5hk8dV8bowl568s02Jhr+
	94llI7Ala+DYAy7HDDWVEjf5Yo7PblNCsri+ALQv/gXY6zVas5aishG4reyB7Zsi1Atm1WuBYv3ys
	uVl5deHOHykttNIhIoaD+WwHblHEAH57pYabxdABQ0TH55YS3yeMRgKPaD5VHGZZ72+Kd+cbvCMSB
	KWGY3/ALDqcC6Xf+U/ztL1vJZQ6cGOTvh0786TczfMEIxUEL1MADPA+GFT97UhzkqndtS5rGKG8Zz
	GJcKnerNlTtqlpi4cGylK1TJDk0EuMI6fLjGpKurJZY4ln6tJtxSzH6Rab6u4VxPxBYc6pp0sUQn+
	BrSohe1Q9C1oQi3kTe0q++zQ+5NviiFGiPCA74/N02APc/9pesbEjefUbl5RlD64poV0g9ZxiDzcH
	xQT0OuhSJvc3NRh49Kpa/FHTSKy2/2Etq26QvQ+QrUUxJMdvad34kpt2wNfgpHg0X47Q4DN10Rw/z
	1rdYw0kBaW8uad6lYyRglHwH;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vieUK-00000001eju-2oL8;
	Wed, 21 Jan 2026 20:07:36 +0000
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
Subject: [RFC PATCH 1/3] RDMA/core: introduce rdma_restrict_node_type()
Date: Wed, 21 Jan 2026 21:07:11 +0100
Message-ID: <21c111d5f87f539bdb4d19714c375aefcffae7e3.1769025321.git.metze@samba.org>
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
	TAGGED_FROM(0.00)[bounces-15862-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[samba.org:s=42];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,samba.org:email,samba.org:dkim,samba.org:mid,talpey.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: D143A5E073
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
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

And cifs.ko uses 5445 with a fallback to 445, which
means depending on the available interfaces, it tries
5445 in the RoCE range or may tries iWarp with 445
as a fallback. This leads to strange error messages
and strange network captures.

To avoid these problems they will be able to
use rdma_restrict_node_type(RDMA_NODE_RNIC) before
trying port 5445 and rdma_restrict_node_type(RDMA_NODE_IB_CA)
before trying port 445. It means we'll get early
-ENODEV early from rdma_resolve_addr() without any
network traffic and timeouts.

This is designed to be called before calling any
of rdma_bind_addr(), rdma_resolve_addr() or rdma_listen().

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
 drivers/infiniband/core/cma.c      | 30 ++++++++++++++++++++++++++++++
 drivers/infiniband/core/cma_priv.h |  1 +
 include/rdma/rdma_cm.h             | 17 +++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index f00f1d3fbd9c..0ee855a71ed4 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -793,6 +793,9 @@ static int cma_acquire_dev_by_src_ip(struct rdma_id_private *id_priv)
 
 	mutex_lock(&lock);
 	list_for_each_entry(cma_dev, &dev_list, list) {
+		if (id_priv->restricted_node_type != RDMA_NODE_UNSPECIFIED &&
+		    id_priv->restricted_node_type != cma_dev->device->node_type)
+			continue;
 		rdma_for_each_port (cma_dev->device, port) {
 			gidp = rdma_protocol_roce(cma_dev->device, port) ?
 			       &iboe_gid : &gid;
@@ -1015,6 +1018,7 @@ __rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
 		return ERR_PTR(-ENOMEM);
 
 	id_priv->state = RDMA_CM_IDLE;
+	id_priv->restricted_node_type = RDMA_NODE_UNSPECIFIED;
 	id_priv->id.context = context;
 	id_priv->id.event_handler = event_handler;
 	id_priv->id.ps = ps;
@@ -4177,6 +4181,32 @@ int rdma_resolve_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
 }
 EXPORT_SYMBOL(rdma_resolve_addr);
 
+int rdma_restrict_node_type(struct rdma_cm_id *id, u8 node_type)
+{
+	struct rdma_id_private *id_priv =
+		container_of(id, struct rdma_id_private, id);
+	int ret = 0;
+
+	switch (node_type) {
+	case RDMA_NODE_UNSPECIFIED:
+	case RDMA_NODE_IB_CA:
+	case RDMA_NODE_RNIC:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&lock);
+	if (id_priv->cma_dev)
+		ret = -EALREADY;
+	else
+		id_priv->restricted_node_type = node_type;
+	mutex_unlock(&lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(rdma_restrict_node_type);
+
 int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
 {
 	struct rdma_id_private *id_priv =
diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index c604b601f4d9..04332eb82668 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -72,6 +72,7 @@ struct rdma_id_private {
 
 	int			internal_id;
 	enum rdma_cm_state	state;
+	u8			restricted_node_type;
 	spinlock_t		lock;
 	struct mutex		qp_mutex;
 
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index 9bd930a83e6e..6de6fd8bd15e 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -168,6 +168,23 @@ struct rdma_cm_id *rdma_create_user_id(rdma_cm_event_handler event_handler,
   */
 void rdma_destroy_id(struct rdma_cm_id *id);
 
+/**
+ * rdma_restrict_node_type - Restrict an RDMA identifier to specific
+ *   RDMA device node type.
+ *
+ * @id: RDMA identifier.
+ * @node_type: The device node type. Only RDMA_NODE_UNSPECIFIED (default),
+ *   RDMA_NODE_RNIC and RDMA_NODE_IB_CA are allowed
+ *
+ * This allows the caller to restrict the possible devices
+ * used to iWarp (RDMA_NODE_RNIC) or InfiniBand/RoCEv1/RoCEv2 (RDMA_NODE_IB_CA).
+ *
+ * It needs to be called before the RDMA identifier is bound
+ * to an device, which mean it should be called before
+ * rdma_bind_addr(), rdma_bind_addr() and rdma_listen().
+ */
+int rdma_restrict_node_type(struct rdma_cm_id *id, u8 node_type);
+
 /**
  * rdma_bind_addr - Bind an RDMA identifier to a source address and
  *   associated RDMA device, if needed.
-- 
2.43.0


