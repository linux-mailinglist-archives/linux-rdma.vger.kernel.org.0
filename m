Return-Path: <linux-rdma+bounces-10395-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2A6ABAED7
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 10:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A507ABD02
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 08:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947421DA617;
	Sun, 18 May 2025 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="g2v793On"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F9313790B
	for <linux-rdma@vger.kernel.org>; Sun, 18 May 2025 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747558629; cv=none; b=G+yXrKVoDioVaDxz73VF2GQEjBmrwlvHMHE6NmYZWYyUqPXHKdTGOqnA6UwH0tnNJq7laekY9pKL637EmGAPPIBRvKMmmARni0tn7Mon20wC85yntBYlILsm4pLbIYu0Rkf/NuAcFbw403GxxUaRgOPBDXxhdePOFoPhqkb//2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747558629; c=relaxed/simple;
	bh=nd9xB01d/7t5hWm0Oq1jSQ2MaYc+PSbGl4rNpfeoY2I=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fDPc7peFTp4oWakAeg0J2Tc+3nZLBPFTZVeJ1v7VI2+nfYMgmwQR79+HZ8Vjuv4HmrHpIPuo3L7c57wsyzgGP1O21wN3/DhUsxgYAxu3hUhCgpxBX5XZuSoOoQXmBj3i5nZlaRG6wCyStkUhIfBmz5rjnPh/qrJtXA3scMLJzmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=g2v793On; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747558628; x=1779094628;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=96zxc6yGic+SI+N1CxDcPP549xIkD+BfbbtHTqrWtQI=;
  b=g2v793OnrUyRsZ5phW+EobE+wbgu+kVYnowf1y0FWrOnH5aNlCkxqMzc
   aqd7RFFzAihUal+g1sJvhV3gz6L06TCdG6G+ZGiSwrWinvr41mBnv8VA/
   mcTDds5upcfcsSV4XH4g2J0ZVkMj6l3rF44COk/2cxwHEgwRaH0xvnXDa
   uuaiQp/oCJlrgBtUXlKSH1EfO9Vuu8XIdO8FrrbR/PnK5QWsjpdAvga3i
   RqxWTi8g4pj0jru19m/FxBfWooANjhVryWpx/h024zo7yZxL1DNIV14s8
   B20vzSQ28ZCuxM5NfC5a3L4m5cIm5DIxPCGc0fIzU341p69DWwJyDk/Vm
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,298,1739836800"; 
   d="scan'208";a="406477325"
Subject: Re: [PATCH for-next] RDMA/efa: Add CQ with external memory support
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 08:57:06 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:29675]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.70:2525] with esmtp (Farcaster)
 id afe79087-85b0-4111-9c15-d22561d775f4; Sun, 18 May 2025 08:57:05 +0000 (UTC)
X-Farcaster-Flow-ID: afe79087-85b0-4111-9c15-d22561d775f4
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 18 May 2025 08:57:05 +0000
Received: from [192.168.136.189] (10.85.143.179) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 18 May 2025 08:57:01 +0000
Message-ID: <985b77cc-63bb-4cf9-885e-c2d6aca95551@amazon.com>
Date: Sun, 18 May 2025 11:56:56 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>,
	<matua@amazon.com>, <gal.pressman@linux.dev>, Daniel Kranzdorf
	<dkkranzd@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
References: <20250515145040.6862-1-mrgolin@amazon.com>
 <20250518064241.GC7435@unreal>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20250518064241.GC7435@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 5/18/2025 9:42 AM, Leon Romanovsky wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Thu, May 15, 2025 at 02:50:40PM +0000, Michael Margolin wrote:
>> Add an option to create CQ using external memory instead of allocating
>> in the driver. The memory can be passed from userspace by dmabuf fd and
>> an offset.
> EFA is unique here. This patch is missing description of why it is
> needed, and why existing solutions if any exist, can't be used.
>
> Thanks

I probably should have explained more, the purpose is creating CQs that 
reside in GPU HBM enabling low latency polling directly by the GPU. EFA 
isn't unique in receiving pre-allocated memory from userspace, the 
extension here is the use of dmabuf for that purpose as a general 
mechanism that allows using memory independent of its source. I will add 
more info in the commit message.

Michael


