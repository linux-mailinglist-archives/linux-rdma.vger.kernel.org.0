Return-Path: <linux-rdma+bounces-8385-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66944A50E3F
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 22:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3024B16A626
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 21:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3449265CC9;
	Wed,  5 Mar 2025 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+D6LeRh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D9265635;
	Wed,  5 Mar 2025 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211890; cv=none; b=QyymlcdDPGVeKFf/vzHOKUqHgC0xSY6Up2fAwN+bVw8GrQIrmotwR1ZZ5sWEBwV90pp4D8Jm20CCnDgnUE7OEcA80CGrXuMvOdyKEKcslJi0htBK9+FIeIBTX8NHmmGFloHCi7DiGJ0D3/FOVtHQl/DlqYVTu2azqGCtIISjmRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211890; c=relaxed/simple;
	bh=YtN9hyJWflxYKrfouDqhZZNXrLwx9v59K9kMzD86Tus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Frov9PCA/owRLnmtSLEFX5Nmi529DZZ98HDNNWQYtaEQoixg3NyXw6KTqwD1n6Xq+Ik+NORv6824+TPH4h0aijIFFmaV3cnsFbSCHVmYeE5nFWaPIciBacKZ0m4VhuqImZxfrtBlR8K1EDSbcxpM2NBMwq8b7MgjiEZ8+dHm568=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+D6LeRh; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741211889; x=1772747889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YtN9hyJWflxYKrfouDqhZZNXrLwx9v59K9kMzD86Tus=;
  b=E+D6LeRhqfchuMemmktdumQ6MpESVVfemMCy4LB6bwNr5OhRNX651x6p
   f43QhX1RgXC05HZw26WKOxrAWbUbSwEiRrY2TP4lprhdQ5TSQ9NRiXxs1
   1iD1ItiKNkRtmExxP/119z5UmYvrsD4O7aZAk5Cw0rMGcMLPcWwyO6EDZ
   EUGZAzGyHR+rko37Hasfx6lOCBDeaYV+PJL1Ojw5gv3MM3y3ZxwLATN6W
   uKDkooLehHbBp2khnQH4kpdaxDKqbky4FA+tUydbqixyeRUQSkVtaiKSH
   9XU3Hu8VdzHORvkI7ikx0p2jghsnB5OWNWJ4wae/Ctbs6E+KOwJvE/CV4
   w==;
X-CSE-ConnectionGUID: odLQBIjbRpuhP59/RQl29w==
X-CSE-MsgGUID: q/6KS7jOTZSiKZABEIeMaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29782163"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="29782163"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 13:58:06 -0800
X-CSE-ConnectionGUID: DnUSyhtPStmb9SoVIl7lKA==
X-CSE-MsgGUID: BRvv+jA1RmuTNW/R1SpHOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118741664"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 05 Mar 2025 13:58:05 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	tatyana.e.nikolova@intel.com,
	leon@kernel.org,
	jgg@ziepe.ca,
	linux-rdma@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH net-next 2/2] irdma: free iwdev->rf after removing MSI-X
Date: Wed,  5 Mar 2025 13:57:53 -0800
Message-ID: <20250305215756.1519390-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305215756.1519390-1-anthony.l.nguyen@intel.com>
References: <20250305215756.1519390-1-anthony.l.nguyen@intel.com>
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
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/infiniband/hw/irdma/main.c  | 2 ++
 drivers/infiniband/hw/irdma/verbs.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 5fc081ca8905..7599e31b5743 100644
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
2.47.1


