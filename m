Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE6F4FE300
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 15:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356271AbiDLNqE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 09:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349624AbiDLNp7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 09:45:59 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BA84EDFD
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 06:43:41 -0700 (PDT)
Message-ID: <feb4a977-c438-99dd-f31f-08d259c2f75f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649771019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X4lS3VbTtglUgJGkUpa9SIRRPgqxdVFkXXhpXB5iDZ8=;
        b=BsmqHQ7hXYSi201X5i4fVVI0Uuuxzky63eilqbYgzox17HSFog2pVWGw5bfiprE7Gb+M4w
        5hPPLWsV9bew0P54pLrO8mKwxRh7CSgt+d/aw88/DRugMhWcc29I/eRBPwvi4YP2xeV5fo
        /IpfwPiYdn1uTigkxXlOKsHoxVVYd3A=
Date:   Tue, 12 Apr 2022 21:43:28 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Fix a dead lock problem
To:     Jason Gunthorpe <jgg@ziepe.ca>, yanjun.zhu@linux.dev
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
References: <20220411200018.1363127-1-yanjun.zhu@linux.dev>
 <20220411115019.GB64706@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220411115019.GB64706@ziepe.ca>
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

在 2022/4/11 19:50, Jason Gunthorpe 写道:
> On Mon, Apr 11, 2022 at 04:00:18PM -0400, yanjun.zhu@linux.dev wrote:
>> @@ -138,8 +139,10 @@ void *rxe_alloc(struct rxe_pool *pool)
>>   	elem->obj = obj;
>>   	kref_init(&elem->ref_cnt);
>>   
>> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>> -			      &pool->next, GFP_KERNEL);
>> +	xa_lock_irqsave(&pool->xa, flags);
>> +	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>> +				&pool->next, GFP_ATOMIC);
>> +	xa_unlock_irqrestore(&pool->xa, flags);
> 
> No to  using atomics, this needs to be either the _irq or _bh varient

If I understand you correctly, you mean that we should use 
xa_lock_irq/xa_unlock_irq or xa_lock_bh/xa_unlock_bh instead of 
xa_unlock_irqrestore?

If so, xa_lock_irq/xa_unlock_irq or xa_lock_bh/xa_unlock_bh is used 
here, the warning as below will appear. This means that 
__rxe_add_to_pool disables softirq, but fpu_clone enables softirq.

"
Apr 12 16:24:53 kernel: softirqs last  enabled at (13086): 
[<ffffffff91830d26>] fpu_clone+0xf6/0x570
Apr 12 16:24:53 kernel: softirqs last disabled at (13129): 
[<ffffffffc077f319>] __rxe_add_to_pool+0x49/0xa0 [rdma_rxe]
"

As such, it is better to use xa_unlock_irqrestore + 
__xa_alloc(...,GFP_ATOMIC/GFP_NOWAIT).

Zhu Yanjun

> 
> Jason

