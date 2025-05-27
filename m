Return-Path: <linux-rdma+bounces-10746-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18870AC4877
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 08:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC363B21B9
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 06:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8571F099C;
	Tue, 27 May 2025 06:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmdsukM/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044CD1FDA;
	Tue, 27 May 2025 06:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748327738; cv=none; b=cHgPSgfj6+Vz5+98i1+GyDCzcM70GHG+SlNx3XNtAh70m1FC/33lHngCxamOFoI28Y2KKNfe0XtrX90D2ERlYZX+qwMw4+3kRDFnA3UQqeXb2r9Qxl25BjK1lUbZmlEXaRRYX8yZQB8+qYzlG8rF9C6HmYhEJIIvRXlFkQReg9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748327738; c=relaxed/simple;
	bh=Rx8f4II8oUPfnvjBrQq2YJGmpMISeqPnI7FmzJaZ2CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXO6LzM/rjEnRc/RC+pFkFJc0im3SP1WI3Tdc80czWf1mwNkqcUqC3pADk1+jOc/uu2tIh+GVsg0/kVd+z2G6+1oSF8lOwF01m/8Cj8YykWG8tlCcvTcyltHHu+X4XLGSX4XMD/l1m/+VDYvJ0MBEsXTqHalxYVmvmSTEAqElyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmdsukM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC182C4CEEA;
	Tue, 27 May 2025 06:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748327737;
	bh=Rx8f4II8oUPfnvjBrQq2YJGmpMISeqPnI7FmzJaZ2CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tmdsukM/Qc9MUs/P41c2hvdUENuX9qMZb9aUN0cEqE9Ac4gkYhfseJYDSLQEhcZjD
	 jrCTUOY/+YGNL0mmJzRgh/+m/9nTNJN7e8oQu/6cP+Fa0FtjO+fxdzNnKjFziTvpAv
	 +bWhMyINjA8RAFhtL1xD5wFMWJDpcpbGPmELGNZiEHFHdPGg9qwyz7yvybrPYmdd2A
	 O9M1uv1A76BcDrv/2ve/+tT2LzPFc0jCKzeBTS/3yeUIrbQJ8SMlFpaxluOODVePT5
	 WiAWyhZJTffohv6o2B7MX11iit6vM4QEmH/Aw0OuS91sEzxCf+RACA2wTs8U4sQukR
	 hT3pcDdGzcKQg==
Date: Tue, 27 May 2025 09:35:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Greg Sword <gregsword0@gmail.com>
Cc: Daisuke Matsuda <dskmtsd@gmail.com>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com,
	hch@infradead.org
Subject: Re: [PATCH for-next v3] RDMA/core: Avoid hmm_dma_map_alloc() for
 virtual DMA devices
Message-ID: <20250527063532.GZ7435@unreal>
References: <20250524144328.4361-1-dskmtsd@gmail.com>
 <CAEz=LcsmU0A1oa40fVnh_rEDE+wxwfSo0HpKFa_1BzZGzGG71g@mail.gmail.com>
 <20250525060549.GV7435@unreal>
 <CAEz=Lcu3KtR5vNK5KbUcUzziit7z=rJofNQjVB-FA=35jiAseQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEz=Lcu3KtR5vNK5KbUcUzziit7z=rJofNQjVB-FA=35jiAseQ@mail.gmail.com>

On Tue, May 27, 2025 at 01:52:58AM +0800, Greg Sword wrote:
> On Sun, May 25, 2025 at 2:05 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Sun, May 25, 2025 at 05:27:23AM +0800, Greg Sword wrote:
> > > On Sat, May 24, 2025 at 10:43 PM Daisuke Matsuda <dskmtsd@gmail.com> wrote:
> > > >
> > > > Drivers such as rxe, which use virtual DMA, must not call into the DMA
> > > > mapping core since they lack physical DMA capabilities. Otherwise, a NULL
> > > > pointer dereference is observed as shown below. This patch ensures the RDMA
> > > > core handles virtual and physical DMA paths appropriately.
> >
> > <...>
> >
> > > > +EXPORT_SYMBOL(ib_dma_virt_map_alloc);
> > > >  #endif /* CONFIG_INFINIBAND_VIRT_DMA */
> > > >
> > >
> > > Your ODP patches have caused significant issues, including system
> > > instability. The latest version of your patches has led to critical
> > > failures in our environment. Due to these ongoing problems, we have
> > > decided that our system will no longer incorporate your patches going
> > > forward.
> >
> > Please be civil and appreciate the work done by other people. Daisuke
> > invested a lot of effort to implement ODP which is very non-trivial part
> > of RDMA HW.
> >
> > If you can do it better, just do it, we will be happy to merge your
> > patches too.
> >
> > At the end, we are talking about -next branch, which has potential to be
> > unstable, so next time provide detailed bug report to support your claims.
> >
> > In addition, it was me who broke RXE.
> 
> Is it an Honor?

It is a fact.

> 
> >
> > Thanks

