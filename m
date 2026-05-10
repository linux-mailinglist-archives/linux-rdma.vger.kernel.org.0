Return-Path: <linux-rdma+bounces-20312-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO+FOtzAAGppMQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20312-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 19:31:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF685056A0
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 19:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BFFF30094FE
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 17:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3FC3612F1;
	Sun, 10 May 2026 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4j40NZ5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFAD8635D;
	Sun, 10 May 2026 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778434263; cv=none; b=HhIeWOI2+vBAT7Te+2qcYnC9vDJ6kAmTIWn568BI3XyB0ZF9erM5rbn4zLe0Sailat3xdeSzksfTmRH4c8mWbOS9mUcSpnOoZzgYTlmQIUSOPDE6dfILNHxtDi7nMmUYqNqmb+TScPmxMz4t7Ux5jwnSeAKm2thfGwHS6QetqFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778434263; c=relaxed/simple;
	bh=zclz00P2RXzk0iut/vDC+fZ5PNjL1f7ECX+axT82ogk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZCPlxE7ikLZeX2W2x3y8WnqAEFfhtuBuj1uRjzmp26QlziNDUv7bY+rgBg8oBYU/7uvf0wgSlIE61MMjLsbqimDUTLKKcO4PwCg/8WnUeCFapZuqb6sxES4A4pzRhKfWidEACWOFdFMZz5/NOCgdrxLAashqN65VvI0DWS5xbQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4j40NZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B7EC2BCB8;
	Sun, 10 May 2026 17:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778434263;
	bh=zclz00P2RXzk0iut/vDC+fZ5PNjL1f7ECX+axT82ogk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e4j40NZ5Jxpte5AHw8vdTYTpu2SoYMrAGSGdMJocjmx1ZoZEubPg+vuIuMZ/pwqd2
	 u0J4hNsROrC/wBzfC0/Loeo2mguPFK+i8RuH04fykmTGntSt3isC9UikEKHPIajtX4
	 mTKV4bL1upL2/Vxptv3Uh0pw0Nql3iq2kDT/pN3pjCgCOKd7w4S7yKkBN+8g30HQy3
	 9yuDjyxzX/0A4y/3xGlIRMgkpgBMKIINFae22d9UKS1txoILYWsDme0ziyO9vO431b
	 SkWAY0JU0jqIgCglclQWGWCDwX1xVp5FBd7rA5+tUlH0WpoIvxxb4H2mfpRDT67ERP
	 OsxLcu1zlmPmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEC63930020;
	Sun, 10 May 2026 17:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 0/3] Log clean up and TAP follow ups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177843421005.1439575.2959535937305070033.git-patchwork-notify@kernel.org>
Date: Sun, 10 May 2026 17:30:10 +0000
References: <20260507233213.556182-1-achender@kernel.org>
In-Reply-To: <20260507233213.556182-1-achender@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
X-Rspamd-Queue-Id: ADF685056A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-20312-lists,linux-rdma=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 May 2026 16:32:10 -0700 you wrote:
> Hi all,
> 
> This is a follow up series to the  "Log collection, TAP compliance and
> cleanups" set.  The sashiko report had made some points that I thought
> was worth addressing.  This patch set fixes a few more TAP compliance
> prints in the check_gcov* routines.  Also since the user must now pass
> in the log folder to collect logs, log clean up is tightened to only
> remove rds* prefixed artifacts instead of the entire folder.  Lastly a
> the signal handler alarm should be disarmed after the completes to
> avoid multiple calls to the stop_pcaps routine.
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/3] selftests: rds: Fix stale log clean up
    https://git.kernel.org/netdev/net-next/c/4840467c84de
  - [net-next,v1,2/3] selftests: rds: Fix TAP-prefixed prints in check_gcov*
    https://git.kernel.org/netdev/net-next/c/490778834a42
  - [net-next,v1,3/3] selftests: rds: Disarm signal alarm on test completion
    https://git.kernel.org/netdev/net-next/c/08724ab1dc17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



