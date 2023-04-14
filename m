Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BFC6E1C2B
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Apr 2023 08:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDNGEd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Apr 2023 02:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNGEc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Apr 2023 02:04:32 -0400
Received: from out-47.mta0.migadu.com (out-47.mta0.migadu.com [91.218.175.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DA83C11
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 23:04:30 -0700 (PDT)
Message-ID: <bfa3317b-656f-9a3f-9564-4dbb1bbef3e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681452268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kocyopIXHz/RLhDpJOjQGhmjeoA3fjlMdvqOQnqiGAs=;
        b=Kg5uz4JKjOw3pNJcjFCQLgrTEndI9Txx0/8gtSZ6J8Wfxpyh52eo8h0AlMWm2VRmKtTKQs
        oOfi5OinOUKH4R2cOf6puhrGBdcMGKOPv16pYkLLJ+16NLBfBZu5NYQPeGZt4eEAAL/o7m
        /ckCt3qw7oACh4mA/267scQhMbHuWn0=
Date:   Fri, 14 Apr 2023 14:04:23 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Content-Language: en-US
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
 <1681108984-2-3-git-send-email-lizhijian@fujitsu.com>
 <20230410120809.GN182481@unreal>
 <0d9c57db-bca3-adb4-71fd-7362e4842917@linux.dev>
 <85323eb2-cfc7-d1b8-3a75-3fa63dde29db@fujitsu.com>
 <20230411122651.GV182481@unreal>
 <aa43746f-77f9-8592-5370-2a5042506ee5@fujitsu.com>
 <8fe62e38-e43d-3d6c-624f-1c8ce5859788@linux.dev>
 <f85cdaaa-b1d6-bc89-e963-8b611ae3667d@fujitsu.com>
 <230b310a-26ef-34f1-4c3b-c2360088ce04@linux.dev>
 <f71e67d8-119c-7ec5-fbc0-d37799ed82b6@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <f71e67d8-119c-7ec5-fbc0-d37799ed82b6@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/14/23 13:37, Zhijian Li (Fujitsu) wrote:
>
> On 14/04/2023 11:40, Guoqing Jiang wrote:
>>
>> On 4/13/23 16:12, Zhijian Li (Fujitsu) wrote:
>>> On 13/04/2023 15:35, Guoqing Jiang wrote:
>>>> Hi,
>>>>
>>>> I take a closer look today.
>>>>
>>>> On 4/12/23 09:15, Zhijian Li (Fujitsu) wrote:
>>>>> On 11/04/2023 20:26, Leon Romanovsky wrote:
>>>>>> On Tue, Apr 11, 2023 at 02:43:46AM +0000, Zhijian Li (Fujitsu) wrote:
>>>>>>> On 10/04/2023 21:10, Guoqing Jiang wrote:
>>>>>>>> On 4/10/23 20:08, Leon Romanovsky wrote:
>>>>>>>>> On Mon, Apr 10, 2023 at 06:43:03AM +0000, Li Zhijian wrote:
>>>>>>>>>> The warning occurs when destroying PD whose reference count is not zero.
>>>>>>>>>>
>>>>>>>>>> Precodition: clt_path->s.con_num is 2.
>>>>>>>>>> So 2 cm connection will be created as below:
>>>>>>>>>> CPU0                                              CPU1
>>>>>>>>>> init_conns {                              |
>>>>>>>>>>        create_cm() // a. con[0] created        |
>>>>>>>>>>                                                |  a'. rtrs_clt_rdma_cm_handler() {
>>>>>>>>>>                                                |    rtrs_rdma_addr_resolved()
>>>>>>>>>>                                                |      create_con_cq_qp(con); << con[0]
>>>>>>>>>>                                                |  }
>>>>>>>>>>                                                | in this moment, refcnt of PD was increased to 2+
>>>> What do you mean "refcnt of PD"? usecnt in struct ib_pd or dev_ref.
>>> I mean usecnt in struct ib_pd
>>>
>>>
>>>
>>>>>>>>>>                                                |
>>>>>>>>>>        create_cm() // b. cid = 1, failed       |
>>>>>>>>>>          destroy_con_cq_qp()                   |
>>>>>>>>>>            rtrs_ib_dev_put()                   |
>>>>>>>>>>              dev_free()                        |
>>>>>>>>>>                ib_dealloc_pd(dev->ib_pd) << PD |
>>>>>>>>>>                 is destroyed, but refcnt is    |
>>>>>>>>>>                 still greater than 0           |
>>>> Assuming you mean "pd->usecnt". We only allocate pd in con[0] by rtrs_ib_dev_find_or_add,
>>>> if con[1] failed to create cm, then alloc_path_reqs -> ib_alloc_mr -> atomic_inc(&pd->usecnt)
>> The above can't be invoked, right?
>>
>>>> can't be triggered. Is there other places could increase the refcnt?
>>> Yes, when create a qp, it will also associate to this PD, that also mean refcnt of PD will be increased.
>>>
>>> When con[0](create_con_cq_qp) succeeded, refcnt of PD will be 2. and then when con[1] failed, since
>>> QP didn't create, refcnt of PD is still 2. con[1]'s cleanup will destroy the PD(ib_dealloc_pd) since dev_ref = 1, after that its
>>> refcnt is still 1.
>> I can see the path increase usecnt to 1.
>>
>> rtrs_cq_qp_create -> create_qp
>>                       -> rdma_create_qp
>>                           -> ib_create_qp
>>                               -> create_qp
>>                               -> ib_qp_usecnt_inc which increases pd->usecnt
>>
>> Where is another place to increase usecnt to 2?
> It should be
> ib_create_qp　...
>     -> rxe_create_qp
>       -> rxe_qp_from_init
>          -> rxe_get(pd) <<< pd's refcnt will be increased.

Isn't rxe_get just increase elem->ref_cnt?

https://elixir.bootlin.com/linux/v6.3-rc6/source/drivers/infiniband/sw/rxe/rxe_pool.c#L240

>>>> Then what is the appropriate time to call destroy_con_cq_qp for this scenario?
>>>> Otherwise there could be memory leak.
>>> we must ensure QP in con[0] is closed before destroying the PD.
>>> Currently destroy_con_cq_qp() subroutine will close the opened QP first.
>> Let me try another way, with below change, rtrs_ib_dev_put can't be called
>> from destroy_con_cq_qp, right?
> Not really, con[0]->has_dev is true, so con[0]'s cleanup will call rtrs_ib_dev_put()
>
> Without this patch, when con[1] failed, con[1]'s cleanup will be called first. then call con[0]'s cleanup.
> After this change, con[1]'s cleanup will not call rtrs_ib_dev_put, but it will be called the later con[0]'s cleanup.

But rtrs_ib_dev_put relies on dev_ref, if con[1] returns earlier without 
decrease dev_ref
(it is shared among connections), how rtrs_ib_dev_put can be called?

Thanks,
Guoqing
