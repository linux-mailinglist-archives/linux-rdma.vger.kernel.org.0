Return-Path: <linux-rdma+bounces-10750-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F11EAC4C1B
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 12:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B65F07AC4D2
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 10:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE402254873;
	Tue, 27 May 2025 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXWo4TJJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1362494F8;
	Tue, 27 May 2025 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748341195; cv=none; b=KiQ//rxfm15HytAmvcLJ6o17Fy5TU0v4HluCmX+AtNlpH8tDY6/Aeh3eEMQPoknXRcNORXATbhCF+lFXRtK6LFCgGieU+1J3mnNW48c+rsTNI3NJJsAf5hPd1V0WhURH9qS/9p7IZjjMhQTGeVViDKtDqkP1c7ePUSCzMsp+UIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748341195; c=relaxed/simple;
	bh=mzdV6abXGkhQHPLAkMDEWY6imQH6XIgmzpS5HTP5o0U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kklQ0JEOdXzGCpqh/8NoGu7sLycqPlSYxVnd20u2Mr1PHwPQmpQK7Gh7oUk/hFkqy3977dqID6p+qgCQJURQs++psWc5UQcwaItIiMH4dNzscIVnzTPSMeAPjJuNJOC2p6fllaf6gw7wgeeEK27ZMdSC7SxcT8Xaboahgd2FVLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXWo4TJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7750C4CEE9;
	Tue, 27 May 2025 10:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748341195;
	bh=mzdV6abXGkhQHPLAkMDEWY6imQH6XIgmzpS5HTP5o0U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SXWo4TJJ7zq3+M8PaDa04tuymzIthKx3m6fXMQc2ETdEsaAyJh/trOaqKpIN3sTpG
	 sgwdZhDDJyJA3+Vja4RrUM5o1uA/4UyhR58XOQFEsBMT6wEea00yjiFKdSawwPHX4H
	 37hs+qHLRqvW+dCAwuQpOh92fZgPWo/gwZQP44n9ZpqbVAdFFKU3P6gFMjroCIJDVd
	 wmfuJx2pS9roP+hMse9U/dYDSuiWpbC7KTaP2d4LOm0GjPdPP6xMr3vIv3UV8NkxQh
	 v2N7RY71//AmffuZ2nYS/vKaY6lSnyEW7XiGj39jmH16uq4IXbKlZVI+W5fa8Qyf1h
	 2c7GwdlZjhOTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DD8380AAE2;
	Tue, 27 May 2025 10:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Doc: networking: Fix various typos in rds.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174834122925.1243040.10154337643543327123.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 10:20:29 +0000
References: <20250522074413.3634446-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250522074413.3634446-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 darren.kenny@oracle.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 22 May 2025 00:43:55 -0700 you wrote:
> Corrected "sages" to "messages" in the bitmap allocation description.
> Fixed "competed" to "completed" in the recv path datagram handling section.
> Corrected "privatee" to "private" in the multipath RDS section.
> Fixed "mutlipath" to "multipath" in the transport capabilities description.
> 
> These changes improve documentation clarity and maintain consistency.
> 
> [...]

Here is the summary with links:
  - Doc: networking: Fix various typos in rds.rst
    https://git.kernel.org/netdev/net-next/c/6682bfc1b227

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



