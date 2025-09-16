Return-Path: <linux-rdma+bounces-13389-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF80B588B5
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 02:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D37394E21D4
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 00:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3922135AD;
	Tue, 16 Sep 2025 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvGG+cPS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108531BC5C;
	Tue, 16 Sep 2025 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980807; cv=none; b=bVpavt41DxZj2Sy2SP8iMLfZA6l9IWMv4WEDhYQSn7/n6rwFjrlZXSRJAiW2rKS8JmerRYP1G7Y9T2Y2naEM7XG/qEMQH0M/maQ3E/DTLd4z8Q/RKvn0GMsgdh0Ssoh0UC/qAdvwn3qzrumVPwxeLJp2RKOMSx/7wLpGy/RoGKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980807; c=relaxed/simple;
	bh=m+NikykpL2wGDa+qKk4c9X1UBB6XqdEMd19a08SIEZ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kefwohh01GWA4ruJt79ln7lBwg/rhWxNtNkQi2LornH/okCXB5OHU0cmo1/vXyuDJFIft10kSvfXOAUZ4IGa7VPXtSn1YMakTddVEMYf5P1s4GOIqyJ7OZESqk1BveSMUmklZKo9amdclr4TZhOS90T9A04Ehdu3ePAwAZWxpwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvGG+cPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B175C4CEF1;
	Tue, 16 Sep 2025 00:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980805;
	bh=m+NikykpL2wGDa+qKk4c9X1UBB6XqdEMd19a08SIEZ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TvGG+cPSNlSG5chnTgb0er0AajH2OG2DeGwKS2heVVx7WR26QLzyD3Ab27CcsNxMk
	 lGagpUaIMJV86Q70lvnbktL1cgcOT/E+FN9L7us+4pygvxKOad4R7kV03rKcH0hm5q
	 Inw1VjTyJNVU2odz7W/2cCDuy/QFMAotMBGAb/jmwevUtU7s3yE5XMsSiDBscMGUvn
	 VmtvgzzpYfpeuL0xdYyCpKxh8tjm9uZB+WBMET+713YUjFQoS8SenzVwtFyKCErkVa
	 doQDbmXRxXEO78idJ69obuM4HsMMxrp8voxyDyqxbuW1gmOGcRvqXC0IQgkek/9/WQ
	 FQ8UX2RGBtFgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D1939D0C18;
	Tue, 16 Sep 2025 00:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] rds: ib: Increment i_fastreg_wrs before bailing
 out
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175798080701.534846.17163351278679972758.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 00:00:07 +0000
References: <20250911133336.451212-1-haakon.bugge@oracle.com>
In-Reply-To: <20250911133336.451212-1-haakon.bugge@oracle.com>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Sep 2025 15:33:34 +0200 you wrote:
> We need to increment i_fastreg_wrs before we bail out from
> rds_ib_post_reg_frmr().
> 
> We have a fixed budget of how many FRWR operations that can be
> outstanding using the dedicated QP used for memory registrations and
> de-registrations. This budget is enforced by the atomic_t
> i_fastreg_wrs. If we bail out early in rds_ib_post_reg_frmr(), we will
> "leak" the possibility of posting an FRWR operation, and if that
> accumulates, no FRWR operation can be carried out.
> 
> [...]

Here is the summary with links:
  - [net,v4] rds: ib: Increment i_fastreg_wrs before bailing out
    https://git.kernel.org/netdev/net/c/4351ca3fcb3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



