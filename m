Return-Path: <linux-rdma+bounces-18934-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFW0LSnfzWlVigYAu9opvQ
	(envelope-from <linux-rdma+bounces-18934-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 05:14:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F7138303B
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 05:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69394300D97D
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 03:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A02934250E;
	Thu,  2 Apr 2026 03:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RN3ejrT2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0B62BEC23;
	Thu,  2 Apr 2026 03:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775099324; cv=none; b=qIVq+hce0SlbJWJ0lz3rWcg8MEl+S327cZEGAnjPpMWuWKhIONwfEOmTcem6D0N067m9GDBG5nXI/jSmmjN5F1krBaRSgipA7oXPBpFImZTed9aauFs5QN6TI9LVriy19pi1ImlL14KqJrgBx0lTqxCPNebBuPTG/OUk1IkX018=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775099324; c=relaxed/simple;
	bh=9WcfmINy8tur5KnVTbq1a7pXjZq5fNEd5bvED0yc7JA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jF+hXnv/cTSyYOcF1SkayVEVHmpRu2xUy9I0FgioE5f9CPqTP8Hrg8eblBLohBx6oQiY2p/0MvkIzWER+gCKKAQUL+Bge+HYccPZX8KBqwgOP4CG1TrqTA9ulsqCcsHRMxIY0Pxv7vGilfQEH/ojZaM9bcNTf5FIeH0/AdHXC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RN3ejrT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443C6C19421;
	Thu,  2 Apr 2026 03:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775099324;
	bh=9WcfmINy8tur5KnVTbq1a7pXjZq5fNEd5bvED0yc7JA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RN3ejrT2w6RAnfT4sPeyNVCFLdmODJ3O5bfwMwMeRvu03kv3t1rqlamHOLDPn1iab
	 BOqX9x1bjBGIRWAF7/A7JkJMOaNbfm1Cj9J9UxKL2ZXJMw5sGtU6mqD5gYFOLvMmKc
	 lIKvU8SGkW2ZrtI1+L6DCfTDjHKTN3ET/w2A1UOqIIbB5+UOCIf7AJHXk5bfNyW8Us
	 NhFVEPnnrbNCjRFHNO5M6cgw8AxKg3cpUT6QL2SSj3LUokhFyeGuAhqH6Y0KndMS7j
	 j3gtdBI20V6LX4tQNGjM1G7xYZN7PM1OxXGq9OwbFwsGvRdxIe0tT1CEqi1JbZBv8P
	 kIWSM9LN/VMgA==
Date: Wed, 1 Apr 2026 20:08:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, "Mark Bloch"
 <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay Drory
 <shayd@nvidia.com>, Simon Horman <horms@kernel.org>, Kees Cook
 <kees@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/3] net/mlx5e: SD, Fix race condition in secondary
 device probe/remove
Message-ID: <20260401200842.79322a24@kernel.org>
In-Reply-To: <20260330193412.53408-2-tariqt@nvidia.com>
References: <20260330193412.53408-1-tariqt@nvidia.com>
	<20260330193412.53408-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-18934-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 54F7138303B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 22:34:10 +0300 Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> When utilizing Socket-Direct single netdev functionality the driver
> resolves the actual auxiliary device using mlx5_sd_get_adev(). However,
> the current implementation returns the primary ETH auxiliary device
> without holding the device lock, leading to a potential race condition
> where the ETH device could be unbound or removed concurrently during
> probe, suspend, resume, or remove operations.[1]
> 
> Fix this by introducing mlx5_sd_put_adev() and updating
> mlx5_sd_get_adev() so that secondaries devices would acquire the device
> lock of the returned auxiliary device. After the lock is acquired, a
> second devcom check is needed[2].
> In addition, update The callers to pair the get operation with the new
> put operation, ensuring the lock is held while the auxiliary device is
> being operated on and released afterwards.

Please explain why the "primary" designation is reliable, and therefore
we can be sure there will be no ABBA deadlock here

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index b6c12460b54a..5761f655f488 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -6657,8 +6657,11 @@ static int mlx5e_resume(struct auxiliary_device *adev)
>  		return err;
>  
>  	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
> -	if (actual_adev)
> -		return _mlx5e_resume(actual_adev);
> +	if (actual_adev) {
> +		err = _mlx5e_resume(actual_adev);
> +		mlx5_sd_put_adev(actual_adev, adev);
> +		return err;
> +	}
>  	return 0;

Feels like I recently complained about similar code y'all were trying
to add. Magically and conditionally locking something in a get helper
makes for extremely confusing code.
-- 
pw-bot: cr

