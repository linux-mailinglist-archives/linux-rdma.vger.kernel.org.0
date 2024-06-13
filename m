Return-Path: <linux-rdma+bounces-3137-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FA1907C8E
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 21:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178D41F24717
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 19:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D2D14D2BD;
	Thu, 13 Jun 2024 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3Ylbhwn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5282D2F50;
	Thu, 13 Jun 2024 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306668; cv=none; b=OLFq48iQ+VkIlOQjjNkBQwM9uge+N0/25KHgfJtm5eDQk4JjCdJnaLmKu+4Tilv6u5/5kuZ2Sc0gR2I6w7yOpLiyTEYGNLGKSLIU5/aByvCsLLQNtQzIwQ+4i/4EXv2LeFiqlMJ3NcmToQ21VxDI2puL2NdOjYDUKrYCl0PdG/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306668; c=relaxed/simple;
	bh=H3rQAbMXOBkRkOPqVoJjiRb+Cni4OWtGmo42Wuz1lXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViicYoHjCoAwRUHceH5m8ll90z0OB5/prgJ03Q644ySngH1CHFpzKpBC8FiSaQd8Q5ZYNAv/yn7AF+vk3H5sEJqtsruZ+OuxaVlNSa5rmSGFD/mNkVYaV/t91H66dBIcACzUck25I00FC94zv+R6Jlhya/bgTuPZuEyHJm+WOow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3Ylbhwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6074AC2BBFC;
	Thu, 13 Jun 2024 19:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718306667;
	bh=H3rQAbMXOBkRkOPqVoJjiRb+Cni4OWtGmo42Wuz1lXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J3YlbhwnpOybqxQ4krBnqxCMZYrEm/cF13xEoiv/guErS65bkXAPvwEr6SUk+ckRZ
	 oJdRvofUEu/DmxzCU5C8pm3R/smk5MUbrSaYOfl/J/IRjO6MSN6TFRB9mB26A3CURj
	 0rNGgOQc1skMxaWDqmqBKK9NYuFNxWeneKDDFTNbIYUT7VNrRY4YeS4FKI2ir0YVvJ
	 vf3LygVZm5ICrt0PawpakLOF5AsPQL9e+l7iFXYXK4hddA7E/mmZkdFbxZqO4zhyp/
	 Pb0x5bWq5d09SrGTpMAzd/0X3dxPxn5GTv9TaUX450Bk1cWgo6MVQGrKx7XdPj/D9R
	 DOFbTArU7XnkA==
Date: Thu, 13 Jun 2024 22:24:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH rdma-next 2/3] IB/mlx5: Create UMR QP just before first
 reg_mr occurs
Message-ID: <20240613192423.GK4966@unreal>
References: <cover.1717409369.git.leon@kernel.org>
 <55d3c4f8a542fd974d8a4c5816eccfb318a59b38.1717409369.git.leon@kernel.org>
 <20240607173003.GN19897@nvidia.com>
 <20240613180600.GG4966@unreal>
 <09aab0b6-ed3f-4569-992b-ea5bfc1c2c32@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09aab0b6-ed3f-4569-992b-ea5bfc1c2c32@linux.dev>

On Fri, Jun 14, 2024 at 03:12:59AM +0800, Zhu Yanjun wrote:
> 在 2024/6/14 2:06, Leon Romanovsky 写道:
> > On Fri, Jun 07, 2024 at 02:30:03PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Jun 03, 2024 at 01:26:38PM +0300, Leon Romanovsky wrote:
> > > > From: Jianbo Liu <jianbol@nvidia.com>
> > > > 
> > > > UMR QP is not used in some cases, so move QP and its CQ creations from
> > > > driver load flow to the time first reg_mr occurs, that is when MR
> > > > interfaces are first called.
> > > 
> > > We use UMR for kernel MRs too, don't we?
> > 
> > Strange, I know that I answered to this email, but I don't see it in the ML.
> > 
> > As far as I checked, we are not. Did I miss something?
> 
> I have also found this problem. IMO, 2 reasons:
> 1. Delay in maillist. That is, there is a delay between a mail sent out and
> this mail appearing in maillist. We will find this mail in the maillist
> after some time.
> 
> 2. sometimes, we forget to include maillist.^_^

I replied on Jun, 7th.

Thanks

> 
> Zhu Yanjun
> > 
> > Thanks
> > 
> > > 
> > > Jason
> 
> 

