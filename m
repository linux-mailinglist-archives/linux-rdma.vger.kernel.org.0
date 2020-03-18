Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4BDF189656
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 08:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgCRHwb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 03:52:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39659 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRHwb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 03:52:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id f7so2057387wml.4
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 00:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bpxZBksPBQbZSZsLfMCh8dVry77qALamjMdjeIJSfmM=;
        b=o7fB3v6fRl7vtXH1QdmzWppWEYk8Hpk+K4FTg3RhCqmHp+MbdDuDVFa+/KYR7hITh3
         u4emgpuogR5NmpQObVR+ykgPXPCDwEoyNdcEGIO/qWgLB6AhSipsKP/vdkeHK0yYFY6P
         n4j5pyNzkGB1Rbil04xnUTmykvdOJc00mPl+q50E+yukwrses4cDiC9aXOhgAqmJCUAz
         uOBzaZAF5i0Jk32ecJwbKXCTUzOJHX+D3dcRug6vibNt3HA/1bopcOX3/qLEAy6ZEmlz
         XronT4GiA3yTk9CB2TlXnNa5smji3m5qRMHbLkdBaZIigUDAD4v+viQxS+SWhZAHVh7C
         hRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bpxZBksPBQbZSZsLfMCh8dVry77qALamjMdjeIJSfmM=;
        b=R8UXiqKzZRB31yejQjxCyXabq5A+b2xYoTAp9qnaivYTm6JzZzgkliYZiALG65cMEw
         LKHikDxGCs3gofm/fkU4zA9tvoNJYa6uqeNJWptEYmczj58yxgnEJwrHLo4aHsGH24/G
         xsylyFGqbR+4wIgM0B7eiCg6/ULDOYMDU0w1Mv77j531JlNwo8IVQ7mWXsnrv8Um3myG
         MKkxsZhRPw9FXDs6Lj7Ic/PzdtSUXmjn7VbwVeHegM3x0MIEkxUi07snnpT+c7VQVnpj
         RVkxIqSaod+v0QY8Tr+F5BlZVACeXydg/+a4n4S8mdW3yjfUM/OlpDilPiXbfRFGew7H
         1vxQ==
X-Gm-Message-State: ANhLgQ0Bj01GXAFL9mLYXfQ6xUPLQmlAXVOxXlNjugW1YYowmrmDKKtu
        2TNuk1YJI4yzBw7QiBqkqBz1gw==
X-Google-Smtp-Source: ADFU+vtUwAWJEmhI9bBejvOjl6pIPuWgN6Iz9Njyo2DM44bR0j/BmBTWf2n+oTzTNJOHWV9V46HojA==
X-Received: by 2002:a05:600c:2250:: with SMTP id a16mr3531476wmm.57.1584517949576;
        Wed, 18 Mar 2020 00:52:29 -0700 (PDT)
Received: from [10.0.0.57] ([5.22.133.241])
        by smtp.googlemail.com with ESMTPSA id u25sm2747315wml.17.2020.03.18.00.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 00:52:29 -0700 (PDT)
Subject: Re: Lockless behavior for CQs in userspace
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Boyer <aboyer@pensando.io>
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org, maorg@mellanox.com
References: <6C1A3349-65B0-4F22-8E82-1BBC22BF8CA2@pensando.io>
 <20200317150057.GJ3351@unreal>
 <F97A8269-872F-4B94-8F03-7A8E26AE0952@pensando.io>
 <20200317195153.GX20941@ziepe.ca>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <73154a58-8d65-702a-2bf3-1d0197079ed8@dev.mellanox.co.il>
Date:   Wed, 18 Mar 2020 09:52:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317195153.GX20941@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/17/2020 9:51 PM, Jason Gunthorpe wrote:
> On Tue, Mar 17, 2020 at 11:10:15AM -0400, Andrew Boyer wrote:
>>
>>> On Mar 17, 2020, at 11:00 AM, Leon Romanovsky <leonro@mellanox.com> wrote:
>>>
>>> On Tue, Mar 17, 2020 at 10:45:08AM -0400, Andrew Boyer wrote:
>>>> Hello Leon,
>>>> I understand that we are not to create new providers that use environment variables to control locking behavior. The ‘new’ way to do it is to use thread domains and parent domains.
>>>>
>>>> However, even mlx5 still uses the env var exclusively to control lockless behavior for CQs. Do you have anything in mind for how to extend thread_domains or some other part of the API to cover the CQ case?
>>>
>>> Which parameter did you have in mind?
>>> I would say that all those parameters are coming from pre-rdma-core era.
>>>
>>> Doesn't this commit do what you are asking?
>>> https://github.com/linux-rdma/rdma-core/commit/0dbde57c59d2983e848c3dbd9ae93eaf8e7b9405
>>>
>>> Thanks
>>>
>>>>
>>>> Thank you,
>>>> Andrew
>>>>
>>
>> You are right - I got thrown off by this:
>>
>>> 	if (mlx5_spinlock_init(&cq->lock, !mlx5_single_threaded))
>>>                  goto err;
>>
>> If IBV_CREATE_CQ_ATTR_SINGLE_THREADED is set, it passes an argument
>> to the polling function to skip the lock calls entirely. So it
>> doesn’t matter that they are still enabled internally.
> 
> Hmm, a thread domain should probably force
> IBV_CREATE_CQ_ATTR_SINGLE_THREADED during greation with the new API..
> 
> Yishai?
> 

We can really consider extending the functionality of a parent domain 
that was just added for CQ in case it holds a thread domain for this 
purpose. However, current code enforces creating a dedicated BF as part 
of thread domain unless we extend ibv_alloc_td() to ask only for marking 
the single thread functionality.
The existing alternative is or to use the legacy ENV that mentioned 
above or to use the ibv_cq_ex functionality which upon its creation gets 
an explicit flag for single threaded one (i.e. 
IBV_CREATE_CQ_ATTR_SINGLE_THREADED).

Yishai


