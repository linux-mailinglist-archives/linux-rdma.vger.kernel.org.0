Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D604D6E27C7
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Apr 2023 17:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDNP6h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Apr 2023 11:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjDNP6h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Apr 2023 11:58:37 -0400
Received: from out-54.mta1.migadu.com (out-54.mta1.migadu.com [95.215.58.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76F119A3
        for <linux-rdma@vger.kernel.org>; Fri, 14 Apr 2023 08:58:35 -0700 (PDT)
Message-ID: <4d1cacbf-f9b2-07c7-75bf-61f34abc1841@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681487913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DpTXmit1ejSE9AiqoGnb66tLFIsHtNr5bViuZsAYkAc=;
        b=nDszz0ZEH77cLMMPj6z6O2CrJFYAzr1sK7tHNTQ/oyEPIooAnIuuYUbuiZs1iCd53D/1xM
        KXLWDMIwdnU7VbpmRlufelV+DTsO98xWmiyghnL+pUZwV8jnaaKHfkiwkQ9hbwj1Cyx8X2
        1FGfqpjvZ9MB0FC0CO+LyypDjwih71M=
Date:   Fri, 14 Apr 2023 23:58:26 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
To:     Leon Romanovsky <leon@kernel.org>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
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
 <20230413132418.GR17993@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230413132418.GR17993@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/4/13 21:24, Leon Romanovsky 写道:
> On Thu, Apr 13, 2023 at 08:12:15AM +0000, Zhijian Li (Fujitsu) wrote:
>>
>>
>> On 13/04/2023 15:35, Guoqing Jiang wrote:
>>> Hi,
>>>
>>> I take a closer look today.
>>>
>>> On 4/12/23 09:15, Zhijian Li (Fujitsu) wrote:
>>>>
>>>> On 11/04/2023 20:26, Leon Romanovsky wrote:
>>>>> On Tue, Apr 11, 2023 at 02:43:46AM +0000, Zhijian Li (Fujitsu) wrote:
>>>>>>
>>>>>> On 10/04/2023 21:10, Guoqing Jiang wrote:
>>>>>>>
>>>>>>> On 4/10/23 20:08, Leon Romanovsky wrote:
>>>>>>>> On Mon, Apr 10, 2023 at 06:43:03AM +0000, Li Zhijian wrote:
>>>>>>>>> The warning occurs when destroying PD whose reference count is not zero.
>>>>>>>>>
>>>>>>>>> Precodition: clt_path->s.con_num is 2.
>>>>>>>>> So 2 cm connection will be created as below:
>>>>>>>>> CPU0                                              CPU1
>>>>>>>>> init_conns {                              |
>>>>>>>>>       create_cm() // a. con[0] created        |
>>>>>>>>>                                               |  a'. rtrs_clt_rdma_cm_handler() {
>>>>>>>>>                                               |    rtrs_rdma_addr_resolved()
>>>>>>>>>                                               |      create_con_cq_qp(con); << con[0]
>>>>>>>>>                                               |  }
>>>>>>>>>                                               | in this moment, refcnt of PD was increased to 2+
>>>
>>> What do you mean "refcnt of PD"? usecnt in struct ib_pd or dev_ref.
>>
>> I mean usecnt in struct ib_pd
>>
>>
>>
>>>
>>>>>>>>>                                               |
>>>>>>>>>       create_cm() // b. cid = 1, failed       |
>>>>>>>>>         destroy_con_cq_qp()                   |
>>>>>>>>>           rtrs_ib_dev_put()                   |
>>>>>>>>>             dev_free()                        |
>>>>>>>>>               ib_dealloc_pd(dev->ib_pd) << PD |
>>>>>>>>>                is destroyed, but refcnt is    |
>>>>>>>>>                still greater than 0           |
>>>
>>> Assuming you mean "pd->usecnt". We only allocate pd in con[0] by rtrs_ib_dev_find_or_add,
>>> if con[1] failed to create cm, then alloc_path_reqs -> ib_alloc_mr -> atomic_inc(&pd->usecnt)
>>> can't be triggered. Is there other places could increase the refcnt?
>>
>>
>> Yes, when create a qp, it will also associate to this PD, that also mean refcnt of PD will be increased.
>>
>> When con[0](create_con_cq_qp) succeeded, refcnt of PD will be 2. and then when con[1] failed, since
>> QP didn't create, refcnt of PD is still 2. con[1]'s cleanup will destroy the PD(ib_dealloc_pd) since dev_ref = 1, after that its
>> refcnt is still 1.
> 
> Why is refcnt 1 in con[1] destruction phase? It seems to me like a bug.
Agree. We should find out why refcnt 1 and fix this problem.

Zhu Yanjun
> 
> Thanks

