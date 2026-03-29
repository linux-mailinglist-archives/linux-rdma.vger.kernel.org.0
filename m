Return-Path: <linux-rdma+bounces-18756-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC70HdKUyGmSngUAu9opvQ
	(envelope-from <linux-rdma+bounces-18756-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 04:56:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0507735077D
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 04:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E452D30098BB
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 02:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6631DDC3F;
	Sun, 29 Mar 2026 02:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t/YtAKcG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E19B2475CB
	for <linux-rdma@vger.kernel.org>; Sun, 29 Mar 2026 02:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774752973; cv=none; b=BZ3Dz72ZDHuH9yqbfcivwjy2LzJEgqyUKJw/YZx5x+vxam2JPUhY+m2iSwVxXG4G/GoZ2qMYnqYbbI1/qj3iF5VL2S6YOjMCAMEH3LsXI4rIL1mZPqWVI7YLCfmRpxJ7YVa8zf4g3m7sO7pQ3E71VY6e4LCDh74hh9+7nSe+sCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774752973; c=relaxed/simple;
	bh=pEcpNu/97z4wIwjxOudxG2IkzxcXZX6qKiFolAmAEWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyPwlps3/3G/+mTm6XbGtRAqJONvb5jpeOWVeFtD03ZM5WJACKBUhZXsk1ArwyMYXHt9yyCz5qWh5sFw8fVG7UDub/Ca9b3v/QYRQfOPnCbvlbsEaBp3bUHwCjgMfRYDTwvqJMrl2R8DZadMItpG7Kbnr7JLc8eR4YHER3ghhEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t/YtAKcG; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774752969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=La2Y59/O6uJYVNjE8wLPFiI8k2gy7IhgTeNJ+XJxkgk=;
	b=t/YtAKcGiglPRhVOO1HJZtwyhrTQVcFBEKpU1+IuobdarOihRFwvRvr7suRbnuptYlFf1R
	0hKdkmTEfDYQA5h/tSehDIudqPWqBFmIjwWiSVwa7VcBQhMY6GdIck387VcEZDRHWn3OqG
	/79dwftto1T3VB+wA9VAR8PSLsc5iyU=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH v2 2/4] RDMA/rxe: add SENT/RCVD bytes
Date: Sun, 29 Mar 2026 10:55:50 +0800
Message-ID: <20260329025552.122946-3-zhenwei.pi@linux.dev>
In-Reply-To: <20260329025552.122946-1-zhenwei.pi@linux.dev>
References: <20260329025552.122946-1-zhenwei.pi@linux.dev>
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
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18756-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenwei.pi@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0507735077D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is a lack of sent/received counter in bytes.

Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_hw_counters.c | 2 ++
 drivers/infiniband/sw/rxe/rxe_hw_counters.h | 2 ++
 drivers/infiniband/sw/rxe/rxe_net.c         | 1 +
 drivers/infiniband/sw/rxe/rxe_recv.c        | 1 +
 drivers/infiniband/sw/rxe/rxe_verbs.h       | 6 ++++++
 5 files changed, 12 insertions(+)

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
index 20338cb8e3c2..ec0ae7479fe7 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -519,6 +519,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	}
 
 	rxe_counter_inc(rxe, RXE_CNT_SENT_PKTS);
+	rxe_counter_add(rxe, RXE_CNT_SENT_BYTES, skb->len);
 	goto done;
 
 drop:
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 5861e4244049..b5522017852d 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -342,6 +342,7 @@ void rxe_rcv(struct sk_buff *skb)
 		goto drop;
 
 	rxe_counter_inc(rxe, RXE_CNT_RCVD_PKTS);
+	rxe_counter_add(rxe, RXE_CNT_RCVD_BYTES, skb->len);
 
 	if (unlikely(bth_qpn(pkt) == IB_MULTICAST_QPN))
 		rxe_rcv_mcast_pkt(rxe, skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index fb149f37e91d..2bcfb919a40b 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -460,6 +460,12 @@ static inline void rxe_counter_inc(struct rxe_dev *rxe, enum rxe_counters index)
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


