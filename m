Return-Path: <linux-rdma+bounces-17209-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEafEc4KoGnbfQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17209-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 09:56:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 884AF1A2FE3
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 09:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1D3D30401AD
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 08:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AC038B7B3;
	Thu, 26 Feb 2026 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIASu9t3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BEB36C0D5
	for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096121; cv=none; b=Cpn4bpP5IxpAAIWA3h0c3W0n743bg6KZIUngwF1JMSoy9hYXL48cabEJYaCGAfOsU7RT4ILFwONqP8py51QLOMIfEv4lutiE3R/QP32RN17EgsMtDDXCuGggxtOe0ryyPCwaSYK94DhCVr7GrMF/ng3SU+7gcje46dYYk+dszB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096121; c=relaxed/simple;
	bh=qPHFYSiu6HBDWeQSH00/S6/xNl3AcetW8wQwJ/Pzo3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRswkNzmAC1CbCmc4ijeMpAoskvDodWEQo9BSCyfsUF7ZSxV0JsBmESYWe3vw9qQj6fRom++Ziz9NOpQgd/2AjpqIttJqUH8dgjnuAmnMOTrRVrPuHTeaYMu+KzNXE5+99LOyUIl+hGnN/avE40B5u/8ahkI/8oyVdG3i4nJF6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIASu9t3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED33C19422;
	Thu, 26 Feb 2026 08:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772096121;
	bh=qPHFYSiu6HBDWeQSH00/S6/xNl3AcetW8wQwJ/Pzo3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qIASu9t3Y7zleRgDd2xUP2dQUfeL1ZEYhGCUy4GdlEphKUURNGsx25xzHWSacCynY
	 yWbQR4G9612OTIBfDQgwsFVRna2/yf41JRwJWKy1ZfHdhXUWw8Rxpc0Bv+SqKy3XBn
	 O7lcs4O17Vf6c6oZ1UN7Gw00c+SxsEc1u7/1pUU2rqoLrNJGFnKskmFJJcCt+vuP5t
	 eq2jFYlqzQ+aq5BXQAdo4f5msR44cSNqojZhs88JkfrhYYyvZ4yq1WKDnlZmNYcmh9
	 r9IoCTo3TRKu3FrsHRlPCb7+xfYWhitOV0vf19mwVpV69VCttMBgVOxHKi/oTn9ubu
	 MpFl7jUX0eQGQ==
Date: Thu, 26 Feb 2026 10:55:17 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jacob Moroni <jmoroni@google.com>
Cc: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 4/4] RDMA/irdma: Add support for revocable
 pinned dmabuf import
Message-ID: <20260226085517.GG12611@unreal>
References: <20260225210705.373126-1-jmoroni@google.com>
 <20260225210705.373126-5-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225210705.373126-5-jmoroni@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17209-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 884AF1A2FE3
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 09:07:05PM +0000, Jacob Moroni wrote:
> Use the new API to support importing pinned dmabufs from exporters
> that require revocation, such as VFIO. The revoke semantic is
> achieved by issuing a HW invalidation command but not freeing
> the key. This prevents further accesses to the region (they will
> result in an invalid key AE), but also keeps the key reserved
> until the region is actually deregistered (i.e., ibv_dereg_mr)
> so that a new MR registration cannot acquire the same key.
> 
> Tested with lockdep+kasan and a memfd backed dmabuf.
> 
> Signed-off-by: Jacob Moroni <jmoroni@google.com>
> ---
>  drivers/infiniband/hw/irdma/main.h  |  1 +
>  drivers/infiniband/hw/irdma/verbs.c | 71 ++++++++++++++++++++++++++++-
>  2 files changed, 71 insertions(+), 1 deletion(-)

<...>

>   * irdma_dereg_mr - deregister mr
>   * @ib_mr: mr ptr for dereg
> @@ -3911,6 +3977,9 @@ static int irdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
>  	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
>  	int ret;
>  
> +	if (iwmr->region && iwmr->region->is_dmabuf)
> +		return irdma_dereg_mr_dmabuf(iwdev, iwmr);

I wonder if you really need to leak umem properties and can't use
existing irdma_dereg_mr(). ib_umem_release() handles both regular and dmabuf correctly.

Thanks

> +
>  	if (iwmr->type != IRDMA_MEMREG_TYPE_MEM) {
>  		if (iwmr->region) {
>  			struct irdma_ucontext *ucontext;
> -- 
> 2.53.0.414.gf7e9f6c205-goog
> 

