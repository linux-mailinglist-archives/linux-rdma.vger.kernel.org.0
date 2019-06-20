Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9974D363
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbfFTQPG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:15:06 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59342 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfFTQMv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:12:51 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg6-00046H-68; Thu, 20 Jun 2019 10:12:49 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg3-0005vu-Oq; Thu, 20 Jun 2019 10:12:43 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 20 Jun 2019 10:12:12 -0600
Message-Id: <20190620161240.22738-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, axboe@kernel.dk, hch@lst.de, bhelgaas@google.com, dan.j.williams@intel.com, sagi@grimberg.me, kbusch@kernel.org, jgg@ziepe.ca, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [RFC PATCH 00/28] Removing struct page from P2PDMA
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For eons there has been a debate over whether or not to use
struct pages for peer-to-peer DMA transactions. Pro-pagers have
argued that struct pages are necessary for interacting with
existing code like scatterlists or the bio_vecs. Anti-pagers
assert that the tracking of the memory is unecessary and
allocating the pages is a waste of memory. Both viewpoints are
valid, however developers working on GPUs and RDMA tend to be
able to do away with struct pages relatively easily compared to
those wanting to work with NVMe devices through the block layer.
So it would be of great value to be able to universally do P2PDMA
transactions without the use of struct pages.

Previously, there have been multiple attempts[1][2] to replace
struct page usage with pfn_t but this has been unpopular seeing
it creates dangerous edge cases where unsuspecting code might
run accross pfn_t's they are not ready for.

Currently, we have P2PDMA using struct pages through the block layer
and the dangerous cases are avoided by using a queue flag that
indicates support for the special pages.

This RFC proposes a new solution: allow the block layer to take
DMA addresses directly for queues that indicate support. This will
provide a more general path for doing P2PDMA-like requests and will
allow us to remove the struct pages that back P2PDMA memory thus paving
the way to build a more uniform P2PDMA ecosystem.

This is a fairly long patch set but most of the patches are quite
small. Patches 1 through 18 introduce the concept of a dma_vec that
is similar to a bio_vec (except it takes dma_addr_t's instead of pages
and offsets) as well as a special dma-direct bio/request. Most of these
patches just prevent the new type of bio from being mis-used and
also support splitting and mapping them in the same way that struct
page bios can be operated on. Patches 19 through 22 modify the existing
P2PDMA support in nvme-pci, ib-core and nvmet to use DMA addresses
directly. Patches 23 through 25 remove the P2PDMA specific
code from the block layer and ib-core. Finally, patches 26 through 28
remove the struct pages from the PCI P2PDMA code.

This RFC is based on v5.2-rc5 and a git branch is available here:

https://github.com/sbates130272/linux-p2pmem.git dma_direct_rfc1

[1] https://lwn.net/Articles/647404/
[2] https://lore.kernel.org/lkml/1495662147-18277-1-git-send-email-logang@deltatee.com/

--

Logan Gunthorpe (28):
  block: Introduce DMA direct request type
  block: Add dma_vec structure
  block: Warn on mis-use of dma-direct bios
  block: Never bounce dma-direct bios
  block: Skip dma-direct bios in bio_integrity_prep()
  block: Support dma-direct bios in bio_advance_iter()
  block: Use dma_vec length in bio_cur_bytes() for dma-direct bios
  block: Introduce dmavec_phys_mergeable()
  block: Introduce vec_gap_to_prev()
  block: Create generic vec_split_segs() from bvec_split_segs()
  block: Create blk_segment_split_ctx
  block: Create helper for bvec_should_split()
  block: Generalize bvec_should_split()
  block: Support splitting dma-direct bios
  block: Support counting dma-direct bio segments
  block: Implement mapping dma-direct requests to SGs in blk_rq_map_sg()
  block: Introduce queue flag to indicate support for dma-direct bios
  block: Introduce bio_add_dma_addr()
  nvme-pci: Support dma-direct bios
  IB/core: Introduce API for initializing a RW ctx from a DMA address
  nvmet: Split nvmet_bdev_execute_rw() into a helper function
  nvmet: Use DMA addresses instead of struct pages for P2P
  nvme-pci: Remove support for PCI_P2PDMA requests
  block: Remove PCI_P2PDMA queue flag
  IB/core: Remove P2PDMA mapping support in rdma_rw_ctx
  PCI/P2PDMA: Remove SGL helpers
  PCI/P2PDMA: Remove struct pages that back P2PDMA memory
  memremap: Remove PCI P2PDMA page memory type

 Documentation/driver-api/pci/p2pdma.rst |   9 +-
 block/bio-integrity.c                   |   4 +
 block/bio.c                             |  71 +++++++
 block/blk-core.c                        |   3 +
 block/blk-merge.c                       | 256 ++++++++++++++++++------
 block/blk.h                             |  49 ++++-
 block/bounce.c                          |   8 +
 drivers/infiniband/core/rw.c            |  85 ++++++--
 drivers/nvme/host/core.c                |   4 +-
 drivers/nvme/host/nvme.h                |   2 +-
 drivers/nvme/host/pci.c                 |  29 ++-
 drivers/nvme/target/core.c              |  12 +-
 drivers/nvme/target/io-cmd-bdev.c       |  82 +++++---
 drivers/nvme/target/nvmet.h             |   5 +-
 drivers/nvme/target/rdma.c              |  43 +++-
 drivers/pci/p2pdma.c                    | 202 +++----------------
 include/linux/bio.h                     |  32 ++-
 include/linux/blk_types.h               |  14 +-
 include/linux/blkdev.h                  |  16 +-
 include/linux/bvec.h                    |  43 ++++
 include/linux/memremap.h                |   5 -
 include/linux/mm.h                      |  13 --
 include/linux/pci-p2pdma.h              |  19 --
 include/rdma/rw.h                       |   6 +
 24 files changed, 648 insertions(+), 364 deletions(-)

--
2.20.1
