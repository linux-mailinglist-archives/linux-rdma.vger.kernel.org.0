Return-Path: <linux-rdma+bounces-20646-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YInJOLtZBWomVQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20646-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 07:12:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 520D953DE8A
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 07:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29ADF30364B6
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 05:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5853B8934;
	Thu, 14 May 2026 05:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sd+VGEsa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8F03B960F
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 05:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735543; cv=none; b=jvp5AePzRMQ6cC4XX9BbT7AlciC8phCNwdQyMG5fUeXjf4tsxCM5V72rz7OTa4P3OwsFvXifAXDCpxlpz4R0FLWVq5BpQkM4DUmgu63WbdAAAXeRatXA9FcZ4vbZOd67aLswabPmt9Rhv6DWbxfo1aRHLVHUFudfr3AWQApXwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735543; c=relaxed/simple;
	bh=3TsgmlKokwUDlN80sFc82AvhIrAIelD2L494ltyH+1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXeMbBXWukI12x8QsS3cFttU3msH6NQ+Ubhoz+/C7AVzvTW0/eO4bB4xOuzVaLBdnIcEEe1e/LZP49PbC1mhxXE92TEc9OEgO86awii8lzhZXI8BClh7nXjr1xFlrkwlwrcrHNQTs0pieMV8dxxv5x3xUWwDbtg4fu6747Ly+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sd+VGEsa; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <346a4118-4902-46a6-9245-ef37322b30b1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778735540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9ok85oELPYZlKrbmgn1F8Vrcgg1D2KQMVzos8BKyqU=;
	b=Sd+VGEsaY9cTpqgwlkWzlTmISC6/HAwkH12kknbfLWctx4vd1ZGMqcvJwhUwyi3l/WgkUC
	G6EHgSpUP9eP3ceFuETutXtQfcFZmKBpCwUdF8IXlPlxkefc3Gu4pWGixVv2u1Eytr7ids
	G/nPfWhzzsQEBsDxW9RyyHyQ8zfZXpk=
Date: Wed, 13 May 2026 22:12:01 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v2 1/2] RDMA/efa: Add initialization of AH cache
 rhashtable
To: Yonatan Nachum <ynachum@amazon.com>, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org, "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: mrgolin@amazon.com, sleybo@amazon.com, matua@amazon.com,
 gal.pressman@linux.dev, Firas Jahjah <firasj@amazon.com>
References: <20260512061121.2177521-1-ynachum@amazon.com>
 <20260512061121.2177521-2-ynachum@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260512061121.2177521-2-ynachum@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 520D953DE8A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20646-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

在 2026/5/11 23:11, Yonatan Nachum 写道:
> New EFA devices don't support the creation of multiple address handles
> to the same remote on the same PD.
> To overcome this limitation, introduce an AH cache rhashtable which will
> store the refcounts of the same AH creation on the same PD and will
> allow the driver to manage AH reuse. The hashtable key is the
> combination of PD and GID. Add initialization and teardown logic for the
> rhashtable.
> 
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> ---
>   drivers/infiniband/hw/efa/Makefile       |  4 +--
>   drivers/infiniband/hw/efa/efa_ah_cache.c | 30 ++++++++++++++++++++
>   drivers/infiniband/hw/efa/efa_ah_cache.h | 36 ++++++++++++++++++++++++
>   drivers/infiniband/hw/efa/efa_com.c      | 12 +++++++-
>   drivers/infiniband/hw/efa/efa_com.h      |  5 +++-
>   5 files changed, 83 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.c
>   create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.h
> 
> diff --git a/drivers/infiniband/hw/efa/Makefile b/drivers/infiniband/hw/efa/Makefile
> index 6e83083af0bc..a6a433b0ba2f 100644
> --- a/drivers/infiniband/hw/efa/Makefile
> +++ b/drivers/infiniband/hw/efa/Makefile
> @@ -1,9 +1,9 @@
>   # SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> -# Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
> +# Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
>   #
>   # Makefile for Amazon Elastic Fabric Adapter (EFA) device driver.
>   #
>   
>   obj-$(CONFIG_INFINIBAND_EFA) += efa.o
>   
> -efa-y := efa_com_cmd.o efa_com.o efa_main.o efa_verbs.o
> +efa-y := efa_com_cmd.o efa_ah_cache.o efa_com.o efa_main.o efa_verbs.o
> diff --git a/drivers/infiniband/hw/efa/efa_ah_cache.c b/drivers/infiniband/hw/efa/efa_ah_cache.c
> new file mode 100644
> index 000000000000..d31871eb9748
> --- /dev/null
> +++ b/drivers/infiniband/hw/efa/efa_ah_cache.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright 2026 Amazon.com, Inc. or its affiliates. All rights reserved.
> + */
> +
> +#include "efa_ah_cache.h"
> +
> +static const struct rhashtable_params ah_cache_params = {
> +	.key_len = sizeof(struct efa_ah_cache_key),
> +	.key_offset = offsetof(struct efa_ah_cache_entry, key),
> +	.head_offset = offsetof(struct efa_ah_cache_entry, linkage),
> +};
> +
> +int efa_ah_cache_init(struct efa_ah_cache *ah_cache)
> +{
> +	int err;
> +
> +	mutex_init(&ah_cache->lock);
> +	err = rhashtable_init(&ah_cache->hashtable, &ah_cache_params);
> +	if (err)
> +		mutex_destroy(&ah_cache->lock);
> +
> +	return err;
> +}
> +
> +void efa_ah_cache_destroy(struct efa_ah_cache *ah_cache)
> +{
> +	rhashtable_destroy(&ah_cache->hashtable);
> +	mutex_destroy(&ah_cache->lock);
> +}
> diff --git a/drivers/infiniband/hw/efa/efa_ah_cache.h b/drivers/infiniband/hw/efa/efa_ah_cache.h
> new file mode 100644
> index 000000000000..25288fdf778a
> --- /dev/null
> +++ b/drivers/infiniband/hw/efa/efa_ah_cache.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> +/*
> + * Copyright 2026 Amazon.com, Inc. or its affiliates. All rights reserved.
> + */
> +
> +#ifndef _EFA_AH_CACHE_H_
> +#define _EFA_AH_CACHE_H_
> +
> +#include <linux/refcount.h>
> +#include <linux/rhashtable.h>
> +
> +#define EFA_AH_GID_SIZE 16
> +
> +struct efa_ah_cache_key {
> +	u8 gid[EFA_AH_GID_SIZE];
> +	u16 pd;
> +};

I am not sure if we add __packed to avoid memory hole.

Zhu Yanjun

> +
> +struct efa_ah_cache_entry {
> +	struct efa_ah_cache_key key;
> +	u16 ah;
> +	bool initialized;
> +	refcount_t refcount;
> +	struct rhash_head linkage;
> +	struct mutex lock; /* Serializes device commands per cache entry */
> +};
> +
> +struct efa_ah_cache {
> +	struct rhashtable hashtable;
> +	struct mutex lock; /* Protects AH cache hashtable */
> +};
> +
> +int efa_ah_cache_init(struct efa_ah_cache *ah_cache);
> +void efa_ah_cache_destroy(struct efa_ah_cache *ah_cache);
> +
> +#endif /* _EFA_AH_CACHE_H_ */
> diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
> index e97b5f0d7003..b9b922583709 100644
> --- a/drivers/infiniband/hw/efa/efa_com.c
> +++ b/drivers/infiniband/hw/efa/efa_com.c
> @@ -688,6 +688,8 @@ void efa_com_admin_destroy(struct efa_com_dev *edev)
>   
>   	size = aenq->depth * sizeof(*aenq->entries);
>   	dma_free_coherent(edev->dmadev, size, aenq->entries, aenq->dma_addr);
> +
> +	efa_ah_cache_destroy(&edev->ah_cache);
>   }
>   
>   /**
> @@ -746,6 +748,12 @@ int efa_com_admin_init(struct efa_com_dev *edev,
>   		return -ENODEV;
>   	}
>   
> +	err = efa_ah_cache_init(&edev->ah_cache);
> +	if (err) {
> +		ibdev_err(edev->efa_dev, "Failed to init AH cache\n");
> +		return err;
> +	}
> +
>   	aq->depth = EFA_ADMIN_QUEUE_DEPTH;
>   
>   	aq->dmadev = edev->dmadev;
> @@ -758,7 +766,7 @@ int efa_com_admin_init(struct efa_com_dev *edev,
>   
>   	err = efa_com_init_comp_ctxt(aq);
>   	if (err)
> -		return err;
> +		goto err_destroy_ah_cache;
>   
>   	err = efa_com_admin_init_sq(edev);
>   	if (err)
> @@ -796,6 +804,8 @@ int efa_com_admin_init(struct efa_com_dev *edev,
>   			  aq->sq.entries, aq->sq.dma_addr);
>   err_destroy_comp_ctxt:
>   	devm_kfree(edev->dmadev, aq->comp_ctx);
> +err_destroy_ah_cache:
> +	efa_ah_cache_destroy(&edev->ah_cache);
>   
>   	return err;
>   }
> diff --git a/drivers/infiniband/hw/efa/efa_com.h b/drivers/infiniband/hw/efa/efa_com.h
> index 4d9ca97e4296..dc365df7f3dd 100644
> --- a/drivers/infiniband/hw/efa/efa_com.h
> +++ b/drivers/infiniband/hw/efa/efa_com.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
>   /*
> - * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
> + * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
>    */
>   
>   #ifndef _EFA_COM_H_
> @@ -14,6 +14,7 @@
>   
>   #include <rdma/ib_verbs.h>
>   
> +#include "efa_ah_cache.h"
>   #include "efa_common_defs.h"
>   #include "efa_admin_defs.h"
>   #include "efa_admin_cmds_defs.h"
> @@ -112,6 +113,8 @@ struct efa_com_dev {
>   	u32 supported_features;
>   	u32 dma_addr_bits;
>   
> +	struct efa_ah_cache ah_cache;
> +
>   	struct efa_com_mmio_read mmio_read;
>   };
>   


