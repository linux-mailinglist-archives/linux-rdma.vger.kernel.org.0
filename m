Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AC74F8945
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 00:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiDGVs5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 17:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiDGVs4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 17:48:56 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849F763BD
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 14:46:51 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id j83so7040392oih.6
        for <linux-rdma@vger.kernel.org>; Thu, 07 Apr 2022 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=g7/53lEkeQrVDh4pTT9VcOTwPBvNDDI936NjtakcQ9U=;
        b=bAugWUrIdkli81l4uiUKxqS7YKbK0BlzWJnNb5eYjX2wNKCWTWTD0FgPLy98PS6qnD
         rRe4vHtiF1PwdjCGbGJ4mM2FXEVcMB9Z3uMwKhlOZ+tJMHkSL7tkfR9zZs7Ms5JgX7Lb
         4wU+sf+oO5PfAZuMtlMWoZDown4Nh/ZTrX8EO7IP1ON/xHU7Itg0Egpwcqo5IY2m+SmN
         rNdUyaiKYKEUMZ3cp3zKECZs56g/wxe9U9bl2PASuuJaLhgdCJZn6ebI2wQKgP2NgGlA
         m/bF4Ob0dyjBExwfuFWk+SoDzp7Pns7fON3id8a2AtXEcrU5HXY6e9afaaruWKcM88K6
         2n5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g7/53lEkeQrVDh4pTT9VcOTwPBvNDDI936NjtakcQ9U=;
        b=R1Lg12JG91oPpq0rvdYv5T32I7yoek9Uf8mDsA7pYBeBck43ED+AqEABWiybjJiCAJ
         FBiP/o0e7t0c5qmAdtSxbZiP4yVqTekoOWceVsAmboMJSiq3Dss9y0AocWdQto1UOSO8
         AwGgSrBQGDtzwqmlUoM5GwUlGPoqf3bH8gV9Hzj0S5sEBVDbYeRG8oUCjRw2JaACY4+E
         t5JC9TO7yrNkKn/uXxmbgPS4N1Kll9yr1WcKx6SBnHmsbG8QKeHTBun8q0F+0+1PpNGr
         V+3uvaML748MoAShrklEMliR1eOj8TvqSO8dFs1B+xA29Yxr9pz6bPx2P54+Wj4TyWIt
         z8Tg==
X-Gm-Message-State: AOAM533KeEIQ9w0MCkpgbw28/wJQBf3mTp+ifyslJ07fB7vqfQnHRe/2
        Mn+QaTdgAuZDUDPKa08/MS0=
X-Google-Smtp-Source: ABdhPJx0ixPG9pnWsoFFuD/LG77OSY7dwcwqadke/Uqo83VepBIwQixuGUfCd557iZ2hok8Zdpl9NQ==
X-Received: by 2002:a05:6808:138d:b0:2ef:9f4b:26fe with SMTP id c13-20020a056808138d00b002ef9f4b26femr6824089oiw.124.1649368010877;
        Thu, 07 Apr 2022 14:46:50 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:203d:1c92:96e5:569a? (2603-8081-140c-1a00-203d-1c92-96e5-569a.res6.spectrum.com. [2603:8081:140c:1a00:203d:1c92:96e5:569a])
        by smtp.gmail.com with ESMTPSA id n18-20020a056820055200b003299b79f3e2sm922808ooj.9.2022.04.07.14.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 14:46:50 -0700 (PDT)
Message-ID: <4a37980e-4a57-13e8-0113-077ead20738c@gmail.com>
Date:   Thu, 7 Apr 2022 16:46:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bug report] rdma_rxe: WARNING: inconsistent lock state,
 inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
References: <CAHj4cs-MT13RiEsWXUAcX_H5jEtjsebuZgSeUcfptNVuELgjYQ@mail.gmail.com>
 <1c16f053-0183-8343-9b36-62027c7260a8@acm.org>
 <CAFc_bgZ5oYtK2doybVT5fhrU+Ut-RfPT+g2z1bbf9V3jTtRTUg@mail.gmail.com>
 <d80141c8-04ee-e6ed-34d8-5cf43b49fd55@acm.org>
 <ca8722e6-db2d-0ab1-b8af-0932017df23e@gmail.com>
 <f7b84702-8001-70bf-2f26-704548b96279@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <f7b84702-8001-70bf-2f26-704548b96279@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/7/22 16:44, Bart Van Assche wrote:
> On 4/7/22 14:06, Bob Pearson wrote:
>> On 4/7/22 14:49, Bart Van Assche wrote:
>>> On 4/7/22 12:15, Robert Pearson wrote:
>>>> I would say it is very possible. There was a period when the
>>>> pool locks were switched to _bh spinlocks but that was later
>>>> reversed back to _irqsave locks which cleaned up some failures. I
>>>> don't know which version Yi Zhang was using. The root cause of
>>>> this bug was caused by librdmacm making verbs API calls while
>>>> holding _irqsave locks which I didn't figure out until later.
>>>
>>> I can reproduce the issue Yi reported with kernel v5.18-rc1. Please
>>> let me know if you need any additional information to reproduce
>>> this issue.
>>
>> From your note I can't figure out what you are running. Can you give
>> me more details about the failing test case?
> 
> Hi Bob,
> 
> In Yi's email I found the following:
> 
> run blktests srp/001
> 
> That test case can be run as follows:
> 
> git clone https://github.com/osandov/blktests && cd blktests && make && sudo ./check -q srp/001
> 
> Thanks,
> 
> Bart.
> 
OK. I know it well. I run it from time to time. I'll see if it is broken just now.

Bob
