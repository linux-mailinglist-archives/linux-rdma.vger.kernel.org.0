Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8017E2A9BD6
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 19:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgKFSUO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 13:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbgKFSUN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 13:20:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565D8C0613D2;
        Fri,  6 Nov 2020 10:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jzVxkCOMV+ZsFNlpyWtMfsKBytOCJws52NU0gO5aQ1s=; b=ZmelvDHzr0KjuikniYN3XAXCgF
        ovUAts43+DdG8mAeWoRUy8h8s0JVd69a6uuBGI9TEwMR/a41KRF9N4pJzRYot33B5doqdWGRt1Cz1
        q//N9WAg+5IDj0q4OgWClx4LdMm7CzLOlCh4Cj7joNQJEukX5Tke4pXmZ94Ozomz0vxDWpW3/3L2N
        kphpO6sDq5OQbOl9NTXm0ilDk7FQgxCys3e0fMuzmfO5fmRpbKMjmEl3Kyqn30lJ7qWCP/usbt5T5
        lr0wpUjQ3eL9DnpbbszOP2wQCb5QABTMIhnk+JbHfag+9DJAGphkRN8ejfReKotaVFYn4r3kGnxiq
        wyKd7gNw==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb6L2-0005e4-Q8; Fri, 06 Nov 2020 18:19:53 +0000
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
Subject: [PATCH 04/10] nvme-rdma: use ibdev_to_node instead of dereferencing ->dma_device
Date:   Fri,  6 Nov 2020 19:19:35 +0100
Message-Id: <20201106181941.1878556-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106181941.1878556-1-hch@lst.de>
References: <20201106181941.1878556-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

->dma_device is a private implementation detail of the RDMA core.  Use
the ibdev_to_node helper to get the NUMA node for a ib_device instead
of poking into ->dma_device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 541b0cba6d8019..c08625e2f21a56 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -854,7 +854,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		return error;
 
 	ctrl->device = ctrl->queues[0].device;
-	ctrl->ctrl.numa_node = dev_to_node(ctrl->device->dev->dma_device);
+	ctrl->ctrl.numa_node = ibdev_to_node(ctrl->device->dev);
 
 	/* T10-PI support */
 	if (ctrl->device->dev->attrs.device_cap_flags &
-- 
2.28.0

