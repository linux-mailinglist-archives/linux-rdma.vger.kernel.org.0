Return-Path: <linux-rdma+bounces-8298-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2DCA4D964
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 10:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 847DD7A24B3
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 09:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92651FCFE6;
	Tue,  4 Mar 2025 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ps19xneF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE92A1FCFCC;
	Tue,  4 Mar 2025 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082163; cv=none; b=iklqVengusQBaCe3m+vOcLg9YkfCoUT2E80OrYnJ2aP3Lg8qFn2BVslNOIa+bnwrgPViETlMnawTcX4bFmvZLCbYpyYbVBNZvZ6jheQTQ7IqD5g4U/Y03bK0ihHga4+eSZnADfAom7vruRlVvFa0EfrywA35vES25EBd3gd3xXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082163; c=relaxed/simple;
	bh=o51jYiIjJ7Hl+a6ZtvtnyQKJHKFVcGivr4VSA+BfR1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9zhnNNVz+ndTDef9LeVdLu42W2s+1YiszfFc/BzbQvFIo2yaJrcYUY/Cyf5vjNm24PNE1EsMGlaJ66zXwDQ5SETZ5hmX0GTLZtmCgts67coIHT8p6CQ6Jhn2qj/R5grOC2nS5xLqEwJ5/jYzQnkh3XIDajkJAw6hK+10ZvAkJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ps19xneF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741082162; x=1772618162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o51jYiIjJ7Hl+a6ZtvtnyQKJHKFVcGivr4VSA+BfR1A=;
  b=Ps19xneF4D3M6cdUHBwSS+SYYl53IciSEvEWKQXVYu3aCDUh3RLnS8QY
   0pe0O5CRMl3UV8eHpPzEUhUu+tfJeALFgFxJIGaoTeuWQtmLBmAE4dhnD
   DYqvCPd0wuXC71RAsfZ9RWeRos8j2IyewvAZSweg/kUCI7UzQeFzIJzio
   qPfHnqhypzE3B5BAFB4A6igpEiOAWw3+eeH+M3toUZLrJAA9dpPsAKE2y
   QyqH+RB4PuBa1LCF90TyZdk9ThVDvY+W3LiEZaWmBDtyM0yylMxsKTsJf
   APiifh0mzdbtmMuVdy92jM8v3vq9Ymy07dHgRmD6J8I36w9YbjsNlBEvh
   A==;
X-CSE-ConnectionGUID: 7pgFDQdxTzmqFAFM+f8FkA==
X-CSE-MsgGUID: FlAd9TfXS0m4fU0rJSW1lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="45767245"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="45767245"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 01:56:02 -0800
X-CSE-ConnectionGUID: 9/id7rMqQ4+3Zhh40VmpKg==
X-CSE-MsgGUID: ljCGWTOARy6fccCifDPeXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118840957"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 01:55:58 -0800
Date: Tue, 4 Mar 2025 10:51:57 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Leon Romanovsky <leonro@nvidia.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/6] net/mlx5e: Properly match IPsec subnet
 addresses
Message-ID: <Z8bNPRtzOBZ7LdGJ@mev-dev.igk.intel.com>
References: <20250226114752.104838-1-tariqt@nvidia.com>
 <20250226114752.104838-7-tariqt@nvidia.com>
 <Z8aw1gn5iFNiSxd3@mev-dev.igk.intel.com>
 <20250304080543.GD1955273@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304080543.GD1955273@unreal>

On Tue, Mar 04, 2025 at 10:05:43AM +0200, Leon Romanovsky wrote:
> On Tue, Mar 04, 2025 at 08:50:46AM +0100, Michal Swiatkowski wrote:
> > On Wed, Feb 26, 2025 at 01:47:52PM +0200, Tariq Toukan wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Existing match criteria didn't allow to match whole subnet and
> > > only by specific addresses only. This caused to tunnel mode do not
> > > forward such traffic through relevant SA.
> > > 
> > > In tunnel mode, policies look like this:
> > > src 192.169.0.0/16 dst 192.169.0.0/16
> > >         dir out priority 383615 ptype main
> > >         tmpl src 192.169.101.2 dst 192.169.101.1
> > >                 proto esp spi 0xc5141c18 reqid 1 mode tunnel
> > >         crypto offload parameters: dev eth2 mode packet
> > > 
> > > In this case, the XFRM core code handled all subnet calculations and
> > > forwarded network address to the drivers e.g. 192.169.0.0.
> > > 
> > > For mlx5 devices, there is a need to set relevant prefix e.g. 0xFFFF00
> > > to perform flow steering match operation.
> > > 
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > > ---
> > >  .../mellanox/mlx5/core/en_accel/ipsec.c       | 49 +++++++++++++++++++
> > >  .../mellanox/mlx5/core/en_accel/ipsec.h       |  9 +++-
> > >  .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 20 +++++---
> > >  3 files changed, 69 insertions(+), 9 deletions(-)
> > > 
> > 
> > [...]
> > 
> > >  
> > > +static __be32 word_to_mask(int prefix)
> > > +{
> > > +	if (prefix < 0)
> > > +		return 0;
> > > +
> > > +	if (!prefix || prefix > 31)
> > > +		return cpu_to_be32(0xFFFFFFFF);
> > > +
> > > +	return cpu_to_be32(((1U << prefix) - 1) << (32 - prefix));
> > 
> > Isn't it GENMASK(31, 32 - prefix)? I don't know if it is preferable to
> > use this macro in such place.
> 
> GENMASK(a, b) expects "b" to be const type, see
> #define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
> 

Sorry, I didn't know that, thanks.

> Thanks

