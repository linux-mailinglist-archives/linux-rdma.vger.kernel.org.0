Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A74E919C
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 22:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfJ2VQN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 17:16:13 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9532 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfJ2VQM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Oct 2019 17:16:12 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5db8ac200003>; Tue, 29 Oct 2019 14:16:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 29 Oct 2019 14:16:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 29 Oct 2019 14:16:10 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Oct
 2019 21:16:10 +0000
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Tue, 29 Oct 2019 21:16:05 +0000
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
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <3ffecdc6-625f-ebea-8fb4-984fe6ca90f3@nvidia.com>
Date:   Tue, 29 Oct 2019 14:16:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191029175837.GS22766@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572383776; bh=jKaEFCmOoMgHXTBCeC7dsZnc0RV2XGykrf6wIgLBhoE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=F7lwbcYsgq3EecVrClNnQaMUTvl8jlGfJX2P6MecIRWcQvwqutTO1hntP4kLrgswg
         Jy4S+sHjqVtFy26qn2ZMc+GMH1sdAMzKxFcQvleOVT2KlamnvTDtjEsfCUJyMic9sq
         03Xk0TIUiiYSwHEn3vS4tBCtXB9/qVzR53jQiPkQiD2FocAWcCnW0+grHrIPeWIy05
         zov+AsgzBYHj3XQgbMkNSETkOZlVjQasNu5HC7fGDHa6DgUuZ2ILEuWawx7WN3iRsV
         xyu/7S3wkLRiB9t06KDnZG/7Wy7quixhrMl5IN3Axv1JUXSFUAAFzD/ASDdwADzFeA
         kLsQkNOdLC/HQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/29/19 10:58 AM, Jason Gunthorpe wrote:
> On Wed, Oct 23, 2019 at 12:55:15PM -0700, Ralph Campbell wrote:
>> Add self tests for HMM.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> 
>> ---
>>   MAINTAINERS                            |    3 +
>>   drivers/char/Kconfig                   |   11 +
>>   drivers/char/Makefile                  |    1 +
>>   drivers/char/hmm_dmirror.c             | 1566 ++++++++++++++++++++++++
>>   include/Kbuild                         |    1 +
>>   include/uapi/linux/hmm_dmirror.h       |   74 ++
>>   tools/testing/selftests/vm/.gitignore  |    1 +
>>   tools/testing/selftests/vm/Makefile    |    3 +
>>   tools/testing/selftests/vm/config      |    3 +
>>   tools/testing/selftests/vm/hmm-tests.c | 1311 ++++++++++++++++++++
>>   tools/testing/selftests/vm/run_vmtests |   16 +
>>   tools/testing/selftests/vm/test_hmm.sh |   97 ++
>>   12 files changed, 3087 insertions(+)
>>   create mode 100644 drivers/char/hmm_dmirror.c
>>   create mode 100644 include/uapi/linux/hmm_dmirror.h
>>   create mode 100644 tools/testing/selftests/vm/hmm-tests.c
>>   create mode 100755 tools/testing/selftests/vm/test_hmm.sh
> 
> This is really big, it would be nice to get a comment from the various
> kernel testing folks if this approach makes sense with the test
> frameworks. Do we have other drivers that are only intended to be used
> by selftests?
> 
> Frankly, I'm not super excited about the idea of a 'test driver', it
> seems more logical for testing to have some way for a test harness to
> call hmm_range_fault() under various conditions and check the results?

test_vmalloc.sh at least uses a test module(s).

> It seems especially over-complicated to use a full page table layout
> for this, wouldn't something simple like an xarray be good enough for
> test purposes?

Possibly. A page table is really just a lookup table from virtual address
to pfn/page. Part of the rationale was to mimic what a real device might do.


>> +/*
>> + * Below are the file operation for the dmirror device file. Only ioctl matters.
>> + *
>> + * Note this is highly specific to the dmirror device driver and should not be
>> + * construed as an example on how to design the API a real device driver would
>> + * expose to userspace.
>> + */
>> +static ssize_t dmirror_fops_read(struct file *filp,
>> +			       char __user *buf,
>> +			       size_t count,
>> +			       loff_t *ppos)
>> +{
>> +	return -EINVAL;
>> +}
>> +
>> +static ssize_t dmirror_fops_write(struct file *filp,
>> +				const char __user *buf,
>> +				size_t count,
>> +				loff_t *ppos)
>> +{
>> +	return -EINVAL;
>> +}
>> +
>> +static int dmirror_fops_mmap(struct file *filp, struct vm_area_struct *vma)
>> +{
>> +	/* Forbid mmap of the dmirror device file. */
>> +	return -EINVAL;
>> +}
> 
> I'm pretty sure these can just be left as NULL in the fops?

I think so.

>> +static int dmirror_fault(struct dmirror *dmirror,
>> +			 unsigned long start,
>> +			 unsigned long end,
>> +			 bool write)
>> +{
>> +	struct mm_struct *mm = dmirror->mirror.hmm->mmu_notifier.mm;
>> +	unsigned long addr;
>> +	unsigned long next;
>> +	uint64_t pfns[64];
>> +	struct hmm_range range = {
>> +		.pfns = pfns,
>> +		.flags = dmirror_hmm_flags,
>> +		.values = dmirror_hmm_values,
>> +		.pfn_shift = DPT_SHIFT,
>> +		.pfn_flags_mask = ~(dmirror_hmm_flags[HMM_PFN_VALID] |
>> +				    dmirror_hmm_flags[HMM_PFN_WRITE]),
>> +		.default_flags = dmirror_hmm_flags[HMM_PFN_VALID] |
>> +				(write ? dmirror_hmm_flags[HMM_PFN_WRITE] : 0),
>> +	};
>> +	int ret = 0;
>> +
>> +	for (addr = start; addr < end; ) {
>> +		long count;
>> +
>> +		next = min(addr + (ARRAY_SIZE(pfns) << PAGE_SHIFT), end);
>> +		range.start = addr;
>> +		range.end = next;
>> +
>> +		down_read(&mm->mmap_sem);
>> +
>> +		ret = hmm_range_register(&range, &dmirror->mirror);
>> +		if (ret) {
>> +			up_read(&mm->mmap_sem);
>> +			break;
>> +		}
>> +
>> +		if (!hmm_range_wait_until_valid(&range,
>> +						DMIRROR_RANGE_FAULT_TIMEOUT)) {
>> +			hmm_range_unregister(&range);
>> +			up_read(&mm->mmap_sem);
>> +			continue;
>> +		}
>> +
>> +		count = hmm_range_fault(&range, 0);
>> +		if (count < 0) {
>> +			ret = count;
>> +			hmm_range_unregister(&range);
>> +			up_read(&mm->mmap_sem);
>> +			break;
>> +		}
>> +
>> +		if (!hmm_range_valid(&range)) {
> 
> There is no 'driver lock' being held here, how does this work?
> Shouldn't it hold dmirror->mutex for this sequence?

I have a modified version of this driver that's based on your series
removing hmm_mirror_register() which uses a mutex.
Otherwise, it looks similar to the changes in nouveau.

>> +			hmm_range_unregister(&range);
>> +			up_read(&mm->mmap_sem);
>> +			continue;
>> +		}
>> +		mutex_lock(&dmirror->mutex);
>> +		ret = dmirror_pt_walk(dmirror, dmirror_do_fault,
>> +				      addr, next, &range, true);
>> +		mutex_unlock(&dmirror->mutex);
> 
> Ie move it down into this block
> 
>> +		hmm_range_unregister(&range);
>> +		up_read(&mm->mmap_sem);
>> +		if (ret)
>> +			break;
>> +
>> +		addr = next;
>> +	}
>> +
>> +	return ret;
>> +}
> 
>> +static int dmirror_read(struct dmirror *dmirror,
>> +			struct hmm_dmirror_cmd *cmd)
>> +{
> 
> Why not just use pread()/pwrite() for this instead of an ioctl?

pread()/pwrite() could certainly be implemented.
I think the idea was that the read/write is actually the "device"
doing read/write and making that clearly different from a program
reading/writing the device. Also, the ioctl() allows information
about what faults or events happened during the operation. I only
have number of pages and number of page faults returned at the moment,
but one of Jerome's version of this driver had other counters being
returned.

>> +	struct dmirror_bounce bounce;
>> +	unsigned long start, end;
>> +	unsigned long size = cmd->npages << PAGE_SHIFT;
>> +	int ret;
>> +
>> +	start = cmd->addr;
>> +	end = start + size;
>> +	if (end < start)
>> +		return -EINVAL;
>> +
>> +	ret = dmirror_bounce_init(&bounce, start, size);
>> +	if (ret)
>> +		return ret;
>> +
>> +static int dmirror_snapshot(struct dmirror *dmirror,
>> +			    struct hmm_dmirror_cmd *cmd)
>> +{
>> +	struct mm_struct *mm = dmirror->mirror.hmm->mmu_notifier.mm;
>> +	unsigned long start, end;
>> +	unsigned long size = cmd->npages << PAGE_SHIFT;
>> +	unsigned long addr;
>> +	unsigned long next;
>> +	uint64_t pfns[64];
>> +	unsigned char perm[64];
>> +	char __user *uptr;
>> +	struct hmm_range range = {
>> +		.pfns = pfns,
>> +		.flags = dmirror_hmm_flags,
>> +		.values = dmirror_hmm_values,
>> +		.pfn_shift = DPT_SHIFT,
>> +		.pfn_flags_mask = ~0ULL,
>> +	};
>> +	int ret = 0;
>> +
>> +	start = cmd->addr;
>> +	end = start + size;
>> +	uptr = (void __user *)cmd->ptr;
>> +
>> +	for (addr = start; addr < end; ) {
>> +		long count;
>> +		unsigned long i;
>> +		unsigned long n;
>> +
>> +		next = min(addr + (ARRAY_SIZE(pfns) << PAGE_SHIFT), end);
>> +		range.start = addr;
>> +		range.end = next;
>> +
>> +		down_read(&mm->mmap_sem);
>> +
>> +		ret = hmm_range_register(&range, &dmirror->mirror);
>> +		if (ret) {
>> +			up_read(&mm->mmap_sem);
>> +			break;
>> +		}
>> +
>> +		if (!hmm_range_wait_until_valid(&range,
>> +						DMIRROR_RANGE_FAULT_TIMEOUT)) {
>> +			hmm_range_unregister(&range);
>> +			up_read(&mm->mmap_sem);
>> +			continue;
>> +		}
>> +
>> +		count = hmm_range_fault(&range, HMM_FAULT_SNAPSHOT);
>> +		if (count < 0) {
>> +			ret = count;
>> +			hmm_range_unregister(&range);
>> +			up_read(&mm->mmap_sem);
>> +			if (ret == -EBUSY)
>> +				continue;
>> +			break;
>> +		}
>> +
>> +		if (!hmm_range_valid(&range)) {
> 
> Same as for dmirror_fault
> 
>> +			hmm_range_unregister(&range);
>> +			up_read(&mm->mmap_sem);
>> +			continue;
>> +		}
>> +
>> +		n = (next - addr) >> PAGE_SHIFT;
>> +		for (i = 0; i < n; i++)
>> +			dmirror_mkentry(dmirror, &range, perm + i, pfns[i]);
> 
> Is this missing locking too?

Yes. It's in the updated version as mentioned above.

>> +static int dmirror_remove(struct platform_device *pdev)
>> +{
>> +	/* all probe actions are unwound by devm */
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver dmirror_device_driver = {
>> +	.probe		= dmirror_probe,
>> +	.remove		= dmirror_remove,
>> +	.driver		= {
>> +		.name	= "HMM_DMIRROR",
>> +	},
>> +};
> 
> This presence of a platform_driver and device is very confusing. I'm
> sure Greg KH would object to this as a misuse of platform drivers.
> 
> A platform device isn't needed to create a char dev, so what is this for?

The devm_request_free_mem_region() and devm_memremap_pages() calls for
creating the ZONE_DEVICE private pages tie into the devm* clean up framework.
I thought a platform_driver was the simplest way to also be able to call
devm_add_action_or_reset() to clean up on module unload and be compatible
with the private page clean up.

>> diff --git a/include/Kbuild b/include/Kbuild
>> index ffba79483cc5..6ffb44a45957 100644
>> --- a/include/Kbuild
>> +++ b/include/Kbuild
>> @@ -1063,6 +1063,7 @@ header-test-			+= uapi/linux/coda_psdev.h
>>   header-test-			+= uapi/linux/errqueue.h
>>   header-test-			+= uapi/linux/eventpoll.h
>>   header-test-			+= uapi/linux/hdlc/ioctl.h
>> +header-test-			+= uapi/linux/hmm_dmirror.h
> 
> Why? This list should only be updated if the header is broken in some
> way.

Should this be in include/linux/ instead?
I wasn't sure where the "right" place was to put the header.

> 
>> diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftests/vm/hmm-tests.c
>> new file mode 100644
>> index 000000000000..f4ae6188fd0e
>> --- /dev/null
>> +++ b/tools/testing/selftests/vm/hmm-tests.c
>> @@ -0,0 +1,1311 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2013 Red Hat Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation; either version 2 of
>> + * the License, or (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
> 
> btw, I think if a SPDX is present I don't think the license text is
> required, just the copyright.

Since I was starting from Jerome's HMM test driver, I didn't want to
delete any of the original copyright text.
If Jerome is OK with just the SPDX header, that's OK with me.

> I think these tests should also study the various case of invoke
> pte_hole, ie faulting/snappshotting before/after a vma, or across a
> vma range with a hole, etc, etc.
> 
> Jason
> 

There are tests for vma hole, pte_none(), zero page, and normal page.
Nothing stress testing races, just set up the mmap() and test once.
I can add more test cases if you have something specific in mind.
