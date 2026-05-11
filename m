Return-Path: <linux-rdma+bounces-20408-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFgFA20dAmocoAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20408-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 20:18:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E18514370
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 20:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58E6F3023DBC
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 18:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D227E47B408;
	Mon, 11 May 2026 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnruIBOF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940DE43E9CD;
	Mon, 11 May 2026 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523476; cv=none; b=sy/QmXOSC6ue131nVdhNj/ut5b9BdGA3g0GMUtFxWYcMM9rwaSs19r4KJeXKLYrhCeg4RB1JXZksn/FF405ZXf+6WfTKr8eVWn8UwImP2pElScBoaBkLIglVao9xBv55Uju8iEhziaN+go2H3RlWx2EuxfU5iwjFKloSCJ3Nubk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523476; c=relaxed/simple;
	bh=16jjIJmtNDT5VX//klLOhtyKWakaV6eMATl9wc+2FUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2NGSSkssfIjP2UjoRJQpymkHmUL1wmDhyPgxjYeuQuMZWrbV6WrRTgrs2eoNql4JeNtjZ7/zJf6J6N7skN9SZWi7DxA6hTPatcWPgJnSyU8L2T1DdVT644QXvVM7KSv19GDmcZ+irgvWvMWlyaJYFTeTzET3oI14Uz+KnyY7+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnruIBOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC66C2BCB0;
	Mon, 11 May 2026 18:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778523476;
	bh=16jjIJmtNDT5VX//klLOhtyKWakaV6eMATl9wc+2FUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QnruIBOFI+Ef8n7//NItCLJevMLKoMfdiXDM75Xp+3Wga+7hAzbOP2an4SBNNbqoV
	 nCJpzbSahUfzYigk/DCjtfPl6DdhYqGF2Vb13c8MpRuKvLzC/j7o204Vo7mheQrtv0
	 tg8YAdkkhS2Rj6N+mDSionqGu+jibF3DEdZTaZtdUGJWO2E5WVzPvmekfV/npWcAjn
	 nIPRsuDfAESycEnap7rRdCkrdk/R6GbfzMYxJye75v4ZBjgJHri7zU4QXO/wBcwlhJ
	 N3AG+ERpKWwtTpdXzUcd8Uz+SvkGV5EHBxRv75wfHq/YOU4df05Z/U1b2SmIFnSjdq
	 5K2VZhuxEW5Ow==
Date: Mon, 11 May 2026 21:17:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Shirin Kaul <shirin.kaul11@gmail.com>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: hw : use clamp() in _mlx5r_umr_zap_mkey()
Message-ID: <20260511181750.GN15586@unreal>
References: <20260503120457.49220-1-shirin.kaul11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503120457.49220-1-shirin.kaul11@gmail.com>
X-Rspamd-Queue-Id: 72E18514370
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
	TAGGED_FROM(0.00)[bounces-20408-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, May 03, 2026 at 12:04:57PM +0000, Shirin Kaul wrote:
> Use clamp() instead of min(max()) to make the code easier to
> understand.
> 
> Signed-off-by: Shirin Kaul <shirin.kaul11@gmail.com>
> ---
>  drivers/infiniband/hw/mlx5/umr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

We already discussed it there
https://lore.kernel.org/linux-rdma/20260310145727.236094-3-thorsten.blum@linux.dev/

Thanks

> 
> diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
> index 29488fba21a0..92b76ee65779 100644
> --- a/drivers/infiniband/hw/mlx5/umr.c
> +++ b/drivers/infiniband/hw/mlx5/umr.c
> @@ -1014,7 +1014,7 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
>  		 MLX5_IB_UPD_XLT_ATOMIC;
>  	max_log_size = get_max_log_entity_size_cap(dev, access_mode);
>  	max_page_shift = order_base_2(mr->ibmr.length);
> -	max_page_shift = min(max(max_page_shift, page_shift), max_log_size);
> +	max_page_shift = clamp(max_page_shift, page_shift, max_log_size);
>  	/* Count blocks in units of max_page_shift, we will zap exactly this
>  	 * many to make the whole MR non-present.
>  	 * Block size must be aligned to MLX5_UMR_FLEX_ALIGNMENT since it may
> -- 
> 2.43.0
> 

