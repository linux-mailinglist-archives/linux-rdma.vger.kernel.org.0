Return-Path: <linux-rdma+bounces-639-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBBA83021F
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jan 2024 10:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B177281563
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jan 2024 09:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E1B14A83;
	Wed, 17 Jan 2024 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl082Dz5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE311C688;
	Wed, 17 Jan 2024 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483167; cv=none; b=MNODI+o8CKJ37Oen5ZdhJSD6zC2OQNV2KUinSg5gGkqFfHUIsAeEzcH6mfq5wDgp+e7t1+ZDNcqGbiVZMZUGhdjZIZB33ifhv6x38zaP31FoNy8rtZSBQnrjGj3+sVrrBNXVJuKFhOv60YXmJ/0LcuBEEQ6jynuKodCpK+pJ/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483167; c=relaxed/simple;
	bh=PbilBdtKJhvv5q5j+kEsTZicZ0aScGFlhI7pefMrNmQ=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=Xgw2RD5FDuHD1VpyPNeQ8ktp8mbNiIIVo1yIj+xxMklb3aPedqX8B5RQYXgvgbpb8UbLBLLEpuTY+R1VtUYMGaLwn7a2QOoWojTT3bbNfk5VURxQlg0Gg0BgXiM1i6dKUjo5jq6vz3ch6LniQ1wxxlGn9NVVx7MmziAKe6dq7Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gl082Dz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B0FC43394;
	Wed, 17 Jan 2024 09:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705483167;
	bh=PbilBdtKJhvv5q5j+kEsTZicZ0aScGFlhI7pefMrNmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gl082Dz5yjBWfmfmNmoIhnsqq4liajUQGppFNuQkfUGrGS2zOAI2hBP5IFVoL02SD
	 mctkiABH+GdMc2ocEOoJ5Gaok6CK4xw7Efn444t/sijL76/Q4gp2GGm15MgNCQ9+cY
	 KfU+uGovA9UWtA1TExWh3J5j8VcDeDE+GfUdLmFArSvySCgLh0tKSseW2Mhedbsf57
	 hwtCe3gXwpj31X4Owa7pMbfcA6T53TP5Ozf2EHg7Nq/M/n12aV34ZoKBx1C6Df48ZE
	 6LV8bpHcB9xnaM/wX/dQFXUkHbx2hIpDJs6pxRA5ihYCboJ/aUtlWxl9SHI1mEPPk+
	 TZ16cYmvoGCwQ==
Date: Wed, 17 Jan 2024 09:19:22 +0000
From: Simon Horman <horms@kernel.org>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maor Gottlieb <maorg@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net/mlx5e: fix a double-free in arfs_create_groups
Message-ID: <20240117091922.GK588419@kernel.org>
References: <20240117071736.3813981-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117071736.3813981-1-alexious@zju.edu.cn>

On Wed, Jan 17, 2024 at 03:17:36PM +0800, Zhipeng Lu wrote:
> When `in` allocated by kvzalloc fails, arfs_create_groups will free
> ft->g and return an error. However, arfs_create_table, the only caller of
> arfs_create_groups, will hold this error and call to
> mlx5e_destroy_flow_table, in which the ft->g will be freed again.
> 
> Fixes: 1cabe6b0965e ("net/mlx5e: Create aRFS flow tables")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
> Changelog:
> 
> v2: free ft->g just in arfs_create_groups with a unwind ladder.
> v3: split the allocation of ft->g and in. Rename the error label.
>     remove some refector change in v2.
> v4: correct some space issue.

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

