Return-Path: <linux-rdma+bounces-6606-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124039F50E8
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 17:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5843F163F20
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A67E1FBEAD;
	Tue, 17 Dec 2024 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="INbn1SEl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0531FBE92;
	Tue, 17 Dec 2024 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734452061; cv=none; b=O637h3y8XJJJEFVYuSr1ziAv8cGPVKY97qEo+V0aeY4azwVqeYl9cPCUtoOuD/NnhzMr3q7h7c5DadNpiZLwlTx0xfOfZjrmoeNWxPuTbTlPtPyfBDCeMg/H8pF+9+bW2b9bRWvDzHcg1oxuPUoWOJpL+1HR93YdTAKoWDgQ9zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734452061; c=relaxed/simple;
	bh=fn68lkIztwJWNwmzR+5z/QDQZTwctfhLrQRP2KLsDn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGwgIRAW9OuTKs6lXqDUbiqJAKr9L6o9lYvF+UhIO/CW9esYuG/Uxvm5hawkbKkBfgoAv45YLlngxoXNH+fhoXURPjUsuvA/rK+uP4/SMjkrKO+vXvsFiyZgDFbAB31KtVBfVGfP3fP7NM+vGsrFX/B7qsvYuwvDUZGIlKaLNi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=INbn1SEl; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YCMMG6tHFzlff0K;
	Tue, 17 Dec 2024 16:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734452056; x=1737044057; bh=xonCYOGgFAUqAOKqQpY+RP9M
	Z4FcCRSgpfbBid5J3/w=; b=INbn1SElovgX1I3KV0qrmVmwli/WkJMkTGdNPI2H
	xbiz06gAejUNO3CKrS+MK8EcifypZpgfMBq2fw2ivMD4AIP1P6lNGrB+wcrdKjk0
	vT8s0CUmjfU1ISQYL2aYnNLPv0/rxY4O+snzIiQ67q3tYQlvtYC3jO6dJO99UGNs
	Pf5jr+Fu0WwKDUkTCGVboYZaiQeLem0IxMrqwcX3cDh99BZ57Vn3yYQE5H25xWEn
	/tWB0pbOTBRabi3pThZci37sLiSyfXVM01lpEBPrXOJnzhq2u/JLtK6dCrcIh+jp
	tDhxtrzmJSqzXiL8k5s0IT2p15qGxXJTsMlNk7qHeedJlQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id KtVd_4J9W6lY; Tue, 17 Dec 2024 16:14:16 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YCMMB3LsZzlff0H;
	Tue, 17 Dec 2024 16:14:13 +0000 (UTC)
Message-ID: <2f74036c-7942-4e8b-8c71-6c413d722262@acm.org>
Date: Tue, 17 Dec 2024 08:14:13 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] RDMA/srp: Fix error handling in srp_add_port
To: Ma Ke <make_ruc2021@163.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241217104605.2924666-1-make_ruc2021@163.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241217104605.2924666-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 2:46 AM, Ma Ke wrote:
> Once device_add() failed, we should call only put_device() to
> decrement reference count for cleanup. We should not call device_del()
> before put_device().
> 
> As comment of device_add() says, 'if device_add() succeeds, you should
> call device_del() when you want to get rid of it. If device_add() has
> not succeeded, use only put_device() to drop the reference count'.
> 
> Found by code review.
> Cc: stable@vger.kernel.org
> Fixes: c8e4c2397655 ("RDMA/srp: Rework the srp_add_port() error path")
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

Patch descriptions should be in the imperative mood.

A blank line should separate the description and the tags.

Otherwise this patch looks good to me. Hence:

Signed-off-by: Bart Van Assche <bvanassche@acm.org>

