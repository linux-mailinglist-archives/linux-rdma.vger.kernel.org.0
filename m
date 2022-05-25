Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FFA5335F2
	for <lists+linux-rdma@lfdr.de>; Wed, 25 May 2022 06:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiEYEL6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 May 2022 00:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiEYEL6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 May 2022 00:11:58 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF5C39691;
        Tue, 24 May 2022 21:11:54 -0700 (PDT)
Subject: Re: [PATCH] RDMA/rxe: Use kzalloc() to alloc map_set
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653451913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RrIgS56jdPjDpT27H2P4h5+BweND/NiSFiwMytt9a9s=;
        b=ayjrdGkxpHrjEvNxosFqK8iyxDY3v0wkg4/98lfWBqOQyANFYyDxikJ1b55fbfQZ5wJC1T
        JMMaf7LAXpF2v8FVRnxMxVjVytWW65fxnbkCQHd7v6Fmx1i6VqJ6EZoYnI4yWrsFNp45dB
        RJ/8VCmTF2QnCsB0nbL3nEi/c/sp5D4=
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>
References: <20220518043725.771549-1-lizhijian@fujitsu.com>
 <20220520144511.GA2302907@nvidia.com>
 <d956bac8-36a6-0148-6f9c-fa43c8c272a7@fujitsu.com>
 <3e3373f5-7b12-a8e8-2d73-c2976b272290@fujitsu.com>
 <CAJpMwyhhWSC_x4Fef32iW5Umzk5bLdJFweuZmN9LEJTQGyHfbQ@mail.gmail.com>
 <123f5c7e-c2eb-7703-ace9-bc5074a394dd@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <94a5ea93-b8bb-3a01-9497-e2021f29598a@linux.dev>
Date:   Wed, 25 May 2022 12:11:44 +0800
MIME-Version: 1.0
In-Reply-To: <123f5c7e-c2eb-7703-ace9-bc5074a394dd@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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



On 5/25/22 9:31 AM, lizhijian@fujitsu.com wrote:
>
> On 24/05/2022 18:56, Haris Iqbal wrote:
>> On Tue, May 24, 2022 at 6:00 AM lizhijian@fujitsu.com
>> <lizhijian@fujitsu.com> wrote:
>>> Hi Jason & Bob
>>> CC Guoqing
>>>
>>> @Guoqing, It may correlate with your previous bug report: https://lore.kernel.org/all/20220210073655.42281-1-guoqing.jiang@linux.dev/T/
>>>
>>>
>>> It's observed that a same MR in rnbd server will trigger below code
>>> path:
>>>     -> rxe_mr_init_fast()
>>>     |-> alloc map_set() # map_set is uninitialized
>>>     |...-> rxe_map_mr_sg() # build the map_set
>>>         |-> rxe_mr_set_page()
>>>     |...-> rxe_reg_fast_mr() # mr->state change to VALID from FREE that means
>>>                              # we can access host memory(such rxe_mr_copy)
>>>     |...-> rxe_invalidate_mr() # mr->state change to FREE from VALID
>>>     |...-> rxe_reg_fast_mr() # mr->state change to VALID from FREE,
>>>                              # but map_set was not built again
>>>     |...-> rxe_mr_copy() # kernel crash due to access wild addresses
>>>                          # that lookup from the map_set

Yes, it could be similar issue thought I didn't get kernel crash, but it 
was FMR relevant.

https://lore.kernel.org/all/20220210073655.42281-1-guoqing.jiang@linux.dev/T/#m5dc6898375cedf17fea13ccebf595aac0454c841

> Yes, this workaround should work but expensive.
> It seems Bob has started a new thread to discuss the FMRs in https://www.spinics.net/lists/linux-rdma/msg110836.html

Will give it a try, thanks for the link.

Thanks,
Guoqing
