Return-Path: <linux-rdma+bounces-20960-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKynBoViDGpXggUAu9opvQ
	(envelope-from <linux-rdma+bounces-20960-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:15:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F02457F676
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 868B230A4143
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 13:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D6F34041F;
	Tue, 19 May 2026 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHa69yBf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AD334041A
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196081; cv=none; b=J/AM7kvMXcwcMA6v4Rl6w6sw2+4uz4z2z2Sai4T+q8PRJ/f/nNpZ+rVdlYF52HBPqJQ41VPy32ylzLad/InC3322WpSMTzQpHqYGkWIh2ahn9NOn3CsLh59w6LLYbJeez/jDMmaASTBXjJjC4A3uD7QcyoOv/j0VCE40VZBX44s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196081; c=relaxed/simple;
	bh=m/IPGt2zp7YTS5Wpo7EpC3MNNVhE0U0sNzAi74Ogp+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPIY2XPQBqdWs7q6d7I50qz5fMr8DIEYMRUUEZ7QrHtOt8fsDWlGJHWAVPdUg482QkQiAwI1hDZEOZ7ga9Rthk5CwYCAoh9ZHWSlZHIQCfJk+00iRwXlud9n56K3U3QZKeY24hT0KLlvS0yD6n91EMoL5s5K4kMxERqB33X6JAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHa69yBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BF7C2BCB3;
	Tue, 19 May 2026 13:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779196081;
	bh=m/IPGt2zp7YTS5Wpo7EpC3MNNVhE0U0sNzAi74Ogp+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FHa69yBfi9AjvAA/upcARTVVMITmQ7L6lR5/Vb3NH5b9nlApjUsb8xZl5KLxyATSw
	 BTe+moME1uYEkGX1CVnmiJhx6EXkTy2S4iC6ijDpJeUzoQS5+O0ahELvI9aG8+D6rh
	 xBho57dg3TkKRhnpYg0v504v9M1R/wHJZ/fIsOd5mWsb+t0Phhtl9W1BOGI2hiPD3Z
	 PLSW1c9M0c8V6IsceIjmpuMXjzpLSAI0yXffiximV4hcS9VdpdEVgEKp7ulxPESY3G
	 RSRoZoSN2z1mfnxryhvXwq12qWwbUjHqUCj/v91Y5llKj72U8kpM7HYSz5xS3GWbmr
	 +XqtYfMIjnc6g==
Date: Tue, 19 May 2026 16:07:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yonatan Nachum <ynachum@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, mrgolin@amazon.com,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next v2 1/2] RDMA/efa: Add initialization of AH cache
 rhashtable
Message-ID: <20260519130755.GV33515@unreal>
References: <20260512061121.2177521-1-ynachum@amazon.com>
 <20260512061121.2177521-2-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512061121.2177521-2-ynachum@amazon.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20960-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8F02457F676
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 12, 2026 at 06:11:20AM +0000, Yonatan Nachum wrote:
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
>  drivers/infiniband/hw/efa/Makefile       |  4 +--
>  drivers/infiniband/hw/efa/efa_ah_cache.c | 30 ++++++++++++++++++++
>  drivers/infiniband/hw/efa/efa_ah_cache.h | 36 ++++++++++++++++++++++++
>  drivers/infiniband/hw/efa/efa_com.c      | 12 +++++++-
>  drivers/infiniband/hw/efa/efa_com.h      |  5 +++-
>  5 files changed, 83 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.c
>  create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.h

<...>

> +struct efa_ah_cache_entry {
> +	struct efa_ah_cache_key key;
> +	u16 ah;
> +	bool initialized;

If this variable is present, it indicates that the reference count is being  
used incorrectly. In the uninitialized state, the refcount must be 0.

Thanks

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
>  	size = aenq->depth * sizeof(*aenq->entries);
>  	dma_free_coherent(edev->dmadev, size, aenq->entries, aenq->dma_addr);
> +
> +	efa_ah_cache_destroy(&edev->ah_cache);
>  }
>  
>  /**
> @@ -746,6 +748,12 @@ int efa_com_admin_init(struct efa_com_dev *edev,
>  		return -ENODEV;
>  	}
>  
> +	err = efa_ah_cache_init(&edev->ah_cache);
> +	if (err) {
> +		ibdev_err(edev->efa_dev, "Failed to init AH cache\n");
> +		return err;
> +	}
> +
>  	aq->depth = EFA_ADMIN_QUEUE_DEPTH;
>  
>  	aq->dmadev = edev->dmadev;
> @@ -758,7 +766,7 @@ int efa_com_admin_init(struct efa_com_dev *edev,
>  
>  	err = efa_com_init_comp_ctxt(aq);
>  	if (err)
> -		return err;
> +		goto err_destroy_ah_cache;
>  
>  	err = efa_com_admin_init_sq(edev);
>  	if (err)
> @@ -796,6 +804,8 @@ int efa_com_admin_init(struct efa_com_dev *edev,
>  			  aq->sq.entries, aq->sq.dma_addr);
>  err_destroy_comp_ctxt:
>  	devm_kfree(edev->dmadev, aq->comp_ctx);
> +err_destroy_ah_cache:
> +	efa_ah_cache_destroy(&edev->ah_cache);
>  
>  	return err;
>  }
> diff --git a/drivers/infiniband/hw/efa/efa_com.h b/drivers/infiniband/hw/efa/efa_com.h
> index 4d9ca97e4296..dc365df7f3dd 100644
> --- a/drivers/infiniband/hw/efa/efa_com.h
> +++ b/drivers/infiniband/hw/efa/efa_com.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
>  /*
> - * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
> + * Copyright 2018-2026 Amazon.com, Inc. or its affiliates. All rights reserved.
>   */
>  
>  #ifndef _EFA_COM_H_
> @@ -14,6 +14,7 @@
>  
>  #include <rdma/ib_verbs.h>
>  
> +#include "efa_ah_cache.h"
>  #include "efa_common_defs.h"
>  #include "efa_admin_defs.h"
>  #include "efa_admin_cmds_defs.h"
> @@ -112,6 +113,8 @@ struct efa_com_dev {
>  	u32 supported_features;
>  	u32 dma_addr_bits;
>  
> +	struct efa_ah_cache ah_cache;
> +
>  	struct efa_com_mmio_read mmio_read;
>  };
>  
> -- 
> 2.50.1
> 

