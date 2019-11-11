Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B397F8267
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Nov 2019 22:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKKVoJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Nov 2019 16:44:09 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9312 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfKKVoI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Nov 2019 16:44:08 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc9d5ea0000>; Mon, 11 Nov 2019 13:43:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 Nov 2019 13:44:08 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 Nov 2019 13:44:08 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Nov
 2019 21:44:07 +0000
Subject: Re: [PATCH 1/1] IB/umem: use get_user_pages_fast() to pin DMA pages
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20191109020434.389855-1-jhubbard@nvidia.com>
 <20191109020434.389855-2-jhubbard@nvidia.com>
 <20191111032111.GA30123@iweiny-DESK2.sc.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <1730ced5-a280-1825-54fe-61b9340f8ac6@nvidia.com>
Date:   Mon, 11 Nov 2019 13:44:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191111032111.GA30123@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573508586; bh=yieNXEWI2py9mI29IscrDXJH38weu1ilyh60Q2W8ILg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JjTN4WKJKNmGnmx0Ulub6NGPQ+dTDSHthvdAaABKuIKi5DQxmHuxZaBwqfxJBaEgs
         6skuSdfqoL9H6AcvRF0VgBGA2jdfUsmrGtQFiwnZMJW0Zamo5LVsIqGsi2qLpptu+L
         RDXRE6hmfQGYZOfR0T8pFLWAUXk/+KM7k1QQpHhRLgsQtZBCE/oGidV/vbcIATvpBn
         66Rr/yI7VXRJjdVCWaQGOTOmAxs3kcDwbfXhY2z2wRPfuzEGtVY9c2BxlwRxv1T3bb
         zBnwTH8LRmI3fay5kjUkkBTmP5NXnDRRGa8tgHrvw74cPxKv/Wb3Mu6KtvWPGNxt5Y
         wjBZxXvUu1zlg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/10/19 7:21 PM, Ira Weiny wrote:
> On Fri, Nov 08, 2019 at 06:04:34PM -0800, John Hubbard wrote:
>> And get rid of the mmap_sem calls, as part of that. Note
>> that get_user_pages_fast() will, if necessary, fall back to
>> __gup_longterm_unlocked(), which takes the mmap_sem as needed.
>>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: Ira Weiny <ira.weiny@intel.com>
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 

Thanks for the review, Ira! This will show up shortly, in the v3
series of "mm/gup: track dma-pinned pages: FOLL_PIN, FOLL_LONGTERM".


thanks,
-- 
John Hubbard
NVIDIA

>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>  drivers/infiniband/core/umem.c | 17 ++++++-----------
>>  1 file changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
>> index 24244a2f68cc..3d664a2539eb 100644
>> --- a/drivers/infiniband/core/umem.c
>> +++ b/drivers/infiniband/core/umem.c
>> @@ -271,16 +271,13 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
>>  	sg = umem->sg_head.sgl;
>>  
>>  	while (npages) {
>> -		down_read(&mm->mmap_sem);
>> -		ret = get_user_pages(cur_base,
>> -				     min_t(unsigned long, npages,
>> -					   PAGE_SIZE / sizeof (struct page *)),
>> -				     gup_flags | FOLL_LONGTERM,
>> -				     page_list, NULL);
>> -		if (ret < 0) {
>> -			up_read(&mm->mmap_sem);
>> +		ret = get_user_pages_fast(cur_base,
>> +					  min_t(unsigned long, npages,
>> +						PAGE_SIZE /
>> +						sizeof(struct page *)),
>> +					  gup_flags | FOLL_LONGTERM, page_list);
>> +		if (ret < 0)
>>  			goto umem_release;
>> -		}
>>  
>>  		cur_base += ret * PAGE_SIZE;
>>  		npages   -= ret;
>> @@ -288,8 +285,6 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
>>  		sg = ib_umem_add_sg_table(sg, page_list, ret,
>>  			dma_get_max_seg_size(context->device->dma_device),
>>  			&umem->sg_nents);
>> -
>> -		up_read(&mm->mmap_sem);
>>  	}
>>  
>>  	sg_mark_end(sg);
>> -- 
>> 2.24.0
>>
> 
