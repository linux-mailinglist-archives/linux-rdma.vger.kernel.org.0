Return-Path: <linux-rdma+bounces-2960-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F03778FF5D7
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 22:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6D92892E3
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 20:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64102757E7;
	Thu,  6 Jun 2024 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JyOXOAjJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E076A19D89B
	for <linux-rdma@vger.kernel.org>; Thu,  6 Jun 2024 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717705752; cv=none; b=RxJmt2n046WKzDXvtm5ynzvcv5Z6hjZ0FKd9OiAtPAFRkobBgHFXmutWJlBIvKNUe6VJ2q/ZVLGwoeiqio0Gs1G7HbqZ/Ai0u8PX3/rNmlOhtIrfw9IkXLW7uZGGV1zVBGgvjGd6CfdhcG44uRnmTx0VeOOpNaYK8br+/xdOeYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717705752; c=relaxed/simple;
	bh=eo+0M2noRiaZznQk+qnw59T4C87BFNMZ7nD8Bsc+110=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eO29yrCtP7XxbdWH1Tx34YMC5X096ugTUKFHgph0EnEOzwAXZQ2WijvGd0kiw29ByOyeaaAJhnw1SlISgZaMwj4zJO8/otkwFtVj3bfTR+d4xVAc95rCCw2AS7weWCmOodtwEHmioDMIq6AYpS3YX4XC/q9jo/Jzj4JEQvT+2I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JyOXOAjJ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bvanassche@acm.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717705747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giQGQOjZ9c/ECOWVAx+0DHYTrbt0G04j8/SiVrDzWww=;
	b=JyOXOAjJFcw2dMHX1xXG60tlFY/hzji5Kgx5yJhZpB3kvMfcJgEo1QCHIybKuDiJm5xMSO
	V+DXQqFS4fbKcEBkT9M4PQkB+RL4c2PZxjPM4WG8beENlPXaPE91QZ4giMmeIoZJnNzD+v
	zY1kfPWGx1SGRXn07aLPnseFdEUsGrA=
X-Envelope-To: jgg@nvidia.com
X-Envelope-To: shinichiro.kawasaki@wdc.com
X-Envelope-To: zyjzyj2000@gmail.com
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: leon@kernel.org
X-Envelope-To: j.granados@samsung.com
X-Envelope-To: mcgrof@kernel.org
Message-ID: <5b3059aa-7f8e-41ac-b2ca-59f6554c1e83@linux.dev>
Date: Thu, 6 Jun 2024 22:29:02 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] RDMA/iwcm: Use list_first_entry() where appropriate
To: Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Joel Granados <j.granados@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>
References: <20240605145117.397751-1-bvanassche@acm.org>
 <20240605145117.397751-2-bvanassche@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240605145117.397751-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/6/5 16:50, Bart Van Assche 写道:
> Improve source code readability by using list_first_entry() where appropriate.
>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/infiniband/core/iwcm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
> index 0301fcad4b48..90d8f3d66990 100644
> --- a/drivers/infiniband/core/iwcm.c
> +++ b/drivers/infiniband/core/iwcm.c
> @@ -143,8 +143,8 @@ static struct iwcm_work *get_work(struct iwcm_id_private *cm_id_priv)
>   
>   	if (list_empty(&cm_id_priv->work_free_list))
>   		return NULL;
> -	work = list_entry(cm_id_priv->work_free_list.next, struct iwcm_work,
> -			  free_list);
> +	work = list_first_entry(&cm_id_priv->work_free_list, struct iwcm_work,
> +				free_list);

The followings are the definitions of list_entry and list_first_entry.

#define list_entry(ptr, type, member) \

     container_of(ptr, type, member)

#define list_first_entry(ptr, type, member) \
     list_entry((ptr)->next, type, member)F

 From the above, IMO, this commit is fine.

Thanks.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>   	list_del_init(&work->free_list);
>   	return work;
>   }
> @@ -1023,8 +1023,8 @@ static void cm_work_handler(struct work_struct *_work)
>   	spin_lock_irqsave(&cm_id_priv->lock, flags);
>   	empty = list_empty(&cm_id_priv->work_list);
>   	while (!empty) {
> -		work = list_entry(cm_id_priv->work_list.next,
> -				  struct iwcm_work, list);
> +		work = list_first_entry(&cm_id_priv->work_list,
> +					struct iwcm_work, list);
>   		list_del_init(&work->list);
>   		empty = list_empty(&cm_id_priv->work_list);
>   		levent = work->event;

-- 
Best Regards,
Yanjun.Zhu


