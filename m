Return-Path: <linux-rdma+bounces-20833-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO9EAWWhCWpdigQAu9opvQ
	(envelope-from <linux-rdma+bounces-20833-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 13:07:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8099560A11
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 13:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3421E3003D24
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 11:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B234EF11;
	Sun, 17 May 2026 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2QEl9bx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3CB5695;
	Sun, 17 May 2026 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779016026; cv=none; b=OxZRiANd2aTjCbOqsyrME/Uui7AmejyoySLiIPUWAuiCoq21HXRs6ytaY3Pji91oyUTaJNOwyZpaVdPnlt+XGqphj7vSTmcoILpcHC8ZaMDPkZYzwBCJEzadunyJ6eAU6AlXR9DYj30jn9s1oIWj4qZt9UqZi1kb0Wb/MAIcefo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779016026; c=relaxed/simple;
	bh=o7wYNZLDVgEtS7M9yBuuZDHk4ULoTFE694kh8GBvd/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aucDQDSaCcizXW5n654xhua8RoU0Ovi8ZpV1ulhaNU7xEdc4ixiK/tDdz8AnmX6Cm+GApGhTQmpgx4SxpjAg9uvVjdIcw9nQE7M3W1P2kRfD6twPOzbp9pbTeLiYYOWSlkMUbvX2ZSAU97F4ICLCjR/cudOxnK5JJUCw0xz7YDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2QEl9bx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDE6C2BCB0;
	Sun, 17 May 2026 11:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779016025;
	bh=o7wYNZLDVgEtS7M9yBuuZDHk4ULoTFE694kh8GBvd/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2QEl9bx+ZgxLYRl6q9HC4DlQdi1x7IKMnAxD1HjYrywsD+sT5fAwVN0E75RKHHKm
	 31YEU7FOtu4AEhHTEs/DFfou5M+7p0rXBm/PtxcB0l31S/gphLXOEjaTpc3WhvEbVu
	 sa2ZB6OP668VAFDW+lcHj9XPpqEZbgzMN0X+SzNsCRTkGtUmmpI91Lc4QL6zo6xNnw
	 42eswXeEErwLbfcQFgvPCrMZ3F2ZEm2pGzgmyzO33ja4LLgUvs/QtYQZhCRRb6HZ0S
	 MrRlorzkeyt+1jvtmGDUzpwboMEs/3Fz6xt4rG7JRSvW11VMW6dbJUi9MEGsg/gS+L
	 qM7ytGH6UZN/g==
Date: Sun, 17 May 2026 14:07:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mana_ib: Use ib_get_eth_speed for
 reporting port speed
Message-ID: <20260517110701.GD33515@unreal>
References: <20260512094056.264827-1-kotaranov@linux.microsoft.com>
 <SA1PR21MB66831B2B066734B6228C866BCE062@SA1PR21MB6683.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB66831B2B066734B6228C866BCE062@SA1PR21MB6683.namprd21.prod.outlook.com>
X-Rspamd-Queue-Id: B8099560A11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20833-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 10:15:01PM +0000, Long Li wrote:
> > From: Shiraz Saleem <shirazsaleem@microsoft.com>
> > 
> > Replace hardcoded IB_WIDTH_4X/IB_SPEED_EDR with ib_get_eth_speed() to
> > report the actual link speed in mana_ib_query_port().
> > 
> > Fixes: 4bda1d5332ec ("RDMA/mana_ib: Implement port parameters")
> > Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> > Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> > ---
> >  drivers/infiniband/hw/mana/main.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/mana/main.c
> > b/drivers/infiniband/hw/mana/main.c
> > index d4dfbec..9af92a4 100644
> > --- a/drivers/infiniband/hw/mana/main.c
> > +++ b/drivers/infiniband/hw/mana/main.c
> > @@ -633,8 +633,7 @@ int mana_ib_query_port(struct ib_device *ibdev, u32
> > port,
> >  		props->phys_state = IB_PORT_PHYS_STATE_DISABLED;
> >  	}
> > 
> > -	props->active_width = IB_WIDTH_4X;
> > -	props->active_speed = IB_SPEED_EDR;
> > +	ib_get_eth_speed(ibdev, port, &props->active_speed,
> > +&props->active_width);
> 
> Should it check the return value, use default values as fallback?

Should it perform the check? Maybe.

Should it fall back to default values? No. A failure at this
stage indicates that the driver is fundamentally broken. This is
why many drivers do not bother checking the return value here.

Thanks

> 
> Something like:
> 
>    ret = ib_get_eth_speed(ibdev, port, &props->active_speed, &props->active_width);
>    if (ret) {
>         props->active_width = IB_WIDTH_4X;
>         props->active_speed = IB_SPEED_EDR;
>    }
> 

