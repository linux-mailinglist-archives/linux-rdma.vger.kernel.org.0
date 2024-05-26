Return-Path: <linux-rdma+bounces-2612-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C55428CF317
	for <lists+linux-rdma@lfdr.de>; Sun, 26 May 2024 11:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD4B1F23794
	for <lists+linux-rdma@lfdr.de>; Sun, 26 May 2024 09:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC258F62;
	Sun, 26 May 2024 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DN2VLq7o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659DA8BEC;
	Sun, 26 May 2024 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716715626; cv=none; b=DAPL41ZFn2bkT7rvbnQlhav1hogkOaOGOEwq/UOy/8uzor1rgB8PLxDv9XtcbX8JGpDtNHhK79ZT/ul6DYmqENZRJiDQj4GgjbVNJ+S1OCnv2uqCRuPPAgmiajOG+9O2sJ1v3VMdBLAyTjM4y/5aOifnfcr4T28hv9I47soq5g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716715626; c=relaxed/simple;
	bh=jcy+vOhlV60idOM5RVwqLIgRJQM6y9+LYCAOLF8c4KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aidfqgKT1j1ElbG49QpjHD8udAWzk9CJIZJ19Vkliilr/FMs9Tgbc02ZKA26GIuXgMmg82AnXMcRgCeQBd9xFZWq2cCoP0D17EYWI66YHIr4VyUw3k3VcD+fThxFfVq3p9bKKhudFuJTYhNSBXmlLVFs5h6fQ7bjSJ/W3y66d0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DN2VLq7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B721C2BD10;
	Sun, 26 May 2024 09:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716715625;
	bh=jcy+vOhlV60idOM5RVwqLIgRJQM6y9+LYCAOLF8c4KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DN2VLq7oHgNuAVJJTjQ025s7VhYckzVzqDOAquoQsYfnyjmLQe/sIQzLovLNX3+eL
	 IlkGurDSkUOLfCMRV+jmqwWAcD5kBIhinQ+nPuhxZoK8a3HBi+fKkiXXtEOp1QTLzo
	 Hcc5rIhcO1nOHgK4Cri0iVxF00x1WkZ+zkH+1qla4kzGC2xSfi7gXO8YtY5G0rHuON
	 DVwDhGBVh4HPPQlO44iz9PJvD8zfWm4OLkAMvPx+Ygg+lJAKM6GuNNRYzSXfRYkRpZ
	 73i9NeOcyRIGcdjT90NTBcWBuE1hWz63FkWpUDnnuf44adzwsJPsUOj2yRpC4bCnPk
	 glQrSZH0wDTvA==
Date: Sun, 26 May 2024 12:27:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Greg Sword <gregsword0@gmail.com>
Cc: Haakon Bugge <haakon.bugge@oracle.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH v2 3/6] RDMA/cma: Brute force GFP_NOIO
Message-ID: <20240526092701.GA96190@unreal>
References: <20240515125342.1069999-1-haakon.bugge@oracle.com>
 <20240515125342.1069999-4-haakon.bugge@oracle.com>
 <82bf9e5f-b798-4d29-8473-c074a34f15b0@linux.dev>
 <236B9732-8264-454C-94BF-7C9D491D3A37@oracle.com>
 <CAEz=Lcvbc3O+PtDSLvGAgd5fmps8j69DDn+Mgm8UWMFMNSd8WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEz=Lcvbc3O+PtDSLvGAgd5fmps8j69DDn+Mgm8UWMFMNSd8WA@mail.gmail.com>

On Fri, May 17, 2024 at 03:07:34AM +0800, Greg Sword wrote:
> On Thu, May 16, 2024 at 11:54 PM Haakon Bugge <haakon.bugge@oracle.com> wrote:
> >
> > Hi Yanjun,
> >
> >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-netdev.rst?h=v6.9#n376
> > >
> > > "
> > > Netdev has a convention for ordering local variables in functions.
> > > Order the variable declaration lines longest to shortest, e.g.::
> >
> > "Infiniband subsystem" != netdev, right?
> 
> All kernel subsystems should follow this rule, including the network
> and rdma subsystems

Of course not. The request to sort variables is netdev coding style,
rest of the kernel doesn't have this rule and doesn't care about it.

In Infiniband, we accept both styles, just to make sure that people who
submit their patches to both subsystems won't need to bother themselves
with this.

Thanks

> 
> >
> >
> > Thxs, Håkon
> >

