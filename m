Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F46550C4C7
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Apr 2022 01:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiDVXjQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Apr 2022 19:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiDVXi5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Apr 2022 19:38:57 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A99FAF5A
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 16:26:47 -0700 (PDT)
Message-ID: <9331a943-cbbd-43fd-a366-e993304f5fbf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650670006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+R5qMr8wO2SQHlHHZ/r4n+xDqRTcpePyk4EK0Mrp7tw=;
        b=tlepnO2O7/6phexbnMLcS9YHIxhcXSpuoXTd+aQ31Vu85uuJ62cyZIVy8rm2Z6H89AwwyO
        WTb2uBidmryrr3LFNjwSE9DNAsIGtzC1qPoloW/OLJzSOtPMNGqJ2r9xFjPuiJaKCNakNC
        qabtyTMzWM/aIWEWKX7PXKbCaaHVhTQ=
Date:   Sat, 23 Apr 2022 07:26:36 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] RDMA/rxe: Check RDMA_CREATE_AH_SLEEPABLE in creating
 AH
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
References: <20220422194416.983549-1-yanjun.zhu@linux.dev>
 <20220422194416.983549-4-yanjun.zhu@linux.dev>
 <20220422164915.GV64706@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220422164915.GV64706@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/4/23 0:49, Jason Gunthorpe 写道:
> On Fri, Apr 22, 2022 at 03:44:16PM -0400, yanjun.zhu@linux.dev wrote:
>> @@ -166,16 +166,18 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
>>   	elem->obj = (u8 *)elem - pool->elem_offset;
>>   	kref_init(&elem->ref_cnt);
>>   
>> -	if (pool->type == RXE_TYPE_AH) {
>> +	if ((pool->type == RXE_TYPE_AH) && (gfp & GFP_ATOMIC)) {
>>   		unsigned long flags;
> No test for AH should be here, just gfp.

Agree. Got it.

Zhu Yanjun

>
> Jason
