Return-Path: <linux-rdma+bounces-5273-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 808FD9932E5
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 18:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347E01F23BF3
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 16:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF661DB940;
	Mon,  7 Oct 2024 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3drM7R+3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C321DAC9F;
	Mon,  7 Oct 2024 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317651; cv=none; b=qIb++UuD3+L+YUIufxL3iQyS+iYH4YYmBwowzcZhSsNx39v7H2uuFktAklruIHEEqDakG+AvRy3eibs4hOk55+2gyTODlbbMLwv6u5WWvOCGnYT8Px+2tPn8G5acFJ+NdRxOTdkK94U74/jw1WYWejWu6c4cdwS1YohnJxcZyZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317651; c=relaxed/simple;
	bh=CCmhBFCYBYr01OUJLECkEKUOmxqvpyndRUbAYJYlxnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9lD/XOaDvpPaxmHwk663KEMeUwezb/7rUrjfFbpJV9urwZ7IOX1O+PYhcS3S93WqwFQd/WpT+K8L0zgzGVNY/UBC33TQZX0pxRSOGkYqMEP1Fo3aSnBPcayn1OQGGK0d4GMXIW6E7/FyNXPuj5TljPWAUxVD8RAD17evUNc9Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3drM7R+3; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XMkjs0SW0z6ClY9X;
	Mon,  7 Oct 2024 16:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1728317646; x=1730909647; bh=CCmhBFCYBYr01OUJLECkEKUO
	mxqvpyndRUbAYJYlxnA=; b=3drM7R+3dcTOXJSxeTyMspq8s3fGO2fUU67sla+z
	7U3kxNOz8kVzvGnctFwMGTNOj3Ccncz3SsTMnXbdkE8hfD/e7bZtalk5btho8og8
	TekWTETlrbApb5E+bC72bSpF5TS6YG8p5VpbkP8pNpyhJnPoEORolvGxZSw+rAYU
	0gZNuoIhStOgk2EI8lkv5GgXBjcsectL2KJzMScfyqg8Y2lOcBlvqVQFhP5jONsf
	i+wwaeZYAymj0f1XSSDcsIW7deeTFhY8Ij1gmwSoBF4ugIkCzEZcfS+CDdYWrahg
	wmAWQGQgsZk7xprhRcsWlpMX5AIIMOkzC2GVd/evnoXm/Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rk5oSylzfvkC; Mon,  7 Oct 2024 16:14:06 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XMkjp1Vjwz6ClY9L;
	Mon,  7 Oct 2024 16:14:05 +0000 (UTC)
Message-ID: <09ffcd22-8853-4bb3-8471-ef620303174b@acm.org>
Date: Mon, 7 Oct 2024 09:14:05 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/srpt: Make slab cache names unique
To: Jens Axboe <axboe@kernel.dk>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20241004173730.1932859-1-bvanassche@acm.org>
 <3108a1da-3eb3-4b9d-8063-eab25c7c2f29@linux.dev>
 <e9778971-9041-4383-8633-c3c8b137e92e@kernel.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e9778971-9041-4383-8633-c3c8b137e92e@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 7:06 AM, Jens Axboe wrote:
> Still seems way over engineered, just use an atomic_long_t for a
> continually increasing index number.

Even an atomic_long_t can wrap around and hence can result in duplicate
slab cache names. With my patch it is guaranteed that slab cache names
are unique. I'm not claiming that this patch is the best possible
solution but it's a working solution and a solution that doesn't require
too many changes to the ib_srpt driver.

Bart.



