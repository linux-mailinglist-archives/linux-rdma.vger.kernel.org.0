Return-Path: <linux-rdma+bounces-533-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50AC823326
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 18:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994D61F24D3C
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 17:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BE41C28C;
	Wed,  3 Jan 2024 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="id+Jtz1l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1409F1C283;
	Wed,  3 Jan 2024 17:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49332C433C8;
	Wed,  3 Jan 2024 17:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704302579;
	bh=3iyOZymBQYPfh3A81OW/8BHqC2kwA+1c8I7WqYrHYY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=id+Jtz1laHJDT6jC/h8FzAg0YKDKd0ybFlwNZ0ZusovfviIq9YSUjmSOsw6H7w9mA
	 cE0hmYXoqQHfAnFSnJ503UZnBguSbdBHrWYc6Y9K2X5jn2w59zLnDoBwxUkWQQ+mBH
	 6rKLpvQfups/h61P3D3gmJbSbOBHU7wDW7LCk5M0wZ83pjKo1PxIsafk6q6w9cROmm
	 dZME5g/+WiX+Qd5SQQp52DMNwDO8wfZgu3xO4DdxxX/HN7QzfHSuzGNAtl+dJmb4Ls
	 380GNdSq9I2cUl8bZ3+FwUwQqIFlKwnbnPloQCQScW+EeEiA0uRDoHKdFC94fabzCi
	 RD5jwsd1yMdLg==
Date: Wed, 3 Jan 2024 17:22:54 +0000
From: Simon Horman <horms@kernel.org>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maor Gottlieb <maorg@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5e: fix a double-free in arfs_create_groups
Message-ID: <20240103172254.GB31813@kernel.org>
References: <20231224081348.3535146-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231224081348.3535146-1-alexious@zju.edu.cn>

On Sun, Dec 24, 2023 at 04:13:48PM +0800, Zhipeng Lu wrote:
> When `in` allocated by kvzalloc fails, arfs_create_groups will free
> ft->g and return an error. However, arfs_create_table, the only caller of
> arfs_create_groups, will hold this error and call to
> mlx5e_destroy_flow_table, in which the ft->g will be freed again.
> 
> Fixes: 1cabe6b0965e ("net/mlx5e: Create aRFS flow tables")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>

Thanks,

I agree this addresses the issue that you describe.
And as a minimal fix it looks good.

Reviewed-by: Simon Horman <horms@kernel.org>

However, I would like to suggest that some clean-up work could
take place as a follow-up.

I think that the error handling in this area of the code
is rather fragile. This is because initialisation is not necessarily
unwound on error within the function that initialisation occurs.

I think it would be better if arfs_create_groups():

1. Released allocates resources it allocates, including ft->g and
   elements of ft->g, on error.
2. This was achieved by using a goto unwind ladder.
3. The caller treated ft->g as uninitialised if
   arfs_create_groups fails.

Likewise, I think that:

* arfs_create_groups, should initialise ft->num_groups

And further, logic similar to the above should guide
how arfs_create_table() initialises ft->t and cleans it
up on error.

I did not look at the code beyond the scope described above.
But the above are general principles that may well apply in
other nearby code too.

...

