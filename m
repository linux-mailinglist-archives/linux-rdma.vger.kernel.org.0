Return-Path: <linux-rdma+bounces-9772-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C449A9AAEF
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Apr 2025 12:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5563A63CF
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Apr 2025 10:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AEA20B7EA;
	Thu, 24 Apr 2025 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BH0J527G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20B6F510;
	Thu, 24 Apr 2025 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491759; cv=none; b=n/4w2S6/HjKOhAJDIdQubB2SMQpya/qW0h43PXLkKBDkl4nfCt2Dm9NwFDYn8c/AuxpXsvasXSE5YJq3MXYv7ISVx+pwxZTOBCOXNIYFtx+5Qg19Ie94ilMcCqGX4ptmamFc+1W68DuU77seAMhFFsDk0/iJHqxbxhGV9YaM4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491759; c=relaxed/simple;
	bh=mqWPrwTyWntUN2VetXvoc4/yqzcGd25/TQDIPFZscK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvV9Tf4qI+px1JoD+M9zXsNakHhlrLPY1nlfJBMdoQKvW00JWaI6iUYUjLFdRiZqq0UOzNYFC+qxnr0xyM0ONfsb5CqJ1HYDiIK/4zKXxwMyX7CqNkvgbRknTSasPE9loDfF6tei8b8P/XkQ4ATFZJQFwkfAs8FlRxDjkkED7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BH0J527G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73357C4CEE4;
	Thu, 24 Apr 2025 10:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745491758;
	bh=mqWPrwTyWntUN2VetXvoc4/yqzcGd25/TQDIPFZscK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BH0J527GnzV00glYPFQKqBPecciMw4nWolX9ixxuZw+IXKKIh6WaRWECI84/KmVGt
	 cwcpEUhwekxaCDH8MztWHBXkG7nwdbI8lVoeZHm3+db4lHZqYzdzTRPpJLq2zLDToP
	 2woe3GLnozM2yL9CS8fTHHI/tnG01Xr09hKOOxB8Kk81mkXim96TDTrpjwOjISBUd4
	 rucKmQ9loaYWfhdrI4voitdtzW2ug4kh++koWa53+fK0y1PrjbXxu4BdSzd1wc1oRQ
	 FefFhGTwtM5yOKoRH+0hAqk6rcgV3QTdYZta4iD2radSkuhMIpElszYZAW86tP8bk2
	 fX002j0O8dXuQ==
Date: Thu, 24 Apr 2025 13:49:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Shiraz Saleem <shirazsaleem@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 4/4] net: mana: Add support for auxiliary
 device servicing events
Message-ID: <20250424104912.GR48485@unreal>
References: <1744655329-13601-1-git-send-email-kotaranov@linux.microsoft.com>
 <1744655329-13601-5-git-send-email-kotaranov@linux.microsoft.com>
 <20250420105309.GC10635@unreal>
 <BL1PR21MB3089EF4639B5CC2AD5E70B96C9852@BL1PR21MB3089.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR21MB3089EF4639B5CC2AD5E70B96C9852@BL1PR21MB3089.namprd21.prod.outlook.com>

On Thu, Apr 24, 2025 at 02:33:24AM +0000, Shiraz Saleem wrote:
> > Subject: [EXTERNAL] Re: [PATCH rdma-next 4/4] net: mana: Add support for
> > auxiliary device servicing events
> > 
> > On Mon, Apr 14, 2025 at 11:28:49AM -0700, Konstantin Taranov wrote:
> > > From: Shiraz Saleem <shirazsaleem@microsoft.com>
> > >
> > > Handle soc servcing events which require the rdma auxiliary device
> > > resources to be cleaned up during a suspend, and re-initialized during a
> > resume.
> > >
> > > Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> > > Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> > > ---
> > >  .../net/ethernet/microsoft/mana/gdma_main.c   | 11 +++-
> > >  .../net/ethernet/microsoft/mana/hw_channel.c  | 19 ++++++
> > > drivers/net/ethernet/microsoft/mana/mana_en.c | 60
> > +++++++++++++++++++
> > >  include/net/mana/gdma.h                       | 18 ++++++
> > >  include/net/mana/hw_channel.h                 |  9 +++
> > >  5 files changed, 116 insertions(+), 1 deletion(-)
> > 
> > <...>
> > 
> > > @@ -1474,6 +1481,8 @@ static void mana_gd_cleanup(struct pci_dev
> > *pdev)
> > >  	mana_hwc_destroy_channel(gc);
> > >
> > >  	mana_gd_remove_irqs(pdev);
> > > +
> > > +	destroy_workqueue(gc->service_wq);
> > >  }
> > 
> > <...>
> > 
> > > +static void mana_handle_rdma_servicing(struct work_struct *work) {
> > > +	struct mana_service_work *serv_work =
> > > +		container_of(work, struct mana_service_work, work);
> > > +	struct gdma_dev *gd = serv_work->gdma_dev;
> > > +	struct device *dev = gd->gdma_context->dev;
> > > +	int ret;
> > > +
> > > +	switch (serv_work->event) {
> > > +	case GDMA_SERVICE_TYPE_RDMA_SUSPEND:
> > > +		if (!gd->adev || gd->is_suspended)
> > > +			break;
> > > +
> > > +		remove_adev(gd);
> > > +		gd->is_suspended = true;
> > > +		break;
> > > +
> > > +	case GDMA_SERVICE_TYPE_RDMA_RESUME:
> > > +		if (!gd->is_suspended)
> > > +			break;
> > > +
> > > +		ret = add_adev(gd, "rdma");
> > > +		if (ret)
> > > +			dev_err(dev, "Failed to add adev on resume: %d\n",
> > ret);
> > > +		else
> > > +			gd->is_suspended = false;
> > > +		break;
> > > +
> > > +	default:
> > > +		dev_warn(dev, "unknown adev service event %u\n",
> > > +			 serv_work->event);
> > > +		break;
> > > +	}
> > > +
> > > +	kfree(serv_work);
> > 
> > The series looks ok to me, except one question. Are you sure that it is safe to
> > have not-connected and not-locked general work while
> > add_adev/remove_adev can be called in parallel from different thread? For
> > example getting event GDMA_SERVICE_TYPE_RDMA_SUSPEND while
> > mana_gd_probe() fails or some other intervention with PCI
> > (GDMA_SERVICE_TYPE_RDMA_SUSPEND and PCI shutdown).
> > 
> > What type of protection do you have here?
> > 
> Hi Leon,
> 
> Thanks for spotting this.
> 
> There are two cases.
> 
> -Probe / Resume
> add_adev() stores gd->adev only after auxiliary_device_add() succeeds.
> While gd->adev is still NULL the worker drops any GDMA_SERVICE_TYPE_RDMA_SUSPEND event, so an early suspend that arrives during probe is harmless and cannot race with the later add_adev().
> 
> -Remove / Suspend / Shutdown
> During teardown the worker may still be inside add_adev()/remove_adev() while the PCI thread starts its own remove_adev(). 
> 
> In v2 I ll serialize them with flag + flush pattern.
> 
> void mana_rdma_remove(struct gdma_dev *gd)
> {
> [....]
>         WRITE_ONCE(gd->rdma_teardown, true);   /* block new events      */
>         flush_workqueue(gc->service_wq);       /* wait running worker   */
> 
>         if (gd->adev)
>                 remove_adev(gd);
> 
> [....]
> }
> i.e. during teardown, we stop the producer and drain the queue
> 
> and,
> 
> static void mana_handle_rdma_servicing(struct work_struct *work)
> {
> [....]
> 	if (READ_ONCE(gd->rdma_teardown))
> 		goto out;
> [.....]
> }
> The flag blocks any new work, and flush_workqueue() waits for anything already running. This serialises the two paths and removes
> the race you pointed out.

Yes, I also think that it solves, so let's post v2 please.

Just remember that WRITE_ONCE/READ_ONCE is not a replacement for locks.

Thanks

> 
> Shiraz
> 

