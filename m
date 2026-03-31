Return-Path: <linux-rdma+bounces-18860-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNOFMUYazGnHPgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18860-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 21:02:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 608B6370535
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 21:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72DD1304068D
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 19:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1002E330B2D;
	Tue, 31 Mar 2026 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HotHbz1V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56503845C2;
	Tue, 31 Mar 2026 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983747; cv=none; b=MEoXFUWyRio/VqCfkPkq88SpQqlIVufcfM00TFFxpGl6KuNB+ntdekGVstBW4xz2+VKaJLhXxyQZDWmi76WnDw/MoofmXWnoKMT0yKnyGKGGyyB0Xq4tulwJOvqukaOgXfFmw6U87KbOoljTmPAl5/LvYMulYyXGvNLrWxDiOdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983747; c=relaxed/simple;
	bh=R94WVshWogD2v4hXHETq37YTuAedBBrvIpKh2CGxklY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6ch8u+sTA29x35rkToEdeneffvUmW6+9pqYHcThOrHodWiy8X6eU58IilvH+4wvj21lvSUhoPVSY/QobyN5xhSNDZcpQ2HawsFHXgnajEmrkakkMPHampBTxSPo8c9ygXoHEZixbtgaVmSOzApssRbkC7lh9yluHKiEHgbAhMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HotHbz1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A1DC19423;
	Tue, 31 Mar 2026 19:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774983747;
	bh=R94WVshWogD2v4hXHETq37YTuAedBBrvIpKh2CGxklY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HotHbz1VpN+dUNKQYC7KDVOBp2EtyGMtsxbWiR4UaZdlPXa08F1P+GYNo8X0Y+PPq
	 ISowxrEU6fREnIPbKnvZjP5om8QNQpMUADWipKo8TsAkRHMai/75MFcTYP1JCN89Mg
	 NQVZTkO4VWfilvnfBAUIrauuZXubwNw17NP+GPHrPQAn3FUu4mFiDyR228UirXOhJl
	 0NY7OWzfD+3DlAUcC8ASJuQIbvKNwv2nDDIJ3cCJDhWH0ROsKcnLwAsyiUv9FPNqrU
	 yhNr8p3UYkImGirMJoJkt6oDzxbkZNOXiJ3PM7DYGtmpdUZfeXb71HdYdNrN1RMutv
	 OggMmxcQa/t9w==
Date: Tue, 31 Mar 2026 22:02:20 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <20260331190220.GI814676@unreal>
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal>
 <acW2BwQKaUbS3eL9@kbusch-mbp>
 <20260331083758.GA814676@unreal>
 <acvFV8c5QVxnt3Em@kbusch-mbp>
 <20260331132942.GC814676@unreal>
 <acvNsvS5ShlQlrox@kbusch-mbp>
 <20260331140309.GH814676@unreal>
 <acvWplw67b3Gwlkc@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acvWplw67b3Gwlkc@kbusch-mbp>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18860-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 608B6370535
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 08:13:58AM -0600, Keith Busch wrote:
> On Tue, Mar 31, 2026 at 05:03:09PM +0300, Leon Romanovsky wrote:
> > I understand, my proposal is always set TPH flag when new struct is
> > used.
> 
> An existing application recompiled against the new kernel api implicitly
> uses the new struct layout without setting the TPH flag, so kernel and
> application are out of sync on where dma_ranges exists with your
> proposal.

Right, what about adding TPH fields to struct vfio_region_dma_range
instead of struct vfio_device_feature_dma_buf?

Thanks

