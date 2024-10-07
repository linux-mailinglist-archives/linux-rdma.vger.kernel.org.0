Return-Path: <linux-rdma+bounces-5278-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EA199349A
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 19:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB611C23C4E
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 17:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7AE1DCB1D;
	Mon,  7 Oct 2024 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="GATlrPig"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65391DD556;
	Mon,  7 Oct 2024 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321387; cv=none; b=AatdbbBCKpB6vPM/kWaJYS/uwXSk2gKzNYEaKLa5QHXRVVZaH7JNQk4GarQpbkZEua/H68m+oXG9S92XZroqjyvA1TEi2qc2TZ8FEpjcBVfFv8OedPEYsBuspYVmJbpXzKoUbSlGiqb4uz7Bqw0LbZT68626x+gTsEJaA/EI2CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321387; c=relaxed/simple;
	bh=C7/n+9dmn2lugRE7XQCnzetT1uNHZROQmL5yAzm+h4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqIc4CZZOmYH3zsw3aJGLCu3y2ZypEZD3AENdVj3xNiFxHap5raq5osb2bAPgWnGVK3yyP5oKUmOfLvZ6EvIbjtAiALqGl7yqRb4lvnCusftyrUmdqpWQenOwZS1TAlUJrlq8a0ylQ3Cz+kfT5fOu/EgJPe5+C1cO+rzcbjQ1Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=GATlrPig; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XMm5j27MNzlgTWP;
	Mon,  7 Oct 2024 17:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1728321383; x=1730913384; bh=MS9F57xixI/8zesCw9YF0mvk
	MymvHl5vF+tYKWcs+Iw=; b=GATlrPigzY7u3td4PHSxnTewBx86UatFzMFGCoyA
	X5d4CkHGGyTXvZ2atBFQMPzSyi+jc6LzKavOLHQyK5h2UbDOuFRkUkVltn09gzCf
	4DXJVSTgqlbw3ZHrrQcUFcCL4CgPVBqivvgobqPkQjjExH8qByTiCt7pFIdZ0jkB
	DXvxOS1TIfH3XV/cySXn6dr4JtQ1RwCaVqXtWL6vsUx7Qb3wb6wlD9PZTRvXsGjs
	fZQ5m3Gk09E4528nkcuddkw7YBYR/jFAUwCAgb3Jog5ezOHpWaoHCgfmiRQSs+/E
	vvXRJTVniGjiQCteg387k1C8Ojy5yJzF+7XnQeizsRePyg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id g338_l7Evgff; Mon,  7 Oct 2024 17:16:23 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XMm5f6RZzzlgTWK;
	Mon,  7 Oct 2024 17:16:22 +0000 (UTC)
Message-ID: <91a24201-8ab9-45b3-ba1f-26f4fb3f2ecf@acm.org>
Date: Mon, 7 Oct 2024 10:16:22 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/srpt: Make slab cache names unique
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20241004173730.1932859-1-bvanassche@acm.org>
 <3108a1da-3eb3-4b9d-8063-eab25c7c2f29@linux.dev>
 <e9778971-9041-4383-8633-c3c8b137e92e@kernel.dk>
 <09ffcd22-8853-4bb3-8471-ef620303174b@acm.org>
 <09aa620c-b44b-41d2-a207-d2cc477fdad2@kernel.dk>
 <04daaf4c-9c62-404e-8c5e-1fffb3f2ecbd@acm.org>
 <20241007165534.GW1365916@nvidia.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241007165534.GW1365916@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 9:55 AM, Jason Gunthorpe wrote:
> On Mon, Oct 07, 2024 at 09:52:05AM -0700, Bart Van Assche wrote:
>> Do you agree that in this case it is safe not to check whether
>> ida_alloc() succeeds?
> 
> It seems like a way to attract static checker bug fix patches :\

Got it. I will add error handling for ida_alloc() failures.

Thanks,

Bart.


