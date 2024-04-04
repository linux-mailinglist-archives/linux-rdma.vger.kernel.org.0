Return-Path: <linux-rdma+bounces-1778-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C128981A6
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Apr 2024 08:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF361F27334
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Apr 2024 06:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD5F52F9A;
	Thu,  4 Apr 2024 06:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XWRX2Ro6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6227053803;
	Thu,  4 Apr 2024 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712213663; cv=none; b=bI4B+S1GImrggSZWdXj2h1GVhrMADH8DNCGp6B6byb5U5f/TMZjQGB8b5yWcMK44eB8zvMnL3YAJBWXdkZQShuMYROCJPbv6H9YTw0MGSGdj/ibwly1uqVjYNPRagwIRSVpG94jCZoUekgQR0+sdfGQJ3hzILXgV9t4wzK6+7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712213663; c=relaxed/simple;
	bh=vyYehCtmuOnkDyiTVtISMV19OYydyeZiEvgBYOzKtdU=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UOLFY1yCAlC9G+w8qDaWN9GUQXypWEwApp+e63LJ2yE4qg+FNP82LA4DThiVVZk899MMyOpeoo/zjlckYHw5TGd0dMr6jkLZFULJiNGREMCm6zZ+i7WS4vPGj6KM1fDPXA07flpJS6kkoAIlRNOSVnvD15beQVct3EM+lDjaIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XWRX2Ro6; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712213662; x=1743749662;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=vyYehCtmuOnkDyiTVtISMV19OYydyeZiEvgBYOzKtdU=;
  b=XWRX2Ro61lfVjiHUSNG93LjGzgb5ESGWcbEoign19AfwjGRHX5FhOxaN
   frpmHuIyas6clSLySSv17BEA8T7kttUf0vMKNRpQyod3St+lAeAe2lB5C
   MPKxntAstbRBHSaOAiKE4Rl1FnveDb7rNlaB/R5ULn/DfFX5SvloBFBtp
   c=;
X-IronPort-AV: E=Sophos;i="6.07,178,1708387200"; 
   d="scan'208";a="78531287"
Subject: Re: Implementing .shutdown method for efa module
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 06:54:20 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:47413]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.213:2525] with esmtp (Farcaster)
 id bb37eac2-f65b-438a-83c5-656e83f2691d; Thu, 4 Apr 2024 06:54:19 +0000 (UTC)
X-Farcaster-Flow-ID: bb37eac2-f65b-438a-83c5-656e83f2691d
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 4 Apr 2024 06:54:19 +0000
Received: from [192.168.84.64] (10.85.143.175) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 4 Apr 2024 06:54:15 +0000
Message-ID: <59c5dabd-c06e-4982-af68-bdee9b8174fd@amazon.com>
Date: Thu, 4 Apr 2024 09:54:10 +0300
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
 <0e7dddff-d7f3-4617-83e6-f255449a282b@amazon.com>
 <20240403154414.GD1363414@ziepe.ca>
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20240403154414.GD1363414@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

Thanks, I'll send a patch.


Michael

On 4/3/2024 6:44 PM, Jason Gunthorpe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Mon, Apr 01, 2024 at 04:23:32PM +0300, Margolin, Michael wrote:
>> Jason
>>
>> Thanks for your response, efa_remove() is performing reset to the device
>> which should stop all DMA from the device.
>>
>> Except skipping cleanups that are unnecessary for shutdown flow are there
>> any other reasons to prefer a separate function for shutdown?
> Yes you should skip "cleanups" like removing the IB device and
> otherwise as there is a risk of system hang/deadlock in a shutdown
> handler context.
>
> Jason
>

