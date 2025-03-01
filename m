Return-Path: <linux-rdma+bounces-8223-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC27A4AD87
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 20:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72431895C0B
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 19:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9FF1E5B90;
	Sat,  1 Mar 2025 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oj7pnLbt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50EB1BD9C7
	for <linux-rdma@vger.kernel.org>; Sat,  1 Mar 2025 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740857746; cv=none; b=EA3uBQ0Gs6QBDA6jQIkzMjK4WdRavSXeqAa9EbWIJ/4XQF1u9QYQphP0wRrB32361bTbTY6Q4Y/zDB8U0/Ytxavny076Dqx8D74xX6FiedgZ2BKSQxf0AFy+4R1rRUSENMxAF2tJldWXV4labXzNggpeaajdsNeeE3pQ1fFTh2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740857746; c=relaxed/simple;
	bh=gxANAxIgu6oMX6/9jS4s9Vbmd8cZyZwbX2kntNEJaaE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nA7o/NKhVam5FrjkUIeF/j9+d12Zvufqz6vMPollc7aA69+a4o3Fwc02AWpQJfKtroW9dzn3Ne7Rs+JpQutFpCG3kiQk7eSNwj8YS2Jdygwf09EUtZm9ej0IPBBjqoGAN5PKwwq8ntJRO70VccAWv/HqVVXoakf4xOsPH+PdjUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Oj7pnLbt; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740857741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZNzGct8N9KozV3rvqn+xihH43OEJR2ANe7pyXC5dKVQ=;
	b=Oj7pnLbtuUQw4V8uplEnzWbMQeRkk43gkPG23k0mHpKnX3ppWu1nO4PP4Z4+sPljcMXZDn
	vwbPEdIqcqnc+8Xk4rST/OIBPn5AKEdg8jNb2Q7E621KiCyXSme5xvMcDVXEcZDjTa2+Ix
	yeU48FELYt4um2VR0k5ohTsiryE1YdU=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH for-next 1/1] RDMA/rxe: Fix the failure of ibv_query_device() and ibv_query_device_ex() tests
Date: Sat,  1 Mar 2025 20:35:30 +0100
Message-Id: <20250301193530.904720-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In rdma-core, the following failures appear.

"
$ ./build/bin/run_tests.py -k device
ssssssss....FF........s
======================================================================
FAIL: test_query_device (tests.test_device.DeviceTest.test_query_device)
Test ibv_query_device()
----------------------------------------------------------------------
Traceback (most recent call last):
   File "/home/ubuntu/rdma-core/tests/test_device.py", line 63, in
   test_query_device
     self.verify_device_attr(attr, dev)
   File "/home/ubuntu/rdma-core/tests/test_device.py", line 200, in
   verify_device_attr
     assert attr.sys_image_guid != 0
            ^^^^^^^^^^^^^^^^^^^^^^^^
AssertionError

======================================================================
FAIL: test_query_device_ex (tests.test_device.DeviceTest.test_query_device_ex)
Test ibv_query_device_ex()
----------------------------------------------------------------------
Traceback (most recent call last):
   File "/home/ubuntu/rdma-core/tests/test_device.py", line 222, in
   test_query_device_ex
     self.verify_device_attr(attr_ex.orig_attr, dev)
   File "/home/ubuntu/rdma-core/tests/test_device.py", line 200, in
   verify_device_attr
     assert attr.sys_image_guid != 0
            ^^^^^^^^^^^^^^^^^^^^^^^^
AssertionError
"

The root cause is: before a net device is set with rxe, this net device
is used to generate a sys_image_guid.

The solution is from siw commit bad5b6e34ffb ("RDMA/siw: Fabricate
a GID on tun and loopback devices").

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 4e56a371deb5..1ae33f616219 100644
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
@@ -71,26 +69,11 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 	rxe->attr.max_pkeys			= RXE_MAX_PKEYS;
 	rxe->attr.local_ca_ack_delay		= RXE_LOCAL_CA_ACK_DELAY;
 
-	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
-	if (!ndev)
-		return;
-
-	if (ndev->addr_len) {
-		memcpy(rxe->raw_gid, ndev->dev_addr,
-			min_t(unsigned int, ndev->addr_len, ETH_ALEN));
-	} else {
-		/*
-		 * This device does not have a HW address, but
-		 * connection mangagement requires a unique gid.
-		 */
-		eth_random_addr(rxe->raw_gid);
-	}
+	eth_random_addr(rxe->raw_gid);
 
 	addrconf_addr_eui48((unsigned char *)&rxe->attr.sys_image_guid,
 			rxe->raw_gid);
 
-	dev_put(ndev);
-
 	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
 
 	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
@@ -144,15 +127,10 @@ static void rxe_init_port_param(struct rxe_port *port)
 static void rxe_init_ports(struct rxe_dev *rxe)
 {
 	struct rxe_port *port = &rxe->port;
-	struct net_device *ndev;
 
 	rxe_init_port_param(port);
-	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
-	if (!ndev)
-		return;
 	addrconf_addr_eui48((unsigned char *)&port->port_guid,
 			    rxe->raw_gid);
-	dev_put(ndev);
 	spin_lock_init(&port->port_lock);
 }
 
-- 
2.34.1


