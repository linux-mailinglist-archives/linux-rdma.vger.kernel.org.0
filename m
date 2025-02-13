Return-Path: <linux-rdma+bounces-7732-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A4AA34C2C
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0143AE38F
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 17:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19903203719;
	Thu, 13 Feb 2025 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fzze/nOV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE34720110B
	for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2025 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468114; cv=none; b=pROBCdt3jsuQUwp4GX+pjoU5TMR7eq9N4mSvNy210Yc37b2KZzPYupzcGHSbNjkcSZ4grepJ6Tbs2cWdVvorNj6Cm6pPajhThqF1Wt9E75fMVYImSLJzZfjVIIwKvnpj+BdxWGoG+4E4O43BdtKmlwZ1UftEtMduznEx0yfyWK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468114; c=relaxed/simple;
	bh=JLFwrfWpZc5xCk47qz27X0myO0UmGNxwdmSzSs9+eoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Edo5y6FypLAHUUIe2JwkYIAPThkvKxY50DjrdGw0BVMJeZa89j3bNFqv4Yj0PP3L2ABM9jqONY4+hFFh9yQSW+gUi9tfiUclngcOLJnvb56E2TfPln192M4V1MKgkN9juMvE8vmpr8RuREhiF2kd+vzdtYf6Z8GbcNiyQEL883c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fzze/nOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52C0C4CED1;
	Thu, 13 Feb 2025 17:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739468114;
	bh=JLFwrfWpZc5xCk47qz27X0myO0UmGNxwdmSzSs9+eoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fzze/nOVtumgPn8AHd6exNdZqp8o4hCjsXBQ9SVh1V1QS+agiJ/C2wzJRIcbkcvou
	 n7uggXKV6vvjweC+ZL1KIGv3uWGx24C53BK1ClJgUcJUi0oN/MbHPvwLqHDGTXkFm4
	 0vFx3oa02sNLSfNbquMLDoNbVTlQClrgMugFp26i3gbJm5Ym6C4Akh6NUxRlvWHnKY
	 q6xWyXAoYGhW0m0YZPRnTCGbFGt3/ohgVscqhkS/dvpHMh8y3t91V2Ck2Wsp6yRqgd
	 9Wvn5gxNBkJ7bDlbtflGHSfwfeW4cPfO8AazNyy7/MIUIql02SD25QLi+4KUwo4Vnm
	 dqJ9Uq3al0ncA==
Date: Thu, 13 Feb 2025 19:35:10 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Margolin, Michael" <mrgolin@amazon.com>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/core: Fix best page size finding when it
 can cross SG entries
Message-ID: <20250213173510.GO17863@unreal>
References: <20250209142608.21230-1-mrgolin@amazon.com>
 <20250213125126.GK17863@unreal>
 <20250213140421.GZ3754072@nvidia.com>
 <777e5518-3f0a-43e8-b80b-0a3ba4ecf5da@amazon.com>
 <20250213144219.GB3754072@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213144219.GB3754072@nvidia.com>

On Thu, Feb 13, 2025 at 10:42:19AM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 13, 2025 at 04:30:11PM +0200, Margolin, Michael wrote:
> > 
> > On 2/13/2025 4:04 PM, Jason Gunthorpe wrote:
> > > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > > 
> > > 
> > > 
> > > On Thu, Feb 13, 2025 at 02:51:26PM +0200, Leon Romanovsky wrote:
> > > > diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> > > > index e7e428369159..63a92d6cfbc2 100644
> > > > --- a/drivers/infiniband/core/umem.c
> > > > +++ b/drivers/infiniband/core/umem.c
> > > > @@ -112,8 +112,7 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
> > > >                  /* If the current entry is physically contiguous with the previous
> > > >                   * one, no need to take its start addresses into consideration.
> > > >                   */
> > > > -               if (curr_base + curr_len != sg_dma_address(sg)) {
> > > > -
> > > > +               if (curr_base != sg_dma_address(sg) - curr_len) {
> > > >                          curr_base = sg_dma_address(sg);
> > > >                          curr_len = 0;
> > > I'm not sure about this, what ensures sg_dma_address() > curr_len?
> > > 
> > > curr_base + curr_len could also overflow, we've seen that AMD IOMMU
> > > sometimes uses the very high addresess already
> > 
> > I think the only case we care about where curr_base + curr_len can overflow
> > is when next sg_dma_address() == 0.
> > 
> > But maybe we should just add an explicit check:
> > 
> > -               if (curr_base + curr_len != sg_dma_address(sg)) {
> > +               if (curr_base + curr_len < curr_base ||
> > +                   curr_base + curr_len != sg_dma_address(sg)) {
> >                         curr_base = sg_dma_address(sg);
> >                         curr_len = 0;
> 
> Ugh
> 
> I wonder if we should try to make a overflow.h helper for these kinds
> of problems.
> 
> /* Check if a + n == b, failing if a+n overflows */
> check_consecutive(a, n, b)
> 
> ?
> 
> It is a fairly common problem
> 
> I suggest to take the patch as it originally was and try to propose
> the above helper?

My concern was with this line:
if (curr_base + curr_len != sg_dma_address(sg)) {

Initially curr_base is 0xFF.....FF and curr_len is 0.
So if this "if ..." is skipped (not possible but static checkers don't know),
we will advance curr_len and curr_base + curr_len will overflow.

I don't want to take original patch.

Thanks

> 
> Jason

