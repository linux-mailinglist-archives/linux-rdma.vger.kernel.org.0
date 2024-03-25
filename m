Return-Path: <linux-rdma+bounces-1539-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F0B88A631
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 16:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4118F1C3B293
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361F156F39;
	Mon, 25 Mar 2024 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="meT28BSM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C8156669;
	Mon, 25 Mar 2024 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370102; cv=none; b=XAglHPtgYw7zVIkczpU+mgdKekhOE8zhrhbaitr74x6hHeuou6gqJVdGkrPfonSIUFAusoO5ybOvpe5WqSLnPNjhpyZXGMLJfibcxuu5tywB4d7u9g5xmpIm17varEJDoOVa6rx9aRvg8OXJV61FJp4omOKxM2xtsJUmRzH27dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370102; c=relaxed/simple;
	bh=6jzjiwrkhrrxiOb3ouQm9/gN7kt04YtLniYwKlTluek=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=fNfM/HWZmJj7ltEr1HJE6UgsiNfIqo0JE6qXgrBcXcS0v0EKO7jgXt++mfs0spP8COdCuCBuaNccHgBkSCfkxYnKKP8ANu6yQ8Cxo72xVO7P7ZmgoozUzGyyo/Sg6BgBQLR0Uma+pHPD08my6ZYTgTM728SsK5WtMbMAEzAh7m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=meT28BSM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711370100; x=1742906100;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=6jzjiwrkhrrxiOb3ouQm9/gN7kt04YtLniYwKlTluek=;
  b=meT28BSM18Q5CeqZIYtu9mWAq3MfHi6+rVVaqz1DPzkIq3liaJn3P1nk
   lVozH64N2x/0psEQgAfOFmvF3e+zH4/DTzZa5J5YU/rVSTzLrUfNefPTe
   dZVn1qfkyutYbO2Ki1kqY2fgWyxsSU9zzNEGyyHZAI8sMBo5yNoXu10lW
   Sm4T7w64g6350vGEibsVq1GtaPeTfFSM8fGikouNS7VRcsyhtbewvPC+G
   MeVcUrLnEMw2QsUeRaaFuFBxCM9x4MC/alv9yQ/Rk7DCnCEo37hTU6gJv
   BkyY4/xA0BUjxmkaXomk7MlO2Zg/X45Laz+QtIS39Gr2C2oBYiFku/oLM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="10139987"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="10139987"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:34:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="16268554"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:34:54 -0700
Message-ID: <3edd5823-bf54-4898-bcee-e1628c863388@linux.intel.com>
Date: Mon, 25 Mar 2024 13:34:51 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/28] sound: intel: Use PCI_IRQ_INTX
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
 <20240325070944.3600338-5-dlemoal@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240325070944.3600338-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/25/2024 8:09 AM, Damien Le Moal wrote:
> Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
> macro.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   sound/soc/intel/avs/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
> index d7f8940099ce..69818e4b43da 100644
> --- a/sound/soc/intel/avs/core.c
> +++ b/sound/soc/intel/avs/core.c
> @@ -343,7 +343,7 @@ static int avs_hdac_acquire_irq(struct avs_dev *adev)
>   	int ret;
>   
>   	/* request one and check that we only got one interrupt */
> -	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI | PCI_IRQ_LEGACY);
> +	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI | PCI_IRQ_INTX);
>   	if (ret != 1) {
>   		dev_err(adev->dev, "Failed to allocate IRQ vector: %d\n", ret);
>   		return ret;

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

