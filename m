Return-Path: <linux-rdma+bounces-18373-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAibMoNeu2knjQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18373-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 03:25:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C85E2C4EBA
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 03:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2098530387F3
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 02:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA673859D0;
	Thu, 19 Mar 2026 02:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ky/0WQPw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAD41CEADB;
	Thu, 19 Mar 2026 02:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773886993; cv=none; b=WYQ6BLTs0AajY+H9CDY/T4xL5Etj8jLWruOfeoRyMTv78ColtkTWajYs00ASljstr9FepkvSngfKD3uCs11Fcx/cyuTdxWvD4LUSd3/a+FiiejIvSzhSHNX6f1yEDpNZPvZPP7VPUWWc7Wh0vBbi6gYYzzAATVpxyreFZPwwmXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773886993; c=relaxed/simple;
	bh=J7ByNCVdyp6p7hoc/up7uJ/7AQHt9/rYYPRSEUuXvFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PasfZbSWrNAzGAXmZiBJHificcl1CODwNPLV/A1U+CCo9a4DkNjzFGlGKImTIXX9+i523I5FdPjVc7taiU1gjhk1v2JDMxpobXs3CGx3ZIbG6BNytpK3H1c3cgwbDN4IkmT42DDBpvmOpeA4D69ofFRHDy2f+31oy5iJCXEA3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ky/0WQPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC7CC19421;
	Thu, 19 Mar 2026 02:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773886993;
	bh=J7ByNCVdyp6p7hoc/up7uJ/7AQHt9/rYYPRSEUuXvFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ky/0WQPwpA4SLaViKimzr8eyaNp8qcqLIU/3vO6L33zkCni8dDi8dUgEmDzbjMznt
	 5tv8LUp628AnXd0auPLh9IO/4AjKHxLHCK7p9ijFRssRTJWplsBo4AC7QVeDUl8mcH
	 zAk/K1qJfwdyqI1JBmVYQFDs5d2WMUKWTT4MvslRnIJeHwGsbkeL40jPDaV4KxugO5
	 Uatgxxh+FbSiSvGA5riKjysAiv0dtPMt6hqmQYg9PqEsmxGYcR+7hqEWmaGLH7tV49
	 Zii8AhQlKySl7hTTWz0MbMGdwGc6KoBT8HSfyEK686CzQR+EBVSmsr6ju0EVGByG//
	 kPo0beRhLeObg==
Date: Wed, 18 Mar 2026 19:23:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Gal Pressman <gal@nvidia.com>, Willem de
 Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/4] ethtool: Track user-provided RSS
 indirection table size
Message-ID: <20260318192310.278ef325@kernel.org>
In-Reply-To: <20260318122603.264550-2-bjorn@kernel.org>
References: <20260318122603.264550-1-bjorn@kernel.org>
	<20260318122603.264550-2-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18373-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8C85E2C4EBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 13:25:58 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index e252cf20c22f..ee91f1155830 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -1204,6 +1204,26 @@ void ethtool_rxfh_context_lost(struct net_device *=
dev, u32 context_id)
>  }
>  EXPORT_SYMBOL(ethtool_rxfh_context_lost);
> =20
> +bool netif_is_rxfh_configured(const struct net_device *dev)
> +{
> +	return dev->ethtool->rss_indir_user_size;
> +}
> +EXPORT_SYMBOL(netif_is_rxfh_configured);
> +
> +/**
> + * ethtool_rxfh_indir_clear - Clear user indirection table config
> + * @dev: network device
> + *
> + * Mark the default RSS context indirection table as unconfigured and
> + * send an %ETHTOOL_MSG_RSS_NTF notification.

If you're adding kdoc you should very clearly state this is function
should only be called if the driver lost the ability to maintain the
indirection table, usually after HW fault recovery reduced the max
queue count.

> + */
> +void ethtool_rxfh_indir_clear(struct net_device *dev)

ethtool_rxfh_indir_lost() would be a better name, it would align with=20
ethtool_rxfh_context_lost() right above the code you're adding, right?

> +{

Let's add an error in here like the one we have in
ethtool_rxfh_context_lost(), this should stop arbitrary use.
And you can remove the local warning in bnxt if we do that.

> +	dev->ethtool->rss_indir_user_size =3D 0;
> +	ethtool_rss_notify(dev, ETHTOOL_MSG_RSS_NTF, 0);
> +}
> +EXPORT_SYMBOL(ethtool_rxfh_indir_clear);
> +
>  enum ethtool_link_medium ethtool_str_to_medium(const char *str)
>  {
>  	int i;

