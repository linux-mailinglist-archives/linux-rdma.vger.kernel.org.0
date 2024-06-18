Return-Path: <linux-rdma+bounces-3277-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB4B90D910
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 18:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBA81B24488
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62034482EE;
	Tue, 18 Jun 2024 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+rHEdVF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20533208A0
	for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2024 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726765; cv=none; b=G+K2nfxjSzae8sO9QKdvCeuXoh5dGgVFvhQK7maRNT2ttDEzqNbWmWiBNLkO8R/5omf45ZHFzjsjG/+0op29WVaJ6YWjiwgYSo5iW+ogDXiCbPg32Q5QraZc2OVcxnbOLp0d4pQEUKub0pVjfe1EU2YlQJgI3qlTWqDJ9smT2Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726765; c=relaxed/simple;
	bh=LjyI+ls8RWRycT0y+u1xSMZ+pFzS3N2kcgJahTLVhu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYs+TErSAMbaQOAkHLZCpRy0ar28f/VVsdX8BMPjZV1WEHLZKfgthu4y3ViUQCyn293PDgZrCoBATA6AlEETAdaxBLeaZh9cSvwFx1GeRt25hr+stg21JX5JesrSdNWhib5S2hskpB1gIzI0OgtyknHFw88tbYivWLgBQEY0he0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+rHEdVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220BAC3277B;
	Tue, 18 Jun 2024 16:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718726764;
	bh=LjyI+ls8RWRycT0y+u1xSMZ+pFzS3N2kcgJahTLVhu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+rHEdVFBdh1bx6fozWyUmPVTxlj5sLNv+N4NMiThBy2TI2lJibZ9ErI/BxW7NEhb
	 M29Z3xtRhDM96UtdK6/CI90HfTIFuLi8Kf+E2/KIoqZoCsuwzpMGrNcm7CYBAF6g9K
	 4wU0YuwWCcF2W5CQE5VWwNyimsPItwrfdqwWK4ld5RzraVTdqUCzTf7ZMALCI6s2p4
	 YFuMMAz8Gau0HsXo9AmviLcPeiI3blOgkZvS90dCW2RhPq7GI6W90ZjF5gdxSMzwAm
	 x6bhJ1pHFgED9Y0RbyuryU2nFgIT34zyjAFJsJBMOgNbwPuFK7EarHT6aj81gdzFi4
	 EjokM7IqcMT3Q==
Date: Tue, 18 Jun 2024 19:05:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Akiva Goldberger <agoldberger@nvidia.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>, linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA: Pass entire uverbs attr bundle to
 create cq function
Message-ID: <20240618160559.GH4025@unreal>
References: <cover.1718554263.git.leon@kernel.org>
 <7d0deae3798c9314ea41f4eb7a211d1b8b05a7fd.1718554263.git.leon@kernel.org>
 <20240617134409.GK19897@nvidia.com>
 <20240617154947.GA4025@unreal>
 <20240617201003.GM19897@nvidia.com>
 <20240618050557.GC4025@unreal>
 <20240618130854.GB2494510@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618130854.GB2494510@nvidia.com>

On Tue, Jun 18, 2024 at 10:08:54AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 18, 2024 at 08:05:57AM +0300, Leon Romanovsky wrote:
> > On Mon, Jun 17, 2024 at 05:10:03PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Jun 17, 2024 at 06:49:47PM +0300, Leon Romanovsky wrote:
> > > > On Mon, Jun 17, 2024 at 10:44:09AM -0300, Jason Gunthorpe wrote:
> > > > > On Sun, Jun 16, 2024 at 07:15:57PM +0300, Leon Romanovsky wrote:
> > > > > 
> > > > > > @@ -63,6 +63,7 @@ enum uverbs_default_objects {
> > > > > >  enum {
> > > > > >  	UVERBS_ATTR_UHW_IN = UVERBS_UDATA_DRIVER_DATA_FLAG,
> > > > > >  	UVERBS_ATTR_UHW_OUT,
> > > > > > +	UVERBS_ATTR_UHW_DRIVER_DATA,
> > > > > 
> > > > > The start of the driver's attributes is not a "UHW", the UHW is only
> > > > > the old structs.
> > > > 
> > > > I asked from Akiva to keep existing naming convention UVERBS_ATTR_UHW_XXX
> > > > to emphasize the namespace and the position of this attribute as
> > > > relevant for existing UHW calls.
> > > 
> > > Well, calling it DRIVER_DATA and UHW is very confusing when it is
> > > really the start of the indexing for drivers that use UHW.
> > > 
> > > A better name is needed
> > 
> > UVERBS_ATTR_UHW_PRIVATE ????
> 
> I think it need to have the word "start" in it, because it is the
> start of numbers, not an actual number itself.

UVERBS_ATTR_UHW_DRIVER_DATA_START ????
What do you suggest instead?

> 
> It is also not PRIVATE at all, this is just in the device specific
> space number space, not the core space.

Private in the sense of driver specific, like net_priv().

> 
> Jason

