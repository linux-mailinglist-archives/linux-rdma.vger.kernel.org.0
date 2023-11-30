Return-Path: <linux-rdma+bounces-173-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C797FF8AC
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 18:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA956281824
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 17:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F92584C2;
	Thu, 30 Nov 2023 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGjc5wG/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B50954FB5;
	Thu, 30 Nov 2023 17:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46670C433C8;
	Thu, 30 Nov 2023 17:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701366344;
	bh=Z0rdqtHB/1WMoBlhdId/h4N42zIR/AZb8/VyMLb5Q5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGjc5wG/kkTHxD/lxA7nYlI8B/lqCH7zV4eRtVsh+EZtg3ogSB5inawWs3OHhDYhW
	 yKe/VZ1Lar5bpOXWgf4pgrDHCRCjha8UzuB69T/FCn1SbCKVMShSWv7UeyfoOf6Uer
	 2DYmS0ZvlO9ezGxBnK98vfZaq/oOPcHz9uoH/0zU9MosKFjWVptF+laAxnbwUkRd/w
	 kDeNv9N7XmIrTe0TcwpS3TohkaiD3vQ/mIvskFWjc6NFui194Kpeo+gHUHfr4MnSmY
	 x0W0/fWd3oARFwsT76pDle5EEBnX90e+XDgqNodb5t25+/VBuJ1aPP5t1ngdAQaG3b
	 gNwqNbGobVc/g==
Date: Thu, 30 Nov 2023 17:45:38 +0000
From: Simon Horman <horms@kernel.org>
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] net/mlx5e: fix a potential double-free in
 fs_udp_create_groups
Message-ID: <20231130174538.GK32077@kernel.org>
References: <20231128094055.5561-1-dinghao.liu@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128094055.5561-1-dinghao.liu@zju.edu.cn>

On Tue, Nov 28, 2023 at 05:40:53PM +0800, Dinghao Liu wrote:
> When kcalloc() for ft->g succeeds but kvzalloc() for in fails,
> fs_udp_create_groups() will free ft->g. However, its caller
> fs_udp_create_table() will free ft->g again through calling
> mlx5e_destroy_flow_table(), which will lead to a double-free.
> Fix this by setting ft->g to NULL in fs_udp_create_groups().
> 
> Fixes: 1c80bd684388 ("net/mlx5e: Introduce Flow Steering UDP API")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:
> 
> v2: Setting ft->g to NULL instead of removing the kfree().

Reviewed-by: Simon Horman <horms@kernel.org>


