Return-Path: <linux-rdma+bounces-13731-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B961DBAAF1E
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 04:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64353B9B99
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 02:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7DC1ACEAF;
	Tue, 30 Sep 2025 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUzC6lPB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8769E1B425C;
	Tue, 30 Sep 2025 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197626; cv=none; b=gONdIbpJTaIDwfiljPoq+95Co+JJ2LH+sJBkTH1503ClNM2eORzPK25qo93JzWE72833ojdkcwwktOdoySmEV3rF5TB5fM4lzueRs5lcnduXmDcACbUXBIk7OIzJkeeWsbhUAcgTgdd4IyPAEJMyS96E6AaYVSfLKNI+70BaPy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197626; c=relaxed/simple;
	bh=XR2Q+N8lw7tOHxYQBRu823Eheqp5Ns3OtL+U9Pz4A8Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=az9HEGI6L3Sul4eFrMeapFhrI82V1AbFIDjSxdu1aL0Rma6YbaV90HsdhaajUK94ZtqlAO5nIaoiOFdtlcYrVDf+zuAffMCicm3FTuJxnwibN6pYzIpCZkQAQ9+RfFTRmlrPZJBDP64E6kv8F62j3Scd4vVYTCqtgg1Ym/zrcQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUzC6lPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D509C4CEF4;
	Tue, 30 Sep 2025 02:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759197626;
	bh=XR2Q+N8lw7tOHxYQBRu823Eheqp5Ns3OtL+U9Pz4A8Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WUzC6lPB+yB71atSLA9aYYpy1+RudKorCLljLUbkeno965ZuouQIn9qzUAhWbYTVR
	 qiS8IMzEdetkvyP3P9YWGuoH9KtFzeyU4wbO7EG+DxKEsn3tigDaD7KW6J4F44+2rQ
	 5Bu6RCpSxEsh3T+omE5SUvj7S3BOldZq+yDqthye42uX33+189Vh2En3278irJSJJv
	 ro+kyUdED2skD9PcNklSN0FKhhm3mI+cvS7glVcAP22b9rnjQ1qrkuOC3yz/OKPa+t
	 tnd7QCSl/eEM4WQ0kmxItEiVdPy1Io2vIApMSypbrE7AB8PTYHjfvxeEJlQdfA5cpg
	 3PvBNYLubfBbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE52A39D0C1A;
	Tue, 30 Sep 2025 02:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] mlx5-next updates 2025-09-28
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919761924.1786573.9506243902879489514.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 02:00:19 +0000
References: <1759093989-841873-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1759093989-841873-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, leon@kernel.org,
 saeedm@nvidia.com, mbloch@nvidia.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, moshe@nvidia.com,
 gal@nvidia.com

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Sep 2025 00:13:09 +0300 you wrote:
> Hi,
> 
> The following pull-request contains common mlx5 updates
> for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [pull-request] mlx5-next updates 2025-09-28
    https://git.kernel.org/netdev/net-next/c/377ea331281f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



