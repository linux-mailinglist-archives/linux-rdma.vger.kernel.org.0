Return-Path: <linux-rdma+bounces-1892-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9318A0687
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 05:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9ADB28A209
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 03:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141D613B792;
	Thu, 11 Apr 2024 03:09:26 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888E513B791
	for <linux-rdma@vger.kernel.org>; Thu, 11 Apr 2024 03:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804965; cv=none; b=tk25Dthu+pWohwsoXm9sz7eMirlNSLYom8Zv/ygeNRVQvD+d3pWCZQDHC1rqSTh5uswx6rCCpGl/cR71uJmNcsrt/OPPi62J/y5BlX6kIFIxxDZZAZCrC0qH6zN9zBMhsK9sJMIQgYCGiXor0IlQtVvds97TW8o18pvMBkv2o3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804965; c=relaxed/simple;
	bh=lJEgYGOR37+PimLwGeif4FU65z3mpOUtiwmKGsZb0aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K5/q8He8INvGErlZBTEW7GTwH6VrdH8Lu41f8ZxFnKf2eYD/z+SVgb/YJY7bPmsKdsiYmfbSf9ctVq+CR17fDGXzcL0RI0lJ6xFEKMvTn+MmisFvhVyJden+KCLJvhfb4+IWR+9YOFXTpgVwMza00XDchwcX26YscAMrula3Y6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VFPkC0MLNzNnZl;
	Thu, 11 Apr 2024 11:06:59 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id E2452140414;
	Thu, 11 Apr 2024 11:09:15 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 11:09:15 +0800
Message-ID: <3c0a2da0-889e-fc6a-193c-05ca75b566ad@huawei.com>
Date: Thu, 11 Apr 2024 11:09:14 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net] RDMA/hns: fix return value in hns_roce_map_mr_sg
To: Junxian Huang <huangjunxian6@hisilicon.com>, <linux-rdma@vger.kernel.org>,
	<tangchengchang@huawei.com>
CC: <jgg@ziepe.ca>, <leon@kernel.org>, <wangxi11@huawei.com>,
	<liweihang@huawei.com>, <chenglang@huawei.com>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>
References: <20240411022757.2591839-1-shaozhengchao@huawei.com>
 <e71e6bc0-6fa8-53ce-a433-3d9a743223df@hisilicon.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <e71e6bc0-6fa8-53ce-a433-3d9a743223df@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)



On 2024/4/11 10:56, Junxian Huang wrote:
> 
> 
> On 2024/4/11 10:27, Zhengchao Shao wrote:
>> As described in the ib_map_mr_sg function comment, it returns the number
>> of sg elements that were mapped to the memory region. However,
>> hns_roce_map_mr_sg returns the number of pages required for mapping the
>> DMA area. Fix it.
>>
>> Fixes: 9b2cf76c9f05 ("RDMA/hns: Optimize PBL buffer allocation process")
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>>   drivers/infiniband/hw/hns/hns_roce_mr.c | 16 +++++++---------
>>   1 file changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
>> index 9e05b57a2d67..0c5e41d5c03d 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
>> @@ -441,7 +441,7 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>>   	struct ib_device *ibdev = &hr_dev->ib_dev;
>>   	struct hns_roce_mr *mr = to_hr_mr(ibmr);
>>   	struct hns_roce_mtr *mtr = &mr->pbl_mtr;
>> -	int ret = 0;
>> +	int ret, sg_num;
>>   
> 
> <...>
> 
>>   	mr->npages = 0;
>>   	mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
>> @@ -449,10 +449,10 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>>   	if (!mr->page_list)
>>   		return ret;
> 
Hi Junxian:
	Thank you for your review.
> The 'ret = 0' is deleted, and here returns an undefined value.
	My mistake.
> 
>>   
>> -	ret = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, hns_roce_set_page);
>> -	if (ret < 1) {
>> +	sg_num = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, hns_roce_set_page);
>> +	if (sg_num < 1) {
>>   		ibdev_err(ibdev, "failed to store sg pages %u %u, cnt = %d.\n",
>> -			  mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, ret);
>> +			  mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, sg_num);
>>   		goto err_page_list;
>>   	}
>>   
>> @@ -463,17 +463,15 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>>   	ret = hns_roce_mtr_map(hr_dev, mtr, mr->page_list, mr->npages);
>>   	if (ret) {
>>   		ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", ret);
>> -		ret = 0;
>> -	} else {
>> +		sg_num = 0;
>> +	} else
>>   		mr->pbl_mtr.hem_cfg.buf_pg_shift = (u32)ilog2(ibmr->page_size);
>> -		ret = mr->npages;
>> -	}
> 
> Braces should be used in both branches, as the if branch has two statements.
> 
	Yeah. I will change it in V2.
> Junxian
> 

Zhengchao Shao
>>   
>>   err_page_list:
>>   	kvfree(mr->page_list);
>>   	mr->page_list = NULL;
>>   
>> -	return ret;
>> +	return sg_num;
>>   }
>>   
>>   static void hns_roce_mw_free(struct hns_roce_dev *hr_dev,

