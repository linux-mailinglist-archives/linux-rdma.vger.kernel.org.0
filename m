Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B324A6544
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Feb 2022 21:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbiBAUAM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Feb 2022 15:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiBAUAL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Feb 2022 15:00:11 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC29EC061714
        for <linux-rdma@vger.kernel.org>; Tue,  1 Feb 2022 12:00:11 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id u13so19298749oie.5
        for <linux-rdma@vger.kernel.org>; Tue, 01 Feb 2022 12:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YUYVcclHavKUveL3WPAMDjt/X03kfmWxUC+m6u4aTYs=;
        b=hmPGDr8Xqf3MXnfwqS6tQmhb3c/NGbEhhk8nTsjqm+xY7gwciklAgTouJctgxK9pPZ
         fY+6ZpZlk+SVHrLqKw9F+BNeL6oBDTHm2KXrI7LqOQ9Zxf7y4iR6gkpQ9qlByn+UKMhK
         sKOv2wu6as3q36++VTkx0u5UPbO7Zvv7bZsFTREK8uVcP8736UBP4742lT6h0vd6DdWF
         Vxue02QWVBgzG5XAaP8nqcT/CSNZxwvH0bTCjOsMQS6iO/Pjm2gPYM0fLztAOAjYhooU
         4GcAlnYCf4VaFJf2DBHcaZtXaiAF+C91uotCBivlYjvCADkqBpE4bCcrLZq4oIHV4qaR
         osJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YUYVcclHavKUveL3WPAMDjt/X03kfmWxUC+m6u4aTYs=;
        b=eLePeMCPeUBXMJ2u1RqRXHOwjxe/jrx9K5PD917h5Acjj7lwYE0AykkSqvLrUvM3nH
         goQ9SgShcwsbt+yQpLOusxsne22vZYp2g6gvbc0SdvFcVixg6tBEVjyyzPpcsihSpvDi
         RUysSwdQ6FnRfGbz7ncAFxsuht32fuEUlg5BUuup4aeeZeY8bhAqH/S2OrO9WpXW4Q4a
         I3OU+fA68lGzi2F8OxhtjDbqTUgv/1HKtlajclYGWCScwJHKSSgi95dvmaQGsNwqVBpD
         +uuiiHnqqQ11m2oflBAS2y+40olA6NuTkoF6EQLrHI4fmTC2FQM2nO0QrHkQdhITcQA6
         njBg==
X-Gm-Message-State: AOAM530QxJdJ2F0Sv2QpFld+2hbfcIR+p1EHU+GGplZO58GEOK66RY8N
        XYaZ77SfUq+YRhCRN9kOyua+VzyW7BQ=
X-Google-Smtp-Source: ABdhPJxqH3pEuvuXsivCoZPy0XNYY3UmGhp/djFy5Fa2iXDZFvQ6RWUeCKgbdmuBRNbOeK7lvV49tw==
X-Received: by 2002:a05:6808:1385:: with SMTP id c5mr2185325oiw.234.1643745610981;
        Tue, 01 Feb 2022 12:00:10 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:71b2:d0bc:75eb:e63d? (2603-8081-140c-1a00-71b2-d0bc-75eb-e63d.res6.spectrum.com. [2603:8081:140c:1a00:71b2:d0bc:75eb:e63d])
        by smtp.gmail.com with ESMTPSA id t25sm6129671otk.31.2022.02.01.12.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 12:00:10 -0800 (PST)
Message-ID: <e1b6b398-ebe2-f5aa-e34f-58b786608b1b@gmail.com>
Date:   Tue, 1 Feb 2022 14:00:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH for-next v10 07/17] RDMA/rxe: Use kzmalloc/kfree for mca
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
 <20220131220849.10170-8-rpearsonhpe@gmail.com>
 <20220201145342.GI1786498@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220201145342.GI1786498@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/1/22 08:53, Jason Gunthorpe wrote:
> On Mon, Jan 31, 2022 at 04:08:40PM -0600, Bob Pearson wrote:
>> Remove rxe_mca (was rxe_mc_elem) from rxe pools and use kzmalloc
>> and kfree to allocate and free. Use the sequence
>>
>>     <lookup qp>
>>     new_mca = kzalloc(sizeof(*new_mca), GFP_KERNEL);
>>     <spin lock>
>>     <lookup qp again> /* in case of a race */
>>     <init new_mca>
>>     <spin unlock>
>>
>> instead of GFP_ATOMIC inside of the spinlock. Add an extra reference
>> to multicast group to protect the pointer in the index that maps
>> mgid to group.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>  drivers/infiniband/sw/rxe/rxe.c       |   8 --
>>  drivers/infiniband/sw/rxe/rxe_mcast.c | 102 +++++++++++++++-----------
>>  drivers/infiniband/sw/rxe/rxe_pool.c  |   5 --
>>  drivers/infiniband/sw/rxe/rxe_pool.h  |   1 -
>>  drivers/infiniband/sw/rxe/rxe_verbs.h |   2 -
>>  5 files changed, 59 insertions(+), 59 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
>> index fab291245366..c55736e441e7 100644
>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>> @@ -29,7 +29,6 @@ void rxe_dealloc(struct ib_device *ib_dev)
>>  	rxe_pool_cleanup(&rxe->mr_pool);
>>  	rxe_pool_cleanup(&rxe->mw_pool);
>>  	rxe_pool_cleanup(&rxe->mc_grp_pool);
>> -	rxe_pool_cleanup(&rxe->mc_elem_pool);
>>  
>>  	if (rxe->tfm)
>>  		crypto_free_shash(rxe->tfm);
>> @@ -163,15 +162,8 @@ static int rxe_init_pools(struct rxe_dev *rxe)
>>  	if (err)
>>  		goto err9;
>>  
>> -	err = rxe_pool_init(rxe, &rxe->mc_elem_pool, RXE_TYPE_MC_ELEM,
>> -			    rxe->attr.max_total_mcast_qp_attach);
>> -	if (err)
>> -		goto err10;
>> -
>>  	return 0;
>>  
>> -err10:
>> -	rxe_pool_cleanup(&rxe->mc_grp_pool);
>>  err9:
>>  	rxe_pool_cleanup(&rxe->mw_pool);
>>  err8:
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
>> index 9336295c4ee2..4a5896a225a6 100644
>> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
>> @@ -26,30 +26,40 @@ static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
>>  }
>>  
>>  /* caller should hold mc_grp_pool->pool_lock */
>> -static struct rxe_mcg *create_grp(struct rxe_dev *rxe,
>> -				     struct rxe_pool *pool,
>> -				     union ib_gid *mgid)
>> +static int __rxe_create_grp(struct rxe_dev *rxe, struct rxe_pool *pool,
>> +			    union ib_gid *mgid, struct rxe_mcg **grp_p)
>>  {
>>  	int err;
>>  	struct rxe_mcg *grp;
>>  
>>  	grp = rxe_alloc_locked(&rxe->mc_grp_pool);
>>  	if (!grp)
>> -		return ERR_PTR(-ENOMEM);
>> +		return -ENOMEM;
>> +
>> +	err = rxe_mcast_add(rxe, mgid);
>> +	if (unlikely(err)) {
>> +		rxe_drop_ref(grp);
>> +		return err;
>> +	}
>>  
>>  	INIT_LIST_HEAD(&grp->qp_list);
>>  	spin_lock_init(&grp->mcg_lock);
>>  	grp->rxe = rxe;
>> +
>> +	rxe_add_ref(grp);
>>  	rxe_add_key_locked(grp, mgid);
>>  
>> -	err = rxe_mcast_add(rxe, mgid);
>> -	if (unlikely(err)) {
>> -		rxe_drop_key_locked(grp);
>> -		rxe_drop_ref(grp);
>> -		return ERR_PTR(err);
>> -	}
>> +	*grp_p = grp;
> 
> This should return the struct rxe_mcg or an ERR_PTR not use output
> function arguments, like it was before
> 
>> +	return 0;
>> +}
>> +
>> +/* caller is holding a ref from lookup and mcg->mcg_lock*/
>> +void __rxe_destroy_mcg(struct rxe_mcg *grp)
>> +{
>> +	rxe_drop_key(grp);
>> +	rxe_drop_ref(grp);
>>  
>> -	return grp;
>> +	rxe_mcast_delete(grp->rxe, &grp->mgid);
>>  }
>>  
>>  static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
>> @@ -68,10 +78,9 @@ static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
>>  	if (grp)
>>  		goto done;
>>  
>> -	grp = create_grp(rxe, pool, mgid);
>> -	if (IS_ERR(grp)) {
>> +	err = __rxe_create_grp(rxe, pool, mgid, &grp);
>> +	if (err) {
>>  		write_unlock_bh(&pool->pool_lock);
>> -		err = PTR_ERR(grp);
>>  		return err;
> 
> This should return the struct rxe_mcg or ERR_PTR too
> 
>> @@ -126,7 +143,7 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
>>  				   union ib_gid *mgid)
>>  {
>>  	struct rxe_mcg *grp;
>> -	struct rxe_mca *elem, *tmp;
>> +	struct rxe_mca *mca, *tmp;
>>  
>>  	grp = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
>>  	if (!grp)
>> @@ -134,33 +151,30 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
>>  
>>  	spin_lock_bh(&grp->mcg_lock);
>>  
>> +	list_for_each_entry_safe(mca, tmp, &grp->qp_list, qp_list) {
>> +		if (mca->qp == qp) {
>> +			list_del(&mca->qp_list);
>>  			grp->num_qp--;
>> +			if (grp->num_qp <= 0)
>> +				__rxe_destroy_mcg(grp);
>>  			atomic_dec(&qp->mcg_num);
>>  
>>  			spin_unlock_bh(&grp->mcg_lock);
>> +			rxe_drop_ref(grp);
> 
> Wwhere did this extra ref come from?
> 
> The grp was threaded on a linked list by rxe_attach_mcast, but that
> also dropped the extra reference.
> 
> The reference should have followed the pointer into the linked list,
> then it could be unput here when unthreading it from the linked list.
> 
> To me this still looks like there should be exactly one ref, the
> rbtree should be removed inside the release function when the ref goes
> to zero (under the pool_lock) and doesn't otherwise hold a ref
> 
> The linked list on the mca should hold the only ref and when
> all the linked list is put back the grp can be released, no need for
> qp_num as well.
> 
> Jason

Here is a rough picture of what is going on. When not active there are pointers to
each mcg in the red-black tree (from a parent of the rb_node contained in mcg) and
if there are attached qp's there are a pair of pointers from the head and tail of the
linked list else none. When active in either verbs or packet processing code there
is a pointer to mcg held in a local variable by the routine obtained from looking
up the mcg in the tree.

                                  +-----+
                                  | rxe |
                                  +-----+
                                     |
                                   +-v-+
                           +-------|rb |-------+
                           |       +---+       |
                           |                 +-v-+
                           |                 |rb |
                        +--v--+              +---+
                        |(rb) |
       +--------------->| mcg |<---------------+
       |                +-----+                |
       |                                       |
       |    +-----+     +-----+     +-----+    |
       +--->| mca |<--->| mca |<--->| mca |<---+
            +-----+     +-----+     +-----+
               |           |           |
               |           |           |
            +--v--+     +--v--+     +--v--+
            | qp  |     | qp  |     | qp  |
            +-----+     +-----+     +-----+

as currently written the local variable has a kref obtained from the kref_get in
rxe_lookup_mcg or the kref_init in rxe_init_mcg if it is newly created. This ref is
dropped when the local variable goes out of scope. To protect the mcg when it is
inactive at least one more ref is required. I take an additional ref in rxe_get_mcg
if the mcg is created to protect the pointer in the red-black tree. This persists
for the lifetime of the object until it is destroyed when it is removed from the tree
and has the longest scope. This is enough to keep the object alive (it works fine BTW.)
It is also possible to take ref's representing the pointers in the list but they
wouldn't add anything.

On the other point. Is it standard practice to user ERRPTRs in the kernel rather than
return arguments? I seem to have seen both styles used but it may have been my imagination. I don't have any preference here but sometimes choose one or the other
in parallel flows to make comparable routines in the flows have similar interfaces.

Bob
