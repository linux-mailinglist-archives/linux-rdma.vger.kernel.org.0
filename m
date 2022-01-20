Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1901E494ECF
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jan 2022 14:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245046AbiATNVu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jan 2022 08:21:50 -0500
Received: from out0.migadu.com ([94.23.1.103]:43513 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244218AbiATNVs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jan 2022 08:21:48 -0500
Message-ID: <40803074-640b-7e42-8a0f-e515ab7c2874@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1642684907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MoTVKm1ue7H7xRboEKWQqWRhWPzuP6FuXQw61L6Mrgk=;
        b=e9VujbhVDiYYU6rW6ZGW+FBHiryf9DBLD56mY8Fz5uqag8bxM6WulBhSl4Z2173O1xNOtl
        bmt3x1dgAGhHNQJRszI8BKf+DRHlGqJicpYdefKL2d6JYfbjeWIKpG7CAgKY3//k759Myi
        mFiLbmGGKSYUux3vztoBcYiITnb9T+Y=
Date:   Thu, 20 Jan 2022 21:21:40 +0800
MIME-Version: 1.0
Subject: Re: rdma_rxe usage problem
To:     Alexander Kalentyev <comrad.karlovich@gmail.com>
Cc:     linux-rdma@vger.kernel.org
References: <CABrV9Yt0HYenR_qk_QWFkvH4-0Ooeb61y+CyT3WVOnDiAmxjhA@mail.gmail.com>
 <d6551275-6d84-d117-dfa3-91956860ab05@linux.dev>
 <CABrV9YuiYkCKMBMsrnd38ZxwqxJeWMw+xXFRpXc1gMtdAN9bFA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <CABrV9YuiYkCKMBMsrnd38ZxwqxJeWMw+xXFRpXc1gMtdAN9bFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If I remember correctly, can you use this command to make tests?

server:

ibv_rc_pingpong -d rxe0 -g 1

Client:

ibv_rc_pingpong -d rxe0 -g 1 server_ip_addr

Zhu Yanjun

在 2022/1/20 1:53, Alexander Kalentyev 写道:
> With rping everything was fiine, but I had to use a real Ip address.
>   >rping -s -C 10 -v
> server ping data: rdma-ping-0:
> ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqr
> server ping data: rdma-ping-1:
> BCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrs
> server ping data: rdma-ping-2:
> CDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrst
> server ping data: rdma-ping-3:
> DEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu
> server ping data: rdma-ping-4:
> EFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuv
> server ping data: rdma-ping-5:
> FGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvw
> server ping data: rdma-ping-6:
> GHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwx
> server ping data: rdma-ping-7:
> HIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxy
> server ping data: rdma-ping-8:
> IJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz
> server ping data: rdma-ping-9:
> JKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyzA
> server DISCONNECT EVENT...
> wait for RDMA_READ_ADV state 10
>
>> rping -c -a 192.168.0.176 -C 10 -v
> ping data: rdma-ping-0: ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqr
> ping data: rdma-ping-1: BCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrs
> ping data: rdma-ping-2: CDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrst
> ping data: rdma-ping-3: DEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstu
> ping data: rdma-ping-4: EFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuv
> ping data: rdma-ping-5: FGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvw
> ping data: rdma-ping-6: GHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwx
> ping data: rdma-ping-7: HIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxy
> ping data: rdma-ping-8: IJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz
> ping data: rdma-ping-9: JKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyzA
> client DISCONNECT EVENT...
>
> Anyway the ibv_rc_pingpong shows an error:
>
>> ibv_rc_pingpong -d rxe0 -g 0
>    local address:  LID 0x0000, QPN 0x000015, PSN 0x015dd8, GID
> fe80::4a51:c5ff:fef6:e159
> Failed to modify QP to RTR
> Couldn't connect to remote QP
>
>> ibv_rc_pingpong -d rxe0 -g 0 192.168.0.176
>    local address:  LID 0x0000, QPN 0x000016, PSN 0x007fa7, GID
> fe80::4a51:c5ff:fef6:e159
> client read/write: No space left on device
> Couldn't read/write remote address
>
> ср, 19 янв. 2022 г. в 15:12, Yanjun Zhu <yanjun.zhu@linux.dev>:
>> 在 2022/1/19 19:42, Alexander Kalentyev 写道:
>>> I am trying to install and use soft RoCE for development purposes
>>> (right now on a localhost).
>>> I installed rdma-core on a MANJARO system from AUR.
>>> Then I did:
>>>
>>> sudo modprobe rdma_rxe
>>> sudo rdma link add rxe0 type rxe netdev wlp60s0
>>>
>>> then ibstat shows:
>>> CA 'rxe0'
>>>           CA type:
>>>           Number of ports: 1
>>>           Firmware version:
>>>           Hardware version:
>>>           Node GUID: 0x4a51c5fffef6e159
>>>           System image GUID: 0x4a51c5fffef6e159
>>>           Port 1:
>>>                   State: Active
>>>                   Physical state: LinkUp
>>>                   Rate: 2.5
>>>                   Base lid: 0
>>>                   LMC: 0
>>>                   SM lid: 0
>>>                   Capability mask: 0x00010000
>>>                   Port GUID: 0x4a51c5fffef6e159
>>>                   Link layer: Ethernet
>> Can rping work after you configured this test environment?
>>
>> Zhu Yanjun
>>
>>> But launching any example I always get an error by call of: ibv_modify_qp
>>> with an attempt to modify QP state to RTR (for example by launching
>>> .ibv_rc_pingpong)
>>> The type of the error is EINVAL.
>>> I believe I miss something very obvious.
