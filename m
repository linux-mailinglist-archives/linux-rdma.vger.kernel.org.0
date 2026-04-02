Return-Path: <linux-rdma+bounces-18935-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF95LWjfzWlVigYAu9opvQ
	(envelope-from <linux-rdma+bounces-18935-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 05:15:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F0D383061
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 05:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6904D3051852
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 03:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ABB34C808;
	Thu,  2 Apr 2026 03:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPGatijO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D812BEC23;
	Thu,  2 Apr 2026 03:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775099354; cv=none; b=b886AxW9NRbYqEtbaDQ5QfeTGUmwFHL0dpwyJRpvEs5poiLfHMraYKJro59feNw84WPl7+Cj9Rgwte1AVf3OPbmwp8K5m1WSDRnYBdUT20lQCqBonbEl2mPlyMYMmH4obM4POpo+6Ht2Fbtg3H399de1zXizMULTvCFkhDf6OiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775099354; c=relaxed/simple;
	bh=SZpoQlO609agjYu+Nfo9JUW0ZxjnGmPyvGVLwhGK/JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lURMD7/Nru+EsqJJbdcK0WI6CkiJo6HpF3jVq4KMF36E+XJjzEYFQMbubbskhln70EJGGBjCx/69qiqxsSX3qRSPCLtiUzRaC6pdmsBBGRAuciRf0u5oRPRjceZDSVsjU+Pg+xfAkE7BEUtIE35Xyns+VbhO3NrZMpi8kq3lEP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPGatijO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB81C19421;
	Thu,  2 Apr 2026 03:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775099354;
	bh=SZpoQlO609agjYu+Nfo9JUW0ZxjnGmPyvGVLwhGK/JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tPGatijO/mMCnNpaRCH7NQqeAfA7VZetvCmcvWEEcX/WSon9Km4ctstZFCCphAtck
	 xsIgfphv3fX3Kg4BPucnYUbsAZBgL4X18Zzx5IEQ0S6oEeUa+yR2RzZUKADHc+613g
	 55oF0IW9d2mcT0nXHXBupm5mjX1Ek/QEuwmFxkSobGMk8poAih1y22IejI5LhKtIap
	 5J5qWXpQnttfCmuDdaxabILNqlKuhP3/LLuW+KOEKH64o8Kt4ufAvebFtuyr1tM6mK
	 CG8ChsEVNW0Qgt60RRfm3Z1j7a7NJFmnmSSMv0QM+Hy72vDUVZIfj93CV/92sIidiL
	 SxmmTb8plNA4A==
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
Subject: Re: [PATCH net 2/3] net/mlx5: SD, Keep multi-pf debugfs entries on primary
Date: Wed,  1 Apr 2026 20:09:11 -0700
Message-ID: <20260402030911.878500-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330193412.53408-3-tariqt@nvidia.com>
References: <20260330193412.53408-3-tariqt@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-18935-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59F0D383061
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/mlx5: SD, Keep multi-pf debugfs entries on primary

This commit fixes an issue where the "multi-pf" debugfs directory was stored
in the calling device's sd struct but created under the primary device's root.
It explicitly stores the debugfs dentry in the primary device's sd struct.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> index 060649645012..4c80b9d25283 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
[ ... ]
> @@ -491,6 +499,7 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
>  {
>  	struct mlx5_sd *sd = mlx5_get_sd(dev);
>  	struct mlx5_core_dev *primary, *pos;
> +	struct mlx5_sd *primary_sd;
>  	int i;
>  
>  	if (!sd)
> @@ -500,10 +509,12 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
>  		goto out;
>  
>  	primary = mlx5_sd_get_primary(dev);
> +	primary_sd = mlx5_get_sd(primary);
>  	mlx5_sd_for_each_secondary(i, primary, pos)
>  		sd_cmd_unset_secondary(pos);
>  	sd_cmd_unset_primary(primary);
> -	debugfs_remove_recursive(sd->dfs);
> +	debugfs_remove_recursive(primary_sd->dfs);
> +	primary_sd->dfs = NULL;

Can concurrent unbind operations cause a use-after-free and double-free
regression here?

In mlx5_sd_cleanup(), the check !mlx5_devcom_comp_is_ready(sd->devcom) is
performed locklessly. If multiple physical functions in the Socket-Direct
group are unbound concurrently, multiple threads can observe ready == true
and enter this teardown block simultaneously.

Since the cleanup code now operates on the shared primary_sd pointer instead
of the local device's sd, the thread for the primary physical function might
complete its unbind and execute sd_cleanup(dev), freeing its sd object
(which is primary_sd).

Concurrently, the thread for a secondary physical function will dereference
the freed primary_sd to access primary_sd->dfs, causing a use-after-free.
Both threads could also pass the same pointer to debugfs_remove_recursive(),
resulting in a double-free.

Note: This was fixed later in the patch series by commit 92528cec4e0b91deb
("net/mlx5: SD: Serialize init/cleanup").
-- 
pw-bot: cr

