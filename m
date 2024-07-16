Return-Path: <linux-rdma+bounces-3888-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185FF932ED6
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2024 19:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492BE1C220B1
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2024 17:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AD219E809;
	Tue, 16 Jul 2024 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmJtJp3T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0838F86;
	Tue, 16 Jul 2024 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721149574; cv=none; b=gdYMKTWEz2praympWUh0W63NA4WaF5cuW4CErmGMlzAy4StUW613XDLpHakm2HSlgqmYvpFlwTPyRrjGVobPwjPOpLZ+ZpBR4143oA+pjmZt2LWkg85vZO94CiTINOKNiOu/6gynWWQa/Xj87hvK1Gs+Bg7U+ItM8PAT3ClkmmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721149574; c=relaxed/simple;
	bh=dLr51+rMqJOg34PglPCXBQFJvPe31lgdVfxnith6BD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6g7dv3cLrA6z3jcWmN3/GEpw8yjtjBkzHehYcVsul0b2PogeNHqJNa2hZ64tdZtP95chKxngf8xat4Wk5GYHK+9K28DTI3NiWAABM84LWBgku+bHyTwRUUxzakR5/oy1GnKsu4SF8fhGaV9OVJfhCqrzAgNIBznluml+KQdOuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmJtJp3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397DFC116B1;
	Tue, 16 Jul 2024 17:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721149573;
	bh=dLr51+rMqJOg34PglPCXBQFJvPe31lgdVfxnith6BD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SmJtJp3TkIHTGVUWiU3t4r0qwDxnFnqHONz09sk7F4QnueidyMjQ5mzJIt9NdBwqk
	 CHvl5P2eHJ/XoHLd1w7W29UxiFglJMAU+ztjelGiplNu4aecJLVB7DPvJA1dXBzyiU
	 bxAL2850DZfZeBDjhdpdQxp5aIAv42CvwGAi3mMqumQ4zrgAtOQqAFZX7oLtA6cXSA
	 TT9xYikt5vGvFsR6SRac3fKzDH4AoKFK/m+KCWjhcFpML0N5gFHPoqBIUZVTp4cYha
	 +HQ+B3xG9U44UPWBCSm0E+CcDjDaIJFyBOF93efGU/1DWo9ZObN6zGVFIlwEDIRQHZ
	 z1wlk9pa1FaDQ==
Date: Tue, 16 Jul 2024 20:06:08 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: indicate that inline data is
 not supported
Message-ID: <20240716170608.GD5630@unreal>
References: <1721126889-22770-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240716111441.GB5630@unreal>
 <PAXPR83MB0559406ED7CCDAFC0CAEC63DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240716142223.GC5630@unreal>
 <PAXPR83MB05595BBC92EB695753EB8563B4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB05595BBC92EB695753EB8563B4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>

On Tue, Jul 16, 2024 at 02:55:26PM +0000, Konstantin Taranov wrote:
> > > > > Set max_inline_data to zero during RC QP creation.
> > > > >
> > > > > Fixes: fdefb9184962 ("RDMA/mana_ib: Implement uapi to create and
> > > > > destroy RC QP")
> > > > > Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> > > > > ---
> > > > >  drivers/infiniband/hw/mana/qp.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/drivers/infiniband/hw/mana/qp.c
> > > > > b/drivers/infiniband/hw/mana/qp.c index 73d67c853b6f..d9f24a763e72
> > > > > 100644
> > > > > --- a/drivers/infiniband/hw/mana/qp.c
> > > > > +++ b/drivers/infiniband/hw/mana/qp.c
> > > > > @@ -426,6 +426,8 @@ static int mana_ib_create_rc_qp(struct ib_qp
> > > > > *ibqp,
> > > > struct ib_pd *ibpd,
> > > > >  	u64 flags = 0;
> > > > >  	u32 doorbell;
> > > > >
> > > > > +	/* inline data is not supported */
> > > > > +	attr->cap.max_inline_data = 0;
> > > >
> > > > Can you please point to me to the flow where attr is not zeroed before?
> > > >
> > >
> > > Sorry, I do not understand the question. I cannot point to something that is
> > not in the code.
> > >
> > > It is to support the case when user asks for x bytes inlined when it
> > > creates a QP, and we respond with actual allowed inline data for the
> > > created QP. (as defined in: "The function ibv_create_qp() will update
> > > the qp_init_attr->cap struct with the actual QP values of the QP that
> > > was created;")
> > >
> > > The kernel logic is inside "static int create_qp(struct uverbs_attr_bundle
> > *attrs, struct ib_uverbs_ex_create_qp *cmd)"
> > > where we do the following:
> > > attr.cap.max_inline_data = cmd->max_inline_data; qp =
> > > ib_create_qp_user(..,&attr,..);
> > 
> > Awesome, ib_create_qp_user() is called exactly in two places, and in both
> > cases I see this line "struct ib_qp_init_attr attr = {}; "
> > 
> > It means that attr is zeroed.
> > 
> 
> I think there is some misunderstanding.
> So, the attr is zeroed at init. Then it is filled with values from the user request.
> With
> 	attr.cap.max_send_wr     = cmd->max_send_wr;
> 	attr.cap.max_recv_wr     = cmd->max_recv_wr;
> 	attr.cap.max_send_sge    = cmd->max_send_sge;
> 	attr.cap.max_recv_sge    = cmd->max_recv_sge;
> 	attr.cap.max_inline_data = cmd->max_inline_data;
> or with:
> 	set_caps(&attr, &cap, true);
> 
> So at this moment there is a value from the user in the attr (it is not 0).
> ib_create_qp_user is called with the attr.
> 
> The drivers are allowed to tune the cap values during QP create.
> So I want to set it to 0 as some other provides (see pvrdma_create_qp,
> rvt_create_qp, set_kernel_sq_size from mlx4).
> 
> After the driver call has happened, the modified cap value are copied to temp variable:
> 	resp.base.max_recv_sge    = attr.cap.max_recv_sge;
> 	resp.base.max_send_sge    = attr.cap.max_send_sge;
> 	resp.base.max_recv_wr     = attr.cap.max_recv_wr;
> 	resp.base.max_send_wr     = attr.cap.max_send_wr;
> 	resp.base.max_inline_data = attr.cap.max_inline_data;
> or with:
> 	set_caps(&attr, &cap, false);
> And then copied to the user with:
> 	uverbs_response(attrs, &resp, sizeof(resp));
> or with
> 	uverbs_copy_to_struct_or_zero(attrs,
> 					UVERBS_ATTR_CREATE_QP_RESP_CAP, &cap,
> 					sizeof(cap));
> 
> Do you agree that my patch solves a problem in mana_ib (there is no problem in core)?
> Or do you think that I am trying to solve non-existent problem?

Yes, you are. If user asked for specific functionality (max_inline_data != 0) and
your device doesn't support it, you should return an error.

pvrdma, mlx4 and rvt are not good examples, they should return an error as well, but because of being
legacy code, we won't change them.

Thanks

> 
> Thanks
> 
> > Thanks
> > 
> > > resp.base.max_inline_data = attr.cap.max_inline_data;
> > >
> > > So, my change makes sure that the response will have 0 and not the
> > > value the user asked, as we do not support inlining. So without the
> > > fix, the user who was asking for inlining was falsely seeing that we support
> > it (example of such an application is rdma_server from librdmacm).
> > >
> > > Thanks
> > >
> > > > Thanks
> > > >
> > > > >  	if (!udata || udata->inlen < sizeof(ucmd))
> > > > >  		return -EINVAL;
> > > > >
> > > > > --
> > > > > 2.43.0
> > > > >

