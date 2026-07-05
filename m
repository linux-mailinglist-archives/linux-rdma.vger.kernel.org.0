Return-Path: <linux-rdma+bounces-22783-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 84Q+FPxnSmo1CgEAu9opvQ
	(envelope-from <linux-rdma+bounces-22783-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:19:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C201370A47D
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 16:19:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cptocLBo;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22783-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22783-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73E87300EF83
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 14:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12813384245;
	Sun,  5 Jul 2026 14:19:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD261382370;
	Sun,  5 Jul 2026 14:19:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783261168; cv=none; b=cUbgdI2DtKgIGZIJIyay/BPD7l6NBUInDchuoRNVnMowlN3Exk/EK1tAUAnmCAJzeLlMaOT64/PHgLpa5x1OyzKn+O2nLDghajoMsEnfLuNbH+nZzeoAU3lYgbBoeExSBwstKMAcuG8fmAqy/9TogJLBKzFRnM8f5dYknX48kcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783261168; c=relaxed/simple;
	bh=jcPJen87JmcP/j7nnSpXSY1c7GTdyigGtyopvSguuN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9qoDtCQ/0N6W8zwkB0xfY+zTSf6XXvnlS+TUnTyXCxbHs7K3H3dJ5IA84Vwaemre6dxZR4bhJatugOVZhXahAbvGGo43697yLg7KxZNzWhJ4T8mp++Q1qZxr8MeCLUhcfO4qfsrsEgCGIyoH+328exeIecq4jSDdXs3lpdgDJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cptocLBo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857331F000E9;
	Sun,  5 Jul 2026 14:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783261167;
	bh=9DrplwkjJBjGxh1cD2R/mrFbb4Rpl+IeLJikyWbz1n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cptocLBoWZfJf1xHYKJoahvZWPj09dm3x9FLqDXE3okKXJfVcomzfi4Mb8GMT+0rZ
	 eC8ShOS3TECSZQc2yeSvxIEUCQ5/Zg5n/l7A0PMRmE8g1Vo7VoAP9XD6iAtKVJytPB
	 Komnun2kImCh88/6eIfp0I75KS/xzkxKHxwBdPpmUdVJrlLjLFA69N581eiP4QaghD
	 Xy/9b8exL1sLmFALl9CqOmja/fTBqR/qPJGUxscaZ+pLoFyNa+IwwlovyQij64QD/W
	 4ldZcyf90JsGEkKU6wSciZH4/WrDFUzGNRr7unp3oVr5ByekNOa5NGCtv4djSbgYx+
	 r7rUEhGxftVZQ==
Date: Sun, 5 Jul 2026 17:19:20 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	michaelgur@nvidia.com, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net/mlx5: free mlx5_st_idx_data on final dealloc
Message-ID: <20260705141920.GI15188@unreal>
References: <20260630165324.2859353-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630165324.2859353-1-zhipingz@meta.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelgur@nvidia.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22783-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,vger.kernel.org:from_smtp,nvidia.com:email,unreal:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C201370A47D

On Tue, Jun 30, 2026 at 09:53:20AM -0700, Zhiping Zhang wrote:
> Workloads that repeatedly allocate and release mkeys carrying TPH
> steering-tag hints (e.g. churning RDMA MRs) leak one
> struct mlx5_st_idx_data per cycle; kmemleak flags it as unreferenced
> and the kmalloc slab grows over time.
> 
> When the last reference to an ST table entry is dropped,
> mlx5_st_dealloc_index() removed the entry from idx_xa but the backing
> mlx5_st_idx_data allocation was never freed.
> 
> Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> struct matches the lifetime of the ST entry it tracks.
> 
> Cc: stable@vger.kernel.org
> Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> Reviewed-by: Michael Gur <michaelgur@nvidia.com>
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
> v2: respin per maintainer-netdev.rst; no code change.
> v1: https://lore.kernel.org/linux-rdma/20260612170406.3339093-1-zhipingz@meta.com/
> 
>  drivers/net/ethernet/mellanox/mlx5/core/lib/st.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

