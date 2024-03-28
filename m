Return-Path: <linux-rdma+bounces-1244-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68A4871B6B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 11:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B021C2205A
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 10:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA9854BFA;
	Tue,  5 Mar 2024 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8SuLY3w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847A842072;
	Tue,  5 Mar 2024 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634147; cv=none; b=q1ExbxPBisL56Jh/uHN8EJ7ciOoq59iRauHSB+NFs65RA3b7+40X+pa1ayeBcONMdtzfuvy5WeeTU6DpWKj+dnycH9x1A6w/pQGjNioZ5k8RWo9Wn/8AMcshl+q6rfHnkx68Ptu8JsRchaEXbXOpG7lZP9lhkTGtQfWSnDYHHGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634147; c=relaxed/simple;
	bh=NxhQVbYsKSwyvGgGk5qfaF5a/Y1wAzitab7stbdLKEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSUuKT/C51yFUQgIAZXsA1Y+cToUJ3XJyA72Oi2XcrMgXVFCWqsdbl3CuUTTdGBts4jB+W7bK0ttDEY/vj8k8hWusMyX8uuYOaSyGfvXHsoPgJS3PvAUSft9Lw+qbzTLfvshvGISFWnrsiKgRWoIf74F7VLQ6iKeRz6MFiTHUoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8SuLY3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284A2C433C7;
	Tue,  5 Mar 2024 10:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709634147;
	bh=NxhQVbYsKSwyvGgGk5qfaF5a/Y1wAzitab7stbdLKEk=;
	h=From:To:Cc:Subject:Date:From;
	b=O8SuLY3wQ6PtRLTCK2VZMHetfJR3PZ4NQmh9jO7R/WsBCTxD1EagJAdaWfXzoro6V
	 yFHEcnfZwoPl1eckggYlRzdmmeka8uTeDA6FZn19J2mGURJ8GM/eP0KEXVv1nN8zJE
	 uVzGgKetd9stSkRmOnWV7rr9SZbmTUNW0WQAFlFQZfLCgEcjyAEWVHYZCOE8BiSfsL
	 SAUbEHuCHeqzC3/mk2w4/mBn6VgdVyuxWexDPDdNx8cajRHssrroxh6ut8CHQZkoL2
	 kgTA0M0yJVpSw6oR2y9la0+QGeM6gatyFAzWa8n6E9DaDPGK1NH0vLaQ+4Fa5zrYER
	 o8kChQWuYHMHw==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [RFC 00/16] Split IOMMU DMA mapping operation to two steps
Date: Tue,  5 Mar 2024 12:22:01 +0200
Message-ID: <cover.1709631800.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is complimentary part to the proposed LSF/MM topic.
https://lore.kernel.org/linux-rdma/22df55f8-cf64-4aa8-8c0b-b556c867b926@linux.dev/T/#m85672c860539fdbbc8fe0f5ccabdc05b40269057

This is posted as RFC to get a feedback on proposed split, but RDMA, VFIO and
DMA patches are ready for review and inclusion, the NVMe patches are still in
progress as they require agreement on API first.

Thanks

-------------------------------------------------------------------------------
The DMA mapping operation performs two steps at one same time: allocates
IOVA space and actually maps DMA pages to that space. This one shot
operation works perfectly for non-complex scenarios, where callers use
that DMA API in control path when they setup hardware.

However in more complex scenarios, when DMA mapping is needed in data
path and especially when some sort of specific datatype is involved,
such one shot approach has its drawbacks.

That approach pushes developers to introduce new DMA APIs for specific
datatype. For example existing scatter-gather mapping functions, or
latest Chuck's RFC series to add biovec related DMA mapping [1] and
probably struct folio will need it too.

These advanced DMA mapping APIs are needed to calculate IOVA size to
allocate it as one chunk and some sort of offset calculations to know
which part of IOVA to map.

Instead of teaching DMA to know these specific datatypes, let's separate
existing DMA mapping routine to two steps and give an option to advanced
callers (subsystems) perform all calculations internally in advance and
map pages later when it is needed.

In this series, three users are converted and each of such conversion
presents different positive gain:
1. RDMA simplifies and speeds up its pagefault handling for
   on-demand-paging (ODP) mode.
2. VFIO PCI live migration code saves huge chunk of memory.
3. NVMe PCI avoids intermediate SG table manipulation and operates
   directly on BIOs.

Thanks

[1] https://lore.kernel.org/all/169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net

Chaitanya Kulkarni (2):
  block: add dma_link_range() based API
  nvme-pci: use blk_rq_dma_map() for NVMe SGL

Leon Romanovsky (14):
  mm/hmm: let users to tag specific PFNs
  dma-mapping: provide an interface to allocate IOVA
  dma-mapping: provide callbacks to link/unlink pages to specific IOVA
  iommu/dma: Provide an interface to allow preallocate IOVA
  iommu/dma: Prepare map/unmap page functions to receive IOVA
  iommu/dma: Implement link/unlink page callbacks
  RDMA/umem: Preallocate and cache IOVA for UMEM ODP
  RDMA/umem: Store ODP access mask information in PFN
  RDMA/core: Separate DMA mapping to caching IOVA and page linkage
  RDMA/umem: Prevent UMEM ODP creation with SWIOTLB
  vfio/mlx5: Explicitly use number of pages instead of allocated length
  vfio/mlx5: Rewrite create mkey flow to allow better code reuse
  vfio/mlx5: Explicitly store page list
  vfio/mlx5: Convert vfio to use DMA link API

 Documentation/core-api/dma-attributes.rst |   7 +
 block/blk-merge.c                         | 156 ++++++++++++++
 drivers/infiniband/core/umem_odp.c        | 219 +++++++------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h      |   1 +
 drivers/infiniband/hw/mlx5/odp.c          |  59 +++--
 drivers/iommu/dma-iommu.c                 | 129 ++++++++---
 drivers/nvme/host/pci.c                   | 220 +++++--------------
 drivers/vfio/pci/mlx5/cmd.c               | 252 ++++++++++++----------
 drivers/vfio/pci/mlx5/cmd.h               |  22 +-
 drivers/vfio/pci/mlx5/main.c              | 136 +++++-------
 include/linux/blk-mq.h                    |   9 +
 include/linux/dma-map-ops.h               |  13 ++
 include/linux/dma-mapping.h               |  39 ++++
 include/linux/hmm.h                       |   3 +
 include/rdma/ib_umem_odp.h                |  22 +-
 include/rdma/ib_verbs.h                   |  54 +++++
 kernel/dma/debug.h                        |   2 +
 kernel/dma/direct.h                       |   7 +-
 kernel/dma/mapping.c                      |  91 ++++++++
 mm/hmm.c                                  |  34 +--
 20 files changed, 870 insertions(+), 605 deletions(-)

-- 
2.44.0


