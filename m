Return-Path: <linux-rdma+bounces-19121-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MueIQqd1Wks8AcAu9opvQ
	(envelope-from <linux-rdma+bounces-19121-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Apr 2026 02:10:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6393B59B0
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Apr 2026 02:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39651301A15B
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Apr 2026 00:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675C3824A3;
	Wed,  8 Apr 2026 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CqruLoys"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D9438DD3
	for <linux-rdma@vger.kernel.org>; Wed,  8 Apr 2026 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775607027; cv=none; b=e0jHQEDM015QnDLp8txHyAVRyTzFzUDZzxeMBzd2wyI+kykVqeWgmqPJiWI/lF8CQmOO+38NrkBc5acT2IpnMRxK+yjnAFtZHNLUOkCSC/saIMPzqcJW8KTKG3q6mPIuv0a2h6onBF5TvJFw7fnSRCKicWVEuXWS76qxU0AU3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775607027; c=relaxed/simple;
	bh=ELC5Aa2urYtusIfibB/7Fu6EIJmnCqfSr71rffWhcMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHzaBWY09m/PWLtZzPFzbGE9LyuzFw7GzpD3YB+oteS3K7zuf/imQtFi6ApTfShKUPnFtrxqGHWzp8av9oaoB+sXACLh1QAmyAMJVkN8e9VE3anudUDqEqnQ7BfKlQQDTC/zyCDpo8xwVm6lDQYGp/XNssBSaHwev52r6SQewTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CqruLoys; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775607024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khPAm7yRKyvsyjet7XrXUNeDJARjrHbHUKpjHIDa6EI=;
	b=CqruLoysXE+INNlYxG8Qomhmn2Z63xfPm3vGshgIwBR61EQfG5RSF1SQ0vPphb4x6/RRKl
	wSmVQOvzAOQmZPG/hzOE2Av5U/K30imtE1U+toh4njvaZIAq8U/KeqWT8xi78i7JHb/Doo
	EBfYD/j7XfsZowSTaPr8qGlFUTj3+LE=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH v5 2/3] RDMA/rxe: add SENT/RCVD bytes
Date: Wed,  8 Apr 2026 08:09:55 +0800
Message-ID: <20260408000956.486522-3-zhenwei.pi@linux.dev>
In-Reply-To: <20260408000956.486522-1-zhenwei.pi@linux.dev>
References: <20260408000956.486522-1-zhenwei.pi@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19121-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 9D6393B59B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is a lack of sent/received counter in bytes.

Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_hw_counters.c | 2 ++
 drivers/infiniband/sw/rxe/rxe_hw_counters.h | 2 ++
 drivers/infiniband/sw/rxe/rxe_net.c         | 2 ++
 drivers/infiniband/sw/rxe/rxe_recv.c        | 2 ++
 drivers/infiniband/sw/rxe/rxe_verbs.h       | 6 ++++++
 5 files changed, 14 insertions(+)

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
index 5861e4244049..e7bab89e7d8d 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -318,6 +318,7 @@ void rxe_rcv(struct sk_buff *skb)
 	int err;
 	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
 	struct rxe_dev *rxe = pkt->rxe;
+	unsigned int skblen = skb->len - skb_network_offset(skb);
 
 	if (unlikely(skb->len < RXE_BTH_BYTES))
 		goto drop;
@@ -341,6 +342,7 @@ void rxe_rcv(struct sk_buff *skb)
 	if (unlikely(err))
 		goto drop;
 
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


