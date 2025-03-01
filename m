Return-Path: <linux-rdma+bounces-8222-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EC3A4AD86
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 20:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E421895BED
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 19:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A638E1E5B90;
	Sat,  1 Mar 2025 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Da5KzVc7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF51BD9C7
	for <linux-rdma@vger.kernel.org>; Sat,  1 Mar 2025 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740857660; cv=none; b=KirpjyBm8JjKVGanNAE470R+XE22+Ug0OAXLhddQvLTitbOfbDJUE+SVeHaWCIyYKRLFoAuud0+01zvipVz9gEqXNYwDeWT70VG2eZrsPeFoz/3JrPBuQbyzXnrFUv9OfxY/Y8+5612BsQQkuQjJ/2vKDXRW3ncXGqwgTBhTKC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740857660; c=relaxed/simple;
	bh=7u9qufSF5sG9BRhNQl3FOhaNqftaCN9LM30/0wwG7ao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OHvE6yBm21cy4y/iBBiGqpVTC4REsalMQHEIFdlJI5sFofgu5FMn/Q0EiZqm7mGh5iNB6KJKZvdFI8Wj/vW21c0p0pVc7iPhVlI4/qpMChvIwmq7wsxHQiEq3fSDiPzwUhgp7jgAanCbeZZ1bChdb8b/Rk7Auf22Bf7+c82OkZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Da5KzVc7; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740857653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DVZAo5PvgaBz3PeXD+t4PpNFLdkwu315Jyq16nqPacQ=;
	b=Da5KzVc7VztYflLDWak3N+rX/DicvKohebilgcR1hf8bnDTSQmvdeVskqrSB7B3prBr/Ch
	5Kz9Ig61d5N9j4PacxkoOBB/ZFlEQ/B4wMA0pzd07SAh0oMoQUkRIYJNRyaDm6ViUcnlqD
	A/y/7NClWux9HFHZoGpPs0/RFPiGyH8=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH for-upstream 1/1] RDMA/rxe: Replace netdev dev addr with raw_gid
Date: Sat,  1 Mar 2025 20:33:51 +0100
Message-Id: <20250301193351.901749-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Because TUN device does not have dev_addr, but a gid in rdma is needed,
as such, a raw_gid is generated to act as the gid. The similar commit
also exists in SIW. This commit learns from the similar commit
bad5b6e34ffb ("RDMA/siw: Fabricate a GID on tun and loopback devices")
in SIW.

Fixes: 2ac5415022d1 ("RDMA/rxe: Remove the direct link to net_device")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.c       | 20 ++++----------------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  4 +++-
 3 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 5f47c18ba938..00304101c715 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -37,8 +37,6 @@ void rxe_dealloc(struct ib_device *ib_dev)
 /* initialize rxe device parameters */
 static void rxe_init_device_param(struct rxe_dev *rxe)
 {
-	struct net_device *ndev;
-
 	rxe->max_inline_data			= RXE_MAX_INLINE_DATA;
 
 	rxe->attr.vendor_id			= RXE_VENDOR_ID;
@@ -70,17 +68,12 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 	rxe->attr.max_fast_reg_page_list_len	= RXE_MAX_FMR_PAGE_LIST_LEN;
 	rxe->attr.max_pkeys			= RXE_MAX_PKEYS;
 	rxe->attr.local_ca_ack_delay		= RXE_LOCAL_CA_ACK_DELAY;
+	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
 
-	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
-	if (!ndev)
-		return;
+	eth_random_addr(rxe->raw_gid);
 
 	addrconf_addr_eui48((unsigned char *)&rxe->attr.sys_image_guid,
-			ndev->dev_addr);
-
-	dev_put(ndev);
-
-	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
+				rxe->raw_gid);
 
 	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
 		rxe->attr.kernel_cap_flags |= IBK_ON_DEMAND_PAGING;
@@ -133,15 +126,10 @@ static void rxe_init_port_param(struct rxe_port *port)
 static void rxe_init_ports(struct rxe_dev *rxe)
 {
 	struct rxe_port *port = &rxe->port;
-	struct net_device *ndev;
 
 	rxe_init_port_param(port);
-	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
-	if (!ndev)
-		return;
 	addrconf_addr_eui48((unsigned char *)&port->port_guid,
-			    ndev->dev_addr);
-	dev_put(ndev);
+			    rxe->raw_gid);
 	spin_lock_init(&port->port_lock);
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 4f4b3285d818..3de4026897d5 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1526,7 +1526,7 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name,
 	dev->num_comp_vectors = num_possible_cpus();
 	dev->local_dma_lkey = 0;
 	addrconf_addr_eui48((unsigned char *)&dev->node_guid,
-			    ndev->dev_addr);
+				rxe->raw_gid);
 
 	dev->uverbs_cmd_mask |= BIT_ULL(IB_USER_VERBS_CMD_POST_SEND) |
 				BIT_ULL(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 040c89ec25e7..fd48075810dd 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -413,7 +413,9 @@ struct rxe_dev {
 	struct ib_device_attr	attr;
 	int			max_ucontext;
 	int			max_inline_data;
-	struct mutex	usdev_lock;
+	struct mutex		usdev_lock;
+
+	char			raw_gid[ETH_ALEN];
 
 	struct rxe_pool		uc_pool;
 	struct rxe_pool		pd_pool;
-- 
2.34.1


