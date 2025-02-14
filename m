Return-Path: <linux-rdma+bounces-7763-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7ACA356A6
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 06:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271A6188E8C5
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 05:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CFE18A6B2;
	Fri, 14 Feb 2025 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1g2wxVR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ACE2753E8
	for <linux-rdma@vger.kernel.org>; Fri, 14 Feb 2025 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739512516; cv=none; b=nWKs8ZftDNZVE1QI9ICqSNOZ4nmdTXKZxwXcVy1Owz3I2XDarlL2xfbegexlIUobBzAwaviosZm4hJGQVOXD832qGm+BZSYfSBNCZP8O2RX51NIssXiYzlF16JTGlyz9hqlnPAAx9MHIlhmzNdTMAFvx8ErIaa0sHWH28s9Qlco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739512516; c=relaxed/simple;
	bh=ZM9GjUUpwC/dZEHZw92EW03IPAF9X7q1nXcfc+rKDgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAUlN+nAyv6unghbeyZ5/wPGyWuMhStD7YPIKrZ3h5NPtbOdRcNgzKg1UJIjGev2rTy/DcK2T+Q1TZdYCpEpyawAf4VD9c7xekgXNooJbTXE9oDYNB/BXvh4AoVIt2IfFy2Ol0/Wxsm7T43Ir8VvFPwrLu7QMQgo8zourRpzxNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1g2wxVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70106C4CED1;
	Fri, 14 Feb 2025 05:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739512515;
	bh=ZM9GjUUpwC/dZEHZw92EW03IPAF9X7q1nXcfc+rKDgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E1g2wxVRLRFUu6QNAsp0IfJdaexROrY9LikfyKPkdxsCXx94aEBaXaEhoiQkkPkqH
	 8cIK+4hndDBAGVx0bLup0wcWM8XBciWbukpWLW1FnSJF/8/lpN5Up8KP1trRSMt7Fi
	 d4w23sAVjz4a8kftY6O/mYzl9FgextlYkBhUtHl/lCwGrUVG/ojU32QYLrFVMyk7Xh
	 m1lCS+hlzdZ1YuS1s8gvao7QTCQ/zmYoltDBRi7/qVFLDw/5D+kD6j7dgQeG6gSdra
	 uSWhMOKluv6g8tkXcFVkeEOrHINll7lPA7gcEh/PTKy/F9BsnptYHFgs0aK10zXFSW
	 0yxcAVEJCYkMQ==
Date: Fri, 14 Feb 2025 07:55:11 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Margolin, Michael" <mrgolin@amazon.com>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/core: Fix best page size finding when it
 can cross SG entries
Message-ID: <20250214055511.GQ17863@unreal>
References: <20250209142608.21230-1-mrgolin@amazon.com>
 <20250213125126.GK17863@unreal>
 <20250213140421.GZ3754072@nvidia.com>
 <777e5518-3f0a-43e8-b80b-0a3ba4ecf5da@amazon.com>
 <20250213144219.GB3754072@nvidia.com>
 <20250213173510.GO17863@unreal>
 <20250213174043.GG3754072@nvidia.com>
 <20250213175517.GP17863@unreal>
 <20250213181242.GF3885104@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213181242.GF3885104@nvidia.com>

On Thu, Feb 13, 2025 at 02:12:42PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 13, 2025 at 07:55:17PM +0200, Leon Romanovsky wrote:
> > On Thu, Feb 13, 2025 at 01:40:43PM -0400, Jason Gunthorpe wrote:
> > > On Thu, Feb 13, 2025 at 07:35:10PM +0200, Leon Romanovsky wrote:
> > >  
> > > > Initially curr_base is 0xFF.....FF and curr_len is 0.
> > > 
> > > curr base can't be so unaligned can it?
> > 
> > It is only for first iteration where it is compared with
> > sg_dma_address(), immediately after that it is overwritten.
> 
> But this is all working with inherently page aligned stuff, cur_base +
> len1 + len2 + len3 + len_n should be page aligned for interior segments..
> 
> > > > So if this "if ..." is skipped (not possible but static checkers don't know),
> > > > we will advance curr_len and curr_base + curr_len will overflow.
> > > > 
> > > > I don't want to take original patch.
> > > 
> > > Subtracting is no better, it will just randomly fail for low dma addrs
> > > instead of high.
> > 
> > Aren't sg_dma_address placed in increasing order?
> 
> Not necessarily, dma direct produces something random
> 
> > If not, whole if loop is not correct.
> 
> The point is to detect cases where they happen to be in order because
> they were split up due to the 32 bit limit in the sgl.

There is no promise that this split will create consecutive SG entries
and iterator will fetch them in that order too.

This discussion leads me to the understanding that we need to drop the patch.

Thanks

> 
> Jason

