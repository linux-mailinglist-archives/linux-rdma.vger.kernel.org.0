Return-Path: <linux-rdma+bounces-5599-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131E99B4BAC
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2024 15:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C0F1C2359D
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2024 14:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3909220696B;
	Tue, 29 Oct 2024 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV2I8WTB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFE342A92
	for <linux-rdma@vger.kernel.org>; Tue, 29 Oct 2024 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210606; cv=none; b=Nyyil8YJdptlMYyLzD0wobxJ2n5Ragw/zeNq6xP35KnOuWWD0bsjkbrnLBcZeJxhu94mv2GOkgOCheNMiFsSre0r3tuVJojOyIjfAeUk2FxVH7r/E5Tn132pp7ic/m/9OUILq1byL+7F/2ehYc+8UDXnqdjV/5JOqezb8ohWoBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210606; c=relaxed/simple;
	bh=HjDV3NW5vu3h97mOzwdCPg2bLHW3z7iZeHzNonvryu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II/A4ZnlbwHEwzi47hop4WlGj+0dOLIWoiYSa9osnmoKFJJoJo+AjRcIen+XRQwHj4DlJOV3Mp45AJUYDAbdk190akPpGynvMFAjWTYEZwESo9kbGEeTDOLwHVuaDqajc1bpZKCULM6b92c3ALuUoEHDjcuRuXYBjM39xvYzsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV2I8WTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F285AC4CECD;
	Tue, 29 Oct 2024 14:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730210605;
	bh=HjDV3NW5vu3h97mOzwdCPg2bLHW3z7iZeHzNonvryu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GV2I8WTB7nBGJ+Wl+yuUSTo5hfOHF4xbAm6J58PQmYgAuZFF5Ouv95cX3iSNT2EWT
	 MqijtcTynwarrL9upxRJR8QkberQ/kJl88/h1/X9zoUrvJ7vhzuqLhuohll10fLr7D
	 O0Smr4KqJVPDk+9w3vVNRaDLiWNReOA87GL4Nqa8O+BoQVpqvXrQ+6hVw2rKo3cwPV
	 dzg2TOq8bC48rjfXmi/S9TwG1rcG8TkJjhaRsHxuy92Zup8ZKNgQaaWTq8djJGwt/1
	 bxD3scffMqu2HzMc3pfwxrIDq2ldSTUtJwdVaCgMtLMSGV9g2nyJpWZdj2jgDrgliC
	 PIMfn7/DWAYmw==
Date: Tue, 29 Oct 2024 16:03:19 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
	kashyap.desai@broadcom.com
Subject: Re: [PATCH for-next 1/4] RDMA/bnxt_re: Support driver specific data
 collection using rdma tool
Message-ID: <20241029140319.GN1615717@unreal>
References: <1729591916-29134-1-git-send-email-selvin.xavier@broadcom.com>
 <1729591916-29134-2-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729591916-29134-2-git-send-email-selvin.xavier@broadcom.com>

On Tue, Oct 22, 2024 at 03:11:53AM -0700, Selvin Xavier wrote:
> From: Kashyap Desai <kashyap.desai@broadcom.com>
> 
> Allow users to dump driver specific resource details when
> queried through rdma tool. This supports the driver data
> for QP, CQ, MR and SRQ.
> 
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 148 +++++++++++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index 6715c96..5bed9af 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -882,6 +882,146 @@ static const struct attribute_group bnxt_re_dev_attr_group = {
>  	.attrs = bnxt_re_attributes,
>  };
>  
> +static int bnxt_re_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr)
> +{
> +	struct bnxt_qplib_hwq *mr_hwq;
> +	struct nlattr *table_attr;
> +	struct bnxt_re_mr *mr;
> +
> +	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
> +	if (!table_attr)
> +		return -EMSGSIZE;
> +
> +	mr = container_of(ib_mr, struct bnxt_re_mr, ib_mr);
> +	mr_hwq = &mr->qplib_mr.hwq;
> +
> +	if (rdma_nl_put_driver_string(msg, "owner",
> +				      mr_hwq->is_user ?  "user" : "kernel"))

Two comments:
1. There is already a helper function to decide if owner is user or kernel - rdma_is_kernel_res().
2. This print duplicates existing information. The difference between
user and kernel can be easily seen by looking on the PID output.

> +		goto err;
> +	if (rdma_nl_put_driver_u32(msg, "page_size",
> +				   mr_hwq->qe_ppg * mr_hwq->element_size))
> +		goto err;
> +	if (rdma_nl_put_driver_u32(msg, "max_elements", mr_hwq->max_elements))
> +		goto err;
> +	if (rdma_nl_put_driver_u32(msg, "element_size", mr_hwq->element_size))
> +		goto err;
> +	if (rdma_nl_put_driver_u64_hex(msg, "hwq", (unsigned long)mr_hwq))
> +		goto err;
> +	if (rdma_nl_put_driver_u64_hex(msg, "va", mr->qplib_mr.va))
> +		goto err;

<...>

> +static int bnxt_re_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ib_qp)
> +{
> +	struct bnxt_qplib_qp *qplib_qp;
> +	struct nlattr *table_attr;
> +	struct bnxt_re_qp *qp;
> +
> +	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
> +	if (!table_attr)
> +		return -EMSGSIZE;
> +
> +	qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
> +	qplib_qp = &qp->qplib_qp;
> +
> +	if (rdma_nl_put_driver_string(msg, "owner",
> +				      ib_qp->uobject ?  "user" : "kernel"))
> +		goto err;
> +
> +	if (rdma_nl_put_driver_u32(msg, "sq_max_wqe", qplib_qp->sq.max_wqe))
> +		goto err;
> +	if (rdma_nl_put_driver_u32(msg, "sq_max_sge", qplib_qp->sq.max_sge))

Doesn't this information already exist in other places? devinfo?

Thanks

