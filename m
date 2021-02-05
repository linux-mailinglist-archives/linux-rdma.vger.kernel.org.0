Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DF5311192
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 20:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhBESNg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 13:13:36 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8978 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbhBESMR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 13:12:17 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601da2570001>; Fri, 05 Feb 2021 11:53:59 -0800
Received: from MacBook-Pro-10.local (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 19:53:58 +0000
Subject: Re: [PATCH v2 1/4] mm/gup: add compound page list iterator
To:     Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210204202500.26474-1-joao.m.martins@oracle.com>
 <20210204202500.26474-2-joao.m.martins@oracle.com>
 <74edd971-a80c-78b6-7ab2-5c1f6ba4ade9@nvidia.com>
 <c274a794-94c8-3bd1-0b9d-670212279e52@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <4eececb9-fa0a-eeff-0c1f-79a0afb7da4e@nvidia.com>
Date:   Fri, 5 Feb 2021 11:53:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <c274a794-94c8-3bd1-0b9d-670212279e52@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612554839; bh=0h3J4XpgSbnd1qVxTuResEviGJFb7t4ULuzWgVzqm6Y=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=J1EL7s+beZe+hOTR8u2crhRqJwPojytXlLfGE4z7O5g60hQTigRJM/n4xeVAszlF2
         qUsoIUqGgZ5Q2fhuVsO3JaD3xkvCVpotl0OGxKnwu4EZSMKd0zzyTftg7GDq9sE8HD
         qmyA2mT+XX9TjJgiSN4nhGM3e+fINEVyMLgZc+WqYNzuSvCUKOl1iZsZuRWRxvUWVm
         sEDaM3+vicku5i6GBMV03yz2o6gIPds3ZzJYXEc5qEEqj7qM/kaO45ZcA0gsQ7zLlL
         rYd8UBMVWoAEIHFBYRTlplypwua41+B25dAbNDYhuCO+PjALKdu9EWybriTMviDOv3
         sUZr0urn5TA1g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/5/21 2:46 AM, Joao Martins wrote:
...>> If instead you keep npages constant like it naturally wants to be, you could
>> just do a "(*ntails)++" in the loop, to take care of *ntails.
>>
> I didn't do it as such as I would need to deref @ntails per iteration, so
> it felt more efficient to do as above. On a second thought, I could alternatively do the
> following below, thoughts?
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index d68bcb482b11..8defe4f670d5 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -215,6 +215,32 @@ void unpin_user_page(struct page *page)
>   }
>   EXPORT_SYMBOL(unpin_user_page);
> 
> +static inline void compound_next(unsigned long i, unsigned long npages,
> +                                struct page **list, struct page **head,
> +                                unsigned int *ntails)
> +{
> +       struct page *page;
> +       unsigned int nr;
> +
> +       if (i >= npages)
> +               return;
> +
> +       page = compound_head(list[i]);
> +       for (nr = i + 1; nr < npages; nr++) {
> +               if (compound_head(list[nr]) != page)
> +                       break;
> +       }
> +
> +       *head = page;
> +       *ntails = nr - i;
> +}
> +

Yes, this is cleaner and quite a bit easier to verify that it is correct.

> 
>> However, given that the patch is correct and works as-is, the above is really just
>> an optional idea, so please feel free to add:
>>
>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>>
>>
> Thanks!
> 
> Hopefully I can retain that if the snippet above is preferred?
> 
> 	Joao
> 

Yes. Still looks good.

thanks,
-- 
John Hubbard
NVIDIA
