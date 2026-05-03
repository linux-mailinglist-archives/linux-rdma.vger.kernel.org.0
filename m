Return-Path: <linux-rdma+bounces-19871-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPL/K7ao9mmgXQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19871-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 03:45:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E554B4089
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 03:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A694630082AE
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 01:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D44424886E;
	Sun,  3 May 2026 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgYQ427k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3040B40DFD0;
	Sun,  3 May 2026 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777772723; cv=none; b=pVtUkSaPD8wX+qctzlLlhsi6GZdpyPl3pYiGo2OVkTUtuVH5l6D3LfD3XIRPeekc9SDqrTtMfJvfPMc0xdmDeS/R32ITA4R8uNQzIQeU9PbgPZCOLM/fJItEP94yrU1T185lQEXpi/+wLDGoXExWlJ6vP7lrKABpLmhzijiCtMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777772723; c=relaxed/simple;
	bh=OcoE6oTTHn+MqLfiKmS2JWn13hTHY26HJsZtSuao5Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upa1qIntEC9LVlC4b1ifIvVBO/G9JRs3+5rQ7GhvC+/szUPyrZ+u7Eo1woV12aWILbuJi+2bukREzMU1+hZtzoxDBlySUMtSXeBJy/P7bPM0CxP4I0den3AXI5FpsPvPXc6f1Vfrmz+AuYsGkatOSnaNLYuGLmrEmwsJYCngJAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgYQ427k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD69C19425;
	Sun,  3 May 2026 01:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777772723;
	bh=OcoE6oTTHn+MqLfiKmS2JWn13hTHY26HJsZtSuao5Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VgYQ427k+iLvvL9YOyYZgSxzukF5XVV8kzvSCLAsAilNyDXPAt3Qu8rPHiyPUK9Lv
	 QnVEGsyzMZzB/yUsJcGJpSK+7jfUGpafrRnnW3IJDl58i0yzz2fFZEUsUNUZcj4TWf
	 FGY/UiOXR8fT3yrzoNAgwAC/cB5zt75+JpM41UW3WgLdbE1hVaX6Mn9OisDNempdcj
	 M2MfbRGMKlLtb1ra4zBxmOj5gKebGWDrxjIveoJ19jbeDRM8qdrwbvSuh0vUQ5eb21
	 gaA1b8J0gIp3BvdMjUZm0fM4bseH0MZ3i81Sn3yum6NitFrOmpFjjIixrx3iCgfQw/
	 orlR1sWdFfIZA==
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	saeedm@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	moshe@nvidia.com,
	agoldberger@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gal@nvidia.com,
	dtatulea@nvidia.com
Subject: Re: [PATCH net-next 3/3] net/mlx5: Add VHCA_ID page management mode support
Date: Sat,  2 May 2026 18:45:20 -0700
Message-ID: <20260503014520.4098577-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501044156.260875-4-tariqt@nvidia.com>
References: <20260501044156.260875-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 33E554B4089
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-19871-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net/mlx5: Add VHCA_ID page management mode support

This commit adds support for VHCA_ID-based page management mode. It
updates page management commands to conditionally use vhca_id and adds
a function to resolve the function type via vport lookup.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> @@ -852,6 +852,48 @@ bool mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
>  	return true;
>  }
>  
> +u16 mlx5_esw_vhca_id_to_func_type(struct mlx5_core_dev *dev, u16 vhca_id)
> +{
> +	struct mlx5_eswitch *esw = dev->priv.eswitch;
> +	struct mlx5_vport *vport;
> +	unsigned long i;
> +	u16 type;
> +
> +	if (vhca_id == MLX5_CAP_GEN(dev, vhca_id))
> +		return MLX5_SELF;
> +
> +	if (!esw)
> +		return MLX5_FUNC_TYPE_NONE;
> +
> +	mutex_lock(&esw->state_lock);

Can this race with driver unload?

Since the page allocator workqueue (pg_wq) is asynchronous and destroyed
after the eswitch structure is freed, could a pending page request evaluate
esw as valid just before it's freed, and then attempt to lock it here?

Also, is there a potential deadlock when acquiring esw->state_lock here?

If a thread holds the lock while sending a firmware command, and the
firmware issues a page request to complete it, the pg_wq worker will block
here waiting for the lock. Would this prevent the firmware command from
completing?

[ ... ]

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
[ ... ]
> -static int give_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
> +static int give_pages(struct mlx5_core_dev *dev, u16 func_vhca_id, int npages,
>  		      int event, bool ec_function)
>  {
> -	u32 function = get_function(func_id, ec_function);
> +	u32 function = get_function_key(dev, func_vhca_id, ec_function);
>  	u32 out[MLX5_ST_SZ_DW(manage_pages_out)] = {0};
>  	int inlen = MLX5_ST_SZ_BYTES(manage_pages_in);

This isn't a new issue introduced by this patch, but does the npages
calculation risk an integer overflow?

The npages parameter is derived from the firmware payload, and the
allocation size is calculated as:

inlen += npages * MLX5_FLD_SZ_BYTES(manage_pages_in, pas[0]);

If a compromised firmware provides a massive npages value, could this
overflow the 32-bit inlen and result in an undersized kvzalloc allocation,
followed by an out-of-bounds write in the subsequent loop?

[ ... ]

> @@ -577,8 +626,9 @@ static int reclaim_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
>  	if (nclaimed)
>  		*nclaimed = num_claimed;
>  
> -	func_type = func_id_to_type(dev, func_id, ec_function);
> -	dev->priv.page_counters[func_type] -= num_claimed;
> +	func_type = func_vhca_id_to_type(dev, func_vhca_id, ec_function);
> +	if (func_type != MLX5_FUNC_TYPE_NONE)
> +		dev->priv.page_counters[func_type] -= num_claimed;

Does this dynamically look up the vport during page reclaim?

If an SF or VF has been destroyed and its vport removed, the lookup will
return MLX5_FUNC_TYPE_NONE. Will this cause the decrement to be skipped,
leading to a counter leak and triggering the WARN() statements in
mlx5_reclaim_startup_pages() during driver unload?

[ ... ]

> @@ -658,30 +708,101 @@ static int req_pages_handler(struct notifier_block *nb,
[ ... ]
> +	} else {
> +		if (MLX5_CAP_GEN_MAX(dev, icm_mng_function_id_mode) ==
> +		    MLX5_ID_MODE_FUNCTION_VHCA_ID) {
> +			err = mlx5_pagealloc_migrate_pf_to_vhca_id(dev);
> +			if (err)
> +				return err;
> +			mlx5_page_mgt_mode_set(dev, MLX5_PAGE_MGT_MODE_VHCA_ID);
> +		}
> +	}

What happens to the device state if mlx5_pagealloc_migrate_pf_to_vhca_id()
fails?

The firmware has already been instructed to use VHCA_ID mode during driver
load, but if the migration fails, the function returns early and leaves
dev->priv.page_mgt_mode as FUNC_ID.

When the initialization aborts and mlx5_reclaim_startup_pages() runs, will
the driver send reclaim commands using the old ID, causing the firmware
to reject them and leak the allocated DMA memory?

