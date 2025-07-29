Return-Path: <linux-rdma+bounces-12532-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABFCB15147
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 18:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB68718A0202
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 16:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408B927874A;
	Tue, 29 Jul 2025 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fLCFCaOe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4BA20ED
	for <linux-rdma@vger.kernel.org>; Tue, 29 Jul 2025 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806395; cv=none; b=SAdcLTk9mILib5YN4B90ANT+omwRy7VAw8FsVaKoOnbGh9MEgc3Wrhbtw8COdZQ8PmnvZuwQHyuxDYpZl3YfOD1DaEn1hW9ZVCGxzNLS912lH/Bgcib+BGejdDp3SwfAmcPf7HaiOt4rXGtfXdPDvjqXtTe+PTe3YuiyXwG6DTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806395; c=relaxed/simple;
	bh=x3VhJ2AskZqSuTuPfJY9mY8Y4Vp2tDodGTD3Uut1yAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKrX1c7SA0SVXWXd8YulKxt00GuQesVoAWvQ+bQIOJDKRROjrZ0LLfCsqgb9u07JYTMhPd5cXwcdnp/apOdvxJ/Bv3N0YwV33oon7Dv0PECnIZxYVDSSFwSE1gO+vGG1IdbD9QVPtnzqf9Sd6J5cV9T/kbApacbw4P/rnvRiUw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fLCFCaOe; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fd203f1c-c18d-458f-b1b0-924b8762fe4c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753806390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9xe3DsNIWQq/BST2UrlVzpUzPeVJ89nxKRtmM36Iw8=;
	b=fLCFCaOeQao4HvCajokKdsQe0hJ+F1ZunKClGbrBmlMA1Yxf4ZY/dCSKlNVgIPndlf7LLx
	prD7GDfLu6ht3YIFchgcx82lCbc0/CUzeKivtUXO6GikvAx3cAW5TfojdVPPhXepqBA63D
	iA+2A4spkTmDh93KHmyuu7PMCcMRsoA=
Date: Tue, 29 Jul 2025 09:26:14 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/hns: Fix querying wrong SCC context for DIP
 algorithm
To: Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, tangchengchang@huawei.com
References: <20250726075345.846957-1-huangjunxian6@hisilicon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250726075345.846957-1-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/26 0:53, Junxian Huang 写道:
> From: wenglianfa <wenglianfa@huawei.com>
> 
> When using DIP algorithm, all QPs establishing connections with
> the same destination IP share the same SCC, which is indexed by
> dip_idx, but dip_idx isn't necessarily equal to qpn. Therefore,
> dip_idx should be used to query SCC context instead of qpn.
> 
> Fixes: 124a9fbe43aa ("RDMA/hns: Append SCC context to the raw dump of QPC")
> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>

Replace qpn with sccn.
The term DIP algorithm typically refers to Deterministic IP, a selection 
algorithm used to pick a destination GID (Global Identifier) when 
multiple IP addresses are available.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 4 ++--
>   drivers/infiniband/hw/hns/hns_roce_restrack.c | 9 ++++++++-
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 64bca08f3f1a..244a4780d3a6 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -5476,7 +5476,7 @@ static int hns_roce_v2_query_srqc(struct hns_roce_dev *hr_dev, u32 srqn,
>   	return ret;
>   }
>   
> -static int hns_roce_v2_query_sccc(struct hns_roce_dev *hr_dev, u32 qpn,
> +static int hns_roce_v2_query_sccc(struct hns_roce_dev *hr_dev, u32 sccn,
>   				  void *buffer)
>   {
>   	struct hns_roce_v2_scc_context *context;
> @@ -5488,7 +5488,7 @@ static int hns_roce_v2_query_sccc(struct hns_roce_dev *hr_dev, u32 qpn,
>   		return PTR_ERR(mailbox);
>   
>   	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, HNS_ROCE_CMD_QUERY_SCCC,
> -				qpn);
> +				sccn);
>   	if (ret)
>   		goto out;
>   
> diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
> index f637b73b946e..230187dda6a0 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
> @@ -100,6 +100,7 @@ int hns_roce_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ib_qp)
>   		struct hns_roce_v2_qp_context qpc;
>   		struct hns_roce_v2_scc_context sccc;
>   	} context = {};
> +	u32 sccn = hr_qp->qpn;
>   	int ret;
>   
>   	if (!hr_dev->hw->query_qpc)
> @@ -116,7 +117,13 @@ int hns_roce_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ib_qp)
>   	    !hr_dev->hw->query_sccc)
>   		goto out;
>   
> -	ret = hr_dev->hw->query_sccc(hr_dev, hr_qp->qpn, &context.sccc);
> +	if (hr_qp->cong_type == CONG_TYPE_DIP) {
> +		if (!hr_qp->dip)
> +			goto out;
> +		sccn = hr_qp->dip->dip_idx;
> +	}
> +
> +	ret = hr_dev->hw->query_sccc(hr_dev, sccn, &context.sccc);
>   	if (ret)
>   		ibdev_warn_ratelimited(&hr_dev->ib_dev,
>   				       "failed to query SCCC, ret = %d.\n",


