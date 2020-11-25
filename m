Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2162C35D4
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Nov 2020 01:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgKYA4q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 19:56:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:24261 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbgKYA4q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Nov 2020 19:56:46 -0500
IronPort-SDR: HrNk+2WrqLHv+p16SeMyPM80RREPLIUfgTAP3kC4U0Qmmq7kryQBRav6XhiHBm5iij99ywB5Y0
 O/yQk3VZePpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="236179426"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="236179426"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 16:56:45 -0800
IronPort-SDR: kzngTPiWAryiaffnveHlXmG2ZomxxfdszhTUDL89g1XPvbMPZzXp6jxPLKKRtHfM+n+uDb6xuA
 SJCdjVcleNNg==
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="370647821"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.212.134.32])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 16:56:43 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, stable@kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Di Zhu <zhudi21@huawei.com>
Subject: [PATCH v2 1/2] RDMA/i40iw: Address an mmap handler exploit in i40iw
Date:   Tue, 24 Nov 2020 18:56:16 -0600
Message-Id: <20201125005616.1800-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201125005616.1800-1-shiraz.saleem@intel.com>
References: <20201125005616.1800-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

i40iw_mmap manipulates the vma->vm_pgoff to differentiate a push page
mmap vs a doorbell mmap, and uses it to compute the pfn in remap_pfn_range
without any validation. This is vulnerable to an mmap exploit as
described in [1].

Push feature is disabled in the driver currently and therefore no push
mmaps are issued from user-space. The feature does not work as expected
in the x722 product.

Remove the push module parameter and all VMA attribute manipulations
for this feature in i40iw_mmap. Update i40iw_mmap to only allow DB
user mmapings at offset = 0. Check vm_pgoff for zero and if the mmaps
are bound to a single page.

[1] https://lore.kernel.org/linux-rdma/20201119093523.7588-1-zhudi21@huawei.com/raw

Fixes: d37498417947 ("i40iw: add files for iwarp interface")
Cc: stable@kernel.org
Reported-by: Di Zhu <zhudi21@huawei.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/i40iw/i40iw_main.c  |    5 ----
 drivers/infiniband/hw/i40iw/i40iw_verbs.c |   37 +++++-----------------------
 2 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index 2408b27..584932d 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -54,10 +54,6 @@
 #define DRV_VERSION	__stringify(DRV_VERSION_MAJOR) "."		\
 	__stringify(DRV_VERSION_MINOR) "." __stringify(DRV_VERSION_BUILD)
 
-static int push_mode;
-module_param(push_mode, int, 0644);
-MODULE_PARM_DESC(push_mode, "Low latency mode: 0=disabled (default), 1=enabled)");
-
 static int debug;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "debug flags: 0=disabled (default), 0x7fffffff=all");
@@ -1580,7 +1576,6 @@ static enum i40iw_status_code i40iw_setup_init_state(struct i40iw_handler *hdl,
 	if (status)
 		goto exit;
 	iwdev->obj_next = iwdev->obj_mem;
-	iwdev->push_mode = push_mode;
 
 	init_waitqueue_head(&iwdev->vchnl_waitq);
 	init_waitqueue_head(&dev->vf_reqs);
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 581ecba..533f3ca 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -167,39 +167,16 @@ static void i40iw_dealloc_ucontext(struct ib_ucontext *context)
  */
 static int i40iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 {
-	struct i40iw_ucontext *ucontext;
-	u64 db_addr_offset, push_offset, pfn;
-
-	ucontext = to_ucontext(context);
-	if (ucontext->iwdev->sc_dev.is_pf) {
-		db_addr_offset = I40IW_DB_ADDR_OFFSET;
-		push_offset = I40IW_PUSH_OFFSET;
-		if (vma->vm_pgoff)
-			vma->vm_pgoff += I40IW_PF_FIRST_PUSH_PAGE_INDEX - 1;
-	} else {
-		db_addr_offset = I40IW_VF_DB_ADDR_OFFSET;
-		push_offset = I40IW_VF_PUSH_OFFSET;
-		if (vma->vm_pgoff)
-			vma->vm_pgoff += I40IW_VF_FIRST_PUSH_PAGE_INDEX - 1;
-	}
+	struct i40iw_ucontext *ucontext = to_ucontext(context);
+	u64 dbaddr;
 
-	vma->vm_pgoff += db_addr_offset >> PAGE_SHIFT;
-
-	if (vma->vm_pgoff == (db_addr_offset >> PAGE_SHIFT)) {
-		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	} else {
-		if ((vma->vm_pgoff - (push_offset >> PAGE_SHIFT)) % 2)
-			vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-		else
-			vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
-	}
+	if (vma->vm_pgoff || vma->vm_end - vma->vm_start != PAGE_SIZE)
+		return -EINVAL;
 
-	pfn = vma->vm_pgoff +
-	      (pci_resource_start(ucontext->iwdev->ldev->pcidev, 0) >>
-	       PAGE_SHIFT);
+	dbaddr = I40IW_DB_ADDR_OFFSET + pci_resource_start(ucontext->iwdev->ldev->pcidev, 0);
 
-	return rdma_user_mmap_io(context, vma, pfn, PAGE_SIZE,
-				 vma->vm_page_prot, NULL);
+	return rdma_user_mmap_io(context, vma, dbaddr >> PAGE_SHIFT, PAGE_SIZE,
+				 pgprot_noncached(vma->vm_page_prot), NULL);
 }
 
 /**
-- 
1.7.1

