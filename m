Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F265F317438
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 00:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhBJXUY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 18:20:24 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6907 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhBJXUW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Feb 2021 18:20:22 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60246a0d0001>; Wed, 10 Feb 2021 15:19:41 -0800
Received: from [10.2.50.67] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 23:19:41 +0000
Subject: Re: [PATCH v3 3/4] mm/gup: add a range variant of
 unpin_user_pages_dirty_lock()
To:     Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210205204127.29441-1-joao.m.martins@oracle.com>
 <20210205204127.29441-4-joao.m.martins@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <6ce67c15-3bb3-3ccb-3c45-edb0efb3a38f@nvidia.com>
Date:   Wed, 10 Feb 2021 15:19:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210205204127.29441-4-joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612999181; bh=FPDbkf9bycX12XeKfhn1RlZRPRS4j668V61lFIhF4zQ=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=pb8CprMoPgh3SW8Vrysu2qUQLAibhJIIpBJh9GFUPASzC3DConnSy/kHhHoQYrBw1
         jdnU5p70FH1Ui3NL0b/YtyJWC2YZhsCx8sQ7ZFcoBvNi4r4D6cOdHVyv6Ju3808F5P
         ewabyAawRX94Hae6meRvQpMBM7fzJpc+JzgwBWZy4Tv0iUe/S72ifD7HKDCEgY/7s3
         q6BSmybp1vT2Paeeji9uZh1qIl5jZq4FEPVz7BZD7K8rNhymrwWDFND8y2+Beez5r4
         qHfXrx0Grwgrn59Zam47B3JSD5B3p9QUTY6gXF4h85uJs9jDDZrHk8xfqMHZkWrUfH
         K6R1F9Z9sAurw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/5/21 12:41 PM, Joao Martins wrote:
> Add a unpin_user_page_range_dirty_lock() API which takes a starting page
> and how many consecutive pages we want to unpin and optionally dirty.
> 
> To that end, define another iterator for_each_compound_range()
> that operates in page ranges as opposed to page array.
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
>   mm/gup.c           | 62 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 64 insertions(+)
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
> index 467a11df216d..938964d31494 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -215,6 +215,32 @@ void unpin_user_page(struct page *page)
>   }
>   EXPORT_SYMBOL(unpin_user_page);
>   
> +static inline void compound_range_next(unsigned long i, unsigned long npages,
> +				       struct page **list, struct page **head,
> +				       unsigned int *ntails)

Yes, the new names look good, and I have failed to find any logic errors, so:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> +{
> +	struct page *next, *page;
> +	unsigned int nr = 1;
> +
> +	if (i >= npages)
> +		return;
> +
> +	next = *list + i;
> +	page = compound_head(next);
> +	if (PageCompound(page) && compound_order(page) >= 1)
> +		nr = min_t(unsigned int,
> +			   page + compound_nr(page) - next, npages - i);
> +
> +	*head = page;
> +	*ntails = nr;
> +}
> +
> +#define for_each_compound_range(__i, __list, __npages, __head, __ntails) \
> +	for (__i = 0, \
> +	     compound_range_next(__i, __npages, __list, &(__head), &(__ntails)); \
> +	     __i < __npages; __i += __ntails, \
> +	     compound_range_next(__i, __npages, __list, &(__head), &(__ntails)))
> +
>   static inline void compound_next(unsigned long i, unsigned long npages,
>   				 struct page **list, struct page **head,
>   				 unsigned int *ntails)
> @@ -303,6 +329,42 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
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

