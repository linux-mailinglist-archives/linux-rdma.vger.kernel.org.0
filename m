Return-Path: <linux-rdma+bounces-15118-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6197FCD38B6
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 00:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE0CC300F9C7
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Dec 2025 23:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721C32FE048;
	Sat, 20 Dec 2025 23:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F3dIwu2B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3820B2F83B2
	for <linux-rdma@vger.kernel.org>; Sat, 20 Dec 2025 23:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766271971; cv=none; b=P/qoidfPhy8x6hJkAFGvJ7+LrAPzCKlZZIH2haKt2W5DEeabuIt1gUYFrmO6sLLmszANA3V1AJX2mv3U6cUhN+ByS19LL1LawX7RMNgc0KPSCgc/WGm9rpeRrs7uadSmji5wuIHEokiLXY1IhSVJ/DgcQp8D+EbnJpbXM1eIEDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766271971; c=relaxed/simple;
	bh=IjXLtzP3AHv0rDolqNzJMPlS8UH+kMA4oC34g/dpx9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZ9rDUOUHhWkhQdJ7xGs0vHB8mWypVGNxkYeKD6P9/WdSO/iJhq0V9NT5lVXXvRppTjYlwitplof9Gwg7IhtS6zlYXa3UCAyKVR8vRZzu6S0d48LAsPFNcUvLveEHdLcIoNs09PIBgNII3IzNNI9vpJIQ9pjsm3lQzVg+U7rWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F3dIwu2B; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8f623d8e-cd83-4610-83fa-794295576dac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766271950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppTibUaZ/aJOjyfk4Y0rqjTvbdqNWKVIiAjytncOa3E=;
	b=F3dIwu2BPP/5ZYeROfKWYm8NnLATWoCZybSKu2QE37IBCMW3VyVpw5Z3JTHo3YiU9YAkbV
	0HTq5vvYfAIh6eyfxUVuHYCL4LZWaXZuDyLIuT0DVaMZ0vJ+NHhAqq1laRcFiQzQtNlWQS
	beOGCSna71VZm4EGV+xV2v9UkOt4nN8=
Date: Sat, 20 Dec 2025 15:05:43 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: let rxe_reclassify_recv_socket() call
 sk_owner_put()
To: Stefan Metzmacher <metze@samba.org>, linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, netdev@vger.kernel.org,
 linux-cifs@vger.kernel.org
References: <20251219140408.2300163-1-metze@samba.org>
 <9ccc0635-7c0e-4a18-8469-9c5b6d9b268f@linux.dev>
 <01cd3f5a-2976-45ad-8a2d-32b3e39c6317@samba.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <01cd3f5a-2976-45ad-8a2d-32b3e39c6317@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/12/20 5:05, Stefan Metzmacher 写道:
> Am 20.12.25 um 04:51 schrieb Zhu Yanjun:
>> 在 2025/12/19 6:04, Stefan Metzmacher 写道:
>>> On kernels build with CONFIG_PROVE_LOCKING, CONFIG_MODULES
>>> and CONFIG_DEBUG_LOCK_ALLOC 'rmmod rdma_rxe' is no longer
>>> possible.
>>>
>>> For the global recv sockets rxe_net_exit() is where we
>>> call rxe_release_udp_tunnel-> udp_tunnel_sock_release(),
>>> which means the sockets are destroyed before 'rmmod rdma_rxe'
>>> finishes, so there's no need to protect against
>>> rxe_recv_slock_key and rxe_recv_sk_key disappearing
>>> while the sockets are still alive.
>>>
>>> Fixes: 80a85a771deb ("RDMA/rxe: reclassify sockets in order to avoid 
>>> false positives from lockdep")
>>> Cc: Zhu Yanjun <zyjzyj2000@gmail.com>
>>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>>> Cc: Leon Romanovsky <leon@kernel.org>
>>> Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>> Cc: linux-rdma@vger.kernel.org
>>> Cc: netdev@vger.kernel.org
>>> Cc: linux-cifs@vger.kernel.org
>>> Signed-off-by: Stefan Metzmacher <metze@samba.org>
>>
>> Thanks a lot. IIRC, there is a similar commit for SIW driver. Thus, I 
>> am not sure if there is a similar problem in SIW driver or not.
>
> I don't think so, siw and the other place in rxe  are attached to 
> specific connections
> and there the reference is ok and needed.


Make sense. Thanks.

Yanjun.Zhu


>
> The problem was only related to the two global sockets with the lifetime
> the rdma_rxe is loaded.
>
> metze

-- 
Best Regards,
Yanjun.Zhu


