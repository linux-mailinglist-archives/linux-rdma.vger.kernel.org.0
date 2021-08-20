Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C613F28A1
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 10:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhHTIqg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 04:46:36 -0400
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47]:33943 "EHLO
        esa1.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230450AbhHTIqf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Aug 2021 04:46:35 -0400
IronPort-SDR: zHGsdWhD8utoOqc7AoZfOLNrG7DdlO224JXvIMGRZJeRS++wLWmdH7O1ocHhd8PFAhgZo6xSVZ
 C/Rl3okDaoVDig4Hc3KSWymRgVF33FoWlMw9gsl6yBcmd1pyW3jOBfBg9+PEvp7n65gWgyYjJn
 L7Fih4M3AaVVoLc+BXqsLWo1LpB3COS1TtiXs1YFRPOlHxsXuITIz60ohSigCRys5y+SdDc/uu
 mfzhEhCx5+J88xe1ooD46ZzRaco97iYanro4wuNVVccIUCqLmMRgK7/rnE1hTfZ3rHprH1P1eG
 /4IAPBVnM+iCVlu6EuTKsTXf
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="41027438"
X-IronPort-AV: E=Sophos;i="5.84,337,1620658800"; 
   d="scan'208";a="41027438"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 20 Aug 2021 17:45:57 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 890046ABE1
        for <linux-rdma@vger.kernel.org>; Fri, 20 Aug 2021 17:45:55 +0900 (JST)
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id C8E813C69B
        for <linux-rdma@vger.kernel.org>; Fri, 20 Aug 2021 17:45:54 +0900 (JST)
Received: from [10.133.114.24] (VPC-Y08P0560251.g01.fujitsu.local [10.133.114.24])
        by m3050.s.css.fujitsu.com (Postfix) with ESMTP id BA58EB2;
        Fri, 20 Aug 2021 17:45:54 +0900 (JST)
Subject: Re: [PATCH] RDMA/core: EPERM should be returned when # of pined pages
 is over ulimit
From:   Yasunori Goto <y-goto@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
References: <20210818082702.692117-1-y-goto@fujitsu.com>
 <20210819231053.GA390234@nvidia.com>
 <f784a0c6-27b7-5e30-b3ba-e1f4ebe95399@fujitsu.com>
Message-ID: <e3cb3dee-9c32-8024-1396-8dfd975a7b23@fujitsu.com>
Date:   Fri, 20 Aug 2021 17:45:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f784a0c6-27b7-5e30-b3ba-e1f4ebe95399@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/08/20 9:36, Yasunori Goto wrote:
> 
> 
> On 2021/08/20 8:10, Jason Gunthorpe wrote:
>> On Wed, Aug 18, 2021 at 05:27:02PM +0900, Yasunori Goto wrote:
>>> Hello,
>>>
>>> When I started to use SoftRoCE, I'm very confused by
>>> ENOMEM error output even if I gave enough memory.
>>>
>>> I think EPERM is more suitable for uses to solve error rather than
>>> ENOMEM at here of ib_umem_get() when # of pinned pages is over ulimit.
>>> This is not "memory is not enough" problem, because driver can
>>> succeed to pin enough amount of pages, but it is larger than ulimit 
>>> value.
>>>
>>> The hard limit of "max locked memory" can be changed by limit.conf.
>>> In addition, this checks also CAP_IPC_LOCK, it is indeed permmission 
>>> check.
>>> So, I think the following patch.
>>>
>>> If there is a intention why ENOMEM is used here, please let me know.
>>> Otherwise, I'm glad if this is merged.
>>>
>>> Thanks.
>>>
>>>
>>> ---
>>> When # of pinned pages are larger than ulimit of "max locked memory"
>>> without CAP_IPC_LOCK, current ib_umem_get() returns ENOMEM.
>>> But it does not mean "not enough memory", because driver could 
>>> succeed to
>>> pinned enough pages.
>>> This is just capability error. Even if a normal user is limited
>>> his/her # of pinned pages, system administrator can give permission
>>> by change hard limit of this ulimit value.
>>> To notify correct information to user, ib_umem_get()
>>> should return EPERM instead of ENOMEM at here.
>>
>> I'm not convinced, can you find other places checking the ulimit and
>> list what codes they return?
> 
> Hmm, OK.
> 
> I'll investigate it.

After the investigation, I found the followings.

- Many codes return ENOMEM in kernel/driver.
- Only one exception I could find is perf_mmap() in kernel/events/core.c
   It returns EPERM.

----
static int perf_mmap(struct file *file, struct vm_area_struct *vma)
{
    :
    :
         lock_limit = rlimit(RLIMIT_MEMLOCK);
         lock_limit >>= PAGE_SHIFT;
         locked = atomic64_read(&vma->vm_mm->pinned_vm) + extra;

         if ((locked > lock_limit) && perf_is_paranoid() &&
                 !capable(CAP_IPC_LOCK)) {
                 ret = -EPERM; <----!!!
                 goto unlock;
         }
----

- The man pages of mlock(2) says the followings. This seems to be cause
   why ENOMEM is returned in many place.
----
ENOMEM (Linux  2.6.9  and later) the caller had a nonzero RLIMIT_MEMLOCK
        soft resource limit, but tried to lock more memory than the limit
        permitted.   This  limit  is  not  enforced  if  the  process  is
        privileged (CAP_IPC_LOCK).
---

- In addition, POSIX specification(*) also says the followings at
   mlock(2).
---
[ENOMEM]
Locking the pages mapped by the specified range would exceed an
implementation-defined limit on the amount of memory that the process
may lock.
----
(*) https://pubs.opengroup.org/onlinepubs/9699919799.2018edition/

So, I changed my mind now. ib_umem_get() should return ENOMEM.

However, I want to provide some information to make it easy for users to 
understand. For example, sev_pin_memory() of arch/x86/kvm/svm/sev.c 
outputs error message like the followings.

---
static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
    :
    :
         if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
                 pr_err("SEV: %lu locked pages exceed the lock limit of 
%lu.\n", locked, lock_limit);
                 return ERR_PTR(-ENOMEM);
         }
---

I think it is better than nothing. How do you think?

Thanks,
-- -
Yasunori Goto
