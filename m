Return-Path: <linux-rdma+bounces-19037-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eArLBzm102nLkgcAu9opvQ
	(envelope-from <linux-rdma+bounces-19037-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 15:29:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0735E3A38BD
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 15:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04C23300A33B
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BDD374195;
	Mon,  6 Apr 2026 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EN8GrFne"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D94372EE3
	for <linux-rdma@vger.kernel.org>; Mon,  6 Apr 2026 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482148; cv=none; b=e3UUTXL3Phy4OYe45CJbqBIOJpcu4Yjs2koDiswcClb42dDigalo/Z/vtZCT3wjKimaWNTV7vnGHtAcTOR4ab17vb6m+730jjy4lb6RgPN0rbNLB7sd01SW6x4ImqGrpvLWTLxIZz2H5W6aAszUCLhJz9EAe84+gAIxoQIh0BOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482148; c=relaxed/simple;
	bh=Ufl15mbQo+7C3CIxVRsGI7LULJ2Z/nqj2OO4kNnY4Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+FunjTJ7h1Ek9L+PhuziJg3dxFmC36eW/WSPuHLfMrZOCYRfLnSFcRlJ+Bv75sxnQuVktYcEi0OJRL5Gc/cAAdFAxG5G9rPmnw6wA3A4w0FacVLBIYcCEvEn4c0MAqLxv5rgUfJfhX8Tc4Fz36AJ13mgNNMMQsDh1PS8Ux8i3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EN8GrFne; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775482145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/OnNQjJT/T9qW97tpprZs0Xz1E0ZXmQRu9U/Jly9xA=;
	b=EN8GrFneshN9ShF38pwluNW0pKqJEXUyBDlDZa4Tozap7GSgpJd/1/qh7lztCNQymBPmmS
	RpNG4fxmZJKF5vpwNqdITMn0eyQMZ8BlxEZH7pbL9jQDwqG8w0gqkw6pUhGpMN0GvEAXiJ
	rAB4G6osvsdvv2tXDonN7bDJt5r+yYE=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH v4 3/4] RDMA/rxe: add SENT/RCVD bytes
Date: Mon,  6 Apr 2026 21:28:28 +0800
Message-ID: <20260406132830.435381-4-zhenwei.pi@linux.dev>
In-Reply-To: <20260406132830.435381-1-zhenwei.pi@linux.dev>
References: <20260406132830.435381-1-zhenwei.pi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19037-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenwei.pi@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 0735E3A38BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is a lack of sent/received counter in bytes.

Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_hw_counters.c | 2 ++
 drivers/infiniband/sw/rxe/rxe_hw_counters.h | 2 ++
 drivers/infiniband/sw/rxe/rxe_net.c         | 2 ++
 drivers/infiniband/sw/rxe/rxe_recv.c        | 6 ++++++
 drivers/infiniband/sw/rxe/rxe_verbs.h       | 6 ++++++
 5 files changed, 18 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.c b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
index 437917a7d8f2..17edaa9a9b9b 100644
--- a/drivers/infiniband/sw/rxe/rxe_hw_counters.c
+++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
@@ -22,6 +22,8 @@ static const struct rdma_stat_desc rxe_counter_descs[] = {
 	[RXE_CNT_LINK_DOWNED].name         =  "link_downed",
 	[RXE_CNT_RDMA_SEND].name           =  "rdma_sends",
 	[RXE_CNT_RDMA_RECV].name           =  "rdma_recvs",
+	[RXE_CNT_SENT_BYTES].name          =  "sent_bytes",
+	[RXE_CNT_RCVD_BYTES].name          =  "rcvd_bytes",
 };
 
 int rxe_ib_get_hw_stats(struct ib_device *ibdev,
diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.h b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
index 051f9e1c3852..01b355103cbc 100644
--- a/drivers/infiniband/sw/rxe/rxe_hw_counters.h
+++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
@@ -26,6 +26,8 @@ enum rxe_counters {
 	RXE_CNT_LINK_DOWNED,
 	RXE_CNT_RDMA_SEND,
 	RXE_CNT_RDMA_RECV,
+	RXE_CNT_SENT_BYTES,
+	RXE_CNT_RCVD_BYTES,
 	RXE_NUM_OF_COUNTERS
 };
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 6621d01ac32d..86660031ffa2 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -503,6 +503,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	int err;
 	int is_request = pkt->mask & RXE_REQ_MASK;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	unsigned int skblen = skb->len;
 	unsigned long flags;
 
 	spin_lock_irqsave(&qp->state_lock, flags);
@@ -526,6 +527,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	}
 
 	rxe_counter_inc(rxe, RXE_CNT_SENT_PKTS);
+	rxe_counter_add(rxe, RXE_CNT_SENT_BYTES, skblen);
 	goto done;
 
 drop:
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 5861e4244049..0d9112e95eae 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -318,6 +318,7 @@ void rxe_rcv(struct sk_buff *skb)
 	int err;
 	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
 	struct rxe_dev *rxe = pkt->rxe;
+	unsigned int skblen = skb->len + sizeof(struct udphdr);
 
 	if (unlikely(skb->len < RXE_BTH_BYTES))
 		goto drop;
@@ -341,6 +342,11 @@ void rxe_rcv(struct sk_buff *skb)
 	if (unlikely(err))
 		goto drop;
 
+	if (skb->protocol == htons(ETH_P_IP))
+		skblen += sizeof(struct iphdr);
+	else if (skb->protocol == htons(ETH_P_IPV6))
+		skblen += sizeof(struct ipv6hdr);
+	rxe_counter_add(rxe, RXE_CNT_RCVD_BYTES, skblen);
 	rxe_counter_inc(rxe, RXE_CNT_RCVD_PKTS);
 
 	if (unlikely(bth_qpn(pkt) == IB_MULTICAST_QPN))
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index e800545d1046..0f5ffd94643f 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -455,6 +455,12 @@ static inline void rxe_counter_inc(struct rxe_dev *rxe, enum rxe_counters index)
 	atomic64_inc(&rxe->stats_counters[index]);
 }
 
+static inline void rxe_counter_add(struct rxe_dev *rxe, enum rxe_counters index,
+				   s64 val)
+{
+	atomic64_add(val, &rxe->stats_counters[index]);
+}
+
 static inline struct rxe_dev *to_rdev(struct ib_device *dev)
 {
 	return dev ? container_of(dev, struct rxe_dev, ib_dev) : NULL;
-- 
2.43.0


