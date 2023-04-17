Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E446E3DE3
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Apr 2023 05:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjDQDKS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Apr 2023 23:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjDQDJn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Apr 2023 23:09:43 -0400
Received: from out-52.mta1.migadu.com (out-52.mta1.migadu.com [95.215.58.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1971C44B7
        for <linux-rdma@vger.kernel.org>; Sun, 16 Apr 2023 20:09:08 -0700 (PDT)
Message-ID: <90bcf57d-3e2f-5fd5-a901-6a640d2b523c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681700892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/5MImZBx71ArdVTD8JIk3uIrjgFKB62VcP4IolAfhg=;
        b=tNx2slIOxnlY6tArRUlKKGAGc3DcI6ueTMOywqot4Icxtxm6c3iKDi/TJVUgsB/KktrZux
        aEGe7miRueNqkMQmDgXAm7iV8zSxW+QPotvQ0yvsDXLGk6sdATTyFlEaFLJpXrhBwaODSm
        6zeAndOGbQgVMzKRv+F87+YFjA20JHU=
Date:   Mon, 17 Apr 2023 11:08:09 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
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
 <bfa3317b-656f-9a3f-9564-4dbb1bbef3e3@linux.dev>
 <71935de6-e3c1-c719-4e66-19242af51ab7@fujitsu.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <71935de6-e3c1-c719-4e66-19242af51ab7@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/14/23 18:09, Zhijian Li (Fujitsu) wrote:
>
> On 14/04/2023 14:04, Guoqing Jiang wrote:
>>
>> On 4/14/23 13:37, Zhijian Li (Fujitsu) wrote:
>>> On 14/04/2023 11:40, Guoqing Jiang wrote:
>>>> On 4/13/23 16:12, Zhijian Li (Fujitsu) wrote:
>>>>> On 13/04/2023 15:35, Guoqing Jiang wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I take a closer look today.
>>>>>>
>>>>>> On 4/12/23 09:15, Zhijian Li (Fujitsu) wrote:
>>>>>>> On 11/04/2023 20:26, Leon Romanovsky wrote:
>>>>>>>> On Tue, Apr 11, 2023 at 02:43:46AM +0000, Zhijian Li (Fujitsu) wrote:
>>>>>>>>> On 10/04/2023 21:10, Guoqing Jiang wrote:
>>>>>>>>>> On 4/10/23 20:08, Leon Romanovsky wrote:
>>>>>>>>>>> On Mon, Apr 10, 2023 at 06:43:03AM +0000, Li Zhijian wrote:
>>>>>>>>>>>> The warning occurs when destroying PD whose reference count is not zero.
>>>>>>>>>>>>
>>>>>>>>>>>> Precodition: clt_path->s.con_num is 2.
>>>>>>>>>>>> So 2 cm connection will be created as below:
>>>>>>>>>>>> CPU0                                              CPU1
>>>>>>>>>>>> init_conns {                              |
>>>>>>>>>>>>         create_cm() // a. con[0] created        |
>>>>>>>>>>>>                                                 |  a'. rtrs_clt_rdma_cm_handler() {
>>>>>>>>>>>>                                                 |    rtrs_rdma_addr_resolved()
>>>>>>>>>>>>                                                 |      create_con_cq_qp(con); << con[0]
>>>>>>>>>>>>                                                 |  }
>>>>>>>>>>>>                                                 | in this moment, refcnt of PD was increased to 2+
>>>>>> What do you mean "refcnt of PD"? usecnt in struct ib_pd or dev_ref.
>>>>> I mean usecnt in struct ib_pd
>>>>>
>>>>>>>>>>>>                                                 |
>>>>>>>>>>>>         create_cm() // b. cid = 1, failed       |
>>>>>>>>>>>>           destroy_con_cq_qp()                   |
>>>>>>>>>>>>             rtrs_ib_dev_put()                   |
>>>>>>>>>>>>               dev_free()                        |
>>>>>>>>>>>>                 ib_dealloc_pd(dev->ib_pd) << PD |
>>>>>>>>>>>>                  is destroyed, but refcnt is    |
>>>>>>>>>>>>                  still greater than 0           |
>>>>>> Assuming you mean "pd->usecnt". We only allocate pd in con[0] by rtrs_ib_dev_find_or_add,
>>>>>> if con[1] failed to create cm, then alloc_path_reqs -> ib_alloc_mr -> atomic_inc(&pd->usecnt)
>>>> The above can't be invoked, right?
>>>>
>>>>>> can't be triggered. Is there other places could increase the refcnt?
>>>>> Yes, when create a qp, it will also associate to this PD, that also mean refcnt of PD will be increased.
>>>>>
>>>>> When con[0](create_con_cq_qp) succeeded, refcnt of PD will be 2. and then when con[1] failed, since
>>>>> QP didn't create, refcnt of PD is still 2. con[1]'s cleanup will destroy the PD(ib_dealloc_pd) since dev_ref = 1, after that its
>>>>> refcnt is still 1.
>>>> I can see the path increase usecnt to 1.
>>>>
>>>> rtrs_cq_qp_create -> create_qp
>>>>                        -> rdma_create_qp
>>>>                            -> ib_create_qp
>>>>                                -> create_qp
>>>>                                -> ib_qp_usecnt_inc which increases pd->usecnt
>>>>
>>>> Where is another place to increase usecnt to 2?
>>> It should be
>>> ib_create_qp　...
>>>      -> rxe_create_qp
>>>        -> rxe_qp_from_init
>>>           -> rxe_get(pd) <<< pd's refcnt will be increased.
>> Isn't rxe_get just increase elem->ref_cnt?
> Yes, that's true.

I am confused, does increase ref_cnt equal to increase usecnt?
If not, then where is another place to increase usecnt to 2?

BTW, I traced with 6.3-rc5, seems pd's usecnt is only increase once
after create one connection.

[ 6941.525088] in init_conns 2353 con_num=3
[ 6941.525732] in create_con_cq_qp 1648
[ 6941.525944] in rtrs_cq_qp_create 311 con->cid=0 
path->dev->ib_pd->usecnt=1
[ 6941.532460] in create_con_cq_qp 1648
[ 6941.532746] in rtrs_cq_qp_create 311 con->cid=1 
path->dev->ib_pd->usecnt=2
[ 6941.533183] in create_con_cq_qp 1648
[ 6941.533464] in rtrs_cq_qp_create 311 con->cid=2 
path->dev->ib_pd->usecnt=3
[ 6941.533685] in init_conns 2365, clt_path->s.dev->ib_pd->usecnt=3
[ 6941.535680] in init_conns 2371, clt_path->s.dev->ib_pd->usecnt=515

Thanks,
Guoqing
