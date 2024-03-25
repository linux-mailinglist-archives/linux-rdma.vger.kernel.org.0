Return-Path: <linux-rdma+bounces-1543-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A685288AB0F
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 18:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9021F6793B
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 17:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D0A145327;
	Mon, 25 Mar 2024 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqANflu9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE23D6B;
	Mon, 25 Mar 2024 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381936; cv=none; b=Pfm3Jx1A9b3NMMuu1EmwubFN3OQnsB+QnFF1ttFp/UtGnZn0PFJhqYHBFC72axlyzfMGsyOaLZUEgNB7Vhrr0zAubMOowFdW5HgYPswUj5lVnGm+UK7XgDtRTMHMlJUOPHuc+nqLefzf2w/lH8XBlDAa71B+wbPtPWWF+YenDXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381936; c=relaxed/simple;
	bh=fyAjDgoqd4EtYQ6Hpyn+LEaIAbDw9+d9HFYSRYIDhfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=scD1/oVH1XkCBUyowjmXY8v2TA1+ye2W/TBbgQeS5wRXA3NPQq6AD8gGwM4ng57iBS0VOfhOo9TxcMBAtxUVf1rKjUG90kYXGUVaChSxI/KMvgD4KWSaLyvajhCVThZ09q/XWWoPnOYanKo92sHGtbDeHmMo3wfW87PD3CIsu94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqANflu9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711381935; x=1742917935;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=fyAjDgoqd4EtYQ6Hpyn+LEaIAbDw9+d9HFYSRYIDhfg=;
  b=HqANflu90wEUJFuLOUclPd6zT6l8Asjb4rw+SdfyKizTMr+9tct7cgSq
   ec3tEmRz01lXOKP54Exk+pPrHr7dfosg1vphOeQJNtSs7laIyGvPme8v8
   WA/yGXjBCLZZSAC6+g5hPJH+exalQAHms39vBz7Neasy5MM5MkV6syxnP
   Zl3m9CH1ijcU2Y274sVM84ABGvX8O/g6j9YdLH9/KGHUv0WKlmiJhCWYF
   aBP05PgLTa76q9ee1sztB7Yo4gt4LuNugc4kuD+UDA+zZ5DiuG3c9me89
   DMIM7wC+Ed0F+AgpwQkJlw4SDd2oNBJP0I01kpVNljAyQCbcFfGAiXoCg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6254355"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6254355"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:52:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="15636553"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.51.103]) ([10.212.51.103])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:52:12 -0700
Message-ID: <37fcc27a-7c6b-4aed-88be-92aadfaa67fe@intel.com>
Date: Mon, 25 Mar 2024 08:52:11 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/28] ntb: Use PCI_IRQ_INTX
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-sound@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, ntb@lists.linux.dev,
 Lee Jones <lee@kernel.org>, David Airlie <airlied@gmail.com>,
 amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240325070944.3600338-1-dlemoal@kernel.org>
 <20240325070944.3600338-9-dlemoal@kernel.org>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240325070944.3600338-9-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/25/24 12:09 AM, Damien Le Moal wrote:
> Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
> macro.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 48823b53ede3..48dfb1a69a77 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2129,7 +2129,7 @@ static int idt_init_isr(struct idt_ntb_dev *ndev)
>  	int ret;
>  
>  	/* Allocate just one interrupt vector for the ISR */
> -	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI | PCI_IRQ_LEGACY);
> +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI | PCI_IRQ_INTX);
>  	if (ret != 1) {
>  		dev_err(&pdev->dev, "Failed to allocate IRQ vector");
>  		return ret;

