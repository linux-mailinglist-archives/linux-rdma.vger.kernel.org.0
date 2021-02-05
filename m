Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A2131042B
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 05:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhBEEuR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 23:50:17 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6552 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhBEEuR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 23:50:17 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601cce600001>; Thu, 04 Feb 2021 20:49:36 -0800
Received: from [10.2.60.31] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 04:49:36 +0000
Subject: Re: [PATCH v2 3/4] mm/gup: add a range variant of
 unpin_user_pages_dirty_lock()
To:     Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210204202500.26474-1-joao.m.martins@oracle.com>
 <20210204202500.26474-4-joao.m.martins@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <6376e151-06fc-1e1b-0b30-1592972353ea@nvidia.com>
Date:   Thu, 4 Feb 2021 20:49:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210204202500.26474-4-joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612500576; bh=L4XmPV4/LhWtyabb5k0RK+38d7lFs/eNJZcod012PNM=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=g+GtMvCz6EcwIsEtSNiCCgMAmVvGlbRkEu2ZJEtjFrc07me1K2ZBn5P0YHcdpznVY
         dYfvAf5//QPlrEJH5ufTin59hPyE5Wx3oslPqxXI3omqWCKeVdNOzI5TqrCEa+6v2S
         yPETIbxNsR4s0iLVKCgYVgbYDVGw6y56QmiKx/chKn6d7Tnl6US5ThIe1sYGs65Bot
         kvnNb7qKLw7mXwiQe1fvbsyNN2B9bFmxoeYE/pxtaWR3xNj15siuwlHURU3o2wDP4d
         z1Z3zDUI3ZY/czu9uvY24huIV3ZQOHlCkn8CWDkR8Zlu/DGXFv6i70L+Levx2p8VI4
         Xrrhcj7QiGgXA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/4/21 12:24 PM, Joao Martins wrote:
> Add a unpin_user_page_range_dirty_lock() API which takes a starting page
> and how many consecutive pages we want to unpin and optionally dirty.
> 
> Given that we won't be iterating on a list of changes, change
> compound_next() to receive a bool, whether to calculate from the starting

Thankfully, that claim is stale and can now be removed from this commit
description.

> page, or walk the page array. Finally add a separate iterator,
> for_each_compound_range() that just operate in page ranges as opposed
> to page array.
> 
> For users (like RDMA mr_dereg) where each sg represents a
> contiguous set of pages, we're able to more efficiently unpin
> pages without having to supply an array of pages much of what
> happens today with unpin_user_pages().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   include/linux/mm.h |  2 ++
>   mm/gup.c           | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 66 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a608feb0d42e..b76063f7f18a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1265,6 +1265,8 @@ static inline void put_page(struct page *page)
>   void unpin_user_page(struct page *page);
>   void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>   				 bool make_dirty);
> +void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
> +				      bool make_dirty);
>   void unpin_user_pages(struct page **pages, unsigned long npages);
>   
>   /**
> diff --git a/mm/gup.c b/mm/gup.c
> index 5a3dd235017a..3426736a01b2 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -215,6 +215,34 @@ void unpin_user_page(struct page *page)
>   }
>   EXPORT_SYMBOL(unpin_user_page);
>   
> +static inline void range_next(unsigned long i, unsigned long npages,
> +			      struct page **list, struct page **head,
> +			      unsigned int *ntails)

Would compound_range_next() be a better name?

> +{
> +	struct page *next, *page;
> +	unsigned int nr = 1;
> +
> +	if (i >= npages)
> +		return;
> +
> +	npages -= i;
> +	next = *list + i;
> +
> +	page = compound_head(next);
> +	if (PageCompound(page) && compound_order(page) > 1)
> +		nr = min_t(unsigned int,
> +			   page + compound_nr(page) - next, npages);

This pointer arithmetic will involve division. Which may be unnecessarily
expensive, if there is a way to calculate this with indices instead of
pointer arithmetic. I'm not sure if there is, off hand, but thought it
worth mentioning because the point is sometimes overlooked.

> +
> +	*head = page;
> +	*ntails = nr;
> +}
> +
> +#define for_each_compound_range(__i, __list, __npages, __head, __ntails) \
> +	for (__i = 0, \
> +	     range_next(__i, __npages, __list, &(__head), &(__ntails)); \
> +	     __i < __npages; __i += __ntails, \
> +	     range_next(__i, __npages, __list, &(__head), &(__ntails)))
> +
>   static inline void compound_next(unsigned long i, unsigned long npages,
>   				 struct page **list, struct page **head,
>   				 unsigned int *ntails)
> @@ -306,6 +334,42 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>   }
>   EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
>   
> +/**
> + * unpin_user_page_range_dirty_lock() - release and optionally dirty
> + * gup-pinned page range
> + *
> + * @page:  the starting page of a range maybe marked dirty, and definitely released.
> + * @npages: number of consecutive pages to release.
> + * @make_dirty: whether to mark the pages dirty
> + *
> + * "gup-pinned page range" refers to a range of pages that has had one of the
> + * get_user_pages() variants called on that page.
> + *
> + * For the page ranges defined by [page .. page+npages], make that range (or
> + * its head pages, if a compound page) dirty, if @make_dirty is true, and if the
> + * page range was previously listed as clean.
> + *
> + * set_page_dirty_lock() is used internally. If instead, set_page_dirty() is
> + * required, then the caller should a) verify that this is really correct,
> + * because _lock() is usually required, and b) hand code it:
> + * set_page_dirty_lock(), unpin_user_page().
> + *
> + */
> +void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
> +				      bool make_dirty)
> +{
> +	unsigned long index;
> +	struct page *head;
> +	unsigned int ntails;
> +
> +	for_each_compound_range(index, &page, npages, head, ntails) {
> +		if (make_dirty && !PageDirty(head))
> +			set_page_dirty_lock(head);
> +		put_compound_head(head, ntails, FOLL_PIN);
> +	}
> +}
> +EXPORT_SYMBOL(unpin_user_page_range_dirty_lock);
> +
>   /**
>    * unpin_user_pages() - release an array of gup-pinned pages.
>    * @pages:  array of pages to be marked dirty and released.
> 

Didn't spot any actual problems with how this works.

thanks,
-- 
John Hubbard
NVIDIA
