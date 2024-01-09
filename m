Return-Path: <linux-rdma+bounces-581-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A13B828BE2
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jan 2024 19:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455012891DB
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jan 2024 18:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23173C09F;
	Tue,  9 Jan 2024 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m98qKa4t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA353BB34
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jan 2024 18:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC52C433F1;
	Tue,  9 Jan 2024 18:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704823528;
	bh=WO9OR200LodCcWG+8xk3KzjgWbPyFRTYYo26up08CnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m98qKa4tVt+Z59fKAJ68Wj5NTUG17JBxQ11i8CBmzUY2/uzdG4zmvWqnIuvPtw0Tv
	 FQ6ODreRem8YZowSw0biCi0CB02tkk0YtUHH841D+kmneONktpx1PxjRNlUrL1A3fg
	 2ML3bEqpJ6oYOct5MBl/dfpdXigZCZmEXOuz0qjCfAJVDoTOGXtIBFFMriZonIvrcG
	 /stVGJLpxGZlt8GSN9vAt89DX1cdOzJox5TcCVWZVdckLhrFheIi4MZ8iL1rUtmYoh
	 aJ1Rejv1RNU98h3uclxghruXC9/B+aT6i3CXIkGLk0qs1v3QKD1n4t6HKPaEWVvmZO
	 mUL755T/ubCLw==
Date: Tue, 9 Jan 2024 20:05:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	"Margolin, Michael" <mrgolin@amazon.com>
Cc: linux-rdma@vger.kernel.org, sleybo@amazon.com, matua@amazon.com,
	gal.pressman@linux.dev, Anas Mousa <anasmous@amazon.com>,
	Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next v4] RDMA/efa: Add EFA query MR support
Message-ID: <20240109180523.GA7488@unreal>
References: <20240104095155.10676-1-mrgolin@amazon.com>
 <20240107100256.GA12803@unreal>
 <20240108130554.GF50406@nvidia.com>
 <20240108180140.GB12803@unreal>
 <20240108180636.GM50406@nvidia.com>
 <86765443-4292-44b4-824e-d2ea5ebebc18@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86765443-4292-44b4-824e-d2ea5ebebc18@app.fastmail.com>

On Mon, Jan 08, 2024 at 09:40:32PM +0200, Leon Romanovsky wrote:
> 
> 
> On Mon, Jan 8, 2024, at 20:06, Jason Gunthorpe wrote:
> > On Mon, Jan 08, 2024 at 08:01:40PM +0200, Leon Romanovsky wrote:
> >> > I was saying in the rdma-core PR that this field shouldn't even
> >> > exist..
> >> 
> >> Something like that?
> >
> > Yeah, like that. However it is difficult to get the out valid uattr
> > back in the rdma-core side.
> >
> > This is best if the ID's can have well defined not-valid values such
> > as 0 or -1.
> 
> Michael tried something like that in previous versions by defining 0xffff as not valid.
> 
> I didn't like it because there's no promise from PCI core that it is invalid value.

Michael,
What do you think?

Thanks

> 
> 
> 
> >
> > Jason
> 

