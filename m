Return-Path: <linux-rdma+bounces-18755-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI7XJdSUyGmpngUAu9opvQ
	(envelope-from <linux-rdma+bounces-18755-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 04:56:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 830C3350784
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 04:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 796923007211
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 02:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D96924A07C;
	Sun, 29 Mar 2026 02:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EZi+t/Ez"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB32475CB
	for <linux-rdma@vger.kernel.org>; Sun, 29 Mar 2026 02:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774752970; cv=none; b=fAuOB8vrBhcDZT3KjMssLL/B1OfvVd2sGvSAH5evJUTCakaIhh1e+FRE8TWi1J0YQp0qd48KYxioHmmuIf5gOo906dN7AGsMNywUr4jA5YvtZKi0EZupGVHa9lZmo3sDq7udzgj9b9pJR1nqhthjNBPO6oXlbm4ZaLADGQOELJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774752970; c=relaxed/simple;
	bh=lm7CjHe8vPHyJKT9bHrJcEmkBQGxKAVk+32c4dZVU4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXWGbI9VGrQwVaD9LOVoQW1S1oxT9FnZgg3D66wV3gxOubND7x5Idvh7H72zIQFL0HasLvJRnKmX5MN2cu/Hqk5FZZgIQI/VbmAqTjgqprGgzb8OfBni8nHsxPPCWEN+EhBpds6pImEslWZ60f82QAzcfswmNL1mJyPBkZRvLKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EZi+t/Ez; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774752966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kk5wzbs8IQgTgCYcmMENff4wR4lLw4kugXJ7K5XPx8c=;
	b=EZi+t/Ezl2X9i3Ub6ii0zqB0mOSEgTZjJzXikO6uHupNbUsxFg3KEOwZJKGOjD+w0Dog3f
	Kvidh5qgUoNOw3rx33xduJYq2hEcpgUw9BBubKRi6YU7olhs/wlFQ4XdqPagKRrOouMFZC
	W13zE5Hgtnkek2PUpnHrzjO1zkFU6ks=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH v2 1/4] RDMA/rxe: use RXE_PORT instead of magic number 1
Date: Sun, 29 Mar 2026 10:55:49 +0800
Message-ID: <20260329025552.122946-2-zhenwei.pi@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18755-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 830C3350784
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


