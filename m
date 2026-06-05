Return-Path: <linux-rdma+bounces-21816-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7F+LDw4pImpDTQEAu9opvQ
	(envelope-from <linux-rdma+bounces-21816-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 03:40:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D3164477A
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 03:40:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ftUT378C;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21816-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21816-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA6D1302F40A
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 01:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0833DDDD3;
	Fri,  5 Jun 2026 01:40:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763673DE43D;
	Fri,  5 Jun 2026 01:40:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623625; cv=none; b=En9DT/rkGZOnQrEsXlgDkrpocGH1CDMy8/ncKyAIVQE1KrVXuTOVKAMhrcRbupFqeIGwTe3B+v1kaFayq9sr8rRGynabX6nz9CIa4yIdCCRj1mKEAUGWZr33hOvirG0GJCI/wOjMWynfvpIIJwqqpVX+se5+omYGWIiArrO1YQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623625; c=relaxed/simple;
	bh=4AEfSWKkdJNyzUgvpPlXBv+nsJC1XKVJru7T5c4QWfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZJrmbp0Leuh72tcQCN+UdnVUdPRptvgWjBQ/2gUKKl4OmYFME+zJ2WSIPeo9Ud/nxVLz3vd5Hk9M19zkTf1nica/Bv011EgxItfT3nuCm05KIWNvUK7u+vIkr94Hyb35W3U6lWxzUkTWZPr4Y8v/yBwFYjAK58RV9NilpvqptRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftUT378C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB731F00893;
	Fri,  5 Jun 2026 01:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623616;
	bh=UP+DrtQ07tytdGGieOfM3dKAHlhCO92qNLfifTM2/gY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ftUT378CdSLv/h3vUglOMRAGnwbEMMiv/N+PRyhdL8lA9W4ujV16XBvkyDqOGUXG4
	 4Tza1WyIZkQusAUwFKadCnOP8fN/R3opVBCmkEKFKW6HflnCbkIbDxYhI+hjbQ1w5l
	 5izvkPCsTLwWb/QpXwS2fXSGmOa1sQHgGlY0Rz+HVAJZNrXN6OTIkJvGfom/YRsxyg
	 n4alNdkfQb/l2aplIXrh2n5++yX6yboNqJZpFJZ9WFnUf6efj7ssVA4oioEFStGb21
	 4bT0o+0wJCINYKmHtw6w0U7Oble/pZcvcuWDQkVf9211RCh284HY/pbDNZN/6K7L1y
	 GNqWryO1gKXyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D10523930A8B;
	Fri,  5 Jun 2026 01:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] selftests: rds: ROCE support follow ups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062361652.3097022.10798618190558791022.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:40:16 +0000
References: <20260602050657.26389-1-achender@kernel.org>
In-Reply-To: <20260602050657.26389-1-achender@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-21816-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:shuah@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[run.sh:url,rds_run.sh:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0D3164477A

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Jun 2026 22:06:53 -0700 you wrote:
> Hi all,
> 
> This is a follow up series to the "Add ROCE support to rds selftests"
> series.  The first patch renames run.sh to rds_run.sh, which provides
> a self-describing name that appears on the netdev CI dashboard.
> 
> The second patch addresses a sashiko complaint that I thought was
> worth circling back for.  In the patch "pin RDS sockets to their
> intended transport," sockets are pinned to the specific transport they
> are meant to test.  By default, socket transports are implicitly
> selected based on the network topology, but it is possible that they
> can fail back to other transports if the underlying connection could
> not be established.  So the patch pins them to the intended transport
> to avoid false positives.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] selftests: rds: Rename run.sh to rds_run.sh
    https://git.kernel.org/netdev/net-next/c/6d05d3cb44c5
  - [net-next,v3,2/4] selftests: rds: pin RDS sockets to their intended transport
    https://git.kernel.org/netdev/net-next/c/d2e76c5b1418
  - [net-next,v3,3/4] selftests: rds: support RDS built as loadable modules
    https://git.kernel.org/netdev/net-next/c/c5eb137685f3
  - [net-next,v3,4/4] selftests: rds: report missing RDMA prereqs as XFAIL
    https://git.kernel.org/netdev/net-next/c/e3ab0affc10f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



