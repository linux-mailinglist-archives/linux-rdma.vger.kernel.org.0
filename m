Return-Path: <linux-rdma+bounces-2407-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A38698C2B91
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 23:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6371C2253F
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 21:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E7D13B597;
	Fri, 10 May 2024 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cmMFjy6X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B733B10965
	for <linux-rdma@vger.kernel.org>; Fri, 10 May 2024 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375589; cv=none; b=DqP5o55dD+TkL4MgX6+gmvGQKMQ1Ey17nJCpF7Rrs31RdLLd/GT841f3X+3ea5jfCyCNjkZCCLCqq9Sjpo6c2NInlMvLAnCgI1ggVGiWUEHOAQJB1CDv3/X818NsD/yRjE1xFmy0Q9YI/ivMNCdC3e6qLePPIMM1MntN+JE2l2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375589; c=relaxed/simple;
	bh=8xGP0XpOJipaqpWhjL+ASafoMNH/9BUkq495J8Ink/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mP+eyf572DFXMxDPkR/v8lMH2wIHsucgzLzvTo8mCZW3WiQFpEpeHIkcCkFkmQqDtpDnyR7JqFRWAyPdLGVTbNU7EvzUOD1Lz08zjBkpIbFj6cHEp3hiIKasfpXmeU1Pq2QoFmMqOG/xbC3S0vlkTMgYC6OAvqLdZwWhuiTANXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cmMFjy6X; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715375582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FMPTI6E985da9h4iuFzDmmJWJNyAvwsV+Q0Uf+d7cmA=;
	b=cmMFjy6Xugj5NbbHRiyWOFRsHzY/mLQHfF8SNtuv1v+cdAO07zCzWv5qe5axjlhTMQFLjM
	2/cMw9BHR5FVUaCZnU2meuN+aLN1QNSBNc2GVYydVzf9UJ5ca/7W525wVwwM0RheGwpuXH
	uajtTWeDIeTnpnBrmUvfHCKdqv4/0uc=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
	Yi Zhang <yi.zhang@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 1/1] RDMA/cma: Fix kmemleak in rdma_core observed during blktests nvme/rdma use siw
Date: Fri, 10 May 2024 23:12:47 +0200
Message-Id: <20240510211247.31345-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When running blktests nvme/rdma, the following kmemleak issue will appear.

kmemleak: Kernel memory leak detector initialized (mempool available:36041)
kmemleak: Automatic memory scanning thread started
kmemleak: 2 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
kmemleak: 8 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
kmemleak: 17 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
kmemleak: 4 new suspected memory leaks (see /sys/kernel/debug/kmemleak)

unreferenced object 0xffff88855da53400 (size 192):
  comm "rdma", pid 10630, jiffies 4296575922
  hex dump (first 32 bytes):
    37 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  7...............
    10 34 a5 5d 85 88 ff ff 10 34 a5 5d 85 88 ff ff  .4.].....4.]....
  backtrace (crc 47f66721):
    [<ffffffff911251bd>] kmalloc_trace+0x30d/0x3b0
    [<ffffffffc2640ff7>] alloc_gid_entry+0x47/0x380 [ib_core]
    [<ffffffffc2642206>] add_modify_gid+0x166/0x930 [ib_core]
    [<ffffffffc2643468>] ib_cache_update.part.0+0x6d8/0x910 [ib_core]
    [<ffffffffc2644e1a>] ib_cache_setup_one+0x24a/0x350 [ib_core]
    [<ffffffffc263949e>] ib_register_device+0x9e/0x3a0 [ib_core]
    [<ffffffffc2a3d389>] 0xffffffffc2a3d389
    [<ffffffffc2688cd8>] nldev_newlink+0x2b8/0x520 [ib_core]
    [<ffffffffc2645fe3>] rdma_nl_rcv_msg+0x2c3/0x520 [ib_core]
    [<ffffffffc264648c>]
rdma_nl_rcv_skb.constprop.0.isra.0+0x23c/0x3a0 [ib_core]
    [<ffffffff9270e7b5>] netlink_unicast+0x445/0x710
    [<ffffffff9270f1f1>] netlink_sendmsg+0x761/0xc40
    [<ffffffff9249db29>] __sys_sendto+0x3a9/0x420
    [<ffffffff9249dc8c>] __x64_sys_sendto+0xdc/0x1b0
    [<ffffffff92db0ad3>] do_syscall_64+0x93/0x180
    [<ffffffff92e00126>] entry_SYSCALL_64_after_hwframe+0x71/0x79

The root cause: rdma_put_gid_attr is not called when sgid_attr is set
to ERR_PTR(-ENODEV).

Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/19bf5745-1b3b-4b8a-81c2-20d945943aaf@linux.dev/T/
Fixes: f8ef1be816bf ("RDMA/cma: Avoid GID lookups on iWARP devices")
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/core/cma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 1e2cd7c8716e..64ace0b968f0 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -715,8 +715,10 @@ cma_validate_port(struct ib_device *device, u32 port,
 		rcu_read_lock();
 		ndev = rcu_dereference(sgid_attr->ndev);
 		if (!net_eq(dev_net(ndev), dev_addr->net) ||
-		    ndev->ifindex != bound_if_index)
+		    ndev->ifindex != bound_if_index) {
+			rdma_put_gid_attr(sgid_attr);
 			sgid_attr = ERR_PTR(-ENODEV);
+		}
 		rcu_read_unlock();
 		goto out;
 	}
-- 
2.34.1


