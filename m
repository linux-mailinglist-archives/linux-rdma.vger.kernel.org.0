Return-Path: <linux-rdma+bounces-8927-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B55A6E695
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 23:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E81174E55
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 22:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FEE1EE032;
	Mon, 24 Mar 2025 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnU9c7f4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C55B17E0;
	Mon, 24 Mar 2025 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855397; cv=none; b=AP+I8X2dP0tA1KJQwL9e4cvtu6EQwuTbAJJzMfAykLpW2C1wkVZfpSLdRIoticnGR6QBMwMjF1wKiGkZoYzMKhyBHy+6VK1HSq/azrR0pcAGogMyloTObEH/yhvikjb54RycvtavgB8w5p3axUywBB2RxMX10lI1D7abNRzmgZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855397; c=relaxed/simple;
	bh=Uf7hKjTBqJosdjHH0BMi+k91QS+QBSTLz9F+9bYV3i8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FdFGHBsE/a9cRnbCXJVFH4GWbcuhztP2igWDX0XJQmh1qG9TsKxsELQkhDuOMOyZTaA+4HaxVAq+1iVrraoFjU3x6SBHedxgqpveNMn6SXlgtm6t6HzgQzKp2Vuz0/upUh5tCzEK+MOTlqTuTzzBQnD6wYhw5BYVYv+txxwhrvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnU9c7f4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CEDC4CEDD;
	Mon, 24 Mar 2025 22:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742855397;
	bh=Uf7hKjTBqJosdjHH0BMi+k91QS+QBSTLz9F+9bYV3i8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GnU9c7f4Gr8/nobTY9nbGBCylfmbrTJbh019f+Y1MN+LcCoAaz0m1NPIJZD2PyYh0
	 4PogJ8B2DegTLIWG926ePEYNzCIcYVNH4ZWIyVr8SjEg0Buu1mgFlfra/E3ErjgJSZ
	 xkvyr1z8x++69jyhOyFkD25WeRiTsCxaYaM3/ahAJbex0qZkvSWjISrPU8xCBDuP3a
	 jkJx5kksEtXSFKQp2ejI0kKi4qOOP16TVjeS2NaHOMEwGAajCL/B7lDySBDX0nAzte
	 2Rn74y4Pp5jAZJghgMuYqPKhAzjMErsM1KEGpZaqMUhEyUGo7ULOtSBEqNGGNYlads
	 7bR/djr59me6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F3C380664F;
	Mon, 24 Mar 2025 22:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mlx5 misc fixes 2025-03-18
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174285543328.6006.16335198386099285028.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 22:30:33 +0000
References: <1742331077-102038-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1742331077-102038-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, gal@nvidia.com,
 leonro@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, moshe@nvidia.com, mbloch@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Mar 2025 22:51:15 +0200 you wrote:
> Hi,
> 
> This small patchset provides misc bug fixes to the mlx5 core driver.
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/mlx5: LAG, reload representors on LAG creation failure
    https://git.kernel.org/netdev/net/c/bdf549a7a4d7
  - [net,2/2] net/mlx5: Start health poll after enable hca
    https://git.kernel.org/netdev/net/c/1726ad035cb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



