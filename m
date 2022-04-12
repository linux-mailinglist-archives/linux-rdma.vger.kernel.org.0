Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190124FE419
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 16:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346478AbiDLOsg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 10:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbiDLOsf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 10:48:35 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED1B5C86A
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 07:46:17 -0700 (PDT)
Message-ID: <684cc49d-c144-85a8-0a3d-d9ecd766abd2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649774773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DHGCXcwFN/4fElapjGnfaeyycRUsVTftlT8T3y33W5M=;
        b=wWKni2i++wxzfFN3MLT+C84tT+tWZ9aKdZ2wANSLOHtJeuGW80FaDCfZ9telcWg/clvtXA
        OSbTWWW9Bnm7ffQTXVG6zIwZvFj0Necbx12b9xP/ankM+wIcAAq1dFBhnoVi6u+zewL19q
        keCYVZzbTyQ8ejfA4FOxKee7wnwPCZM=
Date:   Tue, 12 Apr 2022 22:46:01 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Fix a dead lock problem
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
References: <20220411200018.1363127-1-yanjun.zhu@linux.dev>
 <20220411115019.GB64706@ziepe.ca>
 <feb4a977-c438-99dd-f31f-08d259c2f75f@linux.dev>
 <20220412135313.GD64706@ziepe.ca>
 <a8be1cf3-62d1-43ea-a86c-70e82c6de702@linux.dev>
 <20220412143118.GF64706@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220412143118.GF64706@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/4/12 22:31, Jason Gunthorpe 写道:
> On Tue, Apr 12, 2022 at 10:28:16PM +0800, Yanjun Zhu wrote:
>> 在 2022/4/12 21:53, Jason Gunthorpe 写道:
>>> On Tue, Apr 12, 2022 at 09:43:28PM +0800, Yanjun Zhu wrote:
>>>> 在 2022/4/11 19:50, Jason Gunthorpe 写道:
>>>>> On Mon, Apr 11, 2022 at 04:00:18PM -0400, yanjun.zhu@linux.dev wrote:
>>>>>> @@ -138,8 +139,10 @@ void *rxe_alloc(struct rxe_pool *pool)
>>>>>>     	elem->obj = obj;
>>>>>>     	kref_init(&elem->ref_cnt);
>>>>>> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>>>>>> -			      &pool->next, GFP_KERNEL);
>>>>>> +	xa_lock_irqsave(&pool->xa, flags);
>>>>>> +	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>>>>>> +				&pool->next, GFP_ATOMIC);
>>>>>> +	xa_unlock_irqrestore(&pool->xa, flags);
>>>>> No to  using atomics, this needs to be either the _irq or _bh varient
>>>> If I understand you correctly, you mean that we should use
>>>> xa_lock_irq/xa_unlock_irq or xa_lock_bh/xa_unlock_bh instead of
>>>> xa_unlock_irqrestore?
>>> This is correct
>>>
>>>> If so, xa_lock_irq/xa_unlock_irq or xa_lock_bh/xa_unlock_bh is used here,
>>>> the warning as below will appear. This means that __rxe_add_to_pool disables
>>>> softirq, but fpu_clone enables softirq.
>>> I don't know what this is, you need to show the whole debug.
>> The followings are the warnings if xa_lock_bh + __xa_alloc(...,GFP_KERNEL)
>> is used. The diff is as below.
>>
>> If xa_lock_irqsave/irqrestore + __xa_alloc(...,GFP_ATOMIC) is used,
>> the waring does not appear.
> That is because this was called in an atomic context:
>
>> [   92.107490]  __rxe_add_to_pool+0x76/0xa0 [rdma_rxe]
>> [   92.107500]  rxe_create_ah+0x59/0xe0 [rdma_rxe]
>> [   92.107511]  _rdma_create_ah+0x148/0x180 [ib_core]
>> [   92.107546]  rdma_create_ah+0xb7/0xf0 [ib_core]
>> [   92.107565]  cm_alloc_msg+0x5c/0x170 [ib_cm]
>> [   92.107577]  cm_alloc_priv_msg+0x1b/0x50 [ib_cm]
>> [   92.107584]  ib_send_cm_req+0x213/0x3f0 [ib_cm]
>> [   92.107613]  rdma_connect_locked+0x238/0x8e0 [rdma_cm]
>> [   92.107637]  rdma_connect+0x2b/0x40 [rdma_cm]
>> [   92.107646]  ucma_connect+0x128/0x1a0 [rdma_ucm]
>> [   92.107690]  ucma_write+0xaf/0x140 [rdma_ucm]
>> [   92.107698]  vfs_write+0xb8/0x370
>> [   92.107707]  ksys_write+0xbb/0xd0
> Meaning the GFP_KERNEL is already wrong.
>
> The AH path needs to have its own special atomic allocation flow and
> you have to use an irq lock and GFP_ATOMIC for it.

static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private 
*cm_id_priv)
{
...
spin_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
...
         ah = rdma_create_ah(mad_agent->qp->pd, &cm_id_priv->av.ah_attr, 0);

...

spin_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
...
}
Yes. Exactly.

In cm_alloc_msg, spinlock is used. And __rxe_add_to_pool should not use 
GFP_KERNEL.

Thanks a lot. I will send the latest patch very soon.


Zhu Yanjun

>
> Jason
