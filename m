Return-Path: <linux-rdma+bounces-23252-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JgEzDXMsV2qzGwEAu9opvQ
	(envelope-from <linux-rdma+bounces-23252-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 08:45:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 880DB75B30D
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 08:45:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=ipP7f2kc;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23252-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23252-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3502F300C5BF
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 06:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E901431A56C;
	Wed, 15 Jul 2026 06:42:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3693931353C
	for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2026 06:42:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097728; cv=none; b=hNMZq0p5DmWQkePTGxzlT9bQ0SGOyPZGDj8zf7VX7/htc5adUuKZrl22JRTeAsPgQcjfXSNO3JlPCNN5JuwBF8rbdtYC1yYqMWWUr8BNgB81Tw8SvvvLLuuTBxxAFr0rxliKOpXZC2hmYnXWj7xaA/zIZGgvzTcdOyTglhKerEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097728; c=relaxed/simple;
	bh=rBLGuU/UBeTVlSDCyWSLBkNaMGuSkWwvYhR8ki2ViHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6m/6fDrgikt+IwPTSyQ9hy+xRfrZ8XZrRN6q19/4CcbRYWtFCmdt5+nQAGVpgWFL32nHCPJ9VLcUoNBzR12HvJLlimZU7NM9/kDPQNMIi4Si5kO3+EMcip5t2ztgp1ahoLpWYpdzVqOgQudUQhP/tcT9gTQxo5VtNnpmBr5gAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ipP7f2kc; arc=none smtp.client-ip=117.135.210.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mH
	92X5E20VCV29YiLTTc7ShOS6E0fS7VGemdYBtNkbs=; b=ipP7f2kc3HRILS6K01
	FrkbpCPMIIYQ06+seL/FmkeUdVmd0Tcu31MKl6Hx92ijzEkl12245GAvMCYXIDC/
	fl07Xf2KpjLqKjrziESFDG5zrmLm3twwODbOzI0MtI4hG62O9Q5tzcM/rpQXeNzB
	XyLTWPctHPvUZHaPRMBLASvCg=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDXfmGoK1dqaAedJg--.173S2;
	Wed, 15 Jul 2026 14:41:44 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: linux-rdma@vger.kernel.org
Cc: jgg@nvidia.com,
	zyjzyj2000@gmail.com,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH v3] RDMA/rxe: Hold netdev reference for transmit skbs
Date: Wed, 15 Jul 2026 14:41:49 +0800
Message-ID: <20260715064149.283009-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714015554.174436-1-15927021679@163.com>
References: <20260714015554.174436-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXfmGoK1dqaAedJg--.173S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw48CFyftrykWF1DAF4kCrg_yoWxuw15pF
	4UGay5Kr4xXa129Fn0yrWUZFWay3W8Ja98KF9Fq34Yvrn8Cw47WFsxuryUZF45CFZ5Gw4a
	qF1jyr98Ga1fGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UK-erUUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC8whl7WpXK6iLOwAA39
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23252-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[15927021679@163.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:jgg@nvidia.com,m:zyjzyj2000@gmail.com,m:xiongweimin@kylinos.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[15927021679@163.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kylinos.cn];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 880DB75B30D

From: xiongweimin <xiongweimin@kylinos.cn>

rxe_init_packet() assigns skb->dev from an RCU-protected GID attribute
without holding a netdev reference. If the netdev is unregistered before
the skb is freed, subsequent accesses to skb->dev are unsafe.

Hold a reference with dev_hold() when the skb is initialized and release
it from the transmit destructor or via rxe_put_skb() on error paths that
run before the destructor is installed.

skb->dev can change on the TX path (VLAN/bond/tunnel, ip_finish_output2,
etc.), so put must use the same netdev that was held. Stash that pointer
in skb_shinfo()->destructor_arg: skb->cb is already used by
rxe_pkt_info and is rewritten by IP control blocks.

To avoid blocking netdev unregistration on held skbs, flush all QPs to
the error state on NETDEV_GOING_DOWN and NETDEV_UNREGISTER so pending TX
work is drained and references can be dropped.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
v3:
- put the held netdev from destructor_arg, not live skb->dev
  (skb->dev may be rewritten by the TX stack)

v2:
- rebase on current mainline so the patch applies cleanly
- flush all QPs on NETDEV_GOING_DOWN and NETDEV_UNREGISTER to
  release pending TX skbs before netdev unregister
---
 drivers/infiniband/sw/rxe/rxe_loc.h  |  1 +
 drivers/infiniband/sw/rxe/rxe_net.c  | 68 ++++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_req.c  |  2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c |  4 +-
 4 files changed, 68 insertions(+), 7 deletions(-)

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
index 3741b2c4b..86c9b19f6 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -429,6 +429,29 @@ int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
 	return err;
 }
 
+/*
+ * skb->dev may be rewritten on the TX path (VLAN/bond/tunnel, etc.).
+ * The netdev we held in rxe_init_packet() is kept in destructor_arg so
+ * that put always matches hold. skb->cb cannot be used: it is already
+ * occupied by struct rxe_pkt_info and rewritten by IP control blocks.
+ */
+static void rxe_skb_set_held_ndev(struct sk_buff *skb, struct net_device *ndev)
+{
+	dev_hold(ndev);
+	skb->dev = ndev;
+	skb_shinfo(skb)->destructor_arg = ndev;
+}
+
+static void rxe_skb_put_held_ndev(struct sk_buff *skb)
+{
+	struct net_device *ndev = skb_shinfo(skb)->destructor_arg;
+
+	if (ndev) {
+		skb_shinfo(skb)->destructor_arg = NULL;
+		dev_put(ndev);
+	}
+}
+
 static void rxe_skb_tx_dtor(struct sk_buff *skb)
 {
 	struct rxe_qp *qp = skb->sk->sk_user_data;
@@ -441,6 +464,18 @@ static void rxe_skb_tx_dtor(struct sk_buff *skb)
 
 	rxe_put(qp);
 	sock_put(skb->sk);
+	rxe_skb_put_held_ndev(skb);
+}
+
+/*
+ * Free an skb that still holds a netdev reference from rxe_init_packet()
+ * and does not yet have rxe_skb_tx_dtor() installed. Once the TX
+ * destructor is set, callers must use kfree_skb() instead.
+ */
+void rxe_put_skb(struct sk_buff *skb)
+{
+	rxe_skb_put_held_ndev(skb);
+	kfree_skb(skb);
 }
 
 static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
@@ -529,7 +564,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	goto done;
 
 drop:
-	kfree_skb(skb);
+	rxe_put_skb(skb);
 	err = 0;
 done:
 	return err;
@@ -574,8 +609,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 
 	skb_reserve(skb, hdr_len + LL_RESERVED_SPACE(ndev));
 
-	/* FIXME: hold reference to this netdev until life of this skb. */
-	skb->dev	= ndev;
+	rxe_skb_set_held_ndev(skb, ndev);
 	rcu_read_unlock();
 
 	if (av->network_type == RXE_NETWORK_TYPE_IPV4)
@@ -710,6 +744,28 @@ void rxe_set_port_state(struct rxe_dev *rxe)
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
@@ -721,7 +777,12 @@ static int rxe_notify(struct notifier_block *not_blk,
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
@@ -735,7 +796,6 @@ static int rxe_notify(struct notifier_block *not_blk,
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


