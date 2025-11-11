Return-Path: <linux-rdma+bounces-14400-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBF1C4E781
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 15:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313793A7C9C
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 14:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A24D2DE707;
	Tue, 11 Nov 2025 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbUxHHMz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123A5274FDC;
	Tue, 11 Nov 2025 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870837; cv=none; b=sFjy+cNGmjReD1dTLqmj/AUntHr/3zocYXI6+fNSu9reTWYIzYS+9rNDES380HdLHf5uhjox4BQB3zdxCqJhL69ZAqQW4rkilch6qKOleXt9fhcAt5EHgdDtyr3XyuuhTcoRNWAHRjALtQNfNJvQNSoptY1rLRVODby0BFi137k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870837; c=relaxed/simple;
	bh=RQjFils1y0Bwx97xIYL2BuLLK99JFpYGzWQwK+a2AaM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uVjILegwP1TIoV8XMfJfVi+gj9fSiM097l3PKOxaT+cgcBybM11HS0xmpZdw/vO+VheEVljSDlr82st6FxEiiDIE56/X3u+7Ey5Ij8XXQYl0Rm4Z0MADvB++UyZHPh/yaBfxcya2ZcHhQijmdIKiyjbP07/UG2MxkdkHdXnoQHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbUxHHMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710D6C4CEFB;
	Tue, 11 Nov 2025 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762870836;
	bh=RQjFils1y0Bwx97xIYL2BuLLK99JFpYGzWQwK+a2AaM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bbUxHHMz0u6JxO9NtmKP0M4rYuqm5sxya1J0W9UfBkogmnO8c/0kXA1IA4KU8xVR5
	 V6iXS6N8o9JrAp2SoPNJ+S7Nrf9be0uVwJVf1OLFNIXqXRLmWLF0X0Nh0lr64zy7ka
	 0Nm5RF0cDvExJ4T52fH14VCdI0xxkoQFyDfTCRt2QJfG9VpTE3pzyaxxUOTaYNgxaZ
	 dV6fLnOyu7zR0io/0cBb9WdQqJ4jHR9zojdgHeYDoXKaL2cJK1muy9G3JbpzN+sVNi
	 hs/fAWPMSBuXeLdqEmyRpulbSGKpUqMJ9KhUiSuMoFn65bUc/HYmz0hO8D7wntJWQQ
	 nTopTCiLSUb8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEE7380CFFB;
	Tue, 11 Nov 2025 14:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mlx5: Fix default values in create CQ
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176287080676.3459007.4131073322083276790.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 14:20:06 +0000
References: <1762681743-1084694-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1762681743-1084694-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, leon@kernel.org, jgg@ziepe.ca,
 saeedm@nvidia.com, mbloch@nvidia.com, dtatulea@nvidia.com, mst@redhat.com,
 jasowang@redhat.com, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, gal@nvidia.com, leonro@nvidia.com,
 edwards@nvidia.com, moshe@nvidia.com, agoldberger@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 9 Nov 2025 11:49:03 +0200 you wrote:
> From: Akiva Goldberger <agoldberger@nvidia.com>
> 
> Currently, CQs without a completion function are assigned the
> mlx5_add_cq_to_tasklet function by default. This is problematic since
> only user CQs created through the mlx5_ib driver are intended to use
> this function.
> 
> [...]

Here is the summary with links:
  - [net] mlx5: Fix default values in create CQ
    https://git.kernel.org/netdev/net/c/e5eba42f0134

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



