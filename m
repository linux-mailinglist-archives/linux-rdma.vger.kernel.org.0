Return-Path: <linux-rdma+bounces-4817-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A00970BB9
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 04:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D18CEB20C48
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 02:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAE1134AB;
	Mon,  9 Sep 2024 02:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XDbe+uDK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BFFEEB2
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725847859; cv=none; b=obQM62KMVWJpIXXJE144vjaEwQiAbFOfyt+pgsiHOnomfG1SR5XoW5TG8ZBaE7e0LSS1/8amZLlTp5qh3lW235Aeb8ddtFXvq3y6Yb4qCbga8UPlXO56AEPvpOiF0VZjvOXmkZP68gArnRpZkJvKFGUMGppOP0oC0ST03UasZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725847859; c=relaxed/simple;
	bh=p1DD+8veqylyDtuChBScGnDyYxHX1oGE6MknuQgfTq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqfJEyS4pdJ7rFXvT9qLC7L9SOariYNr2gcapaXqHQGOC2FrtyX67WplHkuT5A0khKGF1+QHFPucFnY69T04tAc/J5qFH4CYc+6EapAsmjkUEc8uCM4M1i6YV8/1013HLYcsW0uDshLmA8iG/+AO4gYGsEhPpRKRA9Mkqnx5cA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XDbe+uDK; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <faac55ee-6bfd-469f-a738-b0141b8d1b1e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725847854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ls8Izm3ewQfbrXdtT689ilq0EcaBy/irAufdrIOjA4M=;
	b=XDbe+uDKu5KFDm9W0wsW4mSkRKiqd8YHEnoPlU/xR6a3hImE1n/cZlIUleYWGOtjtBvv/o
	Z7Qf7QAmlvZiehI1i2PlYJFxc42DWoPGnoxuggh8XrX5MHf8wzw9Y3bNJ3mB+uJT8VrQ4t
	Nfv61R6NzhLCR5oWZOKWkWlPGuiv8Vo=
Date: Mon, 9 Sep 2024 10:10:43 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 0/8] Introduce mlx5 Memory Scheme ODP
To: Michael Guralnik <michaelgur@nvidia.com>, leonro@nvidia.com,
 jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com
References: <20240904153038.23054-1-michaelgur@nvidia.com>
 <4e8e01d1-359d-4877-ac6c-29f4fc512fb7@linux.dev>
 <d0f1e3c2-ac81-4126-bccd-615cd6ed3453@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <d0f1e3c2-ac81-4126-bccd-615cd6ed3453@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/9/8 14:18, Michael Guralnik 写道:
> 
> On 06/09/2024 08:35, Zhu Yanjun wrote:
>>
>> As such, it seems that it can save memory via not pinning down the
>> underlying physical pages of the address space, and track the validity
>> of the mappings.
>>
>> What is the difference on the performance with/without ODP enabled? And
>> about memory usage, is there any test result about this?
>>
>> And ODP can be used mlx5 IB device? Or ODP can only be used in mlx5
>> RoCEv2 device?
>>
> The performance while using ODP is highly dependent on many factors that 
> dictate how many page faults the kernel will have to deal with.
> Each page fault will introduce a latency hit.
> 
> Both the examples in rdma_core (e.g ibv_rc_pingpong) and the perftest 
> (e.g. ib_write_bw) support running with ODP to test this.

Thanks a lot. I have developed ODP for other RDMA devices. From my 
tests, it seems that with ODP, the system memory is needed less than 
without ODP.

 From your descriptions, it seems that the latency of RDMA will increase 
if I get you correctly.

If others (for example, bandwidth) remain unchanged, the tradeoff should 
be between memory and latency.

Best Regards,
Zhu Yanjun

> 
> ODP can be used in both IB and RoCE.
> 
> 
> Michael
> 
> 
>> Thanks,
>> Zhu Yanjun
>>


