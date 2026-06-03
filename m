Return-Path: <linux-rdma+bounces-21664-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CpfACO+QH2rtnAAAu9opvQ
	(envelope-from <linux-rdma+bounces-21664-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 04:26:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C223633A34
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 04:26:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DV1Os+GL;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21664-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21664-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A4A73014A09
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 02:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A3D3DB632;
	Wed,  3 Jun 2026 02:26:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107A63D8115;
	Wed,  3 Jun 2026 02:26:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780453609; cv=none; b=jBrSTPC2N+gxxd3GrZh6YxXZ9kQvZ3QBkUnwkZyKbOEJZzOQEmPKkl2MevhdPWKBNpaZ1nNfYrEbpq9cjzxGKFT3yOkck4koqKcImx4+f+8/c4wdDdaY6Y5WgF6iST7kI+zgVWyr5SejRNKyEEldoblBNwfz674mrB7wHtZwCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780453609; c=relaxed/simple;
	bh=JSUPrEJnDx7Y0UKcp3Wag0GnuEXQ80bx31RIsTPY6wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmvjuA1ZOmhEz0PrKREH2oz36CV6hXMNn4RiQhvfsMyuCy3ZRBufx6dJEGAF67QdDhO7dn3xuuwBziGqpls/es+5lnnEpwqadn1y1tcmLlDqSp/yiTUg1ygg9qxueDzaiGCQl75rPiQwQNLugB2ruLxBdrw/MxtjGL0OZOuuA28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DV1Os+GL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAEA1F00893;
	Wed,  3 Jun 2026 02:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780453607;
	bh=N0fLh43R86usJ8b+pqssco8QjhfpmkspzOkkU1T3cgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DV1Os+GLiUUBUTukFYUZdDDaUuxx+E9yUM6VtjSCxMnPQL+AuxO5Pw5W8zhrmcoKL
	 bXRM444HpieyB9Ox4o7m2fUJ8S6V3V8VD+B7w+z4rRpwQvds7HubHp1Gvr9vCALyeV
	 ky0jToTuVxQ2hlcK82t4gOLNEsL+ROKzA5JifKTnYkMJBLbVVAMliZfCT1yxT4kaeB
	 W5BaYA3L04Lu/KaOd8mwyjcOHTItW4RUbt/XhiJolv8UM7DB3YNB0i6K8DeoytePNq
	 LkAw+0GaDesHccPfLk3w8B1t6A2XhuKjMAmcoF4YIFfCpxBjirpaBQZ6+K+WiQ2QdU
	 DYeMNrdneB2ng==
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
	noren@nvidia.com,
	ychemla@nvidia.com,
	shayd@nvidia.com,
	ohartoov@nvidia.com,
	edwards@nvidia.com,
	horms@kernel.org,
	msanalla@nvidia.com,
	parav@nvidia.com,
	kees@kernel.org,
	phaddad@nvidia.com,
	moshe@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	gal@nvidia.com,
	jacob.e.keller@intel.com
Subject: Re: [PATCH net-next V2 12/13] net/mlx5e: TC, enable steering for SD LAG
Date: Tue,  2 Jun 2026 19:26:45 -0700
Message-ID: <20260603022645.2298955-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531113954.395443-13-tariqt@nvidia.com>
References: <20260531113954.395443-13-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-21664-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:noren@nvidia.com,m:ychemla@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:phaddad@nvidia.com,m:moshe@nvidia.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C223633A34

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/mlx5e: TC, enable steering for SD LAG

Extends TC flow steering to support the SD LAG mode by adding
mlx5_lag_is_sd()/mlx5_sd_is_primary() helpers, redirecting uplink
priv/proto_dev queries to the primary eswitch in SD setups, and adding
peer-flow handling for secondary devices.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> index 2a16368a948e..910492eb51f2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c

[ ... ]

> @@ -4196,9 +4197,26 @@ static bool is_lag_dev(struct mlx5e_priv *priv,
>  		 same_hw_reps(priv, peer_netdev));
>  }
>  
> +static bool is_sd_eligible(struct mlx5e_priv *priv,
> +			   struct net_device *peer_netdev)
> +{
> +	struct mlx5e_priv *peer_priv;
> +
> +	peer_priv = netdev_priv(peer_netdev);
> +	return same_hw_reps(priv, peer_netdev) &&
> +		mlx5_lag_is_sd(priv->mdev) &&
> +		(mlx5_sd_get_primary(priv->mdev) ==
> +		 mlx5_sd_get_primary(peer_priv->mdev));
> +}

[Medium]
With the redefinition of mlx5_sd_get_primary() to return NULL when
sd->devcom is not ready, can both calls here legitimately return NULL
during a teardown race and make the equality test succeed?

In that situation is_sd_eligible() would report two unrelated devices
as belonging to the same SD primary.

Would something like this be more robust:

    struct mlx5_core_dev *primary = mlx5_sd_get_primary(priv->mdev);

    return same_hw_reps(priv, peer_netdev) &&
           mlx5_lag_is_sd(priv->mdev) &&
           primary &&
           primary == mlx5_sd_get_primary(peer_priv->mdev);

> +
>  static bool is_multiport_eligible(struct mlx5e_priv *priv, struct net_device *out_dev)
>  {
> -	return same_hw_reps(priv, out_dev) && mlx5_lag_is_mpesw(priv->mdev);
> +	struct mlx5_core_dev *primary = mlx5_sd_get_primary(priv->mdev);
> +
> +	if (!primary)
> +		return false;
> +
> +	return same_hw_reps(priv, out_dev) && mlx5_lag_is_mpesw(primary);
>  }

[ ... ]

> @@ -4351,7 +4372,7 @@ static struct rhashtable *get_tc_ht(struct mlx5e_priv *priv,
>  		return &tc->ht;
>  }
>  
> -static bool is_peer_flow_needed(struct mlx5e_tc_flow *flow)
> +static bool is_peer_flow_needed(struct mlx5e_tc_flow *flow, bool *is_sd)
>  {
>  	struct mlx5_esw_flow_attr *esw_attr = flow->attr->esw_attr;
>  	struct mlx5_flow_attr *attr = flow->attr;
> @@ -4372,6 +4393,13 @@ static bool is_peer_flow_needed(struct mlx5e_tc_flow *flow)
>  	if (mlx5_lag_is_mpesw(esw_attr->in_mdev))
>  		return true;
>  
> +	if (mlx5_lag_is_sd(esw_attr->in_mdev) &&
> +	    !mlx5_sd_is_primary(esw_attr->in_mdev)) {
> +		if (!mlx5_lag_is_mpesw(mlx5_sd_get_primary(esw_attr->in_mdev)))
> +			*is_sd = true;
> +		return true;
> +	}
> +
>  	return false;
>  }

[High]
Can mlx5_sd_get_primary(esw_attr->in_mdev) return NULL here?

The patch updates mlx5_sd_get_primary() to return NULL when
sd->devcom is not ready:

    struct mlx5_core_dev *mlx5_sd_get_primary(struct mlx5_core_dev *dev)
    {
        struct mlx5_sd *sd = mlx5_get_sd(dev);

        if (!sd)
            return dev;

        if (!mlx5_devcom_comp_is_ready(sd->devcom))
            return NULL;

        return sd->primary ? dev : sd->primary_dev;
    }

The result is then handed straight to mlx5_lag_is_mpesw(), which
dereferences its argument:

    bool mlx5_lag_is_mpesw(struct mlx5_core_dev *dev)
    {
        struct mlx5_lag *ldev = mlx5_lag_dev(dev);

        return ldev && ldev->mode == MLX5_LAG_MODE_MPESW;
    }

mlx5_lag_dev(NULL) evaluates NULL->priv.lag.

Note that the companion is_multiport_eligible() helper added in the
same patch does add the if (!primary) return false; guard for the
same reason; would the same guard be appropriate here?

Could the sequence "mlx5_lag_is_sd() returns true (group_id != 0
observed under lag_lock) but mlx5_sd_get_primary() returns NULL
(devcom->ready observed false)" occur if SD teardown runs concurrently
with a TC flow add?

[Medium]
On the topic of unsynchronized SD-state reads in this branch, the
writer (mlx5_sd_cleanup) updates sd->primary and devcom->ready under
the devcom rwsem, but the readers introduced by this patch take none
of those locks:

  - mlx5_sd_is_primary() reads sd->primary with no lock and no
    READ_ONCE.
  - mlx5_sd_get_primary() pairs READ_ONCE(ready) with a plain read of
    sd->primary and sd->primary_dev.
  - mlx5_lag_is_sd() reads pf->group_id under lag_lock, which does
    not order against the devcom rwsem at all.

Since sd->primary also selects which arm of the union in struct
mlx5_sd is valid (secondaries[] vs primary_dev), can a torn or stale
read of sd->primary make these helpers read the wrong union member?

> @@ -4628,19 +4657,26 @@ mlx5e_add_fdb_flow(struct mlx5e_priv *priv,
>  		   struct mlx5e_tc_flow **__flow)
>  {
>  	struct mlx5_devcom_comp_dev *devcom = priv->mdev->priv.eswitch->devcom, *pos;
> +	struct netlink_ext_ack *extack = f->common.extack;
>  	struct mlx5e_rep_priv *rpriv = priv->ppriv;
>  	struct mlx5_eswitch_rep *in_rep = rpriv->rep;
>  	struct mlx5_core_dev *in_mdev = priv->mdev;
>  	struct mlx5_eswitch *peer_esw;
>  	struct mlx5e_tc_flow *flow;
> +	bool is_sd = false;
>  	int err;
>  
> +	if (mlx5_lag_is_sd(in_mdev) && !mlx5_lag_is_active(in_mdev)) {
> +		NL_SET_ERR_MSG_MOD(extack, "SD shared FDB not yet active");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	flow = __mlx5e_add_fdb_flow(priv, f, flow_flags, filter_dev, in_rep,
>  				    in_mdev);
>  	if (IS_ERR(flow))
>  		return PTR_ERR(flow);
>  
> -	if (!is_peer_flow_needed(flow)) {
> +	if (!is_peer_flow_needed(flow, &is_sd)) {
>  		*__flow = flow;
>  		return 0;
>  	}
> @@ -4651,6 +4687,15 @@ mlx5e_add_fdb_flow(struct mlx5e_priv *priv,
>  	}
>  
>  	mlx5_devcom_for_each_peer_entry(devcom, peer_esw, pos) {
> +		if (is_sd) {
> +			/* SD shared FDB: only the matching SD primary. */
> +			if (mlx5_sd_get_primary(in_mdev) !=
> +			    mlx5_sd_get_primary(peer_esw->dev))
> +				continue;
> +		} else {
> +			if (!mlx5_sd_is_primary(peer_esw->dev))
> +				continue;
> +		}
>  		err = mlx5e_tc_add_fdb_peer_flow(f, flow, flow_flags, peer_esw);
>  		if (err)
>  			goto peer_clean;

[Medium]
Same NULL == NULL question applies here. The devcom being iterated is
priv->mdev->priv.eswitch->devcom, i.e. the eswitch devcom, so peer_esw
entries are not necessarily SD peers and may belong to different SD
groups (or to none).

If mlx5_sd_get_primary() can transiently return NULL on either side
during an SD teardown race, both sides may evaluate to NULL and the
!= test will not skip the unrelated peer:

    if (mlx5_sd_get_primary(in_mdev) !=
        mlx5_sd_get_primary(peer_esw->dev))
        continue;

Would explicitly requiring a non-NULL primary on at least one side, or
caching mlx5_sd_get_primary(in_mdev) once and rejecting NULL up front,
be more correct?

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> index ec606851feb8..25286ecd724e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> @@ -49,13 +49,16 @@ static int mlx5_sd_get_host_buses(struct mlx5_core_dev *dev)
>  	return sd->host_buses;
>  }
>  
> -static struct mlx5_core_dev *mlx5_sd_get_primary(struct mlx5_core_dev *dev)
> +struct mlx5_core_dev *mlx5_sd_get_primary(struct mlx5_core_dev *dev)
>  {
>  	struct mlx5_sd *sd = mlx5_get_sd(dev);
>  
>  	if (!sd)
>  		return dev;
>  
> +	if (!mlx5_devcom_comp_is_ready(sd->devcom))
> +		return NULL;
> +
>  	return sd->primary ? dev : sd->primary_dev;
>  }

[ ... ]

