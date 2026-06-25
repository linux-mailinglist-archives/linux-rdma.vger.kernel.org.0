Return-Path: <linux-rdma+bounces-22461-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ndbWICeOPGpmpQgAu9opvQ
	(envelope-from <linux-rdma+bounces-22461-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 04:10:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 471856C2550
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 04:10:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VVh6sl1Q;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22461-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22461-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8E29302AF43
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 02:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9805F3A9636;
	Thu, 25 Jun 2026 02:10:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5803A838A;
	Thu, 25 Jun 2026 02:10:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782353442; cv=none; b=WyMzA1kb3h6lTCSNMvtylX513rY8LYsigC3T3R2wFEZjVNXenGczeNNiJW3+zuPNxdyZV4OyHh/VpauxEbJlJyRbXklhEYlQcH0ppa5QqJxYse2hQUf0acZYQVHRx1etvtJ+61Fo7cSF1p42AniCugY0qa81jTPmLEgvX0VJcMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782353442; c=relaxed/simple;
	bh=uxAqeyPjQ0tfnxnBVbhZaOPqYgpmeYZ9cUe4DB/rbt0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAwrfZZLAtQDB2cuvE7JKp9dtP5VRJQpJQRoQCZ7zG0X3VDXkRsxnjylEgfs5eRGdSMOTPrusWUvy6NzObeLbcP4w8fYS/j/vZxanfvJLkua6vMWoSGFS9T5g/NByQyAR5rU0nxomNu2kznscc+oCCE4HlQ2fWwRwwIRytYr9Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVh6sl1Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4A11F000E9;
	Thu, 25 Jun 2026 02:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782353441;
	bh=44WIcoDZw9y50a9k0zd/sE64+MgyRy7AHjMamNR0HuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VVh6sl1QaGYaFDNOh04tWgvdFWR2RbJOfmFMZSRtR6feKUeL3APwdhQEoej0Pra6C
	 xwQ/wTKEe8H1O/H5tSOBuu1RqARx7GqD6/R5yFns/B/LNxxwZxKF8Zh+5gvBUaDUPv
	 xJmOu+f+tnOa1mj0U4MCZF3CdD5KG4M53BncDAPKl0XOL7belMvLYvJuZzp0T5Iy+F
	 r/2d87mAeDJAEEdU9fCV9XrOD77EPT7PI/8noe8R3fLqN180grOv7p0iGZ4VJIFzf9
	 P9G+TpQriYlCujsj0OPKLE2of2wVURspmD4xcC7PltG7V5iLNFy1/jlQJR5vBHKCRg
	 3nlnQWI6zr3hQ==
Date: Wed, 24 Jun 2026 19:10:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Lazar
 <alazar@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net 2/3] net/mlx5e: Validate bandwidth for non-ETS
 traffic classes
Message-ID: <20260624191039.4724950c@kernel.org>
In-Reply-To: <20260622112925.624795-3-tariqt@nvidia.com>
References: <20260622112925.624795-1-tariqt@nvidia.com>
	<20260622112925.624795-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22461-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:alazar@nvidia.com,m:cjubran@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:saeedm@nvidia.com,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 471856C2550

On Mon, 22 Jun 2026 14:29:24 +0300 Tariq Toukan wrote:
> From: Alexei Lazar <alazar@nvidia.com>
> 
> The IEEE 802.1Qaz standard defines that bandwidth allocation percentages
> only apply to ETS traffic classes.
> 
> Reject ETS configurations that specify non-zero bandwidth for traffic
> classes.
> 
> Fixes: 08fb1dacdd76 ("net/mlx5e: Support DCBNL IEEE ETS")
> Signed-off-by: Alexei Lazar <alazar@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
> index 762f0a46c120..e4161603cdc0 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
> @@ -324,6 +324,17 @@ static int mlx5e_dbcnl_validate_ets(struct net_device *netdev,
>  		}
>  	}
>  
> +	/* Validate Non ETS BW */
> +	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
> +		if (ets->tc_tsa[i] != IEEE_8021QAZ_TSA_ETS &&
> +		    ets->tc_tx_bw[i]) {
> +			netdev_err(netdev,
> +				   "Failed to validate ETS: tc=%d BW is not 0 for non-ETS TC (tsa=%u, bw=%u)\n",
> +				   i, ets->tc_tsa[i], ets->tc_tx_bw[i]);
> +			return -EINVAL;
> +		}
> +	}

Can we pull this check out into the shared dcbnl handling?
There seems to be zero mlx5 specific logic in this patch,
and the motivation.

>  	/* Validate Bandwidth Sum */
>  	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
>  		if (ets->tc_tsa[i] == IEEE_8021QAZ_TSA_ETS) {


