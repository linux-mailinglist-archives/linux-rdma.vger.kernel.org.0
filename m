Return-Path: <linux-rdma+bounces-4770-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A1A96D61C
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 12:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455371C24F92
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 10:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5201E1957F8;
	Thu,  5 Sep 2024 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQvSMbTV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2AE194A64;
	Thu,  5 Sep 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532297; cv=none; b=NmyLwiOxpQdINOXySbKF6QSRCchG9Mhs7PDBeF/m09FWwpe4h1AEGao8tSQC1IMqnBTeUSasNg5U4Qwr9agOMkij86TY8kB+z6Vn2y2QhtM3rIyuR5Fq1xGzjaE58MubbOBaRchdRMF2BhcmSzktJWxP8EUp79Omtiv89nT5kXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532297; c=relaxed/simple;
	bh=FNHN5rDOdvLsXhzyTOiUuXK9KeAApeyTuUioHxfoDsM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fMcssHWVJPoG05MRT0MKUXYg8dlTZ6CeLTACi3ULNVG7bM7RxL+pwdBeJ4pq21slvJ9ioCmAtCFPD9B/Mn1DE5vLkC3YRhPQGK7g9Yhz4hB+2V0TfoXpxHMlEnXRvUSwTsv8i2LDLPXjDf4bJzgc7+dNdkpYjRUitl41ptAAL30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQvSMbTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16105C4CEC3;
	Thu,  5 Sep 2024 10:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725532296;
	bh=FNHN5rDOdvLsXhzyTOiUuXK9KeAApeyTuUioHxfoDsM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jQvSMbTVAV6AFtMFxWR7+2yEYGqPIad905PZsRKhWYxKwAlmUcbDn9CP8gzL9hT2+
	 SpZiqJJtWDmZZTXFIqfHrbzU0ubvXiC9MoDC+rawpWx62eb4ynDsS2uw/Ek/TiIIt5
	 7yxqesmQxvIzNz9SQWZBNzHsiWipIHSub2ymBCAVadKsVD9mJ7gjhPVjQ4emvvFMHH
	 B7UBZbise/lMdGeph+T65WdAzrvFGcG/HK9/sF7RFa0fo5ldXBaXgJlmCDRItrp0EB
	 JaL2HE+rw2kAQF875YCkcdzkF1FD3pW/S/4Pd3QFrDtjJ531CfF+1BztJWPI9z1Yv0
	 HOJvzMGb9mmFw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Michael Guralnik <michaelgur@nvidia.com>, Shay Drory <shayd@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>
In-Reply-To: <cover.1725362530.git.leon@kernel.org>
References: <cover.1725362530.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next 0/4] Batch of mlx5 MR cache fixes
Message-Id: <172553229176.1771917.2133057589640587555.b4-ty@kernel.org>
Date: Thu, 05 Sep 2024 13:31:31 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 03 Sep 2024 14:24:46 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This is a batch of mlx5 MR cache fixes.
> 
> Thanks
> 
> [...]

Applied, thanks!

[1/4] RDMA/mlx5: Drop redundant work canceling from clean_keys()
      https://git.kernel.org/rdma/rdma/c/291766e6420e72
[2/4] RDMA/mlx5: Fix counter update on MR cache mkey creation
      https://git.kernel.org/rdma/rdma/c/cf047a4d734c28
[3/4] RDMA/mlx5: Limit usage of over-sized mkeys from the MR cache
      https://git.kernel.org/rdma/rdma/c/24e58150b7c370
[4/4] RDMA/mlx5: Fix MR cache temp entries cleanup
      https://git.kernel.org/rdma/rdma/c/8a1e4024cc963c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


