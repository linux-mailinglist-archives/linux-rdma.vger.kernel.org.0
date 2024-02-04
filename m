Return-Path: <linux-rdma+bounces-879-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2867F848C81
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 10:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328451C21099
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 09:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50611802B;
	Sun,  4 Feb 2024 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOmH38dX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52A21640B
	for <linux-rdma@vger.kernel.org>; Sun,  4 Feb 2024 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707039427; cv=none; b=J98OdFH8L72RP95MsqQr9djJX9kUvJ+Sg4Wa7wGGJNJ4OhQ4PLAKy+Xa99BsmJ+OKAUahuOKsBcobKUGtllxB2pNqvwGSNZDOU7kh+vvUePKodSSKIJ2IQ5j1O70SgPZUMhxNQgJD67rNTzKftfIY2EoviMpMbxG9qV7sqanSpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707039427; c=relaxed/simple;
	bh=MPS6O2WEGyAv0YyoXrEnMmjs4ZGqEK82K27ROKq6Z8U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NEErq4LUvEdqMaYz/mSebNV99llFrQRoIA3jpi2PsdUTvxQz2OtFVixMzhytYX/zVKGjF9E+YBngr7RLtafa2cVE5pTTenaIy9Si56vOixpNH+UN4X/sXsC+Ras8Om+rK+GEcYE6d9DSe9b/gZXUHXptD7dY++aR09Hj/72VkXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOmH38dX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF71C433F1;
	Sun,  4 Feb 2024 09:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707039427;
	bh=MPS6O2WEGyAv0YyoXrEnMmjs4ZGqEK82K27ROKq6Z8U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jOmH38dXexcihA4TStZ3uL3qQskac6pgNp+bFLRXbaA/xRQwjNpjeVs6L1UvqxFfP
	 4e4I0X63xUGHNwO6+IfANe6jCpWpVH/N3E2aqW7mptowepmowqfECSSFbyy6yCT0sM
	 hbzh3e0qKkxLHSTx8d1K2psY4tUNjey2k+NjigPdc8b2ZlNKmgwm6rMZ97FTsbttR1
	 j2TvIidoPdBT0b2NALEdafuphgHg6T7AET2/Z2wRaf0vDdhX1Q82lFb721u7M//4Wk
	 zHM8HE6GhBlBUW9naHBqnpkhDz6I0jNVLpOVd7o7w7H4QW7IXTZM8vVnrdTAeh6lsg
	 XYe/31W55gHxw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Sindhu Devale <sindhu.devale@intel.com>
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <20240131233849.400285-1-sindhu.devale@intel.com>
References: <20240131233849.400285-1-sindhu.devale@intel.com>
Subject: Re: [PATCH rdma-rc 0/4] *** irdma 6.8 rc fixes ***
Message-Id: <170703942310.15159.13463842021035817184.b4-ty@kernel.org>
Date: Sun, 04 Feb 2024 11:37:03 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Wed, 31 Jan 2024 17:38:45 -0600, Sindhu Devale wrote:
> Small set of fixes for the irdma driver.
> 
> Mike Marciniszyn (1):
>   RDMA/irdma: Fix KASAN issue with tasklet
> 
> Mustafa Ismail (2):
>   RDMA/irdma: Set the CQ read threshold for GEN 1
>   RDMA/irdma: Add AE for too many RNRS
> 
> [...]

Applied, thanks!

[1/4] RDMA/irdma: Fix KASAN issue with tasklet
      https://git.kernel.org/rdma/rdma/c/bd97cea7b18a0a
[2/4] RDMA/irdma: Validate max_send_wr and max_recv_wr
      https://git.kernel.org/rdma/rdma/c/ee107186bcfd25
[3/4] RDMA/irdma: Set the CQ read threshold for GEN 1
      https://git.kernel.org/rdma/rdma/c/4823a004d8301d
[4/4] RDMA/irdma: Add AE for too many RNRS
      https://git.kernel.org/rdma/rdma/c/772e5fb3884306

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

