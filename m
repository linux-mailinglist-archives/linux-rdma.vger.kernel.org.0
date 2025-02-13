Return-Path: <linux-rdma+bounces-7731-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B90B3A34BDA
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AF367A07F1
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 17:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513762040B7;
	Thu, 13 Feb 2025 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="o0e+9bGk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BA5202F61
	for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2025 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467555; cv=none; b=DeDFtdvQeqgldBz7lmezJAS3JowoevVVzzRb4dJjWM5opSRXoKdPEPMvsUNLUiLXoLOvfMmS/FEbZbqJMPkzV7XIpNPMrO8X6L0PxBwS8r1LI20T7+J69t9NRKb43WI/Xn0F3fAFHbLb/V1BhL/PLMyEnZzcxkmJ7Q/vaLO0yr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467555; c=relaxed/simple;
	bh=3MsfS/ZFoL4F5b/mP9cY8WysNQTtIL0LOAcjDJy3ImQ=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F3qKI+R+M5UPre7tTDHT8wk+qbEclpXYQQBxG+5YCgqIrPg8Sdx7xzURs4vzBUuuRiqYMep+MkPtarWoEfBofQyn2PsDQFYmP2s6rmtkZUY/VoHHb+yR0rpPEtyX5od5Nx+SRyls2CECddBsM6j9+HheYv/Uatxr6IZBhins4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=o0e+9bGk; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739467553; x=1771003553;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=3MsfS/ZFoL4F5b/mP9cY8WysNQTtIL0LOAcjDJy3ImQ=;
  b=o0e+9bGko1cSwiYi0z9qMcx77QG28ZGnGoEvtwtAOUz/B6Hi8sp4pLsR
   T1ClAjzZYD767INYi1aGn2fJPQNbB3tqY9GPJ1NLTMq4TTiAhnqLmbTAQ
   MAG0etTTtBA15M/Xm/qDD89iEiDAYKF/Z4GYoxcBu3lLSJYlIFJbGshG1
   k=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
   d="scan'208";a="169434435"
Subject: Re: [PATCH for-next] RDMA/core: Fix best page size finding when it can cross
 SG entries
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 17:25:51 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:25842]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.5.249:2525] with esmtp (Farcaster)
 id 55eab25e-d479-4fa4-a5bb-8620acef9389; Thu, 13 Feb 2025 17:25:50 +0000 (UTC)
X-Farcaster-Flow-ID: 55eab25e-d479-4fa4-a5bb-8620acef9389
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 17:25:50 +0000
Received: from [192.168.131.192] (10.85.143.178) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 17:25:46 +0000
Message-ID: <fffa6c21-c5d6-46f7-8090-f26c1c72ce55@amazon.com>
Date: Thu, 13 Feb 2025 19:25:41 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Leon Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Firas
 Jahjah" <firasj@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
References: <20250209142608.21230-1-mrgolin@amazon.com>
 <20250213125126.GK17863@unreal> <20250213140421.GZ3754072@nvidia.com>
 <777e5518-3f0a-43e8-b80b-0a3ba4ecf5da@amazon.com>
 <20250213144219.GB3754072@nvidia.com>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20250213144219.GB3754072@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 2/13/2025 4:42 PM, Jason Gunthorpe wrote:
> I wonder if we should try to make a overflow.h helper for these kinds
> of problems.
>
> /* Check if a + n == b, failing if a+n overflows */
> check_consecutive(a, n, b)
>
> ?
>
> It is a fairly common problem
>
> I suggest to take the patch as it originally was and try to propose
> the above helper?

Sounds reasonable, I can propose such check helpers.

Michael


