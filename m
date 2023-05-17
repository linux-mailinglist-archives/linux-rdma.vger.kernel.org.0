Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F55705CB6
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 03:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjEQB6E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 May 2023 21:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjEQB6D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 May 2023 21:58:03 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A6E420A
        for <linux-rdma@vger.kernel.org>; Tue, 16 May 2023 18:57:59 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-19638b3a304so132155fac.1
        for <linux-rdma@vger.kernel.org>; Tue, 16 May 2023 18:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684288679; x=1686880679;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7sxLmiZiAn5aDa90uV7NXYMBWQssHO8ljFEDWZ0lpnU=;
        b=R3pOHrrPcJiuI4BXEWHJQNuO9dCB2bzdt21TI/Q+qVN3Pa8PYZRzf4R9FN0mP+t2XG
         3P6HOEcmpKxq+kAZ7jjKobaupwrw2ZRtnct5gRZu7R54UCcB8NIncOWw4jmRiAPmPyOe
         a16+3d2FPHJyD9PDCLjd/+XsGrjSvno5XXHpiarcLdxI1utl0/6kcmec6nwPGVy3Gr5A
         fs0fn6gYiPjj9UUt9HDG50RaQfWTpcZO98dufBglLflKVGt4wAV9xVp5f3RNFAUEm2bI
         yFpPpbyjzuUsHPMxfncdTOMhN9SMt1KzPxsuVRy8uB9+oD144mFFhs7Qh/dCf+qZzToR
         /hXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684288679; x=1686880679;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sxLmiZiAn5aDa90uV7NXYMBWQssHO8ljFEDWZ0lpnU=;
        b=d6gJzhrO6HCL93c6agYNnw7cx8E6wwmSidZsw6618tfQxdyl6XtIFEiyd3SZnmVfaN
         JSiFOyDz/lMVY5G1j9QnbJ3cGXg/iJIEaxCoiN42pa6fvFesKnvd8cLDO+upqgqk+A//
         yNTtcXask35a09fccgSUWFNWsu7bEbj2QALsQprf258kkpz0rchi/KyzUGHmwZzHaacb
         6hdvEiHrCE32VoBEyUq/ppec/oq59fUO2mq5VRn1GyUlgtBE2G4PTIJ5U35V0ecuU5XZ
         ORtw3j/iNmk8WQa414q5qNxARQzsrzwbSnARgMeNc3nxSXC8w0GWeyfazXnerjW9adoM
         veHg==
X-Gm-Message-State: AC+VfDzDQ4P65+yeajCb6QvcoExsA6R1LuLCLy2Of/GNmw3VrFVrDizY
        cet0cGc0AqwhQEoY1+PQzxE=
X-Google-Smtp-Source: ACHHUZ5/JIdpZj0eVsjtOYFJLyA/K/yG2rjm392iueQg9Yrbe/8u1wLAHvMhopyjHeAFRyzKPV7Gxw==
X-Received: by 2002:a05:6870:3504:b0:19a:1331:9d4d with SMTP id k4-20020a056870350400b0019a13319d4dmr200089oah.23.1684288677348;
        Tue, 16 May 2023 18:57:57 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:6756:74e8:3efd:d9c5? (2603-8081-140c-1a00-6756-74e8-3efd-d9c5.res6.spectrum.com. [2603:8081:140c:1a00:6756:74e8:3efd:d9c5])
        by smtp.gmail.com with ESMTPSA id n40-20020a056870822800b00199c3a06f7esm2986084oae.51.2023.05.16.18.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 18:57:56 -0700 (PDT)
Message-ID: <abcda1c5-d8ba-771c-1cac-20c3c2562b81@gmail.com>
Date:   Tue, 16 May 2023 20:57:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] RDMA/rxe: Convert spin_{lock_bh,unlock_bh} to
 spin_{lock_irqsave,unlock_irqrestore}
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>, zyjzyj2000@gmail.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
References: <20230510035056.881196-1-guoqing.jiang@linux.dev>
 <ZGQbwBeIqk6YMKuf@nvidia.com>
 <5d1aa20f-2cd0-5400-69e9-057ede404ae4@gmail.com>
 <ZGQiMsBAWhyACuxK@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZGQiMsBAWhyACuxK@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/16/23 19:39, Jason Gunthorpe wrote:
> On Tue, May 16, 2023 at 07:32:35PM -0500, Bob Pearson wrote:
>> On 5/16/23 19:11, Jason Gunthorpe wrote:
>>> On Wed, May 10, 2023 at 11:50:56AM +0800, Guoqing Jiang wrote:
>>>> We need to call spin_lock_irqsave/spin_unlock_irqrestore for state_lock
>>>> in rxe, otherwsie the callchain
>>>>
>>>> ib_post_send_mad
>>>> 	-> spin_lock_irqsave
>>>> 	-> ib_post_send -> rxe_post_send
>>>> 				-> spin_lock_bh
>>>> 				-> spin_unlock_bh
>>>> 	-> spin_unlock_irqrestore
>>>>
>>>> caused below traces during run block nvmeof-mp/001 test.
>>> ..
>>>  
>>>> Fixes: f605f26ea196 ("RDMA/rxe: Protect QP state with qp->state_lock")
>>>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>>>> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>> ---
>>>>  drivers/infiniband/sw/rxe/rxe_comp.c  | 26 +++++++++++--------
>>>>  drivers/infiniband/sw/rxe/rxe_net.c   |  7 +++---
>>>>  drivers/infiniband/sw/rxe/rxe_qp.c    | 36 +++++++++++++++++----------
>>>>  drivers/infiniband/sw/rxe/rxe_recv.c  |  9 ++++---
>>>>  drivers/infiniband/sw/rxe/rxe_req.c   | 30 ++++++++++++----------
>>>>  drivers/infiniband/sw/rxe/rxe_resp.c  | 14 ++++++-----
>>>>  drivers/infiniband/sw/rxe/rxe_verbs.c | 25 ++++++++++---------
>>>>  7 files changed, 86 insertions(+), 61 deletions(-)
>>>
>>> Applied to for-rc, thanks
>>>
>>> Jason
>>
>> You didn't mention it but this shouldn't have applied/compiled without
>> fixing the overlap of these two patches. ??
> 
> oh, I fixed it, it is trivial
> 
> Jason

I figured. Thanks.

Bob
