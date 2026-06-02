Return-Path: <linux-rdma+bounces-21647-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5uJoJac/H2qUjAAAu9opvQ
	(envelope-from <linux-rdma+bounces-21647-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 22:40:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2581F631D16
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 22:40:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dbCAVXTa;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21647-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21647-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94BB2302DC55
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 20:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04211370D70;
	Tue,  2 Jun 2026 20:40:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD18431F9A3;
	Tue,  2 Jun 2026 20:40:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432804; cv=none; b=d4wc5EEzslaR9EeZ2fwn5Jv7G3dzTgXGWRvKed77paz8lTyllZeZ+Iy3/Ur6SSNfeNYyH1PaGnICGpw2FI3Tztbp6kcMKYKvenP96DmwfVWzOo3Is0rpjQym0X5DdX8OKI74d/0Bd0IEn+8cvXcndti7Bi0KQZIdefvBPh+fXSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432804; c=relaxed/simple;
	bh=BfLDQr9pt69S8MlWwDuy/Z+mVbeCcUXRj22h9jDPRSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WT/YZr99qNCRHGISNa5amqIMJ/vZseZWsHQt6LDDi+KDuIr005JS1jqJyXZ1ixb2ZuZhqUiVgNhFWSRCNPe20wW5itmUauz2OKkMbsk0pWmDl4Z3g2zfYx0Y8uHphDjyA9ZRqQX8479EU8yy2wgxsHPd26NeLgWBCYvMDDcxvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbCAVXTa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FFC1F00893;
	Tue,  2 Jun 2026 20:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780432803;
	bh=FOpl/ZpM26+tD54wKWBy5O0+u1RCyEjX0Ylp6b3/Ybg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dbCAVXTa1jblXOpkluhoDXnzArjP+63aCEXBYvb9ccHtNXONNhK4cnwNyr2JtR5TB
	 Ru4fkcw4ieIU6akcYldRp36DiyMwu2V42fqKKLGZHjbl7xMyqVsDAQVyV0m8H+yyuN
	 Hjlwcbh1xcgoN0GTRkC3ahWHn6fuMpnSgxhV9aEPWwM/eaP4JFawVcki8B8XQv2oGn
	 KdGTLP75Tc4roMZ2TpTr6lYayJEs0priqyEXqqn1zIFX53sejxm9JoSVlVlatWcUU6
	 fkmcBYKS/zZo7RYnWY/tpE56M9CbReuDuGPLKx67aiJkPty9S9gqHAMNaOBo+oyNXb
	 MkkDIDnk8aJqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93CAE3811A72;
	Tue,  2 Jun 2026 20:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net: rds: clear i_sends on setup unwind
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178043280517.1040770.3974828278309991048.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 20:40:05 +0000
References: 
 <5a0f7624bb9845a7b67d26166a150b59e7f394ce.1779632468.git.xuyq21@lenovo.com>
In-Reply-To: 
 <5a0f7624bb9845a7b67d26166a150b59e7f394ce.1779632468.git.xuyq21@lenovo.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, achender@kernel.org, yanjun.zhu@oracle.com,
 guanglei.li@oracle.com, davem@davemloft.net, santosh.shilimkar@oracle.com,
 junxiao.bi@oracle.com, yuantan098@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, xuyq21@lenovo.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,oss.oracle.com,kernel.org,oracle.com,davemloft.net,gmail.com,lzu.edu.cn,lenovo.com];
	TAGGED_FROM(0.00)[bounces-21647-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:achender@kernel.org,m:yanjun.zhu@oracle.com,m:guanglei.li@oracle.com,m:davem@davemloft.net,m:santosh.shilimkar@oracle.com,m:junxiao.bi@oracle.com,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:xuyq21@lenovo.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lenovo.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2581F631D16

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 21:01:44 +0800 you wrote:
> From: Yuqi Xu <xuyq21@lenovo.com>
> 
> The RDS IB connection teardown path is written so it can run during
> partial startup and on repeated shutdown attempts. It uses NULL
> pointers to distinguish resources that are still owned from resources
> that have already been released.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: rds: clear i_sends on setup unwind
    https://git.kernel.org/netdev/net/c/20cf0fb715c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



