Return-Path: <linux-rdma+bounces-14174-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ABBC28D24
	for <lists+linux-rdma@lfdr.de>; Sun, 02 Nov 2025 11:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C9C54E3497
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Nov 2025 10:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ECF1D5ABA;
	Sun,  2 Nov 2025 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0N5iF32"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB38C1F;
	Sun,  2 Nov 2025 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762078641; cv=none; b=RfEQ98CzFXP/XlVVEuwrpR8bgfPJuNewQTSdsLrv6AdZGh06FUhJf7rcfwzUrx8jJj9HEZ0JZAys8QE0dzdSs6t6FZdm35h8ITr+O6q+LpDWqhklL8/pf/tr/PLq/LxwOxa23BRttIChdUfMWUvvkAovGdRDII70jxjv7OF5Ooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762078641; c=relaxed/simple;
	bh=2astGPBTqePob/d8q9xvK33xSRSffAq1TL6qpck7WAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFW0TZjVK8uxGp9aZBfLIUQn3LTmAmBARoi2+PsSZ/ATkEvGy9m3lDcmXtqyoYAV0ixoL0uFn9JgDTJtf18SsKrgdY8hfywzgluSgf5ubT+deplNpnpB3b13V6qy+e5gtIsiRnrcHNbXkVKvlYDNaJ7JsDi48H1eGTzfECyQpJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0N5iF32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A812AC4CEF7;
	Sun,  2 Nov 2025 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762078640;
	bh=2astGPBTqePob/d8q9xvK33xSRSffAq1TL6qpck7WAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0N5iF32iZdt8/mJtoWR59MSKK8++7UQjQjnKLRW5GbVCmhC0erDTeTG/u4a9FIrt
	 xKfmUdQbUg4xUTCnHBMbFVSxQ+CPINfupN0Kytrf+Tbf7Ov44JZo/6pYMzMUV3qmlD
	 ZtMAoxS669sVgx8X539WZ8Kd4Uv+EHEjI2G8M2Bl/Bqg5TFBQ2t7mBvjyJvhHPPigN
	 rLLVnKlFgNUtqi44kO2GYhzt06w5seylnGbOCmdPsxqWUPA8oTWVDXWRfFS10crzfK
	 eNrrHYIzase/2PYr6Ck1yhlLAQXIf3COKz97T8r5erYt3VbsftSQ3EakcjvplBHf6t
	 3NG5N+fOGnU/w==
Date: Sun, 2 Nov 2025 12:17:14 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>
Subject: Re: [PATCH mlx5-next 1/2] PCI/TPH: Expose pcie_tph_get_st_table_loc()
Message-ID: <20251102101714.GA17533@unreal>
References: <20251027-st-direct-mode-v1-0-e0ad953866b6@nvidia.com>
 <20251027-st-direct-mode-v1-1-e0ad953866b6@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027-st-direct-mode-v1-1-e0ad953866b6@nvidia.com>

On Mon, Oct 27, 2025 at 11:34:01AM +0200, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@nvidia.com>
> 
> Expose pcie_tph_get_st_table_loc() to be used by drivers as will be done
> in the next patch from the series.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/pci/tph.c       | 7 ++++---
>  include/linux/pci-tph.h | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)

<...>

> -static u32 get_st_table_loc(struct pci_dev *pdev)
> +u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>  {
>  	u32 reg;
>  
> @@ -163,6 +163,7 @@ static u32 get_st_table_loc(struct pci_dev *pdev)
>  
>  	return FIELD_GET(PCI_TPH_CAP_LOC_MASK, reg);
>  }
> +EXPORT_SYMBOL(pcie_tph_get_st_table_loc);

Bjorn,

Are you ok with this change?

Thanks

