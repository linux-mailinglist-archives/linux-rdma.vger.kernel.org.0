Return-Path: <linux-rdma+bounces-15452-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B8ED11972
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 10:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E30173042906
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 09:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE88923EAB8;
	Mon, 12 Jan 2026 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU8SE7t9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0FB2192FA
	for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768211136; cv=none; b=dUt7PEZMguv1CeKDR1Qu+j4V+XVMafTm2PvGQMbByOff3x2Ersa43Wm57pZcx09Ptxo8tfERJHh99SmL/fMMw9Y3ESareSYQJcClQw9rOIhP8tFyMzUTuD+UJBLjtDyFxMtYMSFVfvZeURtyFOu4QV6E6t2yKGay8JzYCbeU1V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768211136; c=relaxed/simple;
	bh=Y9VKqJNqilUzfcFjYxcPos2FYCXBclsoXMsFTpOSS0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMZnW95+Kr3Z+RqHteUaSNlK/CaLP1Sw4DM0wTVN0HZb+XncXu+rDv4Xc1bZctxfsQ9oy36kBUXS0Xr7GiggdnIwgQvTZnLbu+TLBwkW4aNyCZftqBI4vu4g7FFmdJ8nQsE/z/mgMWdeusisIKOPbebpggWNoBfgS+/MqbiabtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU8SE7t9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1D5C116D0;
	Mon, 12 Jan 2026 09:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768211136;
	bh=Y9VKqJNqilUzfcFjYxcPos2FYCXBclsoXMsFTpOSS0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BU8SE7t9OKAdA/2ePgzlSFFmyLnJXv1DHHEtCQxmCshsHVp7RoSaNzy09AIOcvy4o
	 x0rcuYmHHagZgptZmig8to3L7bCkEmpIWRVaisJx0Vq47i8ZNRfiW+HCunH9T2kt2s
	 OGEdo1mHkpRnMO8VK+8aBqI3u+VhDalxOO/wJefffKfIpju55PkEx7T6hDUu9R5imo
	 itXCRyesfwPlnVSb/Ynox56yyCigyraVfLeHFTHsC4MmvTHCIxW8tAjyy3PHBrafcx
	 LJO47Hx01winik/y7Qi30Gjnk0SiLlGJWISCMi31iD3SIUgrQZuyOXH9RbT6Nbkkv9
	 E4FeVjF36+68A==
Date: Mon, 12 Jan 2026 11:45:30 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, usman.ansari@broadcom.com,
	Simon Horman <horms@kernel.org>, kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] RDMA/bng_re: Unwind bng_re_dev_init properly and remove
 unnecessary rdev check
Message-ID: <20260112094530.GD14378@unreal>
References: <20260107091607.104468-1-siva.kallam@broadcom.com>
 <20260111132255.GA14378@unreal>
 <CAMet4B4f1itHok0AxExs2dZdGvAExjuESrB+aUTwO_QbTA-SYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMet4B4f1itHok0AxExs2dZdGvAExjuESrB+aUTwO_QbTA-SYA@mail.gmail.com>

On Mon, Jan 12, 2026 at 02:44:05PM +0530, Siva Reddy Kallam wrote:
> On Sun, Jan 11, 2026 at 6:53 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Wed, Jan 07, 2026 at 09:16:07AM +0000, Siva Reddy Kallam wrote:
> > > Fix below smatch warnings:
> > > drivers/infiniband/hw/bng_re/bng_dev.c:113
> > > bng_re_net_ring_free() warn: variable dereferenced before check 'rdev'
> > > (see line 107)
> > > drivers/infiniband/hw/bng_re/bng_dev.c:270
> > > bng_re_dev_init() warn: missing unwind goto?
> >
> > Please provide commit message.
> Sure, will do in next version of patch.
> >
> > >
> > > Fixes: 4f830cd8d7fe ("RDMA/bng_re: Add infrastructure for enabling Firmware channel")
> > > Reported-by: Simon Horman <horms@kernel.org>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <error27@gmail.com>
> > > Closes: https://lore.kernel.org/r/202601010413.sWadrQel-lkp@intel.com/
> > > Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> > > Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
> > > ---
> > >  drivers/infiniband/hw/bng_re/bng_dev.c | 33 +++++++++++++-------------
> > >  1 file changed, 16 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
> > > index d8f8d7f7075f..e2dd2c8eb6d2 100644
> > > --- a/drivers/infiniband/hw/bng_re/bng_dev.c
> > > +++ b/drivers/infiniband/hw/bng_re/bng_dev.c
> > > @@ -124,9 +124,6 @@ static int bng_re_net_ring_free(struct bng_re_dev *rdev,
> > >       struct bnge_fw_msg fw_msg = {};
> > >       int rc = -EINVAL;
> > >
> > > -     if (!rdev)
> >
> > You have other places with impossible "if (rdev)" check in this path which you should
> > delete as well.
> Hi Leon,
> I see only one "if (rdev)" in bng_re_remove . Are you referring to that?

Yes, this is the place I noticed as well, but I would welcome a more
general cleanup.

Thanks

