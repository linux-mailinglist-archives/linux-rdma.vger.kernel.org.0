Return-Path: <linux-rdma+bounces-8966-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E32A71529
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 11:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E297A3AF7
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 10:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F70F1B412B;
	Wed, 26 Mar 2025 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6/ZrvzU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C293A22F01
	for <linux-rdma@vger.kernel.org>; Wed, 26 Mar 2025 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742986742; cv=none; b=EDEzVnX/RXfif90mDjuz72AdAmNM1DxUgOs7ytCoC4lW7kewEwi/MgmcWyamTHWeyWoulfXh6Wp5jkuUbRE/o4D/88f5/9Oy1sZG9kXu4NJtkskpqxuAHUU98NWMwa+zOiSx4E6UL6rYRBWP5Bh6YPXixPp1rbASKWocDTpjCMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742986742; c=relaxed/simple;
	bh=Ocui/tHPBO7JZAvTqkTFS6zAtewqIGiaTZKQmfTwCG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ek6781cVo1WqqiXm+159SoD8gnnwikkTRllvtS85Jp5Ns/tKooOdkcvpqaNl7FsTzHj5BwreTSuasEmudFh188jY1Tvizf+rmyUliujElpSDOYB35Hx/DA0JCyPcM5V6Me+Cxaxe7cFxeA2nbtXiO4rWqGI426EGpqFJ2lrNVwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6/ZrvzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0D2C4CEEA;
	Wed, 26 Mar 2025 10:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742986742;
	bh=Ocui/tHPBO7JZAvTqkTFS6zAtewqIGiaTZKQmfTwCG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6/ZrvzUlfcZW0Oj72eD/f/E0oHuwGfiGfXfgHd9UivF3IPU/RivAhApWTMMnFZ+q
	 KdM0oh+gFC17TVF6o3U1Qbb+6+DSx0VL5E0lVB3t0EYOGRE3SVYJq+NBZyC3GU+zma
	 KHW6YAF7vLupopLdUBEmLt8jlzRDeaLICdop2NxtXUpRs5fXmkIbwszqVfeBi2e4ep
	 KLiDlhpEVAArMwe+OXBesYbHFN2FdcLiRI3eht1qCMsm5NSUmKInkU7+iMxlryThAQ
	 BfauVdq38lrIn6FEwxeXyi1SuupL+U4MbBmAw87SncojVpiHAPqrbyCfItRIdh+1Uf
	 YCTiB+HE4QTbg==
Date: Wed, 26 Mar 2025 12:58:54 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Silence oversized kvmalloc() warning
Message-ID: <20250326105854.GB4558@unreal>
References: <c6cb92379de668be94894f49c2cfa40e73f94d56.1742388096.git.leonro@nvidia.com>
 <20250319172349.GM9311@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319172349.GM9311@nvidia.com>

On Wed, Mar 19, 2025 at 02:23:49PM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 19, 2025 at 02:42:21PM +0200, Leon Romanovsky wrote:
> > From: Shay Drory <shayd@nvidia.com>
> > 
> > syzkaller triggered an oversized kvmalloc() warning.
> > Silence it by adding __GFP_NOWARN.
> 
> I don't think GFP_NOWARN is the right thing..
> 
> We've hit this before and I think we ended up adding a size limit
> check prior to the kvmalloc to prevent the overflow triggered warning.

The size check was needed before this commit was merged:
0708a0afe291 ("mm: Consider __GFP_NOWARN flag for oversized kvmalloc() calls")

From that point, the correct solution is simply provide __GFP_NOWARN flag.

Thanks

> 
> Jason
> 

