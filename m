Return-Path: <linux-rdma+bounces-16556-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO2+OfMjhGnKzgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16556-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 06:00:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F04EE9BE
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 06:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BC85301225C
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 05:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082E2253B73;
	Thu,  5 Feb 2026 05:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzxqKLxm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE228168BD;
	Thu,  5 Feb 2026 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770267625; cv=none; b=HfM+D4Xfd+ZvlsJtm4gOFZIS2W2w+igNSkP7QnuknKMWboDsQ4tFGRzCvaBTb6zpGuZhgqrubvbBaXaHvbu1BH+gsBVC0XO0J490waFi08uhIYZQ5A1qzNnCmFwDEdWvaj09hkge4euepKvVOgturTHtDh6ZPEXj9zU+aD3TizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770267625; c=relaxed/simple;
	bh=u0ucK9KnTdbKPPfUH0M6A9QcdAgEnXMvsatR63D2NCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lSd9q0UgqWqBwDf74Dlk9Sir0FuwgKj74SafFTrM37HLTw1LAk90mfC4rbVjliqFN7SRYsAk56lKA0f+wOnlEWSibALHkVc16VaeP+280d9v/HhD3g15TGQXiLsY2XmWRKPwL+o83hNOq8Pe9h3WwMYGPYmL8eyTYe84bdz6Y3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzxqKLxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52143C4CEF7;
	Thu,  5 Feb 2026 05:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770267625;
	bh=u0ucK9KnTdbKPPfUH0M6A9QcdAgEnXMvsatR63D2NCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OzxqKLxmYe3SIXqGKP3oZumOUf0EQBeZaQy5GsSXQ3O1J0l8suAbbxqWiTYESobIg
	 9UDE1VqXiWiwOnaxJl60kyo4W9SDie4RzIujCRE6hVKurhIaJdrYL3ZbYJeiVzxlEF
	 vLMxVSwytzKLxnC2RWvIiOL6HzAaUfK6VbxogvgEFGmXr1KkjNZ2NU60v1J7oxiPaL
	 QYlW4MisAx0tvjC7dd8HXTAoNiRKIUO645ZfTcWrNWx7vmqrVZGij+7YVVIqeHOV9g
	 FplHMhJQ/Bx1ylzFP3vGqZl2i3qTjDRcKnSBmOxhTordyufVGSPmQqr9erXUcwMC0+
	 UoBhl66DRyDhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8542F3808200;
	Thu,  5 Feb 2026 05:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/8] net/rds: RDS-TCP protocol and extension
 improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177026762333.167759.12194069820318825126.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 05:00:23 +0000
References: <20260203055723.1085751-1-achender@kernel.org>
In-Reply-To: <20260203055723.1085751-1-achender@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pabeni@redhat.com, edumazet@google.com, rds-devel@oss.oracle.com,
 kuba@kernel.org, horms@kernel.org, linux-rdma@vger.kernel.org,
 allison.henderson@oracle.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-16556-lists,linux-rdma=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07F04EE9BE
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Feb 2026 22:57:15 -0700 you wrote:
> From: Allison Henderson <allison.henderson@oracle.com>
> 
> Hi all,
> 
> This is subset 3 of the larger RDS-TCP patch series I posted last
> Oct.  The greater series aims to correct multiple rds-tcp issues that
> can cause dropped or out of sequence messages.  I've broken it down into
> smaller sets to make reviews more manageable.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/8] net/rds: new extension header: rdma bytes
    https://git.kernel.org/netdev/net-next/c/46f257ee6904
  - [net-next,v5,2/8] net/rds: Encode cp_index in TCP source port
    https://git.kernel.org/netdev/net-next/c/a20a6992558f
  - [net-next,v5,3/8] net/rds: rds_tcp_conn_path_shutdown must not discard messages
    https://git.kernel.org/netdev/net-next/c/826c1004d4ae
  - [net-next,v5,4/8] net/rds: Kick-start TCP receiver after accept
    https://git.kernel.org/netdev/net-next/c/aa0cd656f032
  - [net-next,v5,5/8] net/rds: Clear reconnect pending bit
    https://git.kernel.org/netdev/net-next/c/b89fc7c2523b
  - [net-next,v5,6/8] net/rds: Update struct rds_statistics to use u64 instead of uint64_t
    https://git.kernel.org/netdev/net-next/c/9d30ad8a8bc0
  - [net-next,v5,7/8] net/rds: Use the first lane until RDS_EXTHDR_NPATHS arrives
    https://git.kernel.org/netdev/net-next/c/a1f53d5fb6b2
  - [net-next,v5,8/8] net/rds: Trigger rds_send_ping() more than once
    https://git.kernel.org/netdev/net-next/c/9d27a0fb122f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



