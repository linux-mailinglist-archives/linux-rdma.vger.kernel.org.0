Return-Path: <linux-rdma+bounces-17896-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ9WKjxosGloigIAu9opvQ
	(envelope-from <linux-rdma+bounces-17896-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 19:51:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D3D256B09
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 19:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FD7830B1728
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 18:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB9519C566;
	Tue, 10 Mar 2026 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaKPRkds"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303812E7162;
	Tue, 10 Mar 2026 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168468; cv=none; b=SBfpRqF2L91SryEtHN1A+itjOlnpdLzeYPSUHZqyq8LvCTGe4ypcFjd5V9BR7YvM4eAV3ZAgpHZQ5yIQwElBbmuBi6ccaCOVDCWKSXBPrDYfcyv0AXRLgJei0sMoYZFFhkuBpE70gI1WF9pe3FbJIanZkZARFSuuXRpqbJnkHvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168468; c=relaxed/simple;
	bh=OjnQ6y4jhuFFWP63IHFQajUUM398SbQ6fZuTkTN5nQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0hCpwGqe36UHKujB/EVziT/ykMZ8HTy8s89yBGE47hZcak81Hni0PHyPqfqyXHCtcBQ7NF7Ng5OJqvAMww8gtaxajm17111fZHJY2r89XEK6//uLvS0ZK9pztf+N8/LwGKdKyQpCGDIHSIKNitYWHhFCZbPRUhZbhW3tAcZK/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaKPRkds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E6DC19423;
	Tue, 10 Mar 2026 18:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773168467;
	bh=OjnQ6y4jhuFFWP63IHFQajUUM398SbQ6fZuTkTN5nQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kaKPRkdss2wqjwnZ6y/O+bDPscKo5uuw13q74cddIqm5MBTqt8yv1xO3mwAoRO9dU
	 AvwP6OCzxcYLvzk9ItzjgXgKFA1ICh1QPmD1mgudMYV0OYNq0MvmeLh4YLUoxofv+5
	 Da+Bz13zxNZTTa7kM+9Nb1JRJCI83bPi6Nfukrugevol6SsvpJjnHNF7chMtU2Jw6o
	 Ve1ricOTWf5Xba+W7ZjS2T6WlGZFCrD1fHV0ncuZHcHqzuiCUjyrP4DsnL7QKHZ2uz
	 18obJG/J49d8bsNzvunQvB1pjS11R4AM+CXB8/aKijtKoqSpboQdUbzApcxAJhqPp1
	 +G+UHbLPzysuA==
Date: Tue, 10 Mar 2026 20:47:44 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Use clamp() in _mlx5r_umr_zap_mkey()
Message-ID: <20260310184744.GI12611@unreal>
References: <20260310145727.236094-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310145727.236094-3-thorsten.blum@linux.dev>
X-Rspamd-Queue-Id: 19D3D256B09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17896-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 03:57:28PM +0100, Thorsten Blum wrote:
> Replace min(max()) with clamp(). No functional change.

Are you certain about that?
For the values to match, page_shift must be guaranteed to remain
less or equal than max_log_size.

Thanks

> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/infiniband/hw/mlx5/umr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
> index 4e562e0dd9e1..1a6b0ac5c24d 100644
> --- a/drivers/infiniband/hw/mlx5/umr.c
> +++ b/drivers/infiniband/hw/mlx5/umr.c
> @@ -1013,7 +1013,7 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
>  		 MLX5_IB_UPD_XLT_ATOMIC;
>  	max_log_size = get_max_log_entity_size_cap(dev, access_mode);
>  	max_page_shift = order_base_2(mr->ibmr.length);
> -	max_page_shift = min(max(max_page_shift, page_shift), max_log_size);
> +	max_page_shift = clamp(max_page_shift, page_shift, max_log_size);
>  	/* Count blocks in units of max_page_shift, we will zap exactly this
>  	 * many to make the whole MR non-present.
>  	 * Block size must be aligned to MLX5_UMR_FLEX_ALIGNMENT since it may

