Return-Path: <linux-rdma+bounces-7929-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94330A3EA85
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 03:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D76816E443
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 02:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF2C1BEF8A;
	Fri, 21 Feb 2025 02:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BGD2xc4s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1DA2AD0F
	for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 02:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103576; cv=none; b=CRvgDqm66DReSA0ZGGMHimFn/JKEKdjfVh2HWmnpZU2Kwq5NFqbcsWnM2HnJfPAU9jCbaAUnw6kFVARnu6Ih6LvgdcnXjxLLE8Sa0vJNrR2v1xkENT5uiHTM1VhpVmzmYbDHUgCZNNaUXO4PFLIIZfBtNblxL4kAf6li6lbKto0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103576; c=relaxed/simple;
	bh=7bUYJkVR4LhZ5MDpF+WhZIC+c5Z7P28KhdMyqRYAle4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sHTW6oMFXx/PuKcsLsg+hEWIaGhDa+tn2QFKYRFoeqf+2nmv/Kqubat1KiD5jheugYiSJ1J7DrjDWyQm9q8ywK3XFY+vU0T3logTEbwbOfEtS9ooe9+E4ntmlwDuOwmIl03TIEYoMgr4H4YqgiH45rUih8Osexpa0m+eNtv2HxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BGD2xc4s; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740103569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZV49fxUaLuaAIe94fEcao8tPpI/oFMeLfe5oAC8i2bM=;
	b=BGD2xc4sfo+EqSf0zxzex/zxxMANPBaXiq2p7+KZWEykfR1QHb5gVtFWk0yLdr0rUw3Iyh
	NwOKqlTnAa2zDXoHBdNsc44d7nMwJdmhzFeROxu6XVIJ0cXz4a7UhYK86bPqRzh+JZ9gri
	WNK/cIvXMSSoyYUlttZ6IYocwG8tOWw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Maher Sanalla <msanalla@nvidia.com>,
	Parav Pandit <parav@mellanox.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/core: fix a NULL-pointer dereference in hw_stat_device_show()
Date: Fri, 21 Feb 2025 02:05:55 +0000
Message-ID: <20250221020555.4090014-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit 54747231150f ("RDMA: Introduce and use rdma_device_to_ibdev()")
introduced rdma_device_to_ibdev() helper which has to be used to
obtain an ib_device pointer from a device pointer.

hw_stat_device_show() and hw_stat_device_store() were missed.

It causes a NULL pointer dereference panic on an attempt to read
hw counters from a namespace, when the device structure is not
embedded into the ib_device structure. In this case casting the device
pointer into the ib_device pointer using container_of() is wrong.
Instead, rdma_device_to_ibdev() should be used, which uses the
back-reference (container_of(device, struct ib_core_device, dev))->owner.

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

Fixes: 54747231150f ("RDMA: Introduce and use rdma_device_to_ibdev()")
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
2.48.1.601.g30ceb7b040-goog


