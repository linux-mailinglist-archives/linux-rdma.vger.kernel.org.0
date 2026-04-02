Return-Path: <linux-rdma+bounces-18936-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF3III7fzWlVigYAu9opvQ
	(envelope-from <linux-rdma+bounces-18936-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 05:16:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 306C938306F
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 05:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EEBC305DF1F
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 03:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9548435AC06;
	Thu,  2 Apr 2026 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1Q+uh93"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483435A3AD;
	Thu,  2 Apr 2026 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775099356; cv=none; b=JguoIpqz7nb7UZjFqQNpktsclxui8iXV9IfcyS8OZVHD2HXoWD0cayUFdh3oc+dy0+AsQe3E4zAl8ILZvKB71IH9VyxEVupLBrNZ/nZ7yOx0mjluqobCJxDxOmoF157uDS/JOe3VLzEMGUGB3VfNv6NI0+FFLpXSWejM3ouQehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775099356; c=relaxed/simple;
	bh=9s4+QQuD147/ThPWLepqCPxnZGvx3UncHvBNbw74IuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0Fzn9ofQQViiCo9wQdQBWGWUnNaSzDbf7y6zKIXpEYlDC8EgDZjnQ3TX3gp68Ap/znAqhVTDuZxfKXMT+r5T2rBMBjR2NDR1NGMD6iKl490FlrE+PmxTY1cUG7cpsOaVtnboC2NivtgWlhb4ElmTCbU2SjCaUIP1dcJ+X6EGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1Q+uh93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9BAC2BCB0;
	Thu,  2 Apr 2026 03:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775099356;
	bh=9s4+QQuD147/ThPWLepqCPxnZGvx3UncHvBNbw74IuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1Q+uh93EBR+7VGaiMwZrSgDWGBOYt1GrZtRYhnnon2NPmXTSQNTdHWKxadiJv201
	 LvFitOL7tqJV3AF0NdZGMqIIIBs+Oy/r+tU9EJEa5L2kjpwVe815uOM2N6IUUjvOpf
	 EFeU1zDiyq0li71yWkHg+B2hMGIqqB46VjVsfIBLYfrvx7pgb/tGIOAfx/zwCPG0Y6
	 P5SZbKoH9P7sxIpmhfKzvA4DV0MeWXOUTlZrZoIoc4uZuCD5bkY5CpFvcXJKHpOPXU
	 NhvGMSmFE9gd/y0JgdnAQpFgSlX0pzB4vJ+6unmJy/Rfn9pkpajoHRRlS5FgVkhp5L
	 q86TReqjJAHRw==
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
	kees@kernel.org,
	parav@nvidia.com,
	phaddad@nvidia.com,
	gal@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net/mlx5: SD: Serialize init/cleanup
Date: Wed,  1 Apr 2026 20:09:14 -0700
Message-ID: <20260402030914.878606-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330193412.53408-4-tariqt@nvidia.com>
References: <20260330193412.53408-4-tariqt@nvidia.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-18936-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 306C938306F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/mlx5: SD: Serialize init/cleanup

This commit introduces a state tracker and locking around the Socket-Direct
init and cleanup routines. It prevents multiple physical functions from
concurrently bringing up or tearing down the SD group.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> index 4c80b9d25283..374f27b78fbe 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c

[ ... ]

> @@ -505,11 +520,16 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
>  	if (!sd)
>  		return;
>  
> +	mlx5_devcom_comp_lock(sd->devcom);
>  	if (!mlx5_devcom_comp_is_ready(sd->devcom))
> -		goto out;
> +		goto out_unlock;
>  
>  	primary = mlx5_sd_get_primary(dev);
>  	primary_sd = mlx5_get_sd(primary);
> +
> +	if (primary_sd->state != MLX5_SD_STATE_UP)
> +		goto out_unlock;
> +
>  	mlx5_sd_for_each_secondary(i, primary, pos)
>  		sd_cmd_unset_secondary(pos);
>  	sd_cmd_unset_primary(primary);
> @@ -517,7 +537,9 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
>  	primary_sd->dfs = NULL;
>  
>  	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
> -out:
> +	primary_sd->state = MLX5_SD_STATE_DOWN;
> +out_unlock:
> +	mlx5_devcom_comp_unlock(sd->devcom);
>  	sd_unregister(dev);
>  	sd_cleanup(dev);
>  }

Is there a race condition if a secondary PF calls mlx5_sd_init() while the
primary PF is running mlx5_sd_cleanup()?

In mlx5_sd_cleanup(), the code sets the state to MLX5_SD_STATE_DOWN and drops
the devcom lock before calling sd_unregister(). At this point, the primary
PF is still registered in the devcom group, so mlx5_devcom_comp_is_ready()
remains true.

If a secondary PF is concurrently probed, could it acquire the devcom lock
and observe this intermediate state?

CPU1
mlx5_sd_cleanup()
    primary_sd->state = MLX5_SD_STATE_DOWN;
    mlx5_devcom_comp_unlock(sd->devcom);
    // Preempted before sd_unregister(dev)

CPU2 would see this in mlx5_sd_init():
    mlx5_devcom_comp_lock(sd->devcom);
    if (!mlx5_devcom_comp_is_ready(sd->devcom)) // returns true
        goto out;
    
    primary = mlx5_sd_get_primary(dev);
    primary_sd = mlx5_get_sd(primary);
    
    if (primary_sd->state == MLX5_SD_STATE_UP) // returns false
        goto out;
    ...
    debugfs_create_file("primary", 0400, primary_sd->dfs, primary, &dev_fops);

Would CPU2 proceed to initialize the group using the dying primary PF?

If CPU1 then resumes and finishes sd_cleanup(), it would free the primary_sd
structure and the primary device. This might leave the secondary PF with
dangling pointers in the debugfs files, potentially leading to a
use-after-free on access.

Furthermore, when the secondary is later removed, mlx5_sd_cleanup(secondary)
might see is_ready as false and skip the teardown entirely, leaving the
dangling debugfs files permanently.

