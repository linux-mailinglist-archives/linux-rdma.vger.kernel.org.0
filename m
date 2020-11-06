Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3682A9BC7
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 19:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgKFSUG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 13:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgKFSUG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 13:20:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5E7C0613CF;
        Fri,  6 Nov 2020 10:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VaZQL4432wwI41txwmAvcg9ln4IR3PCVL4Re3U71+J4=; b=oiIbG6MbnwXt4SgUikGk8KT98L
        J1OORciwVDKq9gmw4bD1H9mTO8kgveIGr1uMAgl58563N27BK71gwjNO328LXWvEvsPjBFjgRtnGe
        TKy7mkH5PG4AOHrR7RvtBLXGWAh3QrxUmMtK0qt7spGStyPW7e9ilc0k4LAQrgyj5LIkK1uZTf/ws
        bn8hsIBxBSKvvR8AJurjqoyvAZvZ/01DHO789M19Ml/thAKRcOnbwSUc9qgEwR8sdfoz2/c0haOJf
        Doe6Utc1Efl6lYAkQ+X8zTrq5mdZvsj7nxR1tsXAk4sAJOjx8g6An+6e1ZAk0DHYmmfFEziBfkCeF
        WaKTmIYA==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb6L0-0005do-1K; Fri, 06 Nov 2020 18:19:51 +0000
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
Subject: [PATCH 03/10] RDMA: lift ibdev_to_node from rds to common code
Date:   Fri,  6 Nov 2020 19:19:34 +0100
Message-Id: <20201106181941.1878556-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106181941.1878556-1-hch@lst.de>
References: <20201106181941.1878556-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Lift the ibdev_to_node from rds to common code and document it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/rdma/ib_verbs.h | 13 +++++++++++++
 net/rds/ib.h            |  7 -------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9bf6c319a670e2..3257cc046e460f 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4615,6 +4615,19 @@ static inline struct ib_device *rdma_device_to_ibdev(struct device *device)
 	return coredev->owner;
 }
 
+/**
+ * ibdev_to_node - return the NUMA node for a given ib_device
+ * @dev:	device to get the NUMA node for.
+ */
+static inline int ibdev_to_node(struct ib_device *ibdev)
+{
+	struct device *parent = ibdev->dev.parent;
+
+	if (!parent)
+		return NUMA_NO_NODE;
+	return dev_to_node(parent);
+}
+
 /**
  * rdma_device_to_drv_device - Helper macro to reach back to driver's
  *			       ib_device holder structure from device pointer.
diff --git a/net/rds/ib.h b/net/rds/ib.h
index 8dfff43cf07f46..c23a11d9ad3628 100644
--- a/net/rds/ib.h
+++ b/net/rds/ib.h
@@ -264,13 +264,6 @@ struct rds_ib_device {
 	int			*vector_load;
 };
 
-static inline int ibdev_to_node(struct ib_device *ibdev)
-{
-	struct device *parent;
-
-	parent = ibdev->dev.parent;
-	return parent ? dev_to_node(parent) : NUMA_NO_NODE;
-}
 #define rdsibdev_to_node(rdsibdev) ibdev_to_node(rdsibdev->dev)
 
 /* bits for i_ack_flags */
-- 
2.28.0

