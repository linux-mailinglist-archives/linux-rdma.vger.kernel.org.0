Return-Path: <linux-rdma+bounces-585-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE90982912B
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jan 2024 01:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61DF31F2630B
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jan 2024 00:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D60C63D;
	Wed, 10 Jan 2024 00:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J/T643ap"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7450383
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jan 2024 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a4364632-3ab0-477e-96dc-d276479d4e19@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704845717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffxVLH87KRr6B9kcKIEQq8DyZSXe/NjqG0PIapgXwSI=;
	b=J/T643apHZ0O7XaCKwpiXS4UTBm8Ys7Tet0z5SPcZXq5k3Z5LgiRMg4yMV4i7401tANG/y
	vzTrnwvZsE4NjmgH3zvN6xC/zsxaAuq6valDtlIvZxRsrjl2t+69jUU3kUUNdxTJBtjkvy
	r3BfZfL3H5vqKYOjrJxNqibjfbUXjl4=
Date: Wed, 10 Jan 2024 08:15:12 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v4 2/2] RDMA/rxe: Remove rxe_info from
 rxe_set_mtu
To: Li Zhijian <lizhijian@fujitsu.com>, linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
 linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com
References: <20240109083253.3629967-1-lizhijian@fujitsu.com>
 <20240109083253.3629967-2-lizhijian@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240109083253.3629967-2-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/1/9 16:32, Li Zhijian 写道:
> commit 9ac01f434a1e ("RDMA/rxe: Extend dbg log messages to err and info")

Thanks. Maybe move this "commit 9ac01f434a1e ("RDMA/rxe: Extend dbg log 
messages to err and info")" to Fixes tag, is it better?

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> newly added this info. But it did only show null device when
> the rdma_rxe is being loaded because dev_name(rxe->ib_dev->dev)
> has not yet been assigned at the moment:
> 
> "(null): rxe_set_mtu: Set mtu to 1024"
> 
> Remove it to silent this message, check the mtu from it backend link
> instead if needed.
> 
> CC: Bob Pearson <rpearsonhpe@gmail.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V4: Remove it rather than re-order rxe_set_mtu() and rxe_register_device()
> ---
>   drivers/infiniband/sw/rxe/rxe.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index a086d588e159..ae466e72fc43 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -160,8 +160,6 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
>   
>   	port->attr.active_mtu = mtu;
>   	port->mtu_cap = ib_mtu_enum_to_int(mtu);
> -
> -	rxe_info_dev(rxe, "Set mtu to %d\n", port->mtu_cap);
>   }
>   
>   /* called by ifc layer to create new rxe device.


