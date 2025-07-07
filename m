Return-Path: <linux-rdma+bounces-11940-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53367AFB9A5
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 19:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C6E160C25
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 17:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06457224B12;
	Mon,  7 Jul 2025 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="qRoxlonG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B02E1DACA1
	for <linux-rdma@vger.kernel.org>; Mon,  7 Jul 2025 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751908080; cv=none; b=luHWqPk7OELdyjzLpr6vrbyTZy8hp47Wjv36RLS3kxrvSwLuU4eVduG8fXQwrdpeUSJlfxv2V/p6hdos8T0Va0ShLPe3XVzAYDmbX2wsXJM+I2ZIe/GbZfXsCfI1QzIJn5r5A7wlLlqIAGjt3ku8qXyJW01ja8E53fbDQBFLBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751908080; c=relaxed/simple;
	bh=BJhDdhY04mrwZi/HDJkBnW3XzvT046BsVukbRBu793w=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JY7VWIQLaXcO+4rvvCtSpzB2Hq3SVGkTSpAFpgu3wjGdRyoDV+bepBjZqrhGsp+orX4CpdX4ca2KdGA+P7RPP44XcSQut+z23ho+CbfdoCZ1hmcn7KkeSbWU+JuaS7dfDUML/jk0AfGelMYEP0nhFgfqpC7Y6010YfgaraYV7Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qRoxlonG; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1751908080; x=1783444080;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=+owEFFgjIEdIOqU6Ng3dC2rtEmIkdW1Q4xIyblVX/Sk=;
  b=qRoxlonGKrZ9oK09Rk5UOGsxxHZb6YJZ9+n2OWpRF3S2Jcu3IToTxLE0
   PHdIDlR2qy8RS3TuY2b3pkDaQjdOOXXD3p3SXxgCjofksfbXgmbhD3j6W
   GeQp1QkSZguYhhg/3CpEhtg2iKV5Yrlh9sV5oi4bJmjl0iK5wzDb7ThiC
   Pigze6+AEJLk+1SBaJy42WNrPbf5hpJAqQz41u5q8zOnalkletB140zz0
   SaxXrmo80oMPJodHhiXY9uksGONdLM1qAOdyyatGgy5Of9Of7jTNdfbR3
   cKPmqQcI5Zg2E0Zrx+04lpSw4idcyDRqJBAX44DnmzL4oZMRtLdsmpuWw
   w==;
X-IronPort-AV: E=Sophos;i="6.16,294,1744070400"; 
   d="scan'208";a="840533813"
Subject: Re: [PATCH for-next 2/2] RDMA/efa: Add CQ with external memory support
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 17:07:54 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:50943]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.240:2525] with esmtp (Farcaster)
 id 55415198-324a-4ec5-8114-657fe9e24e8c; Mon, 7 Jul 2025 17:07:52 +0000 (UTC)
X-Farcaster-Flow-ID: 55415198-324a-4ec5-8114-657fe9e24e8c
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Jul 2025 17:07:52 +0000
Received: from [192.168.139.156] (10.85.143.177) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Jul 2025 17:07:48 +0000
Message-ID: <40ae393c-f95b-41e2-81c1-d0d1e42e1eaf@amazon.com>
Date: Mon, 7 Jul 2025 20:07:43 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>,
	<matua@amazon.com>, <gal.pressman@linux.dev>, Daniel Kranzdorf
	<dkkranzd@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
References: <20250701231545.14282-1-mrgolin@amazon.com>
 <20250701231545.14282-3-mrgolin@amazon.com>
 <20250704182804.GR1410929@nvidia.com>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20250704182804.GR1410929@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 7/4/2025 9:28 PM, Jason Gunthorpe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Tue, Jul 01, 2025 at 11:15:45PM +0000, Michael Margolin wrote:
>> +     if (umem) {
>> +             umem_sgl = ibcq->umem->sgt_append.sgt.sgl;
>> +             if (sg_dma_len(umem_sgl) < ib_umem_offset(umem) + cq->size) {
>> +                     ibdev_dbg(&dev->ibdev, "Non contiguous CQ unsupported\n");
>> +                     err = -EINVAL;
>> +                     goto err_free_mem;
>> +             }
> I'd rather see this call ib_umem_find_best_pgsz()
>
> Maybe like:
>    len = ib_umem_offset(umem) + cq->size
>    pgsz = roundup_pow_of_two(len);
>    ib_umem_find_best_pgoff(umem, pgsz, U64_MAX);
>    rdma_umem_for_each_dma_block(umem, biter, pgsz) {
>         dma = rdma_block_iter_dma_address(&biter) +  ib_umem_dma_offset(umem, pgsz);
>         break;
>    }
>
> It turns out the scatterlists can be irregular in some cases so this
> will handle that properly while the little test above cannot.
>
> And maybe the above thing could be a little helper:
>
> bool ib_umem_get_contiguous_dma(umem, &dma_addr)
>
> Also I am trying hard to keep scatterlist APIS out of the drivers.
>
> Jason

Some disadvantage of this approach is that if the provided memory 
is contiguous in its first "roundup_pow_of_two(len)" bytes but consists 
of additional smaller or unaligned sgl entries, we will refuse to use it.

I will try to compile some combination of the two approaches into a 
helper function.

Michael


