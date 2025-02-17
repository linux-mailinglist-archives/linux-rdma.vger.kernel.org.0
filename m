Return-Path: <linux-rdma+bounces-7792-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 113C8A37D57
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 09:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40E11890EEE
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 08:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF1F1A3152;
	Mon, 17 Feb 2025 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tRw2BwYL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3D81A314A
	for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2025 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781662; cv=none; b=PaJ6ArXkPbqMxj/Zekd/mT8rrrCUFAlQGNgUwcR7ErZY9aA+AtMjtE9f87eqmnG91UpwIqEnlHMBu+zMTromCGLuvV8u4PHuBVgmfjM4eZwGEr6gSdw/dc5e11d0Is885YqcNF5T2cNIScPpBZNbvoiiT3kc31SMTn+zc78mw3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781662; c=relaxed/simple;
	bh=OZXi348O/FUsk50UKD9wZBsmfYc/pFRqQk7q6SEzq6s=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qlecVgwiP6nBOsQK9IzXF9AXIrm/ogRRAUsaF5wKXjMwmYcruh2ZQjGfkpz1MoKKCD1Nk1TSzYGzSf1aibESUQh0piMaxxmfeeujQ478W4ILDuSMKv1eUiDNb7d1M0a4PLfTyR1xbpX97ZbKzh4H6akA+RhgpH8s1EbMz0Jsb7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tRw2BwYL; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739781661; x=1771317661;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=OZXi348O/FUsk50UKD9wZBsmfYc/pFRqQk7q6SEzq6s=;
  b=tRw2BwYLiDb9SvDE76axKL99YNptD/SiRN+edcAaQ7vJfxd7HHQRjDM5
   ezoE26P1RJf3jVz4MSgBRLNOg0MiU4KNwt6NWTH7zQ7R3/1KrePV6xk9M
   gU+Irv4bOGu5HEF5pzXIu7LyBHHWQHdbTgauK4vB9Qn+18sAXdPZZRUqg
   g=;
X-IronPort-AV: E=Sophos;i="6.13,292,1732579200"; 
   d="scan'208";a="271782798"
Subject: Re: [PATCH for-next] RDMA/core: Fix best page size finding when it can cross
 SG entries
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 08:40:58 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:16887]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.30.55:2525] with esmtp (Farcaster)
 id 5703e6d0-a024-43b7-abe3-dfda0f3d8ea0; Mon, 17 Feb 2025 08:40:56 +0000 (UTC)
X-Farcaster-Flow-ID: 5703e6d0-a024-43b7-abe3-dfda0f3d8ea0
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 17 Feb 2025 08:40:55 +0000
Received: from [192.168.131.253] (10.85.143.177) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Feb 2025 08:40:52 +0000
Message-ID: <5c7bf57a-847b-4425-8e53-9e80c87e783e@amazon.com>
Date: Mon, 17 Feb 2025 10:40:47 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Firas Jahjah <firasj@amazon.com>, Yonatan Nachum
	<ynachum@amazon.com>
References: <20250209142608.21230-1-mrgolin@amazon.com>
 <20250213125126.GK17863@unreal> <20250213140421.GZ3754072@nvidia.com>
 <777e5518-3f0a-43e8-b80b-0a3ba4ecf5da@amazon.com>
 <20250213144219.GB3754072@nvidia.com> <20250213173510.GO17863@unreal>
 <20250213174043.GG3754072@nvidia.com> <20250213175517.GP17863@unreal>
 <20250213181242.GF3885104@nvidia.com> <20250216080724.GS17863@unreal>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20250216080724.GS17863@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 2/16/2025 10:07 AM, Leon Romanovsky wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Thu, Feb 13, 2025 at 02:12:42PM -0400, Jason Gunthorpe wrote:
>> On Thu, Feb 13, 2025 at 07:55:17PM +0200, Leon Romanovsky wrote:
>>> On Thu, Feb 13, 2025 at 01:40:43PM -0400, Jason Gunthorpe wrote:
>>>> On Thu, Feb 13, 2025 at 07:35:10PM +0200, Leon Romanovsky wrote:
>>>>
>>>>> Initially curr_base is 0xFF.....FF and curr_len is 0.
>>>> curr base can't be so unaligned can it?
>>> It is only for first iteration where it is compared with
>>> sg_dma_address(), immediately after that it is overwritten.
>> But this is all working with inherently page aligned stuff, cur_base +
>> len1 + len2 + len3 + len_n should be page aligned for interior segments..
> This is unknown to static code analyze tools. I'm not concerned about
> logical change, but about possible static code analyze failures.
>
> Thanks

OK, I'll edit the patch to make sure it doesn't produce any SA failures.

Michael


