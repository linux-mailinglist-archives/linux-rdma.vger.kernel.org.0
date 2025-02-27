Return-Path: <linux-rdma+bounces-8189-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE6AA485EC
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 17:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA5E18890E2
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 16:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9081B4F04;
	Thu, 27 Feb 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VhHpG0jQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A00E8F40
	for <linux-rdma@vger.kernel.org>; Thu, 27 Feb 2025 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675283; cv=none; b=MM9y3WZXPjOPEQQ3Ogf6DvHXDphGgUt8LTSsoQ0j494Op4fdiQkcoREvb6DAM2Bl+icL6d4hUSTHLNIZDcPtlLVT3DufNlIFy8KOp8BjuRyjAXo/JysHjuN9wlMxRiwuyKcSGLQ1Jgrlew/bMKJXciR94ALbZAzsXha3JSOhfkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675283; c=relaxed/simple;
	bh=/xbSj+dtZ5xL0KKWz+bEG9rH09SkZMpFNTYJzDwhYv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZXKTuWI4MUsLzsuy4rJsoexd8ZXaaW3w44YkzLMowPSGJtntNW6G21iIK5ch7DsfzATXj8s7zUt1uQONv176zAbM4sij2G0saK4nCdA0fuaTCmnwzC5DVqGKfVjHC1JE0VNdWkFAl1V3mJqH+W5uIEm/iEw1RDT9SJ5kfQYtPwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VhHpG0jQ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740675269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LZtJblFnV+khFsBLJxw+UvMEOyflz0RYTRno32s3M9I=;
	b=VhHpG0jQ3tziz9gYawW/sA+KpRZlka2LmM3JFmdR0a7RyhXpvjeK2Z7cPDNoH3EWyI1Dqx
	tdZFxMMspwTMOrpWYrfCOLxMnbYTvBAyUHCeMl0LWUnQ4/nK57GdjVCDVbROuaIYmk6kXW
	QtL3Ev4SWUxejVn0M/uCwa/njAKEVRA=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Maher Sanalla <msanalla@nvidia.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/core: don't expose hw_counters outside of init net namespace
Date: Thu, 27 Feb 2025 16:54:20 +0000
Message-ID: <20250227165420.3430301-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit 467f432a521a ("RDMA/core: Split port and device counter sysfs
attributes") accidentally almost exposed hw counters to non-init net
namespaces. It didn't expose them fully, as an attempt to read any of
those counters leads to a crash like this one:

[42021.807566] BUG: kernel NULL pointer dereference, address: 0000000000000028
[42021.814463] #PF: supervisor read access in kernel mode
[42021.819549] #PF: error_code(0x0000) - not-present page
[42021.824636] PGD 0 P4D 0
[42021.827145] Oops: 0000 [#1] SMP PTI
[42021.830598] CPU: 82 PID: 2843922 Comm: switchto-defaul Kdump: loaded Tainted: G S      W I        XXX
[42021.841697] Hardware name: XXX
[42021.849619] RIP: 0010:hw_stat_device_show+0x1e/0x40 [ib_core]
[42021.855362] Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 49 89 d0 4c 8b 5e 20 48 8b 8f b8 04 00 00 48 81 c7 f0 fa ff ff <48> 8b 41 28 48 29 ce 48 83 c6 d0 48 c1 ee 04 69 d6 ab aa aa aa 48
[42021.873931] RSP: 0018:ffff97fe90f03da0 EFLAGS: 00010287
[42021.879108] RAX: ffff9406988a8c60 RBX: ffff940e1072d438 RCX: 0000000000000000
[42021.886169] RDX: ffff94085f1aa000 RSI: ffff93c6cbbdbcb0 RDI: ffff940c7517aef0
[42021.893230] RBP: ffff97fe90f03e70 R08: ffff94085f1aa000 R09: 0000000000000000
[42021.900294] R10: ffff94085f1aa000 R11: ffffffffc0775680 R12: ffffffff87ca2530
[42021.907355] R13: ffff940651602840 R14: ffff93c6cbbdbcb0 R15: ffff94085f1aa000
[42021.914418] FS:  00007fda1a3b9700(0000) GS:ffff94453fb80000(0000) knlGS:0000000000000000
[42021.922423] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[42021.928130] CR2: 0000000000000028 CR3: 00000042dcfb8003 CR4: 00000000003726f0
[42021.935194] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[42021.942257] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[42021.949324] Call Trace:
[42021.951756]  <TASK>
[42021.953842]  [<ffffffff86c58674>] ? show_regs+0x64/0x70
[42021.959030]  [<ffffffff86c58468>] ? __die+0x78/0xc0
[42021.963874]  [<ffffffff86c9ef75>] ? page_fault_oops+0x2b5/0x3b0
[42021.969749]  [<ffffffff87674b92>] ? exc_page_fault+0x1a2/0x3c0
[42021.975549]  [<ffffffff87801326>] ? asm_exc_page_fault+0x26/0x30
[42021.981517]  [<ffffffffc0775680>] ? __pfx_show_hw_stats+0x10/0x10 [ib_core]
[42021.988482]  [<ffffffffc077564e>] ? hw_stat_device_show+0x1e/0x40 [ib_core]
[42021.995438]  [<ffffffff86ac7f8e>] dev_attr_show+0x1e/0x50
[42022.000803]  [<ffffffff86a3eeb1>] sysfs_kf_seq_show+0x81/0xe0
[42022.006508]  [<ffffffff86a11134>] seq_read_iter+0xf4/0x410
[42022.011954]  [<ffffffff869f4b2e>] vfs_read+0x16e/0x2f0
[42022.017058]  [<ffffffff869f50ee>] ksys_read+0x6e/0xe0
[42022.022073]  [<ffffffff8766f1ca>] do_syscall_64+0x6a/0xa0
[42022.027441]  [<ffffffff8780013b>] entry_SYSCALL_64_after_hwframe+0x78/0xe2

The problem can be reproduced using the following steps:
  ip netns add foo
  ip netns exec foo bash
  cat /sys/class/infiniband/mlx4_0/hw_counters/*

The panic occurs because of casting the device pointer into an
ib_device pointer using container_of() in hw_stat_device_show() is
wrong and leads to a memory corruption.

However the real problem is that hw counters should never been exposed
outside of the non-init net namespace.

Fix this by saving the index of the corresponding attribute group
(it might be 1 or 2 depending on the presence of driver-specific
attributes) and zeroing the pointer to hw_counters group for compat
devices during the initialization.

With this fix applied hw_counters are not available in a non-init
net namespace:
  find /sys/class/infiniband/mlx4_0/ -name hw_counters
    /sys/class/infiniband/mlx4_0/ports/1/hw_counters
    /sys/class/infiniband/mlx4_0/ports/2/hw_counters
    /sys/class/infiniband/mlx4_0/hw_counters

  ip netns add foo
  ip netns exec foo bash
  find /sys/class/infiniband/mlx4_0/ -name hw_counters

Fixes: 467f432a521a ("RDMA/core: Split port and device counter sysfs attributes")
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Maher Sanalla <msanalla@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/infiniband/core/device.c | 9 +++++++++
 drivers/infiniband/core/sysfs.c  | 1 +
 include/rdma/ib_verbs.h          | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 0ded91f056f3..8feb22089cbb 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -528,6 +528,8 @@ static struct class ib_class = {
 static void rdma_init_coredev(struct ib_core_device *coredev,
 			      struct ib_device *dev, struct net *net)
 {
+	bool is_full_dev = &dev->coredev == coredev;
+
 	/* This BUILD_BUG_ON is intended to catch layout change
 	 * of union of ib_core_device and device.
 	 * dev must be the first element as ib_core and providers
@@ -539,6 +541,13 @@ static void rdma_init_coredev(struct ib_core_device *coredev,
 
 	coredev->dev.class = &ib_class;
 	coredev->dev.groups = dev->groups;
+
+	/*
+	 * Don't expose hw counters outside of the init namespace.
+	 */
+	if (!is_full_dev && dev->hw_stats_attr_index)
+		coredev->dev.groups[dev->hw_stats_attr_index] = NULL;
+
 	device_initialize(&coredev->dev);
 	coredev->owner = dev;
 	INIT_LIST_HEAD(&coredev->port_list);
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 7491328ca5e6..0ed862b38b44 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -976,6 +976,7 @@ int ib_setup_device_attrs(struct ib_device *ibdev)
 	for (i = 0; i != ARRAY_SIZE(ibdev->groups); i++)
 		if (!ibdev->groups[i]) {
 			ibdev->groups[i] = &data->group;
+			ibdev->hw_stats_attr_index = i;
 			return 0;
 		}
 	WARN(true, "struct ib_device->groups is too small");
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b59bf30de430..a5761038935d 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2767,6 +2767,7 @@ struct ib_device {
 	 * It is a NULL terminated array.
 	 */
 	const struct attribute_group	*groups[4];
+	u8				hw_stats_attr_index;
 
 	u64			     uverbs_cmd_mask;
 
-- 
2.48.1.711.g2feabab25a-goog


