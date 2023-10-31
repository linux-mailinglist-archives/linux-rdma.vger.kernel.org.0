Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00787DC8AE
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Oct 2023 09:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbjJaIwo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Oct 2023 04:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjJaIwm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Oct 2023 04:52:42 -0400
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [IPv6:2001:41d0:203:375::b7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708A191
        for <linux-rdma@vger.kernel.org>; Tue, 31 Oct 2023 01:52:35 -0700 (PDT)
Message-ID: <7c5dd149-395a-46a2-96a0-89c182105eaf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698742353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TbP5NFFyhT6vLl14jHCWwTkfzMvj2xRM7HIW/xU+hNw=;
        b=pSH6i7E2mRE2zvkxDFKQH/zHDc4X59ST0cFgzStevXPF5Bh3mnfeSuwzJFlRw8ClOf1ivY
        KeS8bFOw/e5SePv+FEMXUaFZ3SyhT8lhi1WF6KmF6U5j3Qxu2fgbrhvQ23/3FbhHvxo2I4
        SigF/tPYHJU6K0SnfIoNg8FgI7QW5r0=
Date:   Tue, 31 Oct 2023 16:52:23 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RFC 1/2] RDMA/rxe: don't allow registering !PAGE_SIZE mr
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
References: <20231027054154.2935054-1-lizhijian@fujitsu.com>
 <4da48f85-a72f-4f6b-900f-fc293d63b5ae@fujitsu.com>
 <20231030124041.GE691768@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231030124041.GE691768@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/10/30 20:40, Jason Gunthorpe 写道:
> On Mon, Oct 30, 2023 at 07:51:41AM +0000, Zhijian Li (Fujitsu) wrote:
>>
>>
>> On 27/10/2023 13:41, Li Zhijian wrote:
>>> mr->page_list only encodes *page without page offset, when
>>> page_size != PAGE_SIZE, we cannot restore the address with a wrong
>>> page_offset.
>>>
>>> Note that this patch will break some ULPs that try to register 4K
>>> MR when PAGE_SIZE is not 4K.
>>> SRP and nvme over RXE is known to be impacted.
>>>
>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>>> ---
>>>    drivers/infiniband/sw/rxe/rxe_mr.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>>> index f54042e9aeb2..61a136ea1d91 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>>> @@ -234,6 +234,12 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
>>>    	struct rxe_mr *mr = to_rmr(ibmr);
>>>    	unsigned int page_size = mr_page_size(mr);
>>>    
>>> +	if (page_size != PAGE_SIZE) {
>>
>> It seems this condition is too strict, it should be:
>> 	if (!IS_ALIGNED(page_size, PAGE_SIZE))
>>
>> So that, page_size with (N * PAGE_SIZE) can work as previously.
>> Because the offset(mr.iova & page_mask) will get lost only when !IS_ALIGNED(page_size, PAGE_SIZE)
> 
> That makes sense

I read all the discussions very carefully.

Thanks, Greg.

Because RXE only supports PAGE_SIZE, when CONFIG_ARM64_64K_PAGES is 
enabled, the PAGE_SIZE is 64K, when CONFIG_ARM64_64K_PAGES is disabled, 
PAGE_SIZE is 4K.

But NVMe calls ib_map_mr_sg with a fixed size SZ_4K. When 
CONFIG_ARM64_64K_PAGES is enabled, it is still 4K. This is not a problem 
in RXE. This problem is in NVMe.

If this problem in NVMe is not fixed, NVMe still can not use RXE to make 
tests with blktests when CONFIG_ARM64_64K_PAGES is enabled.

This is not a problem in RXE, it should not be fixed in RXE.

Zhu Yanjun

> 
> Jason

