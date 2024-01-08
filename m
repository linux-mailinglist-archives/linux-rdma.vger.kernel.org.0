Return-Path: <linux-rdma+bounces-556-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 397B8826C12
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 12:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476F51C2224E
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 11:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D411401E;
	Mon,  8 Jan 2024 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyGyQ2/m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3778E14A8E;
	Mon,  8 Jan 2024 11:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6F6C433C8;
	Mon,  8 Jan 2024 11:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704711928;
	bh=hnEEbFLqfApmzetmvDA6gou/ELu0XbyZz3a1X9//NtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gyGyQ2/m9W0Pt4XSgbjvLigzqgNRwgpBtqDKyKhFITR9y97Cxtrz/1PlDIGp+IjcA
	 EuKa9O9B5hd0LAUnR1F/5LzVUTCqCR7SrTv2ayYSUXF9T1bonV074L//hic4FkcYyM
	 kXENP2DMZ0iC4QLrj1yjvepgS7e3dCT7OB/70YoQ/zdGwcUthVASSxp390vG3ixO0+
	 OSD7AVyrkOxemfqmI0tu1I3ZtLxm7uhLm8LrjsNSc8XbFYaDMcZduBRiq054oMTc26
	 vEAxTN3RaQUgIwpUrMefJr1FYoywnUCcZ8mBn5ZpiA0B8vY74O1nfEoJqW5ab9lwbA
	 7GzNn9CJq5gLw==
Date: Mon, 8 Jan 2024 11:05:23 +0000
From: Simon Horman <horms@kernel.org>
To: alexious@zju.edu.cn
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maor Gottlieb <maorg@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5e: fix a double-free in arfs_create_groups
Message-ID: <20240108110523.GG132648@kernel.org>
References: <20231224081348.3535146-1-alexious@zju.edu.cn>
 <20240103172254.GB31813@kernel.org>
 <5d93189f.7631f.18ce857ef38.Coremail.alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d93189f.7631f.18ce857ef38.Coremail.alexious@zju.edu.cn>

On Mon, Jan 08, 2024 at 05:12:06PM +0800, alexious@zju.edu.cn wrote:
> 
> 
> > On Sun, Dec 24, 2023 at 04:13:48PM +0800, Zhipeng Lu wrote:
> > > When `in` allocated by kvzalloc fails, arfs_create_groups will free
> > > ft->g and return an error. However, arfs_create_table, the only caller of
> > > arfs_create_groups, will hold this error and call to
> > > mlx5e_destroy_flow_table, in which the ft->g will be freed again.
> > > 
> > > Fixes: 1cabe6b0965e ("net/mlx5e: Create aRFS flow tables")
> > > Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> > 
> > Thanks,
> > 
> > I agree this addresses the issue that you describe.
> > And as a minimal fix it looks good.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > However, I would like to suggest that some clean-up work could
> > take place as a follow-up.
> > 
> > I think that the error handling in this area of the code
> > is rather fragile. This is because initialisation is not necessarily
> > unwound on error within the function that initialisation occurs.
> > 
> > I think it would be better if arfs_create_groups():
> > 
> > 1. Released allocates resources it allocates, including ft->g and
> >    elements of ft->g, on error.
> > 2. This was achieved by using a goto unwind ladder.
> > 3. The caller treated ft->g as uninitialised if
> >    arfs_create_groups fails.
> >
>  
> Agree, I think a unwind ladder for arfs_create_groups is much better.
> I'll follow this idea to send a v2 patch later.

Thanks.

> Another comment below.
> 
> > Likewise, I think that:
> > 
> > * arfs_create_groups, should initialise ft->num_groups
> > 
> > And further, logic similar to the above should guide
> > how arfs_create_table() initialises ft->t and cleans it
> > up on error.
> > 
> 
> I think that ft->t you mentioned refers to mlx5_create_flow_table.
> I'd like to make the life cycle of ft->t similar to ft->g in arfs_create_groups, 
> but it needs to add an argument for mlx5_create_flow_table to transfer ft to 
> it. However, mlx5_create_flow_table is called in more than 30 different places 
> throughout the kernel. So such modification could be another refactoring patch
> but may be out of this fix patch's duty.

I agree there is no need to solve all problems in this patch :)

> > I did not look at the code beyond the scope described above.
> > But the above are general principles that may well apply in
> > other nearby code too.
> > 
> > ...

