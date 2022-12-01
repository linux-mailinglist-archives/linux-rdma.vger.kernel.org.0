Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F96163F385
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 16:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiLAPQs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 10:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiLAPQr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 10:16:47 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4569FCAB7B
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 07:16:47 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-142b72a728fso2456152fac.9
        for <linux-rdma@vger.kernel.org>; Thu, 01 Dec 2022 07:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hs23+sSMt/xuSQc49irOh02j4AaUXs9EKswtFd2ggsI=;
        b=I4cWyvLjooVulG1rTgoqfpeDna1uQ1f9+zsiYLR9cuopnsqZj8WbUy4P65TsZBw57q
         mKW4H8ctUpE+yf9hfl5WkD+Fx9VPCReE9ZEbfgAqr4TYEZH6U2FfHttrF/aLBE/ar5vG
         Dz0MSOknIlWWipmBJepapT893/0wDRbn1vQgbY00F/kxlzHm1YbUVH/NFAGNE//3bV60
         FAviXYz7qGLzBgRcBtRdvGHGrIJkGJ1Mt41MrSUd/uINTU4C2gveeHfvTiF6uI45AOUq
         iIryBUnmNJRr0q5KKjM7+vfFK4Pr52ub2X3/hGWPww6MtATXQcT53+YNfycZhUZbpjAm
         4WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hs23+sSMt/xuSQc49irOh02j4AaUXs9EKswtFd2ggsI=;
        b=tFYgtH0HZMMh2PMn0umFvldg/PtPsgsuOjfNuSxEXy1NJdIljMNKERFf9bUcvKzYR9
         13ywrVciUlVY1AGmX7K8RLqTfLKxhUZraQca4JkSG4R4ebY7hYJgmAEUPfUU+KHEBFKp
         bhntoSGOXRDfU5UjJI2kXbFKai+JAsQRlVA0GgD+LLfoaVWvdC7LCZ8IvCQRrBCr2pyf
         3ZeBi6w88tH9XhAEQ/hzn7KZToNniP0XGXLSU81QcP6TPigDNE/r4GSehZ/KmMAQJXlX
         7DAs8K+aUYRxFz8M3amqFethwHNwonStfolrQUO6k9QS3bVOCy6268DaHbgu7E2ej7nE
         QV8A==
X-Gm-Message-State: ANoB5pn8M3M2VqxgiYzHfUOXuseRQFBDusDwK2mTDFQDerfeFweswSOO
        //iUSgmHXVH8b+PW69GLBLU=
X-Google-Smtp-Source: AA0mqf78A4WaFWRuGpTnITxLVGDhY0h1TCIUIhmypHVEtruoUX/Tf8u1dTSkkywEYs2qYud7QKouBQ==
X-Received: by 2002:a05:6870:b9c7:b0:143:471b:3385 with SMTP id iv7-20020a056870b9c700b00143471b3385mr21517836oab.123.1669907806008;
        Thu, 01 Dec 2022 07:16:46 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:edbc:46e8:aba5:dca6? (2603-8081-140c-1a00-edbc-46e8-aba5-dca6.res6.spectrum.com. [2603:8081:140c:1a00:edbc:46e8:aba5:dca6])
        by smtp.gmail.com with ESMTPSA id l25-20020a4ad9d9000000b004a05e943f9esm1859917oou.21.2022.12.01.07.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 07:16:45 -0800 (PST)
Message-ID: <82449ff1-2602-a6d0-e33d-af783545bcb0@gmail.com>
Date:   Thu, 1 Dec 2022 09:16:44 -0600
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
In-Reply-To: <d80f31c4-2e51-c726-2954-a7039befe329@gmail.com>
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

On 12/1/22 09:04, Bob Pearson wrote:
> On 11/30/22 18:41, Jason Gunthorpe wrote:
>> On Wed, Nov 30, 2022 at 06:36:56PM -0600, Bob Pearson wrote:
>>> I'm not looking at my patch you responded to but the one you posted to replace maps
>>> by xarrays.
>>
>> I see, I botched that part
>>
>>> The existing rxe driver assumes that if ibmr->type == IB_MR_TYPE_DMA
>>> that the iova is just a kernel (virtual) address that is already
>>> mapped.
>>
>> No, it is not correct
>>
>>> Maybe this is not correct but it has always worked this way. These
>>> are heavily used by storage stacks (e.g. Lustre) which always use
>>> DMA mr's. Since we don't actually do any DMAs we don't need to setup
>>> the iommu for these and just do memcpy's without dealing with pages.
>>
>> You still should be doing the kmap
>>
>> Jason
> 
> Something was disconnected in my memory. So I went back and looked at lustre.
> Turns out it never uses IB_MR_TYPE_DMA and for that matter I can't find any
> use cases in the rdma tree or online. So, the implementation in rxe has almost
> certainly never been used.
> 
> So I need to choose to 'fix' the current implementation or just delete type dma support.
> I get the idea that I need to convert the iova to a page and kmap it but i'm not
> clear how to do that. This 64 bit numnber (iova) needs to convert to a struct page *.
> Without a use case to look at I don't know how to interpret it. Apparently it's not a
> virtual address.
> 
> Bob
> 

I did find a single use case for the mr created during alloc_pd. The comments seem
to imply that the use is just access to local kernel memory with va=pa. So I am back
to my previous thoughts. Memcpy should just work.

Bob
