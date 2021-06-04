Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD6339C067
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jun 2021 21:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFDT2d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Jun 2021 15:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhFDT2d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Jun 2021 15:28:33 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140FDC061766
        for <linux-rdma@vger.kernel.org>; Fri,  4 Jun 2021 12:26:47 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id t140so5545766oih.0
        for <linux-rdma@vger.kernel.org>; Fri, 04 Jun 2021 12:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=z9fuIELA9UBav6Qzignm4uwKFi4pSNEPBpyp5XMnMB8=;
        b=pOaKQxZ1zeJshpNJB2b6/ZupoVHTOVQ8FLP23eHeW+iY+0hGGg8rWC5hATMZKdPYFg
         TSgvqc2Amw+xHbtJAvwciuWik+uwOzDqTFXO3A8/vmPSHKtIN4hMnzvZetXkOfbfwVUX
         WsiJwZd6/ChbAClPTnx6r7buDvDVO1FnVApFUeRZhXXZjuwV/kK+d52WZVCgJgnw35mF
         Wi2FJnamfXr27PN3pNHc+RjVDXUyDVRDL4ht6cvAlMgP2+MgooIFmhNF/Ou0m/M7yX/D
         TH2wSFkJE/qYrFFh8LZ2GF93iGR54RRwh3VlDD5fuUYWkyccOG4oJ7qH5bdgCR1m4Wd7
         Lfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=z9fuIELA9UBav6Qzignm4uwKFi4pSNEPBpyp5XMnMB8=;
        b=qKff8/+wgJL2u8OE3Bvk7ySZuPszVyWYDn2E0B+ST5pC9eShkrsraOITiVxQaTpIBG
         ZGFL+5iOWtFsKMRBfaP4uq8unYLoccsxD6W7UrvK8k1xmd0PBR3+WVZDVZQPKP+DP1sc
         K+uVWjL151UtcrPx7D8Hf3OlzJwsUM2vt71IWNZluYfIGdM/JVTSAXLNB7/wZzPGpktn
         ummerZk9kV8X+BpcP9ird37m9WAcESJG+SNC2bhIbCoMwI8p4mM8XWj6LNhUrYwBUdRG
         5fv/o/A2/gAXUuzy/ZZTzEZrRFz+zt0qcOqumhRS9y8eBq63jdqZwFI3eG8EXKBkiIcJ
         HdZA==
X-Gm-Message-State: AOAM5324yOfi8PG+TZmE3yQv8grg7HmvKYVvr2Oee6Y3miw4qDgNvKur
        7MWZydktezlnnzdcnq6h7H6Yjt0dl4U=
X-Google-Smtp-Source: ABdhPJxgFcpcKr8g5+SVmqem6O9zyYICRybKiWRzqncrCIGoPmXe+bcppQ+qKX+LqChwrjTlUmKR0w==
X-Received: by 2002:a54:4690:: with SMTP id k16mr11943634oic.57.1622834806304;
        Fri, 04 Jun 2021 12:26:46 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:81b6:accf:d415:6279? (2603-8081-140c-1a00-81b6-accf-d415-6279.res6.spectrum.com. [2603:8081:140c:1a00:81b6:accf:d415:6279])
        by smtp.gmail.com with ESMTPSA id x187sm656037oia.17.2021.06.04.12.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 12:26:45 -0700 (PDT)
Subject: Re: [PATCH for-next v8 00/10] RDMA/rxe: Implement memory windows
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, zyj2000@gmail.com,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210525213751.629017-1-rpearsonhpe@gmail.com>
 <20210603185804.GA317620@nvidia.com>
 <CAD=hENeqZrtLbJF2J-HuetJec8MNfAVDHmcwkWmMNAfeX4-vng@mail.gmail.com>
 <0c9c8709-8816-6083-59ef-c8d664ba382c@gmail.com>
 <8ae22b01-51e0-4115-31a5-ff9c1378efb6@gmail.com>
 <20210604175532.GX1002214@nvidia.com>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <84e39160-1346-cc5e-f4a0-77edcb9940a7@gmail.com>
Date:   Fri, 4 Jun 2021 14:26:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210604175532.GX1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/4/2021 12:55 PM, Jason Gunthorpe wrote:
> On Fri, Jun 04, 2021 at 12:53:51PM -0500, Pearson, Robert B wrote:
>> On 6/4/2021 11:22 AM, Pearson, Robert B wrote:
>>> On 6/4/2021 12:37 AM, Zhu Yanjun wrote:
>>>> After I added a rxe device on the netdev, then run rdma-core test tools.
>>>> Then I remove rxe device, in the end, I unloaded rdma_rxe kernel
>>>> modules.
>>>> I found the above logs.
>>>> "
>>>> [ 1249.651921] rdma_rxe: rxe-pd pool destroyed with unfree'd elem
>>>> [ 1249.651927] rdma_rxe: rxe-qp pool destroyed with unfree'd elem
>>>> [ 1249.651929] rdma_rxe: rxe-cq pool destroyed with unfree'd elem
>>>> "
>>>>
>>>> It seems that  some resources leak.
>>>>
>>>> I will make further investigations.
>>>>
>>>> Zhu Yanjun
>>> Zhu,
>>>
>>> I suspect this is an older error. I traced all the add and drop ref
>>> calls for PDs, then ran the full suite of Python tests and also test_mr
>>> which includes the memory window tests by itself and then counted the
>>> adds and drops. For test_mr alone I get 85 adds and 85 drops but when I
>>> run the whole suite I get 384 adds and 380 drops. Since the memory
>>> window code is only exercised in test_mr I think it is OK. Somewhere
>>> else there are missing drops. I will try to isolate them.
>>>
>>> Bob
>>>
>> Zhu,
>>
>> In rdma_core/tests/test_qpex.py test_qp_ex_rc_atomic_cmp_swp and
>> test_qp_ex_rc_atomic_fetch_add each have two missing drops of PDs. This is
>> either a test bug or a bug in the rxe driver but it has nothing to do with
>> the MW code. We should treat it as a separate error. For some reason these
>> test cases are not cleaning up all resources.
>>
>> The cleanup code in all these Python tests is very implicit. It just happens
>> by magic so it is hard to figure out where an ibv_destroy_qp or
>> ibv_destroy_cq went missing. It would help if someone who is familiar with
>> these tests could look at it.
> It is impossible for userspace to leak a kernel resource, when the fd
> is closed everything is destroyed back to the driver guarenteed by the
> kernel.
>
> As long as pyverbs has exited pyverbs cannot be the bug
>
> Jason

Thanks. That helped. Adding traces for QP references turned up the 
problem. Someone took a reference on QP in send_atomic_ack() that is 
never matched by a drop reference. The logic was probably to protect the 
QP from going away while it held an atomic responder resource. The 
problem is that since the requester can retry the operation multiple 
times the responder never knows when to free the resource so it doesn't. 
It just recycles them FIFO when a new atomic request comes along. They 
are looked up by PSN. So the only logical solution is to not take the 
extra reference. If you destroy the QP while a requester is retrying 
atomic operations it just fails.

I'll submit a patch deleting one line.

Bob

