Return-Path: <linux-rdma+bounces-532-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDE0823082
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 16:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FEE1F24672
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDDB1A72A;
	Wed,  3 Jan 2024 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WC2klXvc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E421B263
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jan 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3845b1b5-6e1d-445c-b937-c8bf7af42a77@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704295588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maou5724PNWK7fCkTVcWEeY3aHC8MpiTYMu6JzAE5cc=;
	b=WC2klXvcSPh/iJcWFuLiRP8zluserpa/aJicyx2liD4CxZcC5V9SywjZAZCjd0M+A7hxBg
	+B6ReJ9f8Dli+qSeRrw9c/QIzIjRzJKFbkRJ3XF6VynVfQya4z7DU9eingVi7f13Uj3uR7
	T51ZPwM53F3yq+fHW57MSDs2Tflt/MM=
Date: Wed, 3 Jan 2024 17:26:24 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/efa: Limit EQs to available MSI-X vectors
To: ynachum@amazon.com, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: sleybo@amazon.com, matua@amazon.com, Michael Margolin
 <mrgolin@amazon.com>, Yonatan Goldhirsh <ygold@amazon.com>
References: <20240103142134.2191-1-ynachum@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
In-Reply-To: <20240103142134.2191-1-ynachum@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Yonatan,

On 03/01/2024 16:21, ynachum@amazon.com wrote:
> From: Yonatan Nachum <ynachum@amazon.com>
> 
> When creating EQs we take into consideration the max number of EQs the
> device reported it can support and the number of available CPUs. There
> are situations where the number of EQs the device reported it can
> support and the PCI configuration of MSI-X is different, take it in
> account as well when creating EQs.
> Also request at least 1 MSI-X vector for the management queue and allow
> the kernel to return a number of vectors in a range between 1 and the
> max supported MSI-X vectors according to the PCI config.
> 
> Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> Reviewed-by: Yonatan Goldhirsh <ygold@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa.h      |  3 ++-
>  drivers/infiniband/hw/efa/efa_main.c | 32 +++++++++++++---------------
>  2 files changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
> index 7352a1f5d811..a17045e100cd 100644
> --- a/drivers/infiniband/hw/efa/efa.h
> +++ b/drivers/infiniband/hw/efa/efa.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
>  /*
> - * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
> + * Copyright 2018-2023 Amazon.com, Inc. or its affiliates. All rights reserved.
>   */
>  
>  #ifndef _EFA_H_
> @@ -57,6 +57,7 @@ struct efa_dev {
>  	u64 db_bar_addr;
>  	u64 db_bar_len;
>  
> +	unsigned int num_irq_vectors;
>  	int admin_msix_vector_idx;
>  	struct efa_irq admin_irq;
>  
> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
> index 15ee92081118..1aade398c723 100644
> --- a/drivers/infiniband/hw/efa/efa_main.c
> +++ b/drivers/infiniband/hw/efa/efa_main.c
> @@ -319,7 +319,9 @@ static int efa_create_eqs(struct efa_dev *dev)
>  	int err;
>  	int i;
>  
> -	neqs = min_t(unsigned int, neqs, num_online_cpus());
> +	neqs = min_t(unsigned int, neqs,
> +		     dev->num_irq_vectors - EFA_COMP_EQS_VEC_BASE);
> +

If the device supports one msix (which is reserved for commands) you'll
end up with zero neqs, and allocate a zero-sized dev->eqs array.

Won't that break when efa_create_cq() is called and try to access this
array?
Especially since efa_ib_device_add() sets num_comp_vectors to 1 in such
case..

>  	dev->neqs = neqs;
>  	dev->eqs = kcalloc(neqs, sizeof(*dev->eqs), GFP_KERNEL);
>  	if (!dev->eqs)

