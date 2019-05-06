Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F3714B46
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 15:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfEFNyC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 09:54:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:48135 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfEFNyB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 09:54:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 06:54:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="344291802"
Received: from ssaleem-mobl4.amr.corp.intel.com ([10.255.35.243])
  by fmsmga006.fm.intel.com with ESMTP; 06 May 2019 06:54:00 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>
Subject: [PATCH v3 rdma-next 0/6] Introduce a DMA block iterator
Date:   Mon,  6 May 2019 08:53:31 -0500
Message-Id: <20190506135337.11324-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.8.3
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: "Saleem, Shiraz" <shiraz.saleem@intel.com>

This patch set is aiming to allow drivers to leverage a new DMA
block iterator to get contiguous aligned memory blocks within
their HW supported page sizes. The motivation for this work comes
from the discussion in [1].

The first patch introduces a new umem API that allows drivers to find a
best supported page size to use for the MR, from a bitmap of HW supported
page sizes.

The second patch introduces a new DMA block iterator that returns allows
drivers to get aligned DMA addresses within a supplied best page size.

The third patch and fouth patch removes the dependency of i40iw and bnxt_re
drivers on the hugetlb flag. The new core APIs are called in these drivers to
get huge page size aligned addresses if the MR is backed by huge pages.

The fifth patch removes the hugetlb flag from IB core.

The sixth patch extends the DMA block itertaor for HW that can support mixed
block sizes. This patch is untested.

[1] https://patchwork.kernel.org/patch/10499753/

RFC-->v0:
---------
* Add to scatter table by iterating a limited sized page list.
* Updated driver call sites to use the for_each_sg_page iterator
  variant where applicable.
* Tweaked algorithm in ib_umem_find_single_pg_size and ib_umem_next_phys_iter
  to ignore alignment of the start of first SGE and end of the last SGE.
* Simplified ib_umem_find_single_pg_size on offset alignments checks for
  user-space virtual and physical buffer.
* Updated ib_umem_start_phys_iter to do some pre-computation
  for the non-mixed page support case.
* Updated bnxt_re driver to use the new core APIs and remove its
  dependency on the huge tlb flag.
* Fixed a bug in computation of sg_phys_iter->phyaddr in ib_umem_next_phys_iter.
* Drop hugetlb flag usage from RDMA subsystem.
* Rebased on top of for-next.

v0-->v1:
--------
* Remove the patches that update driver to use for_each_sg_page variant
  to iterate in the SGE. This is sent as a seperate series using
  the for_each_sg_dma_page variant.
* Tweak ib_umem_add_sg_table API defintion based on maintainer feedback.
* Cache number of scatterlist entries in umem.
* Update function headers for ib_umem_find_single_pg_size and ib_umem_next_phys_iter.
* Add sanity check on supported_pgsz in ib_umem_find_single_pg_size.

v1-->v2:
--------
*Removed page combining patch as it was sent stand alone.
*__fls on pgsz_bitmap as opposed to fls64 since it's an unsigned long.
*rename ib_umem_find_pg_bit() --> rdma_find_pg_bit() and moved to ib_verbs.h
*rename ib_umem_find_single_pg_size() --> ib_umem_find_best_pgsz()
*New flag IB_UMEM_VA_BASED_OFFSET for ib_umem_find_best_pgsz API for HW that uses least significant bits
  of VA to indicate start offset into DMA list.
*rdma_find_pg_bit() logic is re-written and simplified. It can support input of 0 or 1 dma addr cases.
*ib_umem_find_best_pgsz() optimized to be less computationally expensive running rdma_find_pg_bit() only once.
*rdma_for_each_block() is the new re-designed DMA block iterator which is more in line with for_each_sg_dma_page()iterator.
*rdma_find_mixed_pg_bit() logic for interior SGE's accounting for start and end dma address. 
*remove i40iw specific enums for supported page size
*remove vma_list form ib_umem_get()

v2-->v3:
---------
*Check VA/PA bits misalignment to restrict max page size for all SGL address in ib_umem_find_best_pgsz()
*ib_umem_find_best_pgsz() extended to work with any IOVA
*IB_UMEM_VA_BASED_OFFSET flag removed.
*DMA block iterator API split into 2 patches. One for HW that supports single blocks and
second which extends the API to support HW that can do mixed block sizes.

Shiraz Saleem (6):
  RDMA/umem: Add API to find best driver supported page size in an MR
  RDMA/verbs: Add a DMA iterator to return aligned contiguous memory
    blocks
  RDMA/i40iw: Use core helpers to get aligned DMA address within a
    supported page size
  RDMA/bnxt_re: Use core helpers to get aligned DMA address
  RDMA/umem: Remove hugetlb flag
  RDMA/verbs: Extend DMA block iterator support for mixed block sizes

 drivers/infiniband/core/umem.c            | 77 +++++++++++++++++++----------
 drivers/infiniband/core/umem_odp.c        |  3 --
 drivers/infiniband/core/verbs.c           | 68 ++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 27 ++++-------
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 46 +++---------------
 drivers/infiniband/hw/i40iw/i40iw_verbs.h |  3 +-
 include/rdma/ib_umem.h                    | 10 +++-
 include/rdma/ib_verbs.h                   | 81 +++++++++++++++++++++++++++++++
 8 files changed, 228 insertions(+), 87 deletions(-)

-- 
1.8.3.1

