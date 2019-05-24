Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDFA29CAE
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 19:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfEXRGF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 13:06:05 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3781 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfEXRGF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 13:06:05 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce8247b0000>; Fri, 24 May 2019 10:06:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 24 May 2019 10:06:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 24 May 2019 10:06:02 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 May
 2019 17:06:02 +0000
Subject: Re: [RFC PATCH 04/11] mm/hmm: Simplify hmm_get_or_create and make it
 reliable
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190523153436.19102-5-jgg@ziepe.ca>
 <6945b6c9-338a-54e6-64df-2590d536910a@nvidia.com>
 <20190524012320.GA13614@ziepe.ca>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <2ce70e06-2c7c-db46-821c-bdf06825dc1d@nvidia.com>
Date:   Fri, 24 May 2019 10:06:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190524012320.GA13614@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558717563; bh=XJk0dysE9wgKukvEat4C65gaJreFRWBYLCTM0Lx3FyI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jW1eyNNhPjtEAO6FWqVl8EAxx2JBeH4GcdO9kGju1s7tCZab/gJgGjwLYDJ98lkXP
         ksbObcsBdBy2SwkSl5hWajrj2gDQWp2/ZHigUmAZB9FPqZ5qwBeXFMA0Xo6oeVfsgw
         KrkWYEzJrz/qFFNhYSxEU9ACDUFkF1VbeYWyUCMdnUioiLSTCdza46gjeit/WFII6M
         vPcYBjaJY2codolpEZVWGWIz9lCsoYe2oAjoUmVpvFZMiksbBb+3Wes7dhaMbKrhuX
         vNxUXTuonPjZqkVuBftnIHWggJ2lBKOZhHUAXIaZD0JrZuE2gCIANrXlnJCHNSZHxQ
         gVDAQIRhFyd3g==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/23/19 6:23 PM, Jason Gunthorpe wrote:
> On Thu, May 23, 2019 at 04:38:28PM -0700, Ralph Campbell wrote:
>>
>> On 5/23/19 8:34 AM, Jason Gunthorpe wrote:
>>> From: Jason Gunthorpe <jgg@mellanox.com>
>>>
>>> As coded this function can false-fail in various racy situations. Make it
>>> reliable by running only under the write side of the mmap_sem and avoiding
>>> the false-failing compare/exchange pattern.
>>>
>>> Also make the locking very easy to understand by only ever reading or
>>> writing mm->hmm while holding the write side of the mmap_sem.
>>>
>>> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>>>    mm/hmm.c | 75 ++++++++++++++++++++------------------------------------
>>>    1 file changed, 27 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/mm/hmm.c b/mm/hmm.c
>>> index e27058e92508b9..ec54be54d81135 100644
>>> +++ b/mm/hmm.c
>>> @@ -40,16 +40,6 @@
>>>    #if IS_ENABLED(CONFIG_HMM_MIRROR)
>>>    static const struct mmu_notifier_ops hmm_mmu_notifier_ops;
>>> -static inline struct hmm *mm_get_hmm(struct mm_struct *mm)
>>> -{
>>> -	struct hmm *hmm = READ_ONCE(mm->hmm);
>>> -
>>> -	if (hmm && kref_get_unless_zero(&hmm->kref))
>>> -		return hmm;
>>> -
>>> -	return NULL;
>>> -}
>>> -
>>>    /**
>>>     * hmm_get_or_create - register HMM against an mm (HMM internal)
>>>     *
>>> @@ -64,11 +54,20 @@ static inline struct hmm *mm_get_hmm(struct mm_struct *mm)
>>>     */
>>>    static struct hmm *hmm_get_or_create(struct mm_struct *mm)
>>>    {
>>> -	struct hmm *hmm = mm_get_hmm(mm);
>>> -	bool cleanup = false;
>>> +	struct hmm *hmm;
>>> -	if (hmm)
>>> -		return hmm;
>>> +	lockdep_assert_held_exclusive(mm->mmap_sem);
>>> +
>>> +	if (mm->hmm) {
>>> +		if (kref_get_unless_zero(&mm->hmm->kref))
>>> +			return mm->hmm;
>>> +		/*
>>> +		 * The hmm is being freed by some other CPU and is pending a
>>> +		 * RCU grace period, but this CPU can NULL now it since we
>>> +		 * have the mmap_sem.
>>> +		 */
>>> +		mm->hmm = NULL;
>>
>> Shouldn't there be a "return NULL;" here so it doesn't fall through and
>> allocate a struct hmm below?
> 
> No, this function should only return NULL on memory allocation
> failure.
> 
> In this case another thread is busy freeing the hmm but wasn't able to
> update mm->hmm to null due to a locking constraint. So we make it null
> on behalf of the other thread and allocate a fresh new hmm that is
> valid. The freeing thread will complete the free and do nothing with
> mm->hmm.
> 
>>>    static void hmm_fee_rcu(struct rcu_head *rcu)
>>
>> I see Jerome already saw and named this hmm_free_rcu()
>> which I agree with.
> 
> I do love my typos :)
> 
>>>    {
>>> +	struct hmm *hmm = container_of(rcu, struct hmm, rcu);
>>> +
>>> +	down_write(&hmm->mm->mmap_sem);
>>> +	if (hmm->mm->hmm == hmm)
>>> +		hmm->mm->hmm = NULL;
>>> +	up_write(&hmm->mm->mmap_sem);
>>> +	mmdrop(hmm->mm);
>>> +
>>>    	kfree(container_of(rcu, struct hmm, rcu));
>>>    }
>>>    static void hmm_free(struct kref *kref)
>>>    {
>>>    	struct hmm *hmm = container_of(kref, struct hmm, kref);
>>> -	struct mm_struct *mm = hmm->mm;
>>> -
>>> -	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, mm);
>>> -	spin_lock(&mm->page_table_lock);
>>> -	if (mm->hmm == hmm)
>>> -		mm->hmm = NULL;
>>> -	spin_unlock(&mm->page_table_lock);
>>> -
>>> -	mmdrop(hmm->mm);
>>> +	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, hmm->mm);
>>>    	mmu_notifier_call_srcu(&hmm->rcu, hmm_fee_rcu);
>>>    }
>>>
>>
>> This email message is for the sole use of the intended recipient(s) and may contain
>> confidential information.  Any unauthorized review, use, disclosure or distribution
>> is prohibited.  If you are not the intended recipient, please contact the sender by
>> reply email and destroy all copies of the original message.
> 
> Ah, you should not send this trailer to the public mailing lists.
> 
> Thanks,
> Jason
> 

Sorry, I have to apply the "magic" header to suppress this each time I
send email to a public list.
