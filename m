Return-Path: <linux-rdma+bounces-3054-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AEC903E39
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 15:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07B5289FDC
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 13:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FB517E45D;
	Tue, 11 Jun 2024 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kaGvp3xn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D817D88C;
	Tue, 11 Jun 2024 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114196; cv=none; b=QfqrjypcmTAsH3sNpt1EKDX7LkD3Dv7kbczMUMuFcQd6B75QD5rGMEy5EgfEganRbNOuxkgELa84OQPuTlP4dEHB8jmkzUQ9W22hQMJph/0eeguEsGZW5khCW1PNlEu/8MJb+KUue0VUXtpmOsvncl/eZn9XJUFc3sDyN1Sa828=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114196; c=relaxed/simple;
	bh=AzMMWpTTBZJQB1Sti3Hx2aIxr1jFUoxrrZxbpJlwWLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cENKUPdMesLVWCbC2b49yjqIgPC+o9jL/7O2js1HFPg3d8mBy+2lcY7CsAIpaLhNpIDn9gvdceDmX+ntZBvYPf+2fU7gzX84NZRzaA+5jQDt/nsdHz+TE/r/m9mITHI6hOfAq7uknSMneay/id0Oc9tt9XnjJmHgAd7QGeEgIOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kaGvp3xn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C8DC2BD10;
	Tue, 11 Jun 2024 13:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718114196;
	bh=AzMMWpTTBZJQB1Sti3Hx2aIxr1jFUoxrrZxbpJlwWLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kaGvp3xn98pvoMf8thzl6OcKd9guInjdtxXZcUvLZ+WdpCFF7ipgtF8frP2dPjMB1
	 2UMKXeDO/qeXmmZRW+PinxPXHCvmHCadEo/khi4KKI0yFcbzrWpg5U/3JxqfsdQfVa
	 qG0vCVgmhoxkCVVOShkekjx7ssiBOuWQHI5+FfEg=
Date: Tue, 11 Jun 2024 15:56:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <2024061115-aversion-lunchroom-d54c@gregkh>
References: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
 <ZmhUp-UclZkvQLqE@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmhUp-UclZkvQLqE@kekkonen.localdomain>

On Tue, Jun 11, 2024 at 01:44:07PM +0000, Sakari Ailus wrote:
> Hi Greg,
> 
> On Tue, Jun 11, 2024 at 03:01:04PM +0200, Greg Kroah-Hartman wrote:
> > In the quest to make struct device constant, start by making
> > to_auziliary_drv() return a constant pointer so that drivers that call
> 
> s/z/s/

Ah, good catch, I'll fix that up when applying it!

> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com> # drivers/media/pci/intel/ipu6

thanks for the review.

greg k-h

