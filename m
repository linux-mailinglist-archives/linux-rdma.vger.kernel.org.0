Return-Path: <linux-rdma+bounces-11728-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0F4AEC34E
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Jun 2025 01:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A42147A39C6
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 23:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633482900BA;
	Fri, 27 Jun 2025 23:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yh1yIhKf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031982F1FCB;
	Fri, 27 Jun 2025 23:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751068185; cv=none; b=VnbmGti5dA9Pnl1UF7JswaUdfCFu5JC4fSeYvHi9Th3NQiPjLS/OCC3zKDIgQYHLRAOuzv/eGtFv4bpxYFvCU4XISeEzjg5hcPtjEwZk7tZdpTsYZfg+Mc3A2aKJR7y4lGH/Tx27kPZB/NOi7MmYIzebAh3QcXjUiRUF4ZuF74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751068185; c=relaxed/simple;
	bh=mlmZEjXG7JbeCyDnmaOEUzGlG9f+Aalt/BuH5agK3xQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AeQF+hs0mdyewIA71cG8leO0guP4ENcg1p6ctwLPIxEEP3HWn2c50/FOQxw99U1hyGmRMrZfCmXk7t7b2PF2d/pwZ5t3ctdysSC23VlcJjLTe1sdqWJ9RF9dpiBPanh1cAveaGSLocNH5i0G3eireXW0PNgYGh6DbE8DT3T95Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yh1yIhKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CCCC4CEE3;
	Fri, 27 Jun 2025 23:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751068184;
	bh=mlmZEjXG7JbeCyDnmaOEUzGlG9f+Aalt/BuH5agK3xQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yh1yIhKfhuWBncSI/r9zubrT7sZsms2KKYD0++g4aSKqVLr4cb6akeoC7FSShF+/u
	 pz/bmqgsZt4hjyClp0S4ysIstnMCgxmJXc49gcN9RAjJN1AgRSt+lxLcxNEi+ravfo
	 PpvWVyTUI/QfpLZtFTCk2JAQOyx2GcRPdz9DTY6Y7LKx9JGlK/nQz9IRM7jjQYKECy
	 ol0e0ByVk6SjtvTKVPLEGUn/KPFskSCRg9cuDVNzJQ/yuQHiW2fXNSI5mx4l7hWbXn
	 eTmutLw4H3DmPxHeCmWhWgUvWQBrDmdM0tplcgtbRjlyhnxYcSBAd+/2r+ZjmZ8Ah+
	 RLVF4Fb3h1j+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E9938111CE;
	Fri, 27 Jun 2025 23:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/3] dpll: add Reference SYNC feature
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175106821026.2091805.3166945763972558199.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 23:50:10 +0000
References: <20250626135219.1769350-1-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20250626135219.1769350-1-arkadiusz.kubalewski@intel.com>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 vadim.fedorenko@linux.dev, jiri@resnulli.us, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 aleksandr.loktionov@intel.com, corbet@lwn.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Jun 2025 15:52:16 +0200 you wrote:
> The device may support the Reference SYNC feature, which allows the
> combination of two inputs into a input pair. In this configuration,
> clock signals from both inputs are used to synchronize the DPLL device.
> The higher frequency signal is utilized for the loop bandwidth of the DPLL,
> while the lower frequency signal is used to syntonize the output signal of
> the DPLL device. This feature enables the provision of a high-quality loop
> bandwidth signal from an external source.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/3] dpll: add reference-sync netlink attribute
    https://git.kernel.org/netdev/net-next/c/7f15ee35972d
  - [net-next,v7,2/3] dpll: add reference sync get/set
    https://git.kernel.org/netdev/net-next/c/58256a26bfb3
  - [net-next,v7,3/3] ice: add ref-sync dpll pins
    https://git.kernel.org/netdev/net-next/c/5bcea241335b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



