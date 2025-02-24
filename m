Return-Path: <linux-rdma+bounces-8047-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399C2A4309B
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 00:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA877A90E4
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 23:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453E020B1F3;
	Mon, 24 Feb 2025 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JX+AkCZD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213B020011D
	for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2025 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439263; cv=none; b=Ycb+KAbOBp6TRmHldf7QgwwOilAh0bgKEH6gN80WqZYfoFowa1L8X1fzvv9UBAfdpBLBMEsxnMJQGoBVboBC8KLv1nNNp6jqrp7U4Vw4AHkidYTVKiHfFshwa6vtgmh4V3e/aUdxR6xAAxI4y9jLyjKWQ8lYX7ycwS4IFLq7mcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439263; c=relaxed/simple;
	bh=AE/BPPesqujpVG7Skm0q6iIAoiy53Pv6lPSfsMRVZc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YTYKFOPjFA48YZnIc1bSeYhO8pB1pV6oT29T7JjCDOmWqyCOlFlG+r0/M/HeUNys25uwqB/lPpuOjHL78atTHv/Afoya0w7PqWNq53e2M7HmCQWlevM3s2QMvoQL94GpggxyHLLOShmolF8sRRT1Lq1B87KUi8bBTPbUOW9mZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JX+AkCZD; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740439259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w9VyCqQ5W4f+Wpe3SrLp284SEcfzz6nkkWLxQdGLo2g=;
	b=JX+AkCZDCJVLVqVVXmZnp+4dkUZQ3iZQKvPrFcykHfPmUu4wNQ0lK+fkpvqy5Hy1My6Bcl
	8WhEJ4E2xkzVLJesnfWI6YS11VQ4i1Mia9SkRU5LWXBBdY3CcvfXZ3UMeB7NNesIo6VWIO
	Ddf2BB/bllU5jDQyXvPSVAr1PG1CnNs=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Maher Sanalla <msanalla@nvidia.com>,
	Parav Pandit <parav@mellanox.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] RDMA/core: fix a NULL-pointer dereference in hw_stat_device_show()
Date: Mon, 24 Feb 2025 23:20:48 +0000
Message-ID: <20250224232048.1423635-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The following panic has been noticed in production on multiple hosts:

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

The problem is caused by reading hw counters from a non-initial
net namespace. In this case casting the device pointer into
an ib_device pointer using container_of() in hw_stat_device_show() is
wrong and leads to a memory corruption. Instead, rdma_device_to_ibdev()
should be used, which uses a back-reference
(container_of(device, struct ib_core_device, dev))->owner.

Fixes: 467f432a521a ("RDMA/core: Split port and device counter sysfs attributes")
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Maher Sanalla <msanalla@nvidia.com>
Cc: Parav Pandit <parav@mellanox.com>
Cc: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/infiniband/core/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 7491328ca5e6..0be77b8abeae 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -148,7 +148,7 @@ static ssize_t hw_stat_device_show(struct device *dev,
 {
 	struct hw_stats_device_attribute *stat_attr =
 		container_of(attr, struct hw_stats_device_attribute, attr);
-	struct ib_device *ibdev = container_of(dev, struct ib_device, dev);
+	struct ib_device *ibdev = rdma_device_to_ibdev(dev);
 
 	return stat_attr->show(ibdev, ibdev->hw_stats_data->stats,
 			       stat_attr - ibdev->hw_stats_data->attrs, 0, buf);
@@ -160,7 +160,7 @@ static ssize_t hw_stat_device_store(struct device *dev,
 {
 	struct hw_stats_device_attribute *stat_attr =
 		container_of(attr, struct hw_stats_device_attribute, attr);
-	struct ib_device *ibdev = container_of(dev, struct ib_device, dev);
+	struct ib_device *ibdev = rdma_device_to_ibdev(dev);
 
 	return stat_attr->store(ibdev, ibdev->hw_stats_data->stats,
 				stat_attr - ibdev->hw_stats_data->attrs, 0, buf,
-- 
2.48.1.658.g4767266eb4-goog


