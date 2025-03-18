Return-Path: <linux-rdma+bounces-8777-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9943A67146
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 11:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF2AF7A8717
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 10:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D08A207A1F;
	Tue, 18 Mar 2025 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikPPE2Lf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7302040B3
	for <linux-rdma@vger.kernel.org>; Tue, 18 Mar 2025 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293751; cv=none; b=fp4zrnjssMmwRn1O4o2BFjo87+zqllm+Ui/6H5DVpoyYHROua9gp4/CEzk7KzfM62URoPJCyp2wBcEz+gHsGiFUqb4ZGMcIWfGIS7JNqaNXoBhg+gsjuAqR9V0qfJpdvTPhTmKz8cBxGtjs659TuRkJr+zvUHlrlZNchM+XAtsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293751; c=relaxed/simple;
	bh=LrZDP1v1jCQddl22CkSTmARifhQsfH8zHGYANxlSsa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3bfHWon9S8jbjWWI8CEhpJq8I5tyxr0xFXhdo+Gw9f4fTON2hyh2qtyY602S8TQZ+JbUWta6+ndoHUGqrvX+54MEuzPHlsebBbOTpRcO8fZhAIpmcGAGP1PZYkLoZ5z63CT+nnDefTv5S33GIh7ZpxEiKW5zE1JJ/n67xXAxi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikPPE2Lf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6807BC4CEDD;
	Tue, 18 Mar 2025 10:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742293750;
	bh=LrZDP1v1jCQddl22CkSTmARifhQsfH8zHGYANxlSsa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikPPE2LfQV6wV0044MPeDo73rifEksQ+DDsM97XnQG4DDZekw250wlCbqrCrMINS5
	 3MW1a07TSZq9I/PZOnkuNzn8Doo9BlI5typkRaMnCKvqMyEiYYufzZEaJNCfFLtdjV
	 dB9mnrM1QjslqAtSrvkDa+FR3P7bUzv8sVXRYPs5hjlMAxD1pKZDa23uv2nBtnDbqM
	 SnAO2RvXaDhtkdlJwMhIkilHL20Na9dJpmX5h1tS4jleEPfSG6gLzkvhjPvU9JzDAQ
	 KBac4FvUpPysYZyrA5ycB8S+qTrJYq1jl7xa51rksqtB2sOoEJuaZBhQzw+WYzsaJb
	 O5wJnNBhlfo1A==
Date: Tue, 18 Mar 2025 12:29:07 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 0/7] Batch of mlx5_ib fixes
Message-ID: <20250318102907.GC1322339@unreal>
References: <cover.1741875692.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741875692.git.leon@kernel.org>

On Thu, Mar 13, 2025 at 04:29:47PM +0200, Leon Romanovsky wrote:
> Hi,
> 
> This is batch of various fixes to mlx5_ib driver.
> 
> Thanks
> 
> Chiara Meiohas (1):
>   RDMA/mlx5: Fix calculation of total invalidated pages
> 
> Michael Guralnik (5):
>   RDMA/mlx5: Fix MR cache initialization error flow
>   RDMA/mlx5: Fix cache entry update on dereg error
>   RDMA/mlx5: Drop access_flags from _mlx5_mr_cache_alloc()
>   RDMA/mlx5: Fix page_size variable overflow

Applied.

>   RDMA/mlx5: Align cap check of mkc page size to device specification

I was asked offline to drop it for now.

Thanks

> 
> Patrisious Haddad (1):
>   RDMA/mlx5: Fix mlx5_poll_one() cur_qp update flow
> 
>  drivers/infiniband/hw/mlx5/cq.c      |  2 +-
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 23 ++++++++++---
>  drivers/infiniband/hw/mlx5/mr.c      | 50 +++++++++++++++++-----------
>  drivers/infiniband/hw/mlx5/odp.c     | 10 +++---
>  4 files changed, 56 insertions(+), 29 deletions(-)
> 
> -- 
> 2.48.1
> 
> 

