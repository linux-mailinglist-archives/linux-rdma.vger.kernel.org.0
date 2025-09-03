Return-Path: <linux-rdma+bounces-13073-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31950B42C8D
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 00:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C4C17AA48F
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 22:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA762EDD52;
	Wed,  3 Sep 2025 22:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/z3YDuk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59FC2ECEAE;
	Wed,  3 Sep 2025 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756937403; cv=none; b=uYjK8rmA873hWeLhX7FdjG8i/P0cWcl1Pqg8fhYqx9/YKDFxIi28jCOGOgyubJoIRkcnc4GSX6r1YqhJ7MULkWUIrCrpUO9Zpq5+WXUoj7CPPJZ/sqxX6DOyOj5BWu3HV1rpAS1k5FbTpK1c9ucptF+l8ysd1Kk9ZXCVB4TuQT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756937403; c=relaxed/simple;
	bh=cJLDDvPcPL4O4YAzuxUUFnnO+/RebYjcF6y3auColIE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H84E+GGe8IX2HXncvNdNWZi22sn3kdwL2gcU2l6sTyRccUHZtFuen2V8uf1mB7yQqK/12B0ZShye23ycGB5z9PPwr/knI4AhutLQ/mkz/YOPeMMITr2k45VS8tWJl7KaFvda0/7eeR+sDap5EyGCJ9qZ/PL1fJGmmWksEOHQ9zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/z3YDuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680CEC4CEE7;
	Wed,  3 Sep 2025 22:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756937402;
	bh=cJLDDvPcPL4O4YAzuxUUFnnO+/RebYjcF6y3auColIE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M/z3YDukG4DzBpvAw3wQlZxaA2yf3Xcj9l2r6kCR+Br+cBNwFWZABrRP2c95NtezD
	 tkIeY+mk0tHMaBYSjQ5bwbSeVFwDPM+xt7lMrWFrUUfk/rWhcRU3zkkz0zfRHlywTo
	 j59KNUBlYMasit5z9odTYFTY27eTYzWXOms/l/zWrYK7mZPktOJiTa/UZQe3hwoq+a
	 BIUhxQsIqfhzhWRFecsJ+152kxdw9UUzm/nKeRaXaO7e/O0aszTltn1AudnHuH3xtF
	 c05gK2vqlldHRer8GAJ/WsimQ+iNWC683se0szDRVRL+CHh5bqaoeLQxMiOLx+AhqN
	 j0JMXfoe7zQCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC32383C259;
	Wed,  3 Sep 2025 22:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] mlx5 PSP IFC bits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175693740749.1217361.16080488330185740117.git-patchwork-notify@kernel.org>
Date: Wed, 03 Sep 2025 22:10:07 +0000
References: <20250903063050.668442-1-saeed@kernel.org>
In-Reply-To: <20250903063050.668442-1-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, jgg@nvidia.com, saeedm@nvidia.com,
 linux-rdma@vger.kernel.org, leonro@nvidia.com, netdev@vger.kernel.org,
 mbloch@nvidia.com, tariqt@nvidia.com, daniel.zahka@gmail.com,
 raeds@nvidia.com

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Sep 2025 23:30:49 -0700 you wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Hi Jakub, Jason,
> 
> This PR has a single patch to add mlx5_ifc PSP related capabilities structures
> and HW definitions needed for PSP support in mlx5.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] mlx5 PSP IFC bits
    https://git.kernel.org/netdev/net-next/c/0e2a5208cc3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



