Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82234A5B46
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2019 18:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfIBQZO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Sep 2019 12:25:14 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:64056 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725988AbfIBQZO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Sep 2019 12:25:14 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82GP9tR022606;
        Mon, 2 Sep 2019 09:25:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=Mp5B/tWx+fNwtRZYfu7cJgqp3/8kwAKgJQQIDWY0k0M=;
 b=aNVY7ACuevSaQvsb3OLf+04bE3qp5JqTlUfdHQ8deA9pfmXdndn54BXGvX7WEoDXyzSC
 ab4Ax60iqTzr5cqTEv7hZB+cDtTnRgGn6Ro5JAyD0J9GGmtqRLhFyjD7VPILaI+Z+Iiy
 e7kkA2pkQnmTRM/w4XgJNcCy8J4gw6YytpyBzbPVjo5QRxUsn+/258efkmdIkzywKoRi
 UkNXbkH5NiycRpcy2GJ2rNvGNRztoPWu7POPXfBQjx/7wISIcaXHX4ZT1+qzqU/4Uo7/
 EALuik9Y4mbueWTM/D2FCqD3rhVmHFsI9ji1KO7tPidMdaXPHtT4n8WLd/+33d2MVEGR QA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2uqp8p761f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 09:25:09 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 2 Sep
 2019 09:25:04 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 2 Sep 2019 09:25:04 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 2D5953F7040;
        Mon,  2 Sep 2019 09:25:00 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <galpress@amazon.com>,
        <sleybo@amazon.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>
Subject: [PATCH v9 rdma-next 0/7] RDMA/qedr: Use the doorbell overflow recovery mechanism for RDMA
Date:   Mon, 2 Sep 2019 19:23:07 +0300
Message-ID: <20190902162314.17508-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_06:2019-08-29,2019-09-02 signatures=0
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

Changes from V8:
- CORE changes
  - Fix race between getting an entry and deleting it. Increase
    the refcount under the lock only if it is not zero.  Erase all entries
    with __xa_erase instead of xa_erase and take the lock outside the loop.
  - Fix comment when erasing all the xa_entries of a single mmap_entry.
  - Take comment out of loop
  - Change length field in driver structures to be size_t instead of u64
    suggested by Bernard Metzler
  - Change do..while(true) to while(true)
- COMMON driver changes
  - Change mmap length to be size_t instead of u64.
  - In mmap, call put_entry if there is a length error.
- EFA changes:
  - Reverse mmap entries remove order.
  - Give meaningful label names in create_qp error flows.
  - In error flow undo change that frees pages based only on key and
    make sure rq_size > 0 first.
  - Fix xmas tree alignment, move ucontext initialization to declaration
    line.
- SIW changes:
  - Changes received from Bernard Metzler
	- make the siw_user_mmap_entry.address a void *, which
	  naturally fits with remap_vmalloc_range. also avoids
	  other casting during resource address assignment.
	- do not kfree SQ/RQ/CQ/SRQ in preparation of mmap.
	  Those resources are always further needed ;)
	- Fix check for correct mmap range in siw_mmap().
	  - entry->length is the object length. We have to
	    expand to PAGE_ALIGN(entry->length), since mmap
	    comes with complete page(s) containing the
	    object.
	  - put mmap_entry if that check fails. Otherwise
	    entry object ref counting screws up, and later
	    crashes during context close.
	- simplify siw_mmap_free() - it must just free
	  the entry.
  - Change length to size_t instead of u64

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
 drivers/infiniband/core/ib_core_uverbs.c | 353 ++++++++++++++++++++
 drivers/infiniband/core/rdma_core.c      |   1 +
 drivers/infiniband/core/uverbs_cmd.c     |   1 +
 drivers/infiniband/core/uverbs_main.c    |  97 +-----
 drivers/infiniband/hw/efa/efa.h          |  18 +-
 drivers/infiniband/hw/efa/efa_main.c     |   1 +
 drivers/infiniband/hw/efa/efa_verbs.c    | 360 ++++++++++----------
 drivers/infiniband/hw/qedr/main.c        |   1 +
 drivers/infiniband/hw/qedr/qedr.h        |  45 ++-
 drivers/infiniband/hw/qedr/verbs.c       | 544 ++++++++++++++++++++++---------
 drivers/infiniband/hw/qedr/verbs.h       |   3 +-
 drivers/infiniband/sw/siw/siw.h          |  20 +-
 drivers/infiniband/sw/siw/siw_main.c     |   1 +
 drivers/infiniband/sw/siw/siw_verbs.c    | 216 ++++++------
 drivers/infiniband/sw/siw/siw_verbs.h    |   1 +
 include/rdma/ib_verbs.h                  |  37 ++-
 include/uapi/rdma/qedr-abi.h             |  25 ++
 20 files changed, 1196 insertions(+), 547 deletions(-)
 create mode 100644 drivers/infiniband/core/ib_core_uverbs.c

-- 
2.14.5

