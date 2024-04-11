Return-Path: <linux-rdma+bounces-1891-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ABD8A0644
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 04:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0DC288042
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 02:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E4113B2BE;
	Thu, 11 Apr 2024 02:56:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF1F5F870
	for <linux-rdma@vger.kernel.org>; Thu, 11 Apr 2024 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804189; cv=none; b=Wr7CsZYyjtuZ5U3zxCauNhZ+f9KEWIItH0v+efvhK58KrfrlpGEahPKs8dP9F4LtsQZcCFNlHiTfs+ax8R4+2lFnUjAr6JxYqdeZrgFPkPOdaX94Cfw2iYU/q/SrGG3gJJLSpvb/GNj+rjObVF+skx2yQ6IAVMyJZLLXd+rAcLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804189; c=relaxed/simple;
	bh=kGK0dQ4NQfcg7gWBir5Bkqa1NAKvaIL5YS+hoT1jvqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dR1v7ti+svIhP/oE9AFyIQfuK8TZN62/y8eS19JFCtQoWeo5NWZJyeehwS8YOoqU3bRuKBv9JLRSchx/tDMWqIbJZQJNCCmEMdkl/p5qW88heJemYo4EXN0aVpmvpfTbP4BazK5O4gI8MB7lV0mT6zEaGTvlY6ci6qiGEVGxb0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VFPT45gY4zLlhc;
	Thu, 11 Apr 2024 10:55:36 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 959301A0172;
	Thu, 11 Apr 2024 10:56:23 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:56:22 +0800
Message-ID: <e71e6bc0-6fa8-53ce-a433-3d9a743223df@hisilicon.com>
Date: Thu, 11 Apr 2024 10:56:22 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH net] RDMA/hns: fix return value in hns_roce_map_mr_sg
Content-Language: en-US
To: Zhengchao Shao <shaozhengchao@huawei.com>, <linux-rdma@vger.kernel.org>,
	<tangchengchang@huawei.com>
CC: <jgg@ziepe.ca>, <leon@kernel.org>, <wangxi11@huawei.com>,
	<liweihang@huawei.com>, <chenglang@huawei.com>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>
References: <20240411022757.2591839-1-shaozhengchao@huawei.com>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240411022757.2591839-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)



On 2024/4/11 10:27, Zhengchao Shao wrote:
> As described in the ib_map_mr_sg function comment, it returns the number
> of sg elements that were mapped to the memory region. However,
> hns_roce_map_mr_sg returns the number of pages required for mapping the
> DMA area. Fix it.
> 
> Fixes: 9b2cf76c9f05 ("RDMA/hns: Optimize PBL buffer allocation process")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_mr.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> index 9e05b57a2d67..0c5e41d5c03d 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> @@ -441,7 +441,7 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>  	struct ib_device *ibdev = &hr_dev->ib_dev;
>  	struct hns_roce_mr *mr = to_hr_mr(ibmr);
>  	struct hns_roce_mtr *mtr = &mr->pbl_mtr;
> -	int ret = 0;
> +	int ret, sg_num;
>  

<...>

>  	mr->npages = 0;
>  	mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
> @@ -449,10 +449,10 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>  	if (!mr->page_list)
>  		return ret;

The 'ret = 0' is deleted, and here returns an undefined value.

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
> @@ -463,17 +463,15 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>  	ret = hns_roce_mtr_map(hr_dev, mtr, mr->page_list, mr->npages);
>  	if (ret) {
>  		ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", ret);
> -		ret = 0;
> -	} else {
> +		sg_num = 0;
> +	} else
>  		mr->pbl_mtr.hem_cfg.buf_pg_shift = (u32)ilog2(ibmr->page_size);
> -		ret = mr->npages;
> -	}

Braces should be used in both branches, as the if branch has two statements.

Junxian

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

