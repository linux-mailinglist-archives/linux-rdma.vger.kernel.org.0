Return-Path: <linux-rdma+bounces-17197-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEYWJoG6n2n5dQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17197-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 04:14:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CD31A0609
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 04:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28261311DD7D
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 03:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B8C3876DA;
	Thu, 26 Feb 2026 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxpvT19p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8CA3876D2;
	Thu, 26 Feb 2026 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772075419; cv=none; b=VGuMZzUhNygHitXUqz+RFpYVMZw+ghS6e86kn29I0Eh5+rbRgs4y/fUdZVRC7awkkRXMMSVF70seZ+xPT/aW286HUie9p4pa+66o1VTG1M7pyFyUl+s9RJTJsMNJQi9dezqrTzI0wn67HHVJguEWfZz6KqY+YKZXxSM5OBmqD2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772075419; c=relaxed/simple;
	bh=nOBqaLXjj7R4kBWADNygNeYGSHiaYamuf56RIyQ7wQM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U2IEu70MkQbG1N9ZahkZQKSgTcz9GA/daquKJQDEtTJni1E/o4+FhiVcwD4yEpRdTJLl0J2D1KIG4BlN/jxEqRE+hQ9dRan0j23C9JQoNGwB06/+YWN1hUnQaDsV65I7lHjIM4ygWSEpefuJ1lpdOLad11xBTCNOSH/KXbqTJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxpvT19p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE8FC19421;
	Thu, 26 Feb 2026 03:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772075419;
	bh=nOBqaLXjj7R4kBWADNygNeYGSHiaYamuf56RIyQ7wQM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OxpvT19pkka0J+hWP9y4QAcRkN1/Wdxmmi27R+v3K//fWnfj5wKp5I17tMLVwNsDp
	 ogzRWyjYl2Z0Xt69kq3DuZRVfa70CBIeabCXsBsGY2wtGAAR4IpzXysR8EnPpsMr7+
	 dYXpPB166d/bNawwGNGbUb5JIdHBrwGvjuNqEL7oDcd4waPJXucFyy3z3N+Yz+VaNg
	 9dFP6NV7FbTHLRm4H1dDYG8RFomePUcHtqYQxtebXqsOMHzgvXC/ujw/Tk579vRe4C
	 l7aA5ssmeQtRAvkQMhNGwnL19LyUYZ7sNFIJL/uX2yAtJxQpInHfNlFc2V7uh7Adr0
	 WCJ9pK0jDwFeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C11380A94B;
	Thu, 26 Feb 2026 03:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/rds: update outdated comment in
 rds_send_xmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207542353.1014739.1899202695773856519.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:10:23 +0000
References: <20260225053544.1971-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260225053544.1971-1-kexinsun@smail.nju.edu.cn>
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org, julia.lawall@inria.fr, xutong.ma@inria.fr,
 yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17197-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nju.edu.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51CD31A0609
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Feb 2026 13:35:44 +0800 you wrote:
> The function rds_send_reset() was subsumed by rds_send_path_reset()
> by commit d769ef81d5b5 ("RDS: Update rds_conn_shutdown to work with
> rds_conn_path").  Update the comment accordingly.
> 
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
> ---
>  net/rds/send.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next,v2] net/rds: update outdated comment in rds_send_xmit
    https://git.kernel.org/netdev/net-next/c/51432958b565

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



