Return-Path: <linux-rdma+bounces-13072-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FF2B42C8C
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 00:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A03267AA4EB
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 22:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CD32EC0BF;
	Wed,  3 Sep 2025 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko6oU/8q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F272E62B3;
	Wed,  3 Sep 2025 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756937402; cv=none; b=NC5PCdZZZjiUJ0LASlxWprgv4OUu6jSzQYT9SjRoanTLvFcRxhR7myOMU4qpLLQDe6+sqk+8FugqdMTJrsldZqF3CCmxBqR7Zjuc4ivT+HjjiCvf7Ik1Chz1Tg/yTedOMWAv4Wxcz3uCKPoMdIusjpzXPQQQI/D2tQXGnPkqip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756937402; c=relaxed/simple;
	bh=QfaT9OiSqbUSoOuU4wwCC/v88A3txMCqwpY40/rFaOQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eMAsSo+aOl+y1YjHeYAjsdHOhwS0TDrQAWGl06WHjf8AwyjPev9bN8sQuIj8zImMI1gpsoHNL0Thfjbnzr6Yv9SzfqCitcta6hs1VCVlQPlxuawnqCZwhXxIhtzBsXRgc2TbKMKC1nBfAc6iwPAcejCx0PHiWNUCgpXxG98SrA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko6oU/8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3691FC4CEF4;
	Wed,  3 Sep 2025 22:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756937401;
	bh=QfaT9OiSqbUSoOuU4wwCC/v88A3txMCqwpY40/rFaOQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ko6oU/8quscrYCyxI4Xlt1wSrxTE7CYE9qWKMJ7dc05+pXFR0oKHYWFBtWj0a4J3q
	 O1UTDLgSBnFom97aY/4Y7JomMsIg9w/oYEtLY7A7Wk7FdJU5Lt3lzdewH/Gzk5ifKn
	 wHRbsmPZLqh5p6/03qtj40Cfk8ovM2/rLrFlO827nqyaw/tglwjqhALeVe3XsrOf1t
	 hgKJhsRRydbru9PoU+CMiGCc1NDv/bM1H9bPj8Iu6YtfdBgCNfgxttGDH5BW2eg6qt
	 1EriRKzv3L2n/FZzzJ5NkHtsLS/Yk338HvX7F+LdfIOGk5qiRk0RaOSD9T5jBLB78c
	 cuaUrF1xF5GzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CA6383C259;
	Wed,  3 Sep 2025 22:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] net/mlx5: Add PSP capabilities structures and bits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175693740626.1217361.17270265115984686138.git-patchwork-notify@kernel.org>
Date: Wed, 03 Sep 2025 22:10:06 +0000
References: <20250903063050.668442-2-saeed@kernel.org>
In-Reply-To: <20250903063050.668442-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, jgg@nvidia.com, saeedm@nvidia.com,
 linux-rdma@vger.kernel.org, leonro@nvidia.com, netdev@vger.kernel.org,
 mbloch@nvidia.com, tariqt@nvidia.com, daniel.zahka@gmail.com,
 raeds@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Tue,  2 Sep 2025 23:30:50 -0700 you wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Add mlx5_ifc PSP related capabilities structures and HW definitions
> needed for PSP support in mlx5.
> 
> Link: https://lore.kernel.org/netdev/20250828162953.2707727-1-daniel.zahka@gmail.com/
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [1/1] net/mlx5: Add PSP capabilities structures and bits
    https://git.kernel.org/netdev/net-next/c/04a3134f88a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



