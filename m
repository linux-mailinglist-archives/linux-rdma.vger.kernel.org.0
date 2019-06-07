Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCE939857
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 00:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfFGWND (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 18:13:03 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3573 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729456AbfFGWND (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 18:13:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfae15d0000>; Fri, 07 Jun 2019 15:12:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 15:13:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Jun 2019 15:13:00 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 22:13:00 +0000
Subject: Re: [PATCH v2 hmm 05/11] mm/hmm: Remove duplicate condition test
 before wait_event_timeout
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, <Felix.Kuehling@amd.com>,
        <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-6-jgg@ziepe.ca>
 <6833be96-12a3-1a1c-1514-c148ba2dd87b@nvidia.com>
 <20190607191302.GR14802@ziepe.ca>
 <e17aa8c5-790c-d977-2eb8-c18cdaa4cbb3@nvidia.com>
 <20190607204427.GU14802@ziepe.ca>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <ba55e382-c982-8e50-4ee7-7f05c9f7fafa@nvidia.com>
Date:   Fri, 7 Jun 2019 15:13:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190607204427.GU14802@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559945565; bh=w3a7b9rytavrVqWAu68ZTBiYbQdXk8HyDqOvXxODynI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CWdWEdXPdbaJqJvgBK8un2hHaJjvd5blgVCjnqh9s/ui4hx87u/PJ98EsE3qmq6Qu
         1W50vUYw1wY0Qu8QqArvY53uYzlLZ8EkYK+2k62MiFKOdIsVhEE7Gzv4g3wnvDXtD5
         8pYFkrEtJoIqZ9LyuyvmlNSpvhmXLsYcW9r73wlDH8OG6Pl1/sKkUaQ2HV6PkV61/Z
         efjBqzJjkpXoY7LY2JKKbOGi0PFCKWjp0sHy67fAO92y2bEogWuGzdZmw1y4bzEVGW
         tmZOCvZJeqxrnQZ9gAn/6QduMPBBZq+PkRyjmTnXOJhExey4BRW0jLc8st2oDC44/D
         qk8qFJQluW+dQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/7/19 1:44 PM, Jason Gunthorpe wrote:
> On Fri, Jun 07, 2019 at 01:21:12PM -0700, Ralph Campbell wrote:
> 
>>> What I want to get to is a pattern like this:
>>>
>>> pagefault():
>>>
>>>      hmm_range_register(&range);
>>> again:
>>>      /* On the slow path, if we appear to be live locked then we get
>>>         the write side of mmap_sem which will break the live lock,
>>>         otherwise this gets the read lock */
>>>      if (hmm_range_start_and_lock(&range))
>>>            goto err;
>>>
>>>      lockdep_assert_held(range->mm->mmap_sem);
>>>
>>>      // Optional: Avoid useless expensive work
>>>      if (hmm_range_needs_retry(&range))
>>>         goto again;
>>>      hmm_range_(touch vmas)
>>>
>>>      take_lock(driver->update);
>>>      if (hmm_range_end(&range) {
>>>          release_lock(driver->update);
>>>          goto again;
>>>      }
>>>      // Finish driver updates
>>>      release_lock(driver->update);
>>>
>>>      // Releases mmap_sem
>>>      hmm_range_unregister_and_unlock(&range);
>>>
>>> What do you think?
>>>
>>> Is it clear?
>>>
>>> Jason
>>>
>>
>> Are you talking about acquiring mmap_sem in hmm_range_start_and_lock()?
>> Usually, the fault code has to lock mmap_sem for read in order to
>> call find_vma() so it can set range.vma.
> 
>> If HMM drops mmap_sem - which I don't think it should, just return an
>> error to tell the caller to drop mmap_sem and retry - the find_vma()
>> will need to be repeated as well.
> 
> Overall I don't think it makes a lot of sense to sleep for retry in
> hmm_range_start_and_lock() while holding mmap_sem. It would be better
> to drop that lock, sleep, then re-acquire it as part of the hmm logic.
> 
> The find_vma should be done inside the critical section created by
> hmm_range_start_and_lock(), not before it. If we are retrying then we
> already slept and the additional CPU cost to repeat the find_vma is
> immaterial, IMHO?
> 
> Do you see a reason why the find_vma() ever needs to be before the
> 'again' in my above example? range.vma does not need to be set for
> range_register.

Yes, for the GPU case, there can be many faults in an event queue
and the goal is to try to handle more than one page at a time.
The vma is needed to limit the amount of coalescing and checking
for pages that could be speculatively migrated or mapped.

>> I'm also not sure about acquiring the mmap_sem for write as way to
>> mitigate thrashing. It seems to me that if a device and a CPU are
>> both faulting on the same page,
> 
> One of the reasons to prefer this approach is that it means we don't
> need to keep track of which ranges we are faulting, and if there is a
> lot of *unrelated* fault activity (unlikely?) we can resolve it using
> mmap sem instead of this elaborate ranges scheme and related
> locking.
> 
> This would reduce the overall work in the page fault and
> invalidate_start/end paths for the common uncontended cases.
> 
>> some sort of backoff delay is needed to let one side or the other
>> make some progress.
> 
> What the write side of the mmap_sem would do is force the CPU and
> device to cleanly take turns. Once the device pages are registered
> under the write side the CPU will have to wait in invalidate_start for
> the driver to complete a shootdown, then the whole thing starts all
> over again.
> 
> It is certainly imaginable something could have a 'min life' timer for
> a device mapping and hold mm invalidate_start, and device pagefault
> for that min time to promote better sharing.
> 
> But, if we don't use the mmap_sem then we can livelock and the device
> will see an unrecoverable error from the timeout which means we have
> risk that under load the system will simply obscurely fail. This seems
> unacceptable to me..
> 
> Particularly since for the ODP use case the issue is not trashing
> migration as a GPU might have, but simple system stability under swap
> load. We do not want the ODP pagefault to permanently fail due to
> timeout if the VMA is still valid..
> 
> Jason
> 

OK, I understand.
If you come up with a set of changes, I can try testing them.
