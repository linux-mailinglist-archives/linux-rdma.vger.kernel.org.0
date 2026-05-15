Return-Path: <linux-rdma+bounces-20745-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NK3IFh4BmoUkAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20745-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 03:35:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3472548708
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 03:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48F423044F17
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 01:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437182F7478;
	Fri, 15 May 2026 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoePZStM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F791391;
	Fri, 15 May 2026 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808911; cv=none; b=kn6sYwqahZ6HRAiAtl7qoCUC7tKgAK4+akyr+/nkwqSZN0sh7ctYJxAflenu47i6AJV9o03oDc2Ly56adqZ+xKSSpiBf6K+Z0QOu9nsqNC07a2j1Gl2ysqBTlaq5JwmOniJa9jRMn7bW+BKgg5/6CsiYJK6jFOLUchdQRM0SuVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808911; c=relaxed/simple;
	bh=MetcOpFWs7h0xBLOEAcEN86jIbdJx3yD33tX/Dul9QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IoWFQMB8qdVIvGg2ohdU1zSARf7/7jA79esB8Jqe9JOHmD5DfzAbfG18sr0I1V3h2QBLSrCLxyqrv+gR00pcTdXZpaoZ5mryZNdBlOmJdQBGzHSwAWHMxysB8T6KBA/Bqz4ofpvhgbD8hcsJuUn7HQj3WtG9/KszrudF8FRQqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoePZStM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99270C2BCB3;
	Fri, 15 May 2026 01:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808910;
	bh=MetcOpFWs7h0xBLOEAcEN86jIbdJx3yD33tX/Dul9QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aoePZStM19di7cOMDHRSgzmCY+aVOrEE0eWQnRIqxyw0oBc1XEIXblsXeNgeW2ail
	 osxDIJXAuI+FJt2IqwlWVwy1ICdE5LOIDhr49KJin+5aQ/MtV3fNLK/HLkawW//JSy
	 BddFgjaY1KaxKoGYeTazmo5XmwD4PCnKQkbLjvsEME6n/uMEhRdLvBENac8OakE2ti
	 KXab4IpGJ1hJJ530jvQYgUIIWqHjIRuTOu4jTFKnKnPZDqvNdtbX/7NzvqWHQBD12V
	 2cuYeb6pstSc9LJaq6ayG/piIwbToIsSk9lijYkeDOQHnkPLnqgD1qTeneJ6LuTlPS
	 cPJOs0y/j1jQw==
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
	shayd@nvidia.com,
	ohartoov@nvidia.com,
	edwards@nvidia.com,
	msanalla@nvidia.com,
	horms@kernel.org,
	parav@nvidia.com,
	moshe@nvidia.com,
	kees@kernel.org,
	phaddad@nvidia.com,
	gbayer@linux.ibm.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gal@nvidia.com
Subject: Re: [PATCH net] net/mlx5: Skip disabled vports when setting max TX speed
Date: Thu, 14 May 2026 18:35:08 -0700
Message-ID: <20260515013508.1308541-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513063640.334132-1-tariqt@nvidia.com>
References: <20260513063640.334132-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D3472548708
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
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-20745-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/mlx5: Skip disabled vports when setting max TX speed

This commit modifies the LAG activation process to skip setting the maximum
TX speed for disabled vports, preventing firmware commands from being sent
to uninitialized vports. It stores the aggregated speed in the vport
structure so it can be applied later if the vport is enabled.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c

[ ... ]

> @@ -948,6 +966,9 @@ int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
>  
>  	esw->enabled_vports++;
>  	esw_debug(esw->dev, "Enabled VPORT(%d)\n", vport_num);
> +
> +	if (vport->agg_max_tx_speed)

Could dynamically allocated vports bypass the active LAG QoS speed limits?

If a new vport is allocated dynamically after the LAG is already active,
it appears agg_max_tx_speed would be zero-initialized. When this new vport
is subsequently enabled here, the condition evaluates to false, which
would skip the firmware speed update entirely.

> +		mlx5_esw_vport_set_max_tx_speed(esw, vport);

Does this introduce a race condition with mlx5_lag_modify_device_vports_speed?

If the LAG thread is concurrently updating the speed:

LAG thread (lockless):
vport->agg_max_tx_speed = speed;
if (!vport->enabled)
    continue;

ESW thread (with esw->state_lock):
vport->enabled = true;
...
if (vport->agg_max_tx_speed)
    mlx5_esw_vport_set_max_tx_speed(esw, vport);

Since there are no shared locks or explicit memory barriers, could CPU
reordering allow the LAG thread to see a false enabled state while the ESW
thread sees a zero agg_max_tx_speed, resulting in neither thread issuing the
firmware command?

>  done:
>  	mutex_unlock(&esw->state_lock);

[ ... ]

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c

[ ... ]

> @@ -1274,6 +1274,11 @@ static void mlx5_lag_modify_device_vports_speed(struct mlx5_core_dev *mdev,
>  		if (vport->vport == MLX5_VPORT_UPLINK)
>  			continue;
>  
> +		vport->agg_max_tx_speed = speed;
> +
> +		if (!vport->enabled)

Is there a regression here regarding the lifetime of the vport pointer?

This loop locklessly iterates over the esw->vports xarray. Because the xarray
iteration drops the RCU read lock before executing the loop body, and
mlx5_esw_vport_free() calls kfree() synchronously without an RCU grace
period, could a concurrent vport deletion cause these new field accesses to
operate on freed memory?

> +			continue;
> +
>  		ret = mlx5_modify_vport_max_tx_speed(mdev, op_mod,
>  						     vport->vport, true, speed);

Does this code contain a time-of-check to time-of-use regression
that is affected by the lockless architecture here?

Looking at mlx5_modify_vport_max_tx_speed(), it queries the firmware
admin_state and writes it back without holding esw->state_lock. If the LAG
thread reads an UP state, but mlx5_esw_vport_disable() concurrently disables
the vport (setting the hardware state to DOWN), could the LAG thread
accidentally overwrite the admin_state back to UP, effectively reverting the
disable action?

>  		if (ret)
-- 
pw-bot: cr

