Return-Path: <linux-rdma+bounces-14559-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0493C66356
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 22:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4006A4EEAA4
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CB72D3237;
	Mon, 17 Nov 2025 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L29/tDug"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C40534CFD2
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763413693; cv=none; b=pCw2J+1pXtZ004Jk+CaD30xImKO/ojPzVzRUlbhxEtnpKnuCE2ekWnF5wcg4ri52fzrXtc+ZP3SzJdYY354tETPj4y26oUYCeAtlo24gIIvYvMh9N/INwyxR7cMkZGpm0Q7VA6YbiPMqNheUONwCJv0N12CDIuK7KzRC6kI5So4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763413693; c=relaxed/simple;
	bh=z/8YFsYFnfQeCrLLBY8LgwlsTjf9R0gc4Nz+cQC/K8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLDxDZ6O3BWyZX/glLdBxcHJ8Ija0EhMziOSOe/ASBQIpXOHwt0GTJULVJOJHL+byazzX2O6Wo9FXCJEuuJYJ2fX2gKtalHnAdSrwJsgIieT1O1hBDgR5A2/JRydkosj/L+Hem+H8RWd5exMxKL4aT2Z2WJ3H6C80I9Bz3ldMRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L29/tDug; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763413692; x=1794949692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z/8YFsYFnfQeCrLLBY8LgwlsTjf9R0gc4Nz+cQC/K8k=;
  b=L29/tDugTrK3QCq0KclmZb8zCs9GSuIe0fdTE7ybAuIIw721qNdfdSwi
   8UO0NiWJSQU8xnHpqzkkJVhSaD7OPlO56gjuXBVmOo3P+f79JTLuhZ18t
   +pqjWPQ8BpHDl7ufSBGUTNKiiFBqEVHuO4B7hDZfNm8T6w3LscuEgQmHk
   xPTTe5o767Z0BHlNGDe+Pq0nhGvHRjtOwGqmt96HppQG72WE1AYNcZlhG
   6PTz4ca2O8pkhHh0i68z8/HJSULOYg9wxHX8CMGCb0hYDJvauXmUd/Ag3
   2fIs1Sx9liR9h6cInE0tsWvWCyB9IE1Ne1oQ7vF63d4mK1hJ3ZcDVgcI3
   w==;
X-CSE-ConnectionGUID: CsTNcpXyRky5XhB8nnp3ZQ==
X-CSE-MsgGUID: Zny08jqPR9WU269dFKxXoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="83051128"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="83051128"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 13:08:11 -0800
X-CSE-ConnectionGUID: 0lW7WI6RRzqQYisjx4XRDQ==
X-CSE-MsgGUID: WgypuIuuS5aCcGKqWhEg4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="190583660"
Received: from soc-pf51ragt.clients.intel.com ([10.122.185.21])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 13:08:10 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com,
	Anil Samal <anil.samal@intel.com>
Subject: [PATCH] RDMA/irdma: Add missing mutex destroy
Date: Mon, 17 Nov 2025 15:07:53 -0600
Message-ID: <20251117210756.723-5-tatyana.e.nikolova@intel.com>
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

From: Anil Samal <anil.samal@intel.com>

Add missing destroy of ah_tbl_lock and vchnl_mutex.

Signed-off-by: Anil Samal <anil.samal@intel.com>
Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/icrdma_if.c  | 4 +++-
 drivers/infiniband/hw/irdma/ig3rdma_if.c | 4 ++++
 drivers/infiniband/hw/irdma/verbs.c      | 4 +++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/icrdma_if.c b/drivers/infiniband/hw/irdma/icrdma_if.c
index 5d3fd118e4f8..b49fd9cf2476 100644
--- a/drivers/infiniband/hw/irdma/icrdma_if.c
+++ b/drivers/infiniband/hw/irdma/icrdma_if.c
@@ -302,7 +302,8 @@ static int icrdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary
 err_ctrl_init:
 	icrdma_deinit_interrupts(rf, cdev_info);
 err_init_interrupts:
-	kfree(iwdev->rf);
+	mutex_destroy(&rf->ah_tbl_lock);
+	kfree(rf);
 	ib_dealloc_device(&iwdev->ibdev);
 
 	return err;
@@ -319,6 +320,7 @@ static void icrdma_remove(struct auxiliary_device *aux_dev)
 	ice_rdma_update_vsi_filter(cdev_info, iwdev->vsi_num, false);
 	irdma_ib_unregister_device(iwdev);
 	icrdma_deinit_interrupts(iwdev->rf, cdev_info);
+	mutex_destroy(&iwdev->rf->ah_tbl_lock);
 
 	kfree(iwdev->rf);
 
diff --git a/drivers/infiniband/hw/irdma/ig3rdma_if.c b/drivers/infiniband/hw/irdma/ig3rdma_if.c
index 1bb42eb298ba..e1d6670d9396 100644
--- a/drivers/infiniband/hw/irdma/ig3rdma_if.c
+++ b/drivers/infiniband/hw/irdma/ig3rdma_if.c
@@ -55,6 +55,7 @@ static int ig3rdma_vchnl_init(struct irdma_pci_f *rf,
 	ret = irdma_sc_vchnl_init(&rf->sc_dev, &virt_info);
 	if (ret) {
 		destroy_workqueue(rf->vchnl_wq);
+		mutex_destroy(&rf->sc_dev.vchnl_mutex);
 		return ret;
 	}
 
@@ -124,7 +125,9 @@ static void ig3rdma_decfg_rf(struct irdma_pci_f *rf)
 {
 	struct irdma_hw *hw = &rf->hw;
 
+	mutex_destroy(&rf->ah_tbl_lock);
 	destroy_workqueue(rf->vchnl_wq);
+	mutex_destroy(&rf->sc_dev.vchnl_mutex);
 	kfree(hw->io_regs);
 	iounmap(hw->rdma_reg.addr);
 }
@@ -149,6 +152,7 @@ static int ig3rdma_cfg_rf(struct irdma_pci_f *rf,
 	err = ig3rdma_cfg_regions(&rf->hw, cdev_info);
 	if (err) {
 		destroy_workqueue(rf->vchnl_wq);
+		mutex_destroy(&rf->sc_dev.vchnl_mutex);
 		return err;
 	}
 
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 05a1be5ed426..a5b14ff09605 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -5509,7 +5509,9 @@ void irdma_ib_dealloc_device(struct ib_device *ibdev)
 	irdma_rt_deinit_hw(iwdev);
 	if (!iwdev->is_vport) {
 		irdma_ctrl_deinit_hw(iwdev->rf);
-		if (iwdev->rf->vchnl_wq)
+		if (iwdev->rf->vchnl_wq) {
 			destroy_workqueue(iwdev->rf->vchnl_wq);
+			mutex_destroy(&iwdev->rf->sc_dev.vchnl_mutex);
+		}
 	}
 }
-- 
2.31.1


