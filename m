Return-Path: <linux-rdma+bounces-20110-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL0RIhf3+2l9JQAAu9opvQ
	(envelope-from <linux-rdma+bounces-20110-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 04:21:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D45C64E23B8
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 04:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C051301726E
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 02:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FB1280A58;
	Thu,  7 May 2026 02:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSHd+ugr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133E922D4D3;
	Thu,  7 May 2026 02:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778120466; cv=none; b=TSUG/ASfMUQsfLwPmHGkjX2m2v17AkhIrqODj2Q6GM0+A0sEHTxV1+L1lPV1rfFLzQDlxCwM0RyBxuVCWxkvy3aOBXNNpAptH/aN0/QxRXiZbBMR7c33qZIoYidxocOf8kG4FRpg9VGpsx5EvtCcUxGowVZesllVQbENDBsstEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778120466; c=relaxed/simple;
	bh=ZSqLjFpD60c2bpyYQvPwBPh7kivp1T+epZnLDaU4SkE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=msBnhxok2eXMSAtW3Scl0ONSnEnR5I4ngXP0wzOW0eFqie8BZdTJbbHc4AapmPbPzYpFDdO6DzxrRfJYFI767zxTN4n5uLSYZM3rBLe1rCNdlS6yuZ+fQTzOHIfnFbbsyvU6cddmZPM+jbY45JdpwGDglQ8SNiPk7mkgdMgTYig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSHd+ugr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C307C2BCB0;
	Thu,  7 May 2026 02:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778120465;
	bh=ZSqLjFpD60c2bpyYQvPwBPh7kivp1T+epZnLDaU4SkE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eSHd+ugr/BxqZvHPpVd5F3f6mLPIr1nmUx2f8OE44fdRgV698IFsPUhG+v/CXVCnP
	 pGpYbu+tXsuy1VO2UTelQtVP3vg/bNv8ZG1T/QZcOeWtwPkaVqQx8cwYfyXoMeeCD6
	 2Df/pfE8U57EUhTTjqETY3lFWlqEjyH6+d7ydEDgfp/Fh7z4j3Gva3ICcd2CnwUTz1
	 jJee1XNYvAjl16O9RX+/yz19Ifp+7c4d0PEHr/fNA3RW9bNlzJKA5H6k/MfemBwVrT
	 2Inkc2T5X8SR6tf0Z+6VBHSMCPaWG6j3mNfHzG1ILTnQbwoo3Q85nA4vhJrhSFjriE
	 vtimTPLqQ0TWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C88393089F;
	Thu,  7 May 2026 02:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V3 0/7] net/mlx5: Improve representor lifecycle
 and
 late IB representor loading
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177812041480.3304318.2260784771649427340.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 02:20:14 +0000
References: <20260503202726.266415-1-tariqt@nvidia.com>
In-Reply-To: <20260503202726.266415-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, leon@kernel.org, jgg@ziepe.ca,
 saeedm@nvidia.com, mbloch@nvidia.com, shayd@nvidia.com, ohartoov@nvidia.com,
 edwards@nvidia.com, horms@kernel.org, msanalla@nvidia.com, parav@nvidia.com,
 phaddad@nvidia.com, kees@kernel.org, gbayer@linux.ibm.com, moshe@nvidia.com,
 cjubran@nvidia.com, cratiu@nvidia.com, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, gal@nvidia.com,
 dtatulea@nvidia.com
X-Rspamd-Queue-Id: D45C64E23B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20110-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 3 May 2026 23:27:19 +0300 you wrote:
> Hi,
> 
> Find detailed description by Mark below.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,V3,1/7] net/mlx5: Lag: refactor representor reload handling
    https://git.kernel.org/netdev/net-next/c/b501400fa66d
  - [net-next,V3,2/7] net/mlx5: E-Switch, let esw work callers choose GFP flags
    https://git.kernel.org/netdev/net-next/c/386ef557f6df
  - [net-next,V3,3/7] net/mlx5: E-Switch, add representor lifecycle lock
    https://git.kernel.org/netdev/net-next/c/9b8468f001e4
  - [net-next,V3,4/7] net/mlx5: Lag, avoid LAG and representor lock cycles
    https://git.kernel.org/netdev/net-next/c/63ec6c69e613
  - [net-next,V3,5/7] net/mlx5: E-Switch, serialize representor lifecycle
    https://git.kernel.org/netdev/net-next/c/32a72840ee30
  - [net-next,V3,6/7] net/mlx5: E-Switch, unwind only newly loaded representor types
    https://git.kernel.org/netdev/net-next/c/8a6712925d38
  - [net-next,V3,7/7] net/mlx5: E-Switch, load reps via work queue after registration
    https://git.kernel.org/netdev/net-next/c/25933aca1012

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



