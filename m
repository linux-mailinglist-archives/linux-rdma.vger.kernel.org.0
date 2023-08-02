Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5097276D042
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Aug 2023 16:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjHBOj7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Aug 2023 10:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbjHBOj7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Aug 2023 10:39:59 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADB8119
        for <linux-rdma@vger.kernel.org>; Wed,  2 Aug 2023 07:39:58 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-56c9439e3d3so631014eaf.0
        for <linux-rdma@vger.kernel.org>; Wed, 02 Aug 2023 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690987197; x=1691591997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XX2Og7T5ifxTFSmHrtC92HVUXS2xTTHKGcfHOeb8TIs=;
        b=dDBz/3VhN0/axFBpBh1hFt8fL3lei3MDnkRmZVpfnp2dNPn9UQHjHnR6eHM5uIB8P4
         wn97ndR/eLy5qY9PPf/N6AN8yaOG9dSo7cQh/5LOo9/EFj0UKxqHq811o6x6zrFWdtOC
         gAuiEpV/bbtdDU5V9D8GJVyxZWG0ZAeyBBUUs/3T7n9PNUeJulgeW5oyrooZLcjKAT1j
         RVmTYxp+wI19EUy09aQkoznS5Siv9sfTrOgLeQ+zGa/fwHpXnohKe/HheiZoernbcgS4
         NoT3MPp0ksXso9ug9gw9XHdQdi2nho18x1ukObl5aEDsj187MTJCE1RhZL5BePDiZcPD
         JK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690987197; x=1691591997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XX2Og7T5ifxTFSmHrtC92HVUXS2xTTHKGcfHOeb8TIs=;
        b=FmIwkMn+seYWGruVC+yRU3lp7eYsmqz+qGuijEXvuPOs/y0qXvku6Xe0nNAui6LAw9
         7V4eBzisFqWwJBR1iucyeWmsMnxAG2cWsKeI2FY1K5xCkr1EnSQHk0u6NSXsD/2KfWXq
         ScRbfa3sNctok3Z+WsyckBM1uffHrUgWrWpT0gxi1ze43hKprlwO85ycdCsv4lmuWs5j
         9UK+Bb8Fyv58K4mAZFGAduki0Mmn4VyBNQ0cyXrCcoAaPSEbbnCLEL23Q3Xd9eIzQKd1
         3ImxAki+Q22pTndYDNQYEu0bl2h0RERjwb6NNQPxs0BkZFX1wENUsk5nIo/dkxIzWPaq
         LTdw==
X-Gm-Message-State: ABy/qLZaz4LI9KcAYh7HzuxzPj6sR572JqAU3X8JFOjHVjjt6ECyk+0h
        yfq5JmkZBnlXc8rP35TL6Q0=
X-Google-Smtp-Source: APBJJlGvoxtjDYCxELKlihsmBDCOMxiYiicYq6yD6oVUWUxQYFXphDJmGL7PYZK8SOaSZovlOZTKZA==
X-Received: by 2002:a05:6808:1a92:b0:3a7:4c85:30f6 with SMTP id bm18-20020a0568081a9200b003a74c8530f6mr3217275oib.17.1690987197541;
        Wed, 02 Aug 2023 07:39:57 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:a5d1:3e74:a792:4a01? (2603-8081-140c-1a00-a5d1-3e74-a792-4a01.res6.spectrum.com. [2603:8081:140c:1a00:a5d1:3e74:a792:4a01])
        by smtp.gmail.com with ESMTPSA id p14-20020a05680811ce00b003a37fd2be45sm6303282oiv.31.2023.08.02.07.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 07:39:57 -0700 (PDT)
Message-ID: <dad6082d-24f8-ccc7-0714-e89141159eac@gmail.com>
Date:   Wed, 2 Aug 2023 09:39:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-next 9/9] RDMA/rxe: Protect pending send packets
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-10-rpearsonhpe@gmail.com> <ZMf6xkpicBpXr/B9@nvidia.com>
 <1ee51a2d-3015-3204-33e3-cfcfaac0d80e@gmail.com>
 <ZMf+ILKLjW+09Hhm@nvidia.com>
 <3156272e-91e9-8253-e09d-8a93af3f3258@gmail.com>
 <ZMmNsnJeyGcTeNNp@nvidia.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZMmNsnJeyGcTeNNp@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/1/23 17:56, Jason Gunthorpe wrote:
> On Mon, Jul 31, 2023 at 01:44:47PM -0500, Bob Pearson wrote:
>> On 7/31/23 13:32, Jason Gunthorpe wrote:
>>> On Mon, Jul 31, 2023 at 01:26:23PM -0500, Bob Pearson wrote:
>>>> On 7/31/23 13:17, Jason Gunthorpe wrote:
>>>>> On Fri, Jul 21, 2023 at 03:50:22PM -0500, Bob Pearson wrote:
>>>>>> Network interruptions may cause long delays in the processing of
>>>>>> send packets during which time the rxe driver may be unloaded.
>>>>>> This will cause seg faults when the packet is ultimately freed as
>>>>>> it calls the destructor function in the rxe driver. This has been
>>>>>> observed in cable pull fail over fail back testing.
>>>>>
>>>>> No, module reference counts are only for code that is touching
>>>>> function pointers.
>>>>
>>>> this is exactly the case here. it is the skb destructor function that
>>>> is carried by the skb.
>>>
>>> It can't possibly call it correctly without also having the rxe
>>> ib_device reference too though??
>>
>> Nope. This was causing seg faults in testing when there was a long network
>> hang and the admin tried to reload the rxe driver. The skb code doesn't care
>> about the ib device at all.
> 
> I don't get it, there aren't globals in rxe, so WTF is it doing if it
> isn't somehow tracing back to memory that is under the ib_device
> lifetime?
> 
> Jason

When the rxe driver builds a send packet it puts the address of its destructor
subroutine in the skb before calling ip_local_out and sending it. The address of
driver software is now hanging around. If you don't delay the module exit routine
until all the skb's are freed you can cause seg faults. The only way to cause this to
happen is to call rmmod on the driver too early but people have done this occasionally
and report it as a bug.

Bob
