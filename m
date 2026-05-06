Return-Path: <linux-rdma+bounces-20043-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NZZK3Wo+mlbRAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20043-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 04:33:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BF74D5B3E
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 04:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5A483041486
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 02:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C24C2C326F;
	Wed,  6 May 2026 02:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZKg3ftJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FAD26738D;
	Wed,  6 May 2026 02:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778034681; cv=none; b=I0ZSQCMloOHQpujc2omPyu8cYs044vGZ55+niMCqsqtKuOwORJq9DPJ5Jeu8JJFRY4bomdGYifJO9c+xn36sQ21d+nWrJBwKmd0KYTHajH4j5htKeHAAcXP+e+KwuyIxRY8yEaG0dTd07Yn68ElHSHLJfmT16BKex1j+9bidFQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778034681; c=relaxed/simple;
	bh=AboOtmBYAkkrS2ceQshScswUWsCjqeIzDr8hNfVnrns=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=khdZYgHnn0Wv8BZvq216mpzI9hBWQ39HPK7N1bik9MXXbpyv2HjVJv6jrWjDUgE42zWJzECShEhHhR9sYzyvbo1UNQNXz8JbYlGnjcqsD+JqSWLrXtBzPfSET+el+FzJOhkN/KlPzsMvgjyIYuPfFMyRqMwxVuRgcGWcOQwJAAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZKg3ftJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA89C2BCB4;
	Wed,  6 May 2026 02:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778034681;
	bh=AboOtmBYAkkrS2ceQshScswUWsCjqeIzDr8hNfVnrns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EZKg3ftJ4Afx8whKo+5cT49VTupGd3yNWQyCHE58EFr4N8Y5i4Z7r6imFG5R+qfQ3
	 wQYba76TLzmwUQVA/ngw4vj++IlXEC7y+Ak3SiNH44AeElNXpvaRe6A+IN+oyhS56Q
	 pBb660Y9s46zDIg5wqS2yTRwNfHYdNX/m9d457BKtaVZOV6B4HcwkkZ8ZI5O2CRSE+
	 FgaT+ReRte8Mk67JC9gBU+S+sLDZQ1Tt2Zk7NJ+x+LFBrPkSqAzXRR8rIaNA3LM8MM
	 G6JzymS3UJcLsW61u1Zkp0W1s8TYm+OBDRpeTCdTO9ndUdrkQMTmEko35w7l8n1g9s
	 Ywjk9frOfdi8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CE93930780;
	Wed,  6 May 2026 02:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/10] selftests: rds: Log collection,
 TAP compliance and cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177803463154.2357425.4119848919465141274.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 02:30:31 +0000
References: <20260504054143.4027538-1-achender@kernel.org>
In-Reply-To: <20260504054143.4027538-1-achender@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
X-Rspamd-Queue-Id: 56BF74D5B3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-20043-lists,linux-rdma=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  3 May 2026 22:41:33 -0700 you wrote:
> This series is a set of bug fixes and improvements for the rds
> selftests.
> 
> Patch 1 bumps the kselftest timeout from 400s to 800s. The original
> limit was developed against a lean config, but the kselftest harness
> counts boot time and gcov log collection against the limit, so a
> default config with gcov enabled needs more headroom.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/10] selftests: rds: Increase selftest timeout
    https://git.kernel.org/netdev/net-next/c/94720e01f5bb
  - [net-next,v3,02/10] selftests: rds: Update USAGE string for run.sh
    https://git.kernel.org/netdev/net-next/c/4781c8b037a8
  - [net-next,v3,03/10] selftests: rds: Fix more pylint errors
    https://git.kernel.org/netdev/net-next/c/5bdd59f90633
  - [net-next,v3,04/10] selftests: rds: Add timeout flag to run.sh
    https://git.kernel.org/netdev/net-next/c/7d6a32e7cb45
  - [net-next,v3,05/10] selftests: rds: Add RDS_LOG_DIR env variable
    https://git.kernel.org/netdev/net-next/c/ad070d903759
  - [net-next,v3,06/10] selftests: rds: Add SUDO_USER env variable
    https://git.kernel.org/netdev/net-next/c/d601239dcc26
  - [net-next,v3,07/10] selftests: rds: Remove tmp pcaps
    https://git.kernel.org/netdev/net-next/c/c726bc68fffd
  - [net-next,v3,08/10] selftests: rds: Stop tcpdump on timeout
    https://git.kernel.org/netdev/net-next/c/ec91483634fe
  - [net-next,v3,09/10] selftests: rds: Fix gcov collection
    https://git.kernel.org/netdev/net-next/c/c8781c61fd60
  - [net-next,v3,10/10] selftests: rds: Make rds selftests TAP compliant
    https://git.kernel.org/netdev/net-next/c/06d5c34517e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



