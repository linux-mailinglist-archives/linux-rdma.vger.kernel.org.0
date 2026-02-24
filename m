Return-Path: <linux-rdma+bounces-17129-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDKjMkngnWnpSQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17129-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 18:30:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CCF18A8C1
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 18:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4369303EC36
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 17:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A793A9627;
	Tue, 24 Feb 2026 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="saDX7/wI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD9023EA83;
	Tue, 24 Feb 2026 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954239; cv=none; b=RjRZjcgK9TjA+SvRXXt20sdphBeOCDQb5Eb7MlCDh0zIqo2cDPM7iDXr9npWOTGrtTivay4xnzY/2cnw816JyEs8YocmHGBje9H71TW43B2kO5NA0daVXVHaImoQPxZXLKRwaUATcrKplCj+pU+D8UmsYbDpdbBSL1yDlCEWW5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954239; c=relaxed/simple;
	bh=/gnHt29zu8QVhSKsTduQVCTxFtI94hREDZvkcYSekH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CYSL7AN7BnmSB6ErN4rVngZpmHe5nia3SLWeHVs71MIOfzXpmc79nkkcDQqf6BTJQx8lfH7633VHWcUdLmRvhr+0PYxmwHSchgkAbMOOUL/6pl1I3RamEaKMukgP/m37fJKHewbzqWVy+ksJeR2DEeMGv8To4HFcxDT4YtDCzBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=saDX7/wI; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=nlbCN83habiaQRkpO//4v1rFzC6YhydxQ4Hnz/IiFzI=; b=saDX7/wIrBTy2Te/s7VqM1bC6x
	9C9vvqwMZe2PGJMJTkba+HqOmrdXNe5O4X0GJcUQUkAxb+AuNQmHNNaws13Kbt1QeGTMJRt69dbzy
	oq2uPld9taFpVZ7pdGO4bK7k7Di5y3Qxhcer0TG+GlOyAxuWBrQfxf1Wgx3ofpctUiS6kQyFW+STP
	DUY6OBGZbxIn27pUQFdW0eXsJbpH64068oXsRmtmTJVxOa7Ot4h3udmL6dAGl52N5/mXeQLAPJAWw
	PE9aQRCdAGilnmfjXs0ng2hvT9U3/Dozo2U5wZZe0637uURLN3dLeF/zJaCEzHlSnhQq6AVIWSPaS
	14ahF6TqoagC/oi7LZEeqR7Kr27zdlxF3tUBMoxdL/4gexaaO//cWwhMwwEMHKac+woI+Ffgrhcv9
	jdbRbG55H3wngfAaM6+12u5PsHAit1QeE+3r21Ln0UAlDr6hDevIHhRpjgDfwqGGYK1CHt3vqSZ/+
	JgGXEN58vytWkiYPEDMFLJx+;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vuvli-00000008DRZ-1P5r;
	Tue, 24 Feb 2026 17:00:18 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-rdma@vger.kernel.org
Cc: metze@samba.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH] RDMA/core: check id_priv->restricted_node_type in cma_listen_on_dev()
Date: Tue, 24 Feb 2026 17:59:52 +0100
Message-ID: <20260224165951.3582093-2-metze@samba.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[samba.org,ziepe.ca,kernel.org,gmail.com,talpey.com,microsoft.com,vger.kernel.org,lists.samba.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17129-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[samba.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64CCF18A8C1
X-Rspamd-Action: no action

When listening on wildcard addresses we have a global list for
the application layer rdma_cm_id and for any existing
device or any device added in future we try to listen
on any wildcard listener.

When the listener has a restricted_node_type we
should prevent listening on devices with a different
node type.

While there fix the documentation comment of
rdma_restrict_node_type() to include rdma_resolve_addr()
instead of having rdma_bind_addr() twice.

Fixes: a760e80e90f5 ("RDMA/core: introduce rdma_restrict_node_type()")
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Steve French <smfrench@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: linux-rdma@vger.kernel.org
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 drivers/infiniband/core/cma.c | 6 +++++-
 include/rdma/rdma_cm.h        | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index e54c07c74575..9480d1a51c11 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2729,6 +2729,9 @@ static int cma_listen_on_dev(struct rdma_id_private *id_priv,
 	*to_destroy = NULL;
 	if (cma_family(id_priv) == AF_IB && !rdma_cap_ib_cm(cma_dev->device, 1))
 		return 0;
+	if (id_priv->restricted_node_type != RDMA_NODE_UNSPECIFIED &&
+	    id_priv->restricted_node_type != cma_dev->device->node_type)
+		return 0;
 
 	dev_id_priv =
 		__rdma_create_id(net, cma_listen_handler, id_priv,
@@ -2736,6 +2739,7 @@ static int cma_listen_on_dev(struct rdma_id_private *id_priv,
 	if (IS_ERR(dev_id_priv))
 		return PTR_ERR(dev_id_priv);
 
+	dev_id_priv->restricted_node_type = id_priv->restricted_node_type;
 	dev_id_priv->state = RDMA_CM_ADDR_BOUND;
 	memcpy(cma_src_addr(dev_id_priv), cma_src_addr(id_priv),
 	       rdma_addr_size(cma_src_addr(id_priv)));
@@ -4194,7 +4198,7 @@ int rdma_restrict_node_type(struct rdma_cm_id *id, u8 node_type)
 	}
 
 	mutex_lock(&lock);
-	if (id_priv->cma_dev)
+	if (READ_ONCE(id_priv->state) != RDMA_CM_IDLE)
 		ret = -EALREADY;
 	else
 		id_priv->restricted_node_type = node_type;
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index 6de6fd8bd15e..d639ff889e64 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -181,7 +181,7 @@ void rdma_destroy_id(struct rdma_cm_id *id);
  *
  * It needs to be called before the RDMA identifier is bound
  * to an device, which mean it should be called before
- * rdma_bind_addr(), rdma_bind_addr() and rdma_listen().
+ * rdma_bind_addr(), rdma_resolve_addr() and rdma_listen().
  */
 int rdma_restrict_node_type(struct rdma_cm_id *id, u8 node_type);
 
-- 
2.43.0


