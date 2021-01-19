Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2892FAE50
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 02:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391918AbhASB1w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 20:27:52 -0500
Received: from mail-1.ca.inter.net ([208.85.220.69]:53424 "EHLO
        mail-1.ca.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731837AbhASB1v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 20:27:51 -0500
Received: from localhost (offload-3.ca.inter.net [208.85.220.70])
        by mail-1.ca.inter.net (Postfix) with ESMTP id 27C9A2EA06F;
        Mon, 18 Jan 2021 20:27:10 -0500 (EST)
Received: from mail-1.ca.inter.net ([208.85.220.69])
        by localhost (offload-3.ca.inter.net [208.85.220.70]) (amavisd-new, port 10024)
        with ESMTP id jAEqzhtktl6J; Mon, 18 Jan 2021 20:13:33 -0500 (EST)
Received: from [192.168.48.23] (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail-1.ca.inter.net (Postfix) with ESMTPSA id 77EAC2EA02A;
        Mon, 18 Jan 2021 20:27:09 -0500 (EST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v6 1/4] sgl_alloc_order: remove 4 GiB limit, sgl_free()
 warning
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bodo Stroesser <bostroesser@gmail.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, ddiss@suse.de, bvanassche@acm.org
References: <20210118163006.61659-1-dgilbert@interlog.com>
 <20210118163006.61659-2-dgilbert@interlog.com>
 <20210118182854.GJ4605@ziepe.ca>
 <59707b66-0b6c-b397-82fe-5ad6a6f99ba1@interlog.com>
 <20210118202431.GO4605@ziepe.ca>
 <7f443666-b210-6f99-7b50-6c26d87fa7ca@gmail.com>
 <20210118234818.GP4605@ziepe.ca>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <770a562e-52b9-ba93-59d3-1026340bf4f3@interlog.com>
Date:   Mon, 18 Jan 2021 20:27:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210118234818.GP4605@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021-01-18 6:48 p.m., Jason Gunthorpe wrote:
> On Mon, Jan 18, 2021 at 10:22:56PM +0100, Bodo Stroesser wrote:
>> On 18.01.21 21:24, Jason Gunthorpe wrote:
>>> On Mon, Jan 18, 2021 at 03:08:51PM -0500, Douglas Gilbert wrote:
>>>> On 2021-01-18 1:28 p.m., Jason Gunthorpe wrote:
>>>>> On Mon, Jan 18, 2021 at 11:30:03AM -0500, Douglas Gilbert wrote:
>>>>>
>>>>>> After several flawed attempts to detect overflow, take the fastest
>>>>>> route by stating as a pre-condition that the 'order' function argument
>>>>>> cannot exceed 16 (2^16 * 4k = 256 MiB).
>>>>>
>>>>> That doesn't help, the point of the overflow check is similar to
>>>>> overflow checks in kcalloc: to prevent the routine from allocating
>>>>> less memory than the caller might assume.
>>>>>
>>>>> For instance ipr_store_update_fw() uses request_firmware() (which is
>>>>> controlled by userspace) to drive the length argument to
>>>>> sgl_alloc_order(). If userpace gives too large a value this will
>>>>> corrupt kernel memory.
>>>>>
>>>>> So this math:
>>>>>
>>>>>      	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);
>>>>
>>>> But that check itself overflows if order is too large (e.g. 65).
>>>
>>> I don't reall care about order. It is always controlled by the kernel
>>> and it is fine to just require it be low enough to not
>>> overflow. length is the data under userspace control so math on it
>>> must be checked for overflow.
>>>
>>>> Also note there is another pre-condition statement in that function's
>>>> definition, namely that length cannot be 0.
>>>
>>> I don't see callers checking for that either, if it is true length 0
>>> can't be allowed it should be blocked in the function
>>>
>>> Jason
>>>
>>
>> A already said, I also think there should be a check for length or
>> rather nent overflow.
>>
>> I like the easy to understand check in your proposed code:
>>
>> 	if (length >> (PAGE_SHIFT + order) >= UINT_MAX)
>> 		return NULL;
>>
>>
>> But I don't understand, why you open-coded the nent calculation:
>>
>> 	nent = length >> (PAGE_SHIFT + order);
>> 	if (length & ((1ULL << (PAGE_SHIFT + order)) - 1))
>> 		nent++;
> 
> It is necessary to properly check for overflow, because the easy to
> understand check doesn't prove that round_up will work, only that >>
> results in something that fits in an int and that +1 won't overflow
> the int.
> 
>> Wouldn't it be better to keep the original line instead:
>>
>> 	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);
> 
> This can overflow inside the round_up

To protect against the "unsigned long long" length being too big why
not pick a large power of two and if someone can justify a larger
value, they can send a patch.

         if (length > 64ULL * 1024 * 1024 * 1024)
		return NULL;

So 64 GiB or a similar calculation involving PAGE_SIZE. Compiler does
the multiplication and at run time there is only a 64 bit comparison.


I tested 6 one GiB ramdisks on an 8 GiB machine, worked fine until
firefox was started. Then came the OOM killer ...

Doug Gilbert

