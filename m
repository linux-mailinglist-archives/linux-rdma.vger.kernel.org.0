Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 757144706A
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2019 16:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfFOOZV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Jun 2019 10:25:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfFOOZV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Jun 2019 10:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SdWUCWylJzhzeM8QVNQHKHRjscfikWmZIAkgaxj+0Bw=; b=A7X2mxpnfBOFX0A60aP25q3n/
        szKd4gAVZwsTrlyaIQc5xR24lEmlvmqS83JEsqzjL+AHehjxvbX9tH+sGx5b+/T/POdhFT1Xy7EQd
        z9W2915h22nOnp+4mPxdGJjQST174K6/01OPoe8ioZOArCSmBX24iHJLukWtBCN5yrp7lgnCtL/If
        1mfw9bWonbn4DfHzMmLdRA3xr91p9DvtZSE0qrB2lAlkJ5w/EDdE8D0zcUjdAQSONzDYM6FcFPb/k
        YM/tCltM51daIP24UNpmoh0cZpWskqznE35632yXKH+R+QmO89o+nzwUgq0GJ1pb7OrMAPqMpErU/
        dFBGPBDoQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hc9cG-0008Br-TX; Sat, 15 Jun 2019 14:25:12 +0000
Date:   Sat, 15 Jun 2019 07:25:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 12/12] mm/hmm: Fix error flows in
 hmm_invalidate_range_start
Message-ID: <20190615142512.GL17724@infradead.org>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-13-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614004450.20252-13-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 13, 2019 at 09:44:50PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> If the trylock on the hmm->mirrors_sem fails the function will return
> without decrementing the notifiers that were previously incremented. Since
> the caller will not call invalidate_range_end() on EAGAIN this will result
> in notifiers becoming permanently incremented and deadlock.
> 
> If the sync_cpu_device_pagetables() required blocking the function will
> not return EAGAIN even though the device continues to touch the
> pages. This is a violation of the mmu notifier contract.
> 
> Switch, and rename, the ranges_lock to a spin lock so we can reliably
> obtain it without blocking during error unwind.
> 
> The error unwind is necessary since the notifiers count must be held
> incremented across the call to sync_cpu_device_pagetables() as we cannot
> allow the range to become marked valid by a parallel
> invalidate_start/end() pair while doing sync_cpu_device_pagetables().
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
> Tested-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  include/linux/hmm.h |  2 +-
>  mm/hmm.c            | 77 +++++++++++++++++++++++++++------------------
>  2 files changed, 48 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index bf013e96525771..0fa8ea34ccef6d 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -86,7 +86,7 @@
>  struct hmm {
>  	struct mm_struct	*mm;
>  	struct kref		kref;
> -	struct mutex		lock;
> +	spinlock_t		ranges_lock;
>  	struct list_head	ranges;
>  	struct list_head	mirrors;
>  	struct mmu_notifier	mmu_notifier;
> diff --git a/mm/hmm.c b/mm/hmm.c
> index c0d43302fd6b2f..1172a4f0206963 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -67,7 +67,7 @@ static struct hmm *hmm_get_or_create(struct mm_struct *mm)
>  	init_rwsem(&hmm->mirrors_sem);
>  	hmm->mmu_notifier.ops = NULL;
>  	INIT_LIST_HEAD(&hmm->ranges);
> -	mutex_init(&hmm->lock);
> +	spin_lock_init(&hmm->ranges_lock);
>  	kref_init(&hmm->kref);
>  	hmm->notifiers = 0;
>  	hmm->mm = mm;
> @@ -124,18 +124,19 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>  {
>  	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
>  	struct hmm_mirror *mirror;
> +	unsigned long flags;
>  
>  	/* Bail out if hmm is in the process of being freed */
>  	if (!kref_get_unless_zero(&hmm->kref))
>  		return;
>  
> -	mutex_lock(&hmm->lock);
> +	spin_lock_irqsave(&hmm->ranges_lock, flags);
>  	/*
>  	 * Since hmm_range_register() holds the mmget() lock hmm_release() is
>  	 * prevented as long as a range exists.
>  	 */
>  	WARN_ON(!list_empty(&hmm->ranges));
> -	mutex_unlock(&hmm->lock);
> +	spin_unlock_irqrestore(&hmm->ranges_lock, flags);
>  
>  	down_read(&hmm->mirrors_sem);
>  	list_for_each_entry(mirror, &hmm->mirrors, list) {
> @@ -151,6 +152,23 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>  	hmm_put(hmm);
>  }
>  
> +static void notifiers_decrement(struct hmm *hmm)
> +{
> +	lockdep_assert_held(&hmm->ranges_lock);
> +
> +	hmm->notifiers--;
> +	if (!hmm->notifiers) {

Nitpick, when doing dec and test or inc and test ops I find it much
easier to read if they are merged into one line, i.e.

	if (!--hmm->notifiers) {

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
