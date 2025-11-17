Return-Path: <linux-rdma+bounces-14557-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29101C6634A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 22:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A43DD29830
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3704C34CFDB;
	Mon, 17 Nov 2025 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fg/N6TCI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764F83446A3
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 21:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413693; cv=none; b=IA5S23cB1Mqr1vodk8TCexkxtfqOvk19IcDA5HcZqewiibxFZNmGmQcZI09eLCWuFhQgt0qHbO0U0F3HJ5djgEWkj2N8EDeMxVg8+Pj/AKJnJ11gsbxeqte6OdA659Egyg5olN4pEK//IchucoGCNl+sbFP0803E9oya8uaehZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413693; c=relaxed/simple;
	bh=RSStAWhQ+vifsUpAayzCYxnW3g7dpLugdR1p4N+epG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwvu4RSJCAEAFTURp4w/xz6Nz5yUps8J2KfM96VP1rBN4VKVDvcc+/ABPpT66ThYLoQ8gUlrlfoQLFbqPZC2+dj7Bv+dZm0MYwSB7uKOV7OrluXlXHPpbAW30g/1agWLKiQ+RbM2YkBKQRXzncnHhXJ5ZZMB4MEEYkDoEwxBvCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fg/N6TCI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763413692; x=1794949692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RSStAWhQ+vifsUpAayzCYxnW3g7dpLugdR1p4N+epG8=;
  b=Fg/N6TCI+RCpqdt7GrTeSoLSP4tCsAWz10I9aD8iySj0l+mFaWMBdLqp
   bjNUP/LnRRcQXQ0mOSdi4ESvfhxjzT+reNknDkdh6RHMQ3j9cewvK+RGd
   R9V1b1T09UtaLtfeIu76DvmPB//sJM61hR6kc1g7azcRrpIB56vIz3D85
   boavwXDWqjgCaqaCnxC+wWtlmZq9+a/wwcNeLqzNcImLo5vnuGCdLK2/Z
   6BCpPR8shbytZ8Dr3InldLAsPUmspjD/5030jD5bb4mI1qt398j3wI13G
   2cCTBxdRQSzp+eCA6bVzhsBAN1hKmfjtkkZqgSwNSTU7jTbEcTdKqqhdH
   A==;
X-CSE-ConnectionGUID: U2swhLkDRkK+m1Kz8gk1MA==
X-CSE-MsgGUID: Jo98bnFlSwix5+poHdVjsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="83051121"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="83051121"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 13:08:10 -0800
X-CSE-ConnectionGUID: xEwE15UoR3KUd5Qx7Rlwlg==
X-CSE-MsgGUID: HPvh2W9uTKGxJiO7Yul7Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="190583653"
Received: from soc-pf51ragt.clients.intel.com ([10.122.185.21])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 13:08:09 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [PATCH] RDMA/irdma: Add a missing kfree of struct irdma_pci_f for GEN2
Date: Mon, 17 Nov 2025 15:07:51 -0600
Message-ID: <20251117210756.723-3-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20251117210756.723-1-tatyana.e.nikolova@intel.com>
References: <20251117210756.723-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During a refactor of the irdma GEN2 code, the kfree of the irdma_pci_f struct
in icrdma_remove(), which was originally introduced upstream as part of
commit 80f2ab46c2ee ("irdma: free iwdev->rf after removing MSI-X")
was accidentally removed.

Fixes: 0c2b80cac96e ("RDMA/irdma: Refactor GEN2 auxiliary driver")
Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/icrdma_if.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/icrdma_if.c b/drivers/infiniband/hw/irdma/icrdma_if.c
index 27b191f61caf..5d3fd118e4f8 100644
--- a/drivers/infiniband/hw/irdma/icrdma_if.c
+++ b/drivers/infiniband/hw/irdma/icrdma_if.c
@@ -320,6 +320,8 @@ static void icrdma_remove(struct auxiliary_device *aux_dev)
 	irdma_ib_unregister_device(iwdev);
 	icrdma_deinit_interrupts(iwdev->rf, cdev_info);
 
+	kfree(iwdev->rf);
+
 	pr_debug("INIT: Gen[%d] func[%d] device remove success\n",
 		 rdma_ver, PCI_FUNC(cdev_info->pdev->devfn));
 }
-- 
2.31.1


