Return-Path: <linux-rdma+bounces-4099-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFC394112D
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 13:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BBC1F2399F
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 11:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E131891DA;
	Tue, 30 Jul 2024 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K81P9S1/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED6119580A
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jul 2024 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722340337; cv=none; b=J6Yfkf/jEsEbExqG712RpfQkmWiDk/ct5V4YlSp1vq6gHWsMCa7UxDK3EyWjdOygB9yoBw5nWtQbDW3Z4WQvIcIsVxFluI9iROq2/m4BrhFBU/yKdxoZUaIRESUAWdKU6JjAC4kDGKDh02iqrjnbffca/GpGNpPJVvRiy6xXSk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722340337; c=relaxed/simple;
	bh=cvs9cco82JTUFePkIvywRXSdbeVkpid/g+nyXXDbj0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JkcZ7Jmh5kGPVZrffiFI1iDktrGPW1AP1SQQg74ll7rj1UIRgMTldTosoVdup8JpdtlJ2wJAowNKYPpVRwtd1hkoaOoLxl9NB/lML0qK2fIMZcWXHsrpoDDoVFVmxPepuPASJflb3W5Y21pG37QcXSkCRGcE6Cb4y0TVblcRKO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K81P9S1/; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <90ece72b-3dc2-470f-b141-141e8263849e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722340332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PaH6Kjnj3qg4cCJn8M+gtWJ6h4zRFBUoW9bz1mS8+Yc=;
	b=K81P9S1/MdZwhviPhe+w02WKJImuBtTH1iiSIBNpJD3zzyJIMahPoQ56BaRqx1cyRGRedk
	f4fc+GGJ9xUz7SIZ/WIvbSoYx9Vyy0tdQEcrX/jnSCGVxO2cZ219CxK6/4gyVSm8JsALj+
	Q5Ma+ialRM4ei5Le8S3XouZJOaklK7o=
Date: Tue, 30 Jul 2024 19:52:02 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Seeking Guidance: Creating an IBV Multicast Group?
To: Andrew Sheinberg <as1669@princeton.edu>, linux-rdma@vger.kernel.org
References: <1FF42574-65B2-493A-A779-D27F853063A7@princeton.edu>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1FF42574-65B2-493A-A779-D27F853063A7@princeton.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/7/30 1:10, Andrew Sheinberg 写道:
> Hello all,
> 
> I’m not sure if this the right place to ask, but I will give it a try.
> 
> I have a system with many initialized UD queue pairs (info for address handle creations and qp numbers exchanged out-of-band). I am only using libibverbs for establishment (purposefully not using librdmacm, to allow for more flexible environment configuration) — everything is working smoothly for unicast.  Now I would like to create a multicast group and attach some of these queue pairs (ibv_mcast_attach); however I am struggling to find any details on how to create such a group (and obtain a proper MGID and MLID).
> 
> I found a few examples online but am left with questions:
> 	- There is code within perftest's "multicast_resources.c", but this seems a bit hacky and oddly verbose
> 	- There is code within Nvidia Docs’  "Programming Examples using IBV” showcasing joining an already created multicast group at a given IP address using rdma_cm, but It is unclear how to create the group in the first place
> 
> 
> Questions (please correct me if these do not make sense):
> 
> 1. What is the role of the OpenSM — is there a C API?
> 	- Are there any examples using opensm programmatically and not with CLI?
> 	- Does the API differ on InfiniBand vs. RoCEv2 fabric?

I have made tests with Infiniband vs. RoCEv2. From my perspective, I 
think, there are some differences between the 2 fabrics.

To the basic functionalities, the difference between 2 fabrics is small. 
But to the extended functionalities, the difference is big.

The difference is based on the different features.

I just made some simple tests. Perhaps some engineers who made a lot of 
tests can give more suggestions about this.

Zhu Yanjun

> 
> 2. Is there any high-level documentation to describe the role of libibumad? (Looking at the man pages on a per-function basis is a bit too fine-grained for my understanding as of now).
> 	- I also see libibmad — what is the responsibility breakdown between these two?
> 	- How do they relate to OpenSM?
> 
> Any guidance is greatly appreciated.
> 
> Thanks,
> Andrew Sheinberg


