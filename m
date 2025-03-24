Return-Path: <linux-rdma+bounces-8909-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E62C4A6D32B
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 03:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097363ADB7A
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 02:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD11215A86B;
	Mon, 24 Mar 2025 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5oP1tWd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A382E3392;
	Mon, 24 Mar 2025 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742784598; cv=none; b=Jb5nVb2A1RYatEW3/AmaNmA1JvTQoJ3thRTaF2DP5fUUotV7htI+WHxsP98w+o6mXeMRmhQeAytLtu/oxBgVF0sb77lxAEiAViQx6SBOU4xE3yx/EnrANNGeecfC1rIU7H+3KSplndCtKrZIplH1yWp1N6lIQGe1Eh/LHgv1CLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742784598; c=relaxed/simple;
	bh=XyOiq3hanwj9nMEp9GtsG2uBm/cuEPJnvsDsrn23lbA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IJZtI9hf7xboykICtv10go2Ka/1Ij3pExbZVLnNCAk4fDLRbm9vWeADXhcvibaasssGhf9azL++mqFURB0+yDJ3++S7oHr5yHHQvG2D5KigNvmqBJULvTwxhWS1Bhv/ACyudyJp38tzBt30BDNa3+Ssb6du+Z2w2M+LLIit7fe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5oP1tWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6D9C4CEE2;
	Mon, 24 Mar 2025 02:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742784597;
	bh=XyOiq3hanwj9nMEp9GtsG2uBm/cuEPJnvsDsrn23lbA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b5oP1tWdpUQDy17vIfG7d8xtX8RVwrjRsZjknHu0yYcjIi56/4AC75NoY8vZIOyX1
	 iSUskfbtzByBcMLBtbImCUrlPUjxtTFYFgFL2QdeubxKJ6dovIxU9e/hXNSPvEO4mU
	 Nf1EE816amgqT0eNL7mQsMtopB+JH1jldWtxLdLHDxdLBuFe18rVfo/Et/PfIe6z//
	 PdQN7zLF4Hr/+Al0kFCVlmjE4L6ZyR2JFaO/4kbZRnyF7o1NG+gMiVUPfHUCiYDT4K
	 n/cJII5GZE2UmoT6SsH3TaA07e4WW1Zq/oyvRLdWy8sOnwsymTPTGlmqKDGF2LywdP
	 QCnr8GpOAIIZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714DA380AA70;
	Mon, 24 Mar 2025 02:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/2] Add optional-counters binding support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174278463329.3212931.9680954634489028299.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 02:50:33 +0000
References: <20250319082529.287168-1-phaddad@nvidia.com>
In-Reply-To: <20250319082529.287168-1-phaddad@nvidia.com>
To: Patrisious Haddad <phaddad@nvidia.com>
Cc: leon@kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
 netdev@vger.kernel.org, jgg@nvidia.com, linux-rdma@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 19 Mar 2025 10:25:24 +0200 you wrote:
> Add optional-counters binding support together with new packets/bytes
> counters. Previously optional-counters were on a per link basis, this
> series allows users to bind optional-counters to a specific counter,
> which allows tracking optional-counter over a specific QP group.
> 
> The support is added for both binding modes, automatic and manual,
> in both cases the bound optional counters are those that are currently
> configured over the link when trying to bind the QP.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/2] rdma: update uapi headers
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=85860c7dce2c
  - [iproute2-next,2/2] rdma: Add optional-counter option to rdma stat bind commands
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=a03f40534f6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



