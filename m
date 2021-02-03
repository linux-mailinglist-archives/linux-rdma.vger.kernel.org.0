Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870A030E758
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 00:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhBCX3A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 18:29:00 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12995 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbhBCX27 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Feb 2021 18:28:59 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601b31930000>; Wed, 03 Feb 2021 15:28:19 -0800
Received: from [10.2.50.90] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Feb
 2021 23:28:18 +0000
Subject: Re: [PATCH 2/4] mm/gup: decrement head page once for group of
 subpages
To:     Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210203220025.8568-1-joao.m.martins@oracle.com>
 <20210203220025.8568-3-joao.m.martins@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <a1f9ba72-67c3-7307-89e6-d995ab782b42@nvidia.com>
Date:   Wed, 3 Feb 2021 15:28:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210203220025.8568-3-joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612394899; bh=NpVFPNmAXUPcZtYNGV8eUTmbWgT9gI9vypgKnogWp0U=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=Fr8Gh2SOSsDHAOUG3QOjsZh42pkAchXWWpbVa8eaP0c5V9yXGmZGGtNKCnFOplHNR
         GmPAzEQ9Fov/WoEFOfzN2UXmcD3oUJDc9AbC9mEqvHqv8IKQxdZL/+fbqogJeKkUP3
         A1nMVtFtSIX6xQ30oI6Hzj4TUHYirpJOGWDCDhVqp4+qDnImNO9wnr171twtHIHoWC
         +SxKP63n/AjPTeMbrI9NoHwVA5UQsMRSr8yztUi1SEecSJIpq2GWoDUC8g0xYSc01w
         fpgl9R24FFgxLEcVXHMcvsfLcx7JWfQCpyvVXpg5BW845KSS3lbc3NIrg7hgvhzorF
         st1RJOvbucgFw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/3/21 2:00 PM, Joao Martins wrote:
> Rather than decrementing the head page refcount one by one, we
> walk the page array and checking which belong to the same
> compound_head. Later on we decrement the calculated amount
> of references in a single write to the head page. To that
> end switch to for_each_compound_head() does most of the work.
> 
> set_page_dirty() needs no adjustment as it's a nop for
> non-dirty head pages and it doesn't operate on tail pages.
> 
> This considerably improves unpinning of pages with THP and
> hugetlbfs:
> 
> - THP
> gup_test -t -m 16384 -r 10 [-L|-a] -S -n 512 -w
> PIN_LONGTERM_BENCHMARK (put values): ~87.6k us -> ~23.2k us
> 
> - 16G with 1G huge page size
> gup_test -f /mnt/huge/file -m 16384 -r 10 [-L|-a] -S -n 512 -w
> PIN_LONGTERM_BENCHMARK: (put values): ~87.6k us -> ~27.5k us
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   mm/gup.c | 29 +++++++++++------------------
>   1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 4f88dcef39f2..971a24b4b73f 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -270,20 +270,15 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>   				 bool make_dirty)
>   {
>   	unsigned long index;
> -
> -	/*
> -	 * TODO: this can be optimized for huge pages: if a series of pages is
> -	 * physically contiguous and part of the same compound page, then a
> -	 * single operation to the head page should suffice.
> -	 */

Great to see this TODO (and the related one below) finally done!

Everything looks correct here.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> +	struct page *head;
> +	unsigned int ntails;
>   
>   	if (!make_dirty) {
>   		unpin_user_pages(pages, npages);
>   		return;
>   	}
>   
> -	for (index = 0; index < npages; index++) {
> -		struct page *page = compound_head(pages[index]);
> +	for_each_compound_head(index, pages, npages, head, ntails) {
>   		/*
>   		 * Checking PageDirty at this point may race with
>   		 * clear_page_dirty_for_io(), but that's OK. Two key
> @@ -304,9 +299,9 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>   		 * written back, so it gets written back again in the
>   		 * next writeback cycle. This is harmless.
>   		 */
> -		if (!PageDirty(page))
> -			set_page_dirty_lock(page);
> -		unpin_user_page(page);
> +		if (!PageDirty(head))
> +			set_page_dirty_lock(head);
> +		put_compound_head(head, ntails, FOLL_PIN);
>   	}
>   }
>   EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
> @@ -323,6 +318,8 @@ EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
>   void unpin_user_pages(struct page **pages, unsigned long npages)
>   {
>   	unsigned long index;
> +	struct page *head;
> +	unsigned int ntails;
>   
>   	/*
>   	 * If this WARN_ON() fires, then the system *might* be leaking pages (by
> @@ -331,13 +328,9 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
>   	 */
>   	if (WARN_ON(IS_ERR_VALUE(npages)))
>   		return;
> -	/*
> -	 * TODO: this can be optimized for huge pages: if a series of pages is
> -	 * physically contiguous and part of the same compound page, then a
> -	 * single operation to the head page should suffice.
> -	 */
> -	for (index = 0; index < npages; index++)
> -		unpin_user_page(pages[index]);
> +
> +	for_each_compound_head(index, pages, npages, head, ntails)
> +		put_compound_head(head, ntails, FOLL_PIN);
>   }
>   EXPORT_SYMBOL(unpin_user_pages);
>   
> 

