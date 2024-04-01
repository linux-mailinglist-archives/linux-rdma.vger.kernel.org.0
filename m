Return-Path: <linux-rdma+bounces-1706-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E40893B63
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 15:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC1F281ED1
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 13:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61683F8F4;
	Mon,  1 Apr 2024 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aOo7XpIN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAE821A0A;
	Mon,  1 Apr 2024 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711977847; cv=none; b=HSkr4aoYswWDSuEaDE3ElmT1VraUo2hNVC4Ycx2AanVg1NgE2zO4eP3UvovPV1hc5ysWlfE+kRMuwh54jNujx1LuwdNlx3NIWX7YtYVpWPnZP0dz/AELUSX4iSidbyyCZmncWHw6ItPClkeui2CmwcKhfYmV5HatP/nelJWP3uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711977847; c=relaxed/simple;
	bh=9EaMVV3elotIvVru5tyAQ4Ib+d3jzMQzcTbDbh/1SCs=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d0Ui9QVanPToQkBVK829snNq10aOixUPRBe+O6N+7Y9o6YjuwXWrO1P7CwabW/qPqBYoI+sHuEBD51Q/OF3A0f813jdRKy7QNsmQ5haLcpPpol4kpeg89QppSkTOyHfiZSp/AqMDhkSfTuwu+dnu+cg9OZp4rtavMOXrNjhOgDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aOo7XpIN; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711977846; x=1743513846;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=/q5RUYrVO7lETbxfGo97Atx61q36lvWj5/xhBcLh7fk=;
  b=aOo7XpINo08y4LChadQE9loNUa2Uc9kozy6hJfW74p8UvQ3xxNzJDESz
   UJDa6cwQqUFm5Uo/tvD1pex+aGYAlkcp/5w9q79IB/lRbMQS+yH32tbhU
   FscZSF6JKDvWVVuv690zzY9R4R2u5NBtu6CpGePMgv3SAdIyMyhgSNoBC
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,172,1708387200"; 
   d="scan'208";a="715783487"
Subject: Re: Implementing .shutdown method for efa module
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 13:23:44 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:63400]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.112:2525] with esmtp (Farcaster)
 id de5bc671-77f5-45f8-a682-175bf7ec8cfe; Mon, 1 Apr 2024 13:23:43 +0000 (UTC)
X-Farcaster-Flow-ID: de5bc671-77f5-45f8-a682-175bf7ec8cfe
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 1 Apr 2024 13:23:41 +0000
Received: from [192.168.82.210] (10.85.143.172) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 1 Apr 2024 13:23:37 +0000
Message-ID: <0e7dddff-d7f3-4617-83e6-f255449a282b@amazon.com>
Date: Mon, 1 Apr 2024 16:23:32 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Tao Liu <ltao@redhat.com>, Gal Pressman <gal.pressman@linux.dev>,
	<sleybo@amazon.com>, <leon@kernel.org>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
References: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
 <5d81d6d0-5afc-4d0e-8d2b-445d48921511@linux.dev>
 <CAO7dBbXLU5teiYm8VvES7e7m7dUzJQYV9HHLOFKperjwq-NJeA@mail.gmail.com>
 <b6c0bd81-3b8d-465d-a0eb-faa5323a6b05@amazon.com>
 <20240326153223.GF8419@ziepe.ca>
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20240326153223.GF8419@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

Jason

Thanks for your response, efa_remove() is performing reset to the device 
which should stop all DMA from the device.

Except skipping cleanups that are unnecessary for shutdown flow are 
there any other reasons to prefer a separate function for shutdown?


Michael

On 3/26/2024 5:32 PM, Jason Gunthorpe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Tue, Mar 26, 2024 at 02:34:45PM +0200, Margolin, Michael wrote:
>> Hi Tao,
>>
>> Thanks for bringing this up.
>>
>> I've unsuccessfully tried to reproduce this kernel panic using production
>> Red Hat 9.3 AMI (5.14.0-362.18.1.el9_3.aarch64).
>>
>> Are there any related changes in the kernel you are testing?
>>
>> Anyways we do need to handle shutdown properly, please let know if calling
>> to efa_remove solves your issue.
> efa_remove should not be used for shutdown..
>
> If you have an iommu in your system (smmuv3 for this ARM64 case) then
> drivers must implement a shutdown handler or you will risk data
> corruption on ARM64 sytems during crash.
>
> The shutdown handler must stop all DMA from the device.
>
> If you don't have an iommu then the shutdown handler shouldn't be
> critical.
>
> Jason

