Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1B285F96
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 12:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbfHHK0z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Aug 2019 06:26:55 -0400
Received: from verein.lst.de ([213.95.11.211]:45417 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389947AbfHHK0z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Aug 2019 06:26:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8BF8768B02; Thu,  8 Aug 2019 12:26:52 +0200 (CEST)
Date:   Thu, 8 Aug 2019 12:26:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        Gavin Shan <shangw@linux.vnet.ibm.com>,
        Andrea Righi <andrea@betterlinux.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v3 hmm 02/11] mm/mmu_notifiers: do not speculatively
 allocate a mmu_notifier_mm
Message-ID: <20190808102652.GC648@lst.de>
References: <20190806231548.25242-1-jgg@ziepe.ca> <20190806231548.25242-3-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806231548.25242-3-jgg@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 06, 2019 at 08:15:39PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> A prior commit e0f3c3f78da2 ("mm/mmu_notifier: init notifier if necessary")
> made an attempt at doing this, but had to be reverted as calling
> the GFP_KERNEL allocator under the i_mmap_mutex causes deadlock, see
> commit 35cfa2b0b491 ("mm/mmu_notifier: allocate mmu_notifier in advance").
> 
> However, we can avoid that problem by doing the allocation only under
> the mmap_sem, which is already happening.
> 
> Since all writers to mm->mmu_notifier_mm hold the write side of the
> mmap_sem reading it under that sem is deterministic and we can use that to
> decide if the allocation path is required, without speculation.
> 
> The actual update to mmu_notifier_mm must still be done under the
> mm_take_all_locks() to ensure read-side coherency.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
