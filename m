Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29C5AEA81B
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2019 01:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfJaAOg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Oct 2019 20:14:36 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17399 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfJaAOf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Oct 2019 20:14:35 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dba276f0000>; Wed, 30 Oct 2019 17:14:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 30 Oct 2019 17:14:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 30 Oct 2019 17:14:33 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 31 Oct
 2019 00:14:31 +0000
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
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <f42d06e2-ca08-acdd-948d-2803079a13c2@nvidia.com>
Date:   Wed, 30 Oct 2019 17:14:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191029231255.GX22766@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572480879; bh=aQDvoiizFwVElu/+JB2LeJEv2uD96Wkmo0qAhVBooQc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=MWJCdQBYV5wFB7p92/YoCvnFMvaW5Z0IBrW0xE5hxmWN/aZqJV2A1iGIWrIIsAsV8
         5VbUwe/ni8bh+UdPANC3o40XMQmti2jPniyG+kfKXopV2o92ZsH5WErJY0bTCkzbaq
         Uv2d9ejyWGNHiGyn+USoMYCdZGkZjaf1R1TKpH3UAg2J2+/Vihh1G5u/xoT1MrefGQ
         afjBFP8F4s4qdv4EK4vntC3rY/27ToshvjCbJrew79wgoor/yef38armEhFyhEvIAO
         ruemKtXzYLn3lyFMiFLsaf9rlg03HrmcImjcDUjHfi1/TdGEdrlMlA1xfixlHdVgdW
         DsWeazFXfVoKA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/29/19 4:12 PM, Jason Gunthorpe wrote:
> On Tue, Oct 29, 2019 at 02:16:05PM -0700, Ralph Campbell wrote:
> 
>>> Frankly, I'm not super excited about the idea of a 'test driver', it
>>> seems more logical for testing to have some way for a test harness to
>>> call hmm_range_fault() under various conditions and check the results?
>>
>> test_vmalloc.sh at least uses a test module(s).
> 
> Well, that is good, is it also under drivers/char? It kind feels like
> it should not be there...

I think most of the test modules live in lib/ but I wasn't sure that
was the right place for the HMM test driver.
If you think that is better, I can easily move it.

>>> It seems especially over-complicated to use a full page table layout
>>> for this, wouldn't something simple like an xarray be good enough for
>>> test purposes?
>>
>> Possibly. A page table is really just a lookup table from virtual address
>> to pfn/page. Part of the rationale was to mimic what a real device
>> might do.
> 
> Well, but the details of the page table layout don't see really
> important to this testing, IMHO.

One problem with XArray is that on 32-bit machines the value would
need to be u64 to hold a pfn which won't fit in a ULONG_MAX.
I guess we could make the driver 64-bit only.

>>>> +	for (addr = start; addr < end; ) {
>>>> +		long count;
>>>> +
>>>> +		next = min(addr + (ARRAY_SIZE(pfns) << PAGE_SHIFT), end);
>>>> +		range.start = addr;
>>>> +		range.end = next;
>>>> +
>>>> +		down_read(&mm->mmap_sem);
> 
> Also, did we get a mmget() before doing this down_read?
> 
>>>> +
>>>> +		ret = hmm_range_register(&range, &dmirror->mirror);
>>>> +		if (ret) {
>>>> +			up_read(&mm->mmap_sem);
>>>> +			break;
>>>> +		}
>>>> +
>>>> +		if (!hmm_range_wait_until_valid(&range,
>>>> +						DMIRROR_RANGE_FAULT_TIMEOUT)) {
>>>> +			hmm_range_unregister(&range);
>>>> +			up_read(&mm->mmap_sem);
>>>> +			continue;
>>>> +		}
>>>> +
>>>> +		count = hmm_range_fault(&range, 0);
>>>> +		if (count < 0) {
>>>> +			ret = count;
>>>> +			hmm_range_unregister(&range);
>>>> +			up_read(&mm->mmap_sem);
>>>> +			break;
>>>> +		}
>>>> +
>>>> +		if (!hmm_range_valid(&range)) {
>>>
>>> There is no 'driver lock' being held here, how does this work?
>>> Shouldn't it hold dmirror->mutex for this sequence?
>>
>> I have a modified version of this driver that's based on your series
>> removing hmm_mirror_register() which uses a mutex.
>> Otherwise, it looks similar to the changes in nouveau.
> 
> Well, that locking pattern is required even for original hmm calls..

Will be fixed in v4.

> 
>>>> +static int dmirror_read(struct dmirror *dmirror,
>>>> +			struct hmm_dmirror_cmd *cmd)
>>>> +{
>>>
>>> Why not just use pread()/pwrite() for this instead of an ioctl?
>>
>> pread()/pwrite() could certainly be implemented.
>> I think the idea was that the read/write is actually the "device"
>> doing read/write and making that clearly different from a program
>> reading/writing the device. Also, the ioctl() allows information
>> about what faults or events happened during the operation. I only
>> have number of pages and number of page faults returned at the moment,
>> but one of Jerome's version of this driver had other counters being
>> returned.
> 
> Makes sense I guess
> 
>>>> +static struct platform_driver dmirror_device_driver = {
>>>> +	.probe		= dmirror_probe,
>>>> +	.remove		= dmirror_remove,
>>>> +	.driver		= {
>>>> +		.name	= "HMM_DMIRROR",
>>>> +	},
>>>> +};
>>>
>>> This presence of a platform_driver and device is very confusing. I'm
>>> sure Greg KH would object to this as a misuse of platform drivers.
>>>
>>> A platform device isn't needed to create a char dev, so what is this for?
>>
>> The devm_request_free_mem_region() and devm_memremap_pages() calls for
>> creating the ZONE_DEVICE private pages tie into the devm* clean up framework.
>> I thought a platform_driver was the simplest way to also be able to call
>> devm_add_action_or_reset() to clean up on module unload and be compatible
>> with the private page clean up.
> 
> IIRC Christoph recently fixed things so there was a non devm version
> of these functions. Certainly we should not be making fake
> platform_devices just to call devm.
> 
> There is also a struct device inside the cdev, maybe that could be
> arrange to be devm compatible if it was *really* needed.

Will be fixed in v4.

>>>> diff --git a/include/Kbuild b/include/Kbuild
>>>> index ffba79483cc5..6ffb44a45957 100644
>>>> +++ b/include/Kbuild
>>>> @@ -1063,6 +1063,7 @@ header-test-			+= uapi/linux/coda_psdev.h
>>>>    header-test-			+= uapi/linux/errqueue.h
>>>>    header-test-			+= uapi/linux/eventpoll.h
>>>>    header-test-			+= uapi/linux/hdlc/ioctl.h
>>>> +header-test-			+= uapi/linux/hmm_dmirror.h
>>>
>>> Why? This list should only be updated if the header is broken in some
>>> way.
>>
>> Should this be in include/linux/ instead?
>> I wasn't sure where the "right" place was to put the header.
> 
> No, it is right, it just shouldn't be in this makefile.
> 
> Jason

Will be fixed in v4.

Thanks for the review, the code is much simpler now.
