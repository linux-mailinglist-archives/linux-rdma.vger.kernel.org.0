Return-Path: <linux-rdma+bounces-10493-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FB7ABF911
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 17:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C134917CEAC
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 15:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4251DF991;
	Wed, 21 May 2025 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="JvnyPKXQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99E2CCC9
	for <linux-rdma@vger.kernel.org>; Wed, 21 May 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840807; cv=none; b=sOBLSkoe5T4Uty5bgc/zblWIXoEc5wX+n5C15jc53yRjbjK+TS8bBG3QB2uPs1L3aC+GlYeAhpjhcOtXnuBfy9Kba/cuTOKerG/4NNFMZN0ed64b5EOVmyBmZGuq5kvS62z7cCiSyIUih8mlYpapVQO+5bO1zBOF1p4+/FZg1HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840807; c=relaxed/simple;
	bh=E4dHxybIYr2S1PKluCMHUFVLC6mYVhTrfhtaNtd4oAY=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tes0EQ1Y3EvLNems7txrfS7B9ZYRiYxbQcxV9ZQKyipd8Krdww4R68jr71KmgCkieywaCHw0Nmq8pnW/nYTFohsCNiGSa8iYXZRmnGkx5+dux/cpkhz2wB2wT/4HaBqwEgDilIlOxSbxFInykYgaT5NN/o3ABN2mUrDBrnK9elw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=JvnyPKXQ; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747840806; x=1779376806;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=Ht69PZCHhcfHJO7PqY00LYXvmPniwJCTmO0bQ/BBRAE=;
  b=JvnyPKXQk/cz4vOIaRQTaStUyyR1+H1St8HRZvwUYhJIAi7ykXe25ECz
   Te05PozqWgD7dkGgfsUjoGfq1Jnbu4NE8lh5CFpxEDCW+n8ZftLe6w6El
   bqQ61iRQ/IMHMRmA0JCD3SVunN6I08j6ppL4vbuTP47EjzTE6HjkBbPnn
   qbRVvFhnTD76dooBZ/r7xhbkfjlUqz7LSsrEkY1FnDWDxsg7HLkB/Uzo7
   yegSofcnt+3F6l3ZcsbifmD8cgBu90npQUItgYpacJKdzAeHtD67fP4FO
   kUZyLTKjb/+w/wIxJiLWNWPEptDdnG48Z3+sj/LmEQRae/qfPmAvAKY0l
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; 
   d="scan'208";a="725174874"
Subject: Re: [PATCH for-next] RDMA/efa: Add CQ with external memory support
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 15:20:02 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:30753]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.53:2525] with esmtp (Farcaster)
 id 282e9168-3c0a-4443-953d-4af54b2e9153; Wed, 21 May 2025 15:20:01 +0000 (UTC)
X-Farcaster-Flow-ID: 282e9168-3c0a-4443-953d-4af54b2e9153
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 15:20:00 +0000
Received: from [192.168.137.48] (10.85.143.179) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 15:19:56 +0000
Message-ID: <9ae80a03-e31b-4f33-8900-541a27e30eac@amazon.com>
Date: Wed, 21 May 2025 18:19:51 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Daniel Kranzdorf <dkkranzd@amazon.com>, "Yonatan
 Nachum" <ynachum@amazon.com>
References: <20250515145040.6862-1-mrgolin@amazon.com>
 <20250518064241.GC7435@unreal>
 <985b77cc-63bb-4cf9-885e-c2d6aca95551@amazon.com>
 <20250520091638.GF7435@unreal>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20250520091638.GF7435@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 5/20/2025 12:16 PM, Leon Romanovsky wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Sun, May 18, 2025 at 11:56:56AM +0300, Margolin, Michael wrote:
>> On 5/18/2025 9:42 AM, Leon Romanovsky wrote:
>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>
>>>
>>>
>>> On Thu, May 15, 2025 at 02:50:40PM +0000, Michael Margolin wrote:
>>>> Add an option to create CQ using external memory instead of allocating
>>>> in the driver. The memory can be passed from userspace by dmabuf fd and
>>>> an offset.
>>> EFA is unique here. This patch is missing description of why it is
>>> needed, and why existing solutions if any exist, can't be used.
>>>
>>> Thanks
>> I probably should have explained more, the purpose is creating CQs that
>> reside in GPU HBM enabling low latency polling directly by the GPU. EFA
>> isn't unique in receiving pre-allocated memory from userspace, the extension
>> here is the use of dmabuf for that purpose as a general mechanism that
>> allows using memory independent of its source. I will add more info in the
>> commit message.
> I think that this functionality is worth to have as general verb and not DV.
> mlx5 has something similar and now EFA needs it too.
>
> Let's wait for Jason's response before rushing to implement it.
>
> Thanks

Jason, any thoughts on this?

We can probably add optional attributes to create CQ command, but most 
of the handling will remain vendor specific. I'm not convinced it's 
beneficial enough.

Michael


