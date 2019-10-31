Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 885E3EB61E
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2019 18:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfJaR2R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Oct 2019 13:28:17 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6913 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfJaR2R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Oct 2019 13:28:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dbb19b70000>; Thu, 31 Oct 2019 10:28:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 31 Oct 2019 10:28:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 31 Oct 2019 10:28:16 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 31 Oct
 2019 17:28:12 +0000
Subject: Re: [PATCH v3 3/3] mm/hmm/test: add self tests for HMM
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191023195515.13168-1-rcampbell@nvidia.com>
 <20191023195515.13168-4-rcampbell@nvidia.com>
 <20191029175837.GS22766@mellanox.com>
 <3ffecdc6-625f-ebea-8fb4-984fe6ca90f3@nvidia.com>
 <20191029231255.GX22766@mellanox.com>
 <f42d06e2-ca08-acdd-948d-2803079a13c2@nvidia.com>
 <20191031124200.GJ22766@mellanox.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <a6b49a4e-a194-ce0b-685f-5e597072aeee@nvidia.com>
Date:   Thu, 31 Oct 2019 10:28:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191031124200.GJ22766@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572542903; bh=Wr3SVeuoH5XlM7NZPBlWqcbSTjspk3irIYRvlGi9yaI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=kW174yLMG8IjxnIxZyGrbC9l4pJLEDIfwedwqdfEYw/0iC+ttgHPBJLMZkyCYUOr+
         RmxUpyuuyis4YF6MLdl87jl0c7oyLblhWSadJUmnz1jEpOCgr23NZvbKblPTnLtGgs
         F3C9AzLpFbe7EdbSmOJuem4Dc/OwsHeYevbSFMW2WlRNqRjQ0tLgmrujoxfb20sx1S
         O7fLhLdjM5wM1kN93p9JjJXAvPayJPHH6IpfoERTCjwB492x//hykF6/MCqr0jmn7b
         Q2/7fafKcaLwisg3k/YFqZ32xQkOEgoUivOon5ozWNgTbjxXT0nmbjOPmOykMNz16X
         VpmUH5ZVPU//Q==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/31/19 5:42 AM, Jason Gunthorpe wrote:
> On Wed, Oct 30, 2019 at 05:14:30PM -0700, Ralph Campbell wrote:
> 
>>> Well, that is good, is it also under drivers/char? It kind feels like
>>> it should not be there...
>>
>> I think most of the test modules live in lib/ but I wasn't sure that
>> was the right place for the HMM test driver.
>> If you think that is better, I can easily move it.
> 
> It would be good to get the various test people involved in this, I
> really don't know.

OK.
  
>>>>> It seems especially over-complicated to use a full page table layout
>>>>> for this, wouldn't something simple like an xarray be good enough for
>>>>> test purposes?
>>>>
>>>> Possibly. A page table is really just a lookup table from virtual address
>>>> to pfn/page. Part of the rationale was to mimic what a real device
>>>> might do.
>>>
>>> Well, but the details of the page table layout don't see really
>>> important to this testing, IMHO.
>>
>> One problem with XArray is that on 32-bit machines the value would
>> need to be u64 to hold a pfn which won't fit in a ULONG_MAX.
>> I guess we could make the driver 64-bit only.
> 
> Why would a 32 bit machine need a 64 bit pfn?
> 
> Jason
> 

On x86, Physical Address Extension (PAE) uses a 64 bit PTE.
See arch/x86/include/asm/pgtable_32_types.h which includes
arch/x86/include/asm/pgtable-3level_types.h.
