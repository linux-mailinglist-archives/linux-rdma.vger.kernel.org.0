Return-Path: <linux-rdma+bounces-7772-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9B8A35F79
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 14:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F34016950A
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 13:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AC3263F3D;
	Fri, 14 Feb 2025 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUEf40c/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C0015199D;
	Fri, 14 Feb 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739541215; cv=none; b=jrwB9FhIdf8JTXxoumiYUTa0r9WeXi+vLpYEbe4E0h0R1pnkz76xFfosa20AfnGZAAvn59QzNoK3dAuhB4w6IJGWZVf84Pzq5wm5z3JRijk5ZlJpkpMGrvsCciTXwjHF0DAdhU63wzmFMSi+xVpaBikTMMNE+YNb71OZdMyz09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739541215; c=relaxed/simple;
	bh=t4t0GFjhp7gnA5t6SYamQkof+QYpu37Cw8BGFrVG6BI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/6bM9zhUlHjGe7ahTEEOvk54y9nrkkqREPzX7dLb9fT1dqhIDdMH7x/WoFL/YkLNZvh/TJdQyhalShtsiTpB0cF/4uTqLn5CKL92PtWo+eSP+zQyC9rhhB4XRRIokzVqOqMlITq4gtCF6EbvlfhIk5hizgopJR2dggS7Jv4/cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUEf40c/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739541213; x=1771077213;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t4t0GFjhp7gnA5t6SYamQkof+QYpu37Cw8BGFrVG6BI=;
  b=ZUEf40c/ZHcMH3vBEz+5mVdQiVYJXmdakjNjsRzKvuqdRHQLs2cNblF5
   Lk/EsCNXCY2i8nMkvmPicCOY7sal2cgfNl0wAFlZPx+zHvOfsRNAz8/ur
   tYBz4kULFwK5TrINynhYp0CDqop1Nq7lITFN8p6+g2C12xpg9ZhHHv7gT
   4qBI+FBfjAGu+wMOqxvXvRL5EFNntdSFUozsRtsYw3ZroIx3dinxi99Vf
   85Z3N7oj0B4vg7QOaVH4f9IL3dq/OmNEivYrpVsx7d7lXlcs3ZSuwRT50
   eH5jHZVCfi+cTCflyM3nvTE8TlrGcxs9kFmsePCw9zyUpg5YZ+hY9KvsS
   A==;
X-CSE-ConnectionGUID: hlpjKpenTZ+WefVbe4oXng==
X-CSE-MsgGUID: HSyHk+anScqf5s/DgVJdEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="57822084"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="57822084"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 05:53:33 -0800
X-CSE-ConnectionGUID: HhRJGfvKRgeb1WH95/VRzQ==
X-CSE-MsgGUID: Z9fVTABAQZiaGkR39xK5iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150636991"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa001.jf.intel.com with ESMTP; 14 Feb 2025 05:53:31 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com,
	mustafa.ismail@intel.com,
	tatyana.e.nikolova@intel.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	jacob.e.keller@intel.com,
	anthony.l.nguyen@intel.com,
	linux-rdma@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1] irdma: free iwdev->rf after removing MSI-X
Date: Fri, 14 Feb 2025 14:53:22 +0100
Message-ID: <20250214135322.4999-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently iwdev->rf is allocated in irdma_probe(), but free in
irdma_ib_dealloc_device(). It can be misleading. Move the free to
irdma_remove() to be more obvious.

Freeing in irdma_ib_dealloc_device() leads to KASAN use-after-free
issue. Which can also lead to NULL pointer dereference. Fix this.

irdma_deinit_interrupts() can't be moved before freeing iwdef->rf,
because in this case deinit interrupts will be done before freeing irqs.
The simplest solution is to move kfree(iwdev->rf) to irdma_remove().

Reproducer:
  sudo rmmod irdma

Minified splat(s):
  BUG: KASAN: use-after-free in irdma_remove+0x257/0x2d0 [irdma]
  Call Trace:
   <TASK>
   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
   ? kfree+0x253/0x450
   ? irdma_remove+0x257/0x2d0 [irdma]
   kasan_report+0xed/0x120
   ? irdma_remove+0x257/0x2d0 [irdma]
   irdma_remove+0x257/0x2d0 [irdma]
   auxiliary_bus_remove+0x56/0x80
   device_release_driver_internal+0x371/0x530
   ? kernfs_put.part.0+0x147/0x310
   driver_detach+0xbf/0x180
   bus_remove_driver+0x11b/0x2a0
   auxiliary_driver_unregister+0x1a/0x50
   irdma_exit_module+0x40/0x4c [irdma]

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: 0010:ice_free_rdma_qvector+0x2a/0xa0 [ice]
  Call Trace:
   ? ice_free_rdma_qvector+0x2a/0xa0 [ice]
   irdma_remove+0x179/0x2d0 [irdma]
   auxiliary_bus_remove+0x56/0x80
   device_release_driver_internal+0x371/0x530
   ? kobject_put+0x61/0x4b0
   driver_detach+0xbf/0x180
   bus_remove_driver+0x11b/0x2a0
   auxiliary_driver_unregister+0x1a/0x50
   irdma_exit_module+0x40/0x4c [irdma]

Reported-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Closes: https://lore.kernel.org/netdev/8e533834-4564-472f-b29b-4f1cb7730053@linux.intel.com/
Fixes: 3e0d3cb3fbe0 ("ice, irdma: move interrupts code to irdma")
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
Fix to net-next instead of net, because the commit isn't yet in net
tree.
---
 drivers/infiniband/hw/irdma/main.c  | 2 ++
 drivers/infiniband/hw/irdma/verbs.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 1ee8969595d3..d10fd16dcec3 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -255,6 +255,8 @@ static void irdma_remove(struct auxiliary_device *aux_dev)
 	ice_rdma_update_vsi_filter(pf, iwdev->vsi_num, false);
 	irdma_deinit_interrupts(iwdev->rf, pf);
 
+	kfree(iwdev->rf);
+
 	pr_debug("INIT: Gen2 PF[%d] device remove success\n", PCI_FUNC(pf->pdev->devfn));
 }
 
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index eeb932e58730..1e8c92826de2 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -4871,5 +4871,4 @@ void irdma_ib_dealloc_device(struct ib_device *ibdev)
 
 	irdma_rt_deinit_hw(iwdev);
 	irdma_ctrl_deinit_hw(iwdev->rf);
-	kfree(iwdev->rf);
 }
-- 
2.42.0


