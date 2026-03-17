Return-Path: <linux-rdma+bounces-18234-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEgFG4DBuGkfjAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18234-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 03:50:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1A72A2EDF
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 03:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2076E3019E38
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 02:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AFF3101B6;
	Tue, 17 Mar 2026 02:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0RRJckj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EC22BEFF5;
	Tue, 17 Mar 2026 02:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773715817; cv=none; b=iYEwfBQdzjpEhsLsBhBOBMkCsxGne0e8WHI6eXzfVZ5FFdmbj2qtalvfLbGsrGJ7DWeczjf4PYYMUEZ4Jy8ObK0m7KAFRV5iGPq/i3tSPKu6MWYYGRxliWN1BZ3rPhY1CFCgBQyfsk4g+8CPQ4+uOSwXHdo4Tm71n0kH3iuaqEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773715817; c=relaxed/simple;
	bh=alVrlu101bAdsJEA+qSPzD9ZCVrbyZEFXQz+beNOU40=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cjlbbxXODCgLjp9t0GRjrqehY16NEhy/9RqHK6hhGvHlSKJwUT5gHGAJQ7GSo6FrUVU1pDbG8jSB1tfKY7GNOdfZnanAeqe43lWy3KUInH87y7xaEk5evJixcsZfISOucQMqVfTzFgGjVJHodU1VN1EjKE0FPY3nZoZ43iAChCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0RRJckj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56502C19421;
	Tue, 17 Mar 2026 02:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773715817;
	bh=alVrlu101bAdsJEA+qSPzD9ZCVrbyZEFXQz+beNOU40=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X0RRJckjHVmk7hzNroZO6Q0S/HDK3/wkmqNWJBQ7Q+xHVPigtLEkkwfBxM5ov60qd
	 XNm2+qk1CnPepSC8hK8fzOhP4q0qVm4+yZeAWkI+kznI4du2AKfE2qPims6fWnbPXY
	 DsRrtOPq653720DLUG5P5QEKOtmOjyZUMAHkuQwYSJjJLj40zhZpueVYMSFZQsiAj6
	 WhiV38VuC71UBkTUknIMm2/BSPex9FQoBQz9/yGfgaziMwB4N4E/7bmX4+QTFUDHda
	 GvqfSsJDWl1PYCyPt4GttfMDDBs6WQDj1Xbj89NU4AUfTeo7S++/U+eVdlXOFRWfkl
	 uPxgMWwVyZfuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF953808200;
	Tue, 17 Mar 2026 02:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net/smc: fix NULL dereference and UAF in
 smc_tcp_syn_recv_sock()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177371580978.3402731.5817717150922524333.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 02:50:09 +0000
References: <20260312092909.48325-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260312092909.48325-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, jiayuan.chen@shopee.com,
 syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com, edumazet@google.com,
 alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, sidraya@linux.ibm.com,
 wenjia@linux.ibm.com, mjambigi@linux.ibm.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18234-lists,linux-rdma=lfdr.de,netdevbpf];
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
	TAGGED_RCPT(0.00)[linux-rdma,827ae2bfb3a3529333e9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A1A72A2EDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Mar 2026 17:29:07 +0800 you wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> Syzkaller reported a panic in smc_tcp_syn_recv_sock() [1].
> 
> smc_tcp_syn_recv_sock() is called in the TCP receive path
> (softirq) via icsk_af_ops->syn_recv_sock on the clcsock (TCP
> listening socket). It reads sk_user_data to get the smc_sock
> pointer. However, when the SMC listen socket is being closed
> concurrently, smc_close_active() sets clcsock->sk_user_data
> to NULL under sk_callback_lock, and then the smc_sock itself
> can be freed via sock_put() in smc_release().
> 
> [...]

Here is the summary with links:
  - [net,v5] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
    https://git.kernel.org/netdev/net/c/6d5e4538364b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



