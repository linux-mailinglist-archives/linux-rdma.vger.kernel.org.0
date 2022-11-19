Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E97630EF6
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Nov 2022 14:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKSNUr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Nov 2022 08:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiKSNUq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Nov 2022 08:20:46 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304F675D83
        for <linux-rdma@vger.kernel.org>; Sat, 19 Nov 2022 05:20:45 -0800 (PST)
Message-ID: <2a521299-98c9-885e-c54b-5549f84eaa8f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668864043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2T9/s43nP03QLALIMIe8ShN4wlPzQT+6+k1fJy8eRsI=;
        b=jSqjGsQG5bi7sy4Ae8UW2JdHYZLMSesB5XuLwIq4fDcLcu2ZDBc940IqdOpVZNwORotJWC
        W/q4Qjlz8Y0uZUYs4p60gOAHEo18FB2q5jo4gUx/GSpuamvXvWd3/aJUzugiYvXBBHfn3o
        D30T28peDerw4k64IFW8mNKs/3aO7fI=
Date:   Sat, 19 Nov 2022 21:20:36 +0800
MIME-Version: 1.0
Subject: Re: [for-next PATCH 1/1] RDMA/rxe: sgt_append from ib_umem_get is not
 highmem
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <c806a812-4ecd-226f-109e-84642357fbcb@linux.dev>
 <20221120012939.539953-1-yanjun.zhu@intel.com>
 <4a9748a0-59d9-4094-8895-6f2194eeb521@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <4a9748a0-59d9-4094-8895-6f2194eeb521@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/11/19 18:30, lizhijian@fujitsu.com 写道:
>
> There was a thread that tries to refactor iova_to_vaddr[1][2], where
> page_address will be drop. if so, your changes will be no longer needed.

My commit is to indicate that your commit is not good enough.

And you should make all the related commits in a patch series.

Zhu Yanjun

>
> [1]https://lore.kernel.org/lkml/a7decec2-77d9-db4c-ff66-ff597da8bc71@fujitsu.com/T/
> [2]https://www.spinics.net/lists/linux-rdma/msg114053.html
>
> Thanks
> Zhijian
>
>
> On 20/11/2022 09:29, Zhu Yanjun wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> In ib_umem_get, sgt_append is allocated from the function
>> sg_alloc_append_table_from_pages. And it is not from highmem.
>>
>> As such, the return value of page_address will not be NULL.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>    drivers/infiniband/sw/rxe/rxe_mr.c | 9 ++-------
>>    1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>> index b1423000e4bc..3f33a4cdef24 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>> @@ -119,7 +119,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>>    	struct ib_umem		*umem;
>>    	struct sg_page_iter	sg_iter;
>>    	int			num_buf;
>> -	void			*vaddr;
>>    	int err;
>>    
>>    	umem = ib_umem_get(&rxe->ib_dev, start, length, access);
>> @@ -149,6 +148,8 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>>    		buf = map[0]->buf;
>>    
>>    		for_each_sgtable_page (&umem->sgt_append.sgt, &sg_iter, 0) {
>> +			void *vaddr;
>> +
>>    			if (num_buf >= RXE_BUF_PER_MAP) {
>>    				map++;
>>    				buf = map[0]->buf;
>> @@ -156,16 +157,10 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
>>    			}
>>    
>>    			vaddr = page_address(sg_page_iter_page(&sg_iter));
>> -			if (!vaddr) {
>> -				rxe_dbg_mr(mr, "Unable to get virtual address\n");
>> -				err = -ENOMEM;
>> -				goto err_release_umem;
>> -			}
>>    			buf->addr = (uintptr_t)vaddr;
>>    			buf->size = PAGE_SIZE;
>>    			num_buf++;
>>    			buf++;
>> -
>>    		}
>>    	}
>>    
