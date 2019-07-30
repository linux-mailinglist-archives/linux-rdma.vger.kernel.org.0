Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7CA67ADE3
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 18:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfG3QgC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 12:36:02 -0400
Received: from ale.deltatee.com ([207.54.116.67]:34082 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfG3QgC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 12:36:02 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hsV6V-0003y8-5k; Tue, 30 Jul 2019 10:36:00 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hsV6R-0001ID-0L; Tue, 30 Jul 2019 10:35:55 -0600
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
Date:   Tue, 30 Jul 2019 10:35:31 -0600
Message-Id: <20190730163545.4915-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, bhelgaas@google.com, hch@lst.de, Christian.Koenig@amd.com, jgg@mellanox.com, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, dan.j.williams@intel.com, epilmore@gigaio.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 00/14]  PCI/P2PDMA: Support transactions that hit the host bridge
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here's v2 of the patchset. It doesn't sound like there's anything
terribly controversial here so this version is mostly just some
cleanup changes for clarity.

Changes in v2:
 * Rebase on v5.3-rc2 (No changes)
 * Re-introduce the private pagemap structure and move the p2p-specific
   elements out of the commond dev_pagemap (per Christoph)
 * Use flags instead of bool in the whitelist (per Jason)
 * Only store the mapping type in the xarray (instead of the distance
   with flags) such that a function can return the mapping method
   with a switch statement to decide how to map. (per Christoph)
 * Drop find_parent_pci_dev() on the fast path and rely on the fact
   that the struct device passed to the mapping functions *must* be
   a PCI device and convert it directly. (per suggestions from
   Christoph and Jason)
 * Collected Christian's Reviewed-by's

--

As discussed on the list previously, in order to fully support the
whitelist Christian added with the IOMMU, we must ensure that we
map any buffer going through the IOMMU with an aprropriate dma_map
call. This patchset accomplishes this by cleaning up the output of
upstream_bridge_distance() to better indicate the mapping requirements,
caching these requirements in an xarray, then looking them up at map
time and applying the appropriate mapping method.

After this patchset, it's possible to use the NVMe-of P2P support to
transfer between devices without a switch on the whitelisted root
complexes. A couple Intel device I have tested this on have also
been added to the white list.

Most of the changes are contained within the p2pdma.c, but there are
a few minor touches to other subsystems, mostly to add support
to call an unmap function.

The final patch in this series demonstrates a possible
pci_p2pdma_map_resource() function that I expect Christian will need
but does not have any users at this time so I don't intend for it to be
considered for merging.

This patchset is based on 5.3-rc2 and a git branch is available here:

https://github.com/sbates130272/linux-p2pmem/ p2pdma_rc_map_v2

--

Logan Gunthorpe (14):
  PCI/P2PDMA: Introduce private pagemap structure
  PCI/P2PDMA: Add the provider's pci_dev to the pci_p2pdma_pagemap
    struct
  PCI/P2PDMA: Add constants for not-supported result
    upstream_bridge_distance()
  PCI/P2PDMA: Factor out __upstream_bridge_distance()
  PCI/P2PDMA: Apply host bridge white list for ACS
  PCI/P2PDMA: Factor out host_bridge_whitelist()
  PCI/P2PDMA: Add whitelist support for Intel Host Bridges
  PCI/P2PDMA: Add attrs argument to pci_p2pdma_map_sg()
  PCI/P2PDMA: Introduce pci_p2pdma_unmap_sg()
  PCI/P2PDMA: Factor out __pci_p2pdma_map_sg()
  PCI/P2PDMA: Store mapping method in an xarray
  PCI/P2PDMA: dma_map P2PDMA map requests that traverse the host bridge
  PCI/P2PDMA: No longer require no-mmu for host bridge whitelist
  PCI/P2PDMA: Update documentation for pci_p2pdma_distance_many()

 drivers/infiniband/core/rw.c |   6 +-
 drivers/nvme/host/pci.c      |  10 +-
 drivers/pci/p2pdma.c         | 361 +++++++++++++++++++++++++----------
 include/linux/memremap.h     |   1 -
 include/linux/pci-p2pdma.h   |  28 ++-
 5 files changed, 296 insertions(+), 110 deletions(-)

--
2.20.1
