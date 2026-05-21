Return-Path: <linux-rdma+bounces-21066-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI3aBGhNDmrL9gUAu9opvQ
	(envelope-from <linux-rdma+bounces-21066-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 02:10:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D47159D2E6
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 02:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D0A3305B982
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 00:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810A92F872;
	Thu, 21 May 2026 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bik7NtdL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB0B1FC7;
	Thu, 21 May 2026 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779322213; cv=none; b=ZcHDBOwsrZmwoqXC2ZAFPkwfdJnocMDF/ol8dFrm5bq9I8TbDw4YWv21sBZHEkllbdkNV/5ybAXZKhAQPHx/hEks31WNk8cjS/gnHBBkddOQq009BQCzxT83YmMkA0R6Xb63Vwpfog2y1sE19LQVYEL2KbV5olfU4VN1DziqGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779322213; c=relaxed/simple;
	bh=4WTTzDnU8tOcTpGq7CgnTCThTpEHRj0sAl0IG7EtiY4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NtYPyBWE447YoR1tfNncdQncHu9jZf2hPuUNi3IFVrfCOvvm8YTeieMw7zDcdn1NjFNE/79rALmtc455VMT52FROMhhe7+7SVqIi/Y5WRpA15oA/NcdKnGaEjUu0HQxs5bRrOZNPUqgEcUDSudQxQjP5jCzSH3dTFgc5iv//AVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bik7NtdL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BCC1F000E9;
	Thu, 21 May 2026 00:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779322211;
	bh=V1ZJ41ZjnhM0B9Def/qz9pkrljWgWkUJuPW2Kr4pDio=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Bik7NtdLUNKI6BOjRwdrjNVIJC32Z0kgqv0oYe8ukdjloCjKWFJRE2VRuz/6ZkJ50
	 iVgaUEI39iuTsC+yGC5IUuBhEk8wY3RIdTS8re5ndBRvbjsNdqSQ5ZkSDzQwRLzk9P
	 C894Tc2ozMOvqiC+E/hWuvN0heX8/NaqCk7bu+Iph7svUv4RFRxRPjrgpU4B715JzP
	 11dtMi+unrXsm7juKRr/VM59/0gJTQbAbOD8F/2XhHL6gIs/UNIpK/5ec27HUtrZXE
	 OlHp7UKoXSwWKv9Xbv3Hs7tZ3+45DX3GpKAhnRtyEDLbaDsy4ZI3hpPJ73v11ZHQ44
	 0BFQmMGxg9NDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569A33930C25;
	Thu, 21 May 2026 00:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/11] selftests: rds: Add ROCE support to rds
 selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932222214.3804120.2706643983329253722.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 00:10:22 +0000
References: <20260518012443.2629206-1-achender@kernel.org>
In-Reply-To: <20260518012443.2629206-1-achender@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-21066-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7D47159D2E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 17 May 2026 18:24:32 -0700 you wrote:
> Currently the rds selftests only tests the tcp transport.  This means
> most of rds_rdma.ko has no testing coverage.  This series refactors the
> rds self tests to add an rdma option when running tests.  When used,
> the test creates a pair of ROCE interfaces to run the payloads through.
> 
> Most of this set is refactoring the existing test.py module.  Since most
> of this code is one long procedure, it is difficult to modularize it
> without creating a lot of pylint complaints about lengthy functions
> with too many variables or branches.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/11] net/rds: Don't sleep inside rds_ib_conn_path_shutdown
    https://git.kernel.org/netdev/net-next/c/16f48efaeb69
  - [net-next,v3,02/11] selftests: rds: Add helper function setup_tcp() in test.py
    https://git.kernel.org/netdev/net-next/c/853dee6aec70
  - [net-next,v3,03/11] selftests: rds: Add helper function check_info() in test.py
    https://git.kernel.org/netdev/net-next/c/78bcfe6f34c7
  - [net-next,v3,04/11] selftests: rds: Add helper function send_burst() in test.py
    https://git.kernel.org/netdev/net-next/c/9996b296dabc
  - [net-next,v3,05/11] selftests: rds: Add helper function recv_burst() in test.py
    https://git.kernel.org/netdev/net-next/c/1c8a70b1fb3f
  - [net-next,v3,06/11] selftests: rds: Add helper function verify_hashes() in test.py
    https://git.kernel.org/netdev/net-next/c/f7baddf08bb9
  - [net-next,v3,07/11] selftests: rds: Add helper function snd_rcv_packets() in test.py
    https://git.kernel.org/netdev/net-next/c/3bd27901aa90
  - [net-next,v3,08/11] selftests: rds: Handle errors in netns_socket
    https://git.kernel.org/netdev/net-next/c/0c4d043f61f9
  - [net-next,v3,09/11] selftests: rds: Register network teardown via atexit
    https://git.kernel.org/netdev/net-next/c/a8876203489f
  - [net-next,v3,10/11] selftests: rds: Add ROCE support to test.py
    https://git.kernel.org/netdev/net-next/c/9d4fc641326e
  - [net-next,v3,11/11] selftests: rds: Add ROCE support to run.sh
    https://git.kernel.org/netdev/net-next/c/47f079e56ee5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



