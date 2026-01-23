Return-Path: <linux-rdma+bounces-15908-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI3IDLb7cmlOrgAAu9opvQ
	(envelope-from <linux-rdma+bounces-15908-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 05:40:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ED770521
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 05:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDFDF300690A
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 04:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3E4392B90;
	Fri, 23 Jan 2026 04:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY2Pk8be"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B0332D0E1;
	Fri, 23 Jan 2026 04:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769143210; cv=none; b=Q+xX7b7y2SNK+p7sp9ex8b+zmLW+PHQGjRLEEDr6OmqaHsqieRCPR4Ygj2Cv1n+QJb181gTDpLp/i3ZPsxFNDITB2z579wPkJF9jQipeKadLZ43XkIxa97TqyGqUH/S6mR6O4IzKPkuETRqMEEexzGCxfF7NXo/nB7iPCtGobhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769143210; c=relaxed/simple;
	bh=EsznYmM7XejyDbiYerQYj6FwGFHP4twu43xWSEu695E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UxQLD/jkAXIx3M/dSV0yyTbKP8Y7PBTmAjaqWQjn2sMfQUjlUiGOb5X1F0dzNorIWfVkdWS2AXj/pJctPlkc6NeeXYgWu3Wg+lrcHrmJRZFz/fkEibW8udXQitNQOLg3yoe4qrCK+1SlMcCIRvgjBTtJUQT6nF6J4lP3SMWcCKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY2Pk8be; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0B6C4CEF1;
	Fri, 23 Jan 2026 04:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769143209;
	bh=EsznYmM7XejyDbiYerQYj6FwGFHP4twu43xWSEu695E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JY2Pk8be6h0MzOVIMlKBqw1Rq/cB8p/uQDppoJREvT3JzzGV2iUx4CfVKj2YMXWQK
	 XwJGy3M+ww1pjymr44m8XDF9hQNBs1223CuVxMOCohx1u7cr9+6pm74vkYuVWMivUD
	 yMPOL4Ss+AqoJrqOkcsQipupYwMiXCVtOb1yIfYnM9W9SMtbcIYlgXNEpy/ozGG7O4
	 iNWn0STZ8tGABvZPCjxQxz3FmeN5fGVI1xXqw/iO5Pm4FjOOc3ieRLzInkCHvUYDFT
	 dLjvGYz0BvjGFMu157tkSgszGt4s2TdnWM7LwzC2sIqzdobNOObuHP0091BgYLzyCO
	 mHgD1raBRY7Ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BCF73808200;
	Fri, 23 Jan 2026 04:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5: Fix memory leak in
 esw_acl_ingress_lgcy_setup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176914320511.2396619.17707051472535714326.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jan 2026 04:40:05 +0000
References: <20260120134640.2717808-1-zilin@seu.edu.cn>
In-Reply-To: <20260120134640.2717808-1-zilin@seu.edu.cn>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15908-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45ED770521
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jan 2026 13:46:40 +0000 you wrote:
> In esw_acl_ingress_lgcy_setup(), if esw_acl_table_create() fails,
> the function returns directly without releasing the previously
> created counter, leading to a memory leak.
> 
> Fix this by jumping to the out label instead of returning directly,
> which aligns with the error handling logic of other paths in this
> function.
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5: Fix memory leak in esw_acl_ingress_lgcy_setup()
    https://git.kernel.org/netdev/net/c/108948f723b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



