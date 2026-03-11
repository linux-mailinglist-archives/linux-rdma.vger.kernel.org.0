Return-Path: <linux-rdma+bounces-17926-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNzjBMPMsGkKnQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17926-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 03:00:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ECC25A901
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 03:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A3F13019137
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 02:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C85E279358;
	Wed, 11 Mar 2026 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obp5fL+T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19DC40DFDC;
	Wed, 11 Mar 2026 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194414; cv=none; b=pw6TX9G0Igc1Vg7tNxIPJC/cLB12tY4Cz8tmh8rIfO3n46O0+scRJt6jCfMedznaVpjAvcauIjNdXL38d0GCFrvlMCMN8d5H+Q4sG/fqoAYo+Hx9TDtARcxA3PXoDO/03jojNd/uQmi3Axp/vGsBibHDMttBPBn5SN8dlUX3NMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194414; c=relaxed/simple;
	bh=7oQsrjvVzZ5mAX7oahP+q9uAGu6aT7sQyIPPZDUXvJM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lagALbwq2Dlt9hYtJaAUOmLjMUccG4ubjVBwiVhSGtfGE7XR6lW3a8CKb+QWOb4nZ2lJeWLWSPmSR60Wi4ROFTUoeFlztgSlUhTkdABw9IXyflzpQIJamKmtZyX+MQ9FzQBZ2IPTWla2U25Okk97RmhCveP8G838OHjoZMpW7cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obp5fL+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913ABC19423;
	Wed, 11 Mar 2026 02:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773194414;
	bh=7oQsrjvVzZ5mAX7oahP+q9uAGu6aT7sQyIPPZDUXvJM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=obp5fL+TVrt9P904vLo7cvO0mTqUCvFoFb8N/GNVnOU7oVX3PvMuFLbJSACIKRm4r
	 BQaANeE7D0/+zOWXNIWghKp5qrvYBzdf39jB/JHI2D1991465Bqews5TNb9c6CQgRL
	 14rl9x3i87pNptbGgNmTaIbE+iV00KNzn867kRTOQSEk1Uw+N6as2wCKf6DZUNFc8Q
	 +pJrtcy6SanWI/fY7EGL4hStHpTvyjFmMsVEaCcbFK4lqI8iOtRMs7uI2TLzBRbzlU
	 TtbCjUPKG86W3TIjjq7W40vkFZbn8lWTw636OXnD60Jtmwok2ougF7jMLH2weG4zhC
	 HuIYlnaQYEhRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCFA3808200;
	Wed, 11 Mar 2026 02:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 0/3] selftests: rds: ksft cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319441103.3000247.9451986175005082241.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 02:00:11 +0000
References: <20260308055835.1338257-1-achender@kernel.org>
In-Reply-To: <20260308055835.1338257-1-achender@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pabeni@redhat.com, edumazet@google.com, rds-devel@oss.oracle.com,
 kuba@kernel.org, horms@kernel.org, linux-rdma@vger.kernel.org,
 allison.henderson@oracle.com
X-Rspamd-Queue-Id: 64ECC25A901
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-17926-lists,linux-rdma=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  7 Mar 2026 22:58:32 -0700 you wrote:
> Hi all,
> 
> This set addresses a few rds selftests clean ups and bugs encountered
> when running in the ksft framework.  The first patch is a clean up
> patch that addresses pylint warnings, but otherwise no functional
> changes.  The next patch moves the test time out to a ksft settings
> file so that the time out is set appropriately.  And lastly we fix a
> tcpdump segfault caused by deprecated a os.fork() call.
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/3] selftests: rds: Fix pylint warnings
    https://git.kernel.org/netdev/net-next/c/5a0c5702bd00
  - [net-next,v1,2/3] selftests: rds: Add ksft timeout
    https://git.kernel.org/netdev/net-next/c/b873b4e16042
  - [net-next,v1,3/3] selftests: rds: Fix tcpdump segfault in rds selftests
    https://git.kernel.org/netdev/net-next/c/87fdf57ded3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



