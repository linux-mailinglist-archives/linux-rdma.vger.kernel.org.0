Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9660D39EDCF
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 06:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbhFHEwu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 00:52:50 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:46598 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhFHEwu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 00:52:50 -0400
Received: by mail-oi1-f172.google.com with SMTP id c13so14833825oib.13
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 21:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8xQZRVXh7NiKI9GXSmTX5mG4ss4Jv9Mg/7rSRtlDORs=;
        b=unEtTjH/Sp9C7XZkrgPLfkW6ykP+TG/3NbzoLlve65SP2t35jJQUiRVkU0HzrBqk+b
         cUswWS+aUPAT3o+diArdTUICeL7k77ZMq/bsGf6zDq/Cf5ZzyoTM2xx/7o89AlKFbGvv
         aibW8DAjHOUsguV4kXL8C47JDTXc/XrvLFG6vCu76BzWeo+sLvdJR/ujCqFes8vGyzUQ
         rpFn29Ag9Ry4GxtM5OC236quL8srS77QL6PSvNW0bj4fZ23BVSqbbau5Yc6eK1dKM9KF
         95PESVUVAW7C1bxhBOHJkQ9bFQeqSWtWEEf7LJlcnKRRrsgqDp3fTY9eKOSsOWZq6NRY
         sVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8xQZRVXh7NiKI9GXSmTX5mG4ss4Jv9Mg/7rSRtlDORs=;
        b=gPF1VPAwRyFD2WEUJezC06j4S9fKcdsDYyOeUha+1m6q8OooBdKuUpzYVWDXN/nkgZ
         h+Tzk4GO3YZzlSwhG6nTCBI091nT54P3i6hNYbvEgKgItpaU73OOGuP+k8DeOTVMpDTV
         4eb0QDq3FnouzMfQlrc9gllYYqpuwXJQ+96CgRIYir5kjCFRnTvjzUY9ph148gaTd3BV
         FRC+hpsMqq5JyJ/XeWWx7/ufIxVE7fKxkwUPpuWZYsqtwFoFJvjoRHzWMinoF43YGa0c
         qoNMyM7Kjw0Ya3DIz/YFG9saot5xDI6zSeb66HoOdkTV5EfBncLuUeW+1v14vPIy6w3h
         BvwA==
X-Gm-Message-State: AOAM5303aUtL1PA4l4psblrEyhugE/wBZDPeT8bq9WS97TNf32Smwo++
        twQnpTpjqlkZatjAoIAuSQSICoil2dc=
X-Google-Smtp-Source: ABdhPJyn9unmjADFVra/aMYPU0vWakatH8jhjG8URfu39WJyzK/ZMAx5odlChZuQb3CKfaYas63arQ==
X-Received: by 2002:aca:3c1:: with SMTP id 184mr1333466oid.154.1623127797523;
        Mon, 07 Jun 2021 21:49:57 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:c5c4:ae82:7e0d:a0c? (2603-8081-140c-1a00-c5c4-ae82-7e0d-0a0c.res6.spectrum.com. [2603:8081:140c:1a00:c5c4:ae82:7e0d:a0c])
        by smtp.gmail.com with ESMTPSA id x8sm2624666oiv.51.2021.06.07.21.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 21:49:57 -0700 (PDT)
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
 <95a4ddf1-fcbc-51fd-6cc7-932f065c61bf@gmail.com>
 <CAD=hENdJeroo5+MaxBFMKfF8zJjVkEbMXFffUjBKZjODLxQgvg@mail.gmail.com>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <14111e5b-d38a-0a09-546f-18cfc4c0c2cc@gmail.com>
Date:   Mon, 7 Jun 2021 23:49:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAD=hENdJeroo5+MaxBFMKfF8zJjVkEbMXFffUjBKZjODLxQgvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/7/2021 10:48 PM, Zhu Yanjun wrote:
> On Tue, Jun 8, 2021 at 10:01 AM Pearson, Robert B <rpearsonhpe@gmail.com> wrote:
>>
>> On 6/7/2021 8:39 PM, Zhu Yanjun wrote:
>>> On Tue, Jun 8, 2021 at 12:14 AM Pearson, Robert B <rpearsonhpe@gmail.com> wrote:
>>>> On 6/7/2021 6:12 AM, Zhu Yanjun wrote:
>>>>> On Mon, Jun 7, 2021 at 7:03 PM Leon Romanovsky <leon@kernel.org> wrote:
>>>>>> On Mon, Jun 07, 2021 at 04:16:37PM +0800, Zhu Yanjun wrote:
>>>>>>> On Sat, Jun 5, 2021 at 7:07 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>>>>>> Currently the rdma_rxe driver attempts to protect atomic responder
>>>>>>>> resources by taking a reference to the qp which is only freed when the
>>>>>>>> resource is recycled for a new read or atomic operation. This means that
>>>>>>>> in normal circumstances there is almost always an extra qp reference
>>>>>>>> once an atomic operation has been executed which prevents cleaning up
>>>>>>>> the qp and associated pd and cqs when the qp is destroyed.
>>>>>>>>
>>>>>>>> This patch removes the call to rxe_add_ref() in send_atomic_ack() and the
>>>>>>>> call to rxe_drop_ref() in free_rd_atomic_resource(). If the qp is
>>>>>>> Not sure if it is a good way to fix this problem by removing the call
>>>>>>> to rxe_add_ref.
>>>>>>> Because taking a reference to the qp is to protect atomic responder resources.
>>>>>>>
>>>>>>> Removing rxe_add_ref is to decrease the protection of the atomic
>>>>>>> responder resources.
>>>>>> All those rxe_add_ref/rxe_drop_ref in RXE are horrid. It will be good to delete them all.
>>>>>>
>>>>> I made tests with this commit. After this commit is applied, this
>>>>> problem disappeared.
>>>> You were testing MW when you saw this bug. Does that mean that now MW is
>>>> working for you?
>>> Your MW patches are huge. After these patches are applied, I found 2
>>> problems in my test environment.
>> The trace you showed looked like the pyverbs tests all passed and then
>> there were leaked QP/PD/CQ. I also saw those. After fixing the QP
>> reference count bug (not in MW) I did not see any errors from the
>> pyverbs tests of MW. Or any other errors for that matter. What was the
>> other problem? Was that the memory barrier one (also not in MW)?
>>
>> Mostly I want to know if you currently see any errors in the kernel
>> related to MW. The test case bug (in test_qpex.py) is a separate issue
> The current test cases in rdma-core just confirm a regression in RXE.
>
> Zhu Yanjun

Which test cases are you referring to. Currently all test cases either 
pass or are skipped because they are not supported with one single 
exception. That test in test_qpex.py is *not* a regression. It used to 
skip until I added support for the extended MW bind operation to the 
user code today. It now fails because the test is actually wrong. It 
didn't set the access flags for the MR to support bind MW so the driver 
fails the WR with a bind MW error which is the correct behavior. The 
traditional QP WR API (ibv_post_send) exercises the same exact 
functionality of the driver and they all set the MR access correctly and 
pass. There are *no* actual errors being reported by the rdma-core tests.

Bob

>
>> that is not a rxe bug at all.
>>
>> Bob
>>
>>> So IMO, can you send the test cases about MW to rdma-core? So we can
>>> verify these MW patches with them.
>>>
>>> In previous mails, you mentioned these MW test cases.
>>>
>>> Thanks a lot.
>>> Zhu Yanjun
>>>
>>>>> Zhu Yanjun
>>>>>
>>>>>> Thanks
