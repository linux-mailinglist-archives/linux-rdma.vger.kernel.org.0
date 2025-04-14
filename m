Return-Path: <linux-rdma+bounces-9433-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F758A8903B
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 01:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79AC27A69D9
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 23:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62FA1F561C;
	Mon, 14 Apr 2025 23:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SXy6Mm0N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B319DFB4
	for <linux-rdma@vger.kernel.org>; Mon, 14 Apr 2025 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744674235; cv=none; b=UFvtpOAN1xdyB/ZBOMZ2Hxd+PVw5KLJZzUtVi4Ks2kdWfh2xQi7nvanJAtV0/0oI4TqYVC+vCzr6x2ModhjPx2lUjtm7ldq3uW2ThulJwaIfNAsL64aHSbdFZF2rjqNO0zdCv1s9KntZ1aSf9RGrlO3ZDtYbc2ADVlAo+5NMX1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744674235; c=relaxed/simple;
	bh=uocl/OfR2NB/Ht+CCTK9+GlJGOXT72YGx9u9MNQxkkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOztIOftKvFV5eTVoWr3FPvbgPe4pAL2eXgsXjMIKLE5a9ARtWo2UNeL9OEgYFiNYFCPCZyOZjeAsALAYQpMnrfZnXgaOGDGsK02KNGb6fu2Kqshl7XNY4VunZH4edHXXI+619Tt2Hka44oSSM1PLF97qn+COpQNiTOJpQkJJ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SXy6Mm0N; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744674233; x=1776210233;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uocl/OfR2NB/Ht+CCTK9+GlJGOXT72YGx9u9MNQxkkg=;
  b=SXy6Mm0N8StpGFq0w7diMt+MuOCqx7BaWblWTlLWClO3IHvpgGNBx+lG
   BfL7ovxHWrb6S+j8zgFu9cDWiJfmEBHrr4eZBs2y6hJmCc6uEAfyUqDmn
   A6Z3MNjcfg5rl/o2IMF9nCg1EwgzHaxjDCfdFcWpaAFH6nKEm2KnGcZpf
   OpguuoHctuRWh/nMODQFqAlyP1H5C/SW+iwXKagr6LgQlQNKpNl0juYYz
   yZ0XZr5K8v5L16SfxCF/of2wqr2Gm76SrOka3CGe2tEnGDLFcYuzSBgQ5
   pyUabEEFGooLeiS2MVCFbbRylOD+qrDLT19SOTqMFsdY/B1tcVYtao0J7
   Q==;
X-CSE-ConnectionGUID: hKi9g0YkTxuj6Oyqjeodig==
X-CSE-MsgGUID: KRzqNy6gRQmdR/j40A7mkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46074088"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46074088"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 16:43:53 -0700
X-CSE-ConnectionGUID: gYzfTTAaRX20NxsX3RadqA==
X-CSE-MsgGUID: 1sBQU1kWS1Sh3KYyDa8VWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="153135580"
Received: from bnkannan-mobl1.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.114.218])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 16:43:52 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH for-rc 1/2] irdma: free iwdev->rf after removing MSI-X
Date: Mon, 14 Apr 2025 18:42:30 -0500
Message-ID: <20250414234231.523-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

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
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
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
2.31.1


