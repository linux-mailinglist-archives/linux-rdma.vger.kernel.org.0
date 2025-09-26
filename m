Return-Path: <linux-rdma+bounces-13677-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50566BA4FE2
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 21:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E1187A7A29
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 19:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD451283129;
	Fri, 26 Sep 2025 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BD90N6Ry"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44957280308;
	Fri, 26 Sep 2025 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916215; cv=none; b=DzEu9rEtHky0O9c6/EmpX98dDTdJA8xL2gnbEMxkwMjCGkKyjvdTpU4Wo/PHwAf2Uf6d6oqSXkJVBjAh/3Aw7qweEN+07wuyNxSFddVw/wy5OVCRDjnnUkCPuiGZahEz1DBMO6cxjRIDWiUhfvPJZtUMvvFVEQAFlq+PuYacCUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916215; c=relaxed/simple;
	bh=jbqfYO7LUYlssd2poqpVXDaCMPuZwPS8Lp58xLAuLXY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jNVthGQN+pXLxmNoEfp+3amcwk5oHKA/Cb1L0TdCpt8D8t+dRMl5yrxSxki6NrTVHI2cxOFDS5dOE0uxlaGIRvoMHLjET1tILUGqCrCff1ChcgAPix6DoPGb8iss6ZXWDA5XRBSm/sJZy/C5/0m4iC2xvIv4M1fNZSjx2XUAaw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BD90N6Ry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEB1C4CEF4;
	Fri, 26 Sep 2025 19:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758916213;
	bh=jbqfYO7LUYlssd2poqpVXDaCMPuZwPS8Lp58xLAuLXY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BD90N6Ryx9yYAjKUDF15q7bFLe8x1kcG2ze9J8zXb5kSOzYrTNzPJkJHmskb5nCkG
	 8ivdByzir5dKPwiALp+aFgv7pJVybId2W2WGuFAW0JRyYPnKnQjss94sI70q3LS4jU
	 HPn8C8gqpZdESk61pEPi7wj/259HM5aa0zAo9Mu75k5jk5ouRTUdkNrP+jOpMgWykz
	 mSc4mMO/ih8PUIclSj8yhgUvyvqpRFk05+/PzrwjzIah7OFC6DPmnz1Aw7tWEwi9yd
	 HYO2i5rxGdVbtfTQz9JTOeRmHac6389CM5u8VoLblYG2xrjr6q4Af209Kh8xyr3f1l
	 O7xZ9O32m/4JA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4998C39D0C3F;
	Fri, 26 Sep 2025 19:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] scripts/coccinelle: Symbolic error names
 script
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175891620925.36020.4383105129946487821.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 19:50:09 +0000
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, Julia.Lawall@inria.fr,
 nicolas.palix@imag.fr, richardcochran@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, cocci@inria.fr, gal@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 13:43:45 +0300 you wrote:
> Hi,
> 
> This small series by Gal adds a new coccinelle script that spots
> potential transitions to symbolic error names in print functions, and
> then uses it in mlx5 driver.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] scripts/coccinelle: Find PTR_ERR() to %pe candidates
    https://git.kernel.org/netdev/net-next/c/57c49d235572
  - [net-next,2/2] net/mlx5: Use %pe format specifier for error pointers
    https://git.kernel.org/netdev/net-next/c/b89cd87b77d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



