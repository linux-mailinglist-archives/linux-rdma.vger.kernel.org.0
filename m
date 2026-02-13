Return-Path: <linux-rdma+bounces-16813-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKVLLMD/jmmOGwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16813-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 11:41:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 299761352DB
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 11:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 938523061AC6
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 10:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F178353EC5;
	Fri, 13 Feb 2026 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiEIwczq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445B352C5C;
	Fri, 13 Feb 2026 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770979228; cv=none; b=EIsH3FJMJtxvWsH4yiTRZ5iO5OZt4OjrNg1ntdVNmHuMoGMB3PpbX3k70C5COe2tLLd0DKy8pI4AQoO1d8BSSxvf37qMN9TLLI0UXQyloOIrxBntbpF8WOwgGjfZAuzTcgpDj2XcxB5fV23O8pQHwuhACchj9PsvzaB5y7UDgKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770979228; c=relaxed/simple;
	bh=Cixx3kK46m16Sxr4skPk+gdW3ag7+ixtcEhQ/EJS11I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfDwIfYLqLlqfD0fgM4PZP+ht91L1UBhkWkL0PCwUA1y4QOf1QVUOC6vDJqTRJOAiXMAH1/wHly8A37+vkLzBQBE/cybSj76lZmvnZQnQPvWsSzWfDeGa68MX5HoHhULXgTLLWyur7ZYiBZlGES6nsRD/FkkptWLPUi7Z1hCkFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiEIwczq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EE2C116C6;
	Fri, 13 Feb 2026 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770979228;
	bh=Cixx3kK46m16Sxr4skPk+gdW3ag7+ixtcEhQ/EJS11I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fiEIwczqSB1qQUlnfNjKBC7mlt0NKPb5JG6Vd/hbSS7bTaGhe1XGythcsCWG0g+1H
	 W1bOuJbN2HBKjxw5SD4+C3Z749KWoVwZOTS65xTsPtucZX5XGMbvJV8HJQ5S2TXUiK
	 RoMCot8GQ7ApnpR/byxmvGtatFhFc3AsRav+sbdYJsGvt/ncctBCTefiIlgLfjlkYz
	 KB3t49TyMvzgnlIhKnom/Nf/dAfds3a/RQtfXqJJI5UapyAazbjGtfq9udZ26QH5ns
	 FHaeTdqp/uds5QI+xmcEqCwjO1aN2m5W2CK+DN69PtRzo8Hv8NDytAiYyEechRgaHk
	 honBsiMFHw4ww==
Date: Fri, 13 Feb 2026 12:40:24 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 09/10] RDMA/bnxt_re: Use ib_respond_udata()
Message-ID: <20260213104024.GN12887@unreal>
References: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <9-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16813-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 299761352DB
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 09:45:43PM -0400, Jason Gunthorpe wrote:
> All the calls to ib_copy_to_udata() can use this helper safely.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 6ea03e1f6c23dd..9d1c31bb994218 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -748,7 +748,7 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)

<...>

> -			rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
> +			rc = ib_respond_udata(udata, resp);
>  			if (rc) {
>  				ibdev_err(&rdev->ibdev, "Failed to copy QP udata");

<...>

> -		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
> +		rc = ib_respond_udata(udata, resp);
>  		if (rc) {
>  			ibdev_err(&rdev->ibdev, "SRQ copy to udata failed!");

<...>

> -		rc = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
> +		rc = ib_respond_udata(udata, resp);
>  		if (rc) {
>  			ibdev_err(&rdev->ibdev, "Failed to copy CQ udata");

<...>

> -	rc = ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)));
> +	rc = ib_respond_udata(udata, resp);
>  	if (rc) {
>  		ibdev_err(ibdev, "Failed to copy user context");

Should we move the error message into ib_respond_udata() and remove all
the corresponding prints from the drivers?

Thanks

> -- 
> 2.43.0
> 
> 

