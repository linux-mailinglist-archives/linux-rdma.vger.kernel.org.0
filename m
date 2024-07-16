Return-Path: <linux-rdma+bounces-3885-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0401932835
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2024 16:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC59284729
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2024 14:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633CD19B5AE;
	Tue, 16 Jul 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNQnbiKa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E7319B58D;
	Tue, 16 Jul 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139748; cv=none; b=MV68YLFTSDN7l6wrn7zIz2m5Hsontm5d+zIjKh8s+txOzfMzXZ/7OPgTSEbIt0xByhgz/uNFmWhXq/Gg/A8y4HobEGmUZDDlYK1wZjaIeDhE2zvhmeWUggUwPSxCT6jrF1V9zRc9pEt6xj0vHmIdcU3W3P7m1odZBRBbQ39G2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139748; c=relaxed/simple;
	bh=lRacVhN7ynbA5xBcabtmPnIkPfU0DMzBPbT8tnfeQWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxZMg96jV3Ngd4CX2v+Hj+vaUV/3S5o/DlxZHDBvzVrJvGQxJhm5McF/7g2HeaFHxP9J7hAnSTSwjg8KPIXwTeyz4fAjJqASwOCR1cGofCbxm2T4c9RRn6xJ57E+k6z8di1yopPa2Nz6mQPjkr8x/Ys47mPNNYDamp0A2swF5iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNQnbiKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72794C4AF09;
	Tue, 16 Jul 2024 14:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721139748;
	bh=lRacVhN7ynbA5xBcabtmPnIkPfU0DMzBPbT8tnfeQWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNQnbiKadchSFpiphsNrYnEOQ3WO0ySEZWkrHpEd4VleEauhswxGjM+MJFceiIOzC
	 g7LU35QO4aDn9Bl/oThjSP1kUw3Y3oXIACDsyeiymbuQ/aoyqQZ3VUHygOCXZP7531
	 Oe0C5Fr/M291vBPYRwyZRNQB+dZeOW6hp31DIoOUgXr1lZoWoNsjZyHlJU+vlzp7c3
	 rdjiHMT5Ze/xgow3CJSeKjc1WL84bG+giGGqtz2a0JiY6Mfcof9xYvwRM4sWivka6d
	 Qv7US3RiUfoBoZEKHgJBJATRipkUeIiFRED8MwVzYbzoHB7jXdevwiJqgIF8A3eyuH
	 2qYQlaC1XtzLA==
Date: Tue, 16 Jul 2024 17:22:23 +0300
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
Message-ID: <20240716142223.GC5630@unreal>
References: <1721126889-22770-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240716111441.GB5630@unreal>
 <PAXPR83MB0559406ED7CCDAFC0CAEC63DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB0559406ED7CCDAFC0CAEC63DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>

On Tue, Jul 16, 2024 at 01:42:49PM +0000, Konstantin Taranov wrote:
> > > Set max_inline_data to zero during RC QP creation.
> > >
> > > Fixes: fdefb9184962 ("RDMA/mana_ib: Implement uapi to create and
> > > destroy RC QP")
> > > Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> > > ---
> > >  drivers/infiniband/hw/mana/qp.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/infiniband/hw/mana/qp.c
> > > b/drivers/infiniband/hw/mana/qp.c index 73d67c853b6f..d9f24a763e72
> > > 100644
> > > --- a/drivers/infiniband/hw/mana/qp.c
> > > +++ b/drivers/infiniband/hw/mana/qp.c
> > > @@ -426,6 +426,8 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp,
> > struct ib_pd *ibpd,
> > >  	u64 flags = 0;
> > >  	u32 doorbell;
> > >
> > > +	/* inline data is not supported */
> > > +	attr->cap.max_inline_data = 0;
> > 
> > Can you please point to me to the flow where attr is not zeroed before?
> >
> 
> Sorry, I do not understand the question. I cannot point to something that is not in the code.
> 
> It is to support the case when user asks for x bytes inlined
> when it creates a QP, and we respond with actual allowed inline
> data for the created QP. (as defined in: "The function ibv_create_qp()
> will update the qp_init_attr->cap struct with the actual QP values of
> the QP that was created;")
> 
> The kernel logic is inside "static int create_qp(struct uverbs_attr_bundle *attrs, struct ib_uverbs_ex_create_qp *cmd)"
> where we do the following:
> attr.cap.max_inline_data = cmd->max_inline_data;
> qp = ib_create_qp_user(..,&attr,..);

Awesome, ib_create_qp_user() is called exactly in two places, and in
both cases I see this line "struct ib_qp_init_attr attr = {}; "

It means that attr is zeroed.

Thanks

> resp.base.max_inline_data = attr.cap.max_inline_data;
> 
> So, my change makes sure that the response will have 0 and not the value the user asked,
> as we do not support inlining. So without the fix, the user who was asking for inlining was falsely
> seeing that we support it (example of such an application is rdma_server from librdmacm).
> 
> Thanks
> 
> > Thanks
> > 
> > >  	if (!udata || udata->inlen < sizeof(ucmd))
> > >  		return -EINVAL;
> > >
> > > --
> > > 2.43.0
> > >

