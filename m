Return-Path: <linux-rdma+bounces-18824-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNJUKqssy2n8EQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18824-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 04:08:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 609923634AC
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 04:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EA8B3048076
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 02:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5BB36895D;
	Tue, 31 Mar 2026 02:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3NHhIoq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F92367F39;
	Tue, 31 Mar 2026 02:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774922900; cv=none; b=i99+ZVZn3gDIXmLUjJs0jg59BjYnqMORWSRtetgEBiqiG1nYIJL0QC34QGPBh74fahfzVugjMGTxMiTU6tI4bFhK1EDpbOsYn4sYphkTcB2mBqCcyM2QGRCiNuYWLSj6IvPyR5juixPdFwAefnePqFL5P0V82Ebg+K6ALNIJSKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774922900; c=relaxed/simple;
	bh=G7Vy2RYfpWGsgppluQlynglszZf9OOhmdm5D0oSaJ1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMAO4OtKNJU4DhJMk7aHxB0+ywmovwTPzEpPLu+OFju1IMdcnmC7gEt7aXTg5PCUHdpItZBjao1271eZJnzzJd16eDklZ6wrTX6RA1sHyb5Gv9zw2qxaao0tFcl6TM+WPzBAlWttWt0w4RsczAWKYHcK7Pcko2ZnKtqGdOf4QAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3NHhIoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80564C4CEF7;
	Tue, 31 Mar 2026 02:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774922900;
	bh=G7Vy2RYfpWGsgppluQlynglszZf9OOhmdm5D0oSaJ1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3NHhIoqIcFF1KbpcauTdjvPWinIJogYUTNKVUuEqTk93nyS1xClsj8GxaXi3w4Y0
	 g9NHhozKSk1GwaSYe8A3UYqpnacdq/7gPDiWiCnmM5qcoczamEzp1LWg9dwZ9QZqsn
	 NvlM+8QbzOEAemgZEL5SRXqRmaV5CcxDBvUavOZnjb9uZkwG5mydPpeRlPidrz7m81
	 upKUvsUljvNzuyZL4X/asO17GFw2S96CnI8oNpTg8xV4ocHUjdRnmgnKI7G9HdSp0p
	 TyQ3e39evTqfu1bNof+nRfbDhhjblvyjtURRKW3NRXGY3kdwoaWTR0ksiYzwYABv8t
	 OglC5tUfYC9rg==
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	donald.hunter@gmail.com,
	horms@kernel.org,
	jiri@resnulli.us,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	shuah@kernel.org,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	cratiu@nvidia.com,
	dtatulea@nvidia.com,
	jacob.e.keller@intel.com,
	shshitrit@nvidia.com,
	daniel.zahka@gmail.com,
	parav@nvidia.com,
	ajayachandra@nvidia.com,
	kees@kernel.org,
	shayd@nvidia.com,
	danielj@nvidia.com,
	moshe@nvidia.com,
	willemb@google.com,
	dw@davidwei.uk,
	petrm@nvidia.com,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	joe@dama.to,
	razor@blackwall.org,
	vadim.fedorenko@linux.dev,
	mst@redhat.com,
	antonio@openvpn.net,
	allison.henderson@oracle.com,
	minhquangbui99@gmail.com,
	noren@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	gal@nvidia.com,
	jiri@nvidia.com
Subject: Re: [PATCH net-next V9 11/14] net/mlx5: qos: Remove qos domains and use shd lock
Date: Mon, 30 Mar 2026 19:08:17 -0700
Message-ID: <20260331020817.3525089-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326065949.44058-12-tariqt@nvidia.com>
References: <20260326065949.44058-12-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,davidwei.uk,fomichev.me,iogearbox.net,dama.to,blackwall.org,linux.dev,openvpn.net,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	TAGGED_FROM(0.00)[bounces-18824-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 609923634AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
    net/mlx5: qos: Remove qos domains and use shd lock

This commit removes QoS domains and switches to using the shd lock to
protect against concurrent QoS modifications. It also enables the
supported_cross_device_rate_nodes devlink ops attribute.

Link: https://lore.kernel.org/netdev/20250213180134.323929-1-tariqt@nvidia.com/

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> index 6698ac55a4bfa..c051605fecd23 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> @@ -385,6 +385,7 @@ static const struct devlink_ops mlx5_devlink_ops = {
>  	.rate_node_del = mlx5_esw_devlink_rate_node_del,
>  	.rate_leaf_parent_set = mlx5_esw_devlink_rate_leaf_parent_set,
>  	.rate_node_parent_set = mlx5_esw_devlink_rate_node_parent_set,
> +	.supported_cross_device_rate_nodes = true,

The commit message states that enabling supported_cross_device_rate_nodes
now is safe because mlx5_esw_qos_vport_update_parent rejects cross-esw
parent updates.

When a user provides a DEVLINK_ATTR_PARENT_DEV belonging to an unrelated
device, the devlink core (devlink_nl_rate_parent_node_set) drops the lock on
the parent devlink and calls devlink_rate_node_get_by_name(). This function
traverses the rate_list of the unlocked parent devlink instance.

Does this leave the devlink core exposed to data races and potential
use-after-free vulnerabilities, since the driver's rejection callback
executes only after this lockless list traversal has occurred?

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> index 0be516003bcde..f67f99428959f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> @@ -1110,7 +1068,7 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
>  	struct mlx5_esw_sched_node *parent;
>  
>  	lockdep_assert_held(&esw->state_lock);
> -	esw_qos_lock(esw);
> +	devl_lock(esw->dev->shd);

Could esw->dev->shd be NULL here?

In mlx5_shd_init(), initialization is explicitly skipped for non-PF devices,
meaning Sub-Functions (SFs) acting as E-Switch managers will have a NULL
shd pointer. If the device lacks VPD data, pci_vpd_alloc() returns -ENODEV,
causing mlx5_shd_init() to return 0 but leaving dev->shd as NULL.

When QoS operations are attempted on these devices, calling devl_lock()
dereferences the pointer, which could cause an immediate NULL pointer
dereference and kernel panic.

Additionally, this acquires the devlink lock while already holding
esw->state_lock, establishing the lock order:
state_lock -> devlink->lock.

Conversely, the devlink core invokes driver callbacks with the devlink
instance lock held, and the driver subsequently acquires esw->state_lock
inside these callbacks, creating the reverse order:
devlink->lock -> state_lock.

Does this introduce a circular locking dependency splat between state_lock
and the devlink instance lock?

> @@ -1159,26 +1117,25 @@ int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *vport, u32 max_rate, u32 min_
>  	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
>  	int err;
>  
> -	esw_qos_lock(esw);
> +	devl_lock(esw->dev->shd);

This function is invoked by mlx5_eswitch_set_vport_rate(), which acts as the
handler for the ndo_set_vf_rate netdev callback. The core network stack
executes ndo_set_vf_rate with the rtnl_lock held, establishing the lock
order: rtnl_lock -> devlink->lock.

However, the devlink subsystem enforces the opposite locking order
(devlink->lock -> rtnl_lock). Because all devlink locks share the same
lockdep class, does this inversion trigger a circular locking dependency
lockdep splat and pose an ABBA deadlock risk?

[ ... ]

> @@ -1859,13 +1763,15 @@ mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
>  						  parent ? : esw->qos.root,
>  						  extack);
>  	}
> -	esw_qos_unlock(esw);
> +
>  	return err;
>  }
>  
>  void mlx5_esw_qos_vport_clear_parent(struct mlx5_vport *vport)
>  {
> +	devl_lock(vport->dev->shd);
>  	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
> +	devl_unlock(vport->dev->shd);
>  }

During device teardown, execution paths such as mlx5_unload_one_devl_locked()
hold the primary devlink instance lock. This path invokes
mlx5_eswitch_unload_vf_vports() -> mlx5_esw_offloads_devlink_port_unregister()
-> mlx5_esw_qos_vport_clear_parent().

Because both the primary devlink instance lock and the shd devlink instance
lock are initialized from the same site (devlink_alloc), they share the same
lockdep class.

Does calling devl_lock() directly (instead of using the devlink core's
mutex_lock_nested capability) while a lock of the same class is already held
trigger a recursive locking lockdep warning?

