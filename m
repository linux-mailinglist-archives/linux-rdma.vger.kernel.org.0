Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6392E491BF3
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 04:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241852AbiARDM1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jan 2022 22:12:27 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:41692 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352874AbiARDAp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Jan 2022 22:00:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V29pix9_1642474842;
Received: from 30.43.105.202(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V29pix9_1642474842)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Jan 2022 11:00:43 +0800
Message-ID: <33f96f28-ead3-104f-379c-e56f8de8c3f3@linux.alibaba.com>
Date:   Tue, 18 Jan 2022 11:00:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH rdma-next v2 07/11] RDMA/erdma: Add verbs implementation
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
References: <20220117084828.80638-1-chengyou@linux.alibaba.com>
 <20220117084828.80638-8-chengyou@linux.alibaba.com>
 <20220117151510.GC8034@ziepe.ca>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220117151510.GC8034@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/17/22 11:15 PM, Jason Gunthorpe wrote:
> On Mon, Jan 17, 2022 at 04:48:24PM +0800, Cheng Xu wrote:
> 
>> +	entry = to_emmap(rdma_entry);
>> +
>> +	switch (entry->mmap_flag) {
>> +	case ERDMA_MMAP_IO_NC:
>> +		/* map doorbell. */
>> +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> 
> This should be pgprot_device()

Will fix.

> 
>> +		err = io_remap_pfn_range(vma, vma->vm_start, PFN_DOWN(entry->address),
>> +			PAGE_SIZE, vma->vm_page_prot);
>> +		break;
>> +	default:
>> +		pr_err("mmap failed, mmap_flag = %d\n", entry->mmap_flag);
> 
> Audit this whole driver for prints:
>   1) Do not ever print on user spcae triggered paths, like this
>   2) Always use ibdev_dbg/err/etc
> 

I will check for this.

>> +void erdma_disassociate_ucontext(struct ib_ucontext *ibcontext)
>> +{
>> +}
> 
> Does the driver really fully support device disassociation, including
> support to recover from itin rdma-core? Don't define this function otherwise.
> 
> Jason

OK, will remove it.

Thanks,
Cheng Xu,

