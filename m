Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A54107C2C
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Nov 2019 01:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKWAyM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Nov 2019 19:54:12 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2809 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWAyM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Nov 2019 19:54:12 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd883360002>; Fri, 22 Nov 2019 16:54:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 22 Nov 2019 16:54:11 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 22 Nov 2019 16:54:11 -0800
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 23 Nov
 2019 00:54:09 +0000
Subject: Re: [PATCH v3 02/14] mm/mmu_notifier: add an interval tree notifier
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Philip Yang" <Philip.Yang@amd.com>
References: <20191112202231.3856-1-jgg@ziepe.ca>
 <20191112202231.3856-3-jgg@ziepe.ca> <20191113135952.GB20531@infradead.org>
 <20191113164620.GG21728@mellanox.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <cc5d4d76-df30-af7f-931c-eed8a7ada122@nvidia.com>
Date:   Fri, 22 Nov 2019 16:54:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191113164620.GG21728@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574470454; bh=bqXekT37QvQAiJj5unYfuv1fXYv5e9H7W3TE2f93DwM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=RbJQdgYI/dFjAHVBUW2cZh29EsZO0NHYznPqb2KeSMvLVVy+04SbUd55RqBkrkhJI
         jm/LeQz23dcFfabHtr7RQD84s0QA8rh3fsS0PRa3IJS+eqYq7MGRwyq9H+zGaLMfD3
         WqtNXVdcloKxtxdXWjpWt/eLYryP6nzidZyHs9Wc6z9xD5WKpR41oA1bXATTukQ9M6
         1cHg0E2riIVQJmWnCM05nnbGLP5OMxPkcPPjqw6VP5O8mhO6Ety7S9I+GFqlFd653y
         +sAZHnWhqHkw9LpDWRh+68ed97cLbzYBVPI8EPpFZTzn7/Bdkz3mnORzqe8mUjddCf
         k/1CQ6pwn+MUg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 11/13/19 8:46 AM, Jason Gunthorpe wrote:
> On Wed, Nov 13, 2019 at 05:59:52AM -0800, Christoph Hellwig wrote:
>>> +int mmu_interval_notifier_insert(struct mmu_interval_notifier *mni,
>>> +				      struct mm_struct *mm, unsigned long start,
>>> +				      unsigned long length,
>>> +				      const struct mmu_interval_notifier_ops *ops);
>>> +int mmu_interval_notifier_insert_locked(
>>> +	struct mmu_interval_notifier *mni, struct mm_struct *mm,
>>> +	unsigned long start, unsigned long length,
>>> +	const struct mmu_interval_notifier_ops *ops);
>>
>> Very inconsistent indentation between these two related functions.
> 
> clang-format.. The kernel config is set to prefer a line up under the
> ( if all the arguments will fit within the 80 cols otherwise it does a
> 1 tab continuation indent.
> 
>>> +	/*
>>> +	 * The inv_end incorporates a deferred mechanism like
>>> +	 * rtnl_unlock(). Adds and removes are queued until the final inv_end
>>> +	 * happens then they are progressed. This arrangement for tree updates
>>> +	 * is used to avoid using a blocking lock during
>>> +	 * invalidate_range_start.
>>
>> Nitpick:  That comment can be condensed into one less line:
> 
> The rtnl_unlock can move up a line too. My editor is failing me on
> this.
> 
>>> +	/*
>>> +	 * TODO: Since we already have a spinlock above, this would be faster
>>> +	 * as wake_up_q
>>> +	 */
>>> +	if (need_wake)
>>> +		wake_up_all(&mmn_mm->wq);
>>
>> So why is this important enough for a TODO comment, but not important
>> enough to do right away?
> 
> Lets drop the comment, I'm noto sure wake_up_q is even a function this
> layer should be calling.

Actually, I think you can remove the "need_wake" variable since it is
unconditionally set to "true".

Also, the comment in__mmu_interval_notifier_insert() says
"mni->mr_invalidate_seq" and I think that should be
"mni->invalidate_seq".
