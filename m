Return-Path: <linux-rdma+bounces-15501-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED53CD1887C
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 12:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8BE9B3008144
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781A038BDAD;
	Tue, 13 Jan 2026 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COb26ahl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7D834A3C1;
	Tue, 13 Jan 2026 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768304620; cv=none; b=oyaTvCPWEGFxzRNTePnyPo676FP+cHHE+mUlHWdfA1i/hKG0wpNL33TqJmedPew9KmqyeUmm5JCejdN52yW+65+mT7SPTUDnFyP35nIhkvx03ogaabWGDtesxIXo+6kCTzNAPEjs9V693Hp19jrSRCbTiu/3ruThjW9Gg5YoPcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768304620; c=relaxed/simple;
	bh=0aMmH+mP8gXuho7rQ6w6yVxZnem9t03bVCPnPCRACj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jpVvt2SXP2gjIoyV4WkSpQQcyVlt32CsvD+tmRZRJpdFSi8OQ/lST9bjjcPGvyQKULpL/UU31jYvW+MhFQJKqHvFlJeET9PS9hUEEqNigOunvTTxuia6V36Es3oZ/bji3jghtaDeArlWzwopuzmfhUVspyZCLU4L/F35YgwQ0Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COb26ahl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02FDC116C6;
	Tue, 13 Jan 2026 11:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768304619;
	bh=0aMmH+mP8gXuho7rQ6w6yVxZnem9t03bVCPnPCRACj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=COb26ahleijWeYWBQkq5wuS1j1tfufu2Xwo6r2wAzWPROuliz5aTep5Iqn8Mlu1M0
	 VeRjskDHBdmSf/BipDlB+p7tjbTAXmP8pxoOeOOPexeoApnyCCnwIIISZs41HMpLZR
	 mD7QxOvfQtUqcOgjiaMLOnR97ghK18ni9TGt1ZCMvNzGoJ3njBFb+Y0RC1OoM0QWBW
	 By5tYNsxOUcBfH7/hikh+YJKKe/+/+hQTtqraeGson8w2kJ2vVt1Gu8zvOmWgbDGOS
	 OMxbTH+WGQdAhmiGVTHQyidZfYmzR1AeJp1tcTbC3tCgXAJsh6Yu4jZYY05CS+xW3R
	 vUZxN77gGrnOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 76DF83808200;
	Tue, 13 Jan 2026 11:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] net/rds: RDS-TCP bug fix collection,
 subset 1: Work queue scalability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176830441313.2202748.11246831257261370626.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 11:40:13 +0000
References: <20260109224843.128076-1-achender@kernel.org>
In-Reply-To: <20260109224843.128076-1-achender@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 rds-devel@oss.oracle.com, kuba@kernel.org, horms@kernel.org,
 linux-rdma@vger.kernel.org, allison.henderson@oracle.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  9 Jan 2026 15:48:41 -0700 you wrote:
> From: Allison Henderson <allison.henderson@oracle.com>
> 
> Hi all,
> 
> This is subset 1 of the RDS-TCP bug fix collection series I posted last
> Oct.  The greater series aims to correct multiple rds-tcp bugs that
> can cause dropped or out of sequence messages.  The set was starting to
> get a bit large, so I've broken it down into smaller sets to make
> reviews more manageable.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] net/rds: Add per cp work queue
    https://git.kernel.org/netdev/net-next/c/d327e2e74aed
  - [net-next,v5,2/2] net/rds: Give each connection path its own workqueue
    https://git.kernel.org/netdev/net-next/c/4716af3897e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



