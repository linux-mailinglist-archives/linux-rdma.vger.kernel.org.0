Return-Path: <linux-rdma+bounces-1974-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7878A9761
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Apr 2024 12:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CB31F237CD
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Apr 2024 10:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE1B15B993;
	Thu, 18 Apr 2024 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0UZVUnh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633B615AD88;
	Thu, 18 Apr 2024 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436121; cv=none; b=u/y09zwnMr93TFTNbIqilugd++MLkNIloYw/2bbJw2j+3IIwZFhSp43bsYJ27ySQ9Jnnh9lKBE661+xLZ6INYJwONLhfoWz1O8LhWOp6gED7dWRQ7kdMeer0wzo6ypdB7IBrKtHM7o7FfIwmfM4zM28+ItfHHwwPKafh+dtG1Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436121; c=relaxed/simple;
	bh=E7HNZEiU4nQt6IdXGx6tQYSSdGU7fkBugRG2RaCVSgw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pWnrLr/xmVU41oCMq7+0PjAww0s2dLccp9vSSm/EXyO2+DCIQbd++R92AmpIc4OtdKN261b9p15Uq27+3HfkOntPhrEAWTcdj1WcyUTxy743pWgzBE7SeK5+1BiKVR0M5rE5pzxm1/6ezdhpdUHDyBdnvsxKya+V5UP4Dp6BaHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0UZVUnh; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso9422271fa.0;
        Thu, 18 Apr 2024 03:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713436117; x=1714040917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rtbLebE67WL0AWOnzTi1FCXuJBT54tkis+j6KHxQOGE=;
        b=Y0UZVUnh8JS79avQXheyAvmgsmu0azw+QVoRtmgdu59HnORE5lqw+VkgcqN76PKvfi
         3751/ll34uXOaUKZEKj3j30n1eR0lK2y32ypaY20MwSNnnSov01w/KeVNX4bFDkplnP2
         5/c6/9nO6tSToy0SjbeucP1OpCzYekNFg8ebGF6Z/8LoWFYV7tta6AlqOwQM6pyNwpEM
         EdTDE54T8ZmgUvJ6QOEhdXEGNdhuTCUaURAN5dBd5k6JIomYGcrqnCR9wAYowdDuss2e
         lxegacxZxusTNdRq6OUHIhngeECwXfvFlrDgV5HiaqqNjkyAI5brJp7OBRTySheoR6o8
         eiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713436117; x=1714040917;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtbLebE67WL0AWOnzTi1FCXuJBT54tkis+j6KHxQOGE=;
        b=TECXt1QDtP9qzl4DbcldvipkjKpmGq99gFq5G6l+jN+S6lIlD/GeiOlXQ7aHzGnaME
         aznLjHI91+wUeF8SCM8ze5DAgPSl9+qKHJSpkOpqLHT73nf0ppU2GVC7COZ0O8diTdPY
         5GUzaRO1WV+dDNsX/EUFwQqpoLD7qkWvxLlQ4XfM2OY8T1ZoXDKfHJ7uSfLiQWh6AQS5
         eNJxcXxpkpRIp/JS4tCRvNP6iExbRItk3DhtR20C7cOyWPBELDOgIcK5w4xHnekkppWt
         HR3we2UUOyq7LTl+U7AkW168WB503Z2wqLZVcDkC7u7k6Jkw0Dq64n3uUrSuU700PeTv
         eyOA==
X-Forwarded-Encrypted: i=1; AJvYcCUvBmlhfhLD8EB/ptguSKwOBBPHnGu3vqblbLpR7XhLZ/Je2L89KXsXcPm2bQGZw/SfBoSDSnwE+SxdJpoQp1zzLlnxHGgxroyyyHq2
X-Gm-Message-State: AOJu0YyteAZtIYawBtPFHjNFiFu/c5RGWPBvmuMBmckDneLbZagIlS0U
	12RyhBkZqhHwnp7IgrZ1g0ANZjzGAcK/JlG6J9wHztpacfZQlT8h8MWthw==
X-Google-Smtp-Source: AGHT+IFVv7vf8mGGnCjtTVYEq77xaJsHORhEbOKzVh8FU87fiYglBz4S9OT56d+QC3bbb0zI7HoAmQ==
X-Received: by 2002:a2e:a4c6:0:b0:2d8:5e8b:7de4 with SMTP id p6-20020a2ea4c6000000b002d85e8b7de4mr1536128ljm.6.1713436117140;
        Thu, 18 Apr 2024 03:28:37 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c4f1000b00417f7ddd21dsm6077179wmq.37.2024.04.18.03.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 03:28:36 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <4865def4-8c34-4719-b505-ffb9914d8b6c@linux.dev>
Date: Thu, 18 Apr 2024 12:28:36 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next 2/2] RDMA/mana_ib: Implement get_dma_mr
To: Konstantin Taranov <kotaranov@linux.microsoft.com>,
 kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com,
 jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1713363659-30156-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713363659-30156-3-git-send-email-kotaranov@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1713363659-30156-3-git-send-email-kotaranov@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.04.24 16:20, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Implement allocation of DMA-mapped memory regions.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>   drivers/infiniband/hw/mana/device.c |  1 +
>   drivers/infiniband/hw/mana/mr.c     | 36 +++++++++++++++++++++++++++++
>   include/net/mana/gdma.h             |  5 ++++
>   3 files changed, 42 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
> index 6fa902ee80a6..043cef09f1c2 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -29,6 +29,7 @@ static const struct ib_device_ops mana_ib_dev_ops = {
>   	.destroy_rwq_ind_table = mana_ib_destroy_rwq_ind_table,
>   	.destroy_wq = mana_ib_destroy_wq,
>   	.disassociate_ucontext = mana_ib_disassociate_ucontext,
> +	.get_dma_mr = mana_ib_get_dma_mr,
>   	.get_port_immutable = mana_ib_get_port_immutable,
>   	.mmap = mana_ib_mmap,
>   	.modify_qp = mana_ib_modify_qp,
> diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
> index 4f13423ecdbd..7c9394926a18 100644
> --- a/drivers/infiniband/hw/mana/mr.c
> +++ b/drivers/infiniband/hw/mana/mr.c
> @@ -8,6 +8,8 @@
>   #define VALID_MR_FLAGS                                                         \
>   	(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_READ)
>   
> +#define VALID_DMA_MR_FLAGS IB_ACCESS_LOCAL_WRITE
> +
>   static enum gdma_mr_access_flags
>   mana_ib_verbs_to_gdma_access_flags(int access_flags)
>   {
> @@ -39,6 +41,8 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *dev, struct mana_ib_mr *mr,
>   	req.mr_type = mr_params->mr_type;
>   
>   	switch (mr_params->mr_type) {
> +	case GDMA_MR_TYPE_GPA:
> +		break;
>   	case GDMA_MR_TYPE_GVA:
>   		req.gva.dma_region_handle = mr_params->gva.dma_region_handle;
>   		req.gva.virtual_address = mr_params->gva.virtual_address;
> @@ -168,6 +172,38 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
>   	return ERR_PTR(err);
>   }
>   

Not sure if the following function needs comments or not.
If yes, the kernel doc 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/doc-guide/kernel-doc.rst?h=v6.9-rc4#n67 
can provide a good example.

Best Regards,
Zhu Yanjun

> +struct ib_mr *mana_ib_get_dma_mr(struct ib_pd *ibpd, int access_flags)
> +{
> +	struct mana_ib_pd *pd = container_of(ibpd, struct mana_ib_pd, ibpd);
> +	struct gdma_create_mr_params mr_params = {};
> +	struct ib_device *ibdev = ibpd->device;
> +	struct mana_ib_dev *dev;
> +	struct mana_ib_mr *mr;
> +	int err;
> +
> +	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
> +
> +	if (access_flags & ~VALID_DMA_MR_FLAGS)
> +		return ERR_PTR(-EINVAL);
> +
> +	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
> +	if (!mr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mr_params.pd_handle = pd->pd_handle;
> +	mr_params.mr_type = GDMA_MR_TYPE_GPA;
> +
> +	err = mana_ib_gd_create_mr(dev, mr, &mr_params);
> +	if (err)
> +		goto err_free;
> +
> +	return &mr->ibmr;
> +
> +err_free:
> +	kfree(mr);
> +	return ERR_PTR(err);
> +}
> +
>   int mana_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>   {
>   	struct mana_ib_mr *mr = container_of(ibmr, struct mana_ib_mr, ibmr);
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index 8d796a30ddde..dc19b5cb33a6 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -788,6 +788,11 @@ struct gdma_destory_pd_resp {
>   };/* HW DATA */
>   
>   enum gdma_mr_type {
> +	/*
> +	 * Guest Physical Address - MRs of this type allow access
> +	 * to any DMA-mapped memory using bus-logical address
> +	 */
> +	GDMA_MR_TYPE_GPA = 1,
>   	/* Guest Virtual Address - MRs of this type allow access
>   	 * to memory mapped by PTEs associated with this MR using a virtual
>   	 * address that is set up in the MST


