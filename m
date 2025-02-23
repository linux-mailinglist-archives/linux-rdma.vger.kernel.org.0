Return-Path: <linux-rdma+bounces-8021-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2872A40E41
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 12:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BA23BBC0E
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 11:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77E51FDA7A;
	Sun, 23 Feb 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGnIgDOb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A356F163;
	Sun, 23 Feb 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740310106; cv=none; b=Nw9tQIITBXggTV6Ylkqmn9AKG3E7Ogp/tA/URZFSFFtOsSVISaLzqAwNstAR66tWm5pQCj5KMbZVN2pfO3+EDcc4YHtyLBHzkAz1Cjcs2zIJeh9m772zHy8edxM/tK2xy12sbg1d6lPOdciRiUi/RiecTQp/DuWtuo0L6k9J1RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740310106; c=relaxed/simple;
	bh=CGxSFYwIYe8kWxj8agt6qvxWWiQulmZQB0XkM9xlsOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/M9Uz/aFUE2mfb4Ju7fQvVc+qlv3v5SAxnOwXrbHxgMwCGjExNQUFs8UEabqxEtxWZFJ0JLgJDevpmGX4NblELsmhk7egEk60PfTu9uieaXzHAw4AJxpEdjmymiN4b1hrk3Y0kApNvfkPpEfSh247ZYLjtPO/J/b/pWxSXYtYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGnIgDOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8349CC4CEDD;
	Sun, 23 Feb 2025 11:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740310106;
	bh=CGxSFYwIYe8kWxj8agt6qvxWWiQulmZQB0XkM9xlsOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGnIgDObM1EbswY2agOKgyCO3q+6w++wjfYTS0P41wgWI+Pa7W/48SZbiVLB0RwI2
	 mCK1I2eskazyGRnHnRWpH2G4YZ5DeNPdDwCWJ2J8UROpKwwOKvD9ulx8rfgTsPXWVX
	 LYmI62CPysPWJnBdFdhtK7C5NFjIpAoFYFRmxVAuE1DXMHxlzkIeDVqIzvmIUQJPI9
	 YSuJcWdFOBEtzTjNe8OCsyQm1AbYKMuvFVfjG4pYQ1Ye+1N23d24ZVxha7rp9luN37
	 1975E1503SiGL81MG+OdlofdulmKTQGA65Za3qESVM5B7ze1bgnAWEPcDkBfGIJkJG
	 O8N2VXIhK0I9g==
Date: Sun, 23 Feb 2025 13:28:22 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Kees Bakker <kees@ijzerbout.nl>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH] RDMA/mana_ib: Ensure variable err is
 initialized
Message-ID: <20250223112822.GZ53094@unreal>
References: <20250221195833.7516C16290A@bout3.ijzerbout.nl>
 <SA6PR21MB4231810186481AF0A68AAC6ECEC72@SA6PR21MB4231.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA6PR21MB4231810186481AF0A68AAC6ECEC72@SA6PR21MB4231.namprd21.prod.outlook.com>

On Fri, Feb 21, 2025 at 08:34:43PM +0000, Long Li wrote:
> > Subject: [EXTERNAL] [PATCH] RDMA/mana_ib: Ensure variable err is initialized
> > 
> > [Some people who received this message don't often get email from
> > kees@ijzerbout.nl. Learn why this is important at
> > https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > In the function mana_ib_gd_create_dma_region if there are no dma blocks to
> > process the variable `err` remains uninitialized.
> > 
> > Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure
> > Network Adapter")
> > Signed-off-by: Kees Bakker <kees@ijzerbout.nl>
> 
> I think it's an impossible condition, but the patch looks good to me.

Agree, it is impossible.

> 
> Reviewed-by: Long Li <longli@microsoft.com>

Thanks

> 
> > ---
> >  drivers/infiniband/hw/mana/main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/hw/mana/main.c
> > b/drivers/infiniband/hw/mana/main.c
> > index 114ca8c509ce..eda9c5b971de 100644
> > --- a/drivers/infiniband/hw/mana/main.c
> > +++ b/drivers/infiniband/hw/mana/main.c
> > @@ -384,7 +384,7 @@ static int mana_ib_gd_create_dma_region(struct
> > mana_ib_dev *dev, struct ib_umem
> >         unsigned int tail = 0;
> >         u64 *page_addr_list;
> >         void *request_buf;
> > -       int err;
> > +       int err = 0;
> > 
> >         gc = mdev_to_gc(dev);
> >         hwc = gc->hwc.driver_data;
> > --
> > 2.48.1
> 

