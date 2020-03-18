Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C051896CC
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 09:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgCRIXL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 04:23:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35610 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgCRIXK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 04:23:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id m3so2183330wmi.0
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 01:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eWYN2Db9ZcqvQrB3OwtrasTgq/eyNiz5vz104R0BA2w=;
        b=Fc/7F8BeJnANyKXD0LIUJldAiLur3AMYTZQlNA/3XLUEEJdoD9WurQp4Nw3tMjFYYG
         NeNbbp/rdn3zaKMKEyvsnHpnsNs6Q6J/HEYvp7WAb2mzZ1RGiqW1+8pTAzT07A3xX3bS
         FUkLExfuo17ulaIKopPd9aACwA9oos7w+HpV8DveXiKiS03Y1PXPNGq6Rg884YV2w0hU
         MFIlniWdjO79dvYbuH1WGiYA3X80I72hl/Flk8RNiFLHzDdQILNKhUOrMPrWVkij+mby
         3Jhx4fEgsckBuRwQQTH53mSzeqOcVOXZ+xr8RRvmnASjBTltLOfAJnRWfrPvAL9z9e8k
         rNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eWYN2Db9ZcqvQrB3OwtrasTgq/eyNiz5vz104R0BA2w=;
        b=B6+LufWYDqRm0NNu/24UuVzS1GbvqxWutGrCE6k1389qpOvRTXn404QAFNpsCxTlAF
         l6Ue8IHx6prMwzpr8o7DLRPVFjcxoFbolb13sFVNczAfrogM93QjF1mOk+FUAnfaLxek
         acgVpOtuSa6lOV4i+nXu1YJ0Q5JKFqp6roeDn7UVl116pekr0pE1fykCyu/FLnCib59y
         A9RFACXvp0aqQK4Uq9zo5FowNt1t0rlwFg0v8c15WCA16nuU3DRb+BoOkfjVionx1Omn
         cU2P0J/JweeSFMUIf6pA9riUPRTW03D08cI8zVgzq7q3ravQksYCQOuc2/f0/WMQU5Sc
         cZMQ==
X-Gm-Message-State: ANhLgQ3XF3G3x/84Q5yErwI64kr+ey3u3uCL/kvgLOC+2dUQNyJt7Yhs
        89BDgvhjTqPWSjhd67ej4UxaPJjCxiE=
X-Google-Smtp-Source: ADFU+vsPJr7Yysx+oxn0l2TEPMxL/hrgB3f5c3zBbKlTW7r2jfWRBdEjoLBGPZuc84kjgLJFUfhh8w==
X-Received: by 2002:a1c:208a:: with SMTP id g132mr3742439wmg.44.1584519312789;
        Wed, 18 Mar 2020 01:15:12 -0700 (PDT)
Received: from [10.0.0.57] ([5.22.133.241])
        by smtp.googlemail.com with ESMTPSA id k133sm3020322wma.11.2020.03.18.01.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 01:15:12 -0700 (PDT)
Subject: Re: Lockless behavior for CQs in userspace
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Boyer <aboyer@pensando.io>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-rdma@vger.kernel.org, maorg@mellanox.com
References: <6C1A3349-65B0-4F22-8E82-1BBC22BF8CA2@pensando.io>
 <20200317150057.GJ3351@unreal>
 <F97A8269-872F-4B94-8F03-7A8E26AE0952@pensando.io>
 <20200317195153.GX20941@ziepe.ca>
 <73154a58-8d65-702a-2bf3-1d0197079ed8@dev.mellanox.co.il>
 <20200318080326.GR3351@unreal>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <826a4fd1-b7fb-6651-4939-c1a388dd0646@dev.mellanox.co.il>
Date:   Wed, 18 Mar 2020 10:15:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318080326.GR3351@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/18/2020 10:03 AM, Leon Romanovsky wrote:
> On Wed, Mar 18, 2020 at 09:52:27AM +0200, Yishai Hadas wrote:
>> On 3/17/2020 9:51 PM, Jason Gunthorpe wrote:
>>> On Tue, Mar 17, 2020 at 11:10:15AM -0400, Andrew Boyer wrote:
>>>>
>>>>> On Mar 17, 2020, at 11:00 AM, Leon Romanovsky <leonro@mellanox.com> wrote:
>>>>>
>>>>> On Tue, Mar 17, 2020 at 10:45:08AM -0400, Andrew Boyer wrote:
>>>>>> Hello Leon,
>>>>>> I understand that we are not to create new providers that use environment variables to control locking behavior. The ‘new’ way to do it is to use thread domains and parent domains.
>>>>>>
>>>>>> However, even mlx5 still uses the env var exclusively to control lockless behavior for CQs. Do you have anything in mind for how to extend thread_domains or some other part of the API to cover the CQ case?
>>>>>
>>>>> Which parameter did you have in mind?
>>>>> I would say that all those parameters are coming from pre-rdma-core era.
>>>>>
>>>>> Doesn't this commit do what you are asking?
>>>>> https://github.com/linux-rdma/rdma-core/commit/0dbde57c59d2983e848c3dbd9ae93eaf8e7b9405
>>>>>
>>>>> Thanks
>>>>>
>>>>>>
>>>>>> Thank you,
>>>>>> Andrew
>>>>>>
>>>>
>>>> You are right - I got thrown off by this:
>>>>
>>>>> 	if (mlx5_spinlock_init(&cq->lock, !mlx5_single_threaded))
>>>>>                   goto err;
>>>>
>>>> If IBV_CREATE_CQ_ATTR_SINGLE_THREADED is set, it passes an argument
>>>> to the polling function to skip the lock calls entirely. So it
>>>> doesn’t matter that they are still enabled internally.
>>>
>>> Hmm, a thread domain should probably force
>>> IBV_CREATE_CQ_ATTR_SINGLE_THREADED during greation with the new API..
>>>
>>> Yishai?
>>>
>>
>> We can really consider extending the functionality of a parent domain that
>> was just added for CQ in case it holds a thread domain for this purpose.
>> However, current code enforces creating a dedicated BF as part of thread
>> domain unless we extend ibv_alloc_td() to ask only for marking the single
>> thread functionality.
>> The existing alternative is or to use the legacy ENV that mentioned above or
>> to use the ibv_cq_ex functionality which upon its creation gets an explicit
>> flag for single threaded one (i.e. IBV_CREATE_CQ_ATTR_SINGLE_THREADED).
> 
> "dedicated BF", isn't this Mellanox internal implementation?
> 

Yes, however from API point of view we can consider extending 
ibv_alloc_td() to ask for this specific usage that may prevent this 
resource allocation, unless we are fine with having it always which may 
give a benefit also for a QP that will use it down the road.

As pointed above, there are already few alternatives that may be used in 
the meantime.

Yishai

