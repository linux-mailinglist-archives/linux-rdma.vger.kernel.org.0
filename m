Return-Path: <linux-rdma+bounces-12084-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56702B02F0F
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 09:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EAA47A5800
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 07:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E411D435F;
	Sun, 13 Jul 2025 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH5f2V3v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1E48F4A;
	Sun, 13 Jul 2025 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752390897; cv=none; b=skEKp85ar48aoxEwYG3WUVLA8VkzYp7sia94oI9mDRKJ+ucONoW/5f9rwQiETgj3HGU498/Os/owac5ns7TPka/u9y1Xj0hCCLnWy8BfTCZGJAUehOsXvlUDMRDN85DB4zJ6pDAGHp6uFYq8CrEWPuvnC6XyZOC7KBn35P2bUI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752390897; c=relaxed/simple;
	bh=DWoShqJCacNMYjbFY9jG4uOcA67zWP+z4+7RgEWN+sc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XfoHFWh6XePMxEsOtYhc17e3bcyoFMje8jKpdQGmicojYfcbTDN3XHwvvNTTPRlxzBFhU1j1QE/5rY//ubKeCKyNS6RyuOrFHnV/avf+45KaLMfoq3lImelgOuC5KicfVr8slw4ddXw+faBH204ZXEFANQRlGdd1VDuaxhAaMyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH5f2V3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E31C4CEE3;
	Sun, 13 Jul 2025 07:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752390896;
	bh=DWoShqJCacNMYjbFY9jG4uOcA67zWP+z4+7RgEWN+sc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UH5f2V3vr8sU9cVzIGoQU7xwBce+Dlke0SPUHA2gLfqRSvn1Ts+tq99oCGqw7Eit8
	 kirk/SB+MhowjYYm+STEx1UKFqIozL7HDKClIVqZHE9NGJm6QatN1KstdQ2ZTsIboU
	 wfPxIaufw46IxyOii5GuHmjebDiYJYxstTzt183XvfsVUgcBLTmx/qJvqwTK1dBb20
	 XhoXoj4edcM2lT1fFeP6ha5W1QkwOhyJ7ofwWtOZiSYGEfQ7oWiRcfVUz05qU3+oUE
	 Yx/tCeDp9QCtAdm6SpAcWpcmzrSFR0qF54gDh4ASfpD/9Epz7EYqOtkehjlbowK3GS
	 yA9Sc6DYTGgZA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org, 
 Michael Guralnik <michaelgur@nvidia.com>, netdev@vger.kernel.org, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <cover.1751979184.git.leon@kernel.org>
References: <cover.1751979184.git.leon@kernel.org>
Subject: Re: (subset) [PATCH rdma-next 0/4] Optimize DMABUF mkey page size
 in mlx5
Message-Id: <175239089340.73869.8008024617618167954.b4-ty@kernel.org>
Date: Sun, 13 Jul 2025 03:14:53 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 09 Jul 2025 09:42:07 +0300, Leon Romanovsky wrote:
> >From Edward:
> 
> This patch series enables the mlx5 driver to dynamically choose the
> optimal page size for a DMABUF-based memory key (mkey), rather than
> always registering with a fixed page size.
> 
> Previously, DMABUF memory registration used a fixed 4K page size for
> mkeys which could lead to suboptimal performance when the underlying
> memory layout may offer better page sizes.
> 
> [...]

Applied, thanks!

[3/4] RDMA/mlx5: Align mkc page size capability check to PRM
      https://git.kernel.org/rdma/rdma/c/fcfb03597b7d77
[4/4] RDMA/mlx5: Optimize DMABUF mkey page size
      https://git.kernel.org/rdma/rdma/c/e73242aa14d2ec

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


