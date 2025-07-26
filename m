Return-Path: <linux-rdma+bounces-12488-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE5DB1286E
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Jul 2025 03:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA1D1CC3118
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Jul 2025 01:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263061922FA;
	Sat, 26 Jul 2025 01:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sEUgeirO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEDC72635
	for <linux-rdma@vger.kernel.org>; Sat, 26 Jul 2025 01:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753493486; cv=none; b=HJgxztCuJAr5bUlMPQOrMe953Bb/OEDvFJe8oH16leJpldF7c7OYWh4H6wD+yQ5bk8QgY6NZEDDCZ+PeFtGK/IuCtxW04Sgigo71++qc1g/wYPp6EDkPXRHlz5qkym93B4BRo+j7DB6P05fgGvgZvIgLGOgSXzQUmibqlhH8J8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753493486; c=relaxed/simple;
	bh=SYlwH3LJZ9Tk7Uvw3lKXM4fY1POFDvv8Mq1Cfae8Uxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sakcbCzASqkOQK2NXURTaaf6nGXbKjpzpZ6FYK9OQOTM6TsPso/nINYKitQ5IK9rKnOKks2Kk3W6aYG6EfBEwAtscBfqw6JRgErC5nfQR8RrXHe9A/DxL/ks59q9NGFb9FTm0zrVOclAue6xmGvHT87GP9TmaikQvsaAoJismi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sEUgeirO; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753493482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wm6kN+a6w9ahJ3ekoduwpjeSW0IMMcv+PYs3XUTCi2E=;
	b=sEUgeirOOiqP/tTJV7Q2HiUfG6CQB04oReQm23F/DBuraux3Q+7UflcJTvp9lpzGkQiWqW
	eHsewGxvlt88PFnWLMAKGqfRXO3LIZ8GJTAjszioX72CZDVHJG5Cn5nJo9CB1jBbjFEKOL
	3E4ZVsRZQL/0Mvw+H0I5ZZUqfLfSESo=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
	syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com
Subject: [PATCH rdma-next 1/1] RDMA/rxe: Fix rxe_skb_tx_dtor problem
Date: Fri, 25 Jul 2025 18:31:04 -0700
Message-ID: <20250726013104.463570-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When skb packets are sent out, these skb packets still depends on
the rxe resources, for example, QP, sk, when these packets are
destroyed.

If these rxe resources are released when the skb packets are destroyed,
the call traces will appear.

To avoid skb packets hang too long time in some network devices,
a timestamp is added when these skb packets are created. If these
skb packets hang too long time in network devices, these network
devices can free these skb packets to release rxe resources.

Reported-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153
Tested-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com
Fixes: 1a633bdc8fd9 ("RDMA/rxe: Let destroy qp succeed with stuck packet")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 29 ++++++++---------------------
 drivers/infiniband/sw/rxe/rxe_qp.c  |  2 +-
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 132a87e52d5c..ac0183a2ff7a 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -345,33 +345,15 @@ int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
 
 static void rxe_skb_tx_dtor(struct sk_buff *skb)
 {
-	struct net_device *ndev = skb->dev;
-	struct rxe_dev *rxe;
-	unsigned int qp_index;
-	struct rxe_qp *qp;
+	struct rxe_qp *qp = skb->sk->sk_user_data;
 	int skb_out;
 
-	rxe = rxe_get_dev_from_net(ndev);
-	if (!rxe && is_vlan_dev(ndev))
-		rxe = rxe_get_dev_from_net(vlan_dev_real_dev(ndev));
-	if (WARN_ON(!rxe))
-		return;
-
-	qp_index = (int)(uintptr_t)skb->sk->sk_user_data;
-	if (!qp_index)
-		return;
-
-	qp = rxe_pool_get_index(&rxe->qp_pool, qp_index);
-	if (!qp)
-		goto put_dev;
-
 	skb_out = atomic_dec_return(&qp->skb_out);
-	if (qp->need_req_skb && skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW)
+	if (unlikely(qp->need_req_skb &&
+		skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
 		rxe_sched_task(&qp->send_task);
 
 	rxe_put(qp);
-put_dev:
-	ib_device_put(&rxe->ib_dev);
 	sock_put(skb->sk);
 }
 
@@ -383,6 +365,7 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	sock_hold(sk);
 	skb->sk = sk;
 	skb->destructor = rxe_skb_tx_dtor;
+	rxe_get(pkt->qp);
 	atomic_inc(&pkt->qp->skb_out);
 
 	if (skb->protocol == htons(ETH_P_IP))
@@ -405,6 +388,7 @@ static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	sock_hold(sk);
 	skb->sk = sk;
 	skb->destructor = rxe_skb_tx_dtor;
+	rxe_get(pkt->qp);
 	atomic_inc(&pkt->qp->skb_out);
 
 	if (skb->protocol == htons(ETH_P_IP))
@@ -497,6 +481,9 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 		goto out;
 	}
 
+	/* Add time stamp to skb. */
+	skb->tstamp = ktime_get();
+
 	skb_reserve(skb, hdr_len + LL_RESERVED_SPACE(ndev));
 
 	/* FIXME: hold reference to this netdev until life of this skb. */
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index f2af3e0aef35..95f1c1c2949d 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -244,7 +244,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
 	if (err < 0)
 		return err;
-	qp->sk->sk->sk_user_data = (void *)(uintptr_t)qp->elem.index;
+	qp->sk->sk->sk_user_data = qp;
 
 	/* pick a source UDP port number for this QP based on
 	 * the source QPN. this spreads traffic for different QPs
-- 
2.50.1


