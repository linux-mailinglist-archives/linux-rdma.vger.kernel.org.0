Return-Path: <linux-rdma+bounces-21068-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPhYJs9PDmpQ9wUAu9opvQ
	(envelope-from <linux-rdma+bounces-21068-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 02:20:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E66559D43E
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 02:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 623543009F3F
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 00:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D4B237713;
	Thu, 21 May 2026 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZdvi63n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED1B223DFF;
	Thu, 21 May 2026 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779322799; cv=none; b=ihy4vTO2zgPAsz3VVXlEmA6DcQBX0Gz/bjA/VAqF65X2cXbKgcecYb6DWkyU30TBH2XgWoSu42S/Pvl+e+jNX+BkEYyDQyKb+ZqkPpIhdDTv9oTRpMP47uQnP5Mz98NQ17BcbwNT+M2PhvSSwueyNaGdShrPp5k5L4sP6fvOJ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779322799; c=relaxed/simple;
	bh=A1F8lhjzrsFLPFuKCrabgz1Q9thjbNW7K3wTJEyXvF4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QYqWLnmjAhL7y5P6E1aCPidBYLXZJHw24LJBvaaI/ecY8aVqXFwO7Ay+YblofaL7E3lAUcbb213DrxwaRkOl6/s7s6ArAoX98haMj9WMSySzZ90YFzUN80jgNoOyCPproUDuYmpyEfOEC05/diEXat5JaFCpsZ5XcqL+wwgQS7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZdvi63n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E4E1F000E9;
	Thu, 21 May 2026 00:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779322798;
	bh=QlU2pbcqqHQL0NLNQCmMKfaSic+pDUn/ZcMi5Hp6a/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YZdvi63nWbV4gZRhmyPzRuM9tS7UBGmLZT+xPWUF27Zv8y7iL+A/n4tDYYcCq2N5j
	 9MW/tVjMYkXpXZrKc0ytHTnqCO6DrKwAvAZ7Uh8rNEgy46M7PuZPpT0rprn/stigc2
	 6oSX08pBcCHzsWVPE/Xp6VJLeyLSvjrAt/7ys7ICqpvGIhyaZo9Vo7pKz7Giysv35X
	 5jFaAWviiOaIlURqqDs0hdlZimhWoTLb+A5zWaPbL6MDIw0I1+k1HbOd/Nie8eUgFT
	 8FFMe+tfq7Rx2pj34ghNxXMUZ7RSoBtsaOo7RWCZec0FLiPirBNRKaAsjDMAgcjeV5
	 aLL4dUq/t2EIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939873930C25;
	Thu, 21 May 2026 00:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] smc: Use flexible array for SMCD connections
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932280814.3806355.4057275719658528266.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 00:20:08 +0000
References: <20260519005206.628071-1-rosenp@gmail.com>
In-Reply-To: <20260519005206.628071-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-rdma@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, sidraya@linux.ibm.com,
 wenjia@linux.ibm.com, mjambigi@linux.ibm.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21068-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9E66559D43E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 May 2026 17:52:06 -0700 you wrote:
> Store the per-DMB connection pointers in the SMCD device allocation
> instead of allocating a separate connection array.
> 
> This keeps the connection table tied to the SMCD device lifetime and
> simplifies the allocation and cleanup paths.
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> 
> [...]

Here is the summary with links:
  - smc: Use flexible array for SMCD connections
    https://git.kernel.org/netdev/net-next/c/5026c42d7f14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



