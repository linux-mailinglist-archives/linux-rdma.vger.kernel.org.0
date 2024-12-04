Return-Path: <linux-rdma+bounces-6235-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0F49E3C01
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 15:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B00281772
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18481F8F18;
	Wed,  4 Dec 2024 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuiaMpDY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616FF1F7599
	for <linux-rdma@vger.kernel.org>; Wed,  4 Dec 2024 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320992; cv=none; b=kYsMZDpFIUIJbV0uk8DNAk3s9ougdupcDIFLPuHqUOQkY2raqSfrsBqgLJ9y2OyB2aHBQs2fhVkvdZI7BvzkIWohT1SC7Ab5o2UcC3t9vTgd4rXaEpNnRMwCaBxpPu6bS6GAvMohYYg/Y24YuzZdMuOLcCPYsO5nFCzetM3QcMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320992; c=relaxed/simple;
	bh=VVfwlq3V2CC2dPNqKeNdOuAjqWrx355F7HHF1SYI3XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOnFanIqRzffdM67Xs55efRGBnRfjnpkEq0WSvnSb/g40AwUqV+5+1SbBMa5RNkZOm9OB1+j2Pp3LHlBBKZK/+j9F702NT3JanaHT/Dr7KqZzQ8HXXL75Kvr4T06TSMDlwV+4sqjy6D3k8rF9c22wX8fbJpvzrns92bisgBxDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuiaMpDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49005C4CECD;
	Wed,  4 Dec 2024 14:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733320991;
	bh=VVfwlq3V2CC2dPNqKeNdOuAjqWrx355F7HHF1SYI3XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VuiaMpDY9hAhQ/4XCyYXa7b27FPZbUFqPoaw+8WPKPDDRW53TwpIzZNhc5eEnLDIu
	 q1J11Zw4T8jDIzrTiPlFlz+7CrkDBgBpkR5a6/vh4+zC8Q4Q5GH2BekD9cqVwkmwtf
	 sEfg5zDJ7AFqOiMJUAgzMQiaG8rJp969afHM/Wbc3ycrDfvFri4FeGcyT2kY9aarku
	 j+vxEYOKSmU/VgV2jjiqdY/WMuTLPsXUqh0dH+vhz+YPh/u8BxlLtWR3juCSDCgEtx
	 QStG2b/8XdXxeWOmziWouSh7aprGWsr+nH0cpIO4eB1EMO0Zt4j1dXaEIZibqatLgZ
	 o/ucuT5/E0amA==
Date: Wed, 4 Dec 2024 16:03:07 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Boshi Yu <boshiyu@linux.alibaba.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: Re: [PATCH for-next 1/8] RDMA/erdma: Probe the erdma RoCEv2 device
Message-ID: <20241204140307.GO1245331@unreal>
References: <20241126070351.92787-1-boshiyu@linux.alibaba.com>
 <20241126070351.92787-2-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126070351.92787-2-boshiyu@linux.alibaba.com>

On Tue, Nov 26, 2024 at 02:59:07PM +0800, Boshi Yu wrote:
> Currently, the erdma driver supports both the iWARP and RoCEv2 protocols.
> The erdma driver reads the ERDMA_REGS_DEV_PROTO_REG register to identify
> the protocol used by the erdma device. Since each protocol requires
> different ib_device_ops, we introduce the erdma_device_ops_iwarp and
> erdma_device_ops_rocev2 for iWARP and RoCEv2 protocols, respectively.
> 
> Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/Kconfig       |  2 +-
>  drivers/infiniband/hw/erdma/erdma.h       |  3 +-
>  drivers/infiniband/hw/erdma/erdma_hw.h    |  7 ++++
>  drivers/infiniband/hw/erdma/erdma_main.c  | 47 ++++++++++++++++++-----
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 16 +++++++-
>  drivers/infiniband/hw/erdma/erdma_verbs.h | 12 ++++++
>  6 files changed, 75 insertions(+), 12 deletions(-)

<...>

> +++ b/drivers/infiniband/hw/erdma/erdma_main.c
> @@ -172,6 +172,12 @@ static int erdma_device_init(struct erdma_dev *dev, struct pci_dev *pdev)
>  {
>  	int ret;
>  
> +	dev->proto = erdma_reg_read32(dev, ERDMA_REGS_DEV_PROTO_REG);
> +	if (!erdma_device_iwarp(dev) && !erdma_device_rocev2(dev)) {

Why do you need this check? Your old driver which supports only iwarp
doesn't have this check, so why did you suddenly need it for roce? 

> +		dev_err(&pdev->dev, "Unsupported protocol: %d\n", dev->proto);
> +		return -ENODEV;
> +	}
> +

Thanks

