Return-Path: <linux-rdma+bounces-10737-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5619AC4437
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 22:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347B816B867
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 20:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F76423F439;
	Mon, 26 May 2025 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMermqow"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2332314830A;
	Mon, 26 May 2025 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748289596; cv=none; b=OCo5Lcitnopo4gsMthZUuSo2ADI9gBfUWdDAVcjhBdH0DNuXuqIRLb1LmDH0DH5/wetZJFAws8Ool+xO+JD6yvYIkYqBTn6oTN+UCgmijhE6b7VH41aBgvHejpKzNZsH8euUJQWlgpRMft6X20AVH1bZ5Sq24sirbHHL3pn4mjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748289596; c=relaxed/simple;
	bh=o5410J5V/wER+tLzUSDIkrzGAIb8DMmxc072FNGuheg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A/v9GhwtCv+wzZWHQK2Lw7u16lefxvKjeOoHcSxlWKtfm9LmN74H2CoLceu2+qcaG2JK26EM/0VQWAMHlxo8aj/Caw1qXMyHkyrHQ/3FedqgegqWv2gBy7kSGFPQBE9foi8ftW97YSUQG+Y9eH4HXU//8BhZtg5Jc+ndPWBYoqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMermqow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88564C4CEE7;
	Mon, 26 May 2025 19:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748289594;
	bh=o5410J5V/wER+tLzUSDIkrzGAIb8DMmxc072FNGuheg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JMermqowHisW8Pjp3O6dbZiZBzGx3nSr4RDUMR80MUczrQK/JeiJPMjYd15hu2NYK
	 cZs811cdnkemGTlrCQQOL3J2UcZt9uu12Xol4PfvnKKxxSUsj8LfKmvQM8C9WL5Fjm
	 ubfq87rUvPxlqA7ahP68RN4U3mZybKahi+rUoerzaBDXucvgR6IAvAxirtiJbp4eAX
	 LYGD/2R2Z9xO7DGQ0Zve1MK6TCvPlkS99wVYEO5GPkbFJ3QZXV1U/7NoJDodcGrQb0
	 9OWYF4yJHRpvAY7vWyJipCvJVHEq8+Y6o18rlZW0b+9aGiue7zYq6M7RW1nxD7C3PV
	 9fyunoVzbON3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3401B3805D8E;
	Mon, 26 May 2025 20:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net/mlx5_core: Add error handling
 inmlx5_query_nic_vport_qkey_viol_cntr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174828962901.1030381.7843371532564989086.git-patchwork-notify@kernel.org>
Date: Mon, 26 May 2025 20:00:29 +0000
References: <20250521133620.912-1-vulab@iscas.ac.cn>
In-Reply-To: <20250521133620.912-1-vulab@iscas.ac.cn>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 May 2025 21:36:20 +0800 you wrote:
> The function mlx5_query_nic_vport_qkey_viol_cntr() calls the function
> mlx5_query_nic_vport_context() but does not check its return value. This
> could lead to undefined behavior if the query fails. A proper
> implementation can be found in mlx5_nic_vport_query_local_lb().
> 
> Add error handling for mlx5_query_nic_vport_context(). If it fails, free
> the out buffer via kvfree() and return error code.
> 
> [...]

Here is the summary with links:
  - [v3] net/mlx5_core: Add error handling inmlx5_query_nic_vport_qkey_viol_cntr()
    https://git.kernel.org/netdev/net/c/f0b50730bdd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



