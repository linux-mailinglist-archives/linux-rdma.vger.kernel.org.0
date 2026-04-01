Return-Path: <linux-rdma+bounces-18887-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCwjN+PlzGnuXgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18887-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 11:31:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C56DC377A5C
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 11:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5406F3062AA2
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079713D0905;
	Wed,  1 Apr 2026 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvlnRkSJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3810299943;
	Wed,  1 Apr 2026 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035598; cv=none; b=N/1CbhzyfzRbTnXgCnCsRuPGIAiTsjRZ2osCGLLumfml5hkAArPxmb26cg0ON6k0gPXLTK8sd4M+CxhIYl+uCTwoVnhyk74Mo4cEbqxMtSb4wV67lTuTfhlDBzSyQs5VxySpxoeQaVDHdegSdtyG8boBqdwtWs/9WC8gToHnOKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035598; c=relaxed/simple;
	bh=JIcw26Hc3Mu3Qcd/EH+auFaYy2XtO5pvzCilu99fKaQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UjxWeF+3geIONya5Iwu7a1smRwrxTDBM/lKtILI+LY205/UIuZEZ+okkf3fxEIu1lMs1fNy7hsg+VYGBHIbBK60qowtMdxwhl7yL0gaIqjysK3oiqAR22gf1gv1/edksjEuwvGOg/FbOiHeSFaWImmoMupHRjIpHFKRZAqmfMoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvlnRkSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750E8C2BCB0;
	Wed,  1 Apr 2026 09:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775035598;
	bh=JIcw26Hc3Mu3Qcd/EH+auFaYy2XtO5pvzCilu99fKaQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=AvlnRkSJHHdWt7Vjph0JpQxDC0XKdsYE7NQUZK2YW1za5+/qcyN+s1CN4dMKiETiy
	 qMgY0HiHI2eD7DUPlKCG3uFufdT5mkC+9maaSHDw+4UlQs3SkuFODZPtzvMi5mxEuy
	 JVBiFd7TtgW0ykz2YD0Gv4D+gd8aiiqmU29OBUUfDc9YLSAeWe7gzEexv6a1z2GS81
	 1yK1aEe3r38WJ327KC1mJWYVFdhCjGFO+sG+pzbVxmUuutWdkQRaIY7xKM4/7ORPel
	 Dmjez1zvYL51EFuMcdXCyfYGR8OCcF35fqQDoX/9T8uZczpOUyncLurFZY0Ez3Cy+m
	 we29uew5WuRow==
Content-Type: multipart/mixed; boundary="===============6263837824321503141=="
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d51e277490dc17d5bdaadff80c625f0f882596a34b6dfb30c00684e42f7634dd@mail.kernel.org>
In-Reply-To: <20260401074509.1897527-7-dwmw2@infradead.org>
References: <20260401074509.1897527-7-dwmw2@infradead.org>
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
From: bot+bpf-ci@kernel.org
To: dwmw2@infradead.org,saeedm@nvidia.com,leon@kernel.org,tariqt@nvidia.com,mbloch@nvidia.com,andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,razor@blackwall.org,idosch@nvidia.com,martin.lau@linux.dev,daniel@iogearbox.net,john.fastabend@gmail.com,sdf@fomichev.me,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,kuniyu@google.com,willemb@google.com,dsahern@kernel.org,ncardwell@google.com,johannes@sipsolutions.net,pablo@netfilter.org,fw@strlen.de,phil@nwl.cc,gnault@redhat.com,dwmw@amazon.co.uk,kees@kernel.org,alazar@nvidia.com,gal@nvidia.com,paul@paul-moore.com,netdev@vger.kernel.org,linux-rdma@vger.kernel.org,linux-kernel@vger.kernel.org,oss-drivers@corigine.com,bridge@lists.linux.dev,bpf@vger.kernel.org,linux-wireless@vger.kernel.org,netfilter-devel@vger.kernel.org,coreteam@netfilter.org,torvalds@linux-foundation.org,jon.maddo
 g.hall@gmail.com
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Apr 2026 09:26:37 +0000 (UTC)
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,linux-rdma@vger.kernel.org];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-18887-lists,linux-rdma=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FREEMAIL_TO(0.00)[infradead.org,nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,amazon.co.uk,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev,linux-foundation.org];
	NEURAL_SPAM(0.00)[0.999];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[58];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C56DC377A5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============6263837824321503141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index dc358faa1647..3838782a8437 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -240,6 +240,9 @@ int inet_listen(struct socket *sock, int backlog)
>  	struct sock *sk = sock->sk;
>  	int err = -EINVAL;
>
> +	pr_warn_once("process '%s' (pid %d) is listening on an AF_INET socket. Consider using AF_INET6 with IPV6_V6ONLY=0 instead.\n",
> +		     current->comm, task_pid_nr(current));

inet_listen() is the .listen handler for both inet_stream_ops
(AF_INET) and inet6_stream_ops (AF_INET6):

net/ipv4/af_inet.c:
    .listen = inet_listen,

net/ipv6/af_inet6.c:
    .listen = inet_listen,       /* ok */

Since pr_warn_once fires on the first listen() call regardless of
address family, won't this warn about "listening on an AF_INET
socket" when an AF_INET6 socket calls listen() first? Many services
(e.g. systemd socket activation) create AF_INET6 sockets before
AF_INET ones. Should there be a check for sk->sk_family == AF_INET
before printing?

Separately, the warning suggests using AF_INET6 with IPV6_V6ONLY=0,
but when CONFIG_IPV6 is disabled, AF_INET6 sockets are not available.
Should the warning be conditional on IS_ENABLED(CONFIG_IPV6)?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23838411859
--===============6263837824321503141==--

