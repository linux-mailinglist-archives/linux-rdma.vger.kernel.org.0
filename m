Return-Path: <linux-rdma+bounces-6023-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5487D9D0BE5
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2024 10:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F3A284EBB
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2024 09:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25CF19067C;
	Mon, 18 Nov 2024 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyhQfIzJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D37186E46;
	Mon, 18 Nov 2024 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922640; cv=none; b=QVYuOfSlIRN+KgL8MdrOg8fMhIDe4JZI7ZROV6SmIJEOFErJJqt0dSPVL40CxOakvsBmyLGMFskEtfHBudk7A7tbzGQx/bVgmlKvKKWtmRKk1yPCTbQnsPoNyqVW4TIKGl76kV/y/6RUl8zFO0obKL5b9Q/eeL9nhjsd2RgJxwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922640; c=relaxed/simple;
	bh=9LFqkLWkNELB0zz0PQ/SBJJxRnjhZ41FKHaJNoaBj0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3q+XU/j5IdIXjNI11AZex77CfBxn5R8oRXet9DoLlwq0D/SrUFNU+31tWEInS/AyeR/NSvUMPlu0WG8o+jEreNWGOfDeXV1LrT66Y43v60Alg6myz6e/LwzCb+nvH5raJ4lTI3X/wQZHnLmdkoGxaUvHti/h3BZsBmk7/iuuwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyhQfIzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FF4C4CECC;
	Mon, 18 Nov 2024 09:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731922638;
	bh=9LFqkLWkNELB0zz0PQ/SBJJxRnjhZ41FKHaJNoaBj0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JyhQfIzJe3wRRsst2j++ZbOlO8oOhqOB4IvQr3WeO7wKreQJ48LKAWX+i+CDYpieL
	 jny8xf9sUH6OApc+O0YcpkO6+jKedHfwfQYlyXZzd2/HNZyMvo+gRWbY6Z5XBVQIDq
	 dtwuN92FjJtRfBxZtiZ7iurYkhQCVEamTs9chXNM7jFVFaIT00CdK38GHuQQG4PEW1
	 R1r4b/d6sKnBb+eXv6MdqTQmksz3RPnzqPwBM9B/NNfzLbQcEqRCZSecqfj/PekGlf
	 ITQtodU01d98jAzuxEcTbJ7lhkc4MGL92p3RpdYodxa1uXG4pwz8S9yej660vSFuI0
	 kJ7eUGfbB4qLQ==
Date: Mon, 18 Nov 2024 11:37:12 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux390-list@tuxmaker.boeblingen.de.ibm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/smc: Run patches also by RDMA ML
Message-ID: <20241118093712.GA8673@unreal>
References: <20241115-smc_lists-v1-1-a0a438125f13@linux.ibm.com>
 <20241117100156.GA28954@unreal>
 <bd8e196839281fd324721650c5974db35b7990ec.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd8e196839281fd324721650c5974db35b7990ec.camel@linux.ibm.com>

On Mon, Nov 18, 2024 at 09:46:28AM +0100, Gerd Bayer wrote:
> On Sun, 2024-11-17 at 12:01 +0200, Leon Romanovsky wrote:
> > On Fri, Nov 15, 2024 at 06:44:57PM +0100, Gerd Bayer wrote:
> > > Commits for the SMC protocol usually get carried through the netdev
> > > mailing list. Some portions use InfiniBand verbs that are discussed on
> > > the RDMA mailing list. So run patches by that list too to increase the
> > > likelihood that all interested parties can see them.
> > > 
> > > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > > ---
> > > ---
> > >  MAINTAINERS | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 32d157621b44fb919307e865e2481ab564eb17df..16024268b5fc1feb6c0d01eab3048bd9255d0bf9 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -20943,6 +20943,7 @@ M:	Jan Karcher <jaka@linux.ibm.com>
> > >  R:	D. Wythe <alibuda@linux.alibaba.com>
> > >  R:	Tony Lu <tonylu@linux.alibaba.com>
> > >  R:	Wen Gu <guwen@linux.alibaba.com>
> > > +L:	linux-rdma@vger.kernel.org
> > >  L:	linux-s390@vger.kernel.org
> > 
> 
> Hi Leon,
> 
> > Why don't we have netdev ML here too?
> 
> since all smc code resides in net/smc the filter tag F: net/ in
> "NETWORKING [GENERAL]" provides that. My first internal draft contained
> an explicit L: tag for the netdev ML, but I dropped it to avoid any
> redundancy.

Thanks for the explanation,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

