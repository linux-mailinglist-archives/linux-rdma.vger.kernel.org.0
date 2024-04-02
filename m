Return-Path: <linux-rdma+bounces-1738-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CAC895413
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 14:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E031C22347
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 12:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90B47F462;
	Tue,  2 Apr 2024 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dDI9Xo/i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C367A151
	for <linux-rdma@vger.kernel.org>; Tue,  2 Apr 2024 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062658; cv=none; b=TNfA185BuzYFURa5RreF/X25E7GiGvCwYUunibDEwHq3t6W0G/XYtj3Tt54rVAmRBDhXBJXGalpqr32Cf+QxVS14LkEipmFMv4Tkp2F0Vp2oKzYflApeBlrl+iAQDGSDOUYoFldgyDCvwxxlLJOjQuldkDmWnVJqxvOZ1FKXCqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062658; c=relaxed/simple;
	bh=1YYYsHiX4QxVJC14JG4cIayvVJ6JlEWD6XqyZtDHGOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oX4UeDKdiVnaG7SRTbVfSVUJrRsUMPHz6LMg4aJt0m1WzWbOea/hv235ydVnhq9cDapKP8miehdMJ+LFoTJYT6sR/sS/iHdwaKB7lEPd52J+Qy0MU8cHjD9eBMtalARYIT73BGFkmqvAYWRmqAqwbAVo1kS9gtqgUJYD0Zt7Kd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dDI9Xo/i; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cfe8e539-5521-464e-870a-eca503835657@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712062654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNiWDTFYV85/LysEIcKFEQmrDHtcaY9ZGXKflrA9HoQ=;
	b=dDI9Xo/iqfMM8QHFJzQkXPtnJO6O5TFnhUvLZvDtqGaHGwrXAcTlt/eIZ4tjLCno0hCOZh
	YAxE6QDF+j4shShF6z9sg2f1aLt31UT23MlCIfjlF0k4pCP75YqRZT78X+iUNVKr3gKJBy
	CySdp0kZjoXsQsBryBnGtp/NYUuo20A=
Date: Tue, 2 Apr 2024 14:57:30 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next 02/11] RDMA/rxe: Allow good work requests to be
 executed
To: Bob Pearson <rpearsonhpe@gmail.com>, jgg@ziepe.ca, leon@kernel.org,
 linux-rdma@vger.kernel.org, jhack@hpe.com
References: <20240326174325.300849-2-rpearsonhpe@gmail.com>
 <20240326174325.300849-4-rpearsonhpe@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240326174325.300849-4-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 26.03.24 18:43, Bob Pearson wrote:
> A previous commit incorrectly added an 'if(!err)' before scheduling
> the requester task in rxe_post_send_kernel(). But if there were send
> wqes successfully added to the send queue before a bad wr they might
> never get executed.
>
> This commit fixes this by scheduling the requester task if any wqes were
> successfully posted in rxe_post_send_kernel() in rxe_verbs.c.
>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> Fixes: 5bf944f24129 ("RDMA/rxe: Add error messages")
> ---
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 614581989b38..a49784e5156c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -888,6 +888,7 @@ static int rxe_post_send_kernel(struct rxe_qp *qp,
>   {
>   	int err = 0;
>   	unsigned long flags;
> +	int good = 0;


 From the usage of the local variable good, can we declare it as bool?

Thanks,

Zhu Yanjun

>   
>   	spin_lock_irqsave(&qp->sq.sq_lock, flags);
>   	while (ibwr) {
> @@ -895,12 +896,15 @@ static int rxe_post_send_kernel(struct rxe_qp *qp,
>   		if (err) {
>   			*bad_wr = ibwr;
>   			break;
> +		} else {
> +			good++;
>   		}
>   		ibwr = ibwr->next;
>   	}
>   	spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
>   
> -	if (!err)
> +	/* kickoff processing of any posted wqes */
> +	if (good)
>   		rxe_sched_task(&qp->req.task);
>   
>   	spin_lock_irqsave(&qp->state_lock, flags);

