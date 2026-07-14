Return-Path: <linux-rdma+bounces-23220-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nXTDLvdzVmpt5wAAu9opvQ
	(envelope-from <linux-rdma+bounces-23220-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 19:37:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BCC75786C
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 19:37:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TwMF7Ci3;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23220-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23220-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B55C32039D8
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 17:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3399384CFE;
	Tue, 14 Jul 2026 17:32:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8347330675F;
	Tue, 14 Jul 2026 17:32:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050330; cv=none; b=N4PVFJOYZkLerEAbWQQ8awoGNIIN5WjPjrM+cdKCYNJfZWowf7hc7mBf0BejlCcvxYgZytpuN006FnIL3NFUYBOC/tyD/huIyEbt2nwXMaAL3yNxjNh+FfE8rGmomgC97kR3KJKW5IAJELVoLLZQ+0E1LIaSDJb2uoKpT0rY7Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050330; c=relaxed/simple;
	bh=CmvrkjVaGQ6MN//Cd8aKji1ytmpktL5xVzNiSdfE/nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7QL+Gm5QZ3Se9n6EzIRKogkoOFqXcRUWEmcy+JaiioI1x1GJnXvc0CJifV/gRl3YogXWyMn4wPU7dqFi5n7855+stnqqrz2/aim701jf0ByZ1thOMtccdGgxt88/JcTpXjoK9kuey3xIT8zSyiItfxmcQmgBqX8c5bwczQoXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwMF7Ci3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9751F000E9;
	Tue, 14 Jul 2026 17:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784050329;
	bh=hChZb/2vVYNOySAV5fErj2Dtv3qUxLzms3YMHDC+iJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TwMF7Ci3I1oEymvv8ZbZKczzhf5SXnPIhnvI/khf841KbVsKM2h6/AZ5B1c4RZX1o
	 Ya+Vavn5/UZOM1QUd1M4m8zDFW6owFb26wGChXoIzlf5nnY7Y6clmJjHtgpz2R1Gtf
	 q16jwigAxeuDQlNpUsh4WtcqnP4h4alz5kaxKw8TWlPASY8kHAZlvCqix6zfedZaRS
	 vhzl/4uOWo4DHFhLK0pjAvO6VJpLTHUHZopU3ky4Hx3xsNHgm2/nqXCNo54c0UlWK7
	 pA7uHREgU7pSQT2mIydWNmc1M+mJkkusnz6RYr+xuqwR1Uwe6znR26X73yHbFroKIU
	 /dcGadmEcBD/Q==
From: Simon Horman <horms@kernel.org>
To: tariqt@nvidia.com
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	aleksandr.loktionov@intel.com,
	borisp@nvidia.com,
	cmi@nvidia.com,
	cratiu@nvidia.com,
	daniel.zahka@gmail.com,
	dtatulea@nvidia.com,
	gal@nvidia.com,
	jacob.e.keller@intel.com,
	jianbol@nvidia.com,
	lkayal@nvidia.com,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	mbloch@nvidia.com,
	raeds@nvidia.com,
	rrameshbabu@nvidia.com,
	saeedm@nvidia.com,
	sdf@fomichev.me,
	sdf.kernel@gmail.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 15/15] net/mlx5e: psp: Report PSP dev registration errors
Date: Tue, 14 Jul 2026 18:31:52 +0100
Message-ID: <20260714173151.1863310-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707130858.969928-16-tariqt@nvidia.com>
References: <20260707130858.969928-16-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23220-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:aleksandr.loktionov@intel.com,m:borisp@nvidia.com,m:cmi@nvidia.com,m:cratiu@nvidia.com,m:daniel.zahka@gmail.com,m:dtatulea@nvidia.com,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:jianbol@nvidia.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:raeds@nvidia.com,m:rrameshbabu@nvidia.com,m:saeedm@nvidia.com,m:sdf@fomichev.me,m:sdf.kernel@gmail.com,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,vger.kernel.org,redhat.com,intel.com,nvidia.com,gmail.com,fomichev.me];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44BCC75786C

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
--- Patch [15]: [PATCH net-next 15/15] net/mlx5e: psp: Report PSP dev registration errors ---
commit 76afe7de4d1e708e7c01d267ef1fb9cf946de937
Author: Cosmin Ratiu <cratiu@nvidia.com>

net/mlx5e: psp: Report PSP dev registration errors

This commit updates mlx5e_psp_register() to return an error code instead
of void when psp_dev_create() fails. The caller, mlx5e_nic_enable(), is
also updated to check this return value and abort if PSP registration fails.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -6199,7 +6199,9 @@ static int mlx5e_nic_enable(struct mlx5e_priv *priv)
>  
>  	mlx5e_fs_init_l2_addr(priv->fs, netdev);
>  	mlx5e_ipsec_init(priv);
> -	mlx5e_psp_register(priv);
> +	err = mlx5e_psp_register(priv);
> +	if (err)
> +		goto out_ipsec_cleanup;

[Severity: High]
Could propagating this error cause the entire network interface to fail if
the optional PSP offload fails to register?

If psp_dev_create() fails (e.g., due to memory pressure or ID exhaustion
in xa_alloc_cyclic), mlx5e_nic_enable() will now abort, resulting in a
complete loss of networking capability for the device.

Notice how the code immediately following this handles MACsec initialization
failures by logging the error and allowing the NIC to continue operating:

	err = mlx5e_macsec_init(priv);
	if (err)
		mlx5_core_err(mdev, "MACsec initialization failed, %d\n", err);

Should PSP registration failure fall back gracefully and allow the core NIC
to function without the offload, similar to how MACsec is handled?

>  
>  	err = mlx5e_macsec_init(priv);
>  	if (err)
>  		mlx5_core_err(mdev, "MACsec initialization failed, %d\n", err);

