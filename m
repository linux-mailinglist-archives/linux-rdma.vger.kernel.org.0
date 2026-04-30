Return-Path: <linux-rdma+bounces-19762-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHVpLXez8ml8tgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19762-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 03:42:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E4849C0FE
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 03:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C8A9301B71D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 01:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4101E273D9F;
	Thu, 30 Apr 2026 01:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igEX+T/E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F316425FA29;
	Thu, 30 Apr 2026 01:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777513330; cv=none; b=M7Z6J5T+NaUAisGbvc0Qsw8hdwmzqEjN/oyaGNsoupgBGY4gU6SDGnfUk0R0AKcIKGRqrch+Wwf7O7gamM4k7XR0/aGEKedV+XwNBqOeflC0F0W8LLoMg6WNkWk4rlVATfrJCLg6Dr7gM+U7hVgrvMzq5RP7NTAg0kvHGAP3BiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777513330; c=relaxed/simple;
	bh=GsmT1RcufuM41CP75WSqpDxykYMBHI9vbSqP/ieAjWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEqqTEFYNI5umebBM/5VelPD1Mmdf7Ix4L1lv+zHkWhxDhmp/M1LNVSFniSNUrOtVsjny9CU5UBQ5omnjXnNYYcnacvzNkIQpb+H2hnmZPLE3RLc6vgoT1scgjpQOPWZXPwl3sIXx4YECrmh+vF2VrbcX4P6aqNf40ZLhHabTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igEX+T/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3E0C19425;
	Thu, 30 Apr 2026 01:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777513329;
	bh=GsmT1RcufuM41CP75WSqpDxykYMBHI9vbSqP/ieAjWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igEX+T/Efhz4E/+qyMxeRMEzu8NVSS7CYcoYKbk52fIDsbQBf6Ox26E4CrP5A25Gu
	 we+MCBkF/MIUINtFi3tJNFQskwUK+t+phfygh/tTrysokEotbkyfxa/gxiB6azpvmR
	 wuEVLQmMGav5+PtX1zxiVkYqj4QbRHgWz5cL+QfnIyFXu3dBOUvuMUKxFsoeTAQsBR
	 HJ3q385dPokK53L37O+o/AKLFGzauoVuH6woDZVwvgjZLf62IMBj33ckeGfCtGD6Gd
	 ncAj8qf1zT6ckcg+nDtmI3HNikIMW3gcgSVUM7OA98+ekQ7QT9BgYs/zBy1ZqehU07
	 udWcObuOEIgQg==
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	saeedm@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	shayd@nvidia.com,
	horms@kernel.org,
	phaddad@nvidia.com,
	kees@kernel.org,
	parav@nvidia.com,
	gal@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dtatulea@nvidia.com
Subject: Re: [PATCH net V4 1/4] net/mlx5: SD: Serialize init/cleanup
Date: Wed, 29 Apr 2026 18:42:07 -0700
Message-ID: <20260430014207.2375703-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428060111.221086-2-tariqt@nvidia.com>
References: <20260428060111.221086-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 20E4849C0FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-19762-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/mlx5: SD: Serialize init/cleanup

This commit protects the Socket-Direct (SD) init/cleanup paths with the
devcom component lock and tracks the SD group state on the primary device.
It skips init if the primary is already UP, and skips cleanup unless the
primary is UP, serializing the bring-up/tear-down sequence across PFs.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> index 762c783156b4..d42c283cbb38 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c

[ ... ]

> @@ -491,22 +507,34 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
>  {
>  	struct mlx5_sd *sd = mlx5_get_sd(dev);
>  	struct mlx5_core_dev *primary, *pos;
> +	struct mlx5_sd *primary_sd;
>  	int i;
>  
>  	if (!sd)
>  		return;
>  
> +	mlx5_devcom_comp_lock(sd->devcom);
>  	if (!mlx5_devcom_comp_is_ready(sd->devcom))
> -		goto out;
> +		goto out_unlock;
>  
>  	primary = mlx5_sd_get_primary(dev);
> +	if (!primary)
> +		goto out_unlock;
> +
> +	primary_sd = mlx5_get_sd(primary);
> +	if (primary_sd->state != MLX5_SD_STATE_UP)
> +		goto out_unlock;

If the device is unbound during the race window where the devcom component
is ready but the state is still MLX5_SD_STATE_DOWN (for example, just after
sd_register() finishes but before mlx5_sd_init() sets the state to UP), does
this early exit leave the component marked as ready?

Since mlx5_devcom_comp_set_ready(sd->devcom, false) was moved out of
sd_unregister() and into this function, skipping it here means the device will
unregister and free its struct mlx5_sd while the group is still ready.

Could a concurrent mlx5_sd_init() on another peer acquire the devcom lock,
observe that it is ready, and proceed? If the unregistered device was the
primary, mlx5_get_sd(primary) would return NULL, causing a NULL pointer
dereference at primary_sd->state. If it was a secondary, mlx5_sd_init()
would iterate over primary_sd->secondaries and access the freed device
structure, resulting in a use-after-free.

> +
>  	mlx5_sd_for_each_secondary(i, primary, pos)
>  		sd_cmd_unset_secondary(pos);
>  	sd_cmd_unset_primary(primary);
>  	debugfs_remove_recursive(sd->dfs);

This isn't a regression introduced in this patch, but does storing sd->dfs
locally instead of on the primary device cause debugfs entries to leak?

If a different peer is unbound first, its sd->dfs is NULL, making the call
to debugfs_remove_recursive() a no-op. The cleanup then finishes and marks
the group as unready.

When the original device that created the debugfs directory is later unbound,
it sees the group is no longer ready and skips this block entirely, never
freeing its sd->dfs. Since these files hold pointers to the mlx5_core_dev
structs, accessing them from userspace after the devices are freed could
trigger a use-after-free.

I note this was fixed later in the series by commit "net/mlx5: SD, Keep
multi-pf debugfs entries on primary", but wanted to highlight it here.

>  
>  	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
> -out:
> +	primary_sd->state = MLX5_SD_STATE_DOWN;
> +	mlx5_devcom_comp_set_ready(sd->devcom, false);
> +out_unlock:
> +	mlx5_devcom_comp_unlock(sd->devcom);
>  	sd_unregister(dev);
>  	sd_cleanup(dev);
>  }
-- 
pw-bot: cr

