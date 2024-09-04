Return-Path: <linux-rdma+bounces-4732-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 013F696B374
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 09:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14061F264BC
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 07:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EB7156871;
	Wed,  4 Sep 2024 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adsOPcEr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D5B8121F
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436249; cv=none; b=K4E8kGMPMoTUEAOr3e0WMpiKscbUsW3QnDB9UhEV6jFLirtHulrSNQ6Z3Xi6naxQL38KAu4KxjNO1upjEYlbvZXbgPozELMowA63nXXuXJ5zS9FXPxRyQdkPBGO+8YRapU3lZfowmsMyyHq/i6ozA275NGlYcfXWgonvF1+q9wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436249; c=relaxed/simple;
	bh=B2sQq3D/rM2ACqXKFHjJrMQnAnijsQWQWkmK1u83+hA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ui1fnsYSDIYFNEEZzgzENKbVN0aXmCR4tsD6qoOyj0p9akIDJJD06dazozOl9P+FYkMH6U/JS6QzNdws5S66v10NMmdDKm0RfJ3I9PD/a0lHv6wvFrS53+g0K2OIW+bYNGkjtzJgjnmGwDalLtI6hljghNgdNwudgkZzgtQqd8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adsOPcEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2655EC4CEC2;
	Wed,  4 Sep 2024 07:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725436248;
	bh=B2sQq3D/rM2ACqXKFHjJrMQnAnijsQWQWkmK1u83+hA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=adsOPcEr6I6B1GbBCQ+fxbp2AS0pMXFRLROclILNqWV6rbjIx/kEsuQVjQOl62RMm
	 L1EoXgQJVtXvEURBEli3jiAQcYTruUkKXI0jW4+q5OelbPwL51Zw2HPWCdb7Pu6pj7
	 4a4PtcdVVMETPIF71uDrXtUeh6y9TFnp9AgwzhYiommOnEaW5gNpmGbROGLLBoU3ez
	 bfBRZeJH5bCWXWCv7aCJndnUrKRD2lkh16N/h7XYrOJOFboVOL1cYuVdrQoWzZEI7O
	 rH1ieamnAJwhQpa5INcYOqCRLbOK9c69asgAaXmsM2Bi09n+8YgV7bGr8Jx1E+3frq
	 /LmZ91pekdvPg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Maher Sanalla <msanalla@nvidia.com>, Gal Shalom <galshalom@nvidia.com>, 
 linux-rdma@vger.kernel.org
In-Reply-To: <fafd4c9f14cf438d2882d88649c2947e1d05d0b4.1725273403.git.leon@kernel.org>
References: <fafd4c9f14cf438d2882d88649c2947e1d05d0b4.1725273403.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Enable ATS when allocating MRs
Message-Id: <172543624490.1199574.548381938434602647.b4-ty@kernel.org>
Date: Wed, 04 Sep 2024 10:50:44 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 02 Sep 2024 13:37:03 +0300, Leon Romanovsky wrote:
> When allocating MRs, it is not definitive whether they will be used for
> peer-to-peer transactions or for other usecases.
> 
> Since peer-to-peer transactions benefit significantly from ATS
> performance-wise, enable ATS on newly-allocated MRs when supported.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Enable ATS when allocating MRs
      https://git.kernel.org/rdma/rdma/c/6a0e452d7fcc09

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


