Return-Path: <linux-rdma+bounces-1839-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B0A89BD57
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 12:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20FD1C21D65
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B75558230;
	Mon,  8 Apr 2024 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLViwjtm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF97557882
	for <linux-rdma@vger.kernel.org>; Mon,  8 Apr 2024 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572527; cv=none; b=GRi1TwDsmav1fIlkKeel5dfVcTGhEQzxa50GFilWFq1uhxS5nzwvd9jFJ224d8MXombZzCKejjLLXf73axwhXlymnCgnHGuuJBDJtXzgJ+aig6qYnuOtYTiEUr1gOMnG9uotA8dBhb7H2NqiajTB1kUnixGGmf4fTB1q8JzDyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572527; c=relaxed/simple;
	bh=GaZiGVWEk8GoiuIVTWLzZNGHmkaVzOajuYxhgxFZ4ew=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LkTdc5WHllLykZ9eplmWEYdPDptRYIGsnPHdvjw6yiJtlQ6ZZ5yw4nICn5YPhBcton1zIr/Lz/eBZMBj0LZJ6giUbgrZmiWCN+kkr0YqM86dUvQI/nje2oaHIIrPcMAixADAiK8swcuL2m24syoKCc5tohlVVh41S+vK6aYtl7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLViwjtm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066EDC43390;
	Mon,  8 Apr 2024 10:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712572527;
	bh=GaZiGVWEk8GoiuIVTWLzZNGHmkaVzOajuYxhgxFZ4ew=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iLViwjtmGWy7RtV1Q9en5Zscg/9V+0a2dm4YGShTyQgI7GILkDBpa13sY6WpXNyFQ
	 8Mj4MDpiGpkcHcC5G0f7RsvUONJfICPLvTgVpOmz1l06ZDLtMVzeOIjWh/clK1R39Z
	 vLuHz8xPalT3IZ03Xz2AvtrYCRXq6gsbO8053o8IhzFKFfKJH7eEOj0Rl9jdsqO/2p
	 PcWtFDZd3dferqp7DBTI5YuWMsVLJjItbmAhQiszcLFHIM7bkB4p9q/x58mzrsvRpc
	 mCAhwySZfaqrS082sLxg/ZBHWNx+AqCD+lTzBwSziLZX3ktf7hLvJ/zTKmOd+q2DZP
	 vB/4dt4qSbbhw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Michael Guralnik <michaelgur@nvidia.com>, 
 Or Har-Toov <ohartoov@nvidia.com>, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <cover.1712140377.git.leon@kernel.org>
References: <cover.1712140377.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next v2 0/3] Rewrite mlx3 mkeys logic
Message-Id: <171257252420.54501.7225632184008065959.b4-ty@kernel.org>
Date: Mon, 08 Apr 2024 13:35:24 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Wed, 03 Apr 2024 13:35:58 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> This is rewrote version of [1].
> 
> [1] https://lore.kernel.org/all/cover.1706433934.git.leon@kernel.org
> 
> Thanks
> 
> [...]

Applied, thanks!

[1/3] RDMA/mlx5: Uncacheable mkey has neither rb_key or cache_ent
      https://git.kernel.org/rdma/rdma/c/0611a8e8b475fc
[2/3] RDMA/mlx5: Change check for cacheable mkeys
      https://git.kernel.org/rdma/rdma/c/8c1185fef68cc6
[3/3] RDMA/mlx5: Adding remote atomic access flag to updatable flags
      https://git.kernel.org/rdma/rdma/c/2ca7e93bc963d9

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


