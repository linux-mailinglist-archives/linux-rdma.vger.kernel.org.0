Return-Path: <linux-rdma+bounces-20013-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIX0F+/z+WkOFgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20013-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 15:43:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 168B54CEB96
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 15:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 356B63070202
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CE843636A;
	Tue,  5 May 2026 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Idm8+J8I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF0431F999;
	Tue,  5 May 2026 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988456; cv=none; b=KrqLgUXgzBQqRl6elFJwvUeg581//6LNCqkfFQzkf3szu1/ZWyv4lvhM55MpLxwygHD78pjwHryqcS+nvW85bt5jkWiB+VziWcs1/KrrezblJ+wGdYNz/DOvmxMzHAfYPTzM0xT5aRsU5YEoZ1fGohnqVEs7qStJx+sj18WDifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988456; c=relaxed/simple;
	bh=TMStEg1+ntr8hZqgU/YiQ3XIIjNCu4WGPjFuaFvfY7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DGyAYklRnkUDY3xcmHR6oNR3TtRAvOtoHullh4AGIW6zWYqA739J0BFNk2GqxxfIQemiXf69HtZW2mOD5e2T+i91tZHg9vqSEKupaY5bcKQL276jW/zobVjkJwzSMx+ErUyO+LAf7c0T1qDYOXwI9etAfqDWAANS19KgfHKBm3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Idm8+J8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567CAC2BCB4;
	Tue,  5 May 2026 13:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777988456;
	bh=TMStEg1+ntr8hZqgU/YiQ3XIIjNCu4WGPjFuaFvfY7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Idm8+J8IlfxzfW7jBzRg6mQqiX8iT2t2v6016zJ+XU24Ro8JnlCigY+vwHKDcAF3r
	 bb1DKRNOnKe9xAWfNc92Hm0APH3hi8d0IoGszgJLGKPk65Vrv+2u4RaiwfqKIE4ay3
	 HmkoAIEMzBmm+y+Ba2G8a/XORHRH7n4/xDtK4tjFdDXjjB0zSVUxNYIDX/QQQLazdI
	 LqRa/3IeRYm2b01wTCi8f7iRotSkGFqayV4z2UGrmF4YD+JQMrcfLkz+tNQilyEIQB
	 eQudLWs+nEjfKKOWv58QXeLCxlAWDlrx+dpjOQPPiUGrcKdjRdSBp8Cwf1Eaw1NXsA
	 58qWEihWuCERA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DEF3930235;
	Tue,  5 May 2026 13:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net/rds: handle zerocopy send cleanup before the
 message is queued
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177798840659.2061297.6676935811982463988.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 13:40:06 +0000
References: 
 <d2ea98a6313d5467bac00f7c9fef8c7acddb9258.1777550074.git.tonanli66@gmail.com>
In-Reply-To: 
 <d2ea98a6313d5467bac00f7c9fef8c7acddb9258.1777550074.git.tonanli66@gmail.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, achender@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 santosh.shilimkar@oracle.com, sowmini.varadhan@oracle.com,
 willemb@google.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, lx24@stu.ynu.edu.cn,
 tonanli66@gmail.com
X-Rspamd-Queue-Id: 168B54CEB96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,oss.oracle.com,kernel.org,davemloft.net,google.com,redhat.com,oracle.com,gmail.com,lzu.edu.cn,stu.ynu.edu.cn];
	TAGGED_FROM(0.00)[bounces-20013-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  1 May 2026 09:08:44 +0800 you wrote:
> From: Nan Li <tonanli66@gmail.com>
> 
> A zerocopy send can fail after user pages have been pinned but before
> the message is attached to the sending socket.
> 
> The purge path currently infers zerocopy state from rm->m_rs, so an
> unqueued message can be cleaned up as if it owned normal payload pages.
> However, zerocopy ownership is really determined by the presence of
> op_mmp_znotifier, regardless of whether the message has reached the
> socket queue.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net/rds: handle zerocopy send cleanup before the message is queued
    https://git.kernel.org/netdev/net/c/44b550d88b26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



