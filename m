Return-Path: <linux-rdma+bounces-4270-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3936794CF33
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 13:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7832842AD
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 11:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00213192B89;
	Fri,  9 Aug 2024 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IpZsukK/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EE6192B85
	for <linux-rdma@vger.kernel.org>; Fri,  9 Aug 2024 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723201608; cv=none; b=AqBKqmP0T30ZFeADOJkmcmwJK5k7wDcQbTBLJZJlVnBrOBFYK5Nd23Ct/sHvUB0+7Ije48KvuHbA/8chhFrD1Y/uyL77CCtWw0pCPVn4z4NqNnN1NTZrKe8IayoJbI9ZI/TnvOVkoLzJcceb/9Ww2ZfPCpJsCQHt1i+dJiwuC6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723201608; c=relaxed/simple;
	bh=FsJH1oPqe3J/n++J6VIPiS1aVwUObinBK31JK09xJKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebzsRYnV3zCHMJIewxTJOTlIVoi7l5FsrHKIRk8p4INzpW4F4ol7d54KNcme/3wZxOxFD5TiwNtszIXEdrHrxkRaELb+4l9Jbs7O8QpwQqay0V1SVgvkvqxUJX5Jpj2KPaNEsVya5//nSYLBx8UDqk+4DcJ8vRT8AOOmGdcO29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IpZsukK/; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <72029ea9-f550-470e-9e5d-42e95ca4592e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723201605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7a9Ts4/llGMmUnxlPjxeNlOYr1Ij9hhyDHvMU74sFI=;
	b=IpZsukK/a5/ex/aAZ/5Zsl+OJ8uXj1Z5S0iKkcYXpb+nLQCE7JXHkikU+TELGULkIpkYOZ
	ShOFd5D++dDSGBUIs8yK9MYfrttj7n/T2MwYK7gxy/bLx69HdM1CMfuvTNbG6hxFBMEyxy
	ToxvGFBuyIh7fLeayJocmXHdTTjUKWQ=
Date: Fri, 9 Aug 2024 19:06:34 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 4/4] RDMA/rxe: Set queue pair cur_qp_state when
 being queried
To: Liu Jian <liujian56@huawei.com>, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org
Cc: jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20240809083148.1989912-1-liujian56@huawei.com>
 <20240809083148.1989912-5-liujian56@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240809083148.1989912-5-liujian56@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/8/9 16:31, Liu Jian 写道:
> Same with commit e375b9c92985 ("RDMA/cxgb4: Set queue pair state when
>   being queried"). The API for ib_query_qp requires the driver to set
> cur_qp_state on return, add the missing set.
> 

Add the following?
Cc: stable@vger.kernel.org

> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 5c18f7e342f2..699b4b315336 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -634,6 +634,8 @@ static int rxe_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>   	rxe_qp_to_init(qp, init);
>   	rxe_qp_to_attr(qp, attr, mask);
>   
> +	attr->cur_qp_state = qp->attr.qp_state;

I am fine with this commit.

But I think this "attr->cur_qp_state = qp->attr.qp_state;" should be put 
into this function rxe_qp_to_attr.

And the access to qp->attr.qp_state should be protected by spin lock 
qp->state_lock.

So the following is better.
Any way, thanks.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c 
b/drivers/infiniband/sw/rxe/rxe_qp.c
index d2f7b5195c19..da723b9690e5 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -782,6 +782,10 @@ int rxe_qp_to_attr(struct rxe_qp *qp, struct 
ib_qp_attr *attr, int mask)
                 spin_unlock_irqrestore(&qp->state_lock, flags);
         }

+       spin_lock_irqsave(&qp->state_lock, flags);
+       attr->cur_qp_state = qp_state(qp);
+       spin_unlock_irqrestore(&qp->state_lock, flags);
+
         return 0;
  }

Best Regards,
Zhu Yanjun

> +
>   	return 0;
>   }
>   


