Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C68539EBC7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 04:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFHCEO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 22:04:14 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:36785 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhFHCEJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Jun 2021 22:04:09 -0400
Received: by mail-ot1-f47.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so18808203otl.3
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 19:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Btk6DtONn4o4biYtPX8MjpLMyxwqPM+TySUUlK1D//w=;
        b=ehVHGgxpek3Ii3CIB6MuySYKwOxptMbxC6pFdWW4VL+v54PS9Nq+KDUi1KvJz55a3W
         LZydSCFmV2KjaWygAQPJriZdDeYKzr0tU4XhaUKBeTs5H8LL8E64IoW9et7kk9cHqYxW
         XV/yDsaaVNUCTnsUOBA5FWf3Tk751fJ8zZNP/dxuc0qCQ+1TcKwfBdA8OigNxxQrraLG
         /+0uDYqznInNthxeFkwsTQYDsJ3lYTEsBl2M/+xzx+kWlIzi5oYo8nnVEjfegujc736j
         KDKoWzOi6y/ha6ZoNN0W16M6CLMw0LyOUe56svM3XtywqD4H5Y64S/0agezxe1rh8dw3
         sANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Btk6DtONn4o4biYtPX8MjpLMyxwqPM+TySUUlK1D//w=;
        b=esK1bibum9vqKSmT1zfrknnBX62LN4W7+QSrTr/eGgRdudn5gJjS/VDSaTRqIpGA5s
         zNJJVkB4i0aChOvnEu7+HktSPwXUA3NXaG5xIlS43CH1zi8tU8yoVMN0hkR8+Zb+1UeB
         NS9GrbJE2l++i2G/wzg/LuT3+Uh87HDt76Cb8i1p6s3/p2PGTlv/Ypa2/gnD7OglHUNY
         ciPs5+RTX3oK2Ny9omgaYyiWJ/ummfAMpQiRkx4g4wLhHn5VlHpLVeA2hhLGxgTqnmNW
         ki1jcyFcwWf5v5Khja1tRSne3T9UDXIuRvBtvspa8EpZrM8oDcEEFxe559TtsWjKuS8K
         +rqQ==
X-Gm-Message-State: AOAM530UCXmvlHaYRbieZrcWqaAPUNzcrEbiMfBWP6GV381+ANdiiNRT
        WlWmj99o9dNG4KzF6MBEwVUmT1WlVHM=
X-Google-Smtp-Source: ABdhPJya+9+mOR1Xphb/V1wVlk3Gox1jSGuuwx/6VKy3W9Zqc3Q4IHnvAvnHrlScBHAgihbsANY69A==
X-Received: by 2002:a05:6830:1155:: with SMTP id x21mr16090828otq.303.1623117677385;
        Mon, 07 Jun 2021 19:01:17 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:c5c4:ae82:7e0d:a0c? (2603-8081-140c-1a00-c5c4-ae82-7e0d-0a0c.res6.spectrum.com. [2603:8081:140c:1a00:c5c4:ae82:7e0d:a0c])
        by smtp.gmail.com with ESMTPSA id x199sm1498344oif.5.2021.06.07.19.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 19:01:17 -0700 (PDT)
Subject: Re: [PATCH for-next] RDMA/rxe: Fix qp reference counting for atomic
 ops
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210604230558.4812-1-rpearsonhpe@gmail.com>
 <CAD=hENcwwjS8X2R24+cFRyyrA5_k=F5LuC4bx1tzCVW969uvuQ@mail.gmail.com>
 <YL389Dqd8+akhb1i@unreal>
 <CAD=hENd6J=1eTPn3u8M5rvym1xP_A30DnreKOCvi+hLTh0iuNw@mail.gmail.com>
 <e0be8fe4-dcda-ddbe-faa4-104d36442b96@gmail.com>
 <CAD=hENeoK7971B4koPPaJ+u_DL=VSgL8zoF3GZXexozSHuK8pA@mail.gmail.com>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <95a4ddf1-fcbc-51fd-6cc7-932f065c61bf@gmail.com>
Date:   Mon, 7 Jun 2021 21:01:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAD=hENeoK7971B4koPPaJ+u_DL=VSgL8zoF3GZXexozSHuK8pA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/7/2021 8:39 PM, Zhu Yanjun wrote:
> On Tue, Jun 8, 2021 at 12:14 AM Pearson, Robert B <rpearsonhpe@gmail.com> wrote:
>>
>> On 6/7/2021 6:12 AM, Zhu Yanjun wrote:
>>> On Mon, Jun 7, 2021 at 7:03 PM Leon Romanovsky <leon@kernel.org> wrote:
>>>> On Mon, Jun 07, 2021 at 04:16:37PM +0800, Zhu Yanjun wrote:
>>>>> On Sat, Jun 5, 2021 at 7:07 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>>>> Currently the rdma_rxe driver attempts to protect atomic responder
>>>>>> resources by taking a reference to the qp which is only freed when the
>>>>>> resource is recycled for a new read or atomic operation. This means that
>>>>>> in normal circumstances there is almost always an extra qp reference
>>>>>> once an atomic operation has been executed which prevents cleaning up
>>>>>> the qp and associated pd and cqs when the qp is destroyed.
>>>>>>
>>>>>> This patch removes the call to rxe_add_ref() in send_atomic_ack() and the
>>>>>> call to rxe_drop_ref() in free_rd_atomic_resource(). If the qp is
>>>>> Not sure if it is a good way to fix this problem by removing the call
>>>>> to rxe_add_ref.
>>>>> Because taking a reference to the qp is to protect atomic responder resources.
>>>>>
>>>>> Removing rxe_add_ref is to decrease the protection of the atomic
>>>>> responder resources.
>>>> All those rxe_add_ref/rxe_drop_ref in RXE are horrid. It will be good to delete them all.
>>>>
>>> I made tests with this commit. After this commit is applied, this
>>> problem disappeared.
>> You were testing MW when you saw this bug. Does that mean that now MW is
>> working for you?
> Your MW patches are huge. After these patches are applied, I found 2
> problems in my test environment.

The trace you showed looked like the pyverbs tests all passed and then 
there were leaked QP/PD/CQ. I also saw those. After fixing the QP 
reference count bug (not in MW) I did not see any errors from the 
pyverbs tests of MW. Or any other errors for that matter. What was the 
other problem? Was that the memory barrier one (also not in MW)?

Mostly I want to know if you currently see any errors in the kernel 
related to MW. The test case bug (in test_qpex.py) is a separate issue 
that is not a rxe bug at all.

Bob

> So IMO, can you send the test cases about MW to rdma-core? So we can
> verify these MW patches with them.
>
> In previous mails, you mentioned these MW test cases.
>
> Thanks a lot.
> Zhu Yanjun
>
>>> Zhu Yanjun
>>>
>>>> Thanks
