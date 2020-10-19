Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD222924FD
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Oct 2020 11:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgJSJua (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Oct 2020 05:50:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:26889 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgJSJu3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Oct 2020 05:50:29 -0400
IronPort-SDR: iJ/Tr0+YqNwOZYuF8Nuz4QRySEZRhKsdJMA3iHe9qwxqd0KzDJRUaxxqKgTKwM9wJJrPmlDG8l
 WDRN4BQzGFIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="167074347"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="167074347"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 02:50:29 -0700
IronPort-SDR: wOhg53Sl2o7dSrmuey9mftrC8wQLe5UHW2R48yboVQeair4n2dGzZ/4W1Em2ITVY0vpMmdFkDE
 2n79TSlJDT+A==
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="465465851"
Received: from ashaulsk-mobl1.ger.corp.intel.com (HELO [10.214.247.170]) ([10.214.247.170])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 02:50:25 -0700
Subject: Re: dynamic-sg patch has broken rdma_rxe
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Ursulin, Tvrtko" <tvrtko.ursulin@intel.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Gal Pressman <galpress@amazon.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
References: <0fdfc60e-ea93-8cf2-b23a-ce5d07d5fe33@gmail.com>
 <20201014225125.GC5316@nvidia.com>
 <e2763434-2f4f-9971-ae9d-62bab62b2e93@nvidia.com>
 <63997d02-827c-5a0d-c6a1-427cbeb4ef27@amazon.com>
 <8cf4796d-4dcb-ef5a-83ac-e11134eac99b@nvidia.com>
 <20201016003127.GD6219@nvidia.com>
 <796ca31aed8f469c957cb850385b9d09@intel.com>
 <20201016115831.GI6219@nvidia.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <9fa38ed1-605e-f0f6-6cb6-70b800a1831a@linux.intel.com>
Date:   Mon, 19 Oct 2020 10:50:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016115831.GI6219@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 16/10/2020 12:58, Jason Gunthorpe wrote:
> On Fri, Oct 16, 2020 at 08:29:11AM +0000, Ursulin, Tvrtko wrote:
>>
>> Hi guys,
>>
>> [I removed the mailing list from cc since from this email address) I
>> can't reply properly inline. (tvrtko.ursulin@linux.intel.com works
>> better.)]
> 
> I put it back
>   
>> However:
>>
>> +	/* Avoid overflow when computing sg_len + PAGE_SIZE */
>> +	max_segment = max_segment & PAGE_MASK;
>> +	if (WARN_ON(max_segment < PAGE_SIZE))
>>   		return ERR_PTR(-EINVAL);
>>
>> Maybe it's too early for me but I don't get this. It appears the
>> condition can only be true if the max_segment is smaller than page
>> size as passed in to the function to _start with_. Don't see what
>> does filtering out low bits achieves on top.
> 
> The entire problem is the algorithm in __sg_alloc_table_from_pages()
> only limits sg_len to
> 
>     sg_len == N * PAGE_SIZE <= ALIGN_UP(max_segment, PAGE_SIZE);
> 
> ie it overshoots max_segment if it is unaligned.
> 
> It also badly malfunctions if the ALIGN_UP() overflows, eg for
> ALIGN_UP(UINT_MAX).
> 
> This is all internal problems inside __sg_alloc_table_from_pages() and
> has nothing to do with the scatter lists themselves.
> 
> Adding an ALIGN_DOWN guarentees this algorithm produces sg_len <=
> max_segment in all cases.

Right, I can follow the story now that ALIGN_DOWN is in the picture.

>> If the intent is to allow unaligned max_segment then also please
>> change kerneldoc.
> 
> Sure
>   
>> Although TBH I don't get how unaligned max segment makes sense. List
>> can end on an unaligned segment but surely shouldn't have then in
>> the middle.
> 
> The max_segment should either be UINT_MAX because the caller doesn't
> care, or come from the DMA max_segment_size which is a HW limitation
> usually derived from the # of bits available to express a length.
> 
> Conflating the HW limitation with the system PAGE_SIZE is
> nonsense. This is further confused because the only reason we have an
> alignment restriction is due to this algorithm design, the SGL rules
> don't prevent the use of unaligned lengths, or length smaller than
> PAGE_SIZE, even in the interior.
> 
> Jason
> 
>>From b03302028893ce7465ba7e8736abba1922469bc1 Mon Sep 17 00:00:00 2001
> From: Jason Gunthorpe <jgg@nvidia.com>
> Date: Fri, 16 Oct 2020 08:46:01 -0300
> Subject: [PATCH] lib/scatterlist: Do not limit max_segment to PAGE_ALIGNED
>   values
> 
> The main intention of the max_segment argument to
> __sg_alloc_table_from_pages() is to match the DMA layer segment size set
> by dma_set_max_seg_size().
> 
> Restricting the input to be page aligned makes it impossible to just
> connect the DMA layer to this API.
> 
> The only reason for a page alignment here is because the algorithm will
> overshoot the max_segment if it is not a multiple of PAGE_SIZE. Simply fix
> the alignment before starting and don't expose this implementation detail
> to the callers.

What does not make complete sense to me is the statement that input 
alignment requirement makes it impossible to connect to DMA layer, but 
then the patch goes to align behind the covers anyway.

At minimum the kerneldoc should explain that max_segment will still be 
rounded down. But wouldn't it be better for the API to be more explicit 
and just require aligned anyway?

I mean I have no idea what is the problem for connecting to the DMA 
layer. Is it a matter of too many call sites which would need to align? 
Or there is more to it?

> A future patch will completely remove SCATTERLIST_MAX_SEGMENT.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   lib/scatterlist.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> index e102fdfaa75be7..ed2497c79a216b 100644
> --- a/lib/scatterlist.c
> +++ b/lib/scatterlist.c
> @@ -404,7 +404,7 @@ static struct scatterlist *get_next_sg(struct sg_table *table,
>    * @n_pages:	 Number of pages in the pages array
>    * @offset:      Offset from start of the first page to the start of a buffer
>    * @size:        Number of valid bytes in the buffer (after offset)
> - * @max_segment: Maximum size of a scatterlist node in bytes (page aligned)
> + * @max_segment: Maximum size of a scatterlist element in bytes
>    * @prv:	 Last populated sge in sgt
>    * @left_pages:  Left pages caller have to set after this call
>    * @gfp_mask:	 GFP allocation mask
> @@ -435,7 +435,12 @@ struct scatterlist *__sg_alloc_table_from_pages(struct sg_table *sgt,
>   	unsigned int added_nents = 0;
>   	struct scatterlist *s = prv;
>   
> -	if (WARN_ON(!max_segment || offset_in_page(max_segment)))
> +	/*
> +	 * The algorithm below requires max_segment to be aligned to PAGE_SIZE
> +	 * otherwise it can overshoot.
> +	 */
> +	max_segment = ALIGN_DOWN(max_segment, PAGE_SIZE);
> +	if (WARN_ON(max_segment < PAGE_SIZE))

Equivalent to !max_segment or max_segment == 0 now.

And it's a bit weird API - "you can pass in any unaligned size apart 
from unaligned sizes less than a PAGE_SIZE". Makes me think more that 
explicit requirement to pass in page aligned was better.

>   		return ERR_PTR(-EINVAL);
>   
>   	if (IS_ENABLED(CONFIG_ARCH_NO_SG_CHAIN) && prv)
> @@ -542,8 +547,7 @@ int sg_alloc_table_from_pages(struct sg_table *sgt, struct page **pages,
>   			      unsigned long size, gfp_t gfp_mask)
>   {
>   	return PTR_ERR_OR_ZERO(__sg_alloc_table_from_pages(sgt, pages, n_pages,
> -			offset, size, SCATTERLIST_MAX_SEGMENT,
> -			NULL, 0, gfp_mask));
> +			offset, size, UINT_MAX, NULL, 0, gfp_mask));
>   }
>   EXPORT_SYMBOL(sg_alloc_table_from_pages);
>   
> 

Regards,

Tvrtko
