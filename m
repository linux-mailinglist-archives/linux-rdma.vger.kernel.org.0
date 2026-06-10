Return-Path: <linux-rdma+bounces-22079-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NaqwJd2DKWqoYQMAu9opvQ
	(envelope-from <linux-rdma+bounces-22079-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 17:33:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F6A66AD4A
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 17:33:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G70YDoVx;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22079-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22079-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5639130735FD
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EF343CEF3;
	Wed, 10 Jun 2026 15:20:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F8B427A0C;
	Wed, 10 Jun 2026 15:20:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104812; cv=none; b=FRQvNPCx+H4M6OZZcYKK31P2u0HQvU3txHGFEVFMv6/zp5KUnRqcFR2R12VJhrdnNPmeFsLNeYEkWBr+H7GzaMpQOCDUVhT0xCWB8ZvSQgJVUiB8lG0/PfT/+OHssG4WZv0JGqh4Q0cZP6HDcAw8jCEcxoPeapXaoUElWV2yCwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104812; c=relaxed/simple;
	bh=pLCpcmfWdOkh9vAt/shqdNS3cH7550n0VAxQhyMZ4lk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bQte5zy04sanr71wqrlc9nfRB/gYtvX20QuZM9v+64T+dxbSvUcmkOAT+QUWfcUK5VMGEQnWhoTx6xBXDqdp6iMyGe/e8PJsQHFwLiliiU2olezkBqkeCRdTxpCjt65RTeNR3cLOvaAiqW8ZljfBq/dBQaeoCyLic3zCUMktoOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G70YDoVx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AB91F00899;
	Wed, 10 Jun 2026 15:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781104811;
	bh=6i9Jm5okbfmlos5U23G4dUUUadPFjk0l2q7W1GIsH0Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=G70YDoVxLKzDElLXlSz++v14/zxFXPXqcoxYcHEC1HCdy3MTUn4WNEwMITXYWiDhw
	 Q35bcOiqnDg15yAaBLx5JBG3Ao+b1nZKYMNYuDq3P6tEen81Kw0efuN7+7YNwtBGZK
	 cX9vFCPBKfS9A4zTUxvWoCC4N7Z49aIeNtn+ii0RiJUpvbRrnFTmDzzljIACrE3U+s
	 LAsie0jHVF5zQEirKVMznjshrxHUFutMtuafgxwpwAS/voolPcuugmUXYJDqXwyRuV
	 c7k9WdV61ApUuQ/J77T1vfYat1m+QwZEf5cW5s+kA/Fmea9I+pu/en9FcooUVjwh7a
	 WGMpdLLfMoOfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A323930D5F;
	Wed, 10 Jun 2026 15:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rds: mark snapshot pages dirty in
 rds_info_getsockopt()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178110480913.3089075.6318008330720525320.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 15:20:09 +0000
References: <20260608-rds_fix-v1-1-006c88543408@debian.org>
In-Reply-To: <20260608-rds_fix-v1-1-006c88543408@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: achender@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andy.grover@oracle.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22079-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andy.grover@oracle.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71F6A66AD4A

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 08 Jun 2026 02:32:05 -0700 you wrote:
> rds_info_getsockopt() pins the destination user pages with FOLL_WRITE and
> the RDS_INFO_* producers memcpy the snapshot into them through
> kmap_atomic(). Because that copy goes through the kernel direct map, the
> dirty bit on the user PTE is never set, so unpin_user_pages() releases the
> pages without marking them dirty. A file-backed destination page can then
> be reclaimed without writeback, silently discarding the copied data.
> 
> [...]

Here is the summary with links:
  - [net] rds: mark snapshot pages dirty in rds_info_getsockopt()
    https://git.kernel.org/netdev/net/c/512db8267b73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



