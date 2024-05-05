Return-Path: <linux-rdma+bounces-2270-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4178BC079
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 15:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6771B212E1
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 13:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C8B1BC5C;
	Sun,  5 May 2024 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyFIsDIc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669F218C36;
	Sun,  5 May 2024 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714914589; cv=none; b=iz5fEvSiFly5GzszwxJeG6r2zUwIY6zFQFSpEn8QgKONtQtGpYtC1bfU84uGch0VRupZ61/VUa4+akLFrINB016ejwK/Axb7qDrZSdyKje+8YOxW3DhpgshB4xqRls3D13yusYk+7kU/PbdmWLJhrBRgUul4+zlvwWfLW91QX38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714914589; c=relaxed/simple;
	bh=xlRUYoJPou2/MPpAB5hzWLpalR+ZAUvBv9HmZG5I9+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5h9egQu9yFIYyQulPXPhgYqqjFbJjlEzpkHcE+8TiMgFxlnENQKN02y+QIIipEVsvYRDMfR3vhY6VIxpVYeHvYxByb/L6GIb+crRDHtkQqxSSeIBvp4hrhDozEAYYAlAoeHbvHM0yFekATz4uPN/XPK91BdZnGKuI6Pjpf3CaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyFIsDIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E851C113CC;
	Sun,  5 May 2024 13:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714914588;
	bh=xlRUYoJPou2/MPpAB5hzWLpalR+ZAUvBv9HmZG5I9+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DyFIsDIcBCXPdf5m999VIskZIZ3Ju5s8JfJ7pbM8DKPrNCCZI9ot8LqlAFcA7zGeH
	 xEfZUHP+pTYlQEqLs5pArOYOcT/l+a+8A+7Li6FYOIOb0T0Q92zUCdc02p38J1kKkN
	 fGz+U2FNMt6C6ocJrCG3jWrFuT2kSuaQOuVPdsE/3Xt5+iiIhD2KTKWkyHVbirLHfh
	 32cMVlj5dqsjTbb6WCnYlM6luqPotng5VtG5kZVmmJPSVMiRB1wsc8tj4jsVypNjmR
	 0qe5FzwC3I1L1tkbGk2SvbABZQgkwvc244O3J4xGB0zePEAC4wEw7a2mGw3vkLSbks
	 1+K3E3asdqGhg==
Date: Sun, 5 May 2024 16:09:45 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	dri-devel@lists.freedesktop.org,
	LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Lukas Wunner <lukas@wunner.de>,
	Dean Luick <dean.luick@cornelisnetworks.com>
Subject: Re: [PATCH 3/3] RDMA/hfi1: Use RMW accessors for changing LNKCTL2
Message-ID: <20240505130945.GB68202@unreal>
References: <20240215133155.9198-1-ilpo.jarvinen@linux.intel.com>
 <20240215133155.9198-4-ilpo.jarvinen@linux.intel.com>
 <26be3948-e687-f510-0612-abcac5d919af@linux.intel.com>
 <20240503130416.GA901876@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503130416.GA901876@ziepe.ca>

On Fri, May 03, 2024 at 10:04:16AM -0300, Jason Gunthorpe wrote:
> On Fri, May 03, 2024 at 01:18:35PM +0300, Ilpo Järvinen wrote:
> > On Thu, 15 Feb 2024, Ilpo Järvinen wrote:
> > 
> > > Convert open coded RMW accesses for LNKCTL2 to use
> > > pcie_capability_clear_and_set_word() which makes its easier to
> > > understand what the code tries to do.
> > > 
> > > LNKCTL2 is not really owned by any driver because it is a collection of
> > > control bits that PCI core might need to touch. RMW accessors already
> > > have support for proper locking for a selected set of registers
> > > (LNKCTL2 is not yet among them but likely will be in the future) to
> > > avoid losing concurrent updates.
> > > 
> > > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > Reviewed-by: Dean Luick <dean.luick@cornelisnetworks.com>
> > 
> > I found out from Linux RDMA and InfiniBand patchwork that this patch had 
> > been silently closed as "Not Applicable". Is there some reason for
> > that?
> 
> It is part of a series that crosses subsystems, series like that
> usually go through some other trees.

Exactly, this is why I marked it as "Not Applicable".

> 
> If you want single patches applied then please send single
> patches.. It is hard to understand intent from mixed series.
> 
> Jason

