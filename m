Return-Path: <linux-rdma+bounces-23165-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qUYxFT6XVWo0qgAAu9opvQ
	(envelope-from <linux-rdma+bounces-23165-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 03:56:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2AA750358
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 03:56:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=eWn1ZeVM;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23165-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23165-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5676730067B5
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 01:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34C037107E;
	Tue, 14 Jul 2026 01:56:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4C319ABC6
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 01:56:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994172; cv=none; b=WCKu1caddpOO0rVA5nwjMmri+L+yVnUnb4/7gHui8vnGQjxv6+rDb7a/olxt2rXElHD+DSwtQtAoJEPmhyRk8HP7bOxkQYButAse2GWYj4JZych1aECCOFa1QRIiLANkIZnUAqBhsht3xAa6OPnIqppMbJgRPe1c7ZqPHF2BVlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994172; c=relaxed/simple;
	bh=BTh8QBfiCpOAp8ehVoQhAaHVyj9UQ4pdzzWBpwtzV3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfaHCF4CePNh4OFH0rg+FdQr93VVIgr/cuYrVJe3ZfxI5BlzQhtbpBCHSP6dsv+VNG7KnF0NZOzrKrecHnKeFR9ru9MBPED2zPyChJK/Em2R9N6Hnyt5LwkzKt6leKleyvazY7DtGKC7BLQVH9aPLTO9QJSxwo1yevuenPfw5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eWn1ZeVM; arc=none smtp.client-ip=220.197.31.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=oj
	WD06GHzjTWLLkDV6exfr8/+lpHjuxn5tKWlTOQJqQ=; b=eWn1ZeVMYRUqRBiZbY
	j+rb3ZbatcHbvkIvsV+FPVrKA+7CcR+qCdoJNKIuVHC/hdZqJ1A6njJqkNfCFF+k
	5Hm4tNQuPwDUvG4ghQggeZWZr0LN61l9d3lD2KN6ufRSkNKKYkGtioG5zMKOS6HT
	vlMJstRooCJQ3bPDfsYeEIHGk=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wA3CKgql1Vq_LfiIw--.27120S2;
	Tue, 14 Jul 2026 09:55:54 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: linux-rdma@vger.kernel.org
Cc: jgg@nvidia.com,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH v2] RDMA/rxe: Hold netdev reference for transmit skbs
Date: Tue, 14 Jul 2026 09:55:54 +0800
Message-ID: <20260714015554.174436-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713100309.101189-1-15927021679@163.com>
References: <20260713100309.101189-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3CKgql1Vq_LfiIw--.27120S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw48CFyftr1fCrW5Cr1xZrb_yoW7CF4fpF
	4UGa45Kr4fXa129Fn8ArWUZFWSy3W8J3y5KF9Fq345Xrn8C3y2gFnxuryUZF4rCFZ5Gw4a
	qF1jvryDGw4fJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UDR67UUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC8wvfaGpVlyttBAAA3l
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23165-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[15927021679@163.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:jgg@nvidia.com,m:xiongweimin@kylinos.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[15927021679@163.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB2AA750358

From: xiongweimin <xiongweimin@kylinos.cn>

rxe_init_packet() assigns skb->dev from an RCU-protected GID attribute
without holding a netdev reference. If the netdev is unregistered before
the skb is freed, subsequent accesses to skb->dev are unsafe.

Hold a reference with dev_hold() when the skb is initialized and release
it from the transmit destructor or via rxe_put_skb() on error paths that
run before the destructor is installed.

To avoid blocking netdev unregistration on held skbs, flush all QPs to
the error state on NETDEV_GOING_DOWN and NETDEV_UNREGISTER so pending TX
work is drained and references can be dropped.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/infiniband/sw/rxe/rxe_loc.h  |  1 +
 drivers/infiniband/sw/rxe/rxe_net.c  | 48 ++++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_req.c  |  2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c |  4 +--
 4 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 64d636bf8..7c3cc48e8 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -92,6 +92,7 @@ void rxe_mw_cleanup(struct rxe_pool_elem *elem);
 /* rxe_net.c */
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 				int paylen, struct rxe_pkt_info *pkt);
+void rxe_put_skb(struct sk_buff *skb);
 int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
 		struct sk_buff *skb);
 int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 3741b2c4b..44a16cb16 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -441,6 +441,22 @@ static void rxe_skb_tx_dtor(struct sk_buff *skb)
 
 	rxe_put(qp);
 	sock_put(skb->sk);
+	if (skb->dev) {
+		dev_put(skb->dev);
+		skb->dev = NULL;
+	}
+}
+
+/*
+ * Free an skb that still holds a netdev reference from rxe_init_packet()
+ * and does not yet have rxe_skb_tx_dtor() installed. Once the TX
+ * destructor is set, callers must use kfree_skb() instead.
+ */
+void rxe_put_skb(struct sk_buff *skb)
+{
+	if (skb->dev)
+		dev_put(skb->dev);
+	kfree_skb(skb);
 }
 
 static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
@@ -529,7 +545,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	goto done;
 
 drop:
-	kfree_skb(skb);
+	rxe_put_skb(skb);
 	err = 0;
 done:
 	return err;
@@ -574,7 +590,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 
 	skb_reserve(skb, hdr_len + LL_RESERVED_SPACE(ndev));
 
-	/* FIXME: hold reference to this netdev until life of this skb. */
+	dev_hold(ndev);
 	skb->dev	= ndev;
 	rcu_read_unlock();
 
@@ -710,6 +726,28 @@ void rxe_set_port_state(struct rxe_dev *rxe)
 	dev_put(ndev);
 }
 
+/*
+ * Move all QPs to the error state so pending send/recv work is drained and
+ * in-flight TX skbs (which hold a netdev reference) can be released. Called
+ * from the netdev notifier so unregister cannot stall on held skbs.
+ */
+static void rxe_flush_qps(struct rxe_dev *rxe)
+{
+	struct rxe_pool_elem *elem;
+	struct rxe_qp *qp;
+	unsigned long index;
+
+	rcu_read_lock();
+	xa_for_each(&rxe->qp_pool.xa, index, elem) {
+		if (!elem || !kref_get_unless_zero(&elem->ref_cnt))
+			continue;
+		qp = elem->obj;
+		rxe_qp_error(qp);
+		rxe_put(qp);
+	}
+	rcu_read_unlock();
+}
+
 static int rxe_notify(struct notifier_block *not_blk,
 		      unsigned long event,
 		      void *arg)
@@ -721,7 +759,12 @@ static int rxe_notify(struct notifier_block *not_blk,
 		return NOTIFY_OK;
 
 	switch (event) {
+	case NETDEV_GOING_DOWN:
+		/* Start draining TX queues before the netdev disappears. */
+		rxe_flush_qps(rxe);
+		break;
 	case NETDEV_UNREGISTER:
+		rxe_flush_qps(rxe);
 		ib_unregister_device_queued(&rxe->ib_dev);
 		rxe_net_del(&rxe->ib_dev);
 		break;
@@ -735,7 +778,6 @@ static int rxe_notify(struct notifier_block *not_blk,
 			rxe_counter_inc(rxe, RXE_CNT_LINK_DOWNED);
 		break;
 	case NETDEV_REBOOT:
-	case NETDEV_GOING_DOWN:
 	case NETDEV_CHANGEADDR:
 	case NETDEV_CHANGENAME:
 	case NETDEV_FEAT_CHANGE:
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 12d03f390..927ef68de 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -796,7 +796,7 @@ int rxe_requester(struct rxe_qp *qp)
 			wqe->status = IB_WC_LOC_PROT_ERR;
 		else
 			wqe->status = IB_WC_LOC_QP_OP_ERR;
-		kfree_skb(skb);
+		rxe_put_skb(skb);
 		if (ah)
 			rxe_put(ah);
 		goto err;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index d8cbdfa70..ee3630e4b 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -866,7 +866,7 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 
 	err = rxe_prepare(&qp->pri_av, ack, skb);
 	if (err) {
-		kfree_skb(skb);
+		rxe_put_skb(skb);
 		return NULL;
 	}
 
@@ -994,7 +994,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
 			  payload, RXE_FROM_MR_OBJ);
 	if (err) {
-		kfree_skb(skb);
+		rxe_put_skb(skb);
 		state = RESPST_ERR_RKEY_VIOLATION;
 		goto err_out;
 	}
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus


