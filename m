Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D9166D38E
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 01:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjAQAFy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 19:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjAQAFw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 19:05:52 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA613233D9
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 16:05:50 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id j130so24670730oif.4
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 16:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=li27uw3Tse9FuArrZ4M0nrssiCHPtwnAyeoVw9EWPZE=;
        b=qIZ6REST3mUDksLo4f6Fgawm30gDcJ7UR0pEeIee2z6FAJHt+aW8X7PbZLjZaHSKyR
         PTaNWBxvOGx688I5PYqSl/KBPxryxFjsOIiAXTWddWyOPqVx7vcUmaHEVvOAdv3jJNpv
         VTA+qrIgDlwVThKpaIfyGADDa17WJ1CJFcTIqtyDQeSDwLhnnwnZya5Secem/dOQ7/KB
         qNCBlQ5Ev/45VQNx1sROTN9f6dpV2MUaAlJUCjsMOE9FhKzL3wkQ94qOi/MtwS/48iwN
         CafSr/+8+b05zW0P7mn7E1yKP6lltMtknYpHkdPIai7+hGw7lZNtPoXRurLnRwNaiZZw
         y11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=li27uw3Tse9FuArrZ4M0nrssiCHPtwnAyeoVw9EWPZE=;
        b=0Uv6sAHRTL4nkZT88VCvjsSYLoyAqdl/RhFVNtUReY+t5To7qfvxsKcczVzZuOwPZA
         n7BpRHppRRBz0DwhXFJ3fi+o44GYDI53fbQLH3IqK0L2qhrxQdiSea38RQ820iHC8GJp
         igE00wwmIsHXJu64NoyDrKQQLKDofI9wthzJzKfN7q5RMoK3nbSug3JAcloYplQ7Za+A
         RN/CiiuBSABG4Pbau/7/s1gAxrY3CgfMwKwIZi7LD7svNxIH0ZVfmGMZsoc2x30VGq3g
         Taptpv2lySkpFDzaFvqbe+XNM/TO99psQQ+36CG4wBfqLdB6tWXe19dteQ61yizFoKKM
         bzSw==
X-Gm-Message-State: AFqh2kporRpAPeWy95KAuCll4xzSaOaaZWA79GvOl9Sbtex27g8rVVoX
        vKJerEbseqZ+7n49OEyMf53aHfesfTqeDg==
X-Google-Smtp-Source: AMrXdXu3/vCx7Exgt7bDMi8S8LkjCb3BxigvifqzFy5JmBG7lPqg4e9llNLy0plZ0f6zEqFrIRboZg==
X-Received: by 2002:aca:a8c1:0:b0:35b:ae91:db53 with SMTP id r184-20020acaa8c1000000b0035bae91db53mr241797oie.42.1673913950156;
        Mon, 16 Jan 2023 16:05:50 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:ea18:3ee9:26d1:7526? (2603-8081-140c-1a00-ea18-3ee9-26d1-7526.res6.spectrum.com. [2603:8081:140c:1a00:ea18:3ee9:26d1:7526])
        by smtp.gmail.com with ESMTPSA id a20-20020a9d6e94000000b006718a823321sm884630otr.41.2023.01.16.16.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 16:05:49 -0800 (PST)
Message-ID: <1900866b-6cd7-3dc6-7e47-77e1c680a016@gmail.com>
Date:   Mon, 16 Jan 2023 18:05:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-next v3 6/6] RDMA/rxe: Replace rxe_map and
 rxe_phys_buf by xarray
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230113232704.20072-1-rpearsonhpe@gmail.com>
 <20230113232704.20072-7-rpearsonhpe@gmail.com>
 <c03afa55-c2f2-5949-289a-4411bdba87f9@fujitsu.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <c03afa55-c2f2-5949-289a-4411bdba87f9@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/15/23 20:21, lizhijian@fujitsu.com wrote:
> 
> 
> On 14/01/2023 07:27, Bob Pearson wrote:
>> Replace struct rxe-phys_buf and struct rxe_map by struct xarray
>> in rxe_verbs.h. This allows using rcu locking on reads for
>> the memory maps stored in each mr.
>>
>> This is based off of a sketch of a patch from Jason Gunthorpe in the
>> link below. Some changes were needed to make this work. It applies
>> cleanly to the current for-next and passes the pyverbs, perftest
>> and the same blktests test cases which run today.
>>
>> Link:https://lore.kernel.org/linux-rdma/Y3gvZr6%2FNCii9Avy@nvidia.com/
>> Co-developed-by: Jason Gunthorpe<jgg@nvidia.com>
>> Signed-off-by: Bob Pearson<rpearsonhpe@gmail.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_loc.h   |   1 -
>>   drivers/infiniband/sw/rxe/rxe_mr.c    | 533 ++++++++++++--------------
>>   drivers/infiniband/sw/rxe/rxe_resp.c  |   2 +-
>>   drivers/infiniband/sw/rxe/rxe_verbs.h |  21 +-
>>   4 files changed, 251 insertions(+), 306 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>> index fd70c71a9e4e..0cf78f9bb27c 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>> @@ -71,7 +71,6 @@ int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
>>   	      void *addr, int length, enum rxe_mr_copy_dir dir);
>>   int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
>>   		  int sg_nents, unsigned int *sg_offset);
>> -void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
>>   int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>>   			u64 compare, u64 swap_add, u64 *orig_val);
>>   int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr);
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>> index fd5537ee7f04..e4634279080a 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> [snip...]
> 
>> -static bool is_pmem_page(struct page *pg)
>> +static unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
>>   {
>> -	unsigned long paddr = page_to_phys(pg);
>> +	return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
>> +}
>>   
>> -	return REGION_INTERSECTS ==
>> -	       region_intersects(paddr, PAGE_SIZE, IORESOURCE_MEM,
>> -				 IORES_DESC_PERSISTENT_MEMORY);
> 
> [snip...]
> 
>> +	rxe_mr_init(access, mr);
>> +
>>   	umem = ib_umem_get(&rxe->ib_dev, start, length, access);
>>   	if (IS_ERR(umem)) {
>>   		rxe_dbg_mr(mr, "Unable to pin memory region err = %d\n",
>>   			(int)PTR_ERR(umem));
>> -		err = PTR_ERR(umem);
>> -		goto err_out;
>> +		return PTR_ERR(umem);
>>   	}
>>   
>> -	num_buf = ib_umem_num_pages(umem);
>> -
>> -	rxe_mr_init(access, mr);
>> -
>> -	err = rxe_mr_alloc(mr, num_buf);
>> +	err = rxe_mr_fill_pages_from_sgt(mr, &umem->sgt_append.sgt);
>>   	if (err) {
>> -		rxe_dbg_mr(mr, "Unable to allocate memory for map\n");
>> -		goto err_release_umem;
>> +		ib_umem_release(umem);
>> +		return err;
>>   	}
>>   
>> -	num_buf			= 0;
>> -	map = mr->map;
>> -	if (length > 0) {
>> -		bool persistent_access = access & IB_ACCESS_FLUSH_PERSISTENT;
>> -
>> -		buf = map[0]->buf;
>> -		for_each_sgtable_page (&umem->sgt_append.sgt, &sg_iter, 0) {
>> -			struct page *pg = sg_page_iter_page(&sg_iter);
>> +	mr->umem = umem;
>> +	mr->ibmr.type = IB_MR_TYPE_USER;
>> +	mr->state = RXE_MR_STATE_VALID;
>>   
>> -			if (persistent_access && !is_pmem_page(pg)) {
>> -				rxe_dbg_mr(mr, "Unable to register persistent access to non-pmem device\n");
>> -				err = -EINVAL;
>> -				goto err_release_umem;
>> -			}
> 
> I read you removed is_pmem_page and its checking, but there is no description about this.
> IMO, it's required by IBA spec.
> 
> Thanks
> Zhijian

Zhijian,

It was dropped by accident. I just posted an update with the calls put back. Please take a
look and if possible can you test to see if it doesn't regress your pmem changes. I have no
way to test pmem. Also look at a comment I added to the pmem flush call. I am suspicious of
the smp_store_release() call based on the original comment.

Regards,

Bob
