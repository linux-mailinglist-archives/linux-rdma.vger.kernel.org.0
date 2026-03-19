Return-Path: <linux-rdma+bounces-18372-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ+9F+NRu2lMigIAu9opvQ
	(envelope-from <linux-rdma+bounces-18372-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 02:31:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 705122C4756
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 02:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82E8C301DD1F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 01:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226822DC322;
	Thu, 19 Mar 2026 01:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGvMYcu0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78E42DAFBD;
	Thu, 19 Mar 2026 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773883820; cv=none; b=Y3+IWUHVeTZmo4rFZ/srjstjxdRotK4eaXlvEPf7IbAnPf+ffjfMLW37IHfOx1qEsBWjwBnn0ZggmouXbHdu31MxDB/gK0FDqRia0WtmsRx3oZFn63w1bIvE+iso9P9ZAiKsrZLWmjrOx2NBcWcZaC7IZ6+ZJfZ1DACPEV5MUA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773883820; c=relaxed/simple;
	bh=RfXx/GdX9I0tNkcvWvdQRskJruN1HU8dodwLwQjwUyw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JWEPhwaqU97OTbudkFXD47jrstbdiZqALRo3qFgdJAOpE7b0kRYEDdSi0BkMIQPtSS5zafqQYUavw68iTRZU0iqWI+1XKGXhhXw/oBxAKJKBTLS5nL2BwrQ1LLlkOqn5tIuUtUqLueEtZJ3jZEue8NHnFlx7/ykZYZeLbggKDX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGvMYcu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6692DC2BC87;
	Thu, 19 Mar 2026 01:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773883820;
	bh=RfXx/GdX9I0tNkcvWvdQRskJruN1HU8dodwLwQjwUyw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tGvMYcu0hc/YWalRxo25S/KTfY15RBJ8RVjwbniOQX1QuYmDjaZ8haCTPQLJYb0r8
	 4+jJfyzDEfMGj89A91ZDFArxELqHG02xME9db3jzm+uH68x+XxA06kjjmZBC8FyTLg
	 cxicHRqq5Y8D6XhpNrKMuWdRwWpn0BJTgHvgX2rfxQ6bYVcnAruMmpp+QTJfvrz8QC
	 dYz3DkqI2hjHkuGOwSwq/HjM9dClCJIBvFaM1miHSIAtrtKeZ0FAHTg2OAbi/gpWfp
	 WHLwrPje8scNPhTQX+7QCc5+cEgH5BPrq+IcprNUbGnlNl1nZz34SRBkPW2173O2xQ
	 n9yFKLB5F+qeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DB53808200;
	Thu, 19 Mar 2026 01:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5e: Add hds-thresh query support via
 ethtool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388381153.978731.9539928416113084591.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 01:30:11 +0000
References: <20260317104934.16124-1-tariqt@nvidia.com>
In-Reply-To: <20260317104934.16124-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 moshe@nvidia.com, noren@nvidia.com, cjubran@nvidia.com, dtatulea@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18372-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 705122C4756
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Mar 2026 12:49:34 +0200 you wrote:
> From: Nimrod Oren <noren@nvidia.com>
> 
> Add support for reporting HDS (Header-Data Split) threshold via
> ethtool. When applicable, mlx5 hardware splits packets of all sizes with
> no configurable threshold, so report both hds-thresh and hds-thresh-max
> as 0 (i.e. always split regardless of size).
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx5e: Add hds-thresh query support via ethtool
    https://git.kernel.org/netdev/net-next/c/d347b28c492e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



