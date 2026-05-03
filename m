Return-Path: <linux-rdma+bounces-19868-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFnSDBeo9mmgXQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19868-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 03:42:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4504B4054
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 03:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94FD9300BD97
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 01:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490A223EA94;
	Sun,  3 May 2026 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urexeOad"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF1521771B;
	Sun,  3 May 2026 01:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777772548; cv=none; b=Cr7vwmCRwjUFbIMUwXaYdCMoSo7r4ga/LQpg0iLprgsWGPx3DOYl3pJXLza3VT03oRw3pnZD+hxpoMvi3qD2Tz3ljwAXY0MPGM+mU0bvHRLYV90QYQquS0kIjejsHWqnhIbmXCXYbTwaPJlD1g0Ayv+vgVs0VqEYJ2QoF5r7SsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777772548; c=relaxed/simple;
	bh=eYq7eGBEftXQmW1NfJ9JnLPK6NM3jRQIrGdc2lagKuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIZfiSm557aCxp5iIAZIcPxhX1B39vJv+aaq5+QYLRkdrzVZVDdXCtO4YpyErc7ACyrT/kFRke/47ll48I5mrlSLP3fPSMYLhEteLZ1tLAQUg0J6L9jz4bgyryxAb0oRoVfm1h+uWQqxb7sSIfWakRbLK3qbG9IyO6ewfaUsycA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urexeOad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7788CC19425;
	Sun,  3 May 2026 01:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777772547;
	bh=eYq7eGBEftXQmW1NfJ9JnLPK6NM3jRQIrGdc2lagKuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=urexeOadMlxO8sGoKDR9ovfS0RalqH+mmjXvoPrysUtLrMKdvVYt0F24kLYE2XCQq
	 7kEKDXhi8ck7Slh0Wmq3zY1SoG1FsVYl7OFJxJRX3aJQAMzA0T1o4g4sqROePRhC6U
	 ADbjWKbj9qRPrw/XZEXOb5V+K5LumvRyURKhbba0+V2uOKAp1rht6Oz8o51wAplQxa
	 3U875meOJRjCZS0x1ZbMPLrctuB1rydZxs5Y6P8uk+rzHW3s+h/iulSyhoDqN3zxtC
	 OMW2t/DOs4yMhW/5FZW+TdIVmgKrxfLWqKOw57qIF7U8ThdmAjYey0Wy+AIDGzFqe3
	 4h4zigbFT/ZYg==
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	leon@kernel.org,
	jgg@ziepe.ca,
	saeedm@nvidia.com,
	mbloch@nvidia.com,
	shayd@nvidia.com,
	ohartoov@nvidia.com,
	edwards@nvidia.com,
	msanalla@nvidia.com,
	horms@kernel.org,
	gbayer@linux.ibm.com,
	moshe@nvidia.com,
	kees@kernel.org,
	phaddad@nvidia.com,
	parav@nvidia.com,
	cjubran@nvidia.com,
	cratiu@nvidia.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	gal@nvidia.com,
	dtatulea@nvidia.com
Subject: Re: [PATCH net-next V2 4/7] net/mlx5: E-Switch, serialize representor lifecycle
Date: Sat,  2 May 2026 18:42:24 -0700
Message-ID: <20260503014224.4096089-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501041633.231662-5-tariqt@nvidia.com>
References: <20260501041633.231662-5-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6E4504B4054
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-19868-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/mlx5: E-Switch, serialize representor lifecycle

This change replaces the ad-hoc bit/wait-queue coordination of E-Switch
representor lifecycle with the per-E-Switch reps_lock, adds nested
wrappers for the shared-FDB master IB path, and clears the rep_ops
pointer on unregister.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> index 66a773a99876..f70737437954 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c

[ ... ]

> @@ -1825,7 +1831,11 @@ void mlx5_eswitch_disable(struct mlx5_eswitch *esw)
>  
>  	devl_assert_locked(priv_to_devlink(esw->dev));
>  	mlx5_lag_disable_change(esw->dev);
> +
> +	mlx5_esw_reps_block(esw);
>  	mlx5_eswitch_disable_locked(esw);
> +	mlx5_esw_reps_unblock(esw);
> +
>  	esw->mode = MLX5_ESWITCH_LEGACY;
>  	mlx5_lag_enable_change(esw->dev);
>  }

The commit message says "Take the representor lock around the mode
transition", but the assignment esw->mode = MLX5_ESWITCH_LEGACY happens
here after reps_lock has been dropped.

Meanwhile mlx5_eswitch_unregister_vport_reps_blocked() now reads
esw->mode under reps_lock to decide whether to call
__unload_reps_all_vport():

    if (esw->mode == MLX5_ESWITCH_OFFLOADS)
            __unload_reps_all_vport(esw, rep_type);

Should the mode store be moved inside the reps_block/reps_unblock
region so the reader's assumption about stability under reps_lock
holds?

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index 6a5143b63dfd..d4ac07c995b9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c

[ ... ]

> @@ -2425,21 +2436,22 @@ void mlx5_esw_reps_unblock(struct mlx5_eswitch *esw)
>  
>  static void esw_mode_change(struct mlx5_eswitch *esw, u16 mode)
>  {
> +	mlx5_esw_reps_unblock(esw);
>  	mlx5_devcom_comp_lock(esw->dev->priv.hca_devcom_comp);
>  	if (esw->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_IB_ADEV ||
>  	    mlx5_core_mp_enabled(esw->dev)) {
>  		esw->mode = mode;
> -		mlx5_rescan_drivers_locked(esw->dev);
> -		mlx5_devcom_comp_unlock(esw->dev->priv.hca_devcom_comp);
> -		return;
> +		goto out;
>  	}
>  
>  	esw->dev->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
>  	mlx5_rescan_drivers_locked(esw->dev);
>  	esw->mode = mode;
>  	esw->dev->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
> +out:
>  	mlx5_rescan_drivers_locked(esw->dev);
>  	mlx5_devcom_comp_unlock(esw->dev->priv.hca_devcom_comp);
> +	mlx5_esw_reps_block(esw);
>  }

Both assignments to esw->mode in this function are reached after
reps_lock has been dropped at the top of the function.

mlx5_rescan_drivers_locked() can invoke driver bind/unbind which routes
through mlx5_eswitch_unregister_vport_reps(), and that path now takes
reps_lock and reads esw->mode to decide whether to call
__unload_reps_all_vport().

Can a rep-unregister that runs during the rescan observe a stale
esw->mode here and make the wrong unload decision?

[ ... ]

> @@ -4496,9 +4524,10 @@ mlx5_eswitch_vport_has_rep(const struct mlx5_eswitch *esw, u16 vport_num)

[ ... ]

> @@ -4525,9 +4585,35 @@ void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type)
>  
>  	mlx5_esw_for_each_rep(esw, i, rep)
>  		atomic_set(&rep->rep_data[rep_type].state, REP_UNREGISTERED);
> +
> +	esw->offloads.rep_ops[rep_type] = NULL;
> +}

This new NULL store on unregister appears to introduce a concurrent
NULL dereference in readers that do not hold reps_lock. Before this
patch, rep_ops[rep_type] was set once at register and never cleared,
so a REP_LOADED state check was sufficient to know the pointer was
valid.

mlx5_eswitch_get_proto_dev() is one such reader:

    rep = mlx5_eswitch_get_rep(esw, vport);
    if (atomic_read(&rep->rep_data[rep_type].state) == REP_LOADED &&
        esw->offloads.rep_ops[rep_type]->get_proto_dev)
            return esw->offloads.rep_ops[rep_type]->get_proto_dev(rep);

The state check and each pointer load here are independent reads. Can
a concurrent unregister on another CPU run between the state load and
the ->get_proto_dev dereference, transitioning the rep through
REP_REGISTERED/REP_UNREGISTERED and then storing NULL into rep_ops,
so the second load observes NULL?

mlx5_esw_offloads_rep_event_unpair() and mlx5_esw_offloads_pair() have
the same shape:

    ops = esw->offloads.rep_ops[rep_type];
    if (atomic_read(&rep->rep_data[rep_type].state) == REP_LOADED &&
        ops->event)
            ops->event(esw, rep, ...);

Neither path holds reps_lock; they run from the devcom PAIR/UNPAIR
event handler. Can ops be NULL here once an unregister has cleared
rep_ops?

If readers are expected to be safe, should they either take reps_lock,
be converted to RCU, or skip the NULL clear on unregister?

[ ... ]
-- 
pw-bot: cr

