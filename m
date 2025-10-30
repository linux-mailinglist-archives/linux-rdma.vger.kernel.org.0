Return-Path: <linux-rdma+bounces-14131-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A749EC1DF83
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 02:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DA7188E398
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 01:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292C023E340;
	Thu, 30 Oct 2025 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QplQC59I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32B523D7C2;
	Thu, 30 Oct 2025 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761786037; cv=none; b=DYzqKyZ8NDTpkMh5kbuhsMdQj1FUNM/yk1iXATpcYv5iO+Mk8XIZutMsPc7NacLm6dt1nsuD/CgkAdlrOA3+/7ivtiD0Qs1coJP35HRPpZJKYJgpOX404OOOcyXpPV7QnN3KEgYj5DBiC2F0Rybu2HMqnuqaTQ/I+vaT6pmYmmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761786037; c=relaxed/simple;
	bh=ZkCBJfYfaF9HJb+lOVAzByIByWqsfRoPhi3YIUIjZX4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cjul7YcuZwWQOVLLDAOMbdeWYaTTg42WkCX3CmeCv+TbS6OXdlbs8QMy68QqR0UR3zBaTpQUCrN2SetdgBSZ/wma1aN8LZ4TrhydRlz2zilbKJqXTKdKivBVpES1HVVbOBIGziMSYg3r0Ed7H9xXaUO8GXCle8Bx6g85nklPPg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QplQC59I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D384C4CEF7;
	Thu, 30 Oct 2025 01:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761786037;
	bh=ZkCBJfYfaF9HJb+lOVAzByIByWqsfRoPhi3YIUIjZX4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QplQC59IIsCGex0mbem0ePPMCP7UxytkOTJdFza9Ht5g92A9rMX3R6z28h0Q6dBdW
	 TkT+RkAYq9PWjacNk/ukCz3RomED3sRQYt0J6adw+dOSf/lLE3XKWzk4THtXOAyXP2
	 i99TdsT9kb6TfYdXed25+qmvc4rYasnE/NpUWUrjWbwwbTK0p4P7Gh0CQyZ4rGIXzA
	 +49LSc/nKbFRDoeG2ELHtLw0AFTLLN2i1MeSqjAITR3ep7Ngvplic2aTjI8g7POOQ7
	 bdkbDuS2PBSOBoo+Xwlbcxs565wOk9fk80hMITuAphrVdKZqUVYYXMxbw28cRLxpje
	 a75fIMAMZ/ZPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE8ED3A55EC7;
	Thu, 30 Oct 2025 01:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5: Don't zero user_count when destroying FDB
 tables
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178601425.3269431.7440616130656460451.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 01:00:14 +0000
References: <1761510019-938772-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1761510019-938772-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 dtatulea@nvidia.com, cratiu@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 26 Oct 2025 22:20:19 +0200 you wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> esw->user_count tracks how many TC rules are added on an esw via
> mlx5e_configure_flower -> mlx5_esw_get -> atomic64_inc(&esw->user_count)
> 
> esw.user_count was unconditionally set to 0 in
> esw_destroy_legacy_fdb_table and esw_destroy_offloads_fdb_tables.
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5: Don't zero user_count when destroying FDB tables
    https://git.kernel.org/netdev/net/c/53110232c95f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



