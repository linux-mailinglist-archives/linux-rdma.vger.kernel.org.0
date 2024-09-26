Return-Path: <linux-rdma+bounces-5118-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F55A9879F9
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2024 22:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6C37B24AE2
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2024 20:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E78117C233;
	Thu, 26 Sep 2024 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="G8dPWBgY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ADC17BB33
	for <linux-rdma@vger.kernel.org>; Thu, 26 Sep 2024 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727381052; cv=none; b=tmgOz7yHCVwjyU9/07Lldrogbcey3nkc09huA6fE+7qeyvk+dK1p/KQHLHkNCRtw/jBlGKENoKpS5+BYE1Cniec52YM8lZSqQs+YlowbC1MLzUWeD3Htw7gZDSP02GgvrybS1DUMEXz/QsK0hlOJIYw/t91kiMEIyjYvYoCL9m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727381052; c=relaxed/simple;
	bh=RlXNggeuRvIx7uKsn+nCjTpTHr+U3dx/RtOxLHcDckE=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dq1j24ohECzuNOEtaBINHn9jjI1tZFimjxPlHaFm2QoAaPuutpyfsFjD+cN7cyYHUhqCV93/GCPHubBhiwuTa2Aa9YEwFCDrp4m+7RHHAA/aHkrBF4cWXJmeZXPAxSOzf80dmyeDCTHQBJ86vNEC164xAzkJnFVtLCaiYa/6Yok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=G8dPWBgY; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727381050; x=1758917050;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=UOEYipGuXHHE/dCJ1ShgS5XNI5ffr1hxT6VP7H2atM8=;
  b=G8dPWBgYy/4b3nbhqheSD2p4LwkaEYKUYhysNsWzWpjgeBbDjw+756lw
   8/sAQQPmIO9wgP6pcf5tS4DdvUKHY3sv9CrmadMgJUXYzOYPTIR3Np/55
   1s5X0iStXyn0QBQP6x5UCpnpgS2p9ujHcDFzbDsUyN1zC7gE9UWKd1YLi
   U=;
X-IronPort-AV: E=Sophos;i="6.11,156,1725321600"; 
   d="scan'208";a="130557086"
Subject: Re: [PATCH] RDMA/efa: Fix node guid compiler warning
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 20:04:08 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:17160]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.41.159:2525] with esmtp (Farcaster)
 id e8b10e3e-09f7-47cf-8d72-acbe6dd18a05; Thu, 26 Sep 2024 20:04:07 +0000 (UTC)
X-Farcaster-Flow-ID: e8b10e3e-09f7-47cf-8d72-acbe6dd18a05
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 26 Sep 2024 20:04:07 +0000
Received: from [192.168.146.133] (10.85.143.177) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 26 Sep 2024 20:04:03 +0000
Message-ID: <08cf6d96-02f0-4974-ac69-b9a5184bfb20@amazon.com>
Date: Thu, 26 Sep 2024 23:03:57 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>,
	<matua@amazon.com>, <gal.pressman@linux.dev>, kernel test robot
	<lkp@intel.com>, Yehuda Yitschak <yehuday@amazon.com>, Yonatan Nachum
	<ynachum@amazon.com>
References: <20240924121603.16006-1-mrgolin@amazon.com>
 <20240924180030.GM9417@nvidia.com>
 <7aa4bf5b-17aa-474a-b6c5-c4b0600f30a3@amazon.com>
 <0aa53dd7-7650-4d53-b942-00903e41dd9e@amazon.com>
 <20240926145423.GB9417@nvidia.com>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20240926145423.GB9417@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 9/26/2024 5:54 PM, Jason Gunthorpe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Thu, Sep 26, 2024 at 04:25:19PM +0300, Margolin, Michael wrote:
>
>> Actually that's wrong, the device always sets guid in BE order so no
>> swap is needed in the driver in any case.
> They you just mark it as _be64 in the struct and there is no reason
> for the __force ?
>
> Jason

That's probably the most correct way but I prefer to avoid introducing 
kernel specific types in a shared interface file.

Michael


