Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BEA2F042F
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Jan 2021 23:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbhAIW7e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Jan 2021 17:59:34 -0500
Received: from mail-1.ca.inter.net ([208.85.220.69]:59948 "EHLO
        mail-1.ca.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbhAIW7e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 9 Jan 2021 17:59:34 -0500
Received: from localhost (offload-3.ca.inter.net [208.85.220.70])
        by mail-1.ca.inter.net (Postfix) with ESMTP id 3EEB82EA491;
        Sat,  9 Jan 2021 17:58:52 -0500 (EST)
Received: from mail-1.ca.inter.net ([208.85.220.69])
        by localhost (offload-3.ca.inter.net [208.85.220.70]) (amavisd-new, port 10024)
        with ESMTP id leBru8RgDJjg; Sat,  9 Jan 2021 17:45:52 -0500 (EST)
Received: from [192.168.48.23] (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail-1.ca.inter.net (Postfix) with ESMTPSA id 400562EA023;
        Sat,  9 Jan 2021 17:58:51 -0500 (EST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v5 1/4] sgl_alloc_order: remove 4 GiB limit, sgl_free()
 warning
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, bostroesser@gmail.com, bvanassche@acm.org,
        ddiss@suse.de
References: <20201228234955.190858-1-dgilbert@interlog.com>
 <20201228234955.190858-2-dgilbert@interlog.com>
 <20210107174410.GB504133@ziepe.ca>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <76827f07-9484-d2c6-346b-0bdccfdf4a7a@interlog.com>
Date:   Sat, 9 Jan 2021 17:58:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210107174410.GB504133@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021-01-07 12:44 p.m., Jason Gunthorpe wrote:
> On Mon, Dec 28, 2020 at 06:49:52PM -0500, Douglas Gilbert wrote:
>> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
>> index a59778946404..4986545beef9 100644
>> +++ b/lib/scatterlist.c
>> @@ -554,13 +554,15 @@ EXPORT_SYMBOL(sg_alloc_table_from_pages);
>>   #ifdef CONFIG_SGL_ALLOC
>>   
>>   /**
>> - * sgl_alloc_order - allocate a scatterlist and its pages
>> + * sgl_alloc_order - allocate a scatterlist with equally sized elements
>>    * @length: Length in bytes of the scatterlist. Must be at least one
>> - * @order: Second argument for alloc_pages()
>> + * @order: Second argument for alloc_pages(). Each sgl element size will
>> + *	   be (PAGE_SIZE*2^order) bytes
>>    * @chainable: Whether or not to allocate an extra element in the scatterlist
>> - *	for scatterlist chaining purposes
>> + *	       for scatterlist chaining purposes
>>    * @gfp: Memory allocation flags
>> - * @nent_p: [out] Number of entries in the scatterlist that have pages
>> + * @nent_p: [out] Number of entries in the scatterlist that have pages.
>> + *		  Ignored if NULL is given.
>>    *
>>    * Returns: A pointer to an initialized scatterlist or %NULL upon failure.
>>    */
>> @@ -574,8 +576,8 @@ struct scatterlist *sgl_alloc_order(unsigned long long length,
>>   	u32 elem_len;
>>   
>>   	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);
>> -	/* Check for integer overflow */
>> -	if (length > (nent << (PAGE_SHIFT + order)))
>> +	/* Integer overflow if:  length > nent*2^(PAGE_SHIFT+order) */
>> +	if (ilog2(length) > ilog2(nent) + PAGE_SHIFT + order)
>>   		return NULL;
>>   	nalloc = nent;
>>   	if (chainable) {
> 
> This is a little bit too tortured now, how about this:
> 
> 	if (length >> (PAGE_SHIFT + order) >= UINT_MAX)
> 		return NULL;
> 	nent = length >> (PAGE_SHIFT + order);
> 	if (length & ((1ULL << (PAGE_SHIFT + order)) - 1))
> 		nent++;
> 
> 	if (chainable) {
> 		if (check_add_overflow(nent, 1, &nalloc))
> 			return NULL;
> 	}
> 	else
> 		nalloc = nent;
> 

And your proposal is less <<tortured>> ?

I'm looking at performance, not elegance and I'm betting that two
ilog2() calls [which boil down to ffs()] are faster than two
right-shift-by-n_s and one left-shift-by-n . Perhaps an extra comment
could help my code by noting that mathematically:
   /* if n > m for positive n and m then: log(n) > log(m) */

My original preference was to drop the check all together but Bart
Van Assche (who wrote that function) wanted me to keep it. Any
function that takes 'order' (i.e. an exponent) can blow up given
a silly value.


The chainable check_add_overflow() call is new and an improvement.

Doug Gilbert
