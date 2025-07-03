Return-Path: <linux-rdma+bounces-11867-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F43AF73F5
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 14:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CA91C23A14
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 12:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB9D299A94;
	Thu,  3 Jul 2025 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="A+v7jTah"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADAD2F42
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545270; cv=none; b=hfrwsVvdcwazx6pfPCPFIGVnKV1AQt+6pTL1UNjTNmlgMS8OmWHrG9IET3NF+HLcj8KSve1swcz25ogwNcorfaP6RBenY+rARzSp6OR4A4iore237H5Txb3iUrYdulN6W9d+NTCmUV8ngG22nWp/XelRrdT8T8UmGNdrwt/OKN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545270; c=relaxed/simple;
	bh=plNRRfepUxCKBpEREYAuzDZHIj+eMC7isU+HWM9vRUA=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iMxcaGGOt9v5GWfnacuWidvT3zX5CfDnDIBWPELDjiPKL6zZfolEE0qsEQ92iAucoVwUMcX72RY+FAUozEropw70x9YDQLnr7JccFhMli0hY/4HsBtB9iZQjKGrMe/dweiQb3Fscn90cZMo3TBsPqI9f47OmaAREDWyZLMz+f4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=A+v7jTah; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1751545269; x=1783081269;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=plNRRfepUxCKBpEREYAuzDZHIj+eMC7isU+HWM9vRUA=;
  b=A+v7jTahc8qGPVmfyipqWeaDB9AjqyOS5bjgl2S8qw8LebsI5Pp+Pc8E
   DQKmj3F1/NDiiTMZ1NM4IORi+G322z0RFzRO4glxdGKgKm7qYxVa/F9Zh
   MoEheNTiopDsnq35WnDwwc++FEoKHqJwjeoOCvmDePDVtFVVZkxjCFheJ
   ysFeGYzKbXMer0GDVkiXFbSqxwYA4ERsiqhfbiyitHwhBEiaYLWONeoUc
   wR8D1oBlKNTsJkuKX3jwnBGwy/US35EGKR8KpRlFi5uHdKUIahvTHlyKt
   8HjOEUqnh0QeWVXmuw6H4BAk651X9ZWzTR4YkPdHVydCYOk6nObIejtMl
   A==;
X-IronPort-AV: E=Sophos;i="6.16,284,1744070400"; 
   d="scan'208";a="507509298"
Subject: Re: [PATCH for-next] RDMA/efa: Extend admin timeout error print
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 12:21:05 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:7034]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.23.111:2525] with esmtp (Farcaster)
 id 6db36715-1c90-4426-b719-aeb9fc660d94; Thu, 3 Jul 2025 12:21:03 +0000 (UTC)
X-Farcaster-Flow-ID: 6db36715-1c90-4426-b719-aeb9fc660d94
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 3 Jul 2025 12:21:03 +0000
Received: from [192.168.138.241] (10.85.143.179) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 3 Jul 2025 12:20:59 +0000
Message-ID: <73bc57f6-a791-4852-9fde-b82021e98372@amazon.com>
Date: Thu, 3 Jul 2025 15:20:53 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gal Pressman <gal.pressman@linux.dev>, <jgg@nvidia.com>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, Yonatan Nachum
	<ynachum@amazon.com>
References: <20250702152028.2812-1-mrgolin@amazon.com>
 <bdbb1205-d940-434a-a102-b233562a1429@linux.dev>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <bdbb1205-d940-434a-a102-b233562a1429@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 7/3/2025 9:46 AM, Gal Pressman wrote:
> Arguably, there is no point in keeping the comp_ctx pointer print, as
> you have nothing to compare the hashed pointer to. It could've been
> useful if the pointer was also printed when the command is submitted,
> but it isn't, so it's probably better to just remove it and keep the
> index you added.
>
> A better alternative might be storing the cmd_id inside the comp_ctx and
> printing it instead, it contains more information.

Nice idea, doing that. Thanks.

Michael


