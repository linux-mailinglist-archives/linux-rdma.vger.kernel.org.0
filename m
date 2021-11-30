Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6A9463F00
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Nov 2021 21:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbhK3UI2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Nov 2021 15:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbhK3UIY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Nov 2021 15:08:24 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7257C061574
        for <linux-rdma@vger.kernel.org>; Tue, 30 Nov 2021 12:05:04 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id p2-20020a4adfc2000000b002c2676904fdso7047138ood.13
        for <linux-rdma@vger.kernel.org>; Tue, 30 Nov 2021 12:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lC3ALNhmMwo++64sAuvDgPIjdv91YSbZMMKdLxbc1X8=;
        b=bLVt9N5PetII6soJQI0L2BO/PqdXFUc4Yw8X/t9tftjd3TQQFbiqe87KaYVmhUw3M3
         xjH7aHRunTq6FcdzHyScGw/3gHhKYukJRxwPUJUBCxh9f+iQqZA0ARsLBrCaZjdVZ1//
         5POZvQuStyeR4QZVYtT6rdTGrwV5zX5XdrQi4gu6v/TjNDHDjbZ8BOXOhA09/s/JD4Va
         NYEyXnk6B+xDPYiw54ryO1jh3CxpLg0P3Vn4MGXD3c2VXrUPq7pXsn1G8QM/gYSqb1B5
         1debZbvq8wwK/8ApmpX+PpoxG0TVEr7wuFzhFJuW0pkGn7wF8T61RgOh+wZyuqogkpsq
         eToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lC3ALNhmMwo++64sAuvDgPIjdv91YSbZMMKdLxbc1X8=;
        b=Cgvlm/RV36NmXQVgq8n0s335xMgZ4h3S2XTvu8WGroS4goal0IiTDjuFeRmLwAsW85
         vJf3pza03wXwC/L+xMQQypkm4P6WowL7Y5lAnF/BR1o52m0Ai2RU63M8kqkD+D/MyV7B
         5FC548kkMZQaG5Kvkd8ifq3UFu+UTLN7yq91Ty33z8MPhDr5lsfsZWQOSukQrimLjqgS
         DYC8Jjs090dhlhjR/Iq9R7ikYciQCVmRv5eEjDxyTK4afdsjMq5GJ7f1Ox0UsL5iOqee
         nUCf4Dzafb8NWCGwInKYxUxphwfwv8wRA0Bj/e2raKKVUCHFeY07Z07RZBgETOs5q64W
         ihdw==
X-Gm-Message-State: AOAM530oh+KJ7ulzipSK+VwxExtE01QIxOOepoLfy9fAXUuvKBtJrP4A
        x+J7MjBN3n7ex34ohSXUi/I=
X-Google-Smtp-Source: ABdhPJypGc70n5ncXL82Bt6ERVNU2d7c4YmwMpkoQSzHQ5pWpdZq10pYJySy+NsrT33VbTY0n9Jx/w==
X-Received: by 2002:a4a:d68f:: with SMTP id i15mr924174oot.77.1638302704194;
        Tue, 30 Nov 2021 12:05:04 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:dd05:4465:8509:1390? (2603-8081-140c-1a00-dd05-4465-8509-1390.res6.spectrum.com. [2603:8081:140c:1a00:dd05:4465:8509:1390])
        by smtp.gmail.com with ESMTPSA id w17sm3322436oth.17.2021.11.30.12.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 12:05:03 -0800 (PST)
Message-ID: <9044234b-76b4-3c6a-6d85-dcfdcff240e9@gmail.com>
Date:   Tue, 30 Nov 2021 14:05:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH for-next v4 10/13] RDMA/rxe: Prevent taking references to
 dead objects
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
 <20211103050241.61293-11-rpearsonhpe@gmail.com>
 <20211119174537.GC2988708@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20211119174537.GC2988708@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/19/21 11:45, Jason Gunthorpe wrote:
> On Wed, Nov 03, 2021 at 12:02:39AM -0500, Bob Pearson wrote:
>> Currently rxe_add_ref() calls kref_get() which increments the
>> reference count even if the object has already been released.
>> Change this to refcount_inc_not_zero() which will only succeed
>> if the current ref count is larger than zero. This change exposes
>> some reference counting errors which will be fixed in the following
>> patches.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>  drivers/infiniband/sw/rxe/rxe_pool.h | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
>> index 6cd2366d5407..46f2abc359f3 100644
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.h
>> @@ -7,6 +7,8 @@
>>  #ifndef RXE_POOL_H
>>  #define RXE_POOL_H
>>  
>> +#include <linux/refcount.h>
>> +
>>  enum rxe_pool_flags {
>>  	RXE_POOL_AUTO_INDEX	= BIT(1),
>>  	RXE_POOL_EXT_INDEX	= BIT(2),
>> @@ -70,9 +72,15 @@ int __rxe_pool_add(struct rxe_pool *pool, struct rxe_pool_elem *elem);
>>  
>>  void *rxe_pool_get_index(struct rxe_pool *pool, unsigned long index);
>>  
>> -#define rxe_add_ref(obj) kref_get(&(obj)->elem.ref_cnt)
>> +static inline int __rxe_add_ref(struct rxe_pool_elem *elem)
>> +{
>> +	return refcount_inc_not_zero(&elem->ref_cnt.refcount);
>> +}
> 
> Don't reach inside a kref to touch the
> refcount. kref_get_unless_zero() is the api for krefs

Yes. Thanks for pointing this out. I had started using the refcount APIs instead of the
kref APIs for a different one that is not supported by kref and then quit using it.
This is a cleaner solution.
> 
> I'm not sure how any of this works, ie rxe_create_qp() stuffs a core
> allocated object into the pool, and various places do refcounting on
> it
I have been having a long running discussion with Leon about rxe's use of ref counting.
His opinion is that it isn't required at all and that rdma-core is doing enough. I think
that we either have to push the problem onto the apps (e.g. return EAGAIN or EBUSY) or
let the driver sleep if there are currently active packets being processed with a mutex
or semaphore. Additionally we need to cleanup some bad code that makes things not work as
mentioned.
 
> 
> But then rxe_destroy_qp doesn't seem to do anything with the
> refcounts, it just blindly lets things go to kfree in the core.
> 
> Seems really confused..
> 
> Jason
> 

