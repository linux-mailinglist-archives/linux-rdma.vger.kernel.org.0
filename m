Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0AD63F442
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 16:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiLAPjX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 10:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiLAPjC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 10:39:02 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96F6638A
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 07:38:14 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id t62so2368096oib.12
        for <linux-rdma@vger.kernel.org>; Thu, 01 Dec 2022 07:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yeN6GjSK0gxMKJtJJS+11SXwZ6ljxklBKlz0KcqnFrg=;
        b=k2zfTYwKPszq2Gpno/Slt3dXbyfhIcJjTWJIOy3M/1vBFoXDemRDNunj0TZ4ELEbsg
         5Kk0YFCVd33KAg7FhOlXUihaCKhq5MyVsOcgz/8RUyH1OGwpJD4qamTDGgXqQIi3FO1N
         bXYMfsqR8uMrd0aM8KcoXHel9+ujFfbWH8GQFvGXoWpAyUq/z3PK9mLCf1w/ieD8mqKR
         E8Rlxdz5jAUEwYE/ujcVZ98qxYSzzRVhNLcH6Wulo9zy/4EVNTGhiZwVZ94dgLBIz1o5
         UqnRrmuaEfI8XSCxTnVIEVF3GLByPz0xm21f0uMyYX0iXpALUAZURTU7GHUrAPk0ECqa
         WFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeN6GjSK0gxMKJtJJS+11SXwZ6ljxklBKlz0KcqnFrg=;
        b=Czl/rz06uAxFWVD5cWOXOU7d75oJPXCO8LgEB09Ya7vb6ZnCwAY7ml8+EtifPCZEAS
         z4U9C3d9g8NTe7p4lUB31uG9TbTaFHc7bdnYe8/PQkK1cEoC6MEcyrIwqLN0/nXP4BoW
         5fEvu5yWkAk5jdLT+QBoZkpUvCn31lEoVSmEy/zPPGoPWyI4u5oRDsRFH/LqsirFNpRw
         JpMzsO+jQopevrskEy5GD2cy5rtEFYkx0n1L//qHxm41w2n1CZrrXLSWvg3blNU6NvrH
         2sHx2pehozaKQrxDHTwHZrgM+0c7UBWKdvhUywbmbd9T35jV1JUAQ+YsjuMLIZ3eg1ct
         7QCQ==
X-Gm-Message-State: ANoB5pn2425Q3aPxoS/SF71PoXk5Q8I0/aWk4psmLi2s2juzOdgZALNt
        jmS98/UtsgINEGtBAyc+ijk=
X-Google-Smtp-Source: AA0mqf5zy9lXZOOYUbqU2QY46Buspy70dwHs3mUpHomfH7HSOFP/4PTf57i+2oNfFbJfi9JLeN/Hog==
X-Received: by 2002:a05:6808:2110:b0:35b:bae2:d997 with SMTP id r16-20020a056808211000b0035bbae2d997mr8797883oiw.90.1669909091547;
        Thu, 01 Dec 2022 07:38:11 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:edbc:46e8:aba5:dca6? (2603-8081-140c-1a00-edbc-46e8-aba5-dca6.res6.spectrum.com. [2603:8081:140c:1a00:edbc:46e8:aba5:dca6])
        by smtp.gmail.com with ESMTPSA id cs3-20020a056830678300b006393ea22c1csm2233768otb.16.2022.12.01.07.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 07:38:11 -0800 (PST)
Message-ID: <443943ee-6f79-b6df-4533-723953173a5e@gmail.com>
Date:   Thu, 1 Dec 2022 09:38:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-next v2 06/18] RDMA/rxe: Add rxe_add_frag() to
 rxe_mr.c
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20221031202805.19138-1-rpearsonhpe@gmail.com>
 <20221031202805.19138-6-rpearsonhpe@gmail.com> <Y3/Bqa7obMROAtr8@nvidia.com>
 <7ebc82bd-3d1c-e2d3-be4f-2e5c95073a65@gmail.com>
 <Y4fo6tknpuCveRgq@nvidia.com>
 <fd788906-6e40-8109-f6a1-5f281361c68c@gmail.com>
 <Y4fzZk7D9GgLNhy9@nvidia.com>
 <eff1e3d7-03a5-97fc-e494-f9ba93c185d6@gmail.com>
 <Y4f4NkV+4ZbubQjp@nvidia.com>
 <d80f31c4-2e51-c726-2954-a7039befe329@gmail.com>
 <82449ff1-2602-a6d0-e33d-af783545bcb0@gmail.com>
In-Reply-To: <82449ff1-2602-a6d0-e33d-af783545bcb0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/1/22 09:16, Bob Pearson wrote:
> On 12/1/22 09:04, Bob Pearson wrote:
>> On 11/30/22 18:41, Jason Gunthorpe wrote:
>>> On Wed, Nov 30, 2022 at 06:36:56PM -0600, Bob Pearson wrote:
>>>> I'm not looking at my patch you responded to but the one you posted to replace maps
>>>> by xarrays.
>>>
>>> I see, I botched that part
>>>
>>>> The existing rxe driver assumes that if ibmr->type == IB_MR_TYPE_DMA
>>>> that the iova is just a kernel (virtual) address that is already
>>>> mapped.
>>>
>>> No, it is not correct
>>>
>>>> Maybe this is not correct but it has always worked this way. These
>>>> are heavily used by storage stacks (e.g. Lustre) which always use
>>>> DMA mr's. Since we don't actually do any DMAs we don't need to setup
>>>> the iommu for these and just do memcpy's without dealing with pages.
>>>
>>> You still should be doing the kmap
>>>
>>> Jason
>>
>> Something was disconnected in my memory. So I went back and looked at lustre.
>> Turns out it never uses IB_MR_TYPE_DMA and for that matter I can't find any
>> use cases in the rdma tree or online. So, the implementation in rxe has almost
>> certainly never been used.
>>
>> So I need to choose to 'fix' the current implementation or just delete type dma support.
>> I get the idea that I need to convert the iova to a page and kmap it but i'm not
>> clear how to do that. This 64 bit numnber (iova) needs to convert to a struct page *.
>> Without a use case to look at I don't know how to interpret it. Apparently it's not a
>> virtual address.
>>
>> Bob
>>
> 
> I did find a single use case for the mr created during alloc_pd. The comments seem
> to imply that the use is just access to local kernel memory with va=pa. So I am back
> to my previous thoughts. Memcpy should just work.
> 
> Bob

Further, looking at ipoib as an example, it builds sge lists using the lkey from get_dma_mr()
and sets the sge->addr to a kernel virtual memory address after previously calling
ib_dma_map_single() so the addresses are mapped for dma access and visible before use.
They are unmapped after the read/write operation completes. What is the point of kmapping
the address after dma mapping them?

Bob  
