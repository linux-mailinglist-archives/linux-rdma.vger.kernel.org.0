Return-Path: <linux-rdma+bounces-19559-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOVVGjkI7mm5qAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19559-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 14:42:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D684D469D12
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 14:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F37430082A7
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 12:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF60635E95F;
	Sun, 26 Apr 2026 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz5b0pgR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E6735DA76
	for <linux-rdma@vger.kernel.org>; Sun, 26 Apr 2026 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777207348; cv=none; b=YI68vdua4TI+ws0W80dEkb8ubjFpmB698AWA4eG0MhDiqXIUr3RiCWTbB6Sp4QWiNJngMGKMqZH5SM1KIpLKdQ6LEfdNmaOeBCo9+i7vIPvtege0qAdlFIB8fMWHbsi8QC5VNPCxV0Zmn7vr7JNcWAR7TvPyMJZpU+GczCe/k6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777207348; c=relaxed/simple;
	bh=UvmKBqelyEVaxIAHmw++JwjiwjeMxk4kVxhXnXaRsHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bo5TVudhJiOahu0Ehu8LllGhZDHPcfGcGwfnp5ln7G03egjguBqP8o0sunPKym+G5fX+h7XtAE6WHAXyoUXy5OURUy2zZdFaUiNEKcnq6OOPv8VcpW09lPpAxMaof+IW1jePAPB6N2xS+oARD45Gq1JPTSTEpB341urG5MqgM4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bz5b0pgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0022C2BCAF;
	Sun, 26 Apr 2026 12:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777207348;
	bh=UvmKBqelyEVaxIAHmw++JwjiwjeMxk4kVxhXnXaRsHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bz5b0pgRg+O5zUKB5HUtNqBELyIY3Md/v22zrd+seo1vKA7j6mKKrvRCgh9Zc/10I
	 SYf3+r9SWXvqL3LLO51Mujy+39T1iaW9/RHxvlOiONO1YUJwKJvUcLsEDuNbD/XQt7
	 SeL3L4tSJYp80pCR2jfBOVTxDMuypELnYawAz8nI/Qy3lIsOBKZM3mmMLXFjaLQCzc
	 +2pfQzLfqSSt5YjHsA4fu74JqqoTTTdC+DR9p+JEPQrtT5kW6FX+YxNjiA5ftNyohW
	 7AOjxvXSHNYdvFe09zeKtB0JxeNdmPDcmfBmPJoRV1Nt9vno5zl32aFPsZEwH2w4r5
	 rHdaohCSqJmlw==
Date: Sun, 26 Apr 2026 15:42:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tao Cui <cuitao@kylinos.cn>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/2] RDMA/nldev: add resource summary max values for
 usage rate display
Message-ID: <20260426124223.GF440345@unreal>
References: <20260423061352.359749-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260423061352.359749-1-cuitao@kylinos.cn>
X-Rspamd-Queue-Id: D684D469D12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19559-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email]

On Thu, Apr 23, 2026 at 02:13:51PM +0800, Tao Cui wrote:
> Add RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX netlink attribute to expose
> device resource limits (max_qp, max_cq, max_mr, max_pd, max_srq) in
> the resource summary alongside the existing current count. This allows
> userspace tools like iproute2's rdma to display resource usage rates.

Historically, we try to avoid duplicating functionality, and this already
exists in ibv_devinfo. What is the reason for adding it to rdmatool as well?

> 
> The new attribute is optional and backward compatible - old userspace
> tools will simply ignore it.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  drivers/infiniband/core/nldev.c  | 29 ++++++++++++++++++++++++++---
>  include/uapi/rdma/rdma_netlink.h |  5 +++++
>  2 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index 96c745d5bac4..879aaa7960fe 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -187,6 +187,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
>  	[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD] = { .type = NLA_U32 },
>  	[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES] = { .type = NLA_U32 },
>  	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY] = { .type = NLA_U64 },
> +	[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX]	= { .type = NLA_U64 },
>  };
>  
>  static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
> @@ -412,7 +413,7 @@ static int fill_port_info(struct sk_buff *msg,
>  }
>  
>  static int fill_res_info_entry(struct sk_buff *msg,
> -			       const char *name, u64 curr)
> +			       const char *name, u64 curr, u64 max)
>  {
>  	struct nlattr *entry_attr;
>  
> @@ -426,6 +427,9 @@ static int fill_res_info_entry(struct sk_buff *msg,
>  	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR, curr,
>  			      RDMA_NLDEV_ATTR_PAD))
>  		goto err;
> +	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX, max,
> +			      RDMA_NLDEV_ATTR_PAD))
> +		goto err;

From an implementation perspective, this is not an appropriate place to
store this information. It will result in reporting the same value
(max_XXX is per‑device) across multiple objects.

Thanks

