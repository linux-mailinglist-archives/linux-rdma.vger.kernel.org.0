Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD084043EE
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Sep 2021 05:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348438AbhIID1V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 23:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347312AbhIID0m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Sep 2021 23:26:42 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF17C061575
        for <linux-rdma@vger.kernel.org>; Wed,  8 Sep 2021 20:25:32 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so726479otq.7
        for <linux-rdma@vger.kernel.org>; Wed, 08 Sep 2021 20:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UiwvpggGm8gyLIB/pShqLXDwNusX7+/f6iPoD9llerg=;
        b=oKvbRTSO/z8/AzfnKmtfdRifiMN21RapS5DROAG49y3Xu14u9viaLy4+vCsoStCbXG
         TB8uhgoBKIjyt92UVJjvNWpx3nsjBv7cB5W7xbbYQTXDBvF2p82RzeNZo8qa8ZtEymHf
         kSqmt1OE5NwzNfHMjrJ9kmc63jizos6scwdJzz8343nm7wVpo465kIxrpzZgidv1acJb
         alLO1f/mOqLICx8lzmkGqTVyKlV4UC6/Tn2G2YREzWoYzMevQcz1DaEc7uS9gpWiGkv7
         8yVk09PI6oNQaD6OANEjdSJwP3eaAKeSJ/CZk08bqvar+Yux8u1E7QdXl3pGSJDXjdo1
         WdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UiwvpggGm8gyLIB/pShqLXDwNusX7+/f6iPoD9llerg=;
        b=Mezz96IwM4nflqAYfLRTwPw3pTZPHlJOjJljR7lqmQv3KDy1O+zZ/6UhA3eDPH61+3
         ahtRCW9YHm1e35Qxs7y6khZAkbR9EC3vB1ck3+8NREYY+D/rVUBhsQHiI1HsVLrYZn1n
         J82bSSqukEYxPJo5D3iOSsSA7K33ZXXrms3mk1LNddV2DVq3w9jxe6Zhh/2igvp8tqLt
         nxl/obHyXPMmlidmniRdc9n/c31U10Wyn7fFKNPXoSjZLDR6eUKqNYYuk0e57lIggBnB
         GeoYH1dxqR8v1w1JJfq+vs7ZE8Xm1z3V/k1oMQ50yw25Epsa2u5wZ1mkBXLsxEJstNIJ
         XShA==
X-Gm-Message-State: AOAM530nqf1swzr4d+rDG/4YZzegr6GLZGN9ow8yKm5yoi4BujKNzBEU
        tNbd+cchsktC3oNcb8OlbSL94tzbaGhVdQ==
X-Google-Smtp-Source: ABdhPJz6mQ1BdTs+ds8lwxm4vngb3T5+YnNZ36Jw2OgueI0zIQBrkri8/m0HqK3kmOhNbzd5MCqADg==
X-Received: by 2002:a05:6830:815:: with SMTP id r21mr621880ots.219.1631157931552;
        Wed, 08 Sep 2021 20:25:31 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:7465:96d8:e8db:b915? (2603-8081-140c-1a00-7465-96d8-e8db-b915.res6.spectrum.com. [2603:8081:140c:1a00:7465:96d8:e8db:b915])
        by smtp.gmail.com with ESMTPSA id j8sm114185ooc.21.2021.09.08.20.25.31
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 20:25:31 -0700 (PDT)
Subject: Fwd: [RFC PATCH 0/3] RDMA/rxe: Add dma-buf support
References: <86086421-225c-0bde-00be-f49a028ed06d@gmail.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Forwarded-Message-Id: <86086421-225c-0bde-00be-f49a028ed06d@gmail.com>
Message-ID: <4284422c-0fd3-a4b7-4c18-cdb7aa177b2f@gmail.com>
Date:   Wed, 8 Sep 2021 22:25:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <86086421-225c-0bde-00be-f49a028ed06d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org




-------- Forwarded Message --------
Subject: Re: [RFC PATCH 0/3] RDMA/rxe: Add dma-buf support
Date: Wed, 8 Sep 2021 22:23:53 -0500
From: Bob Pearson <rpearsonhpe@gmail.com>
To: Shunsuke Mie <mie@igel.co.jp>
CC: Jason Gunthorpe <jgg@nvidia.com>

On 9/8/21 9:17 PM, Shunsuke Mie wrote:
> Hi Bob,
> 
> I agree with you. The fix has to be merged firstly. I'd like to know
> the patches.
> Is the patch for that bug fix at the following link?
> https://lore.kernel.org/linux-rdma/20210908052928.17375-1-rpearsonhpe@gmail.com/
> 
> Thanks,
> 
> 2021年9月9日(木) 7:52 Bob Pearson <rpearsonhpe@gmail.com>:
>>
>> On 9/8/21 1:16 AM, Shunsuke Mie wrote:
>>> This patch series add a support for rxe driver.
>>>
>>> A dma-buf based memory registering has beed introduced to use the memory
>>> region that lack of associated page structures (e.g. device memory and CMA
>>> managed memory) [1]. However, to use the dma-buf based memory, each rdma
>>> device drivers require add some implementation. The rxe driver has not
>>> support yet.
>>>
>>> [1] https://www.spinics.net/lists/linux-rdma/msg98592.html
>>>
>>> To enable to use the memories in rxe rdma device, add some changes and
>>> implementation in this patch series.
>>>
>>> This series consists of three patches. The first patch changes the IB core
>>> to support for rdma drivers that have not real dma device. The second
>>> patch extracts a memory mapping process of rxe as a common function to use
>>> a dma-buf support. The third patch adds the dma-buf support to rxe driver.
>>>
>>> Related user space RDMA library changes are provided as a separate
>>> patch.
>>>
>>> Shunsuke Mie (3):
>>>   RDMA/umem: Change for rdma devices has not dma device
>>>   RDMA/rxe: Extract a mapping process into a function
>>>   RDMA/rxe: Support dma-buf as memory region
>>>
>>>  drivers/infiniband/core/umem_dmabuf.c |   2 +-
>>>  drivers/infiniband/sw/rxe/rxe_loc.h   |   3 +
>>>  drivers/infiniband/sw/rxe/rxe_mr.c    | 186 +++++++++++++++++++++-----
>>>  drivers/infiniband/sw/rxe/rxe_verbs.c |  36 +++++
>>>  4 files changed, 193 insertions(+), 34 deletions(-)
>>>
>>
>> Mie,
>>
>> This looks very interesting. But, I am afraid we are going to collide. I just submitted some patches
>> to fix blktest which will very likely overlap with yours. Please take a look. It should be easy to
>> merge them. I am anxious to clear the blktest bug ASAP though.
>>
>> Bob Pearson

Mie,

I just forwarded to you the emails in the patch series. 1/5 and 2/5 are mostly elsewhere. But 2-5/5 are directly changing rxe_mr.c and especially 4/5 touches the SG to page list code. Per a recent exchange
with Jason we needed to keep two copies of the buffer list so that the kernel space API could be
used as intended and allow overlap of invalidating one MR while a new one is getting built and then
registered. In case, you can look at all the emails at https://lore.kernel.org/linux-rdma/.

Bob
