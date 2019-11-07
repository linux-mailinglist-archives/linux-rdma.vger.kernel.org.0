Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8EF39F0
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2019 21:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfKGU4s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Nov 2019 15:56:48 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14349 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKGU4r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Nov 2019 15:56:47 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc484d00000>; Thu, 07 Nov 2019 12:55:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 07 Nov 2019 12:56:45 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 07 Nov 2019 12:56:45 -0800
Received: from [10.2.174.146] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Nov
 2019 20:56:40 +0000
Subject: Re: [PATCH v2 02/15] mm/mmu_notifier: add an interval tree notifier
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
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
        "Christoph Hellwig" <hch@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Michal Hocko" <mhocko@kernel.org>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-3-jgg@ziepe.ca>
 <35c2b322-004e-0e18-87e4-1920dc71bfd5@nvidia.com>
 <20191107200604.GB21728@mellanox.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <9dc2b3c7-f945-b645-b3a3-313a21d2fdfc@nvidia.com>
Date:   Thu, 7 Nov 2019 12:53:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191107200604.GB21728@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573160145; bh=0o7ET/y25KDp83qUXLZmAimWzQOXiF76Ve9Y+FzALFM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JYP9fwhlxIm5SsWjFushBYq1+VcYPhITepY0rqKtsp43p7cbnw2DVntkJ2D7ZXjN9
         9RFMy0+hTlJ0asJ6SsFHmIq2wiyqj/mDk7puyUOaOgRHDj21gGnWZHyzEORCxkYZLy
         74a5AfKJh2kMafXBVhLtO6AvoPbuLMyIZGVSYKEJggnRxhufdbR6VdL4O2pQPpa+U1
         jqgmSV6LJsRB5SIp7co1IbRQP4ckPA57lwPmdlgWmNauzyrbOExEmwpyHBMSTxwN4S
         7EmycUtOJ+PIgA1H5cW9YZIpCVy2Aq2XVcoPj57OTL9kVR/s89nIgeqjdpFuNKHFgt
         wFwSrwWLRZ3Uw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/7/19 12:06 PM, Jason Gunthorpe wrote:
...
>>
>> Also, it is best moved down to be next to the new MNR structs, so that all the
>> MNR stuff is in one group.
> 
> I agree with Jerome, this enum is part of the 'struct
> mmu_notifier_range' (ie the description of the invalidation) and it
> doesn't really matter that only these new notifiers can be called with
> this type, it is still part of the mmu_notifier_range.
> 

OK.

> The comment already says it only applies to the mmu_range_notifier
> scheme..
> 
>>>   #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
>>> @@ -222,6 +228,26 @@ struct mmu_notifier {
>>>   	unsigned int users;
>>>   };
>>>   
>>
>> That should also be moved down, next to the new structs.
> 
> Which this?

I was referring to MMU_NOTIFIER_RANGE_BLOCKABLE, above. Trying
to put all the new range notifier stuff in one place. But maybe not,
if these are really not as separate as I thought.

> 
>>> +/**
>>> + * struct mmu_range_notifier_ops
>>> + * @invalidate: Upon return the caller must stop using any SPTEs within this
>>> + *              range, this function can sleep. Return false if blocking was
>>> + *              required but range is non-blocking
>>> + */
>>
>> How about this (I'm not sure I fully understand the return value, though):
>>
>> /**
>>   * struct mmu_range_notifier_ops
>>   * @invalidate: Upon return the caller must stop using any SPTEs within this
>>   * 		range.
>>   *
>>   * 		This function is permitted to sleep.
>>   *
>>   *      	@Return: false if blocking was required, but @range is
>>   *			non-blocking.
>>   *
>>   */
> 
> Is this kdoc format for function pointers?

heh, I'm sort of winging it, I'm not sure how function pointers are supposed
to be documented in kdoc. Actually the only key take-away here is to write

"This function can sleep"

as a separate sentence..

...
>> c) Rename new one. Ideas:
>>
>>      struct mmu_interval_notifier
>>      struct mmu_range_intersection
>>      ...other ideas?
> 
> This odd duality has already cause some confusion, but names here are
> hard.  mmu_interval_notifier is the best alternative I've heard.
> 
> Changing this name is a lot of work - are we happy
> 'mmu_interval_notifier' is the right choice?


Yes, it's my favorite too. I'd vote for going with that.

...
>>
>>
>> OK, this either needs more documentation and assertions, or a different
>> approach. Because I see addition, subtraction, AND, OR and booleans
>> all being applied to this field, and it's darn near hopeless to figure
>> out whether or not it really is even or odd at the right times.
> 
> This is a standard design for a seqlock scheme and follows the
> existing design of the linux seq lock.
> 
> The lower bit indicates the lock'd state and the upper bits indicate
> the generation of the lock
> 
> The operations on the lock itself are then:
>     seq |= 1  # Take the lock
>     seq++     # Release an acquired lock
>     seq & 1   # True if locked
> 
> Which is how this is written

Very nice, would you be open to putting that into (any) one of the comment
headers? That's an unusually clear and concise description:

/*
  * This is a standard design for a seqlock scheme and follows the
  * existing design of the linux seq lock.
  *
  * The lower bit indicates the lock'd state and the upper bits indicate
  * the generation of the lock
  *
  * The operations on the lock itself are then:
  *    seq |= 1  # Take the lock
  *    seq++     # Release an acquired lock
  *    seq & 1   # True if locked
  */


> 
>> Different approach: why not just add a mmn_mm->is_invalidating
>> member variable? It's not like you're short of space in that struct.
> 
> Splitting it makes alot of stuff more complex and unnatural.
> 

OK, agreed.

> The ops above could be put in inline wrappers, but they only occur
> only in functions already called mn_itree_inv_start_range() and
> mn_itree_inv_end() and mn_itree_is_invalidating().
> 
> There is the one 'take the lock' outlier in
> __mmu_range_notifier_insert() though
> 
>>> +static void mn_itree_inv_end(struct mmu_notifier_mm *mmn_mm)
>>> +{
>>> +	struct mmu_range_notifier *mrn;
>>> +	struct hlist_node *next;
>>> +	bool need_wake = false;
>>> +
>>> +	spin_lock(&mmn_mm->lock);
>>> +	if (--mmn_mm->active_invalidate_ranges ||
>>> +	    !mn_itree_is_invalidating(mmn_mm)) {
>>> +		spin_unlock(&mmn_mm->lock);
>>> +		return;
>>> +	}
>>> +
>>> +	mmn_mm->invalidate_seq++;
>>
>> Is this the right place for an assertion that this is now an even value?
> 
> Yes, but I'm reluctant to add such a runtime check on this fastish path..
> How about a comment?

Sure.

> 
>>> +	need_wake = true;
>>> +
>>> +	/*
>>> +	 * The inv_end incorporates a deferred mechanism like
>>> +	 * rtnl_lock(). Adds and removes are queued until the final inv_end
>>
>> Let me point out that rtnl_lock() itself is a one-liner that calls mutex_lock().
>> But I suppose if one studies that file closely there is more. :)
> 
> Lets change that to rtnl_unlock() then


Thanks :)


...
>>> +	 * mrn->invalidate_seq is always set to an odd value. This ensures
>>
>> This claim just looks wrong the first N times one reads the code, given that
>> there is mmu_range_set_seq() to set it to an arbitrary value!  Maybe
>> you mean
> 
> mmu_range_set_seq() is NOT to be used to set to an arbitary value, it
> must only be used to set to the value provided in the invalidate()
> callback and that value is always odd. Lets make this super clear:
> 
> 	/*
> 	 * mrn->invalidate_seq must always be set to an odd value via
> 	 * mmu_range_set_seq() using the provided cur_seq from
> 	 * mn_itree_inv_start_range(). This ensures that if seq does wrap we
> 	 * will always clear the below sleep in some reasonable time as
> 	 * mmn_mm->invalidate_seq is even in the idle state.
> 	 */
> 

OK, that helps a lot.

...
>>> +		mrn->invalidate_seq = mmn_mm->invalidate_seq - 1;
>>
>> Ohhh, checkmate. I lose. Why is *subtracting* the right thing to do
>> for seq numbers here?  I'm acutely unhappy trying to figure this out.
>> I suspect it's another unfortunate side effect of trying to use the
>> lower bit of the seq number (even/odd) for something else.
> 
> No, this is actually done for the seq number itself. We need to
> generate a seq number that is != the current invalidate_seq as this
> new mrn is not invalidating.
> 
> The best seq to use is one that the invalidate_seq will not reach for
> a long time, ie 'invalidate_seq + MAX' which is expressed as -1
> 
> The even/odd thing just takes care of itself naturally here as
> invalidate_seq is guarenteed even and -1 creates both an odd mrn value
> and a good seq number.
> 
> The algorithm would actually work correctly if this was
> 'mrn->invalidate_seq = 1', but occasionally things would block when
> they don't need to block.
> 
> Lets add a comment:
> 
> 		/*
> 		 * The starting seq for a mrn not under invalidation should be
> 		 * odd, not equal to the current invalidate_seq and
> 		 * invalidate_seq should not 'wrap' to the new seq any time
> 		 * soon.
> 		 */

Very helpful. How about this additional tweak:

/*
  * The starting seq for a mrn not under invalidation should be
  * odd, not equal to the current invalidate_seq and
  * invalidate_seq should not 'wrap' to the new seq any time
  * soon. Subtracting 1 from the current (even) value achieves that.
  */


> 
>>> +int mmu_range_notifier_insert(struct mmu_range_notifier *mrn,
>>> +			      unsigned long start, unsigned long length,
>>> +			      struct mm_struct *mm)
>>> +{
>>> +	struct mmu_notifier_mm *mmn_mm;
>>> +	int ret;
>>
>> Hmmm, I think a later patch improperly changes the above to "int ret = 0;".
>> I'll check on that. It's correct here, though.
> 
> Looks OK in my tree?

Nope, that's how I found it. The top of your mmu_notifier branch has this:

int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
{
         struct mmu_notifier_mm *mmn_mm = range->mm->mmu_notifier_mm;
         int ret = 0;

         if (mmn_mm->has_interval) {
                 ret = mn_itree_invalidate(mmn_mm, range);
                 if (ret)
                         return ret;
         }
         if (!hlist_empty(&mmn_mm->list))
                 return mn_hlist_invalidate_range_start(mmn_mm, range);
         return 0;
}


> 
>>> +	might_lock(&mm->mmap_sem);
>>> +
>>> +	mmn_mm = smp_load_acquire(&mm->mmu_notifier_mm);
>>
>> What does the above pair with? Should have a comment that specifies that.
> 
> smp_load_acquire() always pairs with smp_store_release() to the same
> memory, there is only one store, is a comment really needed?
> 
> Below are the comment updates I made, thanks!
> 
> Jason
> 
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index 51b92ba013ddce..065c95002e9602 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -302,15 +302,15 @@ void mmu_range_notifier_remove(struct mmu_range_notifier *mrn);
>   /**
>    * mmu_range_set_seq - Save the invalidation sequence
>    * @mrn - The mrn passed to invalidate
> - * @cur_seq - The cur_seq passed to invalidate
> + * @cur_seq - The cur_seq passed to the invalidate() callback
>    *
>    * This must be called unconditionally from the invalidate callback of a
>    * struct mmu_range_notifier_ops under the same lock that is used to call
>    * mmu_range_read_retry(). It updates the sequence number for later use by
> - * mmu_range_read_retry().
> + * mmu_range_read_retry(). The provided cur_seq will always be odd.
>    *
> - * If the user does not call mmu_range_read_begin() or mmu_range_read_retry()
> - * then this call is not required.
> + * If the caller does not call mmu_range_read_begin() or
> + * mmu_range_read_retry() then this call is not required.
>    */
>   static inline void mmu_range_set_seq(struct mmu_range_notifier *mrn,
>   				     unsigned long cur_seq)
> @@ -348,8 +348,9 @@ static inline bool mmu_range_read_retry(struct mmu_range_notifier *mrn,
>    * collided with this lock and a future mmu_range_read_retry() will return
>    * true.
>    *
> - * False is not reliable and only suggests a collision has not happened. It
> - * can be called many times and does not have to hold the user provided lock.
> + * False is not reliable and only suggests a collision may not have
> + * occured. It can be called many times and does not have to hold the user
> + * provided lock.
>    *
>    * This call can be used as part of loops and other expensive operations to
>    * expedite a retry.
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 2b7485919ecfeb..afe1e2d94183f8 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -51,7 +51,8 @@ struct mmu_notifier_mm {
>    * This is a collision-retry read-side/write-side 'lock', a lot like a
>    * seqcount, however this allows multiple write-sides to hold it at
>    * once. Conceptually the write side is protecting the values of the PTEs in
> - * this mm, such that PTES cannot be read into SPTEs while any writer exists.
> + * this mm, such that PTES cannot be read into SPTEs (shadow PTEs) while any
> + * writer exists.
>    *
>    * Note that the core mm creates nested invalidate_range_start()/end() regions
>    * within the same thread, and runs invalidate_range_start()/end() in parallel
> @@ -64,12 +65,13 @@ struct mmu_notifier_mm {
>    *
>    * The write side has two states, fully excluded:
>    *  - mm->active_invalidate_ranges != 0
> - *  - mnn->invalidate_seq & 1 == True
> + *  - mnn->invalidate_seq & 1 == True (odd)
>    *  - some range on the mm_struct is being invalidated
>    *  - the itree is not allowed to change
>    *
>    * And partially excluded:
>    *  - mm->active_invalidate_ranges != 0
> + *  - mnn->invalidate_seq & 1 == False (even)
>    *  - some range on the mm_struct is being invalidated
>    *  - the itree is allowed to change
>    *
> @@ -131,12 +133,13 @@ static void mn_itree_inv_end(struct mmu_notifier_mm *mmn_mm)
>   		return;
>   	}
>   
> +	/* Make invalidate_seq even */
>   	mmn_mm->invalidate_seq++;
>   	need_wake = true;
>   
>   	/*
>   	 * The inv_end incorporates a deferred mechanism like
> -	 * rtnl_lock(). Adds and removes are queued until the final inv_end
> +	 * rtnl_unlock(). Adds and removes are queued until the final inv_end
>   	 * happens then they are progressed. This arrangement for tree updates
>   	 * is used to avoid using a blocking lock during
>   	 * invalidate_range_start.
> @@ -230,10 +233,11 @@ unsigned long mmu_range_read_begin(struct mmu_range_notifier *mrn)
>   	spin_unlock(&mmn_mm->lock);
>   
>   	/*
> -	 * mrn->invalidate_seq is always set to an odd value. This ensures
> -	 * that if seq does wrap we will always clear the below sleep in some
> -	 * reasonable time as mmn_mm->invalidate_seq is even in the idle
> -	 * state.
> +	 * mrn->invalidate_seq must always be set to an odd value via
> +	 * mmu_range_set_seq() using the provided cur_seq from
> +	 * mn_itree_inv_start_range(). This ensures that if seq does wrap we
> +	 * will always clear the below sleep in some reasonable time as
> +	 * mmn_mm->invalidate_seq is even in the idle state.
>   	 */
>   	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
>   	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
> @@ -892,6 +896,12 @@ static int __mmu_range_notifier_insert(struct mmu_range_notifier *mrn,
>   		mrn->invalidate_seq = mmn_mm->invalidate_seq;
>   	} else {
>   		WARN_ON(mn_itree_is_invalidating(mmn_mm));
> +		/*
> +		 * The starting seq for a mrn not under invalidation should be
> +		 * odd, not equal to the current invalidate_seq and
> +		 * invalidate_seq should not 'wrap' to the new seq any time
> +		 * soon.
> +		 */
>   		mrn->invalidate_seq = mmn_mm->invalidate_seq - 1;
>   		interval_tree_insert(&mrn->interval_tree, &mmn_mm->itree);
>   	}
> 

Looks good. We're just polishing up minor points now, so you can add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>



thanks,
-- 
John Hubbard
NVIDIA
