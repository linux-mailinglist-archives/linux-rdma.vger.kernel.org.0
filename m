Return-Path: <linux-rdma+bounces-9136-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3166DA7A103
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 12:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306611894A83
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 10:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8EA24BBE9;
	Thu,  3 Apr 2025 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqGQ8U7D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4659524BBE1
	for <linux-rdma@vger.kernel.org>; Thu,  3 Apr 2025 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743676238; cv=none; b=lfN8hpKls4E7ZHp9JdqWen2JqVne+Z7PsT2Tqz9mBmLgCpkJFRA7ZHRyvmHfBL+TqDrnyJtUoRliUTu2kaYalEQbPNB3osiHv7b6dCrQndaahFeGUP5TKjL4DO8VUzlOICxX5VGrh54AS8DxpzaFQcw5GSoi1/HlewxEUvmbbs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743676238; c=relaxed/simple;
	bh=oh99bQCX6frHKjvRrQLi4wbhUEWe/LYZdZ/nqNKyxOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbH0qyseoSYqqOYIeiWPKOofGSPNSVbHXH7aEn/AECxZ1R0Pjy0XiC0xkgqH3CG704eKfgrlbXgF4UYNU2Pgv8q239AYwGyAiqajiaewQkmCs3TL60k3KubTk2KQOvBLmtyjnvX3H7MEYu7OsSuEdTm4dfcIQbDGpKaIU5LDFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqGQ8U7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CCAC4CEE3;
	Thu,  3 Apr 2025 10:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743676237;
	bh=oh99bQCX6frHKjvRrQLi4wbhUEWe/LYZdZ/nqNKyxOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqGQ8U7DhyIyBaWq2agvwlxumXfbWI5MNqCWKAlXoi3kC60eyz911LCI11xfIbUys
	 WaYvdy1csXNBtlRWtTDNwfQyjZ7k+3uOt+nGCBQm6hL5+bAe5FTYBumhuLb2YvN9XT
	 KYnMCOEHGT6hlrEbCOP7e5j3E2yLFZyKfPMS2nH2ZJCcz/+SAGvBm1ziDd+Wf6L20s
	 4fJe0av0Ty3rON1kuPt6thguTlRAynTCjTNjA3rFJEr3KU0eYkGakF+oYsJtJRiMcz
	 n1+KRmhFoq9AInGSJ15jz5z3ZKfosFYE7ZCdYOI6XesXjzNSSFzlIKGsDstWNqezoq
	 +/uY25zfMfvMQ==
Date: Thu, 3 Apr 2025 13:30:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Silence oversized kvmalloc() warning
Message-ID: <20250403103032.GH84568@unreal>
References: <c6cb92379de668be94894f49c2cfa40e73f94d56.1742388096.git.leonro@nvidia.com>
 <20250319172349.GM9311@nvidia.com>
 <20250326105854.GB4558@unreal>
 <20250331174524.GA291154@nvidia.com>
 <a066aa6e-ff4d-4043-a963-52ce83aaf111@app.fastmail.com>
 <20250401163504.GA325092@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401163504.GA325092@nvidia.com>

On Tue, Apr 01, 2025 at 01:35:04PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 31, 2025 at 10:04:05PM +0300, Leon Romanovsky wrote:
> > 
> > 
> > On Mon, Mar 31, 2025, at 20:45, Jason Gunthorpe wrote:
> > > On Wed, Mar 26, 2025 at 12:58:54PM +0200, Leon Romanovsky wrote:
> > >> On Wed, Mar 19, 2025 at 02:23:49PM -0300, Jason Gunthorpe wrote:
> > >> > On Wed, Mar 19, 2025 at 02:42:21PM +0200, Leon Romanovsky wrote:
> > >> > > From: Shay Drory <shayd@nvidia.com>
> > >> > > 
> > >> > > syzkaller triggered an oversized kvmalloc() warning.
> > >> > > Silence it by adding __GFP_NOWARN.
> > >> > 
> > >> > I don't think GFP_NOWARN is the right thing..
> > >> > 
> > >> > We've hit this before and I think we ended up adding a size limit
> > >> > check prior to the kvmalloc to prevent the overflow triggered warning.
> > >> 
> > >> The size check was needed before this commit was merged:
> > >> 0708a0afe291 ("mm: Consider __GFP_NOWARN flag for oversized kvmalloc() calls")
> > >> 
> > >> From that point, the correct solution is simply provide __GFP_NOWARN flag.
> > >
> > > I'm not sure, NOWARN removes all warnings, even normal OOM warnings
> > > from regually sized allocations which we don't want to remove.
> > 
> > I disagree, this allocation is called from user space. We can safely
> > skip OOM messages and error here will be enough.
> 
> That is not the standard, we OOM splat on all userspace allocations
> too.
> 
> GFP_NOWARN is supposed to be used in cases where the OOM has a
> recovery and nothing will fail.

NULL returned back to the user is best way to recover.

> 
> I think the right thing here is to limit the size, though I'm not
> really sure what the limit should be.

And I still think that NOWARN is the best solution here.

Thanks

> 
> Jason

