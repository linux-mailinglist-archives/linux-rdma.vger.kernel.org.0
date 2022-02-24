Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C604C21BF
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 03:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiBXCZS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 21:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiBXCZQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 21:25:16 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6EF22C6F6
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 18:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645669488; x=1677205488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TDj4bdLIl2vCf4AE1laXwBcch8ZyPVdkvFeeIXkrZlQ=;
  b=DKfrfRvaL/rCwlER9NokcQYLkFtKri/qbEpGrE5UmSKnFTVjC/hsBZRp
   lXUVxHgMdLVWwqtS4riNYNig24lSGAi6QVO4yxvWWokSqklxC8Mfz8giP
   6Nfpz6uPgHc8PiqrKYdu+72EWsn/K/wdUFeYANSQGepecowF4brxOU/P9
   N3OJ9VzRIoLD+kOQqrD3au0O50ih3QqPOJFmTU4NSr5xptbYTUkmOFMtB
   fwY7HKZIHZV2HYPV2oZpd044Ir8VyYHyIP+tVutPt9NB7ezUS6ZXMswE6
   kQLpIeXFl4LcoM4UJH1/loSYjuBHGK+jcVQ1qxvI7c0S+hurTRX9oxbEJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="235627966"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="235627966"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:58:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="548513127"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.255.38.207])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:58:51 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH rdma-rc 2/3] RDMA/irdma: Fix Passthrough mode in VM
Date:   Wed, 23 Feb 2022 18:58:41 -0600
Message-Id: <20220224005842.1707-3-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220224005842.1707-1-shiraz.saleem@intel.com>
References: <20220224005842.1707-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

Using PCI_FUNC macro in a VM, when the device is in passthrough
mode does not provide the real function instance. This means that
currently, devices will not probe unless the instance in the VM
matches the instance in the host.

Fix this by getting the pf_id from the LAN during the probe.

Fixes: 8498a30e1b94 ("RDMA/irdma: Register auxiliary driver and implement private channel OPs")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c       | 2 +-
 drivers/infiniband/hw/irdma/i40iw_if.c | 1 +
 drivers/infiniband/hw/irdma/main.c     | 1 +
 drivers/infiniband/hw/irdma/main.h     | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 89234d0..e46e324 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1608,7 +1608,7 @@ static enum irdma_status_code irdma_initialize_dev(struct irdma_pci_f *rf)
 	info.fpm_commit_buf = mem.va;
 
 	info.bar0 = rf->hw.hw_addr;
-	info.hmc_fn_id = PCI_FUNC(rf->pcidev->devfn);
+	info.hmc_fn_id = rf->pf_id;
 	info.hw = &rf->hw;
 	status = irdma_sc_dev_init(rf->rdma_ver, &rf->sc_dev, &info);
 	if (status)
diff --git a/drivers/infiniband/hw/irdma/i40iw_if.c b/drivers/infiniband/hw/irdma/i40iw_if.c
index 43e962b..0886783 100644
--- a/drivers/infiniband/hw/irdma/i40iw_if.c
+++ b/drivers/infiniband/hw/irdma/i40iw_if.c
@@ -77,6 +77,7 @@ static void i40iw_fill_device_info(struct irdma_device *iwdev, struct i40e_info
 	rf->rdma_ver = IRDMA_GEN_1;
 	rf->gen_ops.request_reset = i40iw_request_reset;
 	rf->pcidev = cdev_info->pcidev;
+	rf->pf_id = cdev_info->fid;
 	rf->hw.hw_addr = cdev_info->hw_addr;
 	rf->cdev = cdev_info;
 	rf->msix_count = cdev_info->msix_count;
diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 9fab290..5e8e886 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -226,6 +226,7 @@ static void irdma_fill_device_info(struct irdma_device *iwdev, struct ice_pf *pf
 	rf->hw.hw_addr = pf->hw.hw_addr;
 	rf->pcidev = pf->pdev;
 	rf->msix_count =  pf->num_rdma_msix;
+	rf->pf_id = pf->hw.pf_id;
 	rf->msix_entries = &pf->msix_entries[pf->rdma_base_vector];
 	rf->default_vsi.vsi_idx = vsi->vsi_num;
 	rf->protocol_used = pf->rdma_mode & IIDC_RDMA_PROTOCOL_ROCEV2 ?
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index cb218ca..fb7faa8 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -257,6 +257,7 @@ struct irdma_pci_f {
 	u8 *mem_rsrc;
 	u8 rdma_ver;
 	u8 rst_to;
+	u8 pf_id;
 	enum irdma_protocol_used protocol_used;
 	u32 sd_type;
 	u32 msix_count;
-- 
1.8.3.1

