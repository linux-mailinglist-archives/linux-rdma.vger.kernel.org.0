Return-Path: <linux-rdma+bounces-15677-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3636D3980B
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 17:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37F4A3009AA5
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 16:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C742248B3;
	Sun, 18 Jan 2026 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChGWQnCy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE6207A20;
	Sun, 18 Jan 2026 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768754248; cv=none; b=lv5lfR1Wl215DOO1gi3c3K8g3Ul43MECis0nqkFYu089HehllWk/ye9fISM600CuGVrJ+qd3Jtz/gNNJ4PekigcXaCqw5zlZRWF0ZZVNC6MIMVD6dZYE+IJ3kLiqHxd53MjamVzNSNnz2OuY/8oz4wpluV7ijVwDsMonArnhEFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768754248; c=relaxed/simple;
	bh=mbZXAq1LrAbZLI1sQpVCaTFH1Y2eE2n7IubAHF00pgs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KoauIJTiug3AhBWkMJsVMjwzo1FxqXZ8tSW+S2eQc6T/Lc9J4fgKzo2Blo9ddretqEAibaOai8Moe5L3oOd4y5uFv6JCsqYDpaXEmpwO4CJTiPLinatCkLoo8MNX7Mii83X8BB22CENpcMLkSGEP4ifHytJZ01seBlLBh6y4fAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChGWQnCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311A3C116D0;
	Sun, 18 Jan 2026 16:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768754248;
	bh=mbZXAq1LrAbZLI1sQpVCaTFH1Y2eE2n7IubAHF00pgs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ChGWQnCyeBEWJ2glHHjZGAcqkKA7B2VQxZd7SMttVkjfXy46SU+2OQFqJ8n9bE2Q4
	 Ky3hrhLrsBpGvhRjdbscoTtQvcuRXFe+UpYBNlJA//GWViPnca1bcEIIfnKi28+7gm
	 XXrXI820ZJMVnipAqbSff9Opoz1de2kSQZNgswNRShkTRINabO1NRTzTVXJ09AkyVB
	 2+soBIorfmrWmLtS0SZVZG9LJvT0OZFcnRw7GBO1CBd3E2PyD7mqQ+US13N9huiOQC
	 J3bGMj2MQSMIC50sqUwjHQplKIji0lBURiKg8EiAgte2+PlVxiq2X34mGMWpFYpEIO
	 ZRzCUSdJgkePw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Mark Bloch <mbloch@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Roi Dayan <roid@nvidia.com>, 
 Edward Srouji <edwards@nvidia.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Or Har-Toov <ohartoov@nvidia.com>
In-Reply-To: <20260115-port-speed-query-fix-v2-1-3bde6a3c78e7@nvidia.com>
References: <20260115-port-speed-query-fix-v2-1-3bde6a3c78e7@nvidia.com>
Subject: Re: [PATCH rdma-next v2] IB/mlx5: Fix port speed query for
 representors
Message-Id: <176875424557.525875.9169723751972889928.b4-ty@kernel.org>
Date: Sun, 18 Jan 2026 11:37:25 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Thu, 15 Jan 2026 14:26:45 +0200, Edward Srouji wrote:
> When querying speed information for a representor in switchdev mode,
> the code previously used the first device in the eswitch, which may not
> match the device that actually owns the representor. In setups such as
> multi-port eswitch or LAG, this led to incorrect port attributes being
> reported.
> 
> Fix this by retrieving the correct core device from the representor's
> eswitch before querying its port attributes.
> 
> [...]

Applied, thanks!

[1/1] IB/mlx5: Fix port speed query for representors
      https://git.kernel.org/rdma/rdma/c/18ea78e2ae83d1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


