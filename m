Return-Path: <linux-rdma+bounces-8622-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E91A5E3C8
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 19:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF1B3BC368
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 18:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD602528E3;
	Wed, 12 Mar 2025 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+EedBmA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4E81662F1;
	Wed, 12 Mar 2025 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804857; cv=none; b=WpTgFgTuVa/cJyZdNp/GUzkTvUZpKGMWEJ6lyfodsn7APcIQGVsJfWaKXl6+BdJeJ/Dk19Aw4ksQs4bR5bvEeEl0aXA0xxrXaM+e+rdnclCrihyYG7REjd8MVRJxdhQpUG4uZv8sBqe15EUXBu9cyhXYBQtp2x9LLhPo37Q16BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804857; c=relaxed/simple;
	bh=wanRahIyORLaUiXEdrQ9KFGs6AVSPbF9IBeUsNlrJFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NO5jPArg/hiwnb9Kv8Zxcbe4iavyWRJwesrij+z2+SfyFhBlW0UCSmMrfjisA6cjA2z0ZttXUXuYJ6Ez33TcqMA8XOfmX4lLfoa9YnYE8ng+o5nbZo7IePiwjYkKPe/RPBaaP/9DhgawrTDhInjefdFR9FoEFTBISb5i+v2JBcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+EedBmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02DAC4CEEA;
	Wed, 12 Mar 2025 18:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741804856;
	bh=wanRahIyORLaUiXEdrQ9KFGs6AVSPbF9IBeUsNlrJFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i+EedBmACBRUt7E6U70iWBXNzXWNWqmCz6GFrzKkTOlO10YcZXf434PecR5FELJEy
	 rHz3rq6qrLCxJ9pL2knILBOYfsZUS6QkX/M8TATPRCS7F9QNpPsehCzMXLEh1cRg3n
	 sn1tb0MBuNGRzGNQff1wzTNv8CLCLZEgtbs5CGWLHLq4BwvDXul87KDC8A/rAbUNv+
	 aTbq/OTLJrzlPwdhJ39seph0FteM75n80cOcjixR6L2bUk7Qe7uOlY6jyaD7Bk4M45
	 XxUubhHoLkarkwipccGD60AD7Ox7FkR/PPV6TVNKvPrjeqL9b/NDXHLngOW8vlqUhO
	 aDUAszK3ifcRA==
Date: Wed, 12 Mar 2025 20:40:51 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Fix integer overflow during
 queue creation
Message-ID: <20250312184051.GG1322339@unreal>
References: <1741287713-13812-1-git-send-email-kotaranov@linux.microsoft.com>
 <SA6PR21MB423152087DEEDD4254C414BBCECA2@SA6PR21MB4231.namprd21.prod.outlook.com>
 <PA1PR83MB0662C52043DE3FA1F2EFBCA0B4D12@PA1PR83MB0662.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PA1PR83MB0662C52043DE3FA1F2EFBCA0B4D12@PA1PR83MB0662.EURPRD83.prod.outlook.com>

On Tue, Mar 11, 2025 at 10:05:47AM +0000, Konstantin Taranov wrote:
> > > Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: Fix integer overflow
> > > during queue creation
> > >
> > > From: Konstantin Taranov <kotaranov@microsoft.com>
> > >
> > > Use size_t instead of u32 in helpers for queue creations to detect
> > > overflow of queue size. The queue size cannot exceed size of u32.
> > >
> > > Fixes: bd4ee700870a ("RDMA/mana_ib: UD/GSI QP creation for kernel")
> > > Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> > > ---
> > >  drivers/infiniband/hw/mana/cq.c      |  9 +++++----
> > >  drivers/infiniband/hw/mana/main.c    | 15 +++++++++++++--
> > >  drivers/infiniband/hw/mana/mana_ib.h |  4 ++--
> > >  drivers/infiniband/hw/mana/qp.c      | 11 ++++++-----
> > >  4 files changed, 26 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/mana/cq.c
> > > b/drivers/infiniband/hw/mana/cq.c index 5c325ef..07b97da 100644
> > > --- a/drivers/infiniband/hw/mana/cq.c
> > > +++ b/drivers/infiniband/hw/mana/cq.c
> > > @@ -18,7 +18,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const
> > > struct ib_cq_init_attr *attr,
> > >  	struct gdma_context *gc;
> > >  	bool is_rnic_cq;
> > >  	u32 doorbell;
> > > -	u32 buf_size;
> > > +	size_t buf_size;
> > >  	int err;
> > >
> > >  	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev); @@ -45,7
> > > +45,8 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> > > +ib_cq_init_attr
> > > *attr,
> > >  		}
> > >
> > >  		cq->cqe = attr->cqe;
> > > -		err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe
> > *
> > > COMP_ENTRY_SIZE,
> > > +		buf_size = (size_t)cq->cqe * COMP_ENTRY_SIZE;
> > > +		err = mana_ib_create_queue(mdev, ucmd.buf_addr, buf_size,
> > >  					   &cq->queue);
> > >  		if (err) {
> > >  			ibdev_dbg(ibdev, "Failed to create queue for create
> > cq, %d\n",
> > > err); @@ -57,8 +58,8 @@ int mana_ib_create_cq(struct ib_cq *ibcq,
> > > const struct ib_cq_init_attr *attr,
> > >  		doorbell = mana_ucontext->doorbell;
> > >  	} else {
> > >  		is_rnic_cq = true;
> > > -		buf_size = MANA_PAGE_ALIGN(roundup_pow_of_two(attr-
> > >cqe
> > > * COMP_ENTRY_SIZE));
> > > -		cq->cqe = buf_size / COMP_ENTRY_SIZE;
> > > +		cq->cqe = attr->cqe;
> > > +		buf_size =
> > > MANA_PAGE_ALIGN(roundup_pow_of_two((size_t)attr->cqe *
> > > +COMP_ENTRY_SIZE));
> > 
> > Why not do a check like:
> > If (attr->cqe > U32_MAX/COMP_ENTRY_SIZE)
> > 	return -EINVAL;
> > 
> > And you don’t need to check them in mana_ib_create_kernel_queue() and
> > mana_ib_create_queue().
> > 
> 
> Yes, I was initially thinking about the small fix as you proposed and then ended up
> adding checks to all paths. As I see the same can happen if a user asks for a large WQ of RC.
> I believe a kernel client can also cause this overflow. We plan to add kernel RC soon and,
> as far as I understand, a kernel user can also ask to create a large CQ resulting in similar overflow.

The expectation that kernel users are using in-kernel API correctly and
kernel shouldn't have extra protection for API misuse.

Thanks

> 
> - Konstantin

