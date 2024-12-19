Return-Path: <linux-rdma+bounces-6640-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C179F7403
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 06:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912D216BA89
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 05:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B48B1F9EB9;
	Thu, 19 Dec 2024 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EZolTLpq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E087C1F76D3;
	Thu, 19 Dec 2024 05:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734586863; cv=none; b=V5ssxQqAG6FRBLoNXLi0UeZebnMmPZ3kRxKIqiQi6fU9jRGCOgfdAvwtvhmQvVyjj3ccUNvMF2xLexEDZyRKDLwjMNVSCAK73M96GX8cvSyjWN+fY1TXMhBDvy/0OHUSbaKobJ2eUpkeP8jnRf9zlRyB1AlMBfHW+Qm16ZbuTPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734586863; c=relaxed/simple;
	bh=Nto3EIZHm2iwdR598DbKz8jnsNCBbWAlg7kYdWJTNzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U29AZ1K5s590bGX88jynuYF9/4xlDWDP88Vzvht7uHJzelXAK7KhiNYQ3+/ATJ6bea/YTOXLuZyY69Z3ybnfRghcbRBHGP4w6oDK/+jCjSZnNjRvjAFlQNiLTo778uf6Ay06D18S1YMQ10dKrW5rpixP2DVa3it196NuKuzLhu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EZolTLpq; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734586852; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=x+I441/A3ta+QB1Uxgje5G0ivlgNC+T1jucSw4QM6is=;
	b=EZolTLpqja/6wrknRp33P6Rr2ZNXMN2lTt65LwzA+cihgdBSFDj5FuqYENpqe5nSO4753llKlkCFcS5wCFEVXJ887rxGD8pSq8UHK3X2cNigWh+PWYa90QwXszEgAZCT1MTIR6Fj8EdGt6eyKG97vXuCZ2DRja+tvbH5ojaK8hY=
Received: from 30.221.116.255(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WLp57Zf_1734586850 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Dec 2024 13:40:51 +0800
Message-ID: <37815931-4b7d-35af-fde4-9f3007ee99d9@linux.alibaba.com>
Date: Thu, 19 Dec 2024 13:40:50 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH-next] RDMA/erdma: Fix opcode conditional check
Content-Language: en-US
To: Advait Dhamorikar <advaitdhamorikar@gmail.com>,
 Kai Shen <kaishen@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241219043939.10344-1-advaitdhamorikar@gmail.com>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20241219043939.10344-1-advaitdhamorikar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/19/24 12:39 PM, Advait Dhamorikar wrote:
> Fix conditional if else check by checking with wr->opcode.
> The indicated dead code may have performed some action; that
> action will never occur as op is pre-assigned a different value.
> 
> Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>

Thanks very much,
Cheng Xu

> diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
> index 4dfb4272ad86..5c266918fb36 100644
> --- a/drivers/infiniband/hw/erdma/erdma_qp.c
> +++ b/drivers/infiniband/hw/erdma/erdma_qp.c
> @@ -406,7 +406,7 @@ static void init_send_sqe_rc(struct erdma_qp *qp, struct erdma_send_sqe_rc *sqe,
>  	if (wr->opcode == IB_WR_SEND_WITH_IMM) {
>  		op = ERDMA_OP_SEND_WITH_IMM;
>  		sqe->imm_data = wr->ex.imm_data;
> -	} else if (op == IB_WR_SEND_WITH_INV) {
> +	} else if (wr->opcode == IB_WR_SEND_WITH_INV) {
>  		op = ERDMA_OP_SEND_WITH_INV;
>  		sqe->invalid_stag = cpu_to_le32(wr->ex.invalidate_rkey);
>  	}

