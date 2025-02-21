Return-Path: <linux-rdma+bounces-7945-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB8EA3EDB3
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 08:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477D317F4F4
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 07:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85F21FF7AA;
	Fri, 21 Feb 2025 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qpTX+8H+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4084F1FF610;
	Fri, 21 Feb 2025 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124538; cv=none; b=lMZhnOUopK2lpXWGlzIPKxvKqxp9xDdVUzYVIC8oONPkzd0LKsC/uT7iWVntnWgwCkSYGL+9w5o6N/VGGF+yp0vJsEjUbw9p+Up4GNUYgvzoyJy3znKPxWA64eFefzpu8KH3s0zZ/RgHrVNdBR42vHOi3cg3FrlXLD802VCqzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124538; c=relaxed/simple;
	bh=h8+1BClpdPaP9AKnoAIFhGnKFTHYfjlLfrnwX+QSKIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2VkYDFMD3BhBG90B5pS4dWI66nVtSEzGqDChfjmaRmORqInX8a4+ohrMCumMaxIF1TQPwlNPRO+hEMauliDDMDbKKJTmRCb+G26p5YGefJAyn1kjXfHGqOI3aTNbGk53+OA0LtXNMGbJRwusrT6ZEGNSTpU/B+HajZSsG1JqoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qpTX+8H+; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740124527; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZsQ4BOAI6QhojusQ8JFGMfpx8v9WfnyFAJcCEaZBrsU=;
	b=qpTX+8H+lQ1nexgTfB3CA+hCT/HhcytJ6liVxe3tFchfcEkm5u/SQYvb957sztDtHyfJpO62pauY71EIbs76jOaEzBvmRBOzV6wiGf7oA3oD8SrxrsqWu8aUew0bEU0t+iV+vRbSUQ73NEVUl1JjsFvjNv+8tj/6ORQWaTnOl2E=
Received: from 30.221.116.138(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WPveC6B_1740124525 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Feb 2025 15:55:26 +0800
Message-ID: <a02b09d9-8b95-354f-dade-67240200d4fc@linux.alibaba.com>
Date: Fri, 21 Feb 2025 15:55:24 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] RDMA/erdma: handle ib_umem_find_best_pgsz() return value
Content-Language: en-US
To: =?UTF-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
 <a.vatoropin@crpt.ru>, Kai Shen <kaishen@linux.alibaba.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Wei Yongjun <weiyongjun1@huawei.com>, Yang Li <yang.lee@linux.alibaba.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20250221070301.18010-1-a.vatoropin@crpt.ru>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20250221070301.18010-1-a.vatoropin@crpt.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/21/25 3:03 PM, Ваторопин Андрей wrote:
> From: Andrey Vatoropin <a.vatoropin@crpt.ru>
> 
> The ib_umem_find_best_pgsz function is necessary for obtaining the optimal
> hardware page size. In the comment above, function has statement: 
> "Drivers always supporting PAGE_SIZE or smaller will never see a 0 result."
> 
> But it's hard to prove this holds true for the erdma driver.
> 
> Similar to other drivers that use ib_umem_find_best_pgsz, it is essential 
> to add an error handler to manage potential error situations in the future.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 155055771704 ("RDMA/erdma: Add verbs implementation")
> Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
> ---
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
> index 51d619edb6c5..7ad38fb84661 100644
> --- a/drivers/infiniband/hw/erdma/erdma_verbs.c
> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
> @@ -781,6 +781,10 @@ static int get_mtt_entries(struct erdma_dev *dev, struct erdma_mem *mem,
>  	mem->page_size = ib_umem_find_best_pgsz(mem->umem, req_page_size, virt);
> +	if (!mem->page_size) {
> +		ret = -EINVAL;
> +		goto error_ret;
> +	}

Thanks,

I think ib_umem_find_best_pgsz won't fail in erdma, because we always set the corresponding bit
of PAGE_SIZE in the req_page_size, which can let ib_umem_find_best_pgsz find an answer at least.

If fixing it can make SVACE happy, I'm OK with this patch.

Acked-by: Cheng Xu <chengyou@linux.alibaba.com>

Regards,
Cheng Xu

>  	mem->page_offset = start & (mem->page_size - 1);
>  	mem->mtt_nents = ib_umem_num_dma_blocks(mem->umem, mem->page_size);
>  	mem->page_cnt = mem->mtt_nents;
>  	mem->mtt = erdma_create_mtt(dev, MTT_SIZE(mem->page_cnt),
>  				    force_continuous);

