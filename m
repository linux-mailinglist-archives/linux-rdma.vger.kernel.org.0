Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CE1502092
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Apr 2022 04:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241761AbiDOCiW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Apr 2022 22:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiDOCiU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Apr 2022 22:38:20 -0400
X-Greylist: delayed 40903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 19:35:50 PDT
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB494BB9B
        for <linux-rdma@vger.kernel.org>; Thu, 14 Apr 2022 19:35:50 -0700 (PDT)
Message-ID: <7d9b5179-9b32-52c4-f772-805a7c60ec55@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649990148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUP2DqcFEH4b3S6H24VIeZWgZ8d7Qw0Uw/CxKlYHCrY=;
        b=PUbBTitlw7zpnuSG55sOisqlTxpGdBij5puWiYCo+LRlL9yCcANWc1mBX6omWa1qzlDm73
        w/wdIJoy8EXVGBaHR2kR9sQ68LSlxhVX/OnwIcMJbR1A8fbYHspcBOAwN8bk6JPAyW8HQW
        ZbMy9N1Ss09dlJVkYgcoqxJxlu1OJxI=
Date:   Fri, 15 Apr 2022 10:35:42 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv3 1/1] RDMA/rxe: Fix a dead lock problem
To:     Leon Romanovsky <leon@kernel.org>,
        Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
References: <20220413074208.1401112-1-yanjun.zhu@linux.dev>
 <20220413004504.GH64706@ziepe.ca>
 <81db8dcc-e417-bff5-b7ec-1067c717ea62@linux.dev>
 <56c4e893-223d-ad6b-2fa9-ca8b2aace9de@linux.dev>
 <20220414135255.GK64706@ziepe.ca>
 <75363d6a-99f2-f61a-0f41-87e641746efa@linux.dev> <YlhIBI4NmAvK7E5S@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <YlhIBI4NmAvK7E5S@unreal>
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

在 2022/4/15 0:12, Leon Romanovsky 写道:
> On Thu, Apr 14, 2022 at 11:13:57PM +0800, Yanjun Zhu wrote:
>> 在 2022/4/14 21:52, Jason Gunthorpe 写道:
>>> On Thu, Apr 14, 2022 at 09:01:29PM +0800, Yanjun Zhu wrote:
>>>
>>>>>> Still no, this does almost every allocation - only AH with the
>>>>>> non-blocking flag set should use this path.
>>>
>>>> To the function ib_send_cm_req, the call chain is as below.
>>>>
>>>> ib_send_cm_req --> cm_alloc_priv_msg --> cm_alloc_msg --> rdma_create_ah -->
>>>> _rdma_create_ah --> rxe_create_ah --> rxe_av_chk_attr -->__rxe_add_to_pool
>>>>
>>>> As such, xa_lock_irqsave/irqrestore is selected.
>>>
>>> As I keep saying, only the rxe_create_ah() with the non-blocking flag
>>> set should use the GFP_ATOMIC. All other paths must use GFP_KERNEL.
>>>
>>
>> Got it. The GFP_ATOMIC/GFP_KERNEL are used in different paths.
>> rxe_create_ah will use GFP_ATOMIC and others will use GFP_KERNEL.
>> So the codes should be as below:
>>
>> -int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
>> +int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
>> gfp_t gfp)
>>   {
>>          int err;
>> +       unsigned long flags;
>>
>>          if (WARN_ON(pool->flags & RXE_POOL_ALLOC))
>>                  return -EINVAL;
>> @@ -168,10 +170,17 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct
>> rxe_pool_elem *elem)
>>          elem->obj = (u8 *)elem - pool->elem_offset;
>>          kref_init(&elem->ref_cnt);
>>
>> -       xa_lock_irq(&pool->xa);
>> -       err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>> -                               &pool->next, GFP_ATOMIC);
>> -       xa_unlock_irq(&pool->xa);
>> +       if (gfp == GFP_ATOMIC) { /* for rxe_create_ah */
> 
> gfp is bitfield.
> "gfp == GFP_ATOMIC" -> "gfp & GFP_ATOMIC"

Got it. Thanks

Zhu Yanjun

> 
> Thanks

