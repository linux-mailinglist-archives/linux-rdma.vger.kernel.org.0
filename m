Return-Path: <linux-rdma+bounces-7682-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF09A3284D
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 15:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6DA1888CD4
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 14:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC89A20FA9D;
	Wed, 12 Feb 2025 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpswTMVx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41D920ADE6;
	Wed, 12 Feb 2025 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370188; cv=none; b=d6x9WVN77yc7NHfE5NXUhMXUArHqbxAqf//rsv06v5a8KiXe/+zdAgP4ctqUapXP1yJ4xIuB7YCvrqub2VCkpKFXMlc2KjEXhOwHhxsCSezG/AvHMHa72ohUKypecJ3i1+1oUaWUTL4MRHYhTj8P1Tg44qiRa4EbkEusJfC73Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370188; c=relaxed/simple;
	bh=UHYcFLxxEEHdO10wGfqqdPYvhzrrTW0umhuEmO4GpBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9vZm+PpFgCVBmjeowglIT1Hetjn7Wf4xfq9MqSwQ23sWE/WxYzFJNKMzxL7dD942jMNSm/cF6nBrO9dnBWJrywViLcEBfYqhEtJ/ThaYB0QwdSonI4lhtZAl4F2if672sYx36m3oL+P3q+yt0eCOczCyFucfuuAp5JaLbZ9qao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpswTMVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6255AC4CEDF;
	Wed, 12 Feb 2025 14:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739370188;
	bh=UHYcFLxxEEHdO10wGfqqdPYvhzrrTW0umhuEmO4GpBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kpswTMVxy1TqQQAQDdvsQ4XxIlpPFCUTmB+IVQCFUFux0+BujXkCE8YOlPVTTCGuX
	 4xDuCW3ixj0geQ/vNUJMZljDLLtYisl8I2QUWtnioBbBY6f5X/peXU7h9THxliUvps
	 tcBVd0y9SLqDKCslej6uvrfzCsJfouaoZvoKu1pF7yaMPfrIMF8dBV8LI1+tx7J+Ho
	 KSWvBhq2Zns0D8GK4GegTdeAvFRAoMx7Ru80ihJuE9+kOPS520/rj8pywteZjccwL7
	 7WVO6Bpk/qcq+JQ0ZEkQ+0E2TroawKKgTScDZv7D6eAr+3msT/Km+nUsKoVqPzycpN
	 0ytQUs/A7WLmQ==
Date: Wed, 12 Feb 2025 16:23:03 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>, jgg@nvidia.com,
	andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
	dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
	dave.jiang@intel.com, dsahern@kernel.org, gospo@broadcom.com,
	hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com,
	kuba@kernel.org, lbloch@nvidia.com, saeedm@nvidia.com,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, brett.creeley@amd.com
Subject: Re: [RFC PATCH fwctl 5/5] pds_fwctl: add Documentation entries
Message-ID: <20250212142303.GI17863@unreal>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-6-shannon.nelson@amd.com>
 <20250212125149.00004980@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212125149.00004980@huawei.com>

On Wed, Feb 12, 2025 at 12:51:49PM +0000, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 15:48:54 -0800
> Shannon Nelson <shannon.nelson@amd.com> wrote:
> 
> > Add pds_fwctl to the driver and fwctl documentation pages.
> > 
> > Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> > ---
> >  Documentation/userspace-api/fwctl/fwctl.rst   |  1 +
> >  Documentation/userspace-api/fwctl/index.rst   |  1 +
> >  .../userspace-api/fwctl/pds_fwctl.rst         | 41 +++++++++++++++++++
> >  3 files changed, 43 insertions(+)
> >  create mode 100644 Documentation/userspace-api/fwctl/pds_fwctl.rst

<...>

> > +========
> > +
> > +The PDS Core device makes an fwctl service available through an
> > +auxiliary_device named pds_core.fwctl.N.  The pds_fwctl driver binds
> > +to this device and registers itself with the fwctl bus.  The resulting
> > +userspace interface is used by an application that is a part of the
> > +AMD/Pensando software package for the Distributed Service Card (DSC).
> 
> Jason, where did we get to on the question of a central open repo etc?

I created organization for it https://github.com/linux-fwctl/ and will
transfer to anyone who will work on it.

Thanks

