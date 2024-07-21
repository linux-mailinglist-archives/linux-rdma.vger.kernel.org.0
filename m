Return-Path: <linux-rdma+bounces-3912-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2FC9383A2
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jul 2024 08:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807201C202C9
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jul 2024 06:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563CD6FD3;
	Sun, 21 Jul 2024 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6h21fbP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF33523A;
	Sun, 21 Jul 2024 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721544986; cv=none; b=muNUcyEF5JfyqCnRHxG6DMyGZ83NPAf4o0ENxd2f7TWV/zz9r2P0AHFi1RSHD/oBROGQDiSxp8LAiAe48yjCnNuYaac7LlhS7LRRQ5Yj9Sb+QcTrEztdRWWBMJFcIHdc6eeezx6M60LJhVuZr/Eq85JMp6Cy2RMcv2jdIHg1yUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721544986; c=relaxed/simple;
	bh=FSBPbLLcbAde3ZXMgz23oLJDG7kV2kFSHjx5C5Dhrkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1PaoBPIOuQBRiewGv6dC0NRjVcPmvos7RSoDQYfowKDcH6yzlu6G1Bpm7URFsXihQ/WQF1oLsAqURRoOeRj79nBE8zxpjxSp47Lfx4a4lr7L7L/XLNA9KDWkjuoGBVOkp46kMSdI+emo7PvPGtERmCnGt+SvJaL9DRim9/dGxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6h21fbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE1AC116B1;
	Sun, 21 Jul 2024 06:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721544985;
	bh=FSBPbLLcbAde3ZXMgz23oLJDG7kV2kFSHjx5C5Dhrkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6h21fbPSKjSk8kQYG8NIpXPDlKS7rB8E1X1qmwOnVAVTKCqAt+wRVfwtQlYvMomg
	 c8cSeT8F8tL0fUPxGOEJjL/xeRiqAfRdnWrw0oZZC3RUCd57f543RTEKYVyWnaKqWo
	 aCypL4Kr9AXVJ5iI8eZnLSvV/SU04h6/ZQ51cIvDEFLomIkrwvzypqopjbrzZYw4zT
	 yyzhMdpjZtLTQiQVYHZhJKGTqhytkhjz8xetANwFUzlWM3Hu0oSj4gfJlybNicM4/e
	 EZjP/9pFl9xR+XpAyLIPTDuZQFrlnjqK5gGCIMskq/4bxQZ372SF955DqJ7rskoILI
	 DOHCFgRDoeLMg==
Date: Sun, 21 Jul 2024 09:56:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: indicate that inline data is
 not supported
Message-ID: <20240721065621.GD1265781@unreal>
References: <PAXPR83MB0559406ED7CCDAFC0CAEC63DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240716142223.GC5630@unreal>
 <PAXPR83MB05595BBC92EB695753EB8563B4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240716170608.GD5630@unreal>
 <PAXPR83MB0559D97004241D37765A151DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240717062250.GE5630@unreal>
 <20240717163437.GG1482543@nvidia.com>
 <PAXPR83MB05599E93C7F584D34D715E8AB4AC2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240718164818.GH1482543@nvidia.com>
 <PAXPR83MB0559FD4684B40F51A67D6AC9B4AD2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB0559FD4684B40F51A67D6AC9B4AD2@PAXPR83MB0559.EURPRD83.prod.outlook.com>

On Fri, Jul 19, 2024 at 10:51:58AM +0000, Konstantin Taranov wrote:
> > > > > > > Yes, you are. If user asked for specific functionality
> > > > > > > (max_inline_data != 0) and your device doesn't support it, you
> > > > > > > should
> > > > return an error.
> > > > > > >
> > > > > > > pvrdma, mlx4 and rvt are not good examples, they should return
> > > > > > > an error as well, but because of being legacy code, we won't change
> > them.
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > >
> > > > > > I see. So I guess we can return a larger value, but not smaller. Right?
> > > > > > I will send v2 that fails QP creation then.
> > > > > >
> > > > > > In this case, may I submit a patch to rdma-core that queries
> > > > > > device caps before trying to create a qp in rdma_client.c and
> > > > > > rdma_server.c? As that code violates what you described.
> > > > >
> > > > > Let's ask Jason, why is that? Do we allow to ignore max_inline_data?
> > > > >
> > > > > librdmacm/examples/rdma_client.c
> > > > >   63         memset(&attr, 0, sizeof attr);
> > > > >   64         attr.cap.max_send_wr = attr.cap.max_recv_wr = 1;
> > > > >   65         attr.cap.max_send_sge = attr.cap.max_recv_sge = 1;
> > > > >   66         attr.cap.max_inline_data = 16;
> > > > >   67         attr.qp_context = id;
> > > > >   68         attr.sq_sig_all = 1;
> > > > >   69         ret = rdma_create_ep(&id, res, NULL, &attr);
> > > > >   70         // Check to see if we got inline data allowed or not
> > > > >   71         if (attr.cap.max_inline_data >= 16)
> > > > >   72                 send_flags = IBV_SEND_INLINE;
> > > > >   73         else
> > > > >   74                 printf("rdma_client: device doesn't support
> > > > IBV_SEND_INLINE, "
> > > > >   75                        "using sge sends\n");
> > > >
> > > > I think the idea expressed in this code is that if max_inline_data
> > > > requested too much it would be limited to the device capability.
> > > >
> > > > ie qp creation should limit the requests values to what the HW can
> > > > do, similar to how entries and other work.
> > > >
> > > > If the HW has no support it should return - for max_inline_data not
> > > > an error, I guess?
> > >
> > > Yes, this code implies that max_inline_data can be ignored at creation,
> > while the manual of ibv_create_qp says:
> > > "The function ibv_create_qp() will update the qp_init_attr->cap struct
> > > with the actual QP values of the QP that was created; the values will
> > > be **greater than or equal to** the values requested."
> > 
> > Ah, well that seems to be some misunderstandings then, yes.
> > 
> > > I see two options:
> > > 1) Remove code from rdma examples that rely on ignoring max_inline; add
> > a warning to libibverbs when drivers ignore that value.
> > > 2) Add to manual that max_inline_data might be ignored by drivers; and
> > allow my current patch that ignores max_inline_data in mana_ib.
> > 
> > I don't know, what do the majority of drivers do? If enough are already doing
> > 1 then lets force everyone into 1, otherwise we have to document 2.
> > 
> > And a pyverbs test should be added to cover this weirdness
> 
> I quickly read create_qp code of all providers and it seems that max_inline_data is ignored by hw/pvrdma and sw/rvt.
> Other providers fail the creation when they cannot satisfy the inline_data cap.
> Some drivers ignore it for GSI, but I think it is reasonable. 
> 
> Then I guess the option 1 is better. Regarding pyverbs, should I add a test for the option 1?
> If yes, what should it test?

Probably, the test should check the max_inline_data value returned from device caps and try to create
QP with higher value. If the QP creation fails, the test should pass. For hw/pvrdma and sw/rvt, the QP
should be successfully created, despite the requested value.

Thanks

> 
> > 
> > Jason

