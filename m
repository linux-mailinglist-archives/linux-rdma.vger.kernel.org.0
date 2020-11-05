Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258072A7834
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 08:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgKEHql (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 02:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgKEHql (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 02:46:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10E9C0613CF;
        Wed,  4 Nov 2020 23:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KPMUUgzv+YFjxRct8tKHBnXGKiPeAkf97Ow3cKkBMFk=; b=MwmPbdTFSwGv/1t+y3wdxnwSHh
        pXJBtW15nFEBIjMOsBPxCW1/vaMKdrjmZWoM1bfiLtVx3G21l9uHJIAuHoXMsvBmFdQgbxZlpktS2
        Fp5oOH056tGbxPbqSJqDcdWf8qYP+yEUJdtzaX5nc47khwwZjo7yzxoiPPFOLGK69NMl0v+Y0DR5V
        L2/LIfCs+t7WUITT/0g45UhJMC/97/yRZdRT7YEjMGu1gPisyHr7AI+Dq5Zi8VpnnSistD5fCL4It
        dsR7z7l5YFRpGUI/zxvK52atkImqKI5bI6ANMZe3Wz05LqtdMjWcrytzRrQK8kfkuKglIE7qCFkU2
        e17NmNcw==;
Received: from 089144208145.atnat0017.highway.a1.net ([89.144.208.145] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaZyY-0004f6-8j; Thu, 05 Nov 2020 07:46:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH 1/6] RMDA/sw: don't allow drivers using dma_virt_ops on highmem configs
Date:   Thu,  5 Nov 2020 08:42:00 +0100
Message-Id: <20201105074205.1690638-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201105074205.1690638-1-hch@lst.de>
References: <20201105074205.1690638-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

dma_virt_ops requires that all pages have a kernel virtual address.
Introduce a INFINIBAND_VIRT_DMA Kconfig symbol that depends on !HIGHMEM
and a large enough dma_addr_t, and make all three driver depend on the
new symbol.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/Kconfig           | 6 ++++++
 drivers/infiniband/sw/rdmavt/Kconfig | 3 ++-
 drivers/infiniband/sw/rxe/Kconfig    | 2 +-
 drivers/infiniband/sw/siw/Kconfig    | 1 +
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 32a51432ec4f73..81acaf5fb5be67 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -73,6 +73,12 @@ config INFINIBAND_ADDR_TRANS_CONFIGFS
 	  This allows the user to config the default GID type that the CM
 	  uses for each device, when initiaing new connections.
 
+config INFINIBAND_VIRT_DMA
+	bool
+	default y
+	depends on !HIGHMEM
+	depends on !64BIT || ARCH_DMA_ADDR_T_64BIT
+
 if INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
 source "drivers/infiniband/hw/mthca/Kconfig"
 source "drivers/infiniband/hw/qib/Kconfig"
diff --git a/drivers/infiniband/sw/rdmavt/Kconfig b/drivers/infiniband/sw/rdmavt/Kconfig
index 9ef5f5ce1ff6b0..c8e268082952b0 100644
--- a/drivers/infiniband/sw/rdmavt/Kconfig
+++ b/drivers/infiniband/sw/rdmavt/Kconfig
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config INFINIBAND_RDMAVT
 	tristate "RDMA verbs transport library"
-	depends on X86_64 && ARCH_DMA_ADDR_T_64BIT
+	depends on INFINIBAND_VIRT_DMA
+	depends on X86_64
 	depends on PCI
 	select DMA_VIRT_OPS
 	help
diff --git a/drivers/infiniband/sw/rxe/Kconfig b/drivers/infiniband/sw/rxe/Kconfig
index a0c6c7dfc1814f..8810bfa680495a 100644
--- a/drivers/infiniband/sw/rxe/Kconfig
+++ b/drivers/infiniband/sw/rxe/Kconfig
@@ -2,7 +2,7 @@
 config RDMA_RXE
 	tristate "Software RDMA over Ethernet (RoCE) driver"
 	depends on INET && PCI && INFINIBAND
-	depends on !64BIT || ARCH_DMA_ADDR_T_64BIT
+	depends on INFINIBAND_VIRT_DMA
 	select NET_UDP_TUNNEL
 	select CRYPTO_CRC32
 	select DMA_VIRT_OPS
diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
index b622fc62f2cd6d..3450ba5081df51 100644
--- a/drivers/infiniband/sw/siw/Kconfig
+++ b/drivers/infiniband/sw/siw/Kconfig
@@ -1,6 +1,7 @@
 config RDMA_SIW
 	tristate "Software RDMA over TCP/IP (iWARP) driver"
 	depends on INET && INFINIBAND && LIBCRC32C
+	depends on INFINIBAND_VIRT_DMA
 	select DMA_VIRT_OPS
 	help
 	This driver implements the iWARP RDMA transport over
-- 
2.28.0

