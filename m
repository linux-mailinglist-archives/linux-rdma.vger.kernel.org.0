Return-Path: <linux-rdma+bounces-14891-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFEACA406F
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Dec 2025 15:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C8A5303070F
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Dec 2025 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2193446B7;
	Thu,  4 Dec 2025 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3zznF+p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA6C2DF137;
	Thu,  4 Dec 2025 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764858789; cv=none; b=MpK+mqZE25X1gkQCodZ+PinhbD9Lsd/nDGwbdaOJk0eFA47S5MHbFcYeqe4R7dPNzadJxTTTkUYiy/9PShw0pvpwK9AReqxVN8WJTVWXNQVUoW9vQIhL0kaK5l/rHMYQPZlZ8soTQ57//8CNKdDCfUYywmiDdDEbC35p4hgekEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764858789; c=relaxed/simple;
	bh=2v5qMcE4svzePXu1CmoCew3oywxUHy0N7sl1tR+/abM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eTwHGPuKAHX0dnqHPM+AuooVF9nFiZl+Iq19qroMrxaFHCZHDfQbGAupevtlE050f+NPNBUE+JEU+/plEv12QakzPZcirMKDIGe4mj7lPNUeJGZ9p3Op8koKO42Shtfylx+/JGdYSDH6tfNEvnH/uHopX4EnGq17igypozJDh0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3zznF+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0FBC4CEFB;
	Thu,  4 Dec 2025 14:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764858787;
	bh=2v5qMcE4svzePXu1CmoCew3oywxUHy0N7sl1tR+/abM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M3zznF+pQoJxfzf0g5JP6boWxuy39pPz8FQAtBiFv3qQeTsdMqCfpV3/l2l6sKLDg
	 7RKVha0LJR84wVvV/ja5OsIVxb4f3GcXNlyp+4izQ1kr6KgEeJBmBUScX7t61WQu+r
	 2noAGrvqexLn6JV8Vxlep7v5mc5o5+jB3VJU2n/bxK/lAquC4LEOJFe9Bsk5VuAC7B
	 5tsiD58PzJw8kqHi53KaMOTM1CtFhUF4BVLIy2qKsptcbjlAupisgKsoNdkfH9Hn79
	 /5ShnCkMeKbMJf9eCEtqkcSfJN7cuauaFl8Ha+iC63OjQj8XD66IesCtej6iGJEBMk
	 ZBrIz0bJrwPXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B9933AA943B;
	Thu,  4 Dec 2025 14:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5: Fix double unregister of HCA_PORTS
 component
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176485860604.800217.14018174657269207121.git-patchwork-notify@kernel.org>
Date: Thu, 04 Dec 2025 14:30:06 +0000
References: <20251202-fix_lag-v1-1-59e8177ffce0@linux.ibm.com>
In-Reply-To: <20251202-fix_lag-v1-1-59e8177ffce0@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shayd@nvidia.com, horms@kernel.org,
 lukas@wunner.de, helgaas@kernel.org, schnelle@linux.ibm.com,
 alifm@linux.ibm.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-pci@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 02 Dec 2025 12:12:57 +0100 you wrote:
> Clear hca_devcom_comp in device's private data after unregistering it in
> LAG teardown. Otherwise a slightly lagging second pass through
> mlx5_unload_one() might try to unregister it again and trip over
> use-after-free.
> 
> On s390 almost all PCI level recovery events trigger two passes through
> mxl5_unload_one() - one through the poll_health() method and one through
> mlx5_pci_err_detected() as callback from generic PCI error recovery.
> While testing PCI error recovery paths with more kernel debug features
> enabled, this issue reproducibly led to kernel panics with the following
> call chain:
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5: Fix double unregister of HCA_PORTS component
    https://git.kernel.org/netdev/net/c/6a107cfe9c99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



