Return-Path: <linux-rdma+bounces-7728-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 144BFA34221
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 15:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702F13A5930
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 14:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8003B335BA;
	Thu, 13 Feb 2025 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IOJE3kGR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA34281343
	for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2025 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457041; cv=none; b=s/269nLAlXo9pzlMVT7NjGYxlbmPTcnr3pyWiIHxxNMi2htHmN3jCHfOQ0MaYHs7KNUEzmyDn33SAOe3Of/yotUWaX7C7a1NQz/rlJ/AiJrR9Sdz4pXipmcLax9WdlXN1afrSO3WKCFSrovyobL4I9wvRQdUZzQlTl0PiFkwW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457041; c=relaxed/simple;
	bh=DCF3Ok7K8v7nNlhP9rEjIcTmy829w7qug/x59wOsx6A=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TRh8HjP/q67fY5zGo/a5xB3ApRqXgqxuTFTwZ+ls74ZU4kFNw64u575NtjzX72v4rg5/Yg9H92MLwUnoWb/sn2H2N5S61FA2ck4vtqBqJHPjwbmoSxU1/hrT5PeS76jSx5Pd6I/fYdCuK1f8GvUF/S1TnMxbwenfrXaLO9dvlVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IOJE3kGR; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739457039; x=1770993039;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=9YFsZJeqmYVZsz+UjiST2uK+HzGgPyGslxp0JUKqCks=;
  b=IOJE3kGRGEcBaREnWRRCHZbPZpqz83D5axBxTcQ1hXbODlf5MAt49yhA
   07hxyvQ2aqXLmHNdSHHa4+lSc9ROyjMyBfxVJ1/chvZ4rTiwkIfMIkN2m
   WPBG85r/ae1Fc5AjTHl4DlQ0YMLIDwGiiZBBTiCCpyPGFz2Y9XLYGy2lH
   g=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
   d="scan'208";a="408334725"
Subject: Re: [PATCH for-next] RDMA/core: Fix best page size finding when it can cross
 SG entries
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:30:33 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:17383]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.20.127:2525] with esmtp (Farcaster)
 id c4821a4d-e6d3-4aea-b5fc-b0f617c7b03a; Thu, 13 Feb 2025 14:30:19 +0000 (UTC)
X-Farcaster-Flow-ID: c4821a4d-e6d3-4aea-b5fc-b0f617c7b03a
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 14:30:19 +0000
Received: from [192.168.98.164] (10.85.143.174) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 14:30:16 +0000
Message-ID: <777e5518-3f0a-43e8-b80b-0a3ba4ecf5da@amazon.com>
Date: Thu, 13 Feb 2025 16:30:11 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Firas Jahjah <firasj@amazon.com>, Yonatan Nachum
	<ynachum@amazon.com>
References: <20250209142608.21230-1-mrgolin@amazon.com>
 <20250213125126.GK17863@unreal> <20250213140421.GZ3754072@nvidia.com>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20250213140421.GZ3754072@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 2/13/2025 4:04 PM, Jason Gunthorpe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Thu, Feb 13, 2025 at 02:51:26PM +0200, Leon Romanovsky wrote:
>> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
>> index e7e428369159..63a92d6cfbc2 100644
>> --- a/drivers/infiniband/core/umem.c
>> +++ b/drivers/infiniband/core/umem.c
>> @@ -112,8 +112,7 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
>>                  /* If the current entry is physically contiguous with the previous
>>                   * one, no need to take its start addresses into consideration.
>>                   */
>> -               if (curr_base + curr_len != sg_dma_address(sg)) {
>> -
>> +               if (curr_base != sg_dma_address(sg) - curr_len) {
>>                          curr_base = sg_dma_address(sg);
>>                          curr_len = 0;
> I'm not sure about this, what ensures sg_dma_address() > curr_len?
>
> curr_base + curr_len could also overflow, we've seen that AMD IOMMU
> sometimes uses the very high addresess already

I think the only case we care about where curr_base + curr_len can 
overflow is when next sg_dma_address() == 0.

But maybe we should just add an explicit check:

-               if (curr_base + curr_len != sg_dma_address(sg)) {
+               if (curr_base + curr_len < curr_base ||
+                   curr_base + curr_len != sg_dma_address(sg)) {
                         curr_base = sg_dma_address(sg);
                         curr_len = 0;

Michael


