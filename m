Return-Path: <linux-rdma+bounces-1898-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8088A086F
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 08:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CCA1F25D63
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 06:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF6613CAAC;
	Thu, 11 Apr 2024 06:26:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FB362144
	for <linux-rdma@vger.kernel.org>; Thu, 11 Apr 2024 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816781; cv=none; b=DzMcSbSwQlx/Xxx20BRYIjb/2Bg0/+QcUyF8sm0N292KdSuppTpYQOVDRTL/toqlueVpyYLK7eeNSeY0gYLS//eZQKv2VkBPQgryoQp3zphu64VdC7xHVDCWjS2IHNAyLB4tGg/B5KobOof6skGipeh2gboycu7Tbpnw339QVCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816781; c=relaxed/simple;
	bh=LSQgw1Mi7adNlW4FE72u490olbg+HMvAB96aKlJHXNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bj2vYvjsREV+1DnIjD1Rgcf51IIf2h7YCJRD/tPMd3L1WCZ30CW5igjgQvpcM9n0TwkYkU8qS++2cYJ1NvB5igvatqZ2mGbZcGaD8zqnWRrhTZ6AQoPczfje0LP2qFIchjMmY6iBW7QX+gscMJXxjWaQBEemcS7dR69DpEE7pDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VFV4l2bvPzwRfh;
	Thu, 11 Apr 2024 14:23:19 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id B6C6A18006B;
	Thu, 11 Apr 2024 14:26:15 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 14:26:15 +0800
Message-ID: <7e31102c-74d0-b398-e776-a79adfbac579@huawei.com>
Date: Thu, 11 Apr 2024 14:26:14 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v2] RDMA/hns: fix return value in hns_roce_map_mr_sg
To: Zhu Yanjun <yanjun.zhu@linux.dev>, <linux-rdma@vger.kernel.org>,
	<tangchengchang@huawei.com>, <huangjunxian6@hisilicon.com>
CC: <jgg@ziepe.ca>, <leon@kernel.org>, <chenglang@huawei.com>,
	<wangxi11@huawei.com>, <liweihang@huawei.com>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>
References: <20240411033851.2884771-1-shaozhengchao@huawei.com>
 <80ad83ce-1c3f-485b-a148-3696b5802b30@linux.dev>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <80ad83ce-1c3f-485b-a148-3696b5802b30@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)



On 2024/4/11 14:08, Zhu Yanjun wrote:
> 在 2024/4/11 5:38, Zhengchao Shao 写道:
>> As described in the ib_map_mr_sg function comment, it returns the number
>> of sg elements that were mapped to the memory region. However,
>> hns_roce_map_mr_sg returns the number of pages required for mapping the
>> DMA area. Fix it.
>>
>> Fixes: 9b2cf76c9f05 ("RDMA/hns: Optimize PBL buffer allocation process")
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>> v2: fix the return value and coding format issues
>> ---
>>   drivers/infiniband/hw/hns/hns_roce_mr.c | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c 
>> b/drivers/infiniband/hw/hns/hns_roce_mr.c
>> index 9e05b57a2d67..80c050d7d0ea 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
>> @@ -441,18 +441,18 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, 
>> struct scatterlist *sg, int sg_nents,
>>       struct ib_device *ibdev = &hr_dev->ib_dev;
>>       struct hns_roce_mr *mr = to_hr_mr(ibmr);
>>       struct hns_roce_mtr *mtr = &mr->pbl_mtr;
>> -    int ret = 0;
>> +    int ret, sg_num = 0;
>>       mr->npages = 0;
>>       mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
>>                    sizeof(dma_addr_t), GFP_KERNEL);
>>       if (!mr->page_list)
>> -        return ret;
>> +        return sg_num;
>> -    ret = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, 
>> hns_roce_set_page);
>> -    if (ret < 1) {
>> +    sg_num = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, 
>> hns_roce_set_page);
>> +    if (sg_num < 1) {
>>           ibdev_err(ibdev, "failed to store sg pages %u %u, cnt = %d.\n",
>> -              mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, ret);
>> +              mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, sg_num);
>>           goto err_page_list;
>>       }
>> @@ -463,17 +463,16 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, 
>> struct scatterlist *sg, int sg_nents,
>>       ret = hns_roce_mtr_map(hr_dev, mtr, mr->page_list, mr->npages);
>>       if (ret) {
>>           ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", ret);
>> -        ret = 0;
>> +        sg_num = 0;
>>       } else {
>>           mr->pbl_mtr.hem_cfg.buf_pg_shift = (u32)ilog2(ibmr->page_size);
>> -        ret = mr->npages;
>>       }
> 
Hi Yanjun:
   Thank you for your review. The hns_roce_mtr_map function indicates
whether the page is successfully mapped. If sg_num is used, there may be
ambiguity. Maybe what do I missed?

Zhengchao Shao
> In the above, can we replace the local variable ret with sg_num? So the 
> local variable ret can be removed.
> A trivial problem.
> 
> @@ -433,7 +433,7 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct 
> scatterlist *sg, int sg_nents,
>          struct ib_device *ibdev = &hr_dev->ib_dev;
>          struct hns_roce_mr *mr = to_hr_mr(ibmr);
>          struct hns_roce_mtr *mtr = &mr->pbl_mtr;
> -       int ret, sg_num = 0;
> +       int sg_num = 0;
> 
>          mr->npages = 0;
>          mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
> @@ -452,9 +452,9 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct 
> scatterlist *sg, int sg_nents,
>          mtr->hem_cfg.region[0].count = mr->npages;
>          mtr->hem_cfg.region[0].hopnum = mr->pbl_hop_num;
>          mtr->hem_cfg.region_count = 1;
> -       ret = hns_roce_mtr_map(hr_dev, mtr, mr->page_list, mr->npages);
> -       if (ret) {
> -               ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", ret);
> +       sg_num = hns_roce_mtr_map(hr_dev, mtr, mr->page_list, mr->npages);
> +       if (sg_num) {
> +               ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", 
> sg_num);
>                  sg_num = 0;
>          } else {
>                  mr->pbl_mtr.hem_cfg.buf_pg_shift = 
> (u32)ilog2(ibmr->page_size);
> 
> Zhu Yanjun
> 
>>   err_page_list:
>>       kvfree(mr->page_list);
>>       mr->page_list = NULL;
>> -    return ret;
>> +    return sg_num;
>>   }
>>   static void hns_roce_mw_free(struct hns_roce_dev *hr_dev,
> 

