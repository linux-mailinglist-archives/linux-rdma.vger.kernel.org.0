Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6274E3CEFFB
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 01:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348433AbhGSWyA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jul 2021 18:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388300AbhGSUtd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jul 2021 16:49:33 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C408EC0613E9
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jul 2021 14:27:08 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id s2-20020a0568301e02b02904ce2c1a843eso9120903otr.13
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jul 2021 14:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sPHub9MVCTMnXD/Zguu0sSAoAHfqFaH3woX5cTLOFIE=;
        b=BX9DMOEBmmq/ZIv3qlY+oD7zol7sqqBsqj4rciI2WNf6e+kZAv9MJ/lkXWGeH3qYDJ
         0BIe/PHZz2c1vr7b8RSEnzrL8+1MBKNsEmEk0H9nPaAMAPUHOOnuBqarZmHwnuYomNVS
         MS+o3dor1vT2F961+dwLmcHxehHwX5n+VGjhYFU8447BsSRz6pr8U9GhOce8CCVKPf9i
         pFx6+trCu8L0bEavIMS/5plWpayJWUCWAgGb1o6lEK5KQimT+Wk1GPqo7CqfQpvVaTn1
         9kD7X+Npgp3K3u2Uuj3nPUEWcrF9aZ58r88FmN20mFIzeKCT16EU8JJkSeCJlPEileM7
         6+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sPHub9MVCTMnXD/Zguu0sSAoAHfqFaH3woX5cTLOFIE=;
        b=HS3Q1tHVi4xmveNluz/cSF4mL8Z/23RClZWHb3MhW3bgDB9O2gz2risR7r/NKCzloE
         L1Fe04f3UQzdtPR0r2nKVFphOSazMB5AxrhLtQNhQ3fodawaeRl/Ddeo24D+q30NweJi
         Xz6Xae7jFDy2fYE0txwId8pA407GZTUedUD7nmK4mhADFiLnQUC55XxlsM2ydChf3WwS
         XCTIkQNCuMwjGL26g57JCCj8mWKtyabwa03IYhl5a5TQ9dqvtq6/UfwzwRIz9CXA8nJl
         82ZHjN3q5g5Kezycp2dVEJvcGPh28QTLyuaI1j++9DJKTOC1FmcAvRryldExGuAJlEUN
         shUg==
X-Gm-Message-State: AOAM531rdoMR1J0KP1zitKi2cIHKRKFg7RJzEHf3Rx+QNRLaDH5cOW3e
        tvYBK8BUGl4Rt4t6ij5T5Vrvmt9cTPs=
X-Google-Smtp-Source: ABdhPJxDegiAzBkyESjQS6RNIVmi6q+BS3rMioW3UBJDmrYLEOagVXwzUUuoXqF2x70glFAXGwy5Tw==
X-Received: by 2002:a9d:64a:: with SMTP id 68mr19622852otn.68.1626730028056;
        Mon, 19 Jul 2021 14:27:08 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:4f8a:6d3a:3227:1f2a? (2603-8081-140c-1a00-4f8a-6d3a-3227-1f2a.res6.spectrum.com. [2603:8081:140c:1a00:4f8a:6d3a:3227:1f2a])
        by smtp.gmail.com with ESMTPSA id f3sm3981651otc.49.2021.07.19.14.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 14:27:07 -0700 (PDT)
Subject: Re: [PATCH for-next v2 0/9] ICRC cleanup
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Olga Kornievskaia <aglo@umich.edu>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210707040040.15434-1-rpearsonhpe@gmail.com>
 <20210716173804.GA767510@nvidia.com>
 <CAD=hENfj2vkNV1uKK7hgfDLqN9xY2fwjiFS536tM9oknMuZ4Fg@mail.gmail.com>
 <CAN-5tyFrtf8SEet8at7QvwnFqLmdZoK2AaULXfXK-kq0_F8azw@mail.gmail.com>
 <20210719171000.GT543781@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <c6ba117f-8a86-cff0-3d4b-50d12e7d706d@gmail.com>
Date:   Mon, 19 Jul 2021 16:26:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719171000.GT543781@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/19/21 12:10 PM, Jason Gunthorpe wrote:
> On Mon, Jul 19, 2021 at 11:53:20AM -0400, Olga Kornievskaia wrote:
>> On Mon, Jul 19, 2021 at 5:16 AM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>>>
>>> On Sat, Jul 17, 2021 at 1:38 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>>
>>>> On Tue, Jul 06, 2021 at 11:00:32PM -0500, Bob Pearson wrote:
>>>>> This series of patches is a cleanup of the ICRC code in the rxe driver.
>>>>> The end result is to collect all the ICRC focused code into rxe_icrc.c
>>>>> with three APIs that are used by the rest of the driver. One to initialize
>>>>> the crypto engine used to compute crc32, and one each to generate and
>>>>> check the ICRC in a packet.
>>>>>
>>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>>> v2:
>>>>>   Split up the 5 patches in the first version into 9 patches which are
>>>>>   each focused on a single change.
>>>>>   Fixed sparse warnings in the first version.
>>>>>
>>>>> Bob Pearson (9):
>>>>>   RDMA/rxe: Move ICRC checking to a subroutine
>>>>>   RDMA/rxe: Move rxe_xmit_packet to a subroutine
>>>>>   RDMA/rxe: Fixup rxe_send and rxe_loopback
>>>>>   RDMA/rxe: Move ICRC generation to a subroutine
>>>>>   RDMA/rxe: Move rxe_crc32 to a subroutine
>>>>>   RDMA/rxe: Fixup rxe_icrc_hdr
>>>>>   RDMA/rxe: Move crc32 init code to rxe_icrc.c
>>>>>   RDMA/rxe: Add kernel-doc comments to rxe_icrc.c
>>>>>   RDMA/rxe: Fix types in rxe_icrc.c
>>>>
>>>> Applied to for-next, thanks
>>>
>>> Hi, Jason && Bob
>>>
>>> I confronted a problem.
>>> One hosts with this patch series, A
>>> other hosts, without this patch series, B
>>>
>>> I run rping between A <-------> B.
>>>
>>> I confronted the following errors, and rping can not succeed.
>>> "
>>> ...
>>> [ 1848.251273] rdma_rxe: bad ICRC from 172.16.1.61
>>> [ 1971.750691] rdma_rxe: bad ICRC from 172.16.1.61
>>> ...
>>> "
>>> It seems that this patch series breaks the Backward compatibility of RXE.
>>>
>>> Not sure if it is a problem. Please comment.
>>>
>>> Thanks a lot.
>>> Zhu Yanjun
>>
>> I would like to second this post. I was about to submit a new post
>> asking about why rxe isn't working and if it's known. I'm trying to
>> figure out when/what patch broke things. From the stand point of
>> NFSoRDMA, it stopped working and I have discovered that simple rping
>> doesn't work as well. The last known working release was 5.11.
> 
> This isn't included in v5.13 or v5.14, so it can't be this series
> 
> You should send Bob and Zhu your non-working report
> 
> Jason
> 
I'm working on finding what went wrong for Zhu. SHould have something in the next couple of hours.

Bob
