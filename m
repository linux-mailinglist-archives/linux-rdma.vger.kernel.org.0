Return-Path: <linux-rdma+bounces-3911-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338F693839D
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jul 2024 08:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85EF1B20EEE
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jul 2024 06:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310D85C96;
	Sun, 21 Jul 2024 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uor6/RuC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22879D0
	for <linux-rdma@vger.kernel.org>; Sun, 21 Jul 2024 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721544086; cv=none; b=kXNx7TRlSKLYEte+iiVNfv4LnyPwF11wsuyUegjIGy1+3S8EuuICnO1Pk636mCG6hrpTW1WScS3TED9sm1YzrJP3ZljyqtMkvwSwrT0kLTxE9fFwRXTYLktD6g8T1Nsj63ZLALOVVjDGtSpJGUxWJ3cyLpxCDGMYUCxpksQtN6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721544086; c=relaxed/simple;
	bh=h/FKIp9xMFC2FXIsZqzoruSg8zaMec3+Ui8zW18MmKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZzbcIQHax4EpvJDgI8hf25kun2y9LvdOUV2nhH//JlcyiRJCY6OeAzWS+SQcpArlz49Qvx5GNVwLbKO6FyRqrz0PSiT8WJIG6WDAypYaZkxRoP9pDc6HFrtWi9hUsT+92xVURfkjTDlL8TFzTKpnBD/OC3l4wxxX891hJAZmHH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uor6/RuC; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux@treblig.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721544081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BhzfpEAkMtM1dmk7F6Pxzl6Zv6RGXBbJz8lZCjiaexQ=;
	b=uor6/RuCwrfZtEtZCy6VtHgqA+hWDOenHgRlRfXTHv5Gle8KjTjI/DKXe4bWNxd2aglWyq
	d5BsLBAtqD3aN0bXBGKL/KnKkQX2hMSa0Yr6Lqeq8pQ8ytbZ+VN5neXfiDSrTHY45Ay13K
	BJM2+XA9NCPsxiHaH6Xw0ztPDvekqCs=
X-Envelope-To: allison.henderson@oracle.com
X-Envelope-To: davem@davemloft.net
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: rds-devel@oss.oracle.com
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <8b5fd878-a952-4cca-87af-aa44319a4f86@linux.dev>
Date: Sun, 21 Jul 2024 08:41:17 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rds: remove unused struct 'rds_ib_dereg_odp_mr'
To: linux@treblig.org, allison.henderson@oracle.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20240531233307.302571-1-linux@treblig.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240531233307.302571-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/6/1 1:33, linux@treblig.org 写道:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'rds_ib_dereg_odp_mr' has been unused since the original
> commit 2eafa1746f17 ("net/rds: Handle ODP mr
> registration/unregistration").
> 
> Remove it.
> 
Need Fixes?

Fixes: 2eafa1746f17 ("net/rds: Handle ODP mr
registration/unregistration")

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>   net/rds/ib_rdma.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/net/rds/ib_rdma.c b/net/rds/ib_rdma.c
> index 8f070ee7e742..d1cfceeff133 100644
> --- a/net/rds/ib_rdma.c
> +++ b/net/rds/ib_rdma.c
> @@ -40,10 +40,6 @@
>   #include "rds.h"
>   
>   struct workqueue_struct *rds_ib_mr_wq;
> -struct rds_ib_dereg_odp_mr {
> -	struct work_struct work;
> -	struct ib_mr *mr;
> -};
>   
>   static void rds_ib_odp_mr_worker(struct work_struct *work);
>   


