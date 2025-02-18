Return-Path: <linux-rdma+bounces-7801-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7C5A39004
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 01:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12994171DE1
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 00:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416F545945;
	Tue, 18 Feb 2025 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXZoI8h8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4FB28373;
	Tue, 18 Feb 2025 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739839208; cv=none; b=O/jdi8IVvIN4lx2rggaTbxE7jFxW2QKH3/Xlor/SCZPtpbKE6v9tiis0r7QKHeNbVz1aCxryKaMwdDxOcNuoJoTO83Hv3i9Wx+RudU44T5htBubn4ynrQhdJRKhQWO2XZtK25i/ja2RbvAmf3HNv25yWZ5JEP8s6uP/qZXjlOmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739839208; c=relaxed/simple;
	bh=AO9yO00MduwbUcjO+Ez3Ys6EHCh5XVjfuxn8kmtTN8A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rHH2c3/YF22i0gk6781EPjd1TY5+lhvqzEBFu4p6FHZ+mjAize3Fboila/RT9bbOh2852aZeAEdupN/k9qkl5wUFLyE8fnggkCaX8kmOtL608jJq6LP79RPzloufjOkyDBYUX5VLg9sLwvKQLGR04dyPtLS/UFndnyz3tMnAL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXZoI8h8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BF3C4CED1;
	Tue, 18 Feb 2025 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739839207;
	bh=AO9yO00MduwbUcjO+Ez3Ys6EHCh5XVjfuxn8kmtTN8A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PXZoI8h8CgWv+d+6SzGbE6ZGE296iUWLINsALeHxnAifXZ3L8mUo3sBWP7HpPupZH
	 dfmJISIe2PsOMMkgKP5xh+19XpVw/iiBr9/iKwTpX3sNkqITGeaoZWwSriWqW/1b8o
	 H1NfyEvMym1YoG3l2ms1HLSEMhar8Ef9mVqF3ddC0fnax2Y3xzXKXrJ7r/j/iDqIRg
	 jMvDmyQCQPa8d1735nlTqQzXrCLEKk44jx+jQIdubc6MT9B8Kp43Yx1Li4e3LBb6fO
	 eqUwwX2FWCCw+PHseKGRJyHoufsRACfkIudRNuHph0U/yxQgBLG5BTtQmfCQA+ygzI
	 yDBgRgQ0PbNFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE734380CEE2;
	Tue, 18 Feb 2025 00:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] mlx5: Add sensor name in temperature message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173983923749.3583210.12936325771072711787.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 00:40:37 +0000
References: <20250213094641.226501-1-tariqt@nvidia.com>
In-Reply-To: <20250213094641.226501-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, shshitrit@nvidia.com,
 gal@nvidia.com, saeedm@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Feb 2025 11:46:37 +0200 you wrote:
> Hi,
> 
> This small series from Shahar adds the sensors names to the temperature
> event messages, in addition to the existing bitmap indicators.
> This improves human readability.
> 
> Series starts with simple refactoring and modifications. The top patch
> adds the sensors names.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net/mlx5: Apply rate-limiting to high temperature warning
    https://git.kernel.org/netdev/net-next/c/9dd3d5d258ac
  - [net-next,2/4] net/mlx5: Prefix temperature event bitmap with '0x' for clarity
    https://git.kernel.org/netdev/net-next/c/b9b72ce0f5f4
  - [net-next,3/4] net/mlx5: Modify LSB bitmask in temperature event to include only the first bit
    https://git.kernel.org/netdev/net-next/c/633f16d7e07c
  - [net-next,4/4] net/mlx5: Add sensor name to temperature event message
    https://git.kernel.org/netdev/net-next/c/46fd50cfcc12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



