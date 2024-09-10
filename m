Return-Path: <linux-rdma+bounces-4853-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A020A9732C5
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 12:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4331C24C72
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 10:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCB918DF73;
	Tue, 10 Sep 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAs1pL8w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A8018D63B;
	Tue, 10 Sep 2024 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963628; cv=none; b=SJ8mrQuJz7QGzadUzcaO3vEL7glAHxUTsB4fEsTMTGiiZQsUt9BYlFkEDYhubNcvU9/BBZwD668Kcwx7YBrjv2n/Hd0h4GTYWbpedYneb+EBofOzBZ7RANQbJFSHygac89DMtbMuRVZCTJ91EpO+VnCvLEIajVomlMG34IwY/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963628; c=relaxed/simple;
	bh=r8VWK/8tS/vNZYMIs0DqPaVd0KVnFCGKkn+01NAdl1I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RDd3wwdhOYkk4FpzMiwpX5s41X/qhNodVSb/nq1dFjJrsI718JVEuYpLx1p9Cplq164dgFlUhI6cKqLeleomKBOiWxeeMB0Ei+MDTqJ/X/bqCtO2xNAgZOc/XotV0YHg1iYl4hEYfPsTI/WxW11jgz+toQbByE9ioKPJ3vc8XXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAs1pL8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADF0C4CEC3;
	Tue, 10 Sep 2024 10:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725963628;
	bh=r8VWK/8tS/vNZYMIs0DqPaVd0KVnFCGKkn+01NAdl1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tAs1pL8wOAhmrxQdD1PXgbrtF4PTsJThc1yFLCsP5+55AqmuHWLchSHvSdh8NCcxE
	 nZxjFpNUHx6OZy6iCwZeCFLezGg2y35kOWccE0sFBlx9v4tEtTksVXlOQS49hhHjLB
	 RDDt0tQwk2My+CGA+dv/3lvBUo7vF0G/QWyjA2MNXJNMCJHtaK6mcFAlKlHavHOnzf
	 0NkBtD5LeGChT7cgL6Tql7ujTDFyaKW45zPwdATRZxGuu/EQ2n79fRDWdmTx/ZNi70
	 aivxt6hJ+rZ69eOjgjIS6bHV+EnrL+3otRWZMD9tOe+8I+dXWQZenMbOdsOFOO55Io
	 2zqbm1eEb/HvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE15D3806654;
	Tue, 10 Sep 2024 10:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/smc: add sysctl for smc_limit_hs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172596362951.205873.17383850527808934087.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 10:20:29 +0000
References: <1725590135-5631-1-git-send-email-alibuda@linux.alibaba.com>
In-Reply-To: <1725590135-5631-1-git-send-email-alibuda@linux.alibaba.com>
To: D. Wythe <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com,
 edumazet@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Sep 2024 10:35:35 +0800 you wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> In commit 48b6190a0042 ("net/smc: Limit SMC visits when handshake workqueue congested"),
> we introduce a mechanism to put constraint on SMC connections visit
> according to the pressure of SMC handshake process.
> 
> At that time, we believed that controlling the feature through netlink
> was sufficient. However, most people have realized now that netlink is
> not convenient in container scenarios, and sysctl is a more suitable
> approach.
> 
> [...]

Here is the summary with links:
  - [net-next] net/smc: add sysctl for smc_limit_hs
    https://git.kernel.org/netdev/net-next/c/f8406a2fd279

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



