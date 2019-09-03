Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41146A6785
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2019 13:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfICLhw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 3 Sep 2019 07:37:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728587AbfICLhw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Sep 2019 07:37:52 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x83Bbnk8042923
        for <linux-rdma@vger.kernel.org>; Tue, 3 Sep 2019 07:37:50 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.114])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usmc6pgsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 03 Sep 2019 07:37:48 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 3 Sep 2019 11:37:20 -0000
Received: from us1b3-smtp06.a3dr.sjc01.isc4sb.com (10.122.203.184)
        by smtp.notes.na.collabserv.com (10.122.47.58) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 3 Sep 2019 11:37:13 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp06.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019090311371292-342264 ;
          Tue, 3 Sep 2019 11:37:12 +0000 
In-Reply-To: <20190902162314.17508-1-michal.kalderon@marvell.com>
Subject: Re: [PATCH v9 rdma-next 0/7] RDMA/qedr: Use the doorbell overflow recovery
 mechanism for RDMA
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Michal Kalderon" <michal.kalderon@marvell.com>
Cc:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <galpress@amazon.com>, <sleybo@amazon.com>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>
Date:   Tue, 3 Sep 2019 11:37:13 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190902162314.17508-1-michal.kalderon@marvell.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-KeepSent: 54E87903:EA13ABB5-0025846A:003EBEF2;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 54671
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19090311-1639-0000-0000-0000004F13F2
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.415104; ST=0; TS=0; UL=0; ISC=; MB=0.315424
X-IBM-SpamModules-Versions: BY=3.00011709; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01256085; UDB=6.00663640; IPR=6.01037752;
 MB=3.00028449; MTD=3.00000008; XFM=3.00000015; UTC=2019-09-03 11:37:19
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-09-03 05:39:54 - 6.00010363
x-cbparentid: 19090311-1640-0000-0000-0000007E14D6
Message-Id: <OF54E87903.EA13ABB5-ON0025846A.003EBEF2-0025846A.003FD51F@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Michal Kalderon" <michal.kalderon@marvell.com> wrote: -----

>To: <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
><dledford@redhat.com>, <bmt@zurich.ibm.com>, <galpress@amazon.com>,
><sleybo@amazon.com>, <leon@kernel.org>
>From: "Michal Kalderon" <michal.kalderon@marvell.com>
>Date: 09/02/2019 06:25PM
>Cc: <linux-rdma@vger.kernel.org>, "Michal Kalderon"
><michal.kalderon@marvell.com>
>Subject: [EXTERNAL] [PATCH v9 rdma-next 0/7] RDMA/qedr: Use the
>doorbell overflow recovery mechanism for RDMA
>
>This patch series uses the doorbell overflow recovery mechanism
>introduced in
>commit 36907cd5cd72 ("qed: Add doorbell overflow recovery mechanism")
>for rdma ( RoCE and iWARP )
>


Hi Michal,

I wanted to try out things -- can you please help me:
Where would that patch apply to? I tried rdma-next
master and for-next. I am getting conflicts in
drivers/infiniband/core/ib_core_uverbs.c. Is there
any previous patch needed for this series?

Thanks very much and best regards,
Bernard.


>The first five patches modify the core code to contain helper
>functions for managing mmap_xa inserting, getting and freeing
>entries. The code was based on the code from efa driver.
>There is still an open discussion on whether we should take
>this even further and make the entire mmap generic. Until a
>decision is made, I only created the database API and modified
>the efa, qedr, siw driver to use it. The functions are integrated
>with the umap mechanism.
>
>The doorbell recovery code is based on the common code.
>
>Efa driver was compile tested and checked only modprobe/rmmod.
>SIW was compile tested and checked only modprobe/rmmod.
>
>rdma-core pull request #493
>
>Changes from V8:
>- CORE changes
>  - Fix race between getting an entry and deleting it. Increase
>    the refcount under the lock only if it is not zero.  Erase all
>entries
>    with __xa_erase instead of xa_erase and take the lock outside the
>loop.
>  - Fix comment when erasing all the xa_entries of a single
>mmap_entry.
>  - Take comment out of loop
>  - Change length field in driver structures to be size_t instead of
>u64
>    suggested by Bernard Metzler
>  - Change do..while(true) to while(true)
>- COMMON driver changes
>  - Change mmap length to be size_t instead of u64.
>  - In mmap, call put_entry if there is a length error.
>- EFA changes:
>  - Reverse mmap entries remove order.
>  - Give meaningful label names in create_qp error flows.
>  - In error flow undo change that frees pages based only on key and
>    make sure rq_size > 0 first.
>  - Fix xmas tree alignment, move ucontext initialization to
>declaration
>    line.
>- SIW changes:
>  - Changes received from Bernard Metzler
>	- make the siw_user_mmap_entry.address a void *, which
>	  naturally fits with remap_vmalloc_range. also avoids
>	  other casting during resource address assignment.
>	- do not kfree SQ/RQ/CQ/SRQ in preparation of mmap.
>	  Those resources are always further needed ;)
>	- Fix check for correct mmap range in siw_mmap().
>	  - entry->length is the object length. We have to
>	    expand to PAGE_ALIGN(entry->length), since mmap
>	    comes with complete page(s) containing the
>	    object.
>	  - put mmap_entry if that check fails. Otherwise
>	    entry object ref counting screws up, and later
>	    crashes during context close.
>	- simplify siw_mmap_free() - it must just free
>	  the entry.
>  - Change length to size_t instead of u64
>
>Changes from V7:
>- Remove license text, SPDX id should suffice.
>- Fix some comments text.
>- Add comment regarding vm_ops being set in ib_uverbs_mmap.
>- Allocate the rdma_user_mmap_entry in the driver and not in the
>  ib_core_uverbs. This lead to defining three new structures per
>driver
>  and seperating the fields between the driver private structures and
>  the common rdma_user_mmap_entry. Freeing the entry was also moved
>  to the drivers.
>- Fix bug found by Gal Pressman. Call mmap_free only once per entry.
>- Add a mutex around xa_mmap insert to assure threads won't intefere
>  while the xa lock is released when inserting an entry into the
>range.
>- Modify the insert algorithm to be more elegant using the
>  xas_next_entry instead of foreach.
>- Remove the rdma_user_mmap_entries_remove_free function, now that
>umap.
>  and mmap_xa are integrated we should not have any entries in the
>mmap_xa
>  when ucontext is released. Replace the function with a
>WARN_ON(!xa_empty).
>- Rdma_umap_open needs to reset the vm_private_data before
>initializing it.
>- Decrease rdma_user_mmap_entry reference count on mmap disassociate.
>- Remove WARN_ON(!kref_read) this is checked when kref debug is on.
>- Remove some redundant defines from ib_verbs.h.
>- Better error handling for efa create qp flow.
>- Add a function that wraps the entry allocation and
>rdma_user_mmap_entry_insert
>  which is used in all places that need to add an entry to the
>xarray.
>- Remove rq_entry_inserted field in efa create qp flow.
>- Add mmap_free to siw and free the memory only on mmap free and not
>before.
>
>Changes from V6:
>- Modified series description to be closer to what the series is now.
>- Create a new file for the new rdma_user_mmap function. The file
>  is called ib_uverbs_core. This file should contain functions
>related
>  to user which are called by hw to eventually enable ib_uverbs to be
>  optional.
>- Modify SIW driver to use new mmap api.
>- When calculating number of pages, need to round it up to PAGE_SIZE.
>- Integrate the mmap_xa and umap mechanism so that the entries in
>  mmap_xa now have a reference count and can be removed. Previously
>  entries existed until context was destroyed. This modified the
>  algorithm for allocating a free page range.
>- Modify algorithm for inserting an entry into the mmap_xa.
>- Rdma_umap_priv is now also used for all mmaps done using the
>  mmap_xa helpers.
>- Move remove_free header to core_priv.
>- Rdma_user_mmap_entry now has a kref that is increase on mmap
>  and umap_open and decreased on umap_close.
>- Modify efa + qedr to remove the entry from xa_map. This will
>  decrease the refcnt and free memory only if refcnt is zero.
>- Rdma_user_mmap_io slightly modified to enable drivers not using
>  the xa_mmap API to continue using it.
>- Modify page allocation for user to use GFP_USER instead of
>GFP_KERNEL
>
>Changes from V5:
>- Switch between driver dealloc_ucontext and mmap_entries_remove
>call.
>- No need to verify the key after using the key to load an entry from
>  the mmap_xa.
>- Change mmap_free api to pass an 'entry' object.
>- Add documentation for mmap_free and for newly exported functions.
>- Fix some extra/missing line breaks.
>
>Changes from V4:
>- Add common mmap database and cookie helper functions.
>
>Changes from V3:
>- Remove casts from void to u8. Pointer arithmetic can be done on
>void
>- rebase to tip of rdma-next
>
>Changes from V2:
>- Don't use long-lived kmap. Instead use user-trigger mmap for the
>  doorbell recovery entries.
>- Modify dpi_addr to be denoted with __iomem and avoid redundant
>  casts
>
>Changes from V1:
>- call kmap to map virtual address into kernel space
>- modify db_rec_delete to be void
>- remove some cpu_to_le16 that were added to previous patch which are
>  correct but not related to the overflow recovery mechanism. Will be
>  submitted as part of a different patch
>
>
>Michal Kalderon (7):
>  RDMA/core: Move core content from ib_uverbs to ib_core
>  RDMA/core: Create mmap database and cookie helper functions
>  RDMA/efa: Use the common mmap_xa helpers
>  RDMA/siw: Use the common mmap_xa helpers
>  RDMA/qedr: Use the common mmap API
>  RDMA/qedr: Add doorbell overflow recovery support
>  RDMA/qedr: Add iWARP doorbell recovery support
>
> drivers/infiniband/core/Makefile         |   2 +-
> drivers/infiniband/core/core_priv.h      |  16 +
> drivers/infiniband/core/device.c         |   1 +
> drivers/infiniband/core/ib_core_uverbs.c | 353 ++++++++++++++++++++
> drivers/infiniband/core/rdma_core.c      |   1 +
> drivers/infiniband/core/uverbs_cmd.c     |   1 +
> drivers/infiniband/core/uverbs_main.c    |  97 +-----
> drivers/infiniband/hw/efa/efa.h          |  18 +-
> drivers/infiniband/hw/efa/efa_main.c     |   1 +
> drivers/infiniband/hw/efa/efa_verbs.c    | 360 ++++++++++----------
> drivers/infiniband/hw/qedr/main.c        |   1 +
> drivers/infiniband/hw/qedr/qedr.h        |  45 ++-
> drivers/infiniband/hw/qedr/verbs.c       | 544
>++++++++++++++++++++++---------
> drivers/infiniband/hw/qedr/verbs.h       |   3 +-
> drivers/infiniband/sw/siw/siw.h          |  20 +-
> drivers/infiniband/sw/siw/siw_main.c     |   1 +
> drivers/infiniband/sw/siw/siw_verbs.c    | 216 ++++++------
> drivers/infiniband/sw/siw/siw_verbs.h    |   1 +
> include/rdma/ib_verbs.h                  |  37 ++-
> include/uapi/rdma/qedr-abi.h             |  25 ++
> 20 files changed, 1196 insertions(+), 547 deletions(-)
> create mode 100644 drivers/infiniband/core/ib_core_uverbs.c
>
>-- 
>2.14.5
>
>

