Return-Path: <linux-rdma+bounces-7780-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F060BA373ED
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Feb 2025 12:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0A61891181
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Feb 2025 11:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FE518DB08;
	Sun, 16 Feb 2025 11:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ4e+pxr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF723179A3;
	Sun, 16 Feb 2025 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739704686; cv=none; b=q3/FFkf+Pw/cFSCt4iBHQP4ZzQIboSzydTZojmFDeYEHN85mHDZxi/W921ZOUlH6l2XBmkSKHSgb7HJrtE+H6ztxEF8GZB6VS3GNVFI69V/XW0exoZEBihUXS8K4ACVBHEFwns111DV771xnNH2bvJW1ZC95C43qbgcpmaLlSnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739704686; c=relaxed/simple;
	bh=7nH4Wr68d+twhepsFkEUe2orfwSb8C//jA3dTUoGGCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIW+UB8bAVqlbEAWK4RCTUFOA9YTC5cN4WlZrrYFacoz0T8TOTNIQGfnZXw5JkLs1e4LnR+edIZqLMexiPXv6iAQ0cAJc4DBE0hoWJ3/H+bHznvvI3R30brsb6AFEj75rjpMUnq+/mlc2DLKEoCPELqXMc3YSC0HA/PFQYuATKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ4e+pxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B1FC4CEDD;
	Sun, 16 Feb 2025 11:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739704686;
	bh=7nH4Wr68d+twhepsFkEUe2orfwSb8C//jA3dTUoGGCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQ4e+pxrQj8KTZuBSDxk3NxlQsH6xPHxgZcZY3oM/kJLo8IEWhtLcclZKdw7qcEfd
	 zpL8EOaBjfpXGikWyKskUgappitn5EI2YjjOwKDId80Ui1/ZrWmacbCldvXyzfTdjO
	 7EMwM7q/ZWKEdSck220fovQzIHFh4+DNZusEyJAQaqjOj9oCVjSBJf88TfSTt1LCib
	 9h5ZjF87V+f565R19saocZm2ZJFfneeCK3n7wEVgqtqn/XjKPpYuPUtIWnV2qtlNNJ
	 SnMz8KJSgNyZUnnfm6U/eJpmPnRjUOGrpmrWxV/q8iDo/D4sT3v++5f7ncSOoB2e+a
	 Ii9Dl4XEj43dA==
Date: Sun, 16 Feb 2025 13:18:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Tatyana Nikolova <tatyana.e.nikolova@intel.com>, jgg@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [iwl-next,rdma v3 00/24] Add RDMA support for Intel IPU E2000
 (GEN3)
Message-ID: <20250216111800.GV17863@unreal>
References: <20250207194931.1569-1-tatyana.e.nikolova@intel.com>
 <7e12c97d-8733-44df-b80e-2956c0e59dae@intel.com>
 <20250210110935.GE17863@unreal>
 <f253c4b6-e4ee-44a3-953d-44f20ac5e79d@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f253c4b6-e4ee-44a3-953d-44f20ac5e79d@intel.com>

On Thu, Feb 13, 2025 at 05:12:46PM +0100, Przemek Kitszel wrote:
> On 2/10/25 12:09, Leon Romanovsky wrote:
> > On Mon, Feb 10, 2025 at 11:41:31AM +0100, Przemek Kitszel wrote:
> > > On 2/7/25 20:49, Tatyana Nikolova wrote:
> > > > This patch series is based on 6.14-rc1 and includes both netdev and RDMA
> > > > patches for ease of review. It can also be viewed here [1]. A shared pull
> > > > request will be sent for patches 1-7 following review.
> > > > 
> > > 
> > > [...]
> > > TLDR of my mail: could be take 1st patch prior to the rest?
> > > 
> > > > V2 RFC series is at https://lwn.net/Articles/987141/.
> > > 
> > > code there was mostly the same, and noone commented, I bet due
> > > to the sheer size of the series
> > 
> > It was very optimistic to expect for a review during holiday season
> > and merge window, especially series of 25 patches which are marked
> > as RFC.
> 
> that's true
> 
> so, given most of the patches will go via your tree, how do you want
> to split us the existing ones into series?
> 
> a) 1st, idpf, rdma
> b) 1st, rest
> c) all together
> 
> In any case I will do a review too of course

There is a need to get Acks for the netdev part and because that part is
going to be before RDMA patches, the fist option is proffered one.

If you plan to merge everything in this cycle, netdev and RDMA parts need
to be merged into some shared branch based on clean -rcX.

I can do it for you as well, but first need to get Acks for netdev part.

Thanks

> 
> > 
> > Thanks
> 
> 

