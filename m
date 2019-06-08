Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55DAF39BFD
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 11:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfFHJKP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jun 2019 05:10:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfFHJKP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 8 Jun 2019 05:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jWAF5+2MrHGGuTvQFl5pQjHX1gq26Kf37occ6yCO+7s=; b=egAbhAuk58EO8mWmsVFAI1IGL
        3NGx28Wqh4mlsRk6rZ00vWqQWM9snKOqvzJ8t8oTYp3b7YpQ4FN8ZhKbrlJodVCitb+Vxfv2byRPT
        NBRO5aK1ycIXMfWixI6Hii44xtfrHE8G1KXTx+YJdvNlNvFPERvkjfosNOy0pOMJSRev/soMMoM/5
        AvIuJh9HkQKbxAE+dz94FYEl91SIfv2c4vtlSkMXRjP+nFBN9qBOL2MNvAGJ9SoDWRIVQ+IolhzoT
        n7RKcTtWipcfqFeHOcfjaOXuF634N2hfWMei0HWuZlCxhD+yKfrFhXTL4UzOcxjtOOHD2M63qigYY
        y8qlfJgRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hZXMW-0001PM-Rs; Sat, 08 Jun 2019 09:10:08 +0000
Date:   Sat, 8 Jun 2019 02:10:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [RFC] mm/hmm: pass mmu_notifier_range to
 sync_cpu_device_pagetables
Message-ID: <20190608091008.GC32185@infradead.org>
References: <20190608001452.7922-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608001452.7922-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 07, 2019 at 05:14:52PM -0700, Ralph Campbell wrote:
> HMM defines its own struct hmm_update which is passed to the
> sync_cpu_device_pagetables() callback function. This is
> sufficient when the only action is to invalidate. However,
> a device may want to know the reason for the invalidation and
> be able to see the new permissions on a range, update device access
> rights or range statistics. Since sync_cpu_device_pagetables()
> can be called from try_to_unmap(), the mmap_sem may not be held
> and find_vma() is not safe to be called.
> Pass the struct mmu_notifier_range to sync_cpu_device_pagetables()
> to allow the full invalidation information to be used.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
> 
> I'm sending this out now since we are updating many of the HMM APIs
> and I think it will be useful.

This is the right thing to do.  But the really right thing is to just
kill the hmm_mirror API entirely and move to mmu_notifiers.  At least
for noveau this already is way simpler, although right now it defeats
Jasons patch to avoid allocating the struct hmm in the fault path.
But as said before that can be avoided by just killing struct hmm,
which for many reasons is the right thing to do anyway.

I've got a series here, which is a bit broken (epecially the last
patch can't work as-is), but should explain where I'm trying to head:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/hmm-mirror-simplification
