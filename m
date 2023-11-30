Return-Path: <linux-rdma+bounces-172-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4757FF8A8
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 18:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE5F1C2114B
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 17:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C902584C0;
	Thu, 30 Nov 2023 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTsVvuxq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84B258133;
	Thu, 30 Nov 2023 17:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A85C433C9;
	Thu, 30 Nov 2023 17:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701366255;
	bh=uzTkHarOhWkDRPyS2TS5VgefjyqziPWu4KYGuOmUCMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OTsVvuxqonWfqBPO3LoEoMMLCu6SuUZ07G3eOHFqcWj3z9ozDz/7GMiQBpASmAJIC
	 9m+cZ8/+8di3YeHnM7QoI9MfKzrJWZQEGCTrPvhTdbjh9wyWejnjZEcIz8+Wnk+sAF
	 ic2/WU+BROUoRffGvaaOGUSyGpDEEZBEmJOE8nxCsEkUSS1sv4r599lUvRXiw2/KVz
	 h4kUDSsiH2NgvfYfHpWErG4UN++6dJMUilSav2USnSh2QYlZSyi/YHDsnMXdHhR5gG
	 +RZA6Aq2ExhTYr2wwsZzLCDAuKrGst83xA+j5ILt8gGpTHXfk9IimKN0Vyq3Xodwsc
	 IcGTJaldjbQkQ==
Date: Thu, 30 Nov 2023 17:44:10 +0000
From: Simon Horman <horms@kernel.org>
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] net/mlx5e: fix a potential double-free in
 fs_any_create_groups
Message-ID: <20231130174410.GJ32077@kernel.org>
References: <20231128092904.2916-1-dinghao.liu@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128092904.2916-1-dinghao.liu@zju.edu.cn>

On Tue, Nov 28, 2023 at 05:29:01PM +0800, Dinghao Liu wrote:
> When kcalloc() for ft->g succeeds but kvzalloc() for in fails,
> fs_any_create_groups() will free ft->g. However, its caller
> fs_any_create_table() will free ft->g again through calling
> mlx5e_destroy_flow_table(), which will lead to a double-free.
> Fix this by setting ft->g to NULL in fs_any_create_groups().
> 
> Fixes: 0f575c20bf06 ("net/mlx5e: Introduce Flow Steering ANY API")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:
> 
> v2: Setting ft->g to NULL instead of removing the kfree().

Reviewed-by: Simon Horman <horms@kernel.org>


