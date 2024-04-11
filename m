Return-Path: <linux-rdma+bounces-1896-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900F48A07F6
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 08:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFA45B23374
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 06:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E4F13CA82;
	Thu, 11 Apr 2024 06:00:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664813C9DD
	for <linux-rdma@vger.kernel.org>; Thu, 11 Apr 2024 05:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712815200; cv=none; b=fe9d4cjws2ojMgu/oAvlAnrBcMErKbOw/NqixXAPygHdNgKUr4cq8DrQmZJ3G+oBMLOwL5wqgE7rZFVHEqe2TeESe1t1iwynWiDy5amlQUxt7jwSxXX1zemDydBJl1Yo9vp9ZZbTqHcq70hXPrxrdlwILOnfSwIq+BtG56NcTnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712815200; c=relaxed/simple;
	bh=TObUJ+VsK8+jbtMD+0KhFMq2AGPEZB5q8u7/8cN1llE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SH1kboMh5X0GGp3ZmH9H/5Mh2iGVkWYfQPHOlvjBiaJG/vKJTTSmoAZiNMP1wR8ZMExfjLyCwGTpQYNRu9mwiQZfTc0Gn3hBkAPjswGFTLz3veaKF3k4SGFs1WyvEvHNwXHn//a3B0sx/2R1vuyqfxbeHLPBjIy93B5US/OxMPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VFTVP4sdVz1RCGr;
	Thu, 11 Apr 2024 13:57:01 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 9870E180063;
	Thu, 11 Apr 2024 13:59:54 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 13:59:53 +0800
Message-ID: <e479c19d-6cd0-c2d2-a380-2fd29476cb74@hisilicon.com>
Date: Thu, 11 Apr 2024 13:59:53 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v2] RDMA/hns: fix return value in hns_roce_map_mr_sg
Content-Language: en-US
To: Zhengchao Shao <shaozhengchao@huawei.com>, <linux-rdma@vger.kernel.org>,
	<tangchengchang@huawei.com>
CC: <jgg@ziepe.ca>, <leon@kernel.org>, <chenglang@huawei.com>,
	<wangxi11@huawei.com>, <liweihang@huawei.com>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>
References: <20240411033851.2884771-1-shaozhengchao@huawei.com>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240411033851.2884771-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500006.china.huawei.com (7.221.188.68)



On 2024/4/11 11:38, Zhengchao Shao wrote:
> As described in the ib_map_mr_sg function comment, it returns the number
> of sg elements that were mapped to the memory region. However,
> hns_roce_map_mr_sg returns the number of pages required for mapping the
> DMA area. Fix it.
> 
> Fixes: 9b2cf76c9f05 ("RDMA/hns: Optimize PBL buffer allocation process")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Thanks,

Reviewed-by: Junxian Huang <huangjunxian6@hisilicon.com>

> ---
> v2: fix the return value and coding format issues
> ---
>  drivers/infiniband/hw/hns/hns_roce_mr.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> index 9e05b57a2d67..80c050d7d0ea 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> @@ -441,18 +441,18 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>  	struct ib_device *ibdev = &hr_dev->ib_dev;
>  	struct hns_roce_mr *mr = to_hr_mr(ibmr);
>  	struct hns_roce_mtr *mtr = &mr->pbl_mtr;
> -	int ret = 0;
> +	int ret, sg_num = 0;
>  
>  	mr->npages = 0;
>  	mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
>  				 sizeof(dma_addr_t), GFP_KERNEL);
>  	if (!mr->page_list)
> -		return ret;
> +		return sg_num;
>  
> -	ret = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, hns_roce_set_page);
> -	if (ret < 1) {
> +	sg_num = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, hns_roce_set_page);
> +	if (sg_num < 1) {
>  		ibdev_err(ibdev, "failed to store sg pages %u %u, cnt = %d.\n",
> -			  mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, ret);
> +			  mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, sg_num);
>  		goto err_page_list;
>  	}
>  
> @@ -463,17 +463,16 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>  	ret = hns_roce_mtr_map(hr_dev, mtr, mr->page_list, mr->npages);
>  	if (ret) {
>  		ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", ret);
> -		ret = 0;
> +		sg_num = 0;
>  	} else {
>  		mr->pbl_mtr.hem_cfg.buf_pg_shift = (u32)ilog2(ibmr->page_size);
> -		ret = mr->npages;
>  	}
>  
>  err_page_list:
>  	kvfree(mr->page_list);
>  	mr->page_list = NULL;
>  
> -	return ret;
> +	return sg_num;
>  }
>  
>  static void hns_roce_mw_free(struct hns_roce_dev *hr_dev,

