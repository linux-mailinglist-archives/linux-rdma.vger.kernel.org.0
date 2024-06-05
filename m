Return-Path: <linux-rdma+bounces-2918-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8878FD765
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 22:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABA01C21EE7
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 20:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE45115E5D7;
	Wed,  5 Jun 2024 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t0xJrHMq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE6115E5DD
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717618670; cv=none; b=QMAdgvL9Fi/4TzT9RmyTImtpi3IISY+9qytoLtV4zWOjEG9BFMZrWM+kjUPiUHjZkxjv5u3tHfU6GhK+qAuyIg8B10xJSkSJgjbLho+JvzuPU5GmfKI/9OcoC12f0IXe+qNp4RI24J5QyMM2fsaIGAztoa8WdpMjFn+bWKbqkEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717618670; c=relaxed/simple;
	bh=l52cIxYSTS3F9eaBpJrzXujuvrRMnAin4tQhn98+osU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXs6bYHiM6nDjXinaUmTUru8lZpoSCdmZpOcXo29+/nXXx3HBlnrnFBjSul0QNqC479MEB2ybm7zcgLhHusx+zW2t1q0nQwkmEboC9lwEoY+tswItatETPfpyVHnsJkVxnOzLP2VdlGLMtG0YsBS9raGlRUeJDvQCwnC1syNrAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t0xJrHMq; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bvanassche@acm.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717618666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7nItL7NzxTcAYy6SlCvTz5mBf/7GQ7aUFVl0/Cje998=;
	b=t0xJrHMqMlFktN1Wfhbo/Lfitjs15EbcGjvLQ2oM9qHWntNzT6KUwVE2+/wtsatpObx3ku
	ZJWwHKXNTHs6dy7AiMux87ADFPL5CmzYj99hGd3Xl05OE41Hvl/Uqis7W6rpIUU9ZkKu+L
	B5N0PdJD2KT3bayDxR56ZZe4asVkymI=
X-Envelope-To: jgg@nvidia.com
X-Envelope-To: shinichiro.kawasaki@wdc.com
X-Envelope-To: zyjzyj2000@gmail.com
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: leon@kernel.org
X-Envelope-To: j.granados@samsung.com
X-Envelope-To: mcgrof@kernel.org
Message-ID: <860f0717-8bd0-4ad2-acb7-28220bddc9a8@linux.dev>
Date: Wed, 5 Jun 2024 22:17:38 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] RDMA/iwcm: Change the return type of iwcm_deref_id()
To: Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Joel Granados <j.granados@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>
References: <20240605145117.397751-1-bvanassche@acm.org>
 <20240605145117.397751-3-bvanassche@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240605145117.397751-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/6/5 16:50, Bart Van Assche 写道:
> Since iwcm_deref_id() returns either 0 or 1, change its return type from
> 'int' into 'bool'.
>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

I am fine with this. Thanks a lot.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/core/iwcm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
> index 90d8f3d66990..ae9c12409f8a 100644
> --- a/drivers/infiniband/core/iwcm.c
> +++ b/drivers/infiniband/core/iwcm.c
> @@ -206,17 +206,17 @@ static void free_cm_id(struct iwcm_id_private *cm_id_priv)
>   
>   /*
>    * Release a reference on cm_id. If the last reference is being
> - * released, free the cm_id and return 1.
> + * released, free the cm_id and return 'true'.
>    */
> -static int iwcm_deref_id(struct iwcm_id_private *cm_id_priv)
> +static bool iwcm_deref_id(struct iwcm_id_private *cm_id_priv)
>   {
>   	if (refcount_dec_and_test(&cm_id_priv->refcount)) {
>   		BUG_ON(!list_empty(&cm_id_priv->work_list));
>   		free_cm_id(cm_id_priv);
> -		return 1;
> +		return true;
>   	}
>   
> -	return 0;
> +	return false;
>   }
>   
>   static void add_ref(struct iw_cm_id *cm_id)

-- 
Best Regards,
Yanjun.Zhu


