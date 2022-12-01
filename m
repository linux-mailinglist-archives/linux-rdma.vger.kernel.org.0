Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E7463F34E
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 16:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiLAPEr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 10:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiLAPEm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 10:04:42 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F8D41987
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 07:04:41 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id j6-20020a4ab1c6000000b004809a59818cso302530ooo.0
        for <linux-rdma@vger.kernel.org>; Thu, 01 Dec 2022 07:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gymtsHQ/PwZsFLq44Uatg2DcWno0BWuZlMzgJ8jQ7I8=;
        b=k6/P6IxfyODOwMb009vIQimSj9h3b46e+DXjiBlVaexrsGKAU+o6sLCQwyYwK+37Fn
         XtkRr30sACp2VsgxUjsKO6tV/GIPuybq4doHsmXXDEv01Bg000FsmMw/4P+mtrH5f48W
         qkjEELB/8C0tTe5qFZd2azixQAsMC1oJMxGu3KF4ScmlE2afr4s3M+J+P65NpqyMwsZz
         fG5o1ypHWXQkPMO0tM+XpRu/fqWvEZT4zcL6vsv5wmPPUwv/jsdIZ5p7IpKcc1MW9FWd
         YiH36AtamPamtG2iT4UgrVQjYqaSVbY5a7chVr2S4PJfVLEaaxpE6ltjy7DhH8xlVfVP
         uSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gymtsHQ/PwZsFLq44Uatg2DcWno0BWuZlMzgJ8jQ7I8=;
        b=z1OXI9+OaYQYUnk6kmUW3zofABB+sBEXge0fDWvezHe6sA1BIyoDqx+CHtRViweDUY
         QFRJY//hfLrJ7ONFtnOqwQxhAwMOzxI9Mf+OZX37kCTdWZdzl+j1BA0fyo4x9LYrEe3L
         LPZ1uUT+NhRx45lwTo/KDrUGxIZg86EI0cFXNWeP5WycLbT9YHoGXkcEDW4NmLyXn5oq
         Y0Zn6jdZJ0Puv0wBrLGy1gMBQoZyke8zPqE/b+CVUbcT++Ic+IXtjN/XdXZNbztHklte
         HWkSoc9PlVDaIXUuAIttN3UJ0rpxe/42FbKqXZX222cAT/i7i7JINUsSNbxDDf8+n7e0
         +Wew==
X-Gm-Message-State: ANoB5pkOkbfX1Q1GW+nbdSuauwSSYiVSaw0jsb6fV+reiJh9/+PvHntO
        dAnZq7HyL7HiwS3x2tX0RLE=
X-Google-Smtp-Source: AA0mqf5r8OitabJcaja/mkTFZD/8q1ZkH1Ge3aOLyimo2yTYp+RXBttov3Ruydt4+vgiQ/Pks3M9HQ==
X-Received: by 2002:a4a:ba94:0:b0:49f:fd89:8235 with SMTP id d20-20020a4aba94000000b0049ffd898235mr19476585oop.55.1669907080562;
        Thu, 01 Dec 2022 07:04:40 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:edbc:46e8:aba5:dca6? (2603-8081-140c-1a00-edbc-46e8-aba5-dca6.res6.spectrum.com. [2603:8081:140c:1a00:edbc:46e8:aba5:dca6])
        by smtp.gmail.com with ESMTPSA id y3-20020a4ae7c3000000b0049be9c3c15dsm1841546oov.33.2022.12.01.07.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 07:04:40 -0800 (PST)
Message-ID: <d80f31c4-2e51-c726-2954-a7039befe329@gmail.com>
Date:   Thu, 1 Dec 2022 09:04:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-next v2 06/18] RDMA/rxe: Add rxe_add_frag() to
 rxe_mr.c
Content-Language: en-US
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
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y4f4NkV+4ZbubQjp@nvidia.com>
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

On 11/30/22 18:41, Jason Gunthorpe wrote:
> On Wed, Nov 30, 2022 at 06:36:56PM -0600, Bob Pearson wrote:
>> I'm not looking at my patch you responded to but the one you posted to replace maps
>> by xarrays.
> 
> I see, I botched that part
> 
>> The existing rxe driver assumes that if ibmr->type == IB_MR_TYPE_DMA
>> that the iova is just a kernel (virtual) address that is already
>> mapped.
> 
> No, it is not correct
> 
>> Maybe this is not correct but it has always worked this way. These
>> are heavily used by storage stacks (e.g. Lustre) which always use
>> DMA mr's. Since we don't actually do any DMAs we don't need to setup
>> the iommu for these and just do memcpy's without dealing with pages.
> 
> You still should be doing the kmap
> 
> Jason

Something was disconnected in my memory. So I went back and looked at lustre.
Turns out it never uses IB_MR_TYPE_DMA and for that matter I can't find any
use cases in the rdma tree or online. So, the implementation in rxe has almost
certainly never been used.

So I need to choose to 'fix' the current implementation or just delete type dma support.
I get the idea that I need to convert the iova to a page and kmap it but i'm not
clear how to do that. This 64 bit numnber (iova) needs to convert to a struct page *.
Without a use case to look at I don't know how to interpret it. Apparently it's not a
virtual address.

Bob

