Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2472430E78A
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 00:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhBCXiK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 18:38:10 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12351 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbhBCXiJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Feb 2021 18:38:09 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601b33b80001>; Wed, 03 Feb 2021 15:37:28 -0800
Received: from [10.2.50.90] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Feb
 2021 23:37:27 +0000
Subject: Re: [PATCH 3/4] mm/gup: add a range variant of
 unpin_user_pages_dirty_lock()
To:     Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210203220025.8568-1-joao.m.martins@oracle.com>
 <20210203220025.8568-4-joao.m.martins@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <5e372e25-7202-e0b6-0763-d267698db5b6@nvidia.com>
Date:   Wed, 3 Feb 2021 15:37:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210203220025.8568-4-joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612395448; bh=qmULijZhnU2V5sy1R2oqyUqss+1cKK98EBpQ9ju3bbA=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=sRmiPr89EHkBrP1GmMCoZXLqZ8VNSxITNjBQAusN3GvzxUWFBhrL2lcJWkF2P+kIy
         9l/L96pp283mqBsKXSdXMP0B7cEfRLetUuITXjeswSnr8XLx0P4/UIvKie54tKU1mf
         RpmbXU9qWq5buJRRakkHwQhFKSy9loIcIm/yezE7DT0hw6LsMEcHUL4OVD68nONe+4
         5yc2+k/QQrp9pk3u0lIFjE8/A8jeBAMHka7l5ndPFJtTbRlCzg3Nzc/W6CJBNCIGM6
         vnm3YQcA8HDupkLPIGStYq25sRtz4qCPmfPCh2wom3KbLqf+xlQhZr8JM0Iq56otyK
         dKoU440SkQ1xA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/3/21 2:00 PM, Joao Martins wrote:
> Add a unpin_user_page_range() API which takes a starting page
> and how many consecutive pages we want to dirty.
> 
> Given that we won't be iterating on a list of changes, change
> compound_next() to receive a bool, whether to calculate from the starting
> page, or walk the page array. Finally add a separate iterator,

A bool arg is sometimes, but not always, a hint that you really just want
a separate set of routines. Below...

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
>   mm/gup.c           | 48 ++++++++++++++++++++++++++++++++++++++--------
>   2 files changed, 42 insertions(+), 8 deletions(-)
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
> index 971a24b4b73f..1b57355d5033 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -215,11 +215,16 @@ void unpin_user_page(struct page *page)
>   }
>   EXPORT_SYMBOL(unpin_user_page);
>   
> -static inline unsigned int count_ntails(struct page **pages, unsigned long npages)
> +static inline unsigned int count_ntails(struct page **pages,
> +					unsigned long npages, bool range)
>   {
> -	struct page *head = compound_head(pages[0]);
> +	struct page *page = pages[0], *head = compound_head(page);
>   	unsigned int ntails;
>   
> +	if (range)
> +		return (!PageCompound(head) || compound_order(head) <= 1) ? 1 :
> +		   min_t(unsigned int, (head + compound_nr(head) - page), npages);

Here, you clearly should use a separate set of _range routines. Because you're basically
creating two different routines here! Keep it simple.

Once you're in a separate routine, you might feel more comfortable expanding that to
a more readable form, too:

	if (!PageCompound(head) || compound_order(head) <= 1)
		return 1;

	return min_t(unsigned int, (head + compound_nr(head) - page), npages);


thanks,
-- 
John Hubbard
NVIDIA

> +
>   	for (ntails = 1; ntails < npages; ntails++) {
>   		if (compound_head(pages[ntails]) != head)
>   			break;
> @@ -229,20 +234,32 @@ static inline unsigned int count_ntails(struct page **pages, unsigned long npage
>   }
>   
>   static inline void compound_next(unsigned long i, unsigned long npages,
> -				 struct page **list, struct page **head,
> -				 unsigned int *ntails)
> +				 struct page **list, bool range,
> +				 struct page **head, unsigned int *ntails)
>   {
> +	struct page *p, **next = &p;
> +
>   	if (i >= npages)
>   		return;
>   
> -	*ntails = count_ntails(list + i, npages - i);
> -	*head = compound_head(list[i]);
> +	if (range)
> +		*next = *list + i;
> +	else
> +		next = list + i;
> +
> +	*ntails = count_ntails(next, npages - i, range);
> +	*head = compound_head(*next);
>   }
>   
> +#define for_each_compound_range(i, list, npages, head, ntails) \
> +	for (i = 0, compound_next(i, npages, list, true, &head, &ntails); \
> +	     i < npages; i += ntails, \
> +	     compound_next(i, npages, list, true,  &head, &ntails))
> +
>   #define for_each_compound_head(i, list, npages, head, ntails) \
> -	for (i = 0, compound_next(i, npages, list, &head, &ntails); \
> +	for (i = 0, compound_next(i, npages, list, false, &head, &ntails); \
>   	     i < npages; i += ntails, \
> -	     compound_next(i, npages, list, &head, &ntails))
> +	     compound_next(i, npages, list, false,  &head, &ntails))
>   
>   /**
>    * unpin_user_pages_dirty_lock() - release and optionally dirty gup-pinned pages
> @@ -306,6 +323,21 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>   }
>   EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
>   
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
