Return-Path: <linux-rdma+bounces-1897-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974258A0810
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 08:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB52D2848BA
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 06:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBFB13C3ED;
	Thu, 11 Apr 2024 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IFV8vP0q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD213CA81
	for <linux-rdma@vger.kernel.org>; Thu, 11 Apr 2024 06:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712815701; cv=none; b=JzUqaJvSiEOfOf5yZY6fsu/CE6FgMwT0UVQgypGfhUnfpi7RJ9VHC6ne8jvbGCd6EgRlg7YlQc1ZA6N0EI59sYPWcDdtMODRus1AoIx69eh7RwVC3OROpqOxRDvE5rEdtzVTZO5H8EkD4NHWc3y1Me1Pz534tUO0Jnll1zsUyf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712815701; c=relaxed/simple;
	bh=w8gJxOBaXlUq2VHnOG0jBHGdux1x/mhOtqvwKB0dKkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYFPQTXqUtoszmiaXTHFNMJ8/H6RRQhJzNoweNJtf3DXm60wc/NY9rzmp4Y3d/l2Yvb2JZYDDrVCTbt5+KpdHC7vGt4EeHrevjNSnKm2VwUkM45vXijcv78aQVPHojJl+ljquxn2LGUsabdQmAzqO5FLlX8X+MH74dMhbCBUpns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IFV8vP0q; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <80ad83ce-1c3f-485b-a148-3696b5802b30@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712815696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KgvT+TA6PM0e+EqxxnSkZ09NB87HDodY7VsIgZGqBs=;
	b=IFV8vP0qYNhOFGBdLsOHNx0qpoxt98r6vkAWZ6qDA1oi655C0yIIZV3Vq2GYAaBaEf2D/2
	3QUQMRdulunOoCqfQPt+FHAH6gtc9CygiTkTZ8G8S+qC1suxzFlbk5wk1BvKdMnyE1/aBM
	3LaJ0aahyXQ27cxFnSexOykg347iY/g=
Date: Thu, 11 Apr 2024 08:08:14 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/hns: fix return value in hns_roce_map_mr_sg
To: Zhengchao Shao <shaozhengchao@huawei.com>, linux-rdma@vger.kernel.org,
 tangchengchang@huawei.com, huangjunxian6@hisilicon.com
Cc: jgg@ziepe.ca, leon@kernel.org, chenglang@huawei.com, wangxi11@huawei.com,
 liweihang@huawei.com, weiyongjun1@huawei.com, yuehaibing@huawei.com
References: <20240411033851.2884771-1-shaozhengchao@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240411033851.2884771-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/4/11 5:38, Zhengchao Shao 写道:
> As described in the ib_map_mr_sg function comment, it returns the number
> of sg elements that were mapped to the memory region. However,
> hns_roce_map_mr_sg returns the number of pages required for mapping the
> DMA area. Fix it.
> 
> Fixes: 9b2cf76c9f05 ("RDMA/hns: Optimize PBL buffer allocation process")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
> v2: fix the return value and coding format issues
> ---
>   drivers/infiniband/hw/hns/hns_roce_mr.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> index 9e05b57a2d67..80c050d7d0ea 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> @@ -441,18 +441,18 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>   	struct ib_device *ibdev = &hr_dev->ib_dev;
>   	struct hns_roce_mr *mr = to_hr_mr(ibmr);
>   	struct hns_roce_mtr *mtr = &mr->pbl_mtr;
> -	int ret = 0;
> +	int ret, sg_num = 0;
>   
>   	mr->npages = 0;
>   	mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
>   				 sizeof(dma_addr_t), GFP_KERNEL);
>   	if (!mr->page_list)
> -		return ret;
> +		return sg_num;
>   
> -	ret = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, hns_roce_set_page);
> -	if (ret < 1) {
> +	sg_num = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, hns_roce_set_page);
> +	if (sg_num < 1) {
>   		ibdev_err(ibdev, "failed to store sg pages %u %u, cnt = %d.\n",
> -			  mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, ret);
> +			  mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, sg_num);
>   		goto err_page_list;
>   	}
>   
> @@ -463,17 +463,16 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>   	ret = hns_roce_mtr_map(hr_dev, mtr, mr->page_list, mr->npages);
>   	if (ret) {
>   		ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", ret);
> -		ret = 0;
> +		sg_num = 0;
>   	} else {
>   		mr->pbl_mtr.hem_cfg.buf_pg_shift = (u32)ilog2(ibmr->page_size);
> -		ret = mr->npages;
>   	}

In the above, can we replace the local variable ret with sg_num? So the 
local variable ret can be removed.
A trivial problem.

@@ -433,7 +433,7 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct 
scatterlist *sg, int sg_nents,
         struct ib_device *ibdev = &hr_dev->ib_dev;
         struct hns_roce_mr *mr = to_hr_mr(ibmr);
         struct hns_roce_mtr *mtr = &mr->pbl_mtr;
-       int ret, sg_num = 0;
+       int sg_num = 0;

         mr->npages = 0;
         mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
@@ -452,9 +452,9 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct 
scatterlist *sg, int sg_nents,
         mtr->hem_cfg.region[0].count = mr->npages;
         mtr->hem_cfg.region[0].hopnum = mr->pbl_hop_num;
         mtr->hem_cfg.region_count = 1;
-       ret = hns_roce_mtr_map(hr_dev, mtr, mr->page_list, mr->npages);
-       if (ret) {
-               ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", ret);
+       sg_num = hns_roce_mtr_map(hr_dev, mtr, mr->page_list, mr->npages);
+       if (sg_num) {
+               ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", 
sg_num);
                 sg_num = 0;
         } else {
                 mr->pbl_mtr.hem_cfg.buf_pg_shift = 
(u32)ilog2(ibmr->page_size);

Zhu Yanjun

>   
>   err_page_list:
>   	kvfree(mr->page_list);
>   	mr->page_list = NULL;
>   
> -	return ret;
> +	return sg_num;
>   }
>   
>   static void hns_roce_mw_free(struct hns_roce_dev *hr_dev,


