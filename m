Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EDE23FD2E
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Aug 2020 09:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgHIHca (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Aug 2020 03:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgHIHc3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Aug 2020 03:32:29 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9CAC061756;
        Sun,  9 Aug 2020 00:32:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id p1so3261995pls.4;
        Sun, 09 Aug 2020 00:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vCUp4yNLVhkxzX16ziPmjg/hfpqr5wNUWS8g+jqIyUE=;
        b=fl9Gid/BNFvSTOD4l7Dt20K3zVQ4FP1tcTGJZpp/DBuhDaAGEc+1uak9c0PkysbPVm
         S7wIPoNFccAYYBRcU4IDkfiygJOZw+HiM0qiVirxzQaNqUQHI4ACOd1t73i5HyhTxtkb
         vx5diB/1HLVh3mQ4cPReGCmmMpgarscxHW9TvpjQf4w7Zc1ALlk+uVa2uDq1TpoWDIos
         GpdfmuhPwH7s2AHYGTrQrjjXdL5RV//vHKUJYuKzDS/5SPDJCy07e+QYixcirzNXhTOF
         hzh8bsga/L0MRqnt3oJMk5N8UqDQgNxHGIETOmTjgLqzp5nhmZ+Bj5MS3Iz2nl9HDTaP
         iHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vCUp4yNLVhkxzX16ziPmjg/hfpqr5wNUWS8g+jqIyUE=;
        b=r58olgzEuT4L42GQXeLAY56DFEd9lB4gmhzleUafkCxwzPOp4YPrwF4zGINo4TCxVT
         l6dc70E8oLQgekdBoVWwu8n/sShYTkGqoDAPs4n/A080CpbzZwwnAGWxpX5h14EhfKH4
         y7ldjqIsxHLHyA3U75KuWqfAbhrepUbnDCvFZmVD2U4Ip0mkn1TYapF8e5hVsS9186GC
         WW4ROrplCdv4ubWE1e6NEWHOBTF+G1BXRyw4iYBCfscPEJN/RaYLLqL2tp+WSc9grZhw
         jz1yodR9Aac5usugcrwbtbrWFkVQLQUNdIKDfpNvbZN9H3k7QDpo8Da+Nzx1ZLxYOBHU
         ZN2A==
X-Gm-Message-State: AOAM533T8+kn+nruHSv/llypght2ejLx4KT7BGRws6qNIsero0QhoO+K
        BRN+hy597qs2sLL+l1TMVaA=
X-Google-Smtp-Source: ABdhPJzoo9DtlYjFE3D8uNuRL/6/yYDMWdgjiTndQ+JoDuKhxigflL6jp3sNTUOdrkWAfeM1yYMsxA==
X-Received: by 2002:a17:90a:de10:: with SMTP id m16mr21650689pjv.34.1596958348919;
        Sun, 09 Aug 2020 00:32:28 -0700 (PDT)
Received: from blackclown ([103.88.82.9])
        by smtp.gmail.com with ESMTPSA id z62sm18020938pfb.47.2020.08.09.00.32.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Aug 2020 00:32:28 -0700 (PDT)
Date:   Sun, 9 Aug 2020 13:02:16 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, dennis.dalessandro@intel.com,
        mike.marciniszyn@intel.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 3/4] RDMA/qib: Remove pci-dma-compat wrapper APIs
Message-ID: <2221f49fba32a2fbeab6dafbb93ec68498186c37.1596957073.git.usuraj35@gmail.com>
References: <cover.1596957073.git.usuraj35@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1596957073.git.usuraj35@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The legacy API wrappers in include/linux/pci-dma-compat.h
should go away as it creates unnecessary midlayering
for include/linux/dma-mapping.h APIs.

Instead use dma-mapping.h APIs directly.

The patch has been generated with the coccinelle script below
and compile-tested.

@@@@
- PCI_DMA_BIDIRECTIONAL
+ DMA_BIDIRECTIONAL

@@@@
- PCI_DMA_TODEVICE
+ DMA_TO_DEVICE

@@@@
- PCI_DMA_FROMDEVICE
+ DMA_FROM_DEVICE

@@@@
- PCI_DMA_NONE
+ DMA_NONE

@@ expression E1, E2, E3; @@
- pci_alloc_consistent(E1, E2, E3)
+ dma_alloc_coherent(&E1->dev, E2, E3, GFP_)

@@ expression E1, E2, E3; @@
- pci_zalloc_consistent(E1, E2, E3)
+ dma_alloc_coherent(&E1->dev, E2, E3, GFP_)

@@ expression E1, E2, E3, E4; @@
- pci_free_consistent(E1, E2, E3, E4)
+ dma_free_coherent(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_map_single(E1, E2, E3, E4)
+ dma_map_single(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_unmap_single(E1, E2, E3, E4)
+ dma_unmap_single(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4, E5; @@
- pci_map_page(E1, E2, E3, E4, E5)
+ dma_map_page(&E1->dev, E2, E3, E4, E5)

@@ expression E1, E2, E3, E4; @@
- pci_unmap_page(E1, E2, E3, E4)
+ dma_unmap_page(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_map_sg(E1, E2, E3, E4)
+ dma_map_sg(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_unmap_sg(E1, E2, E3, E4)
+ dma_unmap_sg(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_dma_sync_single_for_cpu(E1, E2, E3, E4)
+ dma_sync_single_for_cpu(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_dma_sync_single_for_device(E1, E2, E3, E4)
+ dma_sync_single_for_device(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_dma_sync_sg_for_cpu(E1, E2, E3, E4)
+ dma_sync_sg_for_cpu(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_dma_sync_sg_for_device(E1, E2, E3, E4)
+ dma_sync_sg_for_device(&E1->dev, E2, E3, E4)

@@ expression E1, E2; @@
- pci_dma_mapping_error(E1, E2)
+ dma_mapping_error(&E1->dev, E2)

@@ expression E1, E2; @@
- pci_set_consistent_dma_mask(E1, E2)
+ dma_set_coherent_mask(&E1->dev, E2)

@@ expression E1, E2; @@
- pci_set_dma_mask(E1, E2)
+ dma_set_mask(&E1->dev, E2)

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/infiniband/hw/qib/qib_file_ops.c   | 12 ++++++------
 drivers/infiniband/hw/qib/qib_init.c       |  4 ++--
 drivers/infiniband/hw/qib/qib_pcie.c       |  8 ++++----
 drivers/infiniband/hw/qib/qib_user_pages.c | 12 ++++++------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index ff87a67dd7b7..d36412ace705 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -429,8 +429,8 @@ static int qib_tid_update(struct qib_ctxtdata *rcd, struct file *fp,
 				dd->f_put_tid(dd, &tidbase[tid],
 					      RCVHQ_RCV_TYPE_EXPECTED,
 					      dd->tidinvalid);
-				pci_unmap_page(dd->pcidev, phys, PAGE_SIZE,
-					       PCI_DMA_FROMDEVICE);
+				dma_unmap_page(&dd->pcidev->dev, phys,
+					       PAGE_SIZE, DMA_FROM_DEVICE);
 				dd->pageshadow[ctxttid + tid] = NULL;
 			}
 		}
@@ -544,8 +544,8 @@ static int qib_tid_free(struct qib_ctxtdata *rcd, unsigned subctxt,
 			 */
 			dd->f_put_tid(dd, &tidbase[tid],
 				      RCVHQ_RCV_TYPE_EXPECTED, dd->tidinvalid);
-			pci_unmap_page(dd->pcidev, phys, PAGE_SIZE,
-				       PCI_DMA_FROMDEVICE);
+			dma_unmap_page(&dd->pcidev->dev, phys, PAGE_SIZE,
+				       DMA_FROM_DEVICE);
 			qib_release_user_pages(&p, 1);
 		}
 	}
@@ -1780,8 +1780,8 @@ static void unlock_expected_tids(struct qib_ctxtdata *rcd)
 		phys = dd->physshadow[i];
 		dd->physshadow[i] = dd->tidinvalid;
 		dd->pageshadow[i] = NULL;
-		pci_unmap_page(dd->pcidev, phys, PAGE_SIZE,
-			       PCI_DMA_FROMDEVICE);
+		dma_unmap_page(&dd->pcidev->dev, phys, PAGE_SIZE,
+			       DMA_FROM_DEVICE);
 		qib_release_user_pages(&p, 1);
 		cnt++;
 	}
diff --git a/drivers/infiniband/hw/qib/qib_init.c b/drivers/infiniband/hw/qib/qib_init.c
index 43c8ee1f46e0..35cd5b393281 100644
--- a/drivers/infiniband/hw/qib/qib_init.c
+++ b/drivers/infiniband/hw/qib/qib_init.c
@@ -1335,8 +1335,8 @@ static void cleanup_device_data(struct qib_devdata *dd)
 			for (i = ctxt_tidbase; i < maxtid; i++) {
 				if (!tmpp[i])
 					continue;
-				pci_unmap_page(dd->pcidev, tmpd[i],
-					       PAGE_SIZE, PCI_DMA_FROMDEVICE);
+				dma_unmap_page(&dd->pcidev->dev, tmpd[i],
+					       PAGE_SIZE, DMA_FROM_DEVICE);
 				qib_release_user_pages(&tmpp[i], 1);
 				tmpp[i] = NULL;
 			}
diff --git a/drivers/infiniband/hw/qib/qib_pcie.c b/drivers/infiniband/hw/qib/qib_pcie.c
index 3dc6ce033319..7bb93c3a59e3 100644
--- a/drivers/infiniband/hw/qib/qib_pcie.c
+++ b/drivers/infiniband/hw/qib/qib_pcie.c
@@ -90,21 +90,21 @@ int qib_pcie_init(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto bail;
 	}
 
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret) {
 		/*
 		 * If the 64 bit setup fails, try 32 bit.  Some systems
 		 * do not setup 64 bit maps on systems with 2GB or less
 		 * memory installed.
 		 */
-		ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 		if (ret) {
 			qib_devinfo(pdev, "Unable to set DMA mask: %d\n", ret);
 			goto bail;
 		}
-		ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+		ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 	} else
-		ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+		ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret) {
 		qib_early_err(&pdev->dev,
 			      "Unable to set DMA consistent mask: %d\n", ret);
diff --git a/drivers/infiniband/hw/qib/qib_user_pages.c b/drivers/infiniband/hw/qib/qib_user_pages.c
index 4c24e83f3175..dd1cff31b538 100644
--- a/drivers/infiniband/hw/qib/qib_user_pages.c
+++ b/drivers/infiniband/hw/qib/qib_user_pages.c
@@ -60,15 +60,15 @@ int qib_map_page(struct pci_dev *hwdev, struct page *page, dma_addr_t *daddr)
 {
 	dma_addr_t phys;
 
-	phys = pci_map_page(hwdev, page, 0, PAGE_SIZE, PCI_DMA_FROMDEVICE);
-	if (pci_dma_mapping_error(hwdev, phys))
+	phys = dma_map_page(&hwdev->dev, page, 0, PAGE_SIZE, DMA_FROM_DEVICE);
+	if (dma_mapping_error(&hwdev->dev, phys))
 		return -ENOMEM;
 
 	if (!phys) {
-		pci_unmap_page(hwdev, phys, PAGE_SIZE, PCI_DMA_FROMDEVICE);
-		phys = pci_map_page(hwdev, page, 0, PAGE_SIZE,
-				    PCI_DMA_FROMDEVICE);
-		if (pci_dma_mapping_error(hwdev, phys))
+		dma_unmap_page(&hwdev->dev, phys, PAGE_SIZE, DMA_FROM_DEVICE);
+		phys = dma_map_page(&hwdev->dev, page, 0, PAGE_SIZE,
+				    DMA_FROM_DEVICE);
+		if (dma_mapping_error(&hwdev->dev, phys))
 			return -ENOMEM;
 		/*
 		 * FIXME: If we get 0 again, we should keep this page,
-- 
2.17.1

