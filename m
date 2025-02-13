Return-Path: <linux-rdma+bounces-7736-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51475A34C81
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1441D16BA8C
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 17:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E70241664;
	Thu, 13 Feb 2025 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMazmCV3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6564D23F42D
	for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2025 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469321; cv=none; b=CxsAj7zjYNMjX4s1yo0UMLF4BmiMUNoWnjD2lib/vLRfdtG0+3hKj8QQDD2SHZpLlwPV9pyy7w7Meyqc6NxusWac3zvtw22xaHdSaW3uLlxaCcGiqpOZq/w5ofphK3XsgcVuzwMZd8W/GDFGk0voe6mi9gvy/DlGoOOmQFdgsJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469321; c=relaxed/simple;
	bh=MRK0oXXj65UjUqVTXLxb0tIzFyXDcFDKwQ1s6Y0OLwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=friq87PIIHsaqYJB27+gEzMoBpcOQsYH7KPR3sFWPgbJJemnsU8PuneAMibJGOCk0ozSqmDnScKkBRmnUrKm5ogYRY0cFUue7IUKiEuygL9e2mIX3mNdP6tuqHHVmh1cizsD6zG2Jk9n+h/FDWc1yRTKkc0dbsNNCnyTVB34fLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMazmCV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FD2C4CED1;
	Thu, 13 Feb 2025 17:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739469321;
	bh=MRK0oXXj65UjUqVTXLxb0tIzFyXDcFDKwQ1s6Y0OLwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lMazmCV3IUAMyBxmLkCsssgyxo6siHSx4+FLr6a5TdZQgNuvY2XEpnBQ/TskOzFq0
	 GcvKNhtWQDxsHFjQLTlXql++adGe7btizoBwCneYzzigx++Gyus1qpbK0naztxVAYp
	 NgyZjxaOtdBECr8jlfM/EMhDn8UP6z8h5HymOJY718k0GxRdLnIQdohmYCs/tx8S24
	 z1pAPcAz71+901GGWSM/NgJkmZWS/szEnXZc33C/wd/IlA1+0gzgJV8NtxeU0oPdU3
	 IRM4KqsTdiUJ7VunBn2ye3zyRWXT+SE8H5ZaSQjzDsWrtLh0gX49S3kpxsS/DIuwvT
	 t6fCaUJA/TurA==
Date: Thu, 13 Feb 2025 19:55:17 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Margolin, Michael" <mrgolin@amazon.com>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/core: Fix best page size finding when it
 can cross SG entries
Message-ID: <20250213175517.GP17863@unreal>
References: <20250209142608.21230-1-mrgolin@amazon.com>
 <20250213125126.GK17863@unreal>
 <20250213140421.GZ3754072@nvidia.com>
 <777e5518-3f0a-43e8-b80b-0a3ba4ecf5da@amazon.com>
 <20250213144219.GB3754072@nvidia.com>
 <20250213173510.GO17863@unreal>
 <20250213174043.GG3754072@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213174043.GG3754072@nvidia.com>

On Thu, Feb 13, 2025 at 01:40:43PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 13, 2025 at 07:35:10PM +0200, Leon Romanovsky wrote:
>  
> > Initially curr_base is 0xFF.....FF and curr_len is 0.
> 
> curr base can't be so unaligned can it?

It is only for first iteration where it is compared with
sg_dma_address(), immediately after that it is overwritten.

> 
> > So if this "if ..." is skipped (not possible but static checkers don't know),
> > we will advance curr_len and curr_base + curr_len will overflow.
> > 
> > I don't want to take original patch.
> 
> Subtracting is no better, it will just randomly fail for low dma addrs
> instead of high.

Aren't sg_dma_address placed in increasing order?
If not, whole if loop is not correct.
If yes, we won't see any failures.

> 
> You need to call check_add_overflow()
> 
> Jason

