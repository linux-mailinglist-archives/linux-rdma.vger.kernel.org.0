Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05BC7A0535
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 16:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfH1OlZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 10:41:25 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:35410 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfH1OlZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Aug 2019 10:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567003283; x=1598539283;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=NObsrQf54RG1W9NHyag5x1Bol7UtGSclsBljEG7OZhc=;
  b=Br9O7O9TRJssNXj1Q+C2j/U5ZXpxbKDW0OR1WwXSgEzdwjoBgUGnYOR/
   /dTdCHj4v7h+sBOqyWU68NDaj0/guoO8NqnKrmphppORljyfuZbcQgmXZ
   L3TmLV03Ca4H11dC9hLuoL3GwqpCqISpMzjmDrTk3yJ4FCW9joxCfwo1L
   U=;
X-IronPort-AV: E=Sophos;i="5.64,441,1559520000"; 
   d="scan'208";a="747780834"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 28 Aug 2019 14:41:22 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id 50B87A260F;
        Wed, 28 Aug 2019 14:41:19 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 28 Aug 2019 14:41:19 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.30) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 28 Aug 2019 14:41:14 +0000
Subject: Re: [PATCH v8 rdma-next 0/7] RDMA/qedr: Use the doorbell overflow
 recovery mechanism for RDMA
To:     Michal Kalderon <michal.kalderon@marvell.com>
CC:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <sleybo@amazon.com>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>
References: <20190827132846.9142-1-michal.kalderon@marvell.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <51ad6499-cb54-71d7-c22a-94265b166b52@amazon.com>
Date:   Wed, 28 Aug 2019 17:41:09 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827132846.9142-1-michal.kalderon@marvell.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.30]
X-ClientProxiedBy: EX13D17UWB003.ant.amazon.com (10.43.161.42) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 27/08/2019 16:28, Michal Kalderon wrote:
> This patch series uses the doorbell overflow recovery mechanism
> introduced in
> commit 36907cd5cd72 ("qed: Add doorbell overflow recovery mechanism")
> for rdma ( RoCE and iWARP )
> 
> The first five patches modify the core code to contain helper
> functions for managing mmap_xa inserting, getting and freeing
> entries. The code was based on the code from efa driver.
> There is still an open discussion on whether we should take
> this even further and make the entire mmap generic. Until a
> decision is made, I only created the database API and modified
> the efa, qedr, siw driver to use it. The functions are integrated
> with the umap mechanism.
> 
> The doorbell recovery code is based on the common code.
> 
> Efa driver was compile tested and checked only modprobe/rmmod.
> SIW was compile tested and checked only modprobe/rmmod.
> 
> rdma-core pull request #493
> 
> Changes from V7:
> - Remove license text, SPDX id should suffice.
> - Fix some comments text.
> - Add comment regarding vm_ops being set in ib_uverbs_mmap.
> - Allocate the rdma_user_mmap_entry in the driver and not in the
>   ib_core_uverbs. This lead to defining three new structures per driver
>   and seperating the fields between the driver private structures and
>   the common rdma_user_mmap_entry. Freeing the entry was also moved
>   to the drivers.
> - Fix bug found by Gal Pressman. Call mmap_free only once per entry.
> - Add a mutex around xa_mmap insert to assure threads won't intefere
>   while the xa lock is released when inserting an entry into the range.
> - Modify the insert algorithm to be more elegant using the
>   xas_next_entry instead of foreach.
> - Remove the rdma_user_mmap_entries_remove_free function, now that umap.
>   and mmap_xa are integrated we should not have any entries in the mmap_xa
>   when ucontext is released. Replace the function with a WARN_ON(!xa_empty).
> - Rdma_umap_open needs to reset the vm_private_data before initializing it.
> - Decrease rdma_user_mmap_entry reference count on mmap disassociate.
> - Remove WARN_ON(!kref_read) this is checked when kref debug is on.
> - Remove some redundant defines from ib_verbs.h.
> - Better error handling for efa create qp flow.
> - Add a function that wraps the entry allocation and rdma_user_mmap_entry_insert
>   which is used in all places that need to add an entry to the xarray.
> - Remove rq_entry_inserted field in efa create qp flow.
> - Add mmap_free to siw and free the memory only on mmap free and not before.
> 
> Changes from V6:
> - Modified series description to be closer to what the series is now.
> - Create a new file for the new rdma_user_mmap function. The file
>   is called ib_uverbs_core. This file should contain functions related
>   to user which are called by hw to eventually enable ib_uverbs to be
>   optional.
> - Modify SIW driver to use new mmap api.
> - When calculating number of pages, need to round it up to PAGE_SIZE.
> - Integrate the mmap_xa and umap mechanism so that the entries in
>   mmap_xa now have a reference count and can be removed. Previously
>   entries existed until context was destroyed. This modified the
>   algorithm for allocating a free page range.
> - Modify algorithm for inserting an entry into the mmap_xa.
> - Rdma_umap_priv is now also used for all mmaps done using the
>   mmap_xa helpers.
> - Move remove_free header to core_priv.
> - Rdma_user_mmap_entry now has a kref that is increase on mmap
>   and umap_open and decreased on umap_close.
> - Modify efa + qedr to remove the entry from xa_map. This will
>   decrease the refcnt and free memory only if refcnt is zero.
> - Rdma_user_mmap_io slightly modified to enable drivers not using
>   the xa_mmap API to continue using it.
> - Modify page allocation for user to use GFP_USER instead of GFP_KERNEL
> 
> Changes from V5:
> - Switch between driver dealloc_ucontext and mmap_entries_remove call.
> - No need to verify the key after using the key to load an entry from
>   the mmap_xa.
> - Change mmap_free api to pass an 'entry' object.
> - Add documentation for mmap_free and for newly exported functions.
> - Fix some extra/missing line breaks.
> 
> Changes from V4:
> - Add common mmap database and cookie helper functions.
> 
> Changes from V3:
> - Remove casts from void to u8. Pointer arithmetic can be done on void
> - rebase to tip of rdma-next
> 
> Changes from V2:
> - Don't use long-lived kmap. Instead use user-trigger mmap for the
>   doorbell recovery entries.
> - Modify dpi_addr to be denoted with __iomem and avoid redundant
>   casts
> 
> Changes from V1:
> - call kmap to map virtual address into kernel space
> - modify db_rec_delete to be void
> - remove some cpu_to_le16 that were added to previous patch which are
>   correct but not related to the overflow recovery mechanism. Will be
>   submitted as part of a different patch
> 
> 
> Michal Kalderon (7):
>   RDMA/core: Move core content from ib_uverbs to ib_core
>   RDMA/core: Create mmap database and cookie helper functions
>   RDMA/efa: Use the common mmap_xa helpers
>   RDMA/siw: Use the common mmap_xa helpers
>   RDMA/qedr: Use the common mmap API
>   RDMA/qedr: Add doorbell overflow recovery support
>   RDMA/qedr: Add iWARP doorbell recovery support

Haven't reviewed the patches yet, but tested successfully with EFA.
Tested-by: Gal Pressman <galpress@amazon.com>
