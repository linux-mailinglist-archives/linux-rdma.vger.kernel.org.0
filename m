Return-Path: <linux-rdma+bounces-3252-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C17A90C301
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 07:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE172284338
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 05:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92C418E28;
	Tue, 18 Jun 2024 05:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQHHJeMn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A68B17C7F
	for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2024 05:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718687163; cv=none; b=bGJ2XUIcyXOdT3HiPMZCyo35kOchIbQkrectGg+DK3AW8tS6qzFzJvJCLVaMPSyIgUg16ngytlQGWcfsQsBSceNvnCPYyYrJ/78om8UKCDxr7DHxZpR7E5HWpDuzabERVOKtKHgCrWEg9ct03p6IxO+BesJJbkmCWmqBjtAR9vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718687163; c=relaxed/simple;
	bh=5Mz38BtlaRum/l6y5YHFBMGckbj9u8QjJXIZnekb9Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzNRxU7i1ezEyeKgpTtX1iXJiqNeQQmUGOMyi5isecAGIaiQcY++LvaQIs6h/K0zTfGcBGhXD6SqFXfuaapNpOhUU4E1FVeNH8pQqApZyvGIS9dyEh3F97DEeE0jF5RvIlYXTmErt0I9gHsOBxWnCkV6+bOJ4mIy0rpcH+Jq8l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQHHJeMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C591C3277B;
	Tue, 18 Jun 2024 05:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718687163;
	bh=5Mz38BtlaRum/l6y5YHFBMGckbj9u8QjJXIZnekb9Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQHHJeMnEFxFOpg5Q397tPP1SaJ23qfruPlIYKR5DI2vF7AwY+Ml8d6pNKhWS6va9
	 UbFtVUYBWhFOBC5DFZMXyw8f8Kr1HJ9FTeS2SI0RIET2Jl0AnJTiHpfhFfqnS+thwu
	 Vo60jFUY0QnoXlCcVl4tXBbhOOY54Nih0zdZPDhXmVTAI+MGke0WxeSpgHmoY0upAe
	 kjADo37/uD02USI7hkYiRBR919RaOepIRDddzZdp1GsZ/12H3p31lQy8wWMUnj1BnF
	 rXH4VEPHc1AVjfaSrX9T95drehdWFj72rAaEB+ZmLnaTo2QA1vtHN/+6q/sWTLps8l
	 iUm51oEBamzdg==
Date: Tue, 18 Jun 2024 08:05:57 +0300
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
Message-ID: <20240618050557.GC4025@unreal>
References: <cover.1718554263.git.leon@kernel.org>
 <7d0deae3798c9314ea41f4eb7a211d1b8b05a7fd.1718554263.git.leon@kernel.org>
 <20240617134409.GK19897@nvidia.com>
 <20240617154947.GA4025@unreal>
 <20240617201003.GM19897@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617201003.GM19897@nvidia.com>

On Mon, Jun 17, 2024 at 05:10:03PM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 17, 2024 at 06:49:47PM +0300, Leon Romanovsky wrote:
> > On Mon, Jun 17, 2024 at 10:44:09AM -0300, Jason Gunthorpe wrote:
> > > On Sun, Jun 16, 2024 at 07:15:57PM +0300, Leon Romanovsky wrote:
> > > 
> > > > @@ -63,6 +63,7 @@ enum uverbs_default_objects {
> > > >  enum {
> > > >  	UVERBS_ATTR_UHW_IN = UVERBS_UDATA_DRIVER_DATA_FLAG,
> > > >  	UVERBS_ATTR_UHW_OUT,
> > > > +	UVERBS_ATTR_UHW_DRIVER_DATA,
> > > 
> > > The start of the driver's attributes is not a "UHW", the UHW is only
> > > the old structs.
> > 
> > I asked from Akiva to keep existing naming convention UVERBS_ATTR_UHW_XXX
> > to emphasize the namespace and the position of this attribute as
> > relevant for existing UHW calls.
> 
> Well, calling it DRIVER_DATA and UHW is very confusing when it is
> really the start of the indexing for drivers that use UHW.
> 
> A better name is needed

UVERBS_ATTR_UHW_PRIVATE ????

> 
> Jason
> 

