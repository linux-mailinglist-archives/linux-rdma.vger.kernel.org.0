Return-Path: <linux-rdma+bounces-3052-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE72B903DD4
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 15:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3872A28197A
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 13:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1946617D357;
	Tue, 11 Jun 2024 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gFUo5a5V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2B717BB35;
	Tue, 11 Jun 2024 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113460; cv=none; b=jlpXlcMrlTQehkBw6c8Bod+XItxDw+JoZM+NPWC0AH8dje9V1KqG8pnJyd8ZPH3f3YxkpysgT9bCHIXtGAipoc1c9PGkA0h/lNIDlf/AlQrY5rVU3Lka4/ZY27qEfy2keEF+cBBimUkBJq2GIcqFQ2UHeHh36/sIbDHOg6JQgR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113460; c=relaxed/simple;
	bh=EQYSCqQXeZZSe0ClprwCP48eVWRMSRk0A6GlSCKcSkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+qAGPof3TKHJk/JUwWl1VTCeOLdppCDpLMoTEKX35TJ2ZjOCea1PPhX6Wan5wVZzgfmnhQEF6jbXY1Tl/s9jYLP3PNqmQuUO/hg52vt3blULdxB6nlQvHKIkTt/K8vMtgitWtwCd3Pm6sL/P1fdIHVvufKuEYnYbeId6W6JnLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gFUo5a5V; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718113459; x=1749649459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EQYSCqQXeZZSe0ClprwCP48eVWRMSRk0A6GlSCKcSkc=;
  b=gFUo5a5V1GnX2XydgU5zF7EYC/KWkEQqcrVQid5phQOMglvU7IXa9vV9
   udhVO/d6pGtMN6wkq+2qMu5mnyXBjF8np/hVcPWC2A43EZ4o78GuMrwXG
   fQaclTvySDKjfYNL4CQ9+caTVUMiw2BWDijIoVhLnELhkdXmdr4b3hVTb
   Cm77W4gso9l1jULWdT1nnRe3/Gpgz0Zv3VhoJnDzxENz7Ao+MELfuemUI
   8HvIEJ6P/o4s/edanLLbwngG4+9U5oIdfIJyBPeGFWZxnLMjmt8NuRDjO
   64YwA2srN9hY0IroYs75zz2VRSIeuFo/p2Eai7s9Kmf68D+7wVCvoAXzi
   A==;
X-CSE-ConnectionGUID: UAOWDUvCTvGumurKBIdWWg==
X-CSE-MsgGUID: Fcg0EAiuQKGcv9F+EzxMmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14622283"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="14622283"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 06:44:18 -0700
X-CSE-ConnectionGUID: Q0NPPKiNQ7ane9wZalYhdQ==
X-CSE-MsgGUID: U69eDlhwT8qu912gTuRt5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39373309"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 06:44:11 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id CFDB711F855;
	Tue, 11 Jun 2024 16:44:07 +0300 (EEST)
Date: Tue, 11 Jun 2024 13:44:07 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <ZmhUp-UclZkvQLqE@kekkonen.localdomain>
References: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611130103.3262749-7-gregkh@linuxfoundation.org>

Hi Greg,

On Tue, Jun 11, 2024 at 03:01:04PM +0200, Greg Kroah-Hartman wrote:
> In the quest to make struct device constant, start by making
> to_auziliary_drv() return a constant pointer so that drivers that call

s/z/s/

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com> # drivers/media/pci/intel/ipu6

> this can be fixed up before the driver core changes.
> 
> As the return type previously was not constant, also fix up all callers
> that were assuming that the pointer was not going to be a constant one
> in order to not break the build.

-- 
Kind regards,

Sakari Ailus

