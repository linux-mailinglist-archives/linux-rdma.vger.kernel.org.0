Return-Path: <linux-rdma+bounces-7807-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B6A3A174
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 16:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CCC188E969
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D469D26E147;
	Tue, 18 Feb 2025 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nS2Gd5Me"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA50722AE4E;
	Tue, 18 Feb 2025 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893097; cv=none; b=OfY8VQicqL2caDx0HEaVnp4swgFKw9EvYuDhK8VChwZ4mTZ0vO8NB5feQcta0V4zcSg/duLc6OJZLalXOkXZsaczEKFK4NKYGSu45Xble2kbAz2eGkOmYSFV0VK+3CWLiDJ+du3YM+bm0Rntt2Ob6RTrDjPt1YkyLh5nPBX4yyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893097; c=relaxed/simple;
	bh=iDa2j8gYKzA+VuCfPgSgSD5Xf2DBFwZpDYLdLk9+2mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfE7lE5jCIz10oPTEevjfJzZmh37XLz1hjOlUAtmMwmyxoIXwZfbaJeYKiSr3YJwa+1xp+8D/vIUfGdYdwMsajNtbfNdNhzS/eaR86vmuc5Bz7Wd14IHeQaHt4WuzMLfSNQuCeYbjVLehst0uWacOfR7IPmSakwkrjBs91VB4/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nS2Gd5Me; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=x6cdc3EOFmuE/ocv+AEgGlvMbeb+bF1Ao362JvuWKD4=; b=nS2Gd5MeVkcl8dmpRFhJ/6Y1XE
	xG5eGjx0BJFP+GmqXr7xKxx9sewQAeNTemWXsvm6jk4xDVoiJpWrjHFKErs/j00XJbqMxUZJWYC0x
	d4PIC9ZMSkx4+9MyQieXJ/o6XOstjt4SmBKREv85D9JApvdDsM4pPF6htb4ZHysKKabU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tkPfb-00FKza-4y; Tue, 18 Feb 2025 16:37:59 +0100
Date: Tue, 18 Feb 2025 16:37:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
Message-ID: <36ab1f42-b492-497f-a1dc-34631f594da6@lunn.ch>
References: <Z6GCJY8G9EzASrwQ@kspp>
 <4e556977-c7b9-4d37-b874-4f3d60d54429@embeddedor.com>
 <8d06f07c-5bb4-473d-90af-5f57ce2b068f@gmail.com>
 <7ce8d318-584f-42c2-b88a-2597acd67029@embeddedor.com>
 <5f2ca37f-3f6d-44d2-9821-7d6b0655937d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f2ca37f-3f6d-44d2-9821-7d6b0655937d@gmail.com>

On Tue, Feb 18, 2025 at 11:49:14AM +0200, Tariq Toukan wrote:
> 
> 
> On 18/02/2025 10:14, Gustavo A. R. Silva wrote:
> > Hi all,
> > 
> > Friendly ping: who can take this, please?
> > 
> > Thanks
> > -- 
> > Gustavo
> > 
> 
> net-next maintainers, please pick it.
> I provided the Reviewed-by tag.

The alternative patch was not formally submitted, it is just embedded
in the discussion. It needs posting as an actual patch for merging.

    Andrew

---
pw-bot: cr



