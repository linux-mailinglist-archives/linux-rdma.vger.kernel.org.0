Return-Path: <linux-rdma+bounces-3475-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D0F916619
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 13:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A38281492
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 11:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277EA14BF8B;
	Tue, 25 Jun 2024 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aICaVbBH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A490314B064
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719314519; cv=none; b=KyIBxhhvhdJptVlriCFdjFON2CGtIDQlj3dSaAaoG4nE0isspLBfrYIY0K04uXAGNkEHB3aZ6l5GqvMTc/IL72ZjjOhzuiLTnhr+n0d201PRb0xhdg1idzXjncaq5IU6yvxmpA/HPFiXmbYSKdaN/z5u/MfouIrnasfDW3wB6Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719314519; c=relaxed/simple;
	bh=vPVsM/IAUk4HTVcxLJsLi9WW72PyWLufuFF6YDahCtI=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bXoXJpHl/y9I42TcZAU4Ztazp1z01jgTo/zoOzvKhV6RZixftf71D/Fz8+urghgbelq9iHBMEJs9Z/ooiqBDLy4NluuBXtsRzgSt882X9EVEpoLu9qyYUPRaO0SKHYRLSA0FiwGYk3jhr7S9q84L7gwZzLiyWDIrZuWnoOHMlkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aICaVbBH; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719314519; x=1750850519;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=PDzyoSpgxvD5lRhR/n6r1Td5kjcQKyk0SUEkLhUW63w=;
  b=aICaVbBHpYE3+jD636jYigewdMX85jx/v+O3Eb8cXD3uJhV70Rq/s5tk
   GZz6bwZ1950hvuYzm82bMXU+/cUKJYpgoIP/uqOp8p3aEq9tW+7r3pspv
   amhNNL3O9XRw+dVafJ8C5V8Dkjpq45aYQAXeKbKQKdlcvdR+9zJ6aDshJ
   Q=;
X-IronPort-AV: E=Sophos;i="6.08,263,1712620800"; 
   d="scan'208";a="735316658"
Subject: Re: [PATCH for-next 4/5] RDMA/efa: Move type conversion helpers to efa.h
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 11:21:52 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:28530]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.17.97:2525] with esmtp (Farcaster)
 id 7f70d8c2-7d45-472e-99a1-559be7401140; Tue, 25 Jun 2024 11:21:50 +0000 (UTC)
X-Farcaster-Flow-ID: 7f70d8c2-7d45-472e-99a1-559be7401140
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 11:21:48 +0000
Received: from [192.168.71.82] (10.85.143.173) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 11:21:44 +0000
Message-ID: <99b2acde-bb35-4de9-9d1f-d52e69e81bce@amazon.com>
Date: Tue, 25 Jun 2024 14:21:39 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gal Pressman <gal.pressman@linux.dev>, <jgg@nvidia.com>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
References: <20240624160918.27060-1-mrgolin@amazon.com>
 <20240624160918.27060-5-mrgolin@amazon.com>
 <1c1f22fd-10fb-4fc6-a4a7-f167013b60c3@linux.dev>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <1c1f22fd-10fb-4fc6-a4a7-f167013b60c3@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

On 6/25/2024 9:33 AM, Gal Pressman wrote

> On 24/06/2024 19:09, Michael Margolin wrote:
>> Move ib_ to efa_ types conversion functions to have them near the types
>> definitions and to reduce code in efa_verbs.c.
>>
>> Reviewed-by: Firas Jahjah <firasj@amazon.com>
>> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
>> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> The idea was to not expose these functions in the h file as they are not
> used outside of efa_verbs.c.

I know but it's a driver internal header and it also makes sense to have 
the cast from the base type near the definition.

Michael


