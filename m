Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB4B4A65AB
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Feb 2022 21:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbiBAUaq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Feb 2022 15:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiBAUap (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Feb 2022 15:30:45 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB58C061714
        for <linux-rdma@vger.kernel.org>; Tue,  1 Feb 2022 12:30:45 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id b186so29492534oif.1
        for <linux-rdma@vger.kernel.org>; Tue, 01 Feb 2022 12:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VRynQPfp/B03DfRW6Z2YHbchTqnbgSF6URviljNQgqk=;
        b=GviAjBYbjaSDHKs9zLRuz02GgmaLDlAYeEDsy5EHGtxYs7f8yJ0oyvbg8N5lTnnntO
         +Km/QIDyJCai5sVUAslD3KGP39KJV22bVsVkOzNUeP1XtQSGd/Hbydbk2brFpEIAWQMz
         96Xtp6HKEEaDtjQie84tlP2ZuZdGOnzVNGhvN5dtAzt3gxjG/4xQrnNYhxRfC6s0fdC/
         /zsOkxQpCYGsHEnqUuwGpPd3HNvl7GFlaOco0MdGTon/2XHAI0RVl8laH0zqe9PmZ7Kf
         mMKKIDJBwYqfSS69omVEdaqzr/1XD4+DQt81gLPRZN/SOFb7nXxiSn6B3MupRyEzn5Mt
         TDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VRynQPfp/B03DfRW6Z2YHbchTqnbgSF6URviljNQgqk=;
        b=mqx36trmvTiEySzdO4W2qY9swIO3+n79OsQeW6af6n4GRs3fSn5hckn82Nfvh4vt1W
         wqZKq6/CJK0aXwQXOh2/maUPZCI6z0PqwGGXYhmceCgK4exZo/PgcwjLxmqfB/ulc9r9
         j501IvjFo/W5DEuPZA9JKS8ArsYT+noD8FKorcStMubU8jfESWOS4Z5vkKw06xKwqXeF
         rpXm50yq4ouRU9gvIODvQAnmv92hBz9E3EUoI6otG6dv+A1Zuoq8eEENl5gkwsKBZM5h
         KDx709UrEHIBpuENmInkILRuYyKOsEX4rUqVHsCU7nRI1J/l6uBQgohdrxx2Fbj6dY6O
         A6Vw==
X-Gm-Message-State: AOAM5325m9QHrL0qp5S9TvamcC256JjUOVig5j5h3bUByjp3koNPrAsN
        ywoWEhtQlQ3JQx4QkE6Itjk=
X-Google-Smtp-Source: ABdhPJyhQPZUsg9mXFlRHQ2h1VqXtPSvt1izAvKVNkqk5+gwAWKUGCW6cmVT9A7FxCN35j5ki+OT3A==
X-Received: by 2002:aca:1006:: with SMTP id 6mr2562136oiq.139.1643747444929;
        Tue, 01 Feb 2022 12:30:44 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:71b2:d0bc:75eb:e63d? (2603-8081-140c-1a00-71b2-d0bc-75eb-e63d.res6.spectrum.com. [2603:8081:140c:1a00:71b2:d0bc:75eb:e63d])
        by smtp.gmail.com with ESMTPSA id u3sm10762874oie.30.2022.02.01.12.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 12:30:44 -0800 (PST)
Message-ID: <f01397f3-4e75-933f-2d7c-2ec0b7a757e5@gmail.com>
Date:   Tue, 1 Feb 2022 14:30:43 -0600
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
 <e1b6b398-ebe2-f5aa-e34f-58b786608b1b@gmail.com>
 <20220201201452.GO1786498@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220201201452.GO1786498@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/1/22 14:14, Jason Gunthorpe wrote:
> On Tue, Feb 01, 2022 at 02:00:09PM -0600, Bob Pearson wrote:
> 
> 
>> as currently written the local variable has a kref obtained from the kref_get in
>> rxe_lookup_mcg or the kref_init in rxe_init_mcg if it is newly created. This ref is
>> dropped when the local variable goes out of scope. To protect the mcg when it is
>> inactive at least one more ref is required. I take an additional ref in rxe_get_mcg
>> if the mcg is created to protect the pointer in the red-black tree. This persists
>> for the lifetime of the object until it is destroyed when it is removed from the tree
>> and has the longest scope. This is enough to keep the object alive (it works fine BTW.)
>> It is also possible to take ref's representing the pointers in the list but they
>> wouldn't add anything.
> 
> I think I got it upside down, but OK this works for me. What was
> kbuild complaining about?
> 
>> On the other point. Is it standard practice to user ERRPTRs in the
>> kernel rather than return arguments? I seem to have seen both styles
>> used but it may have been my imagination. I don't have any
>> preference here but sometimes choose one or the other in parallel
>> flows to make comparable routines in the flows have similar
>> interfaces.
> 
> Always prefer errptrs.
> 
> Jason

this API is a little different than most of the verbs APIs where typically we have

obj = xx_create_obj()
	takes a reference at kref_init() and doesn't drop it on the non error path.
	returns obj.

xx_other_code_using_obj(obj)
	uses obj holding ref

xx_destroy_obj(obj)
	drops the ref to obj

here the object is a local variable in xx_mcast_attach() and nothing is returned.

For InfiniBand the create and destroy mcast group function is triggered by MADs
from some central mcast server. For RoCEv2 that doesn't happen and these APIs
don't exist.

	
a missing static declaration at line 262. If you want me to I can fix it and resend.
Do I really have to mint new version?

Bob

