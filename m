Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5019E95D
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 15:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbfH0Nb2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 09:31:28 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:22406 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726134AbfH0Nb2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Aug 2019 09:31:28 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7RDUkhq006760;
        Tue, 27 Aug 2019 06:31:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=xboj8yf+xhNQGFsJ/pwPjgZqZHCHCf5+OaILXAqBC3A=;
 b=f6ULyWfs4U25ugqHItB6uvj0JC8xloBKK6Zg+18uG4gBQ8SN6uDWS2icVHevzyo3asIG
 YAaf6Tp1g96zoabGyp0B8tgQRuCxinyAgXB/ncEkMIoSP+eE4gicghynbbq7R/6YKcsM
 ozxXdnChMyPGdbN3cQEzgOFfV5Yip9LhouxSksbgx7h2HPNW6BCl1LNntJI2/MODmRKv
 jtpyU35DZYz6RPDrPqKzlmZFW465v11x5RNIwlgqIql02NpScN0+3u7jDgbI62AksHpk
 W+3EkUODlHlDXS4nHblp3lWHrewg8xWwCHpxDRLQqbdmiHRE8nV8sLaqB0vEtyzVmNTU Ag== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uk4rkjp3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 06:31:23 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 27 Aug
 2019 06:31:21 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 27 Aug 2019 06:31:21 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 610013F7041;
        Tue, 27 Aug 2019 06:31:18 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <galpress@amazon.com>,
        <sleybo@amazon.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>
Subject: [PATCH v8 rdma-next 0/7] RDMA/qedr: Use the doorbell overflow recovery mechanism for RDMA
Date:   Tue, 27 Aug 2019 16:28:39 +0300
Message-ID: <20190827132846.9142-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-27_02:2019-08-27,2019-08-27 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series uses the doorbell overflow recovery mechanism
introduced in
commit 36907cd5cd72 ("qed: Add doorbell overflow recovery mechanism")
for rdma ( RoCE and iWARP )

The first five patches modify the core code to contain helper
functions for managing mmap_xa inserting, getting and freeing
entries. The code was based on the code from efa driver.
There is still an open discussion on whether we should take
this even further and make the entire mmap generic. Until a
decision is made, I only created the database API and modified
the efa, qedr, siw driver to use it. The functions are integrated
with the umap mechanism.

The doorbell recovery code is based on the common code.

Efa driver was compile tested and checked only modprobe/rmmod.
SIW was compile tested and checked only modprobe/rmmod.

rdma-core pull request #493

Changes from V7:
- Remove license text, SPDX id should suffice.
- Fix some comments text.
- Add comment regarding vm_ops being set in ib_uverbs_mmap.
- Allocate the rdma_user_mmap_entry in the driver and not in the
  ib_core_uverbs. This lead to defining three new structures per driver
  and seperating the fields between the driver private structures and
  the common rdma_user_mmap_entry. Freeing the entry was also moved
  to the drivers.
- Fix bug found by Gal Pressman. Call mmap_free only once per entry.
- Add a mutex around xa_mmap insert to assure threads won't intefere
  while the xa lock is released when inserting an entry into the range.
- Modify the insert algorithm to be more elegant using the
  xas_next_entry instead of foreach.
- Remove the rdma_user_mmap_entries_remove_free function, now that umap.
  and mmap_xa are integrated we should not have any entries in the mmap_xa
  when ucontext is released. Replace the function with a WARN_ON(!xa_empty).
- Rdma_umap_open needs to reset the vm_private_data before initializing it.
- Decrease rdma_user_mmap_entry reference count on mmap disassociate.
- Remove WARN_ON(!kref_read) this is checked when kref debug is on.
- Remove some redundant defines from ib_verbs.h.
- Better error handling for efa create qp flow.
- Add a function that wraps the entry allocation and rdma_user_mmap_entry_insert
  which is used in all places that need to add an entry to the xarray.
- Remove rq_entry_inserted field in efa create qp flow.
- Add mmap_free to siw and free the memory only on mmap free and not before.

Changes from V6:
- Modified series description to be closer to what the series is now.
- Create a new file for the new rdma_user_mmap function. The file
  is called ib_uverbs_core. This file should contain functions related
  to user which are called by hw to eventually enable ib_uverbs to be
  optional.
- Modify SIW driver to use new mmap api.
- When calculating number of pages, need to round it up to PAGE_SIZE.
- Integrate the mmap_xa and umap mechanism so that the entries in
  mmap_xa now have a reference count and can be removed. Previously
  entries existed until context was destroyed. This modified the
  algorithm for allocating a free page range.
- Modify algorithm for inserting an entry into the mmap_xa.
- Rdma_umap_priv is now also used for all mmaps done using the
  mmap_xa helpers.
- Move remove_free header to core_priv.
- Rdma_user_mmap_entry now has a kref that is increase on mmap
  and umap_open and decreased on umap_close.
- Modify efa + qedr to remove the entry from xa_map. This will
  decrease the refcnt and free memory only if refcnt is zero.
- Rdma_user_mmap_io slightly modified to enable drivers not using
  the xa_mmap API to continue using it.
- Modify page allocation for user to use GFP_USER instead of GFP_KERNEL

Changes from V5:
- Switch between driver dealloc_ucontext and mmap_entries_remove call.
- No need to verify the key after using the key to load an entry from
  the mmap_xa.
- Change mmap_free api to pass an 'entry' object.
- Add documentation for mmap_free and for newly exported functions.
- Fix some extra/missing line breaks.

Changes from V4:
- Add common mmap database and cookie helper functions.

Changes from V3:
- Remove casts from void to u8. Pointer arithmetic can be done on void
- rebase to tip of rdma-next

Changes from V2:
- Don't use long-lived kmap. Instead use user-trigger mmap for the
  doorbell recovery entries.
- Modify dpi_addr to be denoted with __iomem and avoid redundant
  casts

Changes from V1:
- call kmap to map virtual address into kernel space
- modify db_rec_delete to be void
- remove some cpu_to_le16 that were added to previous patch which are
  correct but not related to the overflow recovery mechanism. Will be
  submitted as part of a different patch


Michal Kalderon (7):
  RDMA/core: Move core content from ib_uverbs to ib_core
  RDMA/core: Create mmap database and cookie helper functions
  RDMA/efa: Use the common mmap_xa helpers
  RDMA/siw: Use the common mmap_xa helpers
  RDMA/qedr: Use the common mmap API
  RDMA/qedr: Add doorbell overflow recovery support
  RDMA/qedr: Add iWARP doorbell recovery support

 drivers/infiniband/core/Makefile         |   2 +-
 drivers/infiniband/core/core_priv.h      |  16 +
 drivers/infiniband/core/device.c         |   1 +
 drivers/infiniband/core/ib_core_uverbs.c | 341 +++++++++++++++++++
 drivers/infiniband/core/rdma_core.c      |   1 +
 drivers/infiniband/core/uverbs_cmd.c     |   1 +
 drivers/infiniband/core/uverbs_main.c    |  97 ++----
 drivers/infiniband/hw/efa/efa.h          |  18 +-
 drivers/infiniband/hw/efa/efa_main.c     |   1 +
 drivers/infiniband/hw/efa/efa_verbs.c    | 339 ++++++++++---------
 drivers/infiniband/hw/qedr/main.c        |   1 +
 drivers/infiniband/hw/qedr/qedr.h        |  45 ++-
 drivers/infiniband/hw/qedr/verbs.c       | 539 ++++++++++++++++++++++---------
 drivers/infiniband/hw/qedr/verbs.h       |   3 +-
 drivers/infiniband/sw/siw/siw.h          |  20 +-
 drivers/infiniband/sw/siw/siw_main.c     |   1 +
 drivers/infiniband/sw/siw/siw_verbs.c    | 223 +++++++------
 drivers/infiniband/sw/siw/siw_verbs.h    |   1 +
 include/rdma/ib_verbs.h                  |  37 ++-
 include/uapi/rdma/qedr-abi.h             |  25 ++
 20 files changed, 1180 insertions(+), 532 deletions(-)
 create mode 100644 drivers/infiniband/core/ib_core_uverbs.c

-- 
2.14.5

