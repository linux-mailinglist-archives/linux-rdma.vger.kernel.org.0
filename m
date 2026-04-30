Return-Path: <linux-rdma+bounces-19763-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGuPJJ6z8ml8tgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19763-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 03:42:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F23049C132
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 03:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 953EA303B727
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 01:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228FD17D6;
	Thu, 30 Apr 2026 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzXidNvm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D724627281E;
	Thu, 30 Apr 2026 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777513331; cv=none; b=qzEjlOSqxgMh/1fZX2SwZUee6eRToGpk8XTaMYhwSEPU3QxtMSBx0N14ZtztAXQMzPi5lOLSr4Auo1IJbF2dz3GBLxTN0zym5udIAyNzIuGovQ5ndbN8qgsd6GXze3mXTPRiC/yKET00OO6UKjm+cMHXDx16X0PzU8fMyz1JSiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777513331; c=relaxed/simple;
	bh=Y0C8DoahSSBT/snQiPAOYHFv3KwGR48cDnmql3PWSC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIXUPLoLyOV6UXgfrHp3851GBShzOYpYq2sZ9C3ZE95G37zPXY7XuQoa1ITRqgnB3ytrgbePtU7ITvTQaTtNtXMNNLsArCR+o7kJwzKM9IKn94rdHl4RqD/uovtecc41WnnUzfr2wOWtftdujiAICQP0P9XtYYoXHHt8XTGQRFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzXidNvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036A4C2BCC4;
	Thu, 30 Apr 2026 01:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777513331;
	bh=Y0C8DoahSSBT/snQiPAOYHFv3KwGR48cDnmql3PWSC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RzXidNvmmnGf8b/uyztl3xI0wT8zjSz3q7cSdItn3VVYNsj3/d9sebLXw5ISA5eLX
	 G/gMygu9wLCO9Q1WGH/jocz26HedGWEWYQFyoxQPgwL9Z3FJbTMcNC03K7I0ogX+Ai
	 xfXpLmI4meUZU/x1AG/SCVVvNAFuyfsmEU51ahL7MsXfBNWBo1hiuqCkGmalH9Mviu
	 gxF3m83gf2vDKcoqaTBiUvZHZ9NgDle4kDGv8p+r1cwz+46SgDXfKX/jCEo1xlfGWo
	 p629qruJg/EN3P3UO9b+xUFrFbk/xTRi5sBbu4PSGcKSl3p9Uj9R7g5FTQxkXxrrty
	 /rNLT09HXwJtg==
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
Subject: Re: [PATCH net V4 3/4] net/mlx5e: SD, Fix missing cleanup on probe error
Date: Wed, 29 Apr 2026 18:42:09 -0700
Message-ID: <20260430014209.2375731-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428060111.221086-4-tariqt@nvidia.com>
References: <20260428060111.221086-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3F23049C132
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
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-19763-lists,linux-rdma=lfdr.de];
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
net/mlx5e: SD, Fix missing cleanup on probe error

This commit adds a missing mlx5_sd_cleanup() call to the probe error path.
The commit message notes a similar gap exists on the resume path leaving
sd == NULL on failure, but defers the fix to a follow-up series.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 5a46870c4b74..e21affd0ffc4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
[ ... ]
> @@ -6912,9 +6912,16 @@ static int mlx5e_probe(struct auxiliary_device *adev,
>  		return err;
>  
>  	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
> -	if (actual_adev)
> -		return _mlx5e_probe(actual_adev);
> +	if (actual_adev) {
> +		err = _mlx5e_probe(actual_adev);
> +		if (err)
> +			goto sd_cleanup;
> +	}
>  	return 0;
> +
> +sd_cleanup:
> +	mlx5_sd_cleanup(mdev);
> +	return err;
>  }
>  
>  static void _mlx5e_remove(struct auxiliary_device *adev)

Will leaving the resume gap unfixed as mentioned in the commit message cause
a NULL pointer dereference when a secondary device is later removed?

If a secondary device fails resume, sd becomes NULL. Later during removal,
mlx5_sd_get_adev() will check !sd and return the secondary adev.

This causes _mlx5e_remove() to be executed on the secondary adev:

_mlx5e_remove()
{
        struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
        struct mlx5e_dev *mlx5e_dev = auxiliary_get_drvdata(adev);
        struct net_device *netdev = mlx5e_dev->netdev;
        ...
}

Since _mlx5e_probe() is never called on secondary devices,
auxiliary_get_drvdata(adev) returns NULL. Does this mean accessing
mlx5e_dev->netdev will crash?

Would it be safer to add a NULL check for mlx5e_dev in _mlx5e_remove()
until the proper PM lifecycle fixes are implemented?

