Return-Path: <linux-rdma+bounces-4855-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8549736DE
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 14:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E0D1F252D1
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 12:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31E618FC74;
	Tue, 10 Sep 2024 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvlI1qUt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D289137932;
	Tue, 10 Sep 2024 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970279; cv=none; b=qbnxtk6ag7JNb95CcT4IUq8FXwmZwCZPX0qo4WV4BiqsapPEztknrkrGdhupoakLnivurSgMGGDV83LGMpbRC4aIu+VC0P7XMeqWq5RA+gwZF96CiWC6yf76BQztUMAcyxRlY5zerQytKEMXO8qlH7uSvjObeB3teRhYF1a5EKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970279; c=relaxed/simple;
	bh=vNwwWeq48jt99rRaV5uRYSV38r7jfjdSTYDgTBdNKfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIonSXgNkDIGV6QxChw57wp5vaHOmLKgYTlbd4OPDV/vO2zCFsH0jqDiUGhmbU/MKirIHmfJt1IGpyowwfrruUp0aiBmH/d/i/s7ihFKDtHNvl7DnbDHi1V3xjqYAcFf0WxcH3Lahz8Hag3fbDJXYFq7/JPDiYp01cXMyhx1dnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvlI1qUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737B8C4CEC3;
	Tue, 10 Sep 2024 12:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725970279;
	bh=vNwwWeq48jt99rRaV5uRYSV38r7jfjdSTYDgTBdNKfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvlI1qUtw83813btRxLb+OehZDHa7Ur/x32o3Jc9rkLelMyAnILPfHA815+0mFKo1
	 Sc1/tloQhEtt7Esp9YrZH/WfRBpdybchskWBlLSlDkpAeQgJcz6u3HS33f3qXnCP2X
	 ecwYeKGe+skXZ40keg8o27FsY6dD3QldjaJQgfx0teQqK5ZM1ihg8ad6mnHVTLzflq
	 B2ITj3lj4RZSQ7Q5zh/XkJ3eRmwiAETITdKqyiM0IFiCLWoHzsd6+vE5pu3UXdPeW/
	 pmI19oR4K4EH7mcfmyhB4+BtS+0KvJvvbZtxNGcryVZqmzAgUej8tSvf66cUkKQyE8
	 mxSlimDepGAAQ==
Date: Tue, 10 Sep 2024 15:11:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Adam Li <adamli@os.amperecomputing.com>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@amperecomputing.com,
	cl@os.amperecomputing.com, shijie@os.amperecomputing.com,
	Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] net/mlx5: Node-aware allocation for mlx5_buf_list
Message-ID: <20240910121113.GY4026@unreal>
References: <20240906061115.522074-1-adamli@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906061115.522074-1-adamli@os.amperecomputing.com>

On Fri, Sep 06, 2024 at 06:11:15AM +0000, Adam Li wrote:
> Allocation for mlx5_frag_buf.frags[i].buf is node-aware.
> Make mlx5_frag_buf.frags allocation node-aware too.
> 
> Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
> Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/alloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

