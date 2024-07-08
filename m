Return-Path: <linux-rdma+bounces-3700-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0C3929AED
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 04:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583701C20A3C
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 02:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C5B63CB;
	Mon,  8 Jul 2024 02:45:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6AD469D;
	Mon,  8 Jul 2024 02:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720406705; cv=none; b=OhBNnLAX22C82FzqRk25jdRaMJvggL7FvIeu3UkcrmXsYclNMY7irxObz7Z6fywgirWCTfpEs4mdfZofFbw27Pdj5Jla9rawbiD59wpWUcksUFZaGkiLa1YFRdXNct8RGltYVRUDDg1CKyMYEh2Qzl2LQAL4AD7jxSQOX9OoU10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720406705; c=relaxed/simple;
	bh=/ESStp0zOGCzcavEfIgFbh1zL12uPrvYRTiTvwFshR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=svNZw5gGzG0yfEQGf3TTKgC6ziN5Q6eHE4k7CodmxBnkrzoT7FBPP6qGT8tqSnbp33YRVp4W7Wu73UVGconP82dLpmSN9rz1cczvwVUMvVkQRD/wWl9fS30ivZcYKrhU9NSoK7CImdbUnFeipm2hjyBmN1obreeCQvaxS3AG01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WHT3d1mpPznZZQ;
	Mon,  8 Jul 2024 10:44:29 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 34BE014041B;
	Mon,  8 Jul 2024 10:44:53 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Jul 2024 10:44:52 +0800
Message-ID: <849ed8b9-e826-7211-3e90-7fdeff9d945a@hisilicon.com>
Date: Mon, 8 Jul 2024 10:44:52 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-rc 5/9] RDMA/hns: Fix missing pagesize and alignment
 check in FRMR
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
 <20240705085937.1644229-6-huangjunxian6@hisilicon.com>
 <eba4bfaf-5986-489b-9ae5-8f5618501290@linux.dev>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <eba4bfaf-5986-489b-9ae5-8f5618501290@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/7/7 17:16, Zhu Yanjun wrote:
> 在 2024/7/5 16:59, Junxian Huang 写道:
>> From: Chengchang Tang <tangchengchang@huawei.com>
>>
>> The offset requires 128B alignment and the page size ranges from
>> 4K to 128M.
>>
>> Fixes: 68a997c5d28c ("RDMA/hns: Add FRMR support for hip08")
> 
> https://patchwork.kernel.org/project/linux-rdma/patch/2eee7e35-504e-4f2a-a364-527e90669108@CMEXHTCAS1.ad.emulex.com/
> In the above link, from Bart, it seems that FRMR is renamed to FRWR.
> "
> There are already a few drivers upstream in which the fast register
> memory region work request is abbreviated as FRWR. Please consider
> renaming FRMR into FRWR in order to avoid confusion and in order to
> make it easier to find related code with grep in the kernel tree.
> "
> 
> So is it possible to rename FRMR to FRWR?
> 

I think the rename is irrelevant to this bugfix, and if it needs to be done,
we'll need a single patch to rename all existing 'FRMR' in hns driver.

So let's leave it as is for now.

Thanks,
Junxian

>> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> ---
>>   drivers/infiniband/hw/hns/hns_roce_device.h | 4 ++++
>>   drivers/infiniband/hw/hns/hns_roce_mr.c     | 5 +++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index 5a2445f357ab..15b3b978a601 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -83,6 +83,7 @@
>>   #define MR_TYPE_DMA                0x03
>>     #define HNS_ROCE_FRMR_MAX_PA            512
>> +#define HNS_ROCE_FRMR_ALIGN_SIZE        128
>>     #define PKEY_ID                    0xffff
>>   #define NODE_DESC_SIZE                64
>> @@ -189,6 +190,9 @@ enum {
>>   #define HNS_HW_PAGE_SHIFT            12
>>   #define HNS_HW_PAGE_SIZE            (1 << HNS_HW_PAGE_SHIFT)
>>   +#define HNS_HW_MAX_PAGE_SHIFT            27
>> +#define HNS_HW_MAX_PAGE_SIZE            (1 << HNS_HW_MAX_PAGE_SHIFT)
>> +
>>   struct hns_roce_uar {
>>       u64        pfn;
>>       unsigned long    index;
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
>> index 1a61dceb3319..846da8c78b8b 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
>> @@ -443,6 +443,11 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>>       struct hns_roce_mtr *mtr = &mr->pbl_mtr;
>>       int ret, sg_num = 0;
>>   +    if (!IS_ALIGNED(*sg_offset, HNS_ROCE_FRMR_ALIGN_SIZE) ||
>> +        ibmr->page_size < HNS_HW_PAGE_SIZE ||
>> +        ibmr->page_size > HNS_HW_MAX_PAGE_SIZE)
>> +        return sg_num;
>> +
>>       mr->npages = 0;
>>       mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
>>                    sizeof(dma_addr_t), GFP_KERNEL);
> 

