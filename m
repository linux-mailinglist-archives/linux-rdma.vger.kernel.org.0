Return-Path: <linux-rdma+bounces-3262-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B4490C7C0
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 12:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9B61C222EC
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 10:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62011C2332;
	Tue, 18 Jun 2024 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ9tkVq+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C8B155CBE;
	Tue, 18 Jun 2024 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702063; cv=none; b=gY68QXhkkOTb51zVIFYNn0H3Rx15cEvIOnVQzqNEhE+qXcQBR6mPPJX1g4jTpy/N6bp7FxUIZTq+5L0LD/36sgNkxhggvJhLbdzemA5r5/9418ifC/pUSJl6Frk2I9POc+D/ZwH+LCE8tDNyIrvhD8/0hQqVZZnmXGSToP1CrfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702063; c=relaxed/simple;
	bh=fIGuUxW+r8nyzI6dlToMvCGbFeC6ZpOBIlGloIm9Tz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kw1xChNU6j3WMHA5xxMlrOWdhf+Wzp4LZCbtDt8eQ4vpku/Sea1UYRNtV2i/1rvyWrQzvvN9pCr3e7sHpLvt5JpJRnwMODynvCPkD/wt6tRVJyd7CKc1o/pNcXCjJBvAmJ+tfUs5vfYSE13NH45zZs3P2ezFPZC3AaUJJGxOX98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ9tkVq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E1AC3277B;
	Tue, 18 Jun 2024 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718702063;
	bh=fIGuUxW+r8nyzI6dlToMvCGbFeC6ZpOBIlGloIm9Tz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZ9tkVq+bTPfkrLdLc7uorMoyKtwLRFWIGsADkkgqIuQlzCe3DdA4nBGdQ4v7Yb3G
	 oCvQJ+XrVlj0Db/PTgSnCa7l34CY8Kstg7dQr3lCXEPq/OdLtca4Od/9yETHW8QbUX
	 f4Y3AdBtYqBJ7MQx2bjSuEEWIAV6ROBQtmMM2txEnbIXZAeFns+gxj9/lSWEHmQb38
	 YmhD90uL7hjy+2wNIXooLwPTYK/hvCExGlOXZO71SRAEFP7nkYtKOtjulhzNDO7oDc
	 hWqzHM6gBS+BfQhse18NJXl7tyLEPUmUpfG9mG+KGPwjJyY3x4DsAKxNJBGUjqK6Q9
	 DI8hETr7e4zdw==
Date: Tue, 18 Jun 2024 10:14:19 +0100
From: Simon Horman <horms@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
	linux-rdma@vger.kernel.org, Maher Sanalla <msanalla@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next] RDMA/mlx5: Use sq timestamp as QP timestamp
 when RoCE is disabled
Message-ID: <20240618091419.GH8447@kernel.org>
References: <32801966eb767c7fd62b8dea3b63991d5fbfe213.1718554199.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32801966eb767c7fd62b8dea3b63991d5fbfe213.1718554199.git.leon@kernel.org>

On Sun, Jun 16, 2024 at 07:10:36PM +0300, Leon Romanovsky wrote:
> From: Or Har-Toov <ohartoov@nvidia.com>
> 
> When creating a QP, one of the attributes is TS format (timestamp).
> In some devices, we have a limitation that all QPs should have the same
> ts_format. The ts_format is chosen based on the device's capability.
> The qp_ts_format cap resides under the RoCE caps table, and the
> cap will be 0 when RoCE is disabled. So when RoCE is disabled, the
> value that should be queried is sq_ts_format under HCA caps.
> 
> Consider the case when the system supports REAL_TIME_TS format (0x2),
> some QPs are created with REAL_TIME_TS as ts_format, and afterwards
> RoCE gets disabled. When trying to construct a new QP, we can't use
> the qp_ts_format, that is queried from the RoCE caps table, Since it
> leads to passing 0x0 (FREE_RUNNING_TS) as the value of the qp_ts_format,
> which is different than the ts_format of the previously allocated
> QPs REAL_TIME_TS format (0x2).
> 
> Thus, to resolve this, read the sq_ts_format, which also reflect
> the supported ts format for the QP when RoCE is disabled.
> 
> Fixes: 4806f1e2fee8 ("net/mlx5: Set QP timestamp mode to default")
> Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


