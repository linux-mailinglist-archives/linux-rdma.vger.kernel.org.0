Return-Path: <linux-rdma+bounces-7413-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD10A283E2
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 06:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA68A1886428
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 05:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5048421D5BC;
	Wed,  5 Feb 2025 05:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VnxF8yfp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEE021506B;
	Wed,  5 Feb 2025 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738734632; cv=none; b=ohug5YAzjYYKSWJKdJBUoDhY4xWjCT6BNlsayhyxrA7b4juRjknqlCgjiTrECo9ycAASsT/yIeYZLdMqcRoigCsiGrjls4z+tu5OX5Jr3o3tHQpWq6PK+bxgJjnRxkf9M7JFOy62dhC+/j9Yu+ebIn/DIQln4tldZ7P1I1KWQhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738734632; c=relaxed/simple;
	bh=xe0fRlWJcvNKZpFORw9JQCfHJsrZcCExU2zO8oKVkjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwtaMdApQlGvp6zqRvJH7PVqiSp0zOhLCyAFgLwmX/gwjauEYRH7Usw7SSVQ4YTMZHQAxZRmkT6L1P0XxMlvLxZCO4JyeSGIAzJ5P3yOeHs6z+nqYii7byXBDxUKCLAn4mvmx77RTHFPuU5obcvTPDs/gGIbS3ARlns0hfDAd8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VnxF8yfp; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738734631; x=1770270631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xe0fRlWJcvNKZpFORw9JQCfHJsrZcCExU2zO8oKVkjY=;
  b=VnxF8yfpnuNnJQxHUSlZ9u9ksEFAcMYKSuHEB4WZKMpyRYPzYwnffGi0
   SaugqTEFaCewlheTVohNK8PKeTyTIyXuw/MOrLH6MAW0mHlUuSk+OdjHB
   7S174K+7coHp7aJ4cqbHT/FX17sydXN8T9MPaWGqwUYJCJhiB2RrtMxLu
   XE6bfVYFmnAShbu1K6JfnYD0j9pg5zrw8SDNnFeNkaUclqUG/KtCh1jPv
   3utcdSOSfBFJl87ekDoglfj61SvmJRTqhWsdBueJOhQo0R4KlmSAIx8OJ
   bgecrXQZGesTvb9kDK2o04Ywlos26mupgpmyPhL6YGzseEVFkP6uVStFM
   g==;
X-CSE-ConnectionGUID: s5/uBzp8Ss6fUcglXk7aNg==
X-CSE-MsgGUID: ZQXcJdVTSn2nGLySkgvwtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39171976"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="39171976"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 21:50:28 -0800
X-CSE-ConnectionGUID: 0HjGmAyvQSCEXREvnHBzjA==
X-CSE-MsgGUID: WxvgcWKHQAqFr0FjuSAHnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="141664236"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 21:50:22 -0800
Date: Wed, 5 Feb 2025 06:46:53 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
	netdev@vger.kernel.org, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, pio.raczynski@gmail.com,
	konrad.knitter@intel.com, marcin.szycik@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com, przemyslaw.kitszel@intel.com,
	jiri@resnulli.us, horms@kernel.org, David.Laight@aculab.com,
	pmenzel@molgen.mpg.de, mschmidt@redhat.com,
	tatyana.e.nikolova@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 2/9] ice: devlink PF MSI-X max and min parameter
Message-ID: <Z6L7Tc/PHmCptobX@mev-dev.igk.intel.com>
References: <20250203210940.328608-1-anthony.l.nguyen@intel.com>
 <20250203210940.328608-3-anthony.l.nguyen@intel.com>
 <20250204143518.1583217e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204143518.1583217e@kernel.org>

On Tue, Feb 04, 2025 at 02:35:17PM -0800, Jakub Kicinski wrote:
> On Mon,  3 Feb 2025 13:09:31 -0800 Tony Nguyen wrote:
> > +	if (val.vu32 > pf->hw.func_caps.common_cap.num_msix_vectors ||
> > +	    val.vu32 < pf->msix.min) {
> > +		NL_SET_ERR_MSG_MOD(extack, "Value is invalid");
> > +		return -EINVAL;
> 
> > +	if (val.vu32 < ICE_MIN_MSIX || val.vu32 > pf->msix.max) {
> > +		NL_SET_ERR_MSG_MOD(extack, "Value is invalid");
> > +		return -EINVAL;
> 
> Please follow up and either remove these extack messages, or make them
> more meaningful. The "value is invalid" is already expressed by EINVAL

Will be removed.

> 
> The suggestion to set the values at once or as "pending" is a
> distraction IMO.

