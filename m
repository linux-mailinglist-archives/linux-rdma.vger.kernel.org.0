Return-Path: <linux-rdma+bounces-15433-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AC8D1011B
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jan 2026 23:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 798AF300FEE6
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jan 2026 22:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B683225788;
	Sun, 11 Jan 2026 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zt51+qxU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998F1E32D6
	for <linux-rdma@vger.kernel.org>; Sun, 11 Jan 2026 22:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768170723; cv=none; b=Ge9RNY5NAh+4SJLI97TZlfYujNzpe8HowVDZjsZn0YXu+O91+p8iTaXmGEDSKQ7qICQpiVX/JrupbViba1Uwj7vCI29unulbZbVQ8q+DOa8EmIfWEs7gct5blxr5NuVjxGCnvaNvmX5N8fcT7cGTCBX1Bekd0M9v10v8v2UQV7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768170723; c=relaxed/simple;
	bh=hnvL56/yFRJx6NepZm2sOSiT0QBzqPBgdMLE1NjEv94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPhcUVhied4WV0mjDsup1s5Wo5AjkzS6Ei2GuBTjL/c6Hhx8lwyBmgEMRQzsE/7CUuXC2l6TYCZTXoWpaAKiExhOE8Tgpu0IgmfmDLwTxkCw16sbV+Ao3LGcEGg5/I3B5M5ZN9jqaQMLbBM9lXcX5it0VzcGbbwwrzgj2+DFqrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zt51+qxU; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <721999a4-760f-4c57-84f2-be1753dd8307@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768170709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjh8xZO5Kemq9dv6nBbPACq8+RfwadzX5wI/CMwfMGg=;
	b=Zt51+qxUPJ8oElmmhw4kmSs3Nr1b0pRAlP4wJDzNUzrziM6DtoczR8ML5casd8nKurkIJC
	Yw/v4vExHEtH4FpiKh2P3wRbRLlvtt9rOG8+6orlDP840XhdqNEUe9VYdCjyKUI3aCLuhx
	7T4xUV7K/i8Nq1YEaCGDufPqVsUczEU=
Date: Sun, 11 Jan 2026 14:31:35 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Fix double free in rxe_srq_from_init
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260111171245.17759-1-jiashengjiangcool@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260111171245.17759-1-jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/1/11 9:12, Jiasheng Jiang 写道:
> In rxe_srq_from_init(), the queue pointer 'q' is assigned to
> 'srq->rq.queue' before copying the SRQ number to user space.
> If copy_to_user() fails, the function calls rxe_queue_cleanup()
> to free the queue, but leaves the now-invalid pointer in
> 'srq->rq.queue'.
> 
> The caller of rxe_srq_from_init() (rxe_create_srq) eventually
> calls rxe_srq_cleanup() upon receiving the error, which triggers
> a second rxe_queue_cleanup() on the same memory, leading to a
> double free.
> 
> Fix this by setting 'srq->rq.queue' to NULL after the initial
> cleanup in the error path.

In the function rxe_srq_from_init,

  80     srq->rq.queue = q;
  81     init->attr.max_wr = srq->rq.max_wr;
  82
  83     if (uresp) {
  84         if (copy_to_user(&uresp->srq_num, &srq->srq_num,
  85                  sizeof(uresp->srq_num))) {
  86             rxe_queue_cleanup(q);
  87             return -EFAULT;
  88         }
  89     }

If we move the following
"
srq->rq.queue = q;
init->attr.max_wr = srq->rq.max_wr;
"
after copy_to_user, it seems also to be able fix the mentioned problem.
The commit is like this:
"
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c 
b/drivers/infiniband/sw/rxe/rxe_srq.c
index 2a234f26ac10..c9a7cd38953d 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -77,9 +77,6 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct 
rxe_srq *srq,
                 goto err_free;
         }

-       srq->rq.queue = q;
-       init->attr.max_wr = srq->rq.max_wr;
-
         if (uresp) {
                 if (copy_to_user(&uresp->srq_num, &srq->srq_num,
                                  sizeof(uresp->srq_num))) {
@@ -88,6 +85,9 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct 
rxe_srq *srq,
                 }
         }

+       srq->rq.queue = q;
+       init->attr.max_wr = srq->rq.max_wr;
+
         return 0;

  err_free:
"

But "make srq->rq.queue to NULL" can also fix this problem.

I am fine with this. Thanks a lot.

BTW, if you can post the call trace in commit log, it is better.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Thanks a lot.

Zhu Yanjun

> 
> Fixes: aae0484e15f0 ("IB/rxe: avoid srq memory leak")
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_srq.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
> index 2a234f26ac10..c527c1cbd4ec 100644
> --- a/drivers/infiniband/sw/rxe/rxe_srq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_srq.c
> @@ -84,6 +84,7 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
>   		if (copy_to_user(&uresp->srq_num, &srq->srq_num,
>   				 sizeof(uresp->srq_num))) {
>   			rxe_queue_cleanup(q);
> +			srq->rq.queue = NULL;
>   			return -EFAULT;
>   		}
>   	}


