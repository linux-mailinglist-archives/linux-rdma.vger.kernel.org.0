Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BB1347F50
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Mar 2021 18:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbhCXR0Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Mar 2021 13:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbhCXR0A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Mar 2021 13:26:00 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8760BC061763
        for <linux-rdma@vger.kernel.org>; Wed, 24 Mar 2021 10:25:59 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso23762185otq.3
        for <linux-rdma@vger.kernel.org>; Wed, 24 Mar 2021 10:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Talg//jNez3Um6RgMNtTXG/uLhQRzEmJD4UUoEVMNy8=;
        b=PVuFVtnMKkFiaasGpDcY7Fr9vKoMKgTZ+EX08U0hBm8YUP4N9g+diOyoSpNjaTmgF+
         4CxQlJa1WwULUjj8++4wRIqhxwYbnW8sa0kuB8NPrVPdV+LiV8YNM47vYB0CQn2QKLyc
         VRQ6TGVojR0ktbsaha1rEForsbyRYbhhPX9EKqP1oBEWqIZ2iu+bTfI/pF6e85VEwIHB
         UCzQDH0tgHpI5bQGVd7eBKGAC5PsjFRP+v4OpuhkYzpU9PNK4rmJyF00VbbmsbFBCZh9
         xnJVU5Qjy8NPorpf2c9cHyG1pz6pQp/RIGPpSX009/0GE/qCBhHaJfC1Bd7NES/vlw+w
         MvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Talg//jNez3Um6RgMNtTXG/uLhQRzEmJD4UUoEVMNy8=;
        b=dJW7UjX7r4ShqLrT8Xf4t5h9nlosx+d4J5LqiAzwGc4jkQVL5gThm7uVY6Z4gkw43V
         WFqSKcHK0r428nnos3hK01HcSfWpJ43rwpzn4Ql6mOcmjfFQICpipQSZt2pafiSQaDKI
         pkw3osN9gTRyg9vyzk0elXSw0eN5EAie1F1S7gvrRFqnXGNm1/Uqrmir0e3+mDlruzrp
         hltOx7ikC0u+QNINnSQ9JWWvxcTPjaxfn9gzMRHN3xPzNYa3SDLPQGn7Qspi/1pplEcb
         yaY+KtbOcfOfdjlYxP4iwWlXC01Q4xrQXERG8Xgrl0M6NEDGjmoDZlhufG2GlMXcJzwF
         gRvQ==
X-Gm-Message-State: AOAM530etwqurFweZj2ofFJ+OY1c6jc623du3skFOBA1V8ElxVoWXESi
        VLj4TImeZfMos2hBNqW/TsM=
X-Google-Smtp-Source: ABdhPJyxw8c5YtrkeoWsdAQa478jn+AwzzhAUFL0+0zpsAzU1zU4a4J7AGAVgVJUpKd4z+dRZediBw==
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr3888295otq.107.1616606758932;
        Wed, 24 Mar 2021 10:25:58 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:3e64:9e65:c6e4:cc20? (2603-8081-140c-1a00-3e64-9e65-c6e4-cc20.res6.spectrum.com. [2603:8081:140c:1a00:3e64:9e65:c6e4:cc20])
        by smtp.gmail.com with ESMTPSA id c25sm727837otk.35.2021.03.24.10.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 10:25:58 -0700 (PDT)
Subject: Re: [PATCH for-next] RDMA/rxe: Split MEM into MR and MW
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
References: <20210314222612.44728-1-rpearson@hpe.com>
 <CAD=hENdyLYLYAyS0Mq_jUb-Vm3P102hiw2Lzmz=hjvgcBn1t-g@mail.gmail.com>
 <c7fd30e5-dfd8-cd95-3b69-ea94432953fd@gmail.com>
 <20210324170721.GN2356281@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <526172c5-b48b-4788-b9d8-7dc37c975033@gmail.com>
Date:   Wed, 24 Mar 2021 12:25:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210324170721.GN2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/24/21 12:07 PM, Jason Gunthorpe wrote:
> On Wed, Mar 24, 2021 at 11:52:19AM -0500, Bob Pearson wrote:
>>>> +struct rxe_mw {
>>>> +       struct rxe_pool_entry   pelem;
>>>> +       struct ib_mw            ibmw;
>>>> +       struct rxe_qp           *qp;    /* type 2B only */
>>>> +       struct rxe_mr           *mr;
>>>> +       spinlock_t              lock;
>>>> +       enum rxe_mw_state       state;
>>>> +       u32                     access;
>>>> +       u64                     addr;
>>>> +       u64                     length;
>>>> +};
>>>
>>>  struct rxe_qp           *qp;    /* type 2B only */
>>>  struct rxe_mr           *mr;
>>>  spinlock_t              lock;
>>>  enum rxe_mw_state       state;
>>>  u32                     access;
>>>  u64                     addr;
>>>  u64                     length;
>>>
>>> The above member variables are not used in your commit. Why keep them
>>> in this struct rxe_mw?
>>>
>>> Zhu Yanjun
>>>
>>
>> There is more to come. The goal here is to implement MW and peeking ahead
>> MWs need each of those fields. As soon as this change gets accepted I will start
>> adding code to implement the MW verbs APIs.
> 
> The requirement is to add things when you need them, so if these are
> unused here they should move to the patch that requires them
> 
> Jason
> 
OK can do. I need to wait another day to see if Zhu is ready to accept the whole idea
of renaming these things. There are two other nits in this patch that I could change.
There was one whitespace change that could come separately (n spaces -> tab) and Leon
moved the MW into core since the first time I sent this in which requires reversing
the order of the ibmw atruct and the pelem struct in mw. It has to change before the
mw struct can actually be used. What do you think?

bob
