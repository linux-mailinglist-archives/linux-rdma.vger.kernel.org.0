Return-Path: <linux-rdma+bounces-2158-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3918B75D7
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 14:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB581C21F13
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 12:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FCC171079;
	Tue, 30 Apr 2024 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdjjzBZ3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F67F1CD3A;
	Tue, 30 Apr 2024 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480641; cv=none; b=XRSTIhXTQ4sisvZJP5jFN8Vm3V6a1JirIF5c15BlFSse62uDHiqcKQiptz2X1Ohq84UduK/Y7dUJivMXUCkp5+0U/t/ZqDI2NysUYQjp+Se6cd+Nk/cNd+LC6QSVy8Tt5A/niFYWAHepkF9Iq/KVHJ4Mxbl0TDPAR+MM1e66VO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480641; c=relaxed/simple;
	bh=FPqMx5f5x4wqvVTHLCGW9lKxGr2DBWjDBToiIp6l0BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UH1JRG7gn6A5MlnxXZ9LOHxPJNZgVCCoIdb7H5tkPFI2qjt1KqjCj43XS2L5Lym5b2kMuUO1uDHGnjhGe2jmaaB8M446yjdI2YRyD7/og669YBW73Z6tVt3ra5VesZI7TksmKIrGb2ILiyLYZ7agrDYgpxIyK6Z6Bn85cFqMOLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdjjzBZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F89C2BBFC;
	Tue, 30 Apr 2024 12:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714480640;
	bh=FPqMx5f5x4wqvVTHLCGW9lKxGr2DBWjDBToiIp6l0BM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WdjjzBZ3K2zK0UKxydaWJFrBQR9CORpACDdDKYLcgpADpGBuG96OPWsWRVBM3G4nJ
	 XZJTelMyIsNu5HSShlcf71Rlsko/PDS3wfFBjXnwfd0znOfSIYhC5g1sXNCHD8LrFZ
	 6bWxSQSHd0xd230gi8JKa1XrqncBPtJEoL7BVhKTYH1L7B2V2yFEtBDgxoiTUSbPqc
	 OFZs/TgRwsgMDIT1o2NtPwnqiA5qUWGptZMPF7ZRNBvrVEzbffHw/W84sp9KsKrERf
	 QRgnTftlB7j5CG4IPtjx5wuZ8yfUW4JmTZF+7kUZQTVwo/34C8nZMpQe/qEddFxzv5
	 /f/Gz94vtF4ZQ==
Date: Tue, 30 Apr 2024 15:37:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 6/6] RDMA/mana_ib: implement uapi for creation
 of rnic cq
Message-ID: <20240430123715.GD100414@unreal>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713459125-14914-7-git-send-email-kotaranov@linux.microsoft.com>
 <SJ1PR21MB345775858C05B9FE51C2BDF0CE112@SJ1PR21MB3457.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR21MB345775858C05B9FE51C2BDF0CE112@SJ1PR21MB3457.namprd21.prod.outlook.com>

On Tue, Apr 23, 2024 at 11:57:53PM +0000, Long Li wrote:
> > Subject: [PATCH rdma-next 6/6] RDMA/mana_ib: implement uapi for creation
> > of rnic cq
> > 
> > From: Konstantin Taranov <kotaranov@microsoft.com>
> > 
> > Enable users to create RNIC CQs.
> > With the previous request size, an ethernet CQ is created.
> > Use the cq_buf_size from the user to create an RNIC CQ and return its ID.
> > 
> > Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> > ---
> >  drivers/infiniband/hw/mana/cq.c | 56 ++++++++++++++++++++++++++++++---
> >  include/uapi/rdma/mana-abi.h    |  7 +++++
> >  2 files changed, 59 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/mana/cq.c
> > b/drivers/infiniband/hw/mana/cq.c index 8323085..a62bda7 100644
> > --- a/drivers/infiniband/hw/mana/cq.c
> > +++ b/drivers/infiniband/hw/mana/cq.c
> > @@ -9,17 +9,25 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> > ib_cq_init_attr *attr,
> >  		      struct ib_udata *udata)
> >  {
> >  	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
> > +	struct mana_ib_create_cq_resp resp = {};
> > +	struct mana_ib_ucontext *mana_ucontext;
> >  	struct ib_device *ibdev = ibcq->device;
> >  	struct mana_ib_create_cq ucmd = {};
> >  	struct mana_ib_dev *mdev;
> > +	bool is_rnic_cq = true;
> > +	u32 doorbell;
> >  	int err;
> > 
> >  	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
> > 
> > -	if (udata->inlen < sizeof(ucmd))
> > +	cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
> > +	cq->cq_handle = INVALID_MANA_HANDLE;
> > +
> > +	if (udata->inlen < offsetof(struct mana_ib_create_cq, cq_buf_size))
> >  		return -EINVAL;
> > 
> > -	cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
> > +	if (udata->inlen == offsetof(struct mana_ib_create_cq, cq_buf_size))
> > +		is_rnic_cq = false;
> 
> I think it's okay with checking on offset in uapi message to decide if this is a newer/updated RNIC uverb.
> 
> But increasing MANA_IB_UVERBS_ABI_VERSION may make the code simpler. I have a feeling that you may need to increase it anyway, because a new uapi message "mana_ib_create_cq_resp" is introduced.
> 
> Jason or Leon may have a better idea on this.

You should really try to avoid changing MANA_IB_UVERBS_ABI_VERSION as it
usually means that backward compatibility will be broken after such change.

Thanks

