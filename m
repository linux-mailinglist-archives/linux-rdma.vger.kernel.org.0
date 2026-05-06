Return-Path: <linux-rdma+bounces-20040-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JhnEU2j+mlWQwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20040-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 04:11:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E324D5928
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 04:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6789B30252BF
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 02:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129E72798F3;
	Wed,  6 May 2026 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6qS92lI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C953B20CCDC;
	Wed,  6 May 2026 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778033477; cv=none; b=Gu36vWDu2v3g4jDhQ5jj2H5T6VxLQDJB8LU/5PMBfS1HBS9lhOFJLbFYhh1vDf45v3W8fh+dBAqILN9Lg2Nld0k6zCoJsyn65YPlZEh5D3qD1rTbpV9P6ldfXbWomm1uS2s1ri4+kj5z24b2ErOz3RFlnr6wdB1G+M1KPoT+gYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778033477; c=relaxed/simple;
	bh=v38LRJ5FG2ZWMI2XIHMxBRq41wm9psTSRRBminyfssY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvUr9Amm4yOOxggxakQkhr7xf6/87yLV/i+GYrTBkUCw1FkUisyGv3zIboS/ziXjEKj+8AAPG9oBp82BDltn0tNADmi+zZSnlsu96bIYSMzRNzPlBjmCeNnNckq7ylRuM2fn8riCrMcQsVhENAVw5/U7s50XcYqS7nARpRgqm8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6qS92lI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82BEC2BCB4;
	Wed,  6 May 2026 02:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778033477;
	bh=v38LRJ5FG2ZWMI2XIHMxBRq41wm9psTSRRBminyfssY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a6qS92lIqNKZgGdmegh/GtZd90exlAahSBh3qeISQiYHUKbOc8sg+XStEtFgXFVQC
	 GY929xdHxje7cNqU0X7yCl5PlL1k4vCO09q+Vb6gZvBQso3G0Om1dyEjCWU73zLr49
	 Ea+ze5jclTTgsheEO6flycdxmHZ8Q9tTEA5vkDkGvgE9xHZk+KkRItrBYnXi5WztDa
	 iIrYz8ACsmtVHzCxUb3IGacmFHkPwkQ69DycmoWKlvcnzFmEJEt90Zt3SlSHynbPw0
	 T858XsJTl4ieIwK2S0iEx8iKI1W8NkUGmOFW62L2zZZesbgjO/jrCtegXChiTcrlLA
	 hATsx14unw4oA==
Date: Tue, 5 May 2026 19:11:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Boris Pismenny <borisp@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Mark Bloch"
 <mbloch@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu
 <rrameshbabu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Kees Cook
 <kees@kernel.org>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net V3 1/3] net/mlx5e: psp: Fix invalid access on PSP
 dev registration fail
Message-ID: <20260505191115.3504d797@kernel.org>
In-Reply-To: <20260504181100.269334-2-tariqt@nvidia.com>
References: <20260504181100.269334-1-tariqt@nvidia.com>
	<20260504181100.269334-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 92E324D5928
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20040-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,redhat.com,lunn.ch,davemloft.net,nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 4 May 2026 21:10:58 +0300 Tariq Toukan wrote:
> -	if (!priv->psp || !priv->psp->psp)
> +	struct mlx5e_psp *psp = priv->psp;
> +
> +	if (!psp || !psp->psp)
>  		return;
>  
> -	psp_dev_unregister(priv->psp->psp);
> +	psp_dev_unregister(psp->psp);
> +	psp->psp = NULL;

TBH the pointless churn to add a local variable here was what I was
referring to when talking about unnecessary refactoring. One line 
change to clear the pointer and you're turning it to a full rewrite
of the helper.

Whatever. Some things can't be taught I guess :\

