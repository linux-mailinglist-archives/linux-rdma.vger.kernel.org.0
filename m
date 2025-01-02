Return-Path: <linux-rdma+bounces-6776-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8780A9FF7AB
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2025 10:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25AE188047C
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2025 09:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE081A4F22;
	Thu,  2 Jan 2025 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6j98rEr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84D19A2A3
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jan 2025 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735811330; cv=none; b=FmMzlhMxdJU5ta+HumQRne7P4i8sV8wXRFp0bkOi8Hl4jZBk1CgTlSkj937xYiOkMMHFOjnuRCnvRwFr/KyNkDlRzXb8Z1OqDSQM1A1IHuUivrQThn2eS2fGQNAPgyWiKIyIwZjdUHVls4CwWFvFldBrWtoSa18ykBF15uoDUw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735811330; c=relaxed/simple;
	bh=Q2YcoKPvAY2CKsxyBqL9Ks3lfBWBlnaRG7+0SgYNYpA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cP4TgqasWYbGjzAUcbutFtuZQBq1+nV0IscustR6gs3Jyf8ygefDs5vyRr+bo6YUN7+hOw/N0nalID3kNKQRCu7Wcun8/DDaZiMKYN1oSo3qbfeCNBUjEB083QqUVX0H+qMZ55PCfC5KGVsY3FYP3tZvcwXS07MxdgWG4fE1RtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6j98rEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C59C4CED0;
	Thu,  2 Jan 2025 09:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735811329;
	bh=Q2YcoKPvAY2CKsxyBqL9Ks3lfBWBlnaRG7+0SgYNYpA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L6j98rErdjMDFn/sYyRacr10g67TFleWXqgNrXIloh2nMYl56rIsH88/sNtVCtbYU
	 ifkgxwajb+dA9FmgpPKGue2rEdvauKD/tdu3mK9IBI04OHyun8v8IxzGxDzdduhrpT
	 ujVgM8E1WTUVxLH5qBWI/AmDeCRrIAt95KReMP9OygkEl2Yv6gLMo5nTAQ/3NIadiq
	 G8pq/LS/SkXVXp3VvCz56Z0Jg/iyNeo5/GhpgsLrfNF8UFtYrotM8sFlwigCUbDwDG
	 /AWpiT/9EltpATJCEIcQvXpMAYn04rzaeFapa7VLbq7SBY9q4p853rSsIuxwbhCVfs
	 xf2lmZsDD+PCQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>, 
 Junxian Huang <huangjunxian6@hisilicon.com>, linux-rdma@vger.kernel.org, 
 Maor Gottlieb <maorg@nvidia.com>, Yuyu Li <liyuyu6@huawei.com>
In-Reply-To: <d7731478e456f61255af798a7fd4e64b006ddebb.1735567976.git.leonro@nvidia.com>
References: <d7731478e456f61255af798a7fd4e64b006ddebb.1735567976.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Fix link status down event for
 MPV
Message-Id: <173581132636.147384.2346327182250671636.b4-ty@kernel.org>
Date: Thu, 02 Jan 2025 04:48:46 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 30 Dec 2024 16:14:04 +0200, Leon Romanovsky wrote:
> The commit below prevented MPV from unloading correctly due to blocking
> the netdev down event, allow sending the event for MPV mode to maintain
> proper unload flow.
> 
> 

Applied, thanks!

[1/1] RDMA/mlx5: Fix link status down event for MPV
      https://git.kernel.org/rdma/rdma/c/220043b06fded9

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


