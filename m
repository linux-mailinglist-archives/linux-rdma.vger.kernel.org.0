Return-Path: <linux-rdma+bounces-16595-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ1AORishGk14QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16595-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:41:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBF7F42A5
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEAB9301F30E
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 14:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C687F40B6CD;
	Thu,  5 Feb 2026 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9vvM+tL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A15122423A;
	Thu,  5 Feb 2026 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302407; cv=none; b=R1K4H9K6D+MFWwCbEvnFvl5Hh4/fIS6ef2IOIIhbpN+vZ9UbsKfAaiSdLtS490JkpO/cBRdL1nYSXm4ic6/bys4AZfMMNybyL4dN681M7iY7/oVNxJpAEiPRVbo3RjtfGgTA9qg2vncMoRj8A0MTxTFftRCx9MQjFXRDteMt04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302407; c=relaxed/simple;
	bh=SZnhW+M1GP44Ww9YIs6L0Vh9fjmfCtWPTOrnOfS4abc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qvNxlJYRgaCe5l//qbXTJKDBQEPNTfBvDH5W6ujEgIxkdG/uf40NJt0WuygmZJfswgq1Qinr0aFY8SlyMkrliw8C8gtzeIkugoZfM2ZvgqqLX1Hbu9FDX9jx7WhcLa9d3KHUxwkFkhl7x4W1FE0ZLYfc5ZhfrCcPhT16y/Tpdnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9vvM+tL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AA5C116D0;
	Thu,  5 Feb 2026 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770302407;
	bh=SZnhW+M1GP44Ww9YIs6L0Vh9fjmfCtWPTOrnOfS4abc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I9vvM+tL41ttNsTic6yfZJqP3ba0nkqzNgr0vO9nT9IRczlTTaFkPwuYeTMedgNqZ
	 uGJS1voYjpECnz/bRMA0ZOPIuV3FzslPS1ZqOPKW875FBFtdcCFh2e+qKzRBkWgDgL
	 BlHolbBKtqnZoPJpNZppipzLP7Xp5WXw7xawxTW7GyzlPgdYIhUtPlv5kUItr+KBjF
	 E7Fa3c1XnELfMPx2TzFCvH6ZygpfAVAmQrJx/FtE6VD2D199wY1Ope6p20KxbIoVuk
	 pU3KaxDAxDYzr5ocLchFjv2ewftQXxYB+TZr/LQM6xwZLj9eiUgkHiO/OFLDT4/kAf
	 GRURlh3lwsCZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B1463808200;
	Thu,  5 Feb 2026 14:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5: Support devlink port state for host PF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177030240483.437311.1652389703638888050.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 14:40:04 +0000
References: <20260203102402.1712218-1-tariqt@nvidia.com>
In-Reply-To: <20260203102402.1712218-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 moshe@nvidia.com, ohartoov@nvidia.com, jiri@nvidia.com, parav@nvidia.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16595-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EBF7F42A5
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 3 Feb 2026 12:24:02 +0200 you wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> Add support for devlink port function state get/set operations for the
> host physical function (PF). Until now, mlx5 only allowed state get/set
> for subfunctions (SFs) ports. This change enables an administrator with
> eSwitch manager privileges to query or modify the host PF’s function
> state, allowing it to be explicitly inactivated or activated. While
> inactivated, the administrator can modify the functions attributes, such
> as enable/disable roce.
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx5: Support devlink port state for host PF
    https://git.kernel.org/netdev/net-next/c/0e6c95c98829

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



