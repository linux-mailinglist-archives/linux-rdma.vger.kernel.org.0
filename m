Return-Path: <linux-rdma+bounces-3074-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E6F904DF7
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 10:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D980B28744D
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 08:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2C616D30E;
	Wed, 12 Jun 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LninAheT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA816C86C;
	Wed, 12 Jun 2024 08:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180436; cv=none; b=Kx9ZRdxaHZJA+pdk8Y1Uem/aRQhAtMX7mbZRWEp12W3AECaiKhh7TEcaJbwmUYQtGKjAgRmU7lEJ0GMuHdnaEySJUyYY+5ZauIuUht18usD12psufjqHJ9oKjBfLnI5CjkYIN9f0Vopl7lfg1O+tNpklmaov4LaR1DeBeX7rfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180436; c=relaxed/simple;
	bh=nqkRr3hEqhXfpawRBXQoqriQ7Yorslv65k57UzVvhMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndhDGwryhcP6JskcsjzQKqxB4UzN3KBnwZfiTLn2FMXyDLf+RSYzYGue5q7rRO1EEMu+v5AUp/vgUEFxkbA+geOPj3OuhAj39Gyp96w69eJ4TrdxoeBfemEwt6AHAiW2MDtgTkfnAEQ2aOWsU0I0JYppyX+sQYjlJ/6yg6UKc+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LninAheT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FD2C3277B;
	Wed, 12 Jun 2024 08:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718180436;
	bh=nqkRr3hEqhXfpawRBXQoqriQ7Yorslv65k57UzVvhMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LninAheT/igtgi3vHkFPND6tsxz+KJap4+LsnQLQqKJfSEAGbdKfNRrZfPkYGZsCQ
	 eOoauin7ReKXi46V47zU/pkO03GoeBhl8VvbU5Qni1cpAIgOGKDcqzaml2fAY6oYFa
	 WZ0eDzahLSSVyRCI998EnVMZuu99SvU6wkuju9z8=
Date: Wed, 12 Jun 2024 10:20:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 1/6] auxbus: make to_auxiliary_drv accept and return a
 constant pointer
Message-ID: <2024061212-excusable-dissuade-379b@gregkh>
References: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
 <d2ffbc2d-0966-4210-a5d0-719c27d9adb1@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2ffbc2d-0966-4210-a5d0-719c27d9adb1@intel.com>

On Tue, Jun 11, 2024 at 03:50:47PM +0200, Przemek Kitszel wrote:
> On 6/11/24 15:01, Greg Kroah-Hartman wrote:
> > In the quest to make struct device constant, start by making
> 
> just curious, how far it will go? eg. do you plan to convert
> get/put_device() to accept const?

Ugh, that should have said "in the quest to make struct device_driver
const", not device.  devices obviously can't be constant everywhere as
they are dynamically created.

> or convert devlink API to accept
> consts?

Again, sorry, no, typo on my part.

> 
> > to_auziliary_drv() return a constant pointer so that drivers that call
> 
> typo: s/auz/aux/

I'll fix this typo up, and the one above, when I commit it.

> 
> > this can be fixed up before the driver core changes.
> > 
> > As the return type previously was not constant, also fix up all callers
> > that were assuming that the pointer was not going to be a constant one
> > in order to not break the build.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> 
> [...]
> 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > index 0f17fc1181d2..7341e7c4ef24 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > @@ -2784,7 +2784,7 @@ static struct ice_pf *
> >   ice_ptp_aux_dev_to_owner_pf(struct auxiliary_device *aux_dev)
> >   {
> >   	struct ice_ptp_port_owner *ports_owner;
> > -	struct auxiliary_driver *aux_drv;
> > +	const struct auxiliary_driver *aux_drv;
> >   	struct ice_ptp *owner_ptp;
> >   	if (!aux_dev->dev.driver)
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
> > index 47e7c2639774..9a79674d27f1 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
> > @@ -349,7 +349,7 @@ int mlx5_attach_device(struct mlx5_core_dev *dev)
> >   {
> >   	struct mlx5_priv *priv = &dev->priv;
> >   	struct auxiliary_device *adev;
> > -	struct auxiliary_driver *adrv;
> > +	const struct auxiliary_driver *adrv;
> 
> nit: in netdev we do maintain RCT order of initialization

what does that mean?  Nothing is being initialized here.

thanks,

greg k-h

