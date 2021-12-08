Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A0C46DD8B
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Dec 2021 22:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhLHVYl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Dec 2021 16:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbhLHVYk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Dec 2021 16:24:40 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9992C061746
        for <linux-rdma@vger.kernel.org>; Wed,  8 Dec 2021 13:21:08 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 7so5791244oip.12
        for <linux-rdma@vger.kernel.org>; Wed, 08 Dec 2021 13:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vAKoiFqwMEu+3mTZw8oyRWirKFl9JIIoKnIX4BghPg4=;
        b=OvwO7yAe45AbvOMCi02KpamPrSCM32UvbsYZH5xZcl0dA9OuZW8dslSarySBZzZJkP
         Zc8A2L9M29RpMxfkkrArZw2Kg+C7tkDf/+ys1TlV6OYvb9qRt6ErIWexOg+6NyUnkDjy
         ZDRVferckKrkEfAoDxWR0iCdvQZAIdQ/TrJf5P8xLeAYUN17bvplvRRpo5/xCs8/rlMy
         ZCzTPB4xxq4Yu7kmtgkcnDhRsT7RrCvHL4pQCDT2w1ATBJoVQ7kEorSxk7oe1jzgG80e
         SRx0vYuz5yFyoa7HsTOoJ4x6k7pGu+x31m3tCDy+9Gs53mlN2nwC148YKhS2zTMGKgMW
         sjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vAKoiFqwMEu+3mTZw8oyRWirKFl9JIIoKnIX4BghPg4=;
        b=LWg3V/y8chuTd9WQUfDHmY51Y3YeU8kDopdFxRB4/u3Fu0s9PR5NbOu5uHu4483lQv
         bLFEc1yW/ASqkZ0lxygRCCfH4VqhC55CBa/9UREYFdthbAzSoqzZBwIotkEQ4LDuYqsF
         lLuls5BnrUYC1+3cF6in8aUY30o3VRaOaJKATcxwjqhIZ0OQEaWjkF/bv7KZVlgd3h3A
         mFAUujEwb3cJdOYqo+Brf4O141H7zhNAF/iQZHSuhc4LW4h7/zMgPfa1WSqI+KpjQdjt
         ZYZTREea1Sq1p/bzC2ML1t/rtlPpDR9Rrrif5NB1/kd6PNa69geQGv1wup6ND6EYRyGS
         nPeA==
X-Gm-Message-State: AOAM530cPNfEpSChZ9FbtKbvle9tszFtdFnAfblxzgefcOA+nQAb8t1a
        eFMfT4W7JlttSxDhXRv2QvU=
X-Google-Smtp-Source: ABdhPJymZoMu9WDPNEVVid0dfAivIqQflQqx6nZEPtQyFUei9ED55Hjxc38BigSw/viq8n+j1QxKpw==
X-Received: by 2002:a05:6808:1984:: with SMTP id bj4mr1972768oib.165.1638998467996;
        Wed, 08 Dec 2021 13:21:07 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:6c59:bf97:7747:3006? (2603-8081-140c-1a00-6c59-bf97-7747-3006.res6.spectrum.com. [2603:8081:140c:1a00:6c59:bf97:7747:3006])
        by smtp.gmail.com with ESMTPSA id k14sm676940otb.50.2021.12.08.13.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 13:21:07 -0800 (PST)
Message-ID: <6ff5a719-d290-0f67-98b2-116cb1d3431f@gmail.com>
Date:   Wed, 8 Dec 2021 15:21:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH for-next v6 8/8] RDMA/rxe: Add wait for completion to obj
 destruct
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20211206211242.15528-1-rpearsonhpe@gmail.com>
 <20211206211242.15528-9-rpearsonhpe@gmail.com>
 <20211207192824.GJ6385@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20211207192824.GJ6385@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/7/21 13:28, Jason Gunthorpe wrote:
> On Mon, Dec 06, 2021 at 03:12:43PM -0600, Bob Pearson wrote:
>> This patch adds code to wait until pending activity on RDMA objects has
>> completed before freeing or returning to rdma-core where the object may
>> be freed.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> v6
>>   Corrected incorrect comment before __rxe_fini()
>>   Added a #define for complete timeout value.
>>   Changed type of __rxe_fini to int to return value from wait_for_completion.
>>  drivers/infiniband/sw/rxe/rxe_comp.c  |  4 +-
>>  drivers/infiniband/sw/rxe/rxe_mcast.c |  4 ++
>>  drivers/infiniband/sw/rxe/rxe_mr.c    |  2 +
>>  drivers/infiniband/sw/rxe/rxe_mw.c    | 14 +++--
>>  drivers/infiniband/sw/rxe/rxe_pool.c  | 31 +++++++++-
>>  drivers/infiniband/sw/rxe/rxe_pool.h  |  4 ++
>>  drivers/infiniband/sw/rxe/rxe_recv.c  |  4 +-
>>  drivers/infiniband/sw/rxe/rxe_req.c   | 11 ++--
>>  drivers/infiniband/sw/rxe/rxe_resp.c  |  6 +-
>>  drivers/infiniband/sw/rxe/rxe_verbs.c | 84 ++++++++++++++++++++-------
>>  10 files changed, 126 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
>> index f363fe3fa414..a2bb66f320fa 100644
>> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
>> @@ -562,7 +562,9 @@ int rxe_completer(void *arg)
>>  	enum comp_state state;
>>  	int ret = 0;
>>  
>> -	rxe_add_ref(qp);
>> +	/* check qp pointer still valid */
>> +	if (!rxe_add_ref(qp))
>> +		return -EAGAIN;
> 
> This doesn't make sense..
> 
> If this already has a pointer to QP then it must already have a ref
> and add_ref cannot fail.
Good point. My first reaction to using kref_get_unless_zero() which returns a
value was to go around and check all the values to make sure no calls failed.
But you are correct. All the main tasklets depend on qp still being around since
the tasklet struct is contained inside of qp. Further all the qp references have
to be freed and the ref from kref_init before qp is freed so this call is both
safe from failing and completely unnecessary in the first place.

Bob
> 
> The kref_get_unless_zero() is a special case for something like a
> container where it is possible for the container to hold a 0 ref item
> in it.
> 
> The scheme you have makes that impossible because the container lock
> is held around the kref == 0 and list_del, so you never need
> unless_zero.
> 
> The optimization is to not hold the lock around the kref_get, allow
> the container to have a 0 ref until the release reaches list_del, and
> then lock and list_del. The reader side then needs the unless_zero
> 
> But the ONLY place unless_zero should be used is in a situation like
> that, and we should never see other failable refcount tests without
> some other clear explanation why the qp pointer with a 0 ref is not
> freed. The above doesn't qualify.
> 
> Further 
> 
> +static inline bool __rxe_add_ref(struct rxe_pool_elem *elem)
> +{
> +       return kref_get_unless_zero(&elem->ref_cnt);
> +}
> 
> Just serves to defeat refcount debugging which checks that it is
> impossible for a 0 ref to be incr'd which is proof of a use after free
> when refcounts are implemetned properly.
> 
> So I don't know what this is all about here but it needs some fixing..
> 
> Jason
> 

