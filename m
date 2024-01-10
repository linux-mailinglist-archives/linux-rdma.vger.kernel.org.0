Return-Path: <linux-rdma+bounces-595-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D1D829E81
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jan 2024 17:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7690B25520
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jan 2024 16:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A044CB4D;
	Wed, 10 Jan 2024 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ufudp8Qg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76F4CB41;
	Wed, 10 Jan 2024 16:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF93C41674;
	Wed, 10 Jan 2024 16:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704903891;
	bh=F/rRPZEP4jt4dv94N+GBp79mg97U/mDxSAOx1+gJl7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ufudp8Qg9VLe8RnLKEopFn0JZ6i4YfvSuUASRNwS1p+YfsHir98+Pu8BXPbZZc2KG
	 qLuFVVyEP8CtAoCKLGZCMujLGWnETj5HMal8pJXodKRnMma/oaTpfPSVdDU34G6nJP
	 jb/dcWrmweLhMbTldpOm3dBEzr6LKpGCvtTV1SFY6pmZFagrT5lQhlTP0NweR4Zaa+
	 f4+H++RQYiroFkBCcvlvjS7rPQ2kusPg8pXQF2vZKxTxrD2njcv5bdFezUT1U4TGjB
	 NRjrWTlkAWkkxncDUxHzf3sNgmEeU9BgyigMJC3067oJ0npjmu6ikXlz6nSK+M/q+X
	 LatT7sy5QW2ng==
Date: Wed, 10 Jan 2024 16:24:46 +0000
From: Simon Horman <horms@kernel.org>
To: alexious@zju.edu.cn
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maor Gottlieb <maorg@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] net/mlx5e: fix a double-free in arfs_create_groups
Message-ID: <20240110162446.GJ9296@kernel.org>
References: <20240108152605.3712050-1-alexious@zju.edu.cn>
 <20240109081837.GJ132648@kernel.org>
 <49a38639.7d59b.18cf38ab939.Coremail.alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49a38639.7d59b.18cf38ab939.Coremail.alexious@zju.edu.cn>

On Wed, Jan 10, 2024 at 09:23:24PM +0800, alexious@zju.edu.cn wrote:
> > On Mon, Jan 08, 2024 at 11:26:04PM +0800, Zhipeng Lu wrote:
> > > When `in` allocated by kvzalloc fails, arfs_create_groups will free
> > > ft->g and return an error. However, arfs_create_table, the only caller of
> > > arfs_create_groups, will hold this error and call to
> > > mlx5e_destroy_flow_table, in which the ft->g will be freed again.
> > > 
> > > Fixes: 1cabe6b0965e ("net/mlx5e: Create aRFS flow tables")
> > > Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > When working on netdev (and probably elsewhere)
> > Please don't include Reviewed-by or other tags
> > that were explicitly supplied by someone: I don't recall
> > supplying the tag above so please drop it.
> 
> I apologize, but it appears that you included a "reviewed-by" 
> tag along with certain suggestions for version 1 of this patch 
> in the first review email(about 6 days before). 

Yes, sorry. My statement above is not correct:
I now see that I did supply the tag.

> In response, after a short discussion, I followed some of 
> those suggestions and send this v2 patch.
> I referred to the "Dealing with tags" section in this KernelNewbies 
> tips: https://kernelnewbies.org/PatchTipsAndTricks and thought 
> that I should include that tag in v1 email to this v2 patch.
> So now I'm a little bit confused here: if the tag rule has changed 
> or I got some misunderstanding on existing rules? Your clarification 
> on this matter would be greatly appreciated.

I think in this case my statement above was incorrect,
and indeed the rule above is correct AFAIK

But it probably would have been best not to include the tag
in v2, because there were significant changes between v1 and v2.

> I'll send a new version of this patch after correcting the tag 
> issue and taking your suggestions into consideration.
> 
> Several comments below.

...

> > > @@ -883,7 +883,6 @@ void mlx5e_fs_init_l2_addr(struct mlx5e_flow_steering *fs, struct net_device *ne
> > >  void mlx5e_destroy_flow_table(struct mlx5e_flow_table *ft)
> > >  {
> > >  	mlx5e_destroy_groups(ft);
> > > -	kfree(ft->g);
> > >  	mlx5_destroy_flow_table(ft->t);
> > >  	ft->t = NULL;
> > 
> > Is the above still needed in some cases, and safe in all cases?
> 
> Well, in fact the kfree(ft->g) in mlx5e_destroy_flow_table causes 
> double frees in different functions such as fs_udp_create_table, 
> not only in arfs_create_groups. But you are right, with a more 
> detailed check I found that in some other functions, like 
> accel_fs_tcp_create_table, removing such free will cause memleak.
> So it could be a better idea to leave mlx5e_destroy_flow_table 
> as it used to be. And that follows the "one patch for one change" idea.

Right, I think it would be best to focus on fixing arfs_create_groups().
And making sure that neither leaks nor double frees occur. And I think
that at this point that includes ensuring ft->g is NULL if it has been freed.

