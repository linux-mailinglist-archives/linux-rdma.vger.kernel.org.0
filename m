Return-Path: <linux-rdma+bounces-10289-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C14AB302F
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 09:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BBCC189AF8C
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 07:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD582566D5;
	Mon, 12 May 2025 07:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LrRyrH4v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B422561B3
	for <linux-rdma@vger.kernel.org>; Mon, 12 May 2025 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747033211; cv=none; b=ioq0p1osDNtL5zRK5KbqcGsW0TzpNpADLWJ6hFuXyToUws1iLK2qBotOg82c/QsuA90Ixgl6gmpC2dwzPr/rj8Pn0imyh7E3MlgOFAlhFYUKXXK8TUSy5+5l5XqkN6r+A8QbFNpwBn+mwF3/5wcARfiGeeKy5fXHZCQBVx7pdaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747033211; c=relaxed/simple;
	bh=Bqq1A3Sa6qHoWnzKdhLS1uicwJ9gxYebr4/OhwLudB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZbKRJQugyX/YM9I+cpGeF2mAYU1WfAbktvhIQyVSbGOyba+gisaOIeASp+S4LAWk0dCPctoYH7wCb//8jRLqxKGy60DW+LfkXi8+KX9s9kQwqvg2HH5KQtyKsfRjLtt/MF6XEuPpFQT42EFEgaBQ8U1i628uxt5Mij4SyprJP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LrRyrH4v; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so41926385e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 12 May 2025 00:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747033206; x=1747638006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f9NnMsqvqzW4Dp+QMCFVbmE2fyembB/PnH3RgqpZhfQ=;
        b=LrRyrH4vsevmMD2hAXOiENfRTMFTaQxc0n6C9fRY3af7C0IDgC+FEXjaMpHyiTXg4d
         W3797QZ7ZhZGTQUlHFCG8JcqKmvpBE4n3MuaBizsSiArrI7NEju1PAp7PwXhqMECQ5w7
         mZzYfESREY/IAzPGDk5c0n40l/Vpin45AuhXFpDVTjbUUxcIy2hPNqGm0C6ATMathILL
         kvTKeOqckeehFzAbe8B3vY3zlH/TlOkGQ1rKlvG79xg70h1eq3m9/bxxnzwE4BVhQpe4
         S1WRjAWdXonNVqFUmJRXWq2nv+DqhZL0vjR91CpE4d4uuQcUOt7IIX74G81r66LV2oSG
         iyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747033206; x=1747638006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9NnMsqvqzW4Dp+QMCFVbmE2fyembB/PnH3RgqpZhfQ=;
        b=TkgycPfCofLdvOZSBFW6fj1oI7Zi3/DdVQT03OhyXZk4dKfmw6f38h15GwXzQRr525
         xkX1BBwEnbO1wPEt1b5WL3E5JXQJaMFAnOmODOWKoA64u7PvAlNDrwV9nHrb48B0cjjI
         xH7lzOFKfO7l+3VkMMkzvnKcr1g9A1Zh4GXLP7NbbZ9X5w87BP2gogzkN5AW4WceLprm
         0Yrvixhtj8HL5kxcDne8Bloy5t9dKg9i5HqeTEE9oUvVDL6OWdYOvFZ/BdxQFsF3HPOM
         nCwzImNewDlmquHmMvqnp1iz3GYGt3Ytppso6n/7ifIbEBrZTcerwxn3Bm90YkAydwvg
         Km2A==
X-Forwarded-Encrypted: i=1; AJvYcCWAr1syIIlE5aFBvXd3MPYXFq+JSOQgMjoLgIcef6kLWn7rYmq9/2tRTkDqoiiJPJ4cfjHrkOQIkg/w@vger.kernel.org
X-Gm-Message-State: AOJu0YxwT8eLBHf7PhxZ0TlfkEKbHIs/Nb1cSHCaNsqGXkAtfKYbBQnH
	4gcB17vIEJ26Nwu+JkZa6BsVYvihHiVzQjPcVKBKo4FX0BkQKujZngqBy3kIbA==
X-Gm-Gg: ASbGncuD0PzhIq44Rk5AUDs3FqS8EAv6iiOPB4iBUz/ogArD5CDWlUoU6aQI0aVNmxy
	Gby8gsg1lcksBktca9hVjP1JYhOugsu+9LOlVxact8uBmFpt8r5+WJU3xv9N/l92/J7sqMLosSc
	cvCPDXOWagGBk7cywdPeaC/FKw5nwyKwzGKh9wYVV8jlTAAqUTc40bAfTZpgfWepn+JXpKDNRJX
	DoBeCGsYDehp0JnadsgwWI/bVkYfbcrXC0PLDLFpr+TaX6MATb72ZzNbidsHvBGczDbVpxeIQqz
	S4M13Cj/Jxn5lTmtlQWa4kSKHeJ9k5tDNUnnRLtkObj4iecNy3ZH59Yuyj0CroLcdwAOdlXFyw=
	=
X-Google-Smtp-Source: AGHT+IF0taVe2Cjr6rPU4zVe3n0h7u5iibv2A6s+QVlkQE644yCZv4nsG7uDfUXl8mm25LJJmLR7mg==
X-Received: by 2002:a05:600c:511f:b0:43d:4686:5cfb with SMTP id 5b1f17b1804b1-442d6de2e97mr85863985e9.27.1747033206152;
        Mon, 12 May 2025 00:00:06 -0700 (PDT)
Received: from thinkpad ([130.93.163.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3aeb79sm157284445e9.27.2025.05.12.00.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 00:00:05 -0700 (PDT)
Date: Mon, 12 May 2025 12:30:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=EF=BF=BD~Dski?= <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Haiyang Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nipun Gupta <nipun.gupta@amd.com>, Yury Norov <yury.norov@gmail.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Cameron <Jonathan.Cameron@huwei.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Kevin Tian <kevin.tian@intel.com>, 
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Konstantin Taranov <kotaranov@microsoft.com>, 
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Erni Sri Satya Vennela <ernis@linux.microsoft.com>, 
	Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Paul Rosswurm <paulros@microsoft.com>, Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v3 2/4] PCI: hv: Allow dynamic MSI-X vector allocation
Message-ID: <plrpscito5e76t4dvtukgqm724stsfxim3zv3xqwnjewenee53@72dipu3yunlr>
References: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1746785602-4600-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1746785602-4600-1-git-send-email-shradhagupta@linux.microsoft.com>

On Fri, May 09, 2025 at 03:13:22AM -0700, Shradha Gupta wrote:
> Allow dynamic MSI-X vector allocation for pci_hyperv PCI controller
> by adding support for the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN and using
> pci_msix_prepare_desc() to prepare the MSI-X descriptors.
> 
> Feature support added for both x86 and ARM64
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  Changes in v3:
>  * Add arm64 support
> ---
>  Changes in v2:
>  * split the patch to keep changes in PCI and pci_hyperv controller
>    seperate
>  * replace strings "pci vectors" by "MSI-X vectors"
> ---
>  drivers/pci/controller/pci-hyperv.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index ac27bda5ba26..8c8882cb0ad2 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -598,7 +598,8 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
>  	return cfg->vector;
>  }
>  
> -#define hv_msi_prepare		pci_msi_prepare
> +#define hv_msi_prepare			pci_msi_prepare
> +#define hv_msix_prepare_desc		pci_msix_prepare_desc

Please do not use custom macro unless its defintion changes based on some
conditional. In this case, you should use pci_msix_prepare_desc directly for
prepare_desc() callback.

- Mani

--
மணிவண்ணன் சதாசிவம்

