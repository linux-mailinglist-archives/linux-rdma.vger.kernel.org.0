Return-Path: <linux-rdma+bounces-2076-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEAE8B276F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 19:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F52B249AC
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3DA14EC78;
	Thu, 25 Apr 2024 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t84GgkJb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EF214E2F8
	for <linux-rdma@vger.kernel.org>; Thu, 25 Apr 2024 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065330; cv=none; b=aRHRuFgn7DAfymgcClhYzevA6HGKhw1TKJQp3qc+7AZ0h55Ay0WIXLA2kSQxwRThcj3qr8iMEUQv/lj+rOCmukw/ptJ4zoBwAcU+D6cUY+MBV2SkXDYDxTYo5WjMNPYBKZrnfxqVIZys1nVUvoETW7rZ4UVbZbehTAaPz+ctTTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065330; c=relaxed/simple;
	bh=iMKBbXfeOAJ31vjCGbDiXRscheCUEbSsf4289g8Ti+8=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t+9C8Xj65fxIWVs8Y0sktjdE1UTL/k1VHA1kLpypaDgGweR0g29w8/AjVGpT5tY3JVtQyvHu5U2Is17v4DhIW2cXdwbAhmthoRvC4KrgdugWKo/g24S6zKUxM9tx/pRV7ZaYOMH2JCGJeASgHXoEEfJ+oeh5eLEtdi1AvxOdL14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=t84GgkJb; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714065329; x=1745601329;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=JDEt2MmCttN4daoDvv4p8ZSeKXNpwwE+FF40vxujNrI=;
  b=t84GgkJbWP2t8boVoTmGImZXnYF98rCWWW5/HaykHxVm0qmr6B8uXo3q
   EEteznNCR2SYQkHDSyssd/FaIFb90+495KY6nTZVnGj8zdDqYXohjmT7+
   kEDxuI3otDMntsCkMXis91CNVLOID8VgWZfQBhq6koovk4+Mt0UVM+eRU
   E=;
X-IronPort-AV: E=Sophos;i="6.07,230,1708387200"; 
   d="scan'208";a="84682860"
Subject: Re: [PATCH for-rc] RDMA/efa: Add shutdown notifier
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:15:27 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:5975]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.21.244:2525] with esmtp (Farcaster)
 id 75bb8628-b16f-466c-90b8-0343e73ac666; Thu, 25 Apr 2024 17:15:26 +0000 (UTC)
X-Farcaster-Flow-ID: 75bb8628-b16f-466c-90b8-0343e73ac666
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 17:15:26 +0000
Received: from [192.168.85.70] (10.85.143.172) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 17:15:22 +0000
Message-ID: <7dc1cd89-ce13-4354-bb15-3caf4e890e34@amazon.com>
Date: Thu, 25 Apr 2024 20:15:16 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Zhu Yanjun <zyjzyj2000@gmail.com>, <jgg@nvidia.com>, <leon@kernel.org>,
	<linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	<ltao@redhat.com>, Firas Jahjah <firasj@amazon.com>, Yonatan Nachum
	<ynachum@amazon.com>
References: <20240425075143.24683-1-mrgolin@amazon.com>
 <6bafebb9-0b2c-42c2-ae9c-851e8499d5d9@linux.dev>
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <6bafebb9-0b2c-42c2-ae9c-851e8499d5d9@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 4/25/2024 2:12 PM, Zhu Yanjun wrote:
> CAUTION: This email originated from outside of the organization. Do 
> not click links or open attachments unless you can confirm the sender 
> and know the content is safe.
>
>
>
> On 25.04.24 09:51, Michael Margolin wrote:
>> Add driver function to stop the device and release any active IRQs as
>> preparation for shutdown. This should fix issues cased by unexpected AQ
>
> s/cased/caused ?
>
> Zhu Yanjun

Right, thanks.


Michael



