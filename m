Return-Path: <linux-rdma+bounces-19120-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOJrDPKc1Wks8AcAu9opvQ
	(envelope-from <linux-rdma+bounces-19120-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Apr 2026 02:10:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AC73B599A
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Apr 2026 02:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AAC830309A1
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Apr 2026 00:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6945918C2C;
	Wed,  8 Apr 2026 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FEMy4yHZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0D51400C
	for <linux-rdma@vger.kernel.org>; Wed,  8 Apr 2026 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775607020; cv=none; b=i8PtuYyr4UBTQpGeX84mwiSPUa96u1au+Rye6E5Ejd47jrA+5SRmb0kl6qsIBpLuycV7FjCu/Mv+Bw+Hmey5l6QMMGAvud4fSskViIJgx4U3gQazvrJ2nj287/vOpbWwBp+8m/75Vco1BAgdz5RV+QWd+H+Wp3DdCHZneUF2h7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775607020; c=relaxed/simple;
	bh=cw4GjcWsuYnUl046fx3PRCDnY8sVbCME0H9EzD/IhbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MV35uc+lXBpwn1DznwThFQVmko7K5Xk7cgfL89CgUOQ2pL9ytUlDXltgd2a0xiNt/e+TpfnXrbdcE+Bja6Ou2iLBxpBSZ68zZTx/kWV6zi/fbQ1zzvYq4yC1jxfo+3AqwMyMBOERe4NJW9pJ1sJlgyov53Fqgq1bbdAcqSW4nlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FEMy4yHZ; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775607016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRFy4q6+w0PLU2dSrVBHct706edyWSjeEhmFgbFlE9k=;
	b=FEMy4yHZJCq05oobZMjtd6soH90YZQWLnxVl4KDoHbfZRicKJ/+O97qeeAQhF1tzMuhhZf
	O5uYRVU6b7/7HZR8oiByalXGPJhvcKAijrpapeee06pa0yStGICJPXrAJ5AQs4tHrvk8Y5
	U6Xbp4HEU4eeV93OrTML3kn6dz92TYg=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH v5 1/3] RDMA/rxe: remove rxe_ib_device_get_netdev() and RXE_PORT
Date: Wed,  8 Apr 2026 08:09:54 +0800
Message-ID: <20260408000956.486522-2-zhenwei.pi@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19120-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1AC73B599A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Suggested by Leon, remove the rxe_ib_device_get_netdev() wrapper and
the RXE_PORT definition. These additions do not improve readability,
and RXE has always had only a single port.

Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 4 ++--
 drivers/infiniband/sw/rxe/rxe_net.c   | 7 +++----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 4 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.h | 6 ------
 4 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 5cad72073eca..acd03bd87794 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -34,7 +34,7 @@ static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
 	struct net_device *ndev;
 	int ret;
 
-	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
+	ndev = ib_device_get_netdev(&rxe->ib_dev, 1);
 	if (!ndev)
 		return -ENODEV;
 
@@ -59,7 +59,7 @@ static int rxe_mcast_del(struct rxe_dev *rxe, union ib_gid *mgid)
 	struct net_device *ndev;
 	int ret;
 
-	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
+	ndev = ib_device_get_netdev(&rxe->ib_dev, 1);
 	if (!ndev)
 		return -ENODEV;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 211bd3000acc..6621d01ac32d 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -602,7 +602,7 @@ const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num)
 	struct net_device *ndev;
 	char *ndev_name;
 
-	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
+	ndev = ib_device_get_netdev(&rxe->ib_dev, 1);
 	if (!ndev)
 		return NULL;
 	ndev_name = ndev->name;
@@ -646,12 +646,11 @@ static void rxe_sock_put(struct sock *sk,
 
 void rxe_net_del(struct ib_device *dev)
 {
-	struct rxe_dev *rxe = container_of(dev, struct rxe_dev, ib_dev);
 	struct net_device *ndev;
 	struct sock *sk;
 	struct net *net;
 
-	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
+	ndev = ib_device_get_netdev(dev, 1);
 	if (!ndev)
 		return;
 
@@ -699,7 +698,7 @@ void rxe_set_port_state(struct rxe_dev *rxe)
 {
 	struct net_device *ndev;
 
-	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
+	ndev = ib_device_get_netdev(&rxe->ib_dev, 1);
 	if (!ndev)
 		return;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 4d4891dc2884..eb17b6086d5e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -50,7 +50,7 @@ static int rxe_query_port(struct ib_device *ibdev,
 		goto err_out;
 	}
 
-	ndev = rxe_ib_device_get_netdev(ibdev);
+	ndev = ib_device_get_netdev(ibdev, 1);
 	if (!ndev) {
 		err = -ENODEV;
 		goto err_out;
@@ -1441,7 +1441,7 @@ static int rxe_enable_driver(struct ib_device *ib_dev)
 	struct rxe_dev *rxe = container_of(ib_dev, struct rxe_dev, ib_dev);
 	struct net_device *ndev;
 
-	ndev = rxe_ib_device_get_netdev(ib_dev);
+	ndev = ib_device_get_netdev(ib_dev, 1);
 	if (!ndev)
 		return -ENODEV;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index d92f80d16f78..e800545d1046 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -415,7 +415,6 @@ struct rxe_port {
 	u32			qp_gsi_index;
 };
 
-#define	RXE_PORT	1
 struct rxe_dev {
 	struct ib_device	ib_dev;
 	struct ib_device_attr	attr;
@@ -451,11 +450,6 @@ struct rxe_dev {
 	struct rxe_port		port;
 };
 
-static inline struct net_device *rxe_ib_device_get_netdev(struct ib_device *dev)
-{
-	return ib_device_get_netdev(dev, RXE_PORT);
-}
-
 static inline void rxe_counter_inc(struct rxe_dev *rxe, enum rxe_counters index)
 {
 	atomic64_inc(&rxe->stats_counters[index]);
-- 
2.43.0


