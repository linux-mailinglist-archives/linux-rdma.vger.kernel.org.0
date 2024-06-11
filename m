Return-Path: <linux-rdma+bounces-3055-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B93903E3E
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 15:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B59A1C256F2
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 13:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0932717E8F4;
	Tue, 11 Jun 2024 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="evsZnex+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE63217D8B5;
	Tue, 11 Jun 2024 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114206; cv=none; b=CE4mCVizb8tP5KXR4Je6S42ICtQKlB8/FmXozr6R7Ih7D2FC4tUg67bu17nOqluXBlGOI9H9esPsMLdn5fVTWXfNkZKTxbwtOTY0XyBBB4LzMgPSV9N+1sCekLG4eVMGq9A0fgzA6r8iudEi8QTcW5ayp8oMhouVBlcbd7QYAyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114206; c=relaxed/simple;
	bh=ArXK0c9vtX+cXd2FYPJx9+fY64OV83XUxatTDVhxFeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExzWPD/YIMkeq7pUAfmtDeUB0m6/98zVkB9gyA1HLuqf21wI5T1e7VsLXKSRmltyRAE0wS+a2mMaZ2J6qJNddKgGa5aEHvLpoBKAJwZd+06lDk8BelrCuCBY4a65yq+l/cYFS+clEwB4xs5MUabK1kAyb/wo/wy+2z/bwv3yXwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=evsZnex+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE98C2BD10;
	Tue, 11 Jun 2024 13:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718114205;
	bh=ArXK0c9vtX+cXd2FYPJx9+fY64OV83XUxatTDVhxFeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evsZnex+0Bp05UmNaZ96IqQ2Cb3uUKm6HvAc73yHVAo+kf3/3ttcxC1QX3kGVxo66
	 SZS1PgoW94tLYneCueGXeuKk7MpXqIv6NpJaWSbRgpvOiwc9Lym4k3bGumJIO77/dF
	 TJW4Gg3In9lW9sYv1/9CYCoX8yqovZ1V6eWh1BZw=
Date: Tue, 11 Jun 2024 15:56:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
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
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 1/6] auxbus: make to_auxiliary_drv accept and return a
 constant pointer
Message-ID: <2024061138-underwire-underwear-a26e@gregkh>
References: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
 <ZmhPnQqYFXWP4heL@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmhPnQqYFXWP4heL@finisterre.sirena.org.uk>

On Tue, Jun 11, 2024 at 02:22:37PM +0100, Mark Brown wrote:
> On Tue, Jun 11, 2024 at 03:01:04PM +0200, Greg Kroah-Hartman wrote:
> > In the quest to make struct device constant, start by making
> > to_auziliary_drv() return a constant pointer so that drivers that call
> > this can be fixed up before the driver core changes.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

thanks for the review.


