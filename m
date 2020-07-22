Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1252299F4
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 16:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgGVOXs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 10:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbgGVOXs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 10:23:48 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230C7C0619DC;
        Wed, 22 Jul 2020 07:23:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so2395950eje.7;
        Wed, 22 Jul 2020 07:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4eDGMiirBr/9wj0aV+FWFSQ39qot6+wnOp4Iy5F1qKw=;
        b=awDiXnCAOzBfXEM7w8PJ3tM3M1ix7xTsKONg8BwDAqtB/5SooWmpeYqhsBclY3dz1T
         8UxHDsup2Iw2w0nR4a/Af6J2xG8/DkpECOZs2nPn1p5ESnv/FFdQ4jXOer0Nvdc+Z1QL
         lPKaVIHuvz/eakMsfVLRj+gUUe/Nu7XfFTwheAZdGUHeQzTkD2ZeFkdZ6S0AqZUc/a8u
         Ef8PCJqmOrOtOIPZKl/U7LO1q/QY3WR1M0whWlEyt1JbQefsCYzAg0GTz8K4YmjRdEbs
         VoJ0oYhlIzs3BeTpU6By8xlkTXpzgEWGtGWjGXwdeYU9JW9EySZIpKX4nwKGeGpux0V4
         9Qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=4eDGMiirBr/9wj0aV+FWFSQ39qot6+wnOp4Iy5F1qKw=;
        b=V596jw5zhQtvu9A0H4g9DjMzAPIm8za3MD3OyR6EnjPsVIRaaCsCr59U1T569XpoVm
         LiBI9rjHquwJQAW66Cqm9IvJafhWvs7okMnw9Yg+5TpMeDCCA1LhRXEiaCFJTghxyaYX
         vZb7MmAEOkAqd/hA2IeOBZEjbAA6JW3AupxVINtY9DAPUmGYFiz0tjRIhc0SqY5fRhFY
         18mNZhh4bs33gyCn4NTsWxoURwKZ2zDBoDtlvsRTW8IAChKiGKNZxxxUwk0UMvaGY4Ar
         Qsy6CHr00bRslYGtjRJ8nt8CKspJTvk4mlKbD9XQ/ZZF6G1k/gBZ8VdTqPrN894EQj68
         swcg==
X-Gm-Message-State: AOAM533n1QT1RrmBoYDNVGUNzIdxgoFgAs1oJjPJimLiJz1YCyswcJiA
        2V9x33hei+MPp8N1xSvOvBE=
X-Google-Smtp-Source: ABdhPJweXE+1WURAaIs/HR95z4aF6xhhUwmufaRJKgZqDHvsKPtNi9tuWkQG2Tj3wIdhocnD1H/YYA==
X-Received: by 2002:a17:906:4f16:: with SMTP id t22mr29680343eju.179.1595427826873;
        Wed, 22 Jul 2020 07:23:46 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id g21sm17224edr.45.2020.07.22.07.23.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2020 07:23:46 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Daniel Stone <daniels@collabora.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Steve Pronovost <spronovo@microsoft.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Jesse Natalie <jenatali@microsoft.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
 <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local>
 <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org>
 <CAPM=9twUWeenf-26GEvkuKo3wHgS3BCyrva=sNaWo6+=A5qdoQ@mail.gmail.com>
 <805c49b7-f0b3-45dc-5fe3-b352f0971527@shipmail.org>
 <CAKMK7uHhhxBC2MvnNnU9FjxJaWkEcP3m5m7AN3yzfw=wxFsckA@mail.gmail.com>
 <92393d26-d863-aac6-6d27-53cad6854e13@shipmail.org>
 <CAKMK7uF8jpyuCF8uUbEeJUedErxqRGa8JY+RuURg7H1XXWXzkw@mail.gmail.com>
 <8fd999f2-cbf6-813c-6ad4-131948fb5cc5@shipmail.org>
 <CAKMK7uH0rcyepP2hDpNB-yuvNyjee1tPmxWUyefS5j7i-N6Pfw@mail.gmail.com>
 <df5414f5-ac5c-d212-500c-b05c7c78ce84@shipmail.org>
 <CAKMK7uF27SifuvMatuP2kJPTf+LVmVbG098cE2cqorYYo7UHkw@mail.gmail.com>
 <697d1b5e-5d1c-1655-23f8-7a3f652606f3@shipmail.org>
 <CAKMK7uGSkgdJyyvGe8SF_vWfgyaCWn5p0GvZZdLvkxmrS6tYbQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c742c557-f48f-1591-1d1d-a5181b408a67@gmail.com>
Date:   Wed, 22 Jul 2020 16:23:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uGSkgdJyyvGe8SF_vWfgyaCWn5p0GvZZdLvkxmrS6tYbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 22.07.20 um 16:07 schrieb Daniel Vetter:
> On Wed, Jul 22, 2020 at 3:12 PM Thomas Hellström (Intel)
> <thomas_os@shipmail.org> wrote:
>> On 2020-07-22 14:41, Daniel Vetter wrote:
>>> I'm pretty sure there's more bugs, I just haven't heard from them yet.
>>> Also due to the opt-in nature of dma-fence we can limit the scope of
>>> what we fix fairly naturally, just don't put them where no one cares
>>> :-) Of course that also hides general locking issues in dma_fence
>>> signalling code, but well *shrug*.
>> Hmm, yes. Another potential big problem would be drivers that want to
>> use gpu page faults in the dma-fence critical sections with the
>> batch-based programming model.
> Yeah that's a massive can of worms. But luckily there's no such driver
> merged in upstream, so hopefully we can think about all the
> constraints and how to best annotate&enforce this before we land any
> code and have big regrets.

Do you want a bad news? I once made a prototype for that when Vega10 
came out.

But we abandoned this approach for the the batch based approach because 
of the horrible performance.

KFD is going to see that, but this is only with user queues and no 
dma_fence involved whatsoever.

Christian.

> -Daniel
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

