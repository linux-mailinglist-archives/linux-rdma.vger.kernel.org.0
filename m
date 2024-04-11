Return-Path: <linux-rdma+bounces-1899-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFD98A0915
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 09:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A8A1F21DDA
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 07:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E58E13DB9C;
	Thu, 11 Apr 2024 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k4Y9bFm8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B76013CAB3
	for <linux-rdma@vger.kernel.org>; Thu, 11 Apr 2024 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819157; cv=none; b=GzsVuwBObGF8/m5E8LanSRgsZvpaqRuvFBKw7dOyU8Hc7Dz2p2ep7AmdeMA1euIJntek4NuuluW0KbPlUP1c5s/KNAyZHMVGgUWD3XnVAzC2ixzf1Kr5bKLS+/8SxGJLR/dZAXjYnkukIpLINosyqDjJBuYfnBuuRulWU8IxYok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819157; c=relaxed/simple;
	bh=Hr1kqdhj/aKp9m91zUG2sovSs81f/RfLbcrUnRekrYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSIaELGJOOZsg4fcNEo4Wfr+dHYWFe8gkB1x0ftBq6hNMZiRoM37kCbdwspDXZdiCSaqodDxnEq+5XOHtF+QnV0DEyUCG7X0Ou62KZgXxiJHTdeWtmtC4Kru7oDB3p1QmfKfUSE5gGyifg1iybR7zs2jilw2R8ilo1ragj0xLrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k4Y9bFm8; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d1a7e1db-e425-4c25-8d10-3614d62eab3a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712819153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fMMG5NNo5E5r0/Jui66UibP3lfydD2vq7YVDWOUHlxI=;
	b=k4Y9bFm8/ki+yQnR6lOG4h6xA1GzW63d+O7719jXoVhA/W2hysH3W6TVqrNOzbpeuMSe+X
	wt0GnKVRXY/zQ5Mz8GNMqqiYYvMqWX1YEqXGl00yCb4Jvjm6EzEYlyi3Q2MAtribvw6/pL
	DurR8wBIS4bN/efFgHoGNWdfaiSYXyQ=
Date: Thu, 11 Apr 2024 09:05:52 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/hns: fix return value in hns_roce_map_mr_sg
To: shaozhengchao <shaozhengchao@huawei.com>, linux-rdma@vger.kernel.org,
 tangchengchang@huawei.com, huangjunxian6@hisilicon.com
Cc: jgg@ziepe.ca, leon@kernel.org, chenglang@huawei.com, wangxi11@huawei.com,
 liweihang@huawei.com, weiyongjun1@huawei.com, yuehaibing@huawei.com
References: <20240411033851.2884771-1-shaozhengchao@huawei.com>
 <80ad83ce-1c3f-485b-a148-3696b5802b30@linux.dev>
 <7e31102c-74d0-b398-e776-a79adfbac579@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <7e31102c-74d0-b398-e776-a79adfbac579@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/4/11 8:26, shaozhengchao 写道:
>
>
> On 2024/4/11 14:08, Zhu Yanjun wrote:
>> 在 2024/4/11 5:38, Zhengchao Shao 写道:
>>> As described in the ib_map_mr_sg function comment, it returns the 
>>> number
>>> of sg elements that were mapped to the memory region. However,
>>> hns_roce_map_mr_sg returns the number of pages required for mapping the
>>> DMA area. Fix it.
>>>
>>> Fixes: 9b2cf76c9f05 ("RDMA/hns: Optimize PBL buffer allocation 
>>> process")
>>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>>> ---
>>> v2: fix the return value and coding format issues
>>> ---
>>>   drivers/infiniband/hw/hns/hns_roce_mr.c | 15 +++++++--------
>>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c 
>>> b/drivers/infiniband/hw/hns/hns_roce_mr.c
>>> index 9e05b57a2d67..80c050d7d0ea 100644
>>> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
>>> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
>>> @@ -441,18 +441,18 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, 
>>> struct scatterlist *sg, int sg_nents,
>>>       struct ib_device *ibdev = &hr_dev->ib_dev;
>>>       struct hns_roce_mr *mr = to_hr_mr(ibmr);
>>>       struct hns_roce_mtr *mtr = &mr->pbl_mtr;
>>> -    int ret = 0;
>>> +    int ret, sg_num = 0;
>>>       mr->npages = 0;
>>>       mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
>>>                    sizeof(dma_addr_t), GFP_KERNEL);
>>>       if (!mr->page_list)
>>> -        return ret;
>>> +        return sg_num;
>>> -    ret = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, 
>>> hns_roce_set_page);
>>> -    if (ret < 1) {
>>> +    sg_num = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, 
>>> hns_roce_set_page);
>>> +    if (sg_num < 1) {
>>>           ibdev_err(ibdev, "failed to store sg pages %u %u, cnt = 
>>> %d.\n",
>>> -              mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, ret);
>>> +              mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, sg_num);
>>>           goto err_page_list;
>>>       }
>>> @@ -463,17 +463,16 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, 
>>> struct scatterlist *sg, int sg_nents,
>>>       ret = hns_roce_mtr_map(hr_dev, mtr, mr->page_list, mr->npages);
>>>       if (ret) {
>>>           ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", ret);
>>> -        ret = 0;
>>> +        sg_num = 0;
>>>       } else {
>>>           mr->pbl_mtr.hem_cfg.buf_pg_shift = 
>>> (u32)ilog2(ibmr->page_size);
>>> -        ret = mr->npages;
>>>       }
>>
> Hi Yanjun:
>   Thank you for your review. The hns_roce_mtr_map function indicates
> whether the page is successfully mapped. If sg_num is used, there may be
> ambiguity. Maybe what do I missed?

Sure. From my perspective, I just want to remove a local variable. You 
consideration also makes sense.

Zhu Yanjun

>
> Zhengchao Shao
>> In the above, can we replace the local variable ret with sg_num? So 
>> the local variable ret can be removed.
>> A trivial problem.
>>
>> @@ -433,7 +433,7 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct 
>> scatterlist *sg, int sg_nents,
>>          struct ib_device *ibdev = &hr_dev->ib_dev;
>>          struct hns_roce_mr *mr = to_hr_mr(ibmr);
>>          struct hns_roce_mtr *mtr = &mr->pbl_mtr;
>> -       int ret, sg_num = 0;
>> +       int sg_num = 0;
>>
>>          mr->npages = 0;
>>          mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
>> @@ -452,9 +452,9 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct 
>> scatterlist *sg, int sg_nents,
>>          mtr->hem_cfg.region[0].count = mr->npages;
>>          mtr->hem_cfg.region[0].hopnum = mr->pbl_hop_num;
>>          mtr->hem_cfg.region_count = 1;
>> -       ret = hns_roce_mtr_map(hr_dev, mtr, mr->page_list, mr->npages);
>> -       if (ret) {
>> -               ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", 
>> ret);
>> +       sg_num = hns_roce_mtr_map(hr_dev, mtr, mr->page_list, 
>> mr->npages);
>> +       if (sg_num) {
>> +               ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", 
>> sg_num);
>>                  sg_num = 0;
>>          } else {
>>                  mr->pbl_mtr.hem_cfg.buf_pg_shift = 
>> (u32)ilog2(ibmr->page_size);
>>
>> Zhu Yanjun
>>
>>>   err_page_list:
>>>       kvfree(mr->page_list);
>>>       mr->page_list = NULL;
>>> -    return ret;
>>> +    return sg_num;
>>>   }
>>>   static void hns_roce_mw_free(struct hns_roce_dev *hr_dev,
>>

