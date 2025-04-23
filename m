Return-Path: <linux-rdma+bounces-9743-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C116A994BF
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 18:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93F416931B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 16:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DAF242D64;
	Wed, 23 Apr 2025 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzl9HJgs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988D1A5B82;
	Wed, 23 Apr 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745424870; cv=none; b=kd591qgEN5PzYPBKOXWJfzLjLq2kGu6wk5eFF7ES8MDEJHTWPq00mAH9YFk7wBiVnIKoq/6zC5c2arUx5naQTJbuTTDCrdNSOoefR86NLDYINQTEk1yNC0gJemlxrwHENL9F+Am/i5drexPmrs5grV0Z4eGdhPtRDF0PsNffN1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745424870; c=relaxed/simple;
	bh=Z/4DmM8gueZBF5pkQ33eV/TOGnbp2ifSLowAhDlqItU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMhc9H+ESsqLMNJoAO35Zu9rNPiQ5J3VBREBM72fH67TxFOcHKhi6/ncLJqj4YqOMFRVh+Yit20ZHw6XXDd1x418JBEzLBdekndzOREW/TQPwpyx9geKu1ORXc3Ohd60oBLJq2cc5CobmcYkNnVExNFEF9Z8unMKuCw2y6gnF/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzl9HJgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3FDC4CEE2;
	Wed, 23 Apr 2025 16:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745424869;
	bh=Z/4DmM8gueZBF5pkQ33eV/TOGnbp2ifSLowAhDlqItU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rzl9HJgsjiv6OYRiFt5O2M0ta6p8Ba77FyXKYN2G+cx5d/s5boXYxcdHFaeuOgmyt
	 6I19ywl2bpMIKMIuH6g/GCL3Q4vlp4avUahDcq8p04KXmOYsa9LWESKzUxgswLn5eQ
	 iwM9/QtSrE3MjM2UYlUzaau1gdcQ+2pkFhsBxN4mKvKofdnyr+MWLtkT1g7sIuQeGJ
	 UiTSV6ZIoJ2lG9f0bGah41y6kr+oQxcbfVPLFWaw34SMT9KuHpSCDUW7raJZo0k1Ab
	 xaMc4diV6LsDmovTDwWNifJRz7+kWEHsA4thtGUp/yf3zXdVl9AexBTHSVVfLDFZDH
	 Q9HaurUSXyKwA==
Date: Wed, 23 Apr 2025 17:14:25 +0100
From: Simon Horman <horms@kernel.org>
To: "Ertman, David M" <david.m.ertman@intel.com>
Cc: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [iwl-next v5 5/5] iidc/ice/irdma: Update IDC
 to support multiple consumers
Message-ID: <20250423161425.GA2843373@horms.kernel.org>
References: <20250416021549.606-1-tatyana.e.nikolova@intel.com>
 <20250416021549.606-6-tatyana.e.nikolova@intel.com>
 <20250417112143.GE2430521@horms.kernel.org>
 <IA1PR11MB6194FD66BA60E12D6430DF22DDBF2@IA1PR11MB6194.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB6194FD66BA60E12D6430DF22DDBF2@IA1PR11MB6194.namprd11.prod.outlook.com>

On Fri, Apr 18, 2025 at 05:14:24PM +0000, Ertman, David M wrote:
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> > Simon Horman
> > Sent: Thursday, April 17, 2025 4:22 AM
> > To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> > Cc: jgg@nvidia.com; leon@kernel.org; intel-wired-lan@lists.osuosl.org; linux-
> > rdma@vger.kernel.org; netdev@vger.kernel.org
> > Subject: Re: [Intel-wired-lan] [iwl-next v5 5/5] iidc/ice/irdma: Update IDC to
> > support multiple consumers
> > 
> > On Tue, Apr 15, 2025 at 09:15:49PM -0500, Tatyana Nikolova wrote:
> > > From: Dave Ertman <david.m.ertman@intel.com>
> > >
> > > In preparation of supporting more than a single core PCI driver
> > > for RDMA, move ice specific structs like qset_params, qos_info
> > > and qos_params from iidc_rdma.h to iidc_rdma_ice.h.
> > >
> > > Previously, the ice driver was just exporting its entire PF struct
> > > to the auxiliary driver, but since each core driver will have its own
> > > different PF struct, implement a universal struct that all core drivers
> > > can provide to the auxiliary driver through the probe call.
> > >
> > > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> > > Co-developed-by: Mustafa Ismail <mustafa.ismail@intel.com>
> > > Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> > > Co-developed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> > > Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> > > Co-developed-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> > > Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > > index fcb199efbea5..4af60e2f37df 100644
> > > --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > > @@ -1339,8 +1339,13 @@ ice_devlink_enable_roce_get(struct devlink
> > *devlink, u32 id,
> > >  			    struct devlink_param_gset_ctx *ctx)
> > >  {
> > >  	struct ice_pf *pf = devlink_priv(devlink);
> > > +	struct iidc_rdma_core_dev_info *cdev;
> > >
> > > -	ctx->val.vbool = pf->rdma_mode & IIDC_RDMA_PROTOCOL_ROCEV2
> > ? true : false;
> > > +	cdev = pf->cdev_info;
> > > +	if (!cdev)
> > > +		return -ENODEV;
> > 
> > Is it possible for cdev to be NULL here?
> > 
> > Likewise for other checks for NULL arguments passed to functions
> > elsewhere in this patch.
> 
> Hi Simon,
> 
> In the resume path from Sx states it is possible to have a NULL pointer for
> the cdev_info pointer.  This is due to us not wanting to fail on resuming unless
> absolutely necessary.  I went through the rest of the patch looking for NULL checks
> and all of them are valid from my inspection (possible to be NULL).
> 
> Thanks for the review!

Likewise, thanks for checking.

