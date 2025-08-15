Return-Path: <linux-rdma+bounces-12768-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35517B277BF
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 06:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3EE1CE7213
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 04:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FED021A43C;
	Fri, 15 Aug 2025 04:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="arJnlrSe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68EB1DA60D;
	Fri, 15 Aug 2025 04:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755231921; cv=none; b=jEiChaV3AHdaUb99bhHRQ46aYcDDZcwhoqBl0ygDuHDxusoRwsRJF6tocqNmtD9tz9t1a0yB4lNH3SK0Z9RCVjWcaJIyWy2GTKm43gaLhJU0ikxkPWhbWu80wN7b5R/OpStndyDEip3ug6jFJngw5IWCMrWJArUYavabkLWCyR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755231921; c=relaxed/simple;
	bh=kFkieBi7PUZefGsFJTSoYxsLTdAtWlB4HN8rGN4R0/M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OtGduF3hk/LJeRihM0Pc38OnbSEJ4J03gw/jW8baC9S67SO9Bnt8oc85QrBdusvgkgt+YpQaTT9CElYPpdETzEZSqFQlVAuasgKM2b/aiCSCrHZboufR+xAnqxH8xV/nmORNxywwyDWUZWYaWBJn+TE7tYEOpxzyyYB8IKyGnCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=arJnlrSe; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4b91db63-8a6d-4491-8882-276f115a4df8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755231917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ifOFromZjXEtPKIclvimCi6WC232FpS9F3lJXJl0+kA=;
	b=arJnlrSe9AWqgtAAd5oZWkUi9Pg4zRUewBGmDgWkwFISMxbNPK6r4TxSvS6ONcMUIEKx9/
	3En4e34Vh00uAJRBCYLfxbMkt3tauiBEp/1wEAcqK8lw2jrKOR2xpw7cdM9OifS6QpCmPK
	lrm8rHpwPezizTWldVU5bhN5uHED6to=
Date: Thu, 14 Aug 2025 21:25:00 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] rdma_rxe: call comp_handler without holding cq->cq_lock
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: Daisuke Matsuda <dskmtsd@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250806123921.633410-1-philipp.reisner@linbit.com>
 <5a31f3ef-358f-4382-8ad1-8050569a2a23@linux.dev>
 <CADGDV=UgDb51nEtdide7k8==urCdrWcig8kBAY6k0PryR0c7xw@mail.gmail.com>
 <2b593684-4409-485b-9edf-e44a402ecf3a@linux.dev>
 <6dbc1383-0c9f-4648-ae8d-4219e89589f4@gmail.com>
 <885bb38c-4108-4fa2-a6d2-1e60d5e84af9@linux.dev>
 <620f8611-1e95-4ebd-9db2-eb7231cfb3f2@gmail.com>
 <3cb43241-20d7-4ac9-b055-373fd058b3a3@linux.dev>
 <2e645d1c-f853-4cee-9590-6f01820d027b@linux.dev>
In-Reply-To: <2e645d1c-f853-4cee-9590-6f01820d027b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

>>>
>>> ===
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c 
>>> b/drivers/infiniband/sw/rxe/rxe_comp.c
>>> index a5b2b62f596b..a10a173e53cf 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
>>> @@ -454,7 +454,7 @@ static void do_complete(struct rxe_qp *qp, 
>>> struct rxe_send_wqe *wqe)
>>>         queue_advance_consumer(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
>>>
>>>         if (post)
>>> -               rxe_cq_post(qp->scq, &cqe, 0);
>>> +               while (rxe_cq_post(qp->scq, &cqe, 0) == -EBUSY);

Just now the maillist notified the mail was not sent successfully. Thus 
I resend it now.


Do you make tests with your commit in the local hosts?


I have applied your commit and made tests in my local host. I run the 
tests for 10000 times.

Sometimes problems occurred. I am not sure if this problem is related 
with this commit or not.

I will make further investigations about this problem.

Yanjun.Zhu

