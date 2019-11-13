Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26CE5FB1FD
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2019 14:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfKMN75 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Nov 2019 08:59:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60514 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfKMN74 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Nov 2019 08:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Mr4RY3jvcUlwtWVilQSRD7aASsaH0ZVmNXKgXD4ar2I=; b=L4pEOF8gToeI1wxRP1AwsUyj7
        it0aZ/H3gzMqN/frlWv7pf8ACU3+ysRk7aQMNDAwKSfgsnYZtpbRLVOgl2xWx2oZDjs6GDaFt9WvR
        l/NQ2gO/K3Ot7KXxQGR4VKhxlIaN3GUEGwzrCHmhIUE4AAL0RvwNFG3C6vKao2bg2rryraoP9pDjJ
        M9IDd6BxvnT2iTiJ3v7dvNhUY1+or3v58FJ4rYsLWxgRZsp54JWPrtILV8uaQiYhqnc+PE8/Af1RU
        FAMu2LxxYuyc1s+r4BStFsKVk8JJ0/AZtijke8xPvXEVjlaYoNKs52mvNP7KuysuicWSP/O+gJLCs
        9wgg5VPgA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUtBY-0001WY-NU; Wed, 13 Nov 2019 13:59:52 +0000
Date:   Wed, 13 Nov 2019 05:59:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        nouveau@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 02/14] mm/mmu_notifier: add an interval tree notifier
Message-ID: <20191113135952.GB20531@infradead.org>
References: <20191112202231.3856-1-jgg@ziepe.ca>
 <20191112202231.3856-3-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112202231.3856-3-jgg@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> +int mmu_interval_notifier_insert(struct mmu_interval_notifier *mni,
> +				 struct mm_struct *mm, unsigned long start,
> +				 unsigned long length,
> +				 const struct mmu_interval_notifier_ops *ops);
> +int mmu_interval_notifier_insert_locked(
> +	struct mmu_interval_notifier *mni, struct mm_struct *mm,
> +	unsigned long start, unsigned long length,
> +	const struct mmu_interval_notifier_ops *ops);

Very inconsistent indentation between these two related functions.

> +	/*
> +	 * The inv_end incorporates a deferred mechanism like
> +	 * rtnl_unlock(). Adds and removes are queued until the final inv_end
> +	 * happens then they are progressed. This arrangement for tree updates
> +	 * is used to avoid using a blocking lock during
> +	 * invalidate_range_start.

Nitpick:  That comment can be condensed into one less line:

	/*
	 * The inv_end incorporates a deferred mechanism like rtnl_unlock().
	 * Adds and removes are queued until the final inv_end happens then
	 * they are progressed. This arrangement for tree updates is used to
	 * avoid using a blocking lock during invalidate_range_start.
	 */

> +	/*
> +	 * TODO: Since we already have a spinlock above, this would be faster
> +	 * as wake_up_q
> +	 */
> +	if (need_wake)
> +		wake_up_all(&mmn_mm->wq);

So why is this important enough for a TODO comment, but not important
enough to do right away?

> +	 * release semantics on the initialization of the mmu_notifier_mm's
> +         * contents are provided for unlocked readers.  acquire can only be
> +         * used while holding the mmgrab or mmget, and is safe because once
> +         * created the mmu_notififer_mm is not freed until the mm is
> +         * destroyed.  As above, users holding the mmap_sem or one of the
> +         * mm_take_all_locks() do not need to use acquire semantics.
>  	 */

Some spaces instead of tabs here.

> +static int __mmu_interval_notifier_insert(
> +	struct mmu_interval_notifier *mni, struct mm_struct *mm,
> +	struct mmu_notifier_mm *mmn_mm, unsigned long start,
> +	unsigned long length, const struct mmu_interval_notifier_ops *ops)

Odd indentation - we usuall do two tabs (my preference) or align after
the opening brace.

> + * This function must be paired with mmu_interval_notifier_insert(). It cannot be

line > 80 chars.

Otherwise this looks good and very similar to what I reviewed earlier:

Reviewed-by: Christoph Hellwig <hch@lst.de>
