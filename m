Return-Path: <linux-rdma+bounces-3280-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8845390D849
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 18:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6CE2873BA
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 16:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133E74D8C3;
	Tue, 18 Jun 2024 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NhmEOlrQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F3478C91
	for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2024 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726910; cv=none; b=YPS3rNScTZGOoYeRzO/TbgI9N8fTz0J1BZQcZK3cgqTKQ1eWXdL3FbkC8pCB7KVGihMlxpiqW5+PWCPCtedbPdlqD/9ktyIQbU8MEFUyY4eIQNzQ4wEdzYc6XD69HQVrJKN1+XgTPG89Bca84C9DtuJENm1dF5R1iPuNBvksMDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726910; c=relaxed/simple;
	bh=zQE1Db58c3BcnTUqIHQ26a76O5g/BAzVpDdPihh7U6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0bQHci8yz4B8O5n5cap10tJHey/GnlnwPD7i02CKf6oqfzUKVpip2+cz41v914Bkt6urQe+O/OAx2jeq6Z7qHxeMXl92ZfKB6Q9CBGlZbVsXvPdAI+tDbl5v/szUxkHSz8IEW2WIYZSIeOVJehCofB9m17H+QOM72CM3OK3Mgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NhmEOlrQ; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4W3WrX6QzlzlgMVS;
	Tue, 18 Jun 2024 16:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1718726904; x=1721318905; bh=rXm22aa4uNfLbj5oHoqEtahn
	hATqX9TBEK1apmGNxQQ=; b=NhmEOlrQaPts2vm1dA+hSzHL6zOzrF14r201rIfL
	WlXlzeNTFzxO3m0fXXUsdX+kySWS3S76lquG6v2/lZ2rqKpCvzfh23IK2ejHj/Bx
	AkERAjTTcjyMZlWXvgKUNjr9Xa8msRXHpaTH7DGbD3wkOehhCfqWeBQFQEXdYQXv
	fCLVFxHncNpYCDHkZLpzl2sioB8YsLHXX96YZdw8ppkslr0B57KG+CritpB9jvAE
	lffmqU3Zq2G8qyeqkNu9+cgOufkFM3jEhJDtUtSnruw6t6uYvPF95IQj6Qirx/b1
	Lm/hahq2/c0bSjSEcyyqiJwn51fOBXJMjNEFDLG8dFtauw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id a2Ikwti1Rv3a; Tue, 18 Jun 2024 16:08:24 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4W3WrP3F8YzlgMVR;
	Tue, 18 Jun 2024 16:08:21 +0000 (UTC)
Message-ID: <8d8ada7d-81c1-4706-9263-7854a7847a85@acm.org>
Date: Tue, 18 Jun 2024 09:08:18 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] RDMA/srpt: remove the handling of last WQE reached
 event
To: Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, shiraz.saleem@intel.com, edumazet@google.com
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
 <20240618001034.22681-4-mgurtovoy@nvidia.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240618001034.22681-4-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/24 5:10 PM, Max Gurtovoy wrote:
> This event is handled by the RDMA core layer.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/infiniband/ulp/srpt/ib_srpt.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 9632afbd727b..8503f56b5202 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -231,11 +231,6 @@ static void srpt_qp_event(struct ib_event *event, void *ptr)
>   		else
>   			ib_cm_notify(ch->ib_cm.cm_id, event->event);
>   		break;
> -	case IB_EVENT_QP_LAST_WQE_REACHED:
> -		pr_debug("%s-%d, state %s: received Last WQE event.\n",
> -			 ch->sess_name, ch->qp->qp_num,
> -			 get_ch_state_name(ch->state));
> -		break;
>   	default:
>   		pr_err("received unrecognized IB QP event %d\n", event->event);
>   		break;

Acked-by: Bart Van Assche <bvanassche@acm.org>

