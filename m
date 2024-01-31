Return-Path: <linux-rdma+bounces-821-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E31CA843AE2
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 10:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995F61F2AF9F
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 09:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F376997C;
	Wed, 31 Jan 2024 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e61CEhRC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145BF55E57
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692575; cv=none; b=NKihyzaWrpyHI1MDe57P0a9UVOnyIbz1GvqvoFqcKIu61IyFuAx/7BFIOarnwzIlHSsFGPW7ftjrIIXbWcuVsDpj8YWHu4wASfXPeua/yYez2nrntcJqllZv6JIK3ti7l9qNpm5oXMYi7++ydxe3qKMPQijkW8HkuyJAHedcrYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692575; c=relaxed/simple;
	bh=wigbbYYJAV7mhljisV0g+K1qCrLxlhtWjs0TGDiTuBs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aqJXeC0Hx5gvASEv0/cAcsAlO9gVWP0OinnqZ6UQQ2EeQCIqoWyVa8l90mau3Rmh5F4nHRX7W3laUDc1Amr+H3TEMrwqmhoKE7aldALDCngSk1C1nhsy3Pu9GeRSeflScKI7iN0kFUQcJn7LkoA26Tg6Q1jCxYbg1e3E2m6/Hro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e61CEhRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC52C433C7;
	Wed, 31 Jan 2024 09:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706692574;
	bh=wigbbYYJAV7mhljisV0g+K1qCrLxlhtWjs0TGDiTuBs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=e61CEhRCUCHpu2LOvUdRFryf9/kne6mZE8g5XXguffqYyZxJMTc6Y/XMf/HGVqCV4
	 hV/ZyhjAyLbIvdffCazUF7fpblx92lsACXXRjmgRY1NXlV9kL1Oih6zx/XxhQ8aO92
	 /Sbbu6iz3850HspiGGxu9lbLdmNliu34HXn6CFFsI/kivAf4lv/S2qTz/NdvquAe0L
	 MBILKsy2dzLi27ZP8NGu2Xrtj8lCqlmDjazcwmGnxaTYidMMdhEUewXTZSClRHd6il
	 mI3OP0UcepDYGhLvPDkdGidMaY1Go9v9e6ViBeQn+4OQwp4H7mDoipn686LI+Fg0Ci
	 nZA7dtIPqoVtA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
 Maor Gottlieb <maorg@nvidia.com>, Mark Zhang <markzhang@nvidia.com>,
 Michael Guralnik <michaelgur@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
 Tamar Mashiah <tmashiah@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>
In-Reply-To: <cover.1706433934.git.leon@kernel.org>
References: <cover.1706433934.git.leon@kernel.org>
Subject: Re: (subset) [PATCH rdma-next v1 0/6] Collection of mlx5_ib fixes
Message-Id: <170669256955.202005.4624056519882229779.b4-ty@kernel.org>
Date: Wed, 31 Jan 2024 11:16:09 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Sun, 28 Jan 2024 11:29:10 +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v1:
>  * Changed function signature is_cacheable_mkey to pass pointer and not value.
> v0: https://lore.kernel.org/all/cover.1706185318.git.leon@kernel.org
> 
> [...]

Applied, thanks!

[1/6] RDMA/mlx5: Fix fortify source warning while accessing Eth segment
      https://git.kernel.org/rdma/rdma/c/4d5e86a56615cc
[2/6] IB/mlx5: Don't expose debugfs entries for RRoCE general parameters if not supported
      https://git.kernel.org/rdma/rdma/c/43fdbd140238d4
[3/6] RDMA/mlx5: Relax DEVX access upon modify commands
      https://git.kernel.org/rdma/rdma/c/be551ee1574280

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

