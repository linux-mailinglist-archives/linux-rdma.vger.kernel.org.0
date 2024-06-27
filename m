Return-Path: <linux-rdma+bounces-3548-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1945791AD4D
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 18:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C428C1F26FF4
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D74199EA1;
	Thu, 27 Jun 2024 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="F7JzlaA7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0517199395
	for <linux-rdma@vger.kernel.org>; Thu, 27 Jun 2024 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507452; cv=none; b=hPg1C8jD4zFSu7rwUfDpISq1Lm4oKXnOVrpY/yyyT/R8Uws8ETpkJFSLEj0YrQF2GBI0Isete/M4A5sdg/DdPehrCO3HqsaBtRfi+71JR2sQNHzVejTOMvnRPHuCKx0MBgvbRLKX6FC2HLOXloDtYx7HaBvS9PY4OkT2rnT1jV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507452; c=relaxed/simple;
	bh=NAX58QwG3ohAmOsQn72nquhetwXNqJ338hhzTR1cmxs=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IaJhV31cg4KuQ+2jVJYbsiK8XDA3Vv9MbsczHRXV8dd414QnSOKWZmlo/+hpnn1N3GbbalAfMcnWT8v+/MnIC1+/Jkq+VzctLI44D/vmiWEyicqT8MwStda+3+aM8JoeBCVkqVhzFhGafPv1dx8rGixmJYZIw5a5JkNq21oYzcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=F7JzlaA7; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719507450; x=1751043450;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=jLD12seoVJtQjFrtU4DXZHkYiVOXIbkD2ufsU/hHVNU=;
  b=F7JzlaA7BIHaAWahgGf8+6YW4GQ0bJ4/0P1lYbw2KvkmVTOzJn9/y+rY
   wnASbgFqXLejlKBOAiwJFc+AMHz/MKJxsV92EkQeMo2WkWQCeNPAXVBmL
   iyF6VDWZEfcV1eMPJYhGtp52qyS9m0cpCttDDCG8MSSFzrpdkq/M3Feb5
   w=;
X-IronPort-AV: E=Sophos;i="6.09,166,1716249600"; 
   d="scan'208";a="100149763"
Subject: Re: [PATCH for-next 5/5] RDMA/efa: Align private func names to a single
 convention
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 16:57:28 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:35186]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.46.91:2525] with esmtp (Farcaster)
 id acc640fa-766b-43c7-a4ea-10502ef5566a; Thu, 27 Jun 2024 16:57:27 +0000 (UTC)
X-Farcaster-Flow-ID: acc640fa-766b-43c7-a4ea-10502ef5566a
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 27 Jun 2024 16:57:25 +0000
Received: from [192.168.71.117] (10.85.143.175) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 27 Jun 2024 16:57:21 +0000
Message-ID: <6310c5d0-e72d-4b4a-9b78-b19b622fdb92@amazon.com>
Date: Thu, 27 Jun 2024 19:57:17 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>,
	<matua@amazon.com>, <gal.pressman@linux.dev>, Firas Jahjah
	<firasj@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
References: <20240624160918.27060-1-mrgolin@amazon.com>
 <20240624160918.27060-6-mrgolin@amazon.com>
 <20240626153834.GA3233164@nvidia.com>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20240626153834.GA3233164@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 6/26/2024 6:38 PM, Jason Gunthorpe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Mon, Jun 24, 2024 at 04:09:18PM +0000, Michael Margolin wrote:
>> Name functions that aren't exposed outside of a file with '_' prefix and
>> make sure that all verbs ops' implementations are named according to the
>> op name with an additional 'efa_' prefix.
> That isn't the kernel convention, please don't use _ like this
>
> Jason

AFAIK there is no single kernel convention for static functions naming 
and it also seems that the underscore prefix isn't rare in the subsystem.

Would you suggest a preferred style?


Michael


