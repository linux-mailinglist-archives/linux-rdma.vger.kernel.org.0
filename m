Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6692A9BC8
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 19:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgKFSUJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 13:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbgKFSUI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 13:20:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B36C0613D2;
        Fri,  6 Nov 2020 10:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1dFKN2o+8kGazOe0y0HWPZu2S++bPIj+AcbHCPxryog=; b=UvbZ4McOLpOwJWOz+h2K0DGiKW
        8IqA/63MkyeH9sXCs+WR4yyskuEGXQPn/ntXaYgsUmxz8pzMw3Cpcny/esZina2l6btoDBVnE5yFP
        Tokid9KGZQh+ci67f4/jGk64yF/6TibtKwEAaalyjFjV3UdsL/8oaPzXDCjc0gbxv6n8iw5WP2DqF
        fLUNqYuvoiqElCT4+FDDzM38BuhTS7ETMJN9/+dPTp+tD0YWeup4lrqg5FvcKhraHhzTakK7Vu6hO
        yf72Kb2EPORXIss8whgM9u2ONWuB+A78s5+C9uRj+YY1ZHxR1jqJjFZ1FsNwKOAJMDAAdC861M4Rw
        wL6+NGgg==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb6Kv-0005dA-PY; Fri, 06 Nov 2020 18:19:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH 01/10] RMDA/sw: don't allow drivers using dma_virt_ops on highmem configs
Date:   Fri,  6 Nov 2020 19:19:32 +0100
Message-Id: <20201106181941.1878556-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106181941.1878556-1-hch@lst.de>
References: <20201106181941.1878556-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

dma_virt_ops requires that all pages have a kernel virtual address.
Introduce a INFINIBAND_VIRT_DMA Kconfig symbol that depends on !HIGHMEM
and make all three driver depend on the new symbol.

Also remove the ARCH_DMA_ADDR_T_64BIT dependency, which has been
obsolete since commit 4965a68780c5 ("arch: define the
ARCH_DMA_ADDR_T_64BIT config symbol in lib/Kconfig")

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/Kconfig           | 3 +++
 drivers/infiniband/sw/rdmavt/Kconfig | 3 ++-
 drivers/infiniband/sw/rxe/Kconfig    | 2 +-
 drivers/infiniband/sw/siw/Kconfig    | 1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 32a51432ec4f73..9325e189a21536 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -73,6 +73,9 @@ config INFINIBAND_ADDR_TRANS_CONFIGFS
 	  This allows the user to config the default GID type that the CM
 	  uses for each device, when initiaing new connections.
 
+config INFINIBAND_VIRT_DMA
+	def_bool !HIGHMEM
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

