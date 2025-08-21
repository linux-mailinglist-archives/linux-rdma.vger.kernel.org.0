Return-Path: <linux-rdma+bounces-12854-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D43B2F3ED
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 11:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A47164163
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 09:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26792EFD90;
	Thu, 21 Aug 2025 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ixQnr5sM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D82F1FEB;
	Thu, 21 Aug 2025 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768383; cv=none; b=qZC5KT6DrTpgESJP+XEw0o0nTQxdIi/L1pHH67oIyzfL6/18hQJpp4vLZiUKDBBuAfWV/hLXs7THx+BeO7B+Rbl9KGn2v1cqrQB81mbvOstWYgFpxpNFOtubFmO5Fbf59mnkaReEPm7uUhp95w18nWd47MYaVO+i8NSVzR89HmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768383; c=relaxed/simple;
	bh=0Yz6pkIFcToOCZztAf8Vm4vvQOU8Nn9k9Tki6XA3csA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLzivyMvK9igHlzAwbmWju0Nevud8f66H2f75Dl0NsnjpQukyz8P+0Md6LulbKxjYL7DwgdEHleWTuDJMCO6rvIa5h6+BkU86NoeI4i2lRwAVdjJCIPUpE8u2yvpbkq6JnZcgQnWlcoLfr2Ne2OAtl8OaW9QbOtfT39Tb11aftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ixQnr5sM; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755768372; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YT0No5sUM1cts6WMJicqOCsJpqe2idZjE5DEkCBK7/s=;
	b=ixQnr5sMSBJJmmdTrP1Xpamne4KZJOm0pQn9cuosT8dnwXc6bKYPcSs9O7bnlh25hAAwezpxqEmTRZhST8vzPWqTH09DOfs71G2Y0dGWzSnZvaKuuBChsTALkh6GN6vcONPzsqoEX04/DAhtHexm2tJNFhHxhSyFHPC1ci0uaKU=
Received: from 30.221.115.63(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WmFdo7C_1755768371 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Aug 2025 17:26:11 +0800
Message-ID: <4dbdf24b-f725-e194-f1ec-f1510759a24c@linux.alibaba.com>
Date: Thu, 21 Aug 2025 17:26:10 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] RDMA/erdma: Use vcalloc() instead of vzalloc()
Content-Language: en-US
To: Qianfeng Rong <rongqianfeng@vivo.com>,
 Kai Shen <kaishen@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Markus.Elfring@web.de
References: <20250821072209.510348-1-rongqianfeng@vivo.com>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20250821072209.510348-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/21/25 3:22 PM, Qianfeng Rong wrote:
> Replace vzalloc() with vcalloc() in vmalloc_to_dma_addrs().  As noted
> in the kernel documentation [1], open-coded multiplication in allocator
> arguments is discouraged because it can lead to integer overflow.
> 
> Use vcalloc() to gain built-in overflow protection, making memory
> allocation safer when calculating allocation size compared to explicit
> multiplication.
> 
> [1]: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
> v2: change sizeof(dma_addr_t) to sizeof(*pg_dma) to improve code
>     robustness as suggested by Markus.
> ---
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks.

Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>

> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
> index 996860f49b2f..109a3f3de911 100644
> --- a/drivers/infiniband/hw/erdma/erdma_verbs.c
> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
> @@ -671,7 +671,7 @@ static u32 vmalloc_to_dma_addrs(struct erdma_dev *dev, dma_addr_t **dma_addrs,
>  
>  	npages = (PAGE_ALIGN((u64)buf + len) - PAGE_ALIGN_DOWN((u64)buf)) >>
>  		 PAGE_SHIFT;
> -	pg_dma = vzalloc(npages * sizeof(dma_addr_t));
> +	pg_dma = vcalloc(npages, sizeof(*pg_dma));
>  	if (!pg_dma)
>  		return 0;
>  

