Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865E630E68F
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 00:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhBCXCY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 18:02:24 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11023 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhBCXAo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Feb 2021 18:00:44 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601b2af10000>; Wed, 03 Feb 2021 15:00:01 -0800
Received: from [10.2.50.90] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Feb
 2021 23:00:01 +0000
Subject: Re: [PATCH 1/4] mm/gup: add compound page list iterator
To:     Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210203220025.8568-1-joao.m.martins@oracle.com>
 <20210203220025.8568-2-joao.m.martins@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <955dbe68-7302-a8bc-f0b5-e9032d7f190e@nvidia.com>
Date:   Wed, 3 Feb 2021 15:00:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210203220025.8568-2-joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612393201; bh=GuboAPGdFAJEcRrueyWlGFwtNTZuZ5B0TDKDNKYBHvU=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=mQzhCI696vm94Sa3p78Z7Gskyb/1gBUUyHmSuvieget9Rc7vwBpU7w1r0NFB6C6VN
         6aAvOwvLi6U22aNNpBQ7zdVKsYmFcFYFbiYYK2/d0hDMVNzD3HVapXC2aols9M9ZFx
         FDC4YTZlnb+Up0ADqnFggTaVjcMnd4TldxjnKzsMmSXq8NpwDfX91XoGtosal3fcDy
         7vQ1cQz5G25oUkJWRRln+qLOYfC0Ck4gG+5sitFYByg1lN4pdGGjfliZDvYdE7HECH
         Sikh51jbn4HEimv2sbOTSpP+3ot5se9i9fck6gxuUyABSz+vAW1V5loRYOPukKIZEM
         FsqxeTUionwTQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/3/21 2:00 PM, Joao Martins wrote:
> Add an helper that iterates over head pages in a list of pages. It
> essentially counts the tails until the next page to process has a
> different head that the current. This is going to be used by
> unpin_user_pages() family of functions, to batch the head page refcount
> updates once for all passed consecutive tail pages.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   mm/gup.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index d68bcb482b11..4f88dcef39f2 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -215,6 +215,35 @@ void unpin_user_page(struct page *page)
>   }
>   EXPORT_SYMBOL(unpin_user_page);
>   
> +static inline unsigned int count_ntails(struct page **pages, unsigned long npages)

Silly naming nit: could we please name this function count_pagetails()? count_ntails
is a bit redundant, plus slightly less clear.

> +{
> +	struct page *head = compound_head(pages[0]);
> +	unsigned int ntails;
> +
> +	for (ntails = 1; ntails < npages; ntails++) {
> +		if (compound_head(pages[ntails]) != head)
> +			break;
> +	}
> +
> +	return ntails;
> +}
> +
> +static inline void compound_next(unsigned long i, unsigned long npages,
> +				 struct page **list, struct page **head,
> +				 unsigned int *ntails)
> +{
> +	if (i >= npages)
> +		return;
> +
> +	*ntails = count_ntails(list + i, npages - i);
> +	*head = compound_head(list[i]);
> +}
> +
> +#define for_each_compound_head(i, list, npages, head, ntails) \

When using macros, which are dangerous in general, you have to worry about
things like name collisions. I really dislike that C has forced this unsafe
pattern upon us, but of course we are stuck with it, for iterator helpers.

Given that we're stuck, you should probably use names such as __i, __list, etc,
in the the above #define. Otherwise you could stomp on existing variables.

> +	for (i = 0, compound_next(i, npages, list, &head, &ntails); \
> +	     i < npages; i += ntails, \
> +	     compound_next(i, npages, list, &head, &ntails))
> +
>   /**
>    * unpin_user_pages_dirty_lock() - release and optionally dirty gup-pinned pages
>    * @pages:  array of pages to be maybe marked dirty, and definitely released.
> 

thanks,
-- 
John Hubbard
NVIDIA
