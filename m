Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7DC7D2816
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 03:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjJWBkm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Oct 2023 21:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjJWBkl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Oct 2023 21:40:41 -0400
Received: from out-200.mta0.migadu.com (out-200.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AB2FB
        for <linux-rdma@vger.kernel.org>; Sun, 22 Oct 2023 18:40:38 -0700 (PDT)
Message-ID: <5fcf502d-71fb-123d-f6ff-f3ffb7c3ba1a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698025235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P0JkTNe9CXVD2FmgNnnMsVzDpQIjdjKewnuWq5qf7FM=;
        b=JDPYtHJg+xyVBrZoS0s2R7WzRdHl+wuKDt/kCp0VKM32kykdDmzcDg8lSIwsI+b1S1odq2
        UrUx70APnTHhDyc2wI3fk7B0TC+UwH5F46iafDsImlBgBWTFDy240o2S5t50Nq342xOrWj
        lIVZfO+3riYrj25Q4UB5drehrclOXfY=
Date:   Mon, 23 Oct 2023 09:40:16 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH v2] IB: rework memlock limit handling code
To:     Leon Romanovsky <leon@kernel.org>,
        Maxim Samoylov <max7255@meta.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Christian Benvenuti <benve@cisco.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
References: <20231012082921.546114-1-max7255@meta.com>
 <20231015091959.GC25776@unreal>
Content-Language: en-US
In-Reply-To: <20231015091959.GC25776@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/15/23 17:19, Leon Romanovsky wrote:
> On Thu, Oct 12, 2023 at 01:29:21AM -0700, Maxim Samoylov wrote:
>> This patch provides the uniform handling for RLIM_INFINITY value
>> across the infiniband/rdma subsystem.
>>
>> Currently in some cases the infinity constant is treated
>> as an actual limit value, which could be misleading.
>>
>> Let's also provide the single helper to check against process
>> MEMLOCK limit while registering user memory region mappings.
>>
>> Signed-off-by: Maxim Samoylov<max7255@meta.com>
>> ---
>>
>> v1 -> v2: rewritten commit message, rebased on recent upstream
>>
>>   drivers/infiniband/core/umem.c             |  7 ++-----
>>   drivers/infiniband/hw/qib/qib_user_pages.c |  7 +++----
>>   drivers/infiniband/hw/usnic/usnic_uiom.c   |  6 ++----
>>   drivers/infiniband/sw/siw/siw_mem.c        |  6 +++---
>>   drivers/infiniband/sw/siw/siw_verbs.c      | 23 ++++++++++------------
>>   include/rdma/ib_umem.h                     | 11 +++++++++++
>>   6 files changed, 31 insertions(+), 29 deletions(-)
> <...>
>
>> @@ -1321,8 +1322,8 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>>   	struct siw_umem *umem = NULL;
>>   	struct siw_ureq_reg_mr ureq;
>>   	struct siw_device *sdev = to_siw_dev(pd->device);
>> -
>> -	unsigned long mem_limit = rlimit(RLIMIT_MEMLOCK);
>> +	unsigned long num_pages =
>> +		(PAGE_ALIGN(len + (start & ~PAGE_MASK))) >> PAGE_SHIFT;
>>   	int rv;
>>   
>>   	siw_dbg_pd(pd, "start: 0x%pK, va: 0x%pK, len: %llu\n",
>> @@ -1338,19 +1339,15 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>>   		rv = -EINVAL;
>>   		goto err_out;
>>   	}
>> -	if (mem_limit != RLIM_INFINITY) {
>> -		unsigned long num_pages =
>> -			(PAGE_ALIGN(len + (start & ~PAGE_MASK))) >> PAGE_SHIFT;
>> -		mem_limit >>= PAGE_SHIFT;
>>   
>> -		if (num_pages > mem_limit - current->mm->locked_vm) {
>> -			siw_dbg_pd(pd, "pages req %lu, max %lu, lock %lu\n",
>> -				   num_pages, mem_limit,
>> -				   current->mm->locked_vm);
>> -			rv = -ENOMEM;
>> -			goto err_out;
>> -		}
>> +	if (!ib_umem_check_rlimit_memlock(num_pages + current->mm->locked_vm)) {
>> +		siw_dbg_pd(pd, "pages req %lu, max %lu, lock %lu\n",
>> +				num_pages, rlimit(RLIMIT_MEMLOCK),
>> +				current->mm->locked_vm);
>> +		rv = -ENOMEM;
>> +		goto err_out;
>>   	}
> Sorry for late response, but why does this hunk exist in first place?
>
>> +
>>   	umem = siw_umem_get(start, len, ib_access_writable(rights));
> This should be ib_umem_get().

IMO, it deserves a separate patch, and replace siw_umem_get with ib_umem_get
is not straightforward given siw_mem has two types of memory (pbl and umem).

Thanks,
Guoqing
