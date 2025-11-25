Return-Path: <linux-rdma+bounces-14745-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBDCC83256
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 03:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC11F34BF73
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 02:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1012B1DDC33;
	Tue, 25 Nov 2025 02:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvqJKTen"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9801DFE09
	for <linux-rdma@vger.kernel.org>; Tue, 25 Nov 2025 02:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039301; cv=none; b=DPiVKyAXcXmY0CypBTLjQb1oWD9PkWoJH8Kzc/P5VKKGv6QDewc0YN9qb1/1f0nethmu9XbCwrCgePNWgo1Sn6r+Dz9060s617fTBXylm6k2mOaOqCOeqvJnPJwhCmWTDdaKzboj/wjv6HXDp9H7fWKl0Sikou2mV8KO1qLHFEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039301; c=relaxed/simple;
	bh=CUpRB70/Kgyl70lwQvNBpwCAk5ySubC06IVSWecFKzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7ZK7l7sNJQeGBuJz27g5jFehnBUwr7x32OAbojTAW4yLOMO/lQqnZ9hlwCvY7y2vCo25AsEZ4o1moyL/pObLjIwAWYQNxKEadYAZPONIivopXppEmMRTIcub3Ta8MA98X3HF0d9USkigKKEXG1CKHpYxXLBBiy0hANxqvdHYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BvqJKTen; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764039300; x=1795575300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CUpRB70/Kgyl70lwQvNBpwCAk5ySubC06IVSWecFKzY=;
  b=BvqJKTenWelozJD6TdTScnJEhnm9H5S5l865UuNS4xGRrkQ2KcdHcY+/
   EmPQQTIwOU6qnjsVuAZe9CRZCPCbzszuPFY87chY1589NcanB7TxuuLDY
   nTAn8+FbTH7t2QgstCLQ8yO4K90iUoItmpth8Ss9ZqNnhHENdO8Evt8au
   FFIQmDIiCCG3IpK/y+5fOJTx+OjZZs9wTbHj0U4cEOCnnBLzYms9cTWpO
   +l9FVACs6iMOr8g5yvMiW6vABk4LgJXWMuovBGoCeqQjlwKnaSYtR72f/
   tFO1bTiBDcV95MjpQUkyl1i/BTAEufnBkOR0b7vlJ/VXgZA4nitE7AyTF
   w==;
X-CSE-ConnectionGUID: w3WCzJXbTUWssPb0Us2HJQ==
X-CSE-MsgGUID: IFOmgMZMQ1OzYDo2GvHtvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65942210"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="65942210"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:54:59 -0800
X-CSE-ConnectionGUID: fW4ibaiURuahdTFHxQNYSw==
X-CSE-MsgGUID: pKahtya/QDe/aNqUagcWpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="196800297"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 18:54:58 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com,
	jmoroni@google.com,
	Anil Samal <anil.samal@intel.com>
Subject: [PATCH 5/9] RDMA/irdma: Add missing mutex destroy
Date: Mon, 24 Nov 2025 20:53:46 -0600
Message-ID: <20251125025350.180-6-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20251125025350.180-1-tatyana.e.nikolova@intel.com>
References: <20251125025350.180-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anil Samal <anil.samal@intel.com>

Add missing destroy of ah_tbl_lock and vchnl_mutex.

Fixes: d5edd33364a5 ("RDMA/irdma: RDMA/irdma: Add GEN3 core driver support")
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
index 66ecaa0f5be6..e35c8e87a756 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -5506,7 +5506,9 @@ void irdma_ib_dealloc_device(struct ib_device *ibdev)
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


