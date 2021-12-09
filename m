Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A2046DF69
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 01:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbhLIAaX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Dec 2021 19:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbhLIAaV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Dec 2021 19:30:21 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256E6C061746
        for <linux-rdma@vger.kernel.org>; Wed,  8 Dec 2021 16:26:49 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so4502404otu.10
        for <linux-rdma@vger.kernel.org>; Wed, 08 Dec 2021 16:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=v42waUpp1qNvPZrhGHHInkkwcQLBvI7R7bD2v3Sd2MY=;
        b=JzuRjDQ9jqOKoDl9fKd6audMqX+oVQxYR/8Rjibg2W+2MKcAjKp+Mavx8M2O4thWr3
         i/AC8d7ER9mRXvBvs8MUfbi4E70tkx2khHlRp/N5gNXie5DddR0yF+EArD0xRmwfADcz
         mDus4++9pBaX4NHxHS5yHcMxNijw+k2y8JDRgG4JGzGZqWr3/HuqKYJTjGysds6G0uLx
         2czQRpwakMlphjf43qS+Z7nKSP2kjZM0dwK3+Kr3Qz7QSxq2PDm6lNgsr1WvdhokLrT4
         GgibeER0yCcgqy1aOaWTvKIkPC5Gub1rNepUcS9ETkSDY7nVsJqj0eFWD2x9Ojkux1RG
         cUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v42waUpp1qNvPZrhGHHInkkwcQLBvI7R7bD2v3Sd2MY=;
        b=yw8+XI+HTABn82gRjbBItOFP1CmBdN9RAzc4idHwMjR9QtHQ0zL/TIjtYj9+zRb5UU
         vs+Fa6bl7fighZySxjmEwl7CMuhb0VBj8csfhVLASAxNyLl69jfqoSNycK2V03o8WBnD
         o2g78Sg/VhYXA+vCyL0vdZHT+mTYxdypzfBdCMR3e/6o/vBQAd405q0Ys7Lv5o6xonDT
         HrhIh1WP1libn5mphas0b7XOyG805urtYo4fnCfxa0earUfSD+4v3dngeleZ9QMz1jmR
         0mxzlQL/P9xWMI04Kxv7l4Zvmv1bMjWY+9a2gGEsvje6NszXllQbT57JyA5rWBD9Yox3
         LSOw==
X-Gm-Message-State: AOAM530T7K79LrcEYFW5JC03zEFaP4+Wa9MvkVY8epoCmyVfeRBdNOqo
        zvVKXy/MdWzXI3mP65bOCNc=
X-Google-Smtp-Source: ABdhPJyZD2qhXWbqlc9AJamK3bDcxXrI9x2hqI2sFA9eQ3Lu2gbRZQ+B1j4fDRFNETxvoXK6zaDTNw==
X-Received: by 2002:a9d:6d98:: with SMTP id x24mr2471165otp.371.1639009608468;
        Wed, 08 Dec 2021 16:26:48 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:6c59:bf97:7747:3006? (2603-8081-140c-1a00-6c59-bf97-7747-3006.res6.spectrum.com. [2603:8081:140c:1a00:6c59:bf97:7747:3006])
        by smtp.gmail.com with ESMTPSA id bd6sm1088116oib.53.2021.12.08.16.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 16:26:48 -0800 (PST)
Message-ID: <61c4b5b5-bd04-4f82-dfd8-1603a02db1ed@gmail.com>
Date:   Wed, 8 Dec 2021 18:26:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH for-next v6 1/8] RDMA/rxe: Replace RB tree by xarray for
 indexes
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20211206211242.15528-1-rpearsonhpe@gmail.com>
 <20211206211242.15528-2-rpearsonhpe@gmail.com>
 <20211207190947.GH6385@nvidia.com>
 <dc322ec4-bbcc-77eb-0c84-5461d08c5378@gmail.com>
 <20211209001848.GK6385@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20211209001848.GK6385@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/8/21 18:18, Jason Gunthorpe wrote:
> On Wed, Dec 08, 2021 at 06:16:21PM -0600, Bob Pearson wrote:
>> On 12/7/21 13:09, Jason Gunthorpe wrote:
>>> On Mon, Dec 06, 2021 at 03:12:36PM -0600, Bob Pearson wrote:
>>>>  	if (pool->flags & RXE_POOL_INDEX) {
>>>> -		pool->index.tree = RB_ROOT;
>>>> -		err = rxe_pool_init_index(pool, info->max_index,
>>>> -					  info->min_index);
>>>> -		if (err)
>>>> -			goto out;
>>>> +		xa_init_flags(&pool->xarray.xa, XA_FLAGS_ALLOC);
>>>> +		pool->xarray.limit.max = info->max_index;
>>>> +		pool->xarray.limit.min = info->min_index;
>>>> +	} else {
>>>> +		/* if pool not indexed just use xa spin_lock */
>>>> +		spin_lock_init(&pool->xarray.xa.xa_lock);
>>>
>>> xarray's don't cost anything to init, so there is no reason to do
>>> something like this.
>> OK
>>>
>>>> +/* drop a reference to an object */
>>>> +static inline bool __rxe_drop_ref(struct rxe_pool_elem *elem)
>>>> +{
>>>> +	bool ret;
>>>> +
>>>> +	rxe_pool_lock_bh(elem->pool);
>>>> +	ret = kref_put(&elem->ref_cnt, rxe_elem_release);
>>>> +	rxe_pool_unlock_bh(elem->pool);
>>>
>>> This is a bit strange, why does something need to hold a lock around a
>>> kref?
>>
>> This also relates to your comment on 8/8 patch. There seems to be a race opportunity
>> between the call to kref_put(&obj->elem, rxe_elem_release) and the call in
>> rxe_elem_release() to xa_erase(). If a duplicate or delayed packet arrives after the the
>> final kref_put() and before the xa_erase() one can still lookup the object from its index
>> (qpn, rkey, etc.) and take a reference to it. The use of kref_get_unless_zero and
>> locking around kref_put and __xa_erase was an attempt to fix this. Once you call kref_put
>> with the ref count going to zero there is no way to prevent the object getting its
>> cleanup routine called.
> 
> This is why you use kref_get_not_zero only during the xa lookup, then
> during that race it returns failure
> 
> Costs nothing as the atomics are already all required.
> 
> Jason
> 
Thanks. -- Bob
