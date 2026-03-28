Return-Path: <linux-rdma+bounces-18747-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PonKQagx2m0ZwUAu9opvQ
	(envelope-from <linux-rdma+bounces-18747-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 10:31:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E333F34DEA4
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 10:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA26130484F1
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 09:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3845E373BF7;
	Sat, 28 Mar 2026 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C/Il5QW+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F07374171
	for <linux-rdma@vger.kernel.org>; Sat, 28 Mar 2026 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774690140; cv=none; b=PmlRFVvWulI3Ww4TEv4UzFBqDLE4wS21CyG4pIwzo6JJm3mhfZryysbQQf5E1D3Yv+utXrcSKLErkyN+6qLYSnG9CLReMD7vCDe6kUhf1R7XTWjnC7AjoaZzeLLPs8m7SU67ogYlWKnL53G/aufb/r4+Qzkd8n8FXU++I4AyGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774690140; c=relaxed/simple;
	bh=lm7CjHe8vPHyJKT9bHrJcEmkBQGxKAVk+32c4dZVU4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMWgY/Wk4gt9z3rKee8NXZZ3x9lIb9zXw+VBSyVSHu7YxyN6xeg7xB3y2fpUbfM/EngtL4tjOMFqUMUTpNdgapWbeNShlO360NYCzmYw1KbbxJMWZJMWx/tdNNvjLk38Q/vwN52YGmDmeHHgpf/1lhwGMQ9gtr/bbCCmutUMI4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C/Il5QW+; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774690136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kk5wzbs8IQgTgCYcmMENff4wR4lLw4kugXJ7K5XPx8c=;
	b=C/Il5QW+QQrK30TTCK9U8KIrKmWKQ3R5gLFTEpJ7EogRXYoYaYGvgkZtx6vy4zy78ckLO7
	L+Zz1Cmqy+C9+qa4Hmq/QAd6HMfBdW+qeUA3XG2OTr2EmyXwm+WzNZn+fqT+ulR9/7PDfI
	Yj+0f0erLgSxJQRpssSXANov8/g/thI=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH 1/3] RDMA/rxe: use RXE_PORT instead of magic number 1
Date: Sat, 28 Mar 2026 17:28:36 +0800
Message-ID: <20260328092839.111499-2-zhenwei.pi@linux.dev>
In-Reply-To: <20260328092839.111499-1-zhenwei.pi@linux.dev>
References: <20260328092839.111499-1-zhenwei.pi@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18747-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E333F34DEA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Align with the existing code:
static ... rxe_ib_device_get_netdev(struct ib_device *dev)
{
        return ib_device_get_netdev(dev, RXE_PORT);
}

Use *RXE_PORT* instead of magic number 1 for all.

Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_net.c   | 6 +++---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 0bd0902b11f7..20338cb8e3c2 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -234,7 +234,7 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	udph = udp_hdr(skb);
 	pkt->rxe = rxe;
-	pkt->port_num = 1;
+	pkt->port_num = RXE_PORT;
 	pkt->hdr = (u8 *)(udph + 1);
 	pkt->mask = RXE_GRH_MASK;
 	pkt->paylen = be16_to_cpu(udph->len) - sizeof(*udph);
@@ -535,7 +535,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 	struct sk_buff *skb = NULL;
 	struct net_device *ndev;
 	const struct ib_gid_attr *attr;
-	const int port_num = 1;
+	const int port_num = RXE_PORT;
 
 	attr = rdma_get_gid_attr(&rxe->ib_dev, port_num, av->grh.sgid_index);
 	if (IS_ERR(attr))
@@ -630,7 +630,7 @@ static void rxe_port_event(struct rxe_dev *rxe,
 	struct ib_event ev;
 
 	ev.device = &rxe->ib_dev;
-	ev.element.port_num = 1;
+	ev.element.port_num = RXE_PORT;
 	ev.event = event;
 
 	ib_dispatch_event(&ev);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index fe41362c5144..bcd486e8668b 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -44,7 +44,7 @@ static int rxe_query_port(struct ib_device *ibdev,
 	struct net_device *ndev;
 	int err, ret;
 
-	if (port_num != 1) {
+	if (port_num != RXE_PORT) {
 		err = -EINVAL;
 		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
 		goto err_out;
@@ -147,7 +147,7 @@ static int rxe_modify_port(struct ib_device *ibdev, u32 port_num,
 	struct rxe_port *port;
 	int err;
 
-	if (port_num != 1) {
+	if (port_num != RXE_PORT) {
 		err = -EINVAL;
 		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
 		goto err_out;
@@ -180,7 +180,7 @@ static enum rdma_link_layer rxe_get_link_layer(struct ib_device *ibdev,
 	struct rxe_dev *rxe = to_rdev(ibdev);
 	int err;
 
-	if (port_num != 1) {
+	if (port_num != RXE_PORT) {
 		err = -EINVAL;
 		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
 		goto err_out;
@@ -200,7 +200,7 @@ static int rxe_port_immutable(struct ib_device *ibdev, u32 port_num,
 	struct ib_port_attr attr = {};
 	int err;
 
-	if (port_num != 1) {
+	if (port_num != RXE_PORT) {
 		err = -EINVAL;
 		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
 		goto err_out;
-- 
2.43.0


