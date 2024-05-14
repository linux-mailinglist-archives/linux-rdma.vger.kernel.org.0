Return-Path: <linux-rdma+bounces-2475-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 391E38C4E30
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 10:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8513282BBF
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 08:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB5722F0F;
	Tue, 14 May 2024 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXgITPmR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AEA1F956;
	Tue, 14 May 2024 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715676790; cv=none; b=svG0mAcejzWvxfeJag5R1Zx5hafLA9LDSg3D8pv0PgZi2Cu0gS/5iS5WfCKE3g5WYD11Lj5KR2twy3GqiZA+q1JjBrP6BTnXOOoMOT1prcRT0lVvCiGx6pG1+8FFirLiAZ/hnLkpZHx2h2EidRhq43OIyicbvdI/JpTgv0/L04E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715676790; c=relaxed/simple;
	bh=eCDgIANrV2Ry8CTSW1FqYJGO3DG4PwyKhu8pftQM/EY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jN9xDdp2dyAS80StiiSoFAsWY76BVldHxfTZD4NDYAX4xwywoGp+TaaptTc7wBZqVcgjknuiBn+gldZGksd6G7XXuUfkQdHlby/5Qinkdj90mVhO16FBV/qY2ILu2hQFgVXuWxbU3fuIxKf17lMQfcmDGAyhEAumXDhTqUQ+Aws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXgITPmR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41f9ce16ed8so53234765e9.0;
        Tue, 14 May 2024 01:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715676787; x=1716281587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6os4V1/Q9TcK/b6z23wU1+fo1ih8KsdRnIutef+IK7w=;
        b=bXgITPmRKCvEizJwZ+zPb1IFoh6E0seQqmiMPIm7Y12jjhyDx731dCrCsRBBFpuIUJ
         tBz/Po0Q1NeqAleHp6CryWmdenmrJkmM7vncj/XwAinZ5Ge+aEgfBbGVnJ678dzmDUWk
         Ol40rX64zHBU95WCob+X2m4yEWfw8iU5v6idVJsQEbEJ/f9V1WMtRFl7l0RgA2z6i/xf
         wU6OnkE7if2qpEc9BEnrV7G83lavO32Znhv7rENrDUatGMJoqTI0eKDfkDGW/zU++8Jv
         a4mVraqOb3wDGceq642C/qIYiL623mEvfJdW/oq2OhadzUhot+L8ksTKk3yMICLDzoU8
         ppyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715676787; x=1716281587;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6os4V1/Q9TcK/b6z23wU1+fo1ih8KsdRnIutef+IK7w=;
        b=mcPBK7SyireE6kK+e/FPn/HhD8cDNJkNhGcIjS4EEvJVvuvy3mbWLqD69aYck/dBY+
         kmA6qEkp3xJSzqAkiuSGcQAyabbL4qH4rPqnHB4zjbe4Af+8LhLcdIlZdpIikBPfwLmn
         wSyCFBMiIyM4dMAFN9Oj/FrwZlbpFYaWS7VzfL0hnEn4LiKKG7SldSQfbXuSqaGKnUNO
         LPAm07YsyHpLWxqlL7kmsii67Xa+OW02HJQGCd7pYzc/DCVp9PiuR5mQJUtgyNSF+aHf
         gGD2j/0O+p/J+n+qJgkXlPtQg4RjzNRY2mjzyOUYyf2zM0vnPdE/j3KaANyfM9ORWJmL
         5w9g==
X-Forwarded-Encrypted: i=1; AJvYcCXNg4AZqxL2hXkzyzWHkgOGcsjlM2c5XSOkPDPqJO2xuBhmOCqFnMJUVmu92GA6X/Jb3SuWhtIsl0vm1V1ntUKHmZasp+9sK356FKj1fyDUe7YIWNiLWFwrImfXe6xVSlGrRYcU3rnHcgl3U0RlNZJPJtDCATWikjc5zro31xUCLQ==
X-Gm-Message-State: AOJu0YxbMNjsiugHXn9UH/JHfGKu6ytj7taIggYgsUoxaF5z+//pgABq
	iv5PQNqm0dqh5tX1DOqlGKhZTUaodkJsHrzoAyJ71Xs3kKwwgwIU
X-Google-Smtp-Source: AGHT+IHAvFzWFhgQ/VN6ZJiA5ZuX3Pxcdma5FjQzZ20e8KiQpCEEVFzLvEKrCeDcZi5az6cFqcLoiA==
X-Received: by 2002:a05:600c:68c3:b0:41b:c24c:8a79 with SMTP id 5b1f17b1804b1-41feaa443dfmr103835945e9.19.1715676786763;
        Tue, 14 May 2024 01:53:06 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee92c7sm191249465e9.34.2024.05.14.01.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 01:53:06 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <38a5ccc6-d0bc-41e0-99de-fe7902b1951f@linux.dev>
Date: Tue, 14 May 2024 10:53:05 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] rds: rdma: Add ability to force GFP_NOIO
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
References: <20240513125346.764076-1-haakon.bugge@oracle.com>
Content-Language: en-US
In-Reply-To: <20240513125346.764076-1-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.05.24 14:53, Håkon Bugge wrote:
> This series enables RDS and the RDMA stack to be used as a block I/O
> device. This to support a filesystem on top of a raw block device

This is to support a filesystem ... ?

> which uses RDS and the RDMA stack as the network transport layer.
> 
> Under intense memory pressure, we get memory reclaims. Assume the
> filesystem reclaims memory, goes to the raw block device, which calls
> into RDS, which calls the RDMA stack. Now, if regular GFP_KERNEL
> allocations in RDS or the RDMA stack require reclaims to be fulfilled,
> we end up in a circular dependency.
> 
> We break this circular dependency by:
> 
> 1. Force all allocations in RDS and the relevant RDMA stack to use
>     GFP_NOIO, by means of a parenthetic use of
>     memalloc_noio_{save,restore} on all relevant entry points.
> 
> 2. Make sure work-queues inherits current->flags
>     wrt. PF_MEMALLOC_{NOIO,NOFS}, such that work executed on the
>     work-queue inherits the same flag(s).
> 
> Håkon Bugge (6):
>    workqueue: Inherit NOIO and NOFS alloc flags
>    rds: Brute force GFP_NOIO
>    RDMA/cma: Brute force GFP_NOIO
>    RDMA/cm: Brute force GFP_NOIO
>    RDMA/mlx5: Brute force GFP_NOIO
>    net/mlx5: Brute force GFP_NOIO
> 
>   drivers/infiniband/core/cm.c                  | 15 ++++-
>   drivers/infiniband/core/cma.c                 | 20 ++++++-
>   drivers/infiniband/hw/mlx5/main.c             | 22 +++++--
>   .../net/ethernet/mellanox/mlx5/core/main.c    | 14 ++++-
>   include/linux/workqueue.h                     |  2 +
>   kernel/workqueue.c                            | 17 ++++++
>   net/rds/af_rds.c                              | 60 ++++++++++++++++++-
>   7 files changed, 138 insertions(+), 12 deletions(-)
> 
> --
> 2.39.3
> 


