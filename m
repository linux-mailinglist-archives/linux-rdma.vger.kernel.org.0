Return-Path: <linux-rdma+bounces-20241-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPjBDh7s/WlJkwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20241-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 15:58:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B17474F7786
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 15:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92BBC30AB2CA
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 13:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF1C3E0C68;
	Fri,  8 May 2026 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OIMsirXh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C335B3E0238
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248312; cv=none; b=OKB6FRNcLIBP/3mBM+1ORCDcWaz5yLfHvO84IHAOIsphLL8HJqjbFL05VjUyfxPNFnCIJOcnJGkSI1fFi5L+1qMk6hnmpdSJCorSK3ZbQvRmgGEn7cDLmYY5+WSBD+ZdkhBJRADTCAFAWorghpjLz4qeAZnLKMIh4emqL5ZYz4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248312; c=relaxed/simple;
	bh=KsfRtRKjrlnVJbGoVhj7QSa0bk0B1DsAd45EvdGW+Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpafmcdSDdfbV5dwLh7iQxMGbCqccDJEZab7IGxU1rCdnzAqlM1nq2e3TPxf//jGhp1NQbjtvYQcTp7U6i/tneUsGz8qy8fE51CEE68TQCV3sElkilblITH3IbXTl6GuWyNa8akqZ00vNQ1MnSgdcMhSDNMHyKSHNRgI1zyU3Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OIMsirXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30060C2BCB0;
	Fri,  8 May 2026 13:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778248312;
	bh=KsfRtRKjrlnVJbGoVhj7QSa0bk0B1DsAd45EvdGW+Os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OIMsirXhJfVKWN7f+h/nODXSNwgtN4sMjSI1x7defcu7AzXhSssQ6B0Smizsh0Eaz
	 MAneXlXo+kL6XpP++A8lcBhCAVbH19RLuzM9OrwQXVOIXJ+3vT/16hS3AH+dKql2d6
	 yYNgqPDEg27odakNKqTs1wbkIvC8Hd6z4RIJr6OU=
Date: Fri, 8 May 2026 15:51:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Henrik Holmberg <pomzm67@gmail.com>
Cc: security@kernel.org, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com, linux-rdma@vger.kernel.org
Subject: Re: [security] RDMA/bnxt_re: kernel infoleak via uninitialised shpg
 shared page exposed to userspace
Message-ID: <2026050818-divisible-unlocked-e1f7@gregkh>
References: <CAOOd5ej7=KFT8+JO8D3g=QnnhJR2+V--a+JSKcpuxUt=tyGyZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOOd5ej7=KFT8+JO8D3g=QnnhJR2+V--a+JSKcpuxUt=tyGyZw@mail.gmail.com>
X-Rspamd-Queue-Id: B17474F7786
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20241-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 03:45:13PM +0200, Henrik Holmberg wrote:
> Suggested fix (one-line)
> ------------------------
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -4375,7 +4375,7 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext
> *ctx, struct ib_udata *udata)
> 
>         uctx->rdev = rdev;
> 
> -       uctx->shpg = (void *)__get_free_page(GFP_KERNEL);
> +       uctx->shpg = (void *)get_zeroed_page(GFP_KERNEL);
>         if (!uctx->shpg) {
>                 rc = -ENOMEM;
>                 goto fail;
> 

Can you just turn this into a real patch that can be applied, so you get
full credit for the fix?  The kernel documentation explains how to do
this.

thanks,

greg k-h

