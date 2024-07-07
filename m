Return-Path: <linux-rdma+bounces-3690-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E35929745
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 11:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C56B20F65
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DF912E55;
	Sun,  7 Jul 2024 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qDeuBVsf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE0A11723
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jul 2024 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720343833; cv=none; b=pM3LR8nhihotKx1C0K5XkGLMN4598j7suzvxDCNR4PCBBx/X1w84yjd0oPNIJ5uyr8DxbSnnjbcZrD4q8AzfXVtOXRX41nronmg3CGooAQ9RVFqPEfbfZHsHj1E65F8uhJoHc7bc24wo+IXpW4PAoulzq7Lahb3p+Yd26OcOfiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720343833; c=relaxed/simple;
	bh=i9A5/UxGvHu1veJV8OtUZgGhU7f0g4IPHdUuahBuNrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PevigKzhoi363F6W6L4kIcxwevFdtVAM/lk9N9ijj+8T8DlRgrlWlqICxceUGH7Tx59LA4l2birQnlqO14v2YBxp7f5hmjTROHJklWujDGxzGrlcHq5ydreFh7Y4jh9IX1523uO8Dol2pxKNI45UPyki7mEpItpPMuv9Z/Xw/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qDeuBVsf; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: huangjunxian6@hisilicon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720343828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EzpCkoTNLUC6dG4hG5P0jPKzpgKo4XXg0U8ChRJ7clw=;
	b=qDeuBVsf9HBmMBPr/mIDaz+6QfWH7CFfc6Ly2M4G/UVn6I8V6GcszeRbRFVmQvebuES6GA
	s7z4CtxfzX9pF1wJams9dInKHbjuQzVPXep5jDhvnrhUDccu7UaRo8eam26HZXgt4VRMwX
	5wGSTu+rcwHKQr5WsvJfvPNwuLY9yKE=
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: leon@kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: linuxarm@huawei.com
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <eba4bfaf-5986-489b-9ae5-8f5618501290@linux.dev>
Date: Sun, 7 Jul 2024 17:16:59 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-rc 5/9] RDMA/hns: Fix missing pagesize and alignment
 check in FRMR
To: Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org
References: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
 <20240705085937.1644229-6-huangjunxian6@hisilicon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240705085937.1644229-6-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/7/5 16:59, Junxian Huang 写道:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> The offset requires 128B alignment and the page size ranges from
> 4K to 128M.
> 
> Fixes: 68a997c5d28c ("RDMA/hns: Add FRMR support for hip08")

https://patchwork.kernel.org/project/linux-rdma/patch/2eee7e35-504e-4f2a-a364-527e90669108@CMEXHTCAS1.ad.emulex.com/
In the above link, from Bart, it seems that FRMR is renamed to FRWR.
"
There are already a few drivers upstream in which the fast register
memory region work request is abbreviated as FRWR. Please consider
renaming FRMR into FRWR in order to avoid confusion and in order to
make it easier to find related code with grep in the kernel tree.
"

So is it possible to rename FRMR to FRWR?

> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>   drivers/infiniband/hw/hns/hns_roce_device.h | 4 ++++
>   drivers/infiniband/hw/hns/hns_roce_mr.c     | 5 +++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 5a2445f357ab..15b3b978a601 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -83,6 +83,7 @@
>   #define MR_TYPE_DMA				0x03
>   
>   #define HNS_ROCE_FRMR_MAX_PA			512
> +#define HNS_ROCE_FRMR_ALIGN_SIZE		128
>   
>   #define PKEY_ID					0xffff
>   #define NODE_DESC_SIZE				64
> @@ -189,6 +190,9 @@ enum {
>   #define HNS_HW_PAGE_SHIFT			12
>   #define HNS_HW_PAGE_SIZE			(1 << HNS_HW_PAGE_SHIFT)
>   
> +#define HNS_HW_MAX_PAGE_SHIFT			27
> +#define HNS_HW_MAX_PAGE_SIZE			(1 << HNS_HW_MAX_PAGE_SHIFT)
> +
>   struct hns_roce_uar {
>   	u64		pfn;
>   	unsigned long	index;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> index 1a61dceb3319..846da8c78b8b 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> @@ -443,6 +443,11 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>   	struct hns_roce_mtr *mtr = &mr->pbl_mtr;
>   	int ret, sg_num = 0;
>   
> +	if (!IS_ALIGNED(*sg_offset, HNS_ROCE_FRMR_ALIGN_SIZE) ||
> +	    ibmr->page_size < HNS_HW_PAGE_SIZE ||
> +	    ibmr->page_size > HNS_HW_MAX_PAGE_SIZE)
> +		return sg_num;
> +
>   	mr->npages = 0;
>   	mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
>   				 sizeof(dma_addr_t), GFP_KERNEL);


