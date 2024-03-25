Return-Path: <linux-rdma+bounces-1540-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E910A88A6AA
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 16:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267D01C3A5BB
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 15:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B3480C15;
	Mon, 25 Mar 2024 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJUAlXLp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4378062E;
	Mon, 25 Mar 2024 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371435; cv=none; b=F3JGkS5CzXamA33+Bk4EwxeG2K/FgMd6uwm/vKUn/6O6V9XJVzRu79PV0jyh5UR9dojTkXk7dK0HeCoMDbQBexuBx3HooIgQjxumXrWUnjE9gw4cnZ7WzYzPu/Q9H1lM4Vps3wx7vOtglMx14Xf8O4z2Hd+RvQWx8/AYF9RJ9ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371435; c=relaxed/simple;
	bh=HUjKdQlxom6P1m/TBqTuw6g6vhOkoQNgKeUZCY9XFh8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=S0PfVWyk1RENFfnj21UUcFJPW2TPp5oSIdVFOrZNqxWYVsrS0PMWLa/VwP82Oa2jDH5IVoupmvyDf5faQnruJHAtDxKCPKTeYzrYj8RJKRU95yaNPoxw1ShK0spEJSi/TwV4cSCn+jJv4PiNYetdl0UL+sI5bCPcqbHHJLt7rOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJUAlXLp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711371433; x=1742907433;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=HUjKdQlxom6P1m/TBqTuw6g6vhOkoQNgKeUZCY9XFh8=;
  b=jJUAlXLpNmQvj1sPQuPkQIAXYKr5zeC4VNVj9Ux1TwLOuSS6Esa4zLz0
   zgEgwo/w7ayto416WoD4OWjK28R7LT3nFHmJB7mXhtz2SNx2K6kC31p5U
   zokP/yHr2iFMo8fP2ftyk69TN7iXUPRNKur3Pl4oRglfGoFbJk2NkgTbk
   Ld2SM0WM8n9T8n6b6LhtlenvoYlxARr3y8LdMlr/xjKFEJKKy7U7aIPV4
   HzXWu0erfWuIPcR0FYP8eDfZMhh9gvMfeAgGO4ZztPpozZ/+GYo7IYEVU
   z6kr/vMDhaX+uJedxYk8whHWDGx1fO1YooHU9R81QnU+gbr0aY4OV5LA3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6552944"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6552944"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:57:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="15637244"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:57:06 -0700
Message-ID: <b99a99be-d5f3-4e7a-a83a-e29722cd79dc@linux.intel.com>
Date: Mon, 25 Mar 2024 13:57:04 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/28] sound: intel: Use PCI_IRQ_INTX
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
References: <20240325070944.3600338-1-dlemoal@kernel.org>
 <20240325070944.3600338-5-dlemoal@kernel.org>
 <3edd5823-bf54-4898-bcee-e1628c863388@linux.intel.com>
Content-Language: en-US
In-Reply-To: <3edd5823-bf54-4898-bcee-e1628c863388@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/25/2024 1:34 PM, Amadeusz Sławiński wrote:
> On 3/25/2024 8:09 AM, Damien Le Moal wrote:
>> Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
>> macro.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>   sound/soc/intel/avs/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
>> index d7f8940099ce..69818e4b43da 100644
>> --- a/sound/soc/intel/avs/core.c
>> +++ b/sound/soc/intel/avs/core.c
>> @@ -343,7 +343,7 @@ static int avs_hdac_acquire_irq(struct avs_dev *adev)
>>       int ret;
>>       /* request one and check that we only got one interrupt */
>> -    ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI | 
>> PCI_IRQ_LEGACY);
>> +    ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI | PCI_IRQ_INTX);
>>       if (ret != 1) {
>>           dev_err(adev->dev, "Failed to allocate IRQ vector: %d\n", ret);
>>           return ret;
> 
> Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

Sorry, one more thing, can you adjust commit title to:
ASoC: Intel: avs: Use PCI_IRQ_INTX

and with that, you can add above Reviewed-by:

Thanks!

