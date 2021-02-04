Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA9830E864
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 01:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhBDAQf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 19:16:35 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7678 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbhBDAQe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Feb 2021 19:16:34 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601b3cb90003>; Wed, 03 Feb 2021 16:15:53 -0800
Received: from [10.2.50.90] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Feb
 2021 00:15:53 +0000
Subject: Re: [PATCH 4/4] RDMA/umem: batch page unpin in __ib_mem_release()
To:     Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210203220025.8568-1-joao.m.martins@oracle.com>
 <20210203220025.8568-5-joao.m.martins@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <4ed92932-8cf2-97ab-7296-6efee51fc555@nvidia.com>
Date:   Wed, 3 Feb 2021 16:15:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210203220025.8568-5-joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612397753; bh=FKxxVoiW2V506J4PCGyrpYPZ6Kptj9MoY4pk4P9XslA=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=fJS4knUwtxxz+DimlJaYQXzRUUV1jiXYzmwh2N9EwutcpqMJx2Ir9z7uRwQdFZ9Yd
         UIsTAjM1UF/vOdTStAC7BGPq2pbqlaLcR3bo5wu3R/h6hu44blEH2R1uykAie8OD4D
         iArUROqhod14DsVwfpd7RZ6vUKi6wV3dYVQy6pp8pE4TsXc2/rmBCJu+AI+MEq7OUd
         xUPuFF4pR2tee7vebUeImE7g8PlFC7uvdewEX8Gc4HvQz3UXkf2Np/LevSQpzM1WqV
         9coNypNBAlQ/Wdt02KLy8L3/Fro0NJGK8S08FSG92Reo1f4F0IkR/CHoRiyX1eaX4M
         +qOg/j1pFRz3w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/3/21 2:00 PM, Joao Martins wrote:
> Use the newly added unpin_user_page_range_dirty_lock()
> for more quickly unpinning a consecutive range of pages
> represented as compound pages. This will also calculate
> number of pages to unpin (for the tail pages which matching
> head page) and thus batch the refcount update.
> 
> Running a test program which calls mr reg/unreg on a 1G in size
> and measures cost of both operations together (in a guest using rxe)
> with THP and hugetlbfs:

In the patch subject line:

    s/__ib_mem_release/__ib_umem_release/

> 
> Before:
> 590 rounds in 5.003 sec: 8480.335 usec / round
> 6898 rounds in 60.001 sec: 8698.367 usec / round
> 
> After:
> 2631 rounds in 5.001 sec: 1900.618 usec / round
> 31625 rounds in 60.001 sec: 1897.267 usec / round
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   drivers/infiniband/core/umem.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index 2dde99a9ba07..ea4ebb3261d9 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -47,17 +47,17 @@
>   
>   static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
>   {
> -	struct sg_page_iter sg_iter;
> -	struct page *page;
> +	bool make_dirty = umem->writable && dirty;
> +	struct scatterlist *sg;
> +	int i;

Maybe unsigned int is better, so as to perfectly match the scatterlist.length.

>   
>   	if (umem->nmap > 0)
>   		ib_dma_unmap_sg(dev, umem->sg_head.sgl, umem->sg_nents,
>   				DMA_BIDIRECTIONAL);
>   
> -	for_each_sg_page(umem->sg_head.sgl, &sg_iter, umem->sg_nents, 0) {
> -		page = sg_page_iter_page(&sg_iter);
> -		unpin_user_pages_dirty_lock(&page, 1, umem->writable && dirty);
> -	}
> +	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, i)

The change from umem->sg_nents to umem->nmap looks OK, although we should get
IB people to verify that there is not some odd bug or reason to leave it as is.

> +		unpin_user_page_range_dirty_lock(sg_page(sg),
> +			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);

Is it really OK to refer directly to sg->length? The scatterlist library goes
to some effort to avoid having callers directly access the struct member variables.

Actually, the for_each_sg() code and its behavior with sg->length and sg_page(sg)
confuses me because I'm new to it, and I don't quite understand how this works.
Especially with SG_CHAIN. I'm assuming that you've monitored /proc/vmstat for
nr_foll_pin* ?

>   
>   	sg_free_table(&umem->sg_head);
>   }
> 

thanks,
-- 
John Hubbard
NVIDIA
