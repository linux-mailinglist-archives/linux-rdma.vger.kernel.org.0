Return-Path: <linux-rdma+bounces-9943-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADC5AA5D4D
	for <lists+linux-rdma@lfdr.de>; Thu,  1 May 2025 12:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41597188D8CA
	for <lists+linux-rdma@lfdr.de>; Thu,  1 May 2025 10:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82A6219E8C;
	Thu,  1 May 2025 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OnXG6p7c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6D3145A03
	for <linux-rdma@vger.kernel.org>; Thu,  1 May 2025 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746095798; cv=none; b=SQaaE8BFkNuwTIdO3UKovonXV04Ct5xnYGdwPgO7S7SpxfL+xZA3Gkc1rymGrQxZj5Pj0GvGDg6s4wGWsSDFBIcerIobZ5jl5xbx0Fec/sCvzwsC34P2NNiwHksrkcmOE9tGJ3IF7GbwWte554T0tEwM7G232difaoasdcFQatc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746095798; c=relaxed/simple;
	bh=8GG4Jo0iCi8wz3pDaQRkihwAmC8sdYvni9ycYtQFDBc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rjlOpxK+ptjTCjdOfy/d1HJgGkh0qORKBgtOkXsLw6T/aiai4CsptABujgm8pAV4xU7Vfo2Ndiy+buaAvdwdqSPSdPxsFtf3/l9yerwGOojv4MOFThtKenU9l2zGBuywXlfK0vMEhP57IVikLNX0Qn4OPDCrq/Jc1cwMRcaG8ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OnXG6p7c; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746095792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=epL2jD2TqrdSkwKIIcmz/YllN4OEJ/hlm7DMu1JhFGY=;
	b=OnXG6p7cNBlcHzJ/tK62gccluymdUQKpYtJAR3lm1lXj/D9mDSmeeFfLETjQKdOSuCxgdR
	64VuewcAcfILVFAPEsVBYLURb5T75mOBDIB0x1ocATd9yZQ3YnC2mbvLvczr5BzHUdUS9P
	r4jh3sUDfOR+FR0mcFtqbkTjQESjtFk=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
	syzbot+e2ce9e275ecc70a30b72@syzkaller.appspotmail.com
Subject: [PATCH 1/1] RDMA/core: Fix "KASAN: slab-use-after-free Read in ib_register_device" problem
Date: Thu,  1 May 2025 12:36:02 +0200
Message-Id: <20250501103602.3479963-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Call Trace:

 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 strlen+0x93/0xa0 lib/string.c:420
 __fortify_strlen include/linux/fortify-string.h:268 [inline]
 get_kobj_path_length lib/kobject.c:118 [inline]
 kobject_get_path+0x3f/0x2a0 lib/kobject.c:158
 kobject_uevent_env+0x289/0x1870 lib/kobject_uevent.c:545
 ib_register_device drivers/infiniband/core/device.c:1472 [inline]
 ib_register_device+0x8cf/0xe00 drivers/infiniband/core/device.c:1393
 rxe_register_device+0x275/0x320 drivers/infiniband/sw/rxe/rxe_verbs.c:1552
 rxe_net_add+0x8e/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:550
 rxe_newlink+0x70/0x190 drivers/infiniband/sw/rxe/rxe.c:225
 nldev_newlink+0x3a3/0x680 drivers/infiniband/core/nldev.c:1796
 rdma_nl_rcv_msg+0x387/0x6e0 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb.constprop.0.isra.0+0x2e5/0x450
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 ____sys_sendmsg+0xa95/0xc70 net/socket.c:2566
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
 __sys_sendmsg+0x16d/0x220 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

This problem is similar to the problem that the commit
1d6a9e7449e2 ("RDMA/core: Fix use-after-free when rename device name")
fixes.

The root cause is: the function ib_device_rename renames the name with
lock. But in the function kobject_uevent, this name is accessed without
lock protection at the same time.

The solution is to add the lock protection when this name is accessed in
the function kobject_uevent.

Fixes: 779e0bf47632 ("RDMA/core: Do not indicate device ready when device enablement fails")
Reported-by: syzbot+e2ce9e275ecc70a30b72@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2ce9e275ecc70a30b72
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/core/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b4e3e4beb7f4..59d84829dd66 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1468,8 +1468,12 @@ int ib_register_device(struct ib_device *device, const char *name,
 		return ret;
 	}
 	dev_set_uevent_suppress(&device->dev, false);
+
+	/* device->dev.kobj->name should be protected by devices_rwsem */
+	down_read(&devices_rwsem);
 	/* Mark for userspace that device is ready */
 	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
+	up_read(&devices_rwsem);
 
 	ib_device_notify_register(device);
 	ib_device_put(device);
-- 
2.34.1


