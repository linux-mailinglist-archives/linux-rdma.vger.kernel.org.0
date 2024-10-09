Return-Path: <linux-rdma+bounces-5340-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DA19976DD
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 22:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CB51C23419
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 20:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D7C1E2833;
	Wed,  9 Oct 2024 20:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="FIjIkeTY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230781E1305
	for <linux-rdma@vger.kernel.org>; Wed,  9 Oct 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506866; cv=none; b=a0ZHr4YyYiurI5x3jzAaoO2L52vel4bI3ygh5xI3fDotV+Dk30BcwARsdCHF9/dbJDr3yEGHBOIu5nOq0h0TKmEXWqiZOoQ+rFTG0RZkV+415LkEnaq6KGSTmvPCujQPUw0IwJaR9Er7lF7IxC0/4AogOiL7pSFqVv7seGzPkm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506866; c=relaxed/simple;
	bh=7Gb3rnZHRzqycpm/nPzaRKhnoFtVZKZXlknnFIhEBio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6nrDccDDRGZXprHP2rBTlWA4wiVcVpdG3k4GzcB9ZOkF+jFr1OKuwrnOSS6sQoVqoOMfBd61scfRAWxjSVG0VhChL4k615x13BKosOQGvBeOAZQ739kxeguOlC+6WPyNoQ5pQ6UtTFZ3J5lHO9YRVH9igW0ZhYewQc5Vdt13rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=FIjIkeTY; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XP4hb3pWSzlgTWK;
	Wed,  9 Oct 2024 20:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1728506862; x=1731098863; bh=T2qby9P752adgIt3ERbQ82Vk
	NVMljphvaN9uilhdTgc=; b=FIjIkeTYoWIw9R/K14yzmWMEDZ5K/Z0ROFYTE3Bw
	mGc5tZJvuqhip2bI+O1ms8P/WJQgPc42a9TWz9vrgkZD5zbhe6dqALJ3LXWOisom
	ly8vVrK0nNrmqExa2E9rOprrcj+3zVIsdES4fN1dyNM4zcWjrtKwx2E/cyzf2IOv
	V6tgmLbEdVjJkPh0AoCQQbFOrxwe0Op+rCujcgp3W4x6BCuM9fAIa6tz/sfcH29L
	7hcUE0X/gtId+eGxmDHjfFsOBkJbc85E6kSbhsx/w6hQ+dGZANSYdimd+DHq07ba
	RliPUqXXXFrppkPpg4L3Km2ismL2MqzpQ+ApRZc1zT+4lA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EOqdghNP--C4; Wed,  9 Oct 2024 20:47:42 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XP4hX5xdHzlgTWG;
	Wed,  9 Oct 2024 20:47:40 +0000 (UTC)
Message-ID: <1775e61b-6237-4213-a617-d11622f86f31@acm.org>
Date: Wed, 9 Oct 2024 13:47:38 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] RDMA/srpt: Make slab cache names unique
To: Leon Romanovsky <leonro@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Zhu Yanjun <yanjun.zhu@linux.dev>
References: <20241007203726.3076222-1-bvanassche@acm.org>
 <20241008120406.GF25819@unreal>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241008120406.GF25819@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 5:04 AM, Leon Romanovsky wrote:
> On Mon, Oct 07, 2024 at 01:37:26PM -0700, Bart Van Assche wrote:
>> +	if (IS_ERR(xa_store(&srpt_memory_caches, object_size, e, GFP_KERNEL)))
> 
> xarray API needs to be checked with xa_is_err() instead of IS_ERR().

Thanks Leon. I will fix this. In case you would not be aware of this,
this patch is the first patch in which I use the xarray API.

Bart.


