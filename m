Return-Path: <linux-rdma+bounces-244-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BE380430A
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 01:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638A21F211FD
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 00:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CCA17E4;
	Tue,  5 Dec 2023 00:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjsTuw9K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EA9FF
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 16:02:57 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-58cecfb4412so3461180eaf.3
        for <linux-rdma@vger.kernel.org>; Mon, 04 Dec 2023 16:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701734577; x=1702339377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aaoJqphCfF9+yI3m7lth8EjN/bv2RFXBuW5zlkU7Gys=;
        b=cjsTuw9KmQ15/8gwQyKvkKCahbv+1NRy0Pb5YzTsxb5TaM6OGh2gLvH7x/Y42MzQJw
         oursdGVjVGAHW8CBb89dWqwoOND21HROrLXbY55FHzj5SpK5ld1PajaWm2Y7dO/HsI4j
         vsOBEfNf6gzlN/JCDBTan9CnBWBYlQ2KmDxViyYby6D/VeouWj0r7blgEI66wfJk+QxZ
         a2B3kX7R3gvfqteZw9bbmoXsvkLo+L54uxm1jqGzRnFBY9KMYnkQeCAYVpYDT2gVTqWo
         E2yU5wW4SrJkcGF5k9ewqEvQcC9JyoNkzOiLmciP479Ljn5WH4rLqnw3K0PBMLlppaXG
         tAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701734577; x=1702339377;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aaoJqphCfF9+yI3m7lth8EjN/bv2RFXBuW5zlkU7Gys=;
        b=tubCO5NtJof674L7j3cX5u8QgsUeYmQ8X5jteurOF7VJTuybm10JqWrzMEXC64CD+b
         I0Fyjf1p0vlYnl5QefYYpnBl6hbGNkzJipzSYA2pYz/lpEoLEfED+zUu09OO23JGSm/d
         0y9oyoQuyldoe6mceSO4p323AxlDyXYRD9T0JB0DduJBRIR9ISpLgAv6OuRd00fCQblH
         Nu+EhFgnB4tLZepC/LeHyPpFgfLe5tBA/myBYWuR+NYmK4DxyjSNmnaqYmvNiBe93Tt1
         jMvdjU7wEkQwwefy6EIUtQmzTdlcoWe6maCFAkImdUoz/kIZ6Z8uGG/i/CFaE3BVoFRP
         +EPQ==
X-Gm-Message-State: AOJu0YxS7YQVAPffpF6ptvFUPGuaOR/cHxBJ4e3sc4Y5lKXF/dYbYeZT
	QIHV1e9s4TMtCiDhA3rUzJg=
X-Google-Smtp-Source: AGHT+IFwjYlo/OWZatsIT2xxyrKX8TplGstuLJUjhou/imYy013+u0b7mbs5CCwR1Xo2yUi3adw0TQ==
X-Received: by 2002:a4a:bb1a:0:b0:58e:1c48:1ee1 with SMTP id f26-20020a4abb1a000000b0058e1c481ee1mr3265600oop.19.1701734576885;
        Mon, 04 Dec 2023 16:02:56 -0800 (PST)
Received: from ?IPV6:2603:8081:1405:679b:e463:fe8f:1aa8:6edb? (2603-8081-1405-679b-e463-fe8f-1aa8-6edb.res6.spectrum.com. [2603:8081:1405:679b:e463:fe8f:1aa8:6edb])
        by smtp.gmail.com with ESMTPSA id x6-20020a4aea06000000b0058d52d0ef2dsm2052526ood.38.2023.12.04.16.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 16:02:56 -0800 (PST)
Message-ID: <e91c7ff8-9c67-45e8-b28e-5bfa8c9e97da@gmail.com>
Date: Mon, 4 Dec 2023 18:02:55 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v4 0/7] RDMA/rxe: Make multicast work
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@nvidia.com,
 linux-rdma@vger.kernel.org, "leon@kernel.org" <leon@kernel.org>
References: <20231204200342.7125-1-rpearsonhpe@gmail.com>
 <2ce139e0-8fd7-4ed7-af5e-83a9e4b55710@gmail.com>
 <afd3694a-695b-45d9-909c-b28b99a09d24@linux.dev>
From: Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <afd3694a-695b-45d9-909c-b28b99a09d24@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/4/23 17:50, Zhu Yanjun wrote:
> + Leon
> 
> Bob
> 
> Exactly.  Some kind of lock is needed for ipv6_sock_mc_join/drop. I will 
> delve into these commits.
> 
> And this is related with mcast. We can invite netdev experts to review 
> the code as well.
> 
> If you agree, I will also send your commits to netdev maillist.
> 
> And these commits are complicated. It is very good to have the 
> suggestions from
> 
> the experts in netdev.
> 
> Zhu Yanjun
> 
> 在 2023/12/5 4:07, Bob Pearson 写道:
>> Zhu,
>>
>> Thanks for testing this. It turns out I needed to take the sk_lock for
>> ipv6_sock_mc_join/drop().
>>
>> Bob
>>
>> On 12/4/23 14:03, Bob Pearson wrote:
>>> After developing a test program which exercises node to node
>>> testing of RoCE multicast it became clear that there are a
>>> number of issues with the current rdma_rxe multicast implementation.
>>>
>>> The issues seen include:
>>>     - There is no support for IPV4 multicast addresses.
>>>     - Once a multicast MAC is added it is not removed.
>>>     - Multicast packets are sent with the wrong QP number.
>>>     - Multicast IP addresses are not created and without
>>>       them no multicast packets received on the interface
>>>       are delivered to the rdma_rxe driver.
>>>     - The implementation in rxe_mcast.c is potentially
>>>       racy if multiple simultaneous attach/detach operations
>>>       are issued.
>>>
>>> This patch set fixes these issues.
>>> ---
>>> v4:
>>>    Corrected a lockdep bug reported by Zhu Yanjun.
>>> v3:
>>>    Removed rxe_loop_and_send(). It turns out it is not needed.
>>>    Added module parameters to set mcast limits to small values when
>>>    driver is loaded to enable mcast limit testing.
>>>    Rebased to current for-next branch.
>>> v2:
>>>    Respond to comments by Zhu.
>>>    Added more Fixes lines.
>>>    Added some more explanation in the commit messages.
>>>    Fixed an error in rxe_lookup_mcg. Should have checked
>>>     the return from rxe_get_mcg().
>>>
>>> Bob Pearson (7):
>>>    RDMA/rxe: Cleanup rxe_ah/av_chk_attr
>>>    RDMA/rxe: Fix sending of mcast packets
>>>    RDMA/rxe: Register IP mcast address
>>>    RDMA/rxe: Let rxe_lookup_mcg use rcu_read_lock
>>>    RDMA/rxe: Split multicast lock
>>>    RDMA/rxe: Cleanup mcg lifetime
>>>    RDMA/rxe: Add module parameters for mcast limits
>>>
>>>   drivers/infiniband/sw/rxe/Makefile     |   3 +-
>>>   drivers/infiniband/sw/rxe/rxe.c        |   8 +-
>>>   drivers/infiniband/sw/rxe/rxe_av.c     |  50 +--
>>>   drivers/infiniband/sw/rxe/rxe_loc.h    |   6 +-
>>>   drivers/infiniband/sw/rxe/rxe_mcast.c  | 524 +++++++++++--------------
>>>   drivers/infiniband/sw/rxe/rxe_net.c    |   6 +-
>>>   drivers/infiniband/sw/rxe/rxe_net.h    |   1 +
>>>   drivers/infiniband/sw/rxe/rxe_opcode.h |   2 +-
>>>   drivers/infiniband/sw/rxe/rxe_param.c  |  23 ++
>>>   drivers/infiniband/sw/rxe/rxe_param.h  |   4 +
>>>   drivers/infiniband/sw/rxe/rxe_qp.c     |   4 +-
>>>   drivers/infiniband/sw/rxe/rxe_recv.c   |  11 +-
>>>   drivers/infiniband/sw/rxe/rxe_req.c    |  11 +-
>>>   drivers/infiniband/sw/rxe/rxe_verbs.c  |   5 +-
>>>   drivers/infiniband/sw/rxe/rxe_verbs.h  |   5 +-
>>>   15 files changed, 303 insertions(+), 360 deletions(-)
>>>   create mode 100644 drivers/infiniband/sw/rxe/rxe_param.c
>>>
Zhu,

After rereading v4 patch 0003 I noticed that I missed adding locks
around ipv6_sock_mc_drop() in the error path in rxe_mcast_add6().
Would you rather I send a new v4 patch or resend the series as v5?

Bob

