Return-Path: <linux-rdma+bounces-4434-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C659585E7
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2024 13:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CF8286C1C
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2024 11:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F60518DF99;
	Tue, 20 Aug 2024 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nqRsnP6r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9318C91C
	for <linux-rdma@vger.kernel.org>; Tue, 20 Aug 2024 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153658; cv=none; b=Xbc4YyxGlwNRnKKw6L9VNPBBNXIaACMiMNzDFLY2yk9bpZBKAyIR6TuCKwKQjQk9dFqAQm3AjKdAdtZ1MTxRXrf4+USAuuhPZ1iJnm7OkXDMnKs+jgbwjlUW1GHGYLG1NpUHfIn1iVCyOpnSQmKgbH3SIHSTsMqY8P7zCgYG+kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153658; c=relaxed/simple;
	bh=GMA19GbbIovrXeashWAEMSAj+Kdx6bnf2oqZ+K8fuw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UTlswUaokGltvYiq6NO9AR4Vtv+NMuNgJPrfhhi9Cl1TogRDRRa4j3KSLa1u6T51k7SOxpJQb3kjOP/niWEFkKz0cWKlY/iTnZ4wI5HI7xgoYdzhNpbQiOzw5ysNssU67+h9CYdPHTxlzayu/Fo/NdidYKqG5aBGuG6PwdbIXIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nqRsnP6r; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724153653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i9IRH1pt6PZ+143snRfI0TPIEV7tugqFkj8MAE2pBvs=;
	b=nqRsnP6rI0PTGYFSukOG3OYyI7EL/tCvIbPqAjncH30QIBefNYAaV18Gc6ie3/Nxb2uNWQ
	w2pfsB4UNCn2ZEbS3h7343zB+YGrqn96vyar6VW1ycDN0PiFTeV193dYDkm+hsfSM1Lmjj
	/qCbwiy6dWuSnHQ73WpkMIn1tubkDrg=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: bvanassche@acm.org,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	shinichiro.kawasaki@wdc.com,
	oliver.sang@intel.com,
	jgg@nvidia.com
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH v2 1/1] RDMA/iwcm: Fix WARNING:at_kernel/workqueue.c:#check_flush_dependency
Date: Tue, 20 Aug 2024 13:33:36 +0200
Message-Id: <20240820113336.19860-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the commit aee2424246f9 ("RDMA/iwcm: Fix a use-after-free related to
destroying CM IDs"), the function flush_workqueue is invoked to flush
the work queue iwcm_wq.

But at that time, the work queue iwcm_wq was created via the function
alloc_ordered_workqueue without the flag WQ_MEM_RECLAIM.

Because the current process is trying to flush the whole iwcm_wq, if
iwcm_wq doesn't have the flag WQ_MEM_RECLAIM, verify that the current
process is not reclaiming memory or running on a workqueue which
doesn't have the flag WQ_MEM_RECLAIM as that can break forward-progress
guarantee leading to a deadlock.

The call trace is as below:
"
[  125.350876][ T1430] Call Trace:
[  125.356281][ T1430]  <TASK>
[ 125.361285][ T1430] ? __warn (kernel/panic.c:693)
[ 125.367640][ T1430] ? check_flush_dependency (kernel/workqueue.c:3706 (discriminator 9))
[ 125.375689][ T1430] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[ 125.382505][ T1430] ? handle_bug (arch/x86/kernel/traps.c:239)
[ 125.388987][ T1430] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
[ 125.395831][ T1430] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621)
[ 125.403125][ T1430] ? check_flush_dependency (kernel/workqueue.c:3706 (discriminator 9))
[ 125.410984][ T1430] ? check_flush_dependency (kernel/workqueue.c:3706 (discriminator 9))
[ 125.418764][ T1430] __flush_workqueue (kernel/workqueue.c:3970)
[ 125.426021][ T1430] ? __pfx___might_resched (kernel/sched/core.c:10151)
[ 125.433431][ T1430] ? destroy_cm_id (drivers/infiniband/core/iwcm.c:375) iw_cm
[  125.440844][ T2411] /usr/bin/wget -q --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-spr-2sp1/blktests-1SSD-rdma-nvme-group-01-debian-12-x86_64-20240206.cgz-aee2424246f9-20240809-69442-1dktaed-4.yaml&job_state=running -O /dev/null
[ 125.441209][ T1430] ? __pfx___flush_workqueue (kernel/workqueue.c:3910)
[  125.441215][ T2411]
[ 125.473900][ T1430] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
[ 125.473909][ T1430] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:161)
[  125.480265][ T2411] target ucode: 0x2b0004b1
[ 125.482537][ T1430] _destroy_id (drivers/infiniband/core/cma.c:2044) rdma_cm
[  125.488511][ T2411]
[ 125.495072][ T1430] nvme_rdma_free_queue (drivers/nvme/host/rdma.c:656 drivers/nvme/host/rdma.c:650) nvme_rdma
[  125.500747][ T2411] LKP: stdout: 2876: current_version: 2b0004b1, target_version: 2b0004b1
[ 125.505827][ T1430] nvme_rdma_reset_ctrl_work (drivers/nvme/host/rdma.c:2180) nvme_rdma
[ 125.505831][ T1430] process_one_work (kernel/workqueue.c:3231)
[  125.508377][ T2411]
[ 125.515122][ T1430] worker_thread (kernel/workqueue.c:3306 kernel/workqueue.c:3393)
[ 125.515127][ T1430] ? __pfx_worker_thread (kernel/workqueue.c:3339)
[  125.524642][ T2411] check_nr_cpu
[ 125.531837][ T1430] kthread (kernel/kthread.c:389)
[  125.537327][ T2411]
[ 125.539864][ T1430] ? __pfx_kthread (kernel/kthread.c:342)
[  125.545392][ T2411] CPU(s):                               224
[ 125.550628][ T1430] ret_from_fork (arch/x86/kernel/process.c:147)
[  125.554342][ T2411]
[ 125.558840][ T1430] ? __pfx_kthread (kernel/kthread.c:342)
[ 125.558844][ T1430] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
[  125.561843][ T2411] On-line CPU(s) list:                  0-223
[  125.566487][ T1430]  </TASK>
[  125.566488][ T1430] ---[ end trace 0000000000000000 ]---
"

Fixes: aee2424246f9 ("RDMA/iwcm: Fix a use-after-free related to destroying CM IDs")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202408151633.fc01893c-oliver.sang@intel.com
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
V1 -> V2: Modify commit logs based on Bart and Jason' suggestions
---
 drivers/infiniband/core/iwcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 1a6339f3a63f..7e3a55349e10 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -1182,7 +1182,7 @@ static int __init iw_cm_init(void)
 	if (ret)
 		return ret;
 
-	iwcm_wq = alloc_ordered_workqueue("iw_cm_wq", 0);
+	iwcm_wq = alloc_ordered_workqueue("iw_cm_wq", WQ_MEM_RECLAIM);
 	if (!iwcm_wq)
 		goto err_alloc;
 
-- 
2.34.1


