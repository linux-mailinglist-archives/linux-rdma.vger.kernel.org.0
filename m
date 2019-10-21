Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA50CDF6CB
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 22:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfJUUdC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 16:33:02 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12450 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUUdC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 16:33:02 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dae16070003>; Mon, 21 Oct 2019 13:33:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 21 Oct 2019 13:33:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 21 Oct 2019 13:33:01 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Oct
 2019 20:33:01 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Oct
 2019 20:32:59 +0000
Subject: Re: [PATCH v2 1/3] mm/hmm: make full use of walk_page_range()
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20191015204814.30099-1-rcampbell@nvidia.com>
 <20191015204814.30099-2-rcampbell@nvidia.com>
 <20191021183220.GF6285@mellanox.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <5692b090-353f-b784-b4f3-0591c40f23be@nvidia.com>
Date:   Mon, 21 Oct 2019 13:32:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191021183220.GF6285@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571689991; bh=pmC8cc9rEY+1OzsfEoomNsQPfpLKPCm66Zn9A4x/2Bo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=WDYWXPDAIgDSA0Ncrpz4rXzOVNQiKSNfbrNEBYZnCV9OrSe2Xg0V8cXskMqgratXX
         L8wPqxnh35udAFbgHh1RfyE1pK2sBasjTTSVTTnABNqmOnBHor0JBbzX6XjYb9TuEI
         h9NQI4EaroYUyM9a/yLwv+kDhqi5pNMKB4hvBvybpIQTnIbwQu0SvYRnkPy/Gwn+Sf
         b/TO58jNsrOUWfs4+BjFPLx1nTorlzJUd8vfuZJRHP8agLi1yLK8xoT1rU9UQKYIBx
         TX926uk5wmdedUnIUHzRqaKRVrK6UWMBUyhH/A1QJH4NrICgIt7X4x8dMYMMgoJbiu
         Bv5/xUhHQ1fXA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/21/19 11:32 AM, Jason Gunthorpe wrote:
> On Tue, Oct 15, 2019 at 01:48:12PM -0700, Ralph Campbell wrote:
> 
>> +static bool hmm_range_needs_fault(unsigned long addr, unsigned long end,
>> +				  const struct hmm_vma_walk *hmm_vma_walk)
> 
> This has a very similar name to hmm_range_need_fault(), and seems like
> it does the same thing?

The two functions are very similar but not identical.
I guess I could resolve the differences and use one function.

>> +static int hmm_vma_walk_test(unsigned long start, unsigned long end,
>> +			     struct mm_walk *walk)
>> +{
>> +	struct hmm_vma_walk *hmm_vma_walk = walk->private;
>> +	struct hmm_range *range = hmm_vma_walk->range;
>> +	struct vm_area_struct *vma = walk->vma;
>> +
>> +	/* If range is no longer valid, force retry. */
>> +	if (!range->valid)
>> +		return -EBUSY;
>> +
>> +	/*
>> +	 * Skip vma ranges that don't have struct page backing them or
>> +	 * map I/O devices directly.
>> +	 */
>> +	if (vma->vm_flags & (VM_IO | VM_PFNMAP | VM_MIXEDMAP))
>> +		return -EFAULT;
>> +
>> +	/*
>> +	 * If the vma does not allow read access, then assume that it does not
>> +	 * allow write access either. HMM does not support architectures
>> +	 * that allow write without read.
>> +	 */
>> +	if (!(vma->vm_flags & VM_READ)) {
>> +		/*
>> +		 * Check to see if a fault is requested for any page in the
>> +		 * range.
>> +		 */
>> +		if (hmm_range_needs_fault(start, end, hmm_vma_walk))
>> +			return -EFAULT;
> 
> Is this change to call hmm_range_needs_fault another bug fix?
> 
> Jason

Yes. If the HMM_FAULT_SNAPSHOT is specified, there shouldn't be any
error return code. If it is not specified, then the range->pfns[] array,
on input, holds flags indicating which pages the driver wants populated
if the page is not already present. The hmm_range_needs_fault() checks
for this and hmm_vma_walk_test() returns -EFAULT.

I guess I could include this in the change log.
