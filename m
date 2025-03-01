Return-Path: <linux-rdma+bounces-8225-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3F1A4AE58
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 00:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8A43A7A5F
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 23:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96811BFE00;
	Sat,  1 Mar 2025 23:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YbriyAti"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC61D5178
	for <linux-rdma@vger.kernel.org>; Sat,  1 Mar 2025 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740871016; cv=none; b=KBcLt1ZzmmhQQpwrfWRUas+nHYHSJceDndZTKgK7zo38hkGxsE54bKINJyKHCxIrzCKapWQy62hVPVdiwzXln6ewgqK8jKE4c84xySspAkEGrcoOM+QnvEtz8L6FvYJyHC3qr6/mQ5LddCmRh4lfnt7pHfA2sLKH+lTUpoUKvSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740871016; c=relaxed/simple;
	bh=n5q3KnvUQMzuefogtJt6LyQ04Xe8lgNhQs15+nYJuf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DfWqsnVmVuShUyZwK59aGjcprYm4wO0hMzvAokdzRsDyALPa1m1uZiFVUo9KK4fPsVut80h6akRvYR+Jc/ow0ABn7TvUvPl4+bYlA4FER2hcby/2lC2kOQpsPfaweiY6XMpgm+AX4fd45GVjmdfR6wJVmv8TVWlcv24Ex2BxULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YbriyAti; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740871011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K/JibQ9PnBD/8tWrEhGvIwKzrp591WykqranHKVZvuo=;
	b=YbriyAtisOsDKF4tBTkiseQvqOWoPiZ31p8uYu+mpd94ijwi1f8Kdv+gGCrdsgUegZVobH
	oFoajzPOxw1RG6JtgWPHJXt0n7s7UOwkidgNBEUpttUSedmgDAL1ImRwXWNH+JGXluWHTQ
	n2i8kx//Egc7XL3QMR3eGfWG1YGj4J4=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCHv2 for-next 1/1] RDMA/rxe: Fix the failure of ibv_query_device() and ibv_query_device_ex() tests
Date: Sun,  2 Mar 2025 00:16:39 +0100
Message-Id: <20250301231639.1304156-1-yanjun.zhu@linux.dev>
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

Fixes: 2ac5415022d1 ("RDMA/rxe: Remove the direct link to net_device")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
V1 -- > V2: Keep dev_addr as raw_gid
---
 drivers/infiniband/sw/rxe/rxe.c       | 23 -----------------------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 4e56a371deb5..18640f006187 100644
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
@@ -70,27 +68,6 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 	rxe->attr.max_fast_reg_page_list_len	= RXE_MAX_FMR_PAGE_LIST_LEN;
 	rxe->attr.max_pkeys			= RXE_MAX_PKEYS;
 	rxe->attr.local_ca_ack_delay		= RXE_LOCAL_CA_ACK_DELAY;
-
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
-
-	addrconf_addr_eui48((unsigned char *)&rxe->attr.sys_image_guid,
-			rxe->raw_gid);
-
-	dev_put(ndev);
-
 	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
 
 	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 2331e698a65b..ff06d7b32a66 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1549,6 +1549,20 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name,
 	if (err)
 		return err;
 
+	if (ndev->addr_len) {
+		memcpy(rxe->raw_gid, ndev->dev_addr,
+			min_t(unsigned int, ndev->addr_len, ETH_ALEN));
+	} else {
+		/*
+		 * This device does not have a HW address, but
+		 * connection mangagement requires a unique gid.
+		 */
+		eth_random_addr(rxe->raw_gid);
+	}
+
+	addrconf_addr_eui48((unsigned char *)&rxe->attr.sys_image_guid,
+				rxe->raw_gid);
+
 	err = ib_register_device(dev, ibdev_name, NULL);
 	if (err)
 		rxe_dbg_dev(rxe, "failed with error %d\n", err);
-- 
2.34.1


