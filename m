Return-Path: <linux-rdma+bounces-2503-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A54B78C721A
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 09:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A92B1F21684
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 07:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EE53E49E;
	Thu, 16 May 2024 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7mErJdA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EB81E48A;
	Thu, 16 May 2024 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715845045; cv=none; b=QBfmwxeJ6nfQs/nu2EPT9YjN7M8E54VS0YYPF5SR9jQn7ksoCHAvRGMb0Gje3CCojZSXc5Q5ZxMmatF2u1MA6mFxS/4FGCcmWYe4QF8E1U3clglLcJPPpNuaEyv5o/l50e4gGl6F/qSoqQBKLZ9MH3r2g3pQqTUIVgPXWiHR0PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715845045; c=relaxed/simple;
	bh=mBQsVqLOD7gY/jYcTABwrJsRYzgj/vfKTUSrE15LC7I=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=M4HXSJOeErohNVDUv9kHOUDojN0czh/DXP2XnN19rz1vwNiOlK0WU2ZxpRGogANOsF8bruR77QLRV1a5MGf0sjjK10PC+X+xUcf3Cnw9YRtvrmkWX1PzTEpAWQLftfkC/k8Sbl+LR4sOq6l+X3DwNBwEj5Q87l8E+QECn17lPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7mErJdA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42016c8db2aso28696295e9.0;
        Thu, 16 May 2024 00:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715845042; x=1716449842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iQjsAe1drpHH99v0CeAENy6yrxzKNZyOFbnJiP/iePc=;
        b=V7mErJdAcrSbVR6nI0RaX21SIU+5jk+Tk05AL9KboXwqgfmmtoUmPla7bhHse3Xpi6
         Dm+FBrnrU9/lWcJpmjkpXGLNMW09ooH87Rlvg6qRshwe6qjS7H4Il33ToA8TuAWrKEHZ
         rZdtG3h3J8M6bQMnT9PQOanUylAqAWO5MC7UtuWCP5t9blMRfk99YFp1hfZielKXNDUN
         Nk8tfpvln9V6vJOvx31FNElfw5cAUzAZ04YMzQZ1efRngwujos0NZMAzr7fOTPXK8Nek
         R4b7RzuJYcPzyU4RG+K8pjw7nMaB5apU9BI9MO+WmQmFrjAJWxdWMLEtfWkPrjXeGh1i
         66Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715845042; x=1716449842;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQjsAe1drpHH99v0CeAENy6yrxzKNZyOFbnJiP/iePc=;
        b=mYqqoqHGVpJYleO1dxaMbPG3ta7XgouHare+vgM+ZPmaN0q1to8v5TNvpri210Vss8
         XKzKsSdE8QLMD45SiRpcKCCHW1OnQ2bQBIO5ABKblSnuNmzvPWIZJEgZ2vbcBPEC+3k9
         mPyGarpx/3vLujKJuOCLxJjcIaYOE3qxR/csJJc/o3Tt/Vw6XzkWKB2QQmJQLlNDX4HG
         dThYqFYWQxhQ8G3QZ6qZoRtjjkT00HFRm/78E5Ni7RWYQjtkiFJQ4sBjfOwTukG54G/K
         wdFDsQPmOYoEMkg3bFtP/S47dKkx/v41l8919lGW8sXFeWnJCYyvzjqjeRsyI9pA4WDt
         EKHg==
X-Forwarded-Encrypted: i=1; AJvYcCUZh0sjpfHnrEPvlS1fOdNzNRM5fdR5UnyLIbaoXEvvnzVb086T9RFtOnWt9xwq/BE0OV6zrSbTyEromhvW8y0TZ0DAJgpk5vTli3SX0GuguX71u3kzC2ey6c2mEdN7F1FvqrvybJ4fAMeyXlnL24ao3lGmIC/P55+l/K6bD/oCFQ==
X-Gm-Message-State: AOJu0Yw1jvKeaWSJXof5xfrddotLmsfO59yRvJB1rdAHOkOKf24Nw9+G
	b5vMUp0FSudS7kdt4CQLWAQwS6XxxmOxWIoyrZgkux5/Xg5v/P2O
X-Google-Smtp-Source: AGHT+IFZZyO7gwkfjlTjlzPeBKqVrud2A2vUIn1+5qazXeGcw/iJcYWkrDZ9MwuH7e9Syr8A37abHg==
X-Received: by 2002:a05:600c:444c:b0:41c:83aa:18b7 with SMTP id 5b1f17b1804b1-41fead6d1c8mr124443205e9.33.1715845041758;
        Thu, 16 May 2024 00:37:21 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fa90e93absm284231335e9.9.2024.05.16.00.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 00:37:20 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <82bf9e5f-b798-4d29-8473-c074a34f15b0@linux.dev>
Date: Thu, 16 May 2024 09:37:19 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] RDMA/cma: Brute force GFP_NOIO
To: =?UTF-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, rds-devel@oss.oracle.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 Manjunath Patil <manjunath.b.patil@oracle.com>,
 Mark Zhang <markzhang@nvidia.com>, Chuck Lever <chuck.lever@oracle.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Yang Li <yang.lee@linux.alibaba.com>
References: <20240515125342.1069999-1-haakon.bugge@oracle.com>
 <20240515125342.1069999-4-haakon.bugge@oracle.com>
Content-Language: en-US
In-Reply-To: <20240515125342.1069999-4-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.05.24 14:53, Håkon Bugge wrote:
> In cma_init(), we call memalloc_noio_{save,restore} in a parenthetic
> fashion when enabled by the module parameter force_noio.
> 
> This in order to conditionally enable rdma_cm to work aligned with
> block I/O devices. Any work queued later on work-queues created during
> module initialization will inherit the PF_MEMALLOC_{NOIO,NOFS}
> flag(s), due to commit ("workqueue: Inherit NOIO and NOFS alloc
> flags").
> 
> We do this in order to enable ULPs using the RDMA stack to be used as
> a network block I/O device. This to support a filesystem on top of a
> raw block device which uses said ULP(s) and the RDMA stack as the
> network transport layer.
> 
> Under intense memory pressure, we get memory reclaims. Assume the
> filesystem reclaims memory, goes to the raw block device, which calls
> into the ULP in question, which calls the RDMA stack. Now, if
> regular GFP_KERNEL allocations in the ULP or the RDMA stack require
> reclaims to be fulfilled, we end up in a circular dependency.
> 
> We break this circular dependency by:
> 
> 1. Force all allocations in the ULP and the relevant RDMA stack to use
>     GFP_NOIO, by means of a parenthetic use of
>     memalloc_noio_{save,restore} on all relevant entry points.
> 
> 2. Make sure work-queues inherits current->flags
>     wrt. PF_MEMALLOC_{NOIO,NOFS}, such that work executed on the
>     work-queue inherits the same flag(s).
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>   drivers/infiniband/core/cma.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 1e2cd7c8716e8..23a50cc3e81cb 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -50,6 +50,10 @@ MODULE_LICENSE("Dual BSD/GPL");
>   #define CMA_IBOE_PACKET_LIFETIME 16
>   #define CMA_PREFERRED_ROCE_GID_TYPE IB_GID_TYPE_ROCE_UDP_ENCAP
>   
> +static bool cma_force_noio;
> +module_param_named(force_noio, cma_force_noio, bool, 0444);
> +MODULE_PARM_DESC(force_noio, "Force the use of GFP_NOIO (Y/N)");
> +
>   static const char * const cma_events[] = {
>   	[RDMA_CM_EVENT_ADDR_RESOLVED]	 = "address resolved",
>   	[RDMA_CM_EVENT_ADDR_ERROR]	 = "address error",
> @@ -5424,6 +5428,10 @@ static struct pernet_operations cma_pernet_operations = {
>   static int __init cma_init(void)
>   {
>   	int ret;
> +	unsigned int noio_flags;

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-netdev.rst?h=v6.9#n376

"
Netdev has a convention for ordering local variables in functions.
Order the variable declaration lines longest to shortest, e.g.::

   struct scatterlist *sg;
   struct sk_buff *skb;
   int err, i;

If there are dependencies between the variables preventing the ordering
move the initialization out of line.
"

Zhu Yanjun

> +
> +	if (cma_force_noio)
> +		noio_flags = memalloc_noio_save();
>   
>   	/*
>   	 * There is a rare lock ordering dependency in cma_netdev_callback()
> @@ -5439,8 +5447,10 @@ static int __init cma_init(void)
>   	}
>   
>   	cma_wq = alloc_ordered_workqueue("rdma_cm", WQ_MEM_RECLAIM);
> -	if (!cma_wq)
> -		return -ENOMEM;
> +	if (!cma_wq) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
>   
>   	ret = register_pernet_subsys(&cma_pernet_operations);
>   	if (ret)
> @@ -5458,7 +5468,8 @@ static int __init cma_init(void)
>   	if (ret)
>   		goto err_ib;
>   
> -	return 0;
> +	ret = 0;
> +	goto out;
>   
>   err_ib:
>   	ib_unregister_client(&cma_client);
> @@ -5469,6 +5480,9 @@ static int __init cma_init(void)
>   	unregister_pernet_subsys(&cma_pernet_operations);
>   err_wq:
>   	destroy_workqueue(cma_wq);
> +out:
> +	if (cma_force_noio)
> +		memalloc_noio_restore(noio_flags);
>   	return ret;
>   }
>   


