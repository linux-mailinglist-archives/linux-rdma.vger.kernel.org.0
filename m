Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE162C34C1
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Nov 2020 00:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbgKXXmv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 18:42:51 -0500
Received: from mga18.intel.com ([134.134.136.126]:40242 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730270AbgKXXmv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Nov 2020 18:42:51 -0500
IronPort-SDR: sZrVwKZ6w4Nkz6AGyNPHRubfhXC0HJqouTyf+PMSk/Dwx7bDbYbbrdBuxOy3FJxvLnsP9Pt9Lq
 BZIBzuMMPzdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="159801398"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="159801398"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 15:42:51 -0800
IronPort-SDR: 5LjAGzIoLhtgkGAPx9WuEjoFh/itH5U6WuRp1SlTWSYgvKGDER+Ox4ksFxmucObN53gWetf5ON
 zUEDHI5jzv3g==
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="478695673"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.212.134.32])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 15:42:50 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, stable@kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH 1/2] RDMA/i40iw: Address an mmap handler exploit in i40iw
Date:   Tue, 24 Nov 2020 17:42:23 -0600
Message-Id: <20201124234224.1654-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201124234224.1654-1-shiraz.saleem@intel.com>
References: <20201124234224.1654-1-shiraz.saleem@intel.com>
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
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/i40iw/i40iw_main.c  |    4 ---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c |   37 +++++-----------------------
 2 files changed, 7 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index 2408b27..8bf15c1 100644
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

