Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B277DB64A
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Oct 2023 10:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjJ3Jnz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Oct 2023 05:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJ3Jnz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Oct 2023 05:43:55 -0400
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8346BB3
        for <linux-rdma@vger.kernel.org>; Mon, 30 Oct 2023 02:43:52 -0700 (PDT)
Message-ID: <6e7df8dc-e31b-472c-86fb-0aef8f6e712b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698659030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6cn7H6WirnCJsuxRJBZuoEdbpY+E2+h4X2v+GizpQXU=;
        b=A5Hy9oUeINP2HvIVJdk5n3qRXZjQCpLhKAAXFKWEJO9K7P+BbxhVCEPJUdRvUc/S3vQ4eb
        MrWC/0Slhv5cifz+YZsoQrZ9GBDY/CPrw5CaDFE+lJca0D+TBSAumAmvGUy5PmRR1vj59g
        gGmUiKnVfs/O+Rehr+c5YY3g0rrn100=
Date:   Mon, 30 Oct 2023 17:43:42 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RFC 1/2] RDMA/rxe: don't allow registering !PAGE_SIZE mr
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
References: <20231027054154.2935054-1-lizhijian@fujitsu.com>
 <53c18b2a-c3b2-4936-b654-12cb5f914622@linux.dev>
 <784a65e3-5438-4700-b3e4-1d72d144ec2a@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <784a65e3-5438-4700-b3e4-1d72d144ec2a@fujitsu.com>
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

在 2023/10/30 16:13, Zhijian Li (Fujitsu) 写道:
> 
> 
> On 27/10/2023 16:17, Zhu Yanjun wrote:
>> 在 2023/10/27 13:41, Li Zhijian 写道:
>>> mr->page_list only encodes *page without page offset, when
>>> page_size != PAGE_SIZE, we cannot restore the address with a wrong
>>> page_offset.
>>>
>>> Note that this patch will break some ULPs that try to register 4K
>>> MR when PAGE_SIZE is not 4K.
>>> SRP and nvme over RXE is known to be impacted.
>>
>> When ULP uses folio or compound page, ULP can not work well with RXE after this commit is applied.
>>
>> Perhaps removing page_size set in RXE is a good solution because page_size is set twice, firstly page_size is set in infiniband/core, secondly it is set in RXE.
> 
> Does The RXE one mean rxe_mr_init(), I think rxe_reg_user_mr() requires this.

Please read the discussions carefully. This problem has been discussed.

Best Regards,
Zhu Yanjun

> 
>    48 static void rxe_mr_init(int access, struct rxe_mr *mr)
>    49 {
>    50         u32 key = mr->elem.index << 8 | rxe_get_next_key(-1);
>    51
>    52         /* set ibmr->l/rkey and also copy into private l/rkey
>    53          * for user MRs these will always be the same
>    54          * for cases where caller 'owns' the key portion
>    55          * they may be different until REG_MR WQE is executed.
>    56          */
>    57         mr->lkey = mr->ibmr.lkey = key;
>    58         mr->rkey = mr->ibmr.rkey = key;
>    59
>    60         mr->access = access;
>    61         mr->ibmr.page_size = PAGE_SIZE;
>    62         mr->page_mask = PAGE_MASK;
>    63         mr->page_shift = PAGE_SHIFT;
>    64         mr->state = RXE_MR_STATE_INVALID;
>    65 }
> 
> 
> Thanks
> Zhijian
> 
>>
>> When folio or compound page is used in ULP, it is very possible that page_size in infiniband/core is different from the page_size in RXE
>>
>> Not sure what problem this difference will cause.
>>
>> Zhu Yanjun
>>
>>>
>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>>> ---
>>>    drivers/infiniband/sw/rxe/rxe_mr.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>>> index f54042e9aeb2..61a136ea1d91 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>>> @@ -234,6 +234,12 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
>>>        struct rxe_mr *mr = to_rmr(ibmr);
>>>        unsigned int page_size = mr_page_size(mr);
>>> +    if (page_size != PAGE_SIZE) {
>>> +        rxe_info_mr(mr, "Unsupported MR with page_size %u, expect %lu\n",
>>> +               page_size, PAGE_SIZE);
>>> +        return -EOPNOTSUPP;
>>> +    }
>>> +
>>>        mr->nbuf = 0;
>>>        mr->page_shift = ilog2(page_size);
>>>        mr->page_mask = ~((u64)page_size - 1);

