Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D893870D0D
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 01:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbfGVXJP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 19:09:15 -0400
Received: from ale.deltatee.com ([207.54.116.67]:40290 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733236AbfGVXJP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Jul 2019 19:09:15 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hphQb-0002k1-Dk; Mon, 22 Jul 2019 17:09:14 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hphQV-0001Qw-TY; Mon, 22 Jul 2019 17:09:03 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon, 22 Jul 2019 17:08:52 -0600
Message-Id: <20190722230859.5436-8-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722230859.5436-1-logang@deltatee.com>
References: <20190722230859.5436-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, bhelgaas@google.com, hch@lst.de, Christian.Koenig@amd.com, jgg@mellanox.com, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, dan.j.williams@intel.com, epilmore@gigaio.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 07/14] PCI/P2PDMA: Add the provider's pci_dev to the dev_pgmap struct
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The provider will be needed to figure out how to properly map a device.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c     | 1 +
 include/linux/memremap.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 143e11d2a5c3..70c262b7c731 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -168,6 +168,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	pgmap->res.end = pgmap->res.start + size - 1;
 	pgmap->res.flags = pci_resource_flags(pdev, bar);
 	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
+	pgmap->pci_p2pdma_provider = pdev;
 	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
 		pci_resource_start(pdev, bar);
 
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index f8a5b2a19945..91aee61796bc 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -112,6 +112,7 @@ struct dev_pagemap {
 	struct device *dev;
 	enum memory_type type;
 	unsigned int flags;
+	struct pci_dev *pci_p2pdma_provider;
 	u64 pci_p2pdma_bus_offset;
 	const struct dev_pagemap_ops *ops;
 };
-- 
2.20.1

