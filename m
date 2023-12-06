Return-Path: <linux-rdma+bounces-292-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 938D2807AD3
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 22:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F321F215C0
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 21:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C72947778;
	Wed,  6 Dec 2023 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1xKEUQ7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01A7096C;
	Wed,  6 Dec 2023 21:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB8DC433C8;
	Wed,  6 Dec 2023 21:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701899587;
	bh=9wE7t5kK/YCsuLwHfAgKzLt+nO/2533i+EX2OMKT0XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1xKEUQ75etOxiDE0K3MohK/zhxSqmqsUrV3Dwgc8LfrQeERy3Cm02LZfoG4g+ebY
	 PeMhkdMKpA4FsfLJCz5AQUNPVg5ZNJJSrhrWm+k7ddCfKQzUXpUO61KwkIEi5TSfLQ
	 tISTkTdSHSHrQOFBjLAAAfUQhK7zSThcgsLour0dyf3R5ze7ItyEMRC1XsTC17LvTH
	 uHWpaWMWCbCmBg3bKlTOPvSLIwiQ7yDMDH2QQZSHrFY6JM2hsHJHJ5cU5hv0c7Ktop
	 bxXpBNN/PAlDLBODscJApIJlWC6jJgP38azdgXp+nD1vi5JJZ5xNtCqSmkMr8otBVf
	 qkp1X8G2hc+TQ==
Date: Wed, 6 Dec 2023 13:53:06 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] net/mlx5e: fix a potential double-free in
 fs_udp_create_groups
Message-ID: <ZXDtQj_lGub3-cWT@x130>
References: <20231128094055.5561-1-dinghao.liu@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231128094055.5561-1-dinghao.liu@zju.edu.cn>

On 28 Nov 17:40, Dinghao Liu wrote:
>When kcalloc() for ft->g succeeds but kvzalloc() for in fails,
>fs_udp_create_groups() will free ft->g. However, its caller
>fs_udp_create_table() will free ft->g again through calling
>mlx5e_destroy_flow_table(), which will lead to a double-free.
>Fix this by setting ft->g to NULL in fs_udp_create_groups().
>
>Fixes: 1c80bd684388 ("net/mlx5e: Introduce Flow Steering UDP API")
>Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
>---
>
>Changelog:
>
>v2: Setting ft->g to NULL instead of removing the kfree().
>---

Applied to net-mlx5.

- Saeed

