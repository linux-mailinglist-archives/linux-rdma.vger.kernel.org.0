Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CBB4FE30E
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 15:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356260AbiDLNwB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 09:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242810AbiDLNv7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 09:51:59 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CD24E392
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 06:49:39 -0700 (PDT)
Message-ID: <cc892813-5737-9600-28c1-0ad899b31eae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649771377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JF7pyaW0Ol89JibMy6y1N1DxObi47mpqU5PSCenmn6U=;
        b=JmvYE1VKn2N8SinVICVaNSzqovcqtga0182voUEl75J/mnctin3FH2N4auKAY9WoMqXWBv
        Laf8Wwy9gW4tyAb8adZ+2qEQsRT025hYPjwp+hS+lTHcD5if6lo2mvMr0dkUWi8NBa2gPZ
        Z5uIEokaqcRiTsbtpDFCYdt0lmfBL9o=
Date:   Tue, 12 Apr 2022 21:49:27 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/rxe: Fix "Replace red-black trees by
 xarrays"
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220410223939.3769-1-rpearsonhpe@gmail.com>
 <ec1de70c-aa84-7c3a-af6c-4a04c5002d1e@acm.org>
 <6296dc52-1298-6a52-a4fb-2c6fe04ab151@gmail.com>
 <20220411113836.GD2120790@nvidia.com>
 <PH7PR84MB1488692D33B6CA7445569DA3BCEA9@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
 <20220411160217.GA4139526@nvidia.com>
 <4314cea9-b5c4-b0e6-60f3-b3a91abce505@linux.dev>
 <20220412133946.GH2120790@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220412133946.GH2120790@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/4/12 21:39, Jason Gunthorpe 写道:
> On Tue, Apr 12, 2022 at 09:32:25PM +0800, Yanjun Zhu wrote:
>> 在 2022/4/12 0:02, Jason Gunthorpe 写道:
>>> On Mon, Apr 11, 2022 at 03:52:23PM +0000, Pearson, Robert B wrote:
>>>>> Yes, you cannot use irq_save variants here. You have to know your calling context is non-atomic already and use the irq wrapper.
>>>> Not sure why. If you call irqsave in a non-atomic context doesn't it
>>>> behave the same as irq? I.e. flags = 0.  xarray provides
>>>> xa_lock_xxx() for people to use. Are you saying I have to call
>>>> xa_alloc_cyclic_xxx() instead which is the same thing?
>>> The xa_lock is a magic thing, when you call a __xa_*(.., GFP_KERNEL)
>>> type function then it will unlock and relock the xa_lock internally.
>>>
>>> Thus you cannot wrapper an irqsave lock across the GFP_KERNEL call
>>> sites because XA doesn't know the 'flags' to be able to properly
>>> unlock it.
>>>
>>>> The problem is I've gotten gun shy about people calling into the
>>>> verbs APIs in strange contexts. The rules don't seem to be written
>>>> down. If I could be certain that no one ever is allowed to call a
>>>> verbs API in an interrupt then this is correct but how do I know
>>>> that?
>>> rxe used GFP_KERNEL so it already has assumed it is a process context.
>> Got it.
>>
>> __xa_alloc_cyclic(..., GFP_NOWAIT) will unlock xa lock internally. But it
>> does not handle flags. So the irq is still disabled. Because GFP_NOWAIT is
>> used in __xa_alloc_cyclic, it will not sleep.
>>
>> __xa_alloc_cyclic will lock xa lock and return to xa_unlock_irqrestore.
>>
>> So the following code should be OK?
>>
>>          xa_lock_irqsave(&pool->xa, flags);
>>          err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>>                                  &pool->next, GFP_NOWAIT);
>>          xa_unlock_irqrestore(&pool->xa, flags);
> No, use GFP_KERNEL an use the proper irq or bh version of
> xa_alloc_cyclic.
>
> save is only required if you don't know the contex you are in, and
> here we know we are in a process context.

if we use xa_lock_irq/xa_unlock_irq or xa_lock_bh/xa_unlock_bh instead 
of xa_unlock_irqrestore,

the warning as below will appear. This means that __rxe_add_to_pool 
disables softirq, but fpu_clone enables softirq.

"
Apr 12 16:24:53 kernel: softirqs last  enabled at (13086): 
[<ffffffff91830d26>] fpu_clone+0xf6/0x570
Apr 12 16:24:53 kernel: softirqs last disabled at (13129): 
[<ffffffffc077f319>] __rxe_add_to_pool+0x49/0xa0 [rdma_rxe]
"

As such, it is better to use xa_unlock_irqrestore + 
__xa_alloc(...,GFP_ATOMIC/GFP_NOWAIT).

Zhu Yanjun

>
> Jason
