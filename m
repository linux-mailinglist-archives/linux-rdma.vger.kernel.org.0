Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2850039E2F4
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 18:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhFGQUM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 12:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbhFGQST (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Jun 2021 12:18:19 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ED0C061198
        for <linux-rdma@vger.kernel.org>; Mon,  7 Jun 2021 09:14:43 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id z3so18601811oib.5
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lGVVecA2A3HEChq6Z4wVsj22qxNqYclznAOTUlzwERo=;
        b=eH0ZC4G4VxMDGgnfFlPV2KK7sRuHpzgkrcbad5eYuPCndrtGel8kckPOrA+m/M8knl
         F6nxPjv7qSR/1d6CZLfImic62NnkTqFrjogpC0/C/jC7MNE18Q/eTIBZqrh13DyIoTMD
         Yp44vLBgj8wIngFAH937JeM++8W47fcR2ZnwvTCxW27+2urfq1dSvXC2wYb83RtXCQ2V
         IGhYyFYXyUT3adQXnKTE3guxM2yicpUqpnhc1Xfr78s09UeHRzJrPQJ+8WykEc4hj0Cc
         YjW65Eqy3pDrRmH8SWLpBlZ/TSTIgqB4YOUfTP8vwzLL090YgoOJXflcpz4s9odjr6yW
         zqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lGVVecA2A3HEChq6Z4wVsj22qxNqYclznAOTUlzwERo=;
        b=R/3DSpmKzwRtWICNFA8KI4c7fmGaoe08oIqObiAvgal0GdwF5De486yz+i1v5klgam
         Y+r+jLyysGDB67+GAqzEienzUmGCqsaD9pULPzLJGIYaXvLip6POtpR1wobVizyd0D8z
         yUAS7Ejrgm7eEFWBOf6JIVS9buIbR8U9SEYJG1PpaH+NmXVL4SrqcIn3v1TTVCNJT1BG
         HP1j5A392f0ypaTyFnhXu36WZqlYJHl3qCmIr78AR4ipGhzSjZDETQsSWr8t7VFQk04R
         eUtgb/d2N3IZPR2O477DH2v8kCL5HrmEDQrI9veJ8Qwbk+a6g2ReumCqRVhMcgxPOenX
         erKQ==
X-Gm-Message-State: AOAM532YslUUwujAATbO0kfSsEkorVSz2v3415E8c1pzq6vq0OJPRb8Y
        MBJWIx0HHT44nD3RTYKBveY0dsqr1b8=
X-Google-Smtp-Source: ABdhPJwXbjcJHg68HjK7HK8pf1aUVgQ4NcwLsBFidtyWkkSJ8T96rYhJdHtE3sxiNVvKdDiQlKXS7A==
X-Received: by 2002:aca:4cc3:: with SMTP id z186mr11973130oia.73.1623082482562;
        Mon, 07 Jun 2021 09:14:42 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:415a:f1da:2582:537? (2603-8081-140c-1a00-415a-f1da-2582-0537.res6.spectrum.com. [2603:8081:140c:1a00:415a:f1da:2582:537])
        by smtp.gmail.com with ESMTPSA id w200sm2331700oie.10.2021.06.07.09.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 09:14:42 -0700 (PDT)
Subject: Re: [PATCH for-next] RDMA/rxe: Fix qp reference counting for atomic
 ops
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210604230558.4812-1-rpearsonhpe@gmail.com>
 <CAD=hENcwwjS8X2R24+cFRyyrA5_k=F5LuC4bx1tzCVW969uvuQ@mail.gmail.com>
 <YL389Dqd8+akhb1i@unreal>
 <CAD=hENd6J=1eTPn3u8M5rvym1xP_A30DnreKOCvi+hLTh0iuNw@mail.gmail.com>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <e0be8fe4-dcda-ddbe-faa4-104d36442b96@gmail.com>
Date:   Mon, 7 Jun 2021 11:14:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAD=hENd6J=1eTPn3u8M5rvym1xP_A30DnreKOCvi+hLTh0iuNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/7/2021 6:12 AM, Zhu Yanjun wrote:
> On Mon, Jun 7, 2021 at 7:03 PM Leon Romanovsky <leon@kernel.org> wrote:
>> On Mon, Jun 07, 2021 at 04:16:37PM +0800, Zhu Yanjun wrote:
>>> On Sat, Jun 5, 2021 at 7:07 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>> Currently the rdma_rxe driver attempts to protect atomic responder
>>>> resources by taking a reference to the qp which is only freed when the
>>>> resource is recycled for a new read or atomic operation. This means that
>>>> in normal circumstances there is almost always an extra qp reference
>>>> once an atomic operation has been executed which prevents cleaning up
>>>> the qp and associated pd and cqs when the qp is destroyed.
>>>>
>>>> This patch removes the call to rxe_add_ref() in send_atomic_ack() and the
>>>> call to rxe_drop_ref() in free_rd_atomic_resource(). If the qp is
>>> Not sure if it is a good way to fix this problem by removing the call
>>> to rxe_add_ref.
>>> Because taking a reference to the qp is to protect atomic responder resources.
>>>
>>> Removing rxe_add_ref is to decrease the protection of the atomic
>>> responder resources.
>> All those rxe_add_ref/rxe_drop_ref in RXE are horrid. It will be good to delete them all.
>>
> I made tests with this commit. After this commit is applied, this
> problem disappeared.
You were testing MW when you saw this bug. Does that mean that now MW is 
working for you?
>
> Zhu Yanjun
>
>> Thanks
