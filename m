Return-Path: <linux-rdma+bounces-18891-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOYoB9nnzGk/XwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18891-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 11:39:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A9C377D2E
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 11:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C809304ACC0
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 09:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215AC3CFF50;
	Wed,  1 Apr 2026 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwdqM54A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1862372678;
	Wed,  1 Apr 2026 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775036338; cv=none; b=AiUhFnqgpifxFMT/3756U0JQPiXaNPE2n25BQwAZ7hgMLTwqS9x3aYfU/oimLQ2mOIm3rXqQ6I0Mi38AkCtYYFh1capLuqjfmUiyftQ4cyaXVoYSrozsIWN6Y+tkgE/LH4v4AYGysQFvMTM3Lkh/3bCSiui2S42eVJ0+usJFgfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775036338; c=relaxed/simple;
	bh=otqIxiI+ZCHYrt/KE3H1Nc+UCVVOSjITq+pjXX/sb0Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ljvSTCC51eQwMptFNoGN3KE/1Ptagu8UwkGSVOBpBtcRPmsLWhh6HsxGKbiBuI3HWbE49jSA/Vt4npVy+TJ9mr++8IvHMypS7Je+kxqpqvpXVK+Xqt7hmUrjDx6mgx4q9DjIPUfBsLomBaiH6bQAnkMJKnpz2SW8sH0+ZCgMSoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwdqM54A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53A6C4CEF7;
	Wed,  1 Apr 2026 09:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775036338;
	bh=otqIxiI+ZCHYrt/KE3H1Nc+UCVVOSjITq+pjXX/sb0Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=YwdqM54ArEb9hcdPTw7hrP78RL9RzX6pL/lZ1LQxiI67/Xec7ykGmVDeq6lV/wCPX
	 t/IhfWP/xv6eEhPnC2ReRYQ5TX/MuVWyV4kWxMX4J5w9xBVghs25YiLRdos5VarbGf
	 cRcsavh0H72yOK8z36YDsu2D4zCi9NsD1KXMtXNEHGISBwhoHEhWkLXtgvqdswrO91
	 EQSHYngjf9g9pNK1zVz+pUf8x4r281bGYgAHqI+9OQ5G/QoapCaTUgPMc6AVXRqTG8
	 cpri8uTGseGf+vACFRelFuACO8Ghu7bSuLwNFbCplaD2EvU3wEghxTv6ytTaCpKbzy
	 SE1ORF+KbQi1g==
Content-Type: multipart/mixed; boundary="===============4427048767068747075=="
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8ffea79650bc8b224d087c22abd2356beae69af6e9545f163f40721e1377f84c@mail.kernel.org>
In-Reply-To: <20260401074509.1897527-4-dwmw2@infradead.org>
References: <20260401074509.1897527-4-dwmw2@infradead.org>
Subject: Re: [PATCH 3/6] net: Guard Legacy IP entry points with CONFIG_LEGACY_IP
From: bot+bpf-ci@kernel.org
To: dwmw2@infradead.org,saeedm@nvidia.com,leon@kernel.org,tariqt@nvidia.com,mbloch@nvidia.com,andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,razor@blackwall.org,idosch@nvidia.com,martin.lau@linux.dev,daniel@iogearbox.net,john.fastabend@gmail.com,sdf@fomichev.me,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,kuniyu@google.com,willemb@google.com,dsahern@kernel.org,ncardwell@google.com,johannes@sipsolutions.net,pablo@netfilter.org,fw@strlen.de,phil@nwl.cc,gnault@redhat.com,dwmw@amazon.co.uk,kees@kernel.org,alazar@nvidia.com,gal@nvidia.com,paul@paul-moore.com,netdev@vger.kernel.org,linux-rdma@vger.kernel.org,linux-kernel@vger.kernel.org,oss-drivers@corigine.com,bridge@lists.linux.dev,bpf@vger.kernel.org,linux-wireless@vger.kernel.org,netfilter-devel@vger.kernel.org,coreteam@netfilter.org,torvalds@linux-foundation.org,jon.maddo
 g.hall@gmail.com
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Apr 2026 09:38:57 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-18891-lists,linux-rdma=lfdr.de,bpf-ci];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1A9C377D2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============4427048767068747075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1922,7 +1922,15 @@ static int __init inet_init(void)
>  	/*
>  	 *	Tell SOCKET that we are alive...
>  	 */
> +	/* Initialize the socket-side protocol switch tables. */
> +	for (r = &inetsw[0]; r < &inetsw[SOCK_MAX]; ++r)
> +		INIT_LIST_HEAD(r);
> +
> +#ifdef CONFIG_XFRM
> +	xfrm_init();
> +#endif
>
> +#ifdef CONFIG_LEGACY_IP
>  	(void)sock_register(&inet_family_ops);

Moving xfrm_init() here places it before sock_register(), but
xfrm_init() calls xfrm_nat_keepalive_init(AF_INET) which creates
per-cpu PF_INET sockets via this chain:

    xfrm_init()
      xfrm_nat_keepalive_init(AF_INET)
        nat_keepalive_sk_init(&nat_keepalive_sk_ipv4, PF_INET)
          inet_ctl_sock_create(&sk, PF_INET, ...)
            sock_create_kern()
              __sock_create()
                pf = rcu_dereference(net_families[PF_INET]);
                if (!pf) -> returns -EAFNOSUPPORT

Since sock_register(&inet_family_ops) has not been called yet,
net_families[PF_INET] is still NULL at this point. This causes
xfrm_nat_keepalive_init(AF_INET) to silently fail (the return
value is not checked by xfrm_init()), leaving the IPv4 XFRM NAT
keepalive sockets uninitialized.

This affects the default CONFIG_LEGACY_IP=y configuration as
well, not just IPv6-only builds. Would it be better to leave
xfrm_init() after sock_register(), or move the
xfrm_nat_keepalive_init(AF_INET) call into xfrm4_init() where
it would run after IPv4 socket registration is complete?

Previously, xfrm_init() was called from ip_rt_init() which ran
well after sock_register():

    inet_init()
      sock_register(&inet_family_ops)   <-- AF_INET available
      ...
      ip_init()
        ip_rt_init()
          xfrm_init()                   <-- worked fine


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23838411859
--===============4427048767068747075==--

