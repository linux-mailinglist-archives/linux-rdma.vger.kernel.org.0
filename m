Return-Path: <linux-rdma+bounces-18374-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ELMB15gu2lujQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18374-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 03:33:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B419E2C5017
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 03:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54CF1312B53F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 02:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3CD387591;
	Thu, 19 Mar 2026 02:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl9kFmbj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C118387562;
	Thu, 19 Mar 2026 02:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773887440; cv=none; b=rp0PwrlR4hBeKlDrGJycIIDXwWgmm762xlJNS45Bddg6FXvASPgEK0bbvD0J+k4bHP951r2F5hcLHLEV+BQyZ4drLfj5u9Qg2WzXaZoRtl+yre8iMOoekR0g0wQo7pPI6vB6oYRFmQyCDefWeA+Cm46B3KTE3owh+0/uQBUPZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773887440; c=relaxed/simple;
	bh=CL5U9R10/soHE24y27WznDYdmeKPUt6jGz54/c51JjM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DgR9K/GGP55HIzkTIkIswhLnoAaTS7BsA7vrTDWE3TATLWvaYBCHlJZHLo5VTMKA16rDgEleH6wEZPL8YdrxLf7Yevl/XNmI4omTMBUd1YaLKIJ/u+mc3Bcu2jbBCMvaqvyKR4xXpQGpHQH2QMxEt0p3Or13Qk2K1H41aW2ImdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl9kFmbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FB0C2BCB0;
	Thu, 19 Mar 2026 02:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773887440;
	bh=CL5U9R10/soHE24y27WznDYdmeKPUt6jGz54/c51JjM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bl9kFmbjZvPDv2OMH15FNE2wz4OptV/0YVQZxdl23syXupp4WGZE0Q59/v2FUXAqJ
	 g/tD50QKcsbN3g+awAPWFUGmpEnBU3B7tg//yPEM2+MjDuZI8h5fpUANQAuXj1U+GV
	 5kQYAqvM1ac+K4QF88hMy7LsX3kMllTTckXlUcIJWdd+6L18EZSq7LvQqW6V9apLAY
	 aR/PDsTi6w7I7Jg6LenebsxuV5G6y59AoI0eRtbD0C4JF1eL7fmnIzWYNFOBa0igjV
	 j+1QKy015Cn/ldAEQjojmhIKx91tjOT3OW2whjwHDcgX8ACw4nw3o31oyNYF/u3gf1
	 ZUvz5IYqAi7DA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F8A3808200;
	Thu, 19 Mar 2026 02:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net/mlx5: Support PTM on ARM architecture
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388743153.997016.3022283738800722938.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 02:30:31 +0000
References: <20260316133607.8738-1-tariqt@nvidia.com>
In-Reply-To: <20260316133607.8738-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, gal@nvidia.com, moshe@nvidia.com,
 dtatulea@nvidia.com, cjubran@nvidia.com, shshitrit@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,nvidia.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-18374-lists,linux-rdma=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	NEURAL_HAM(-0.00)[-0.963];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B419E2C5017
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Mar 2026 15:36:05 +0200 you wrote:
> Hi,
> 
> This series by Carolina refactors mlx5 crosststamp initialization and
> enables cross-timestamp support on ARM.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net/mlx5: Move crosststamp setup into helper function
    https://git.kernel.org/netdev/net-next/c/f87ca3b905e2
  - [net-next,2/2] net/mlx5: Support cross-timestamping on ARM architectures
    https://git.kernel.org/netdev/net-next/c/96aca5efec8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



