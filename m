Return-Path: <linux-rdma+bounces-18884-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIm+Dj/gzGm0XAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18884-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 11:07:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F053C377415
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 11:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CA6D30A2970
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 09:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7D63CB2E3;
	Wed,  1 Apr 2026 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJ3SAr9E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0F23CAE85;
	Wed,  1 Apr 2026 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034085; cv=none; b=LUwgKC6fq0K++JNM8EOR9GLtC6V/khORdhTRHkDQWablMatjcbeyON9t3oXll05UA9B+YyUw69tQkRxOOIhf5T7WlEnLZjfKvDsWLi0HCWYkkCd6d8Zw3v9/RxOoi2jGn4QsrMWY+Fc2j7P1UAINNRW9HIOCLCyL896IF8MjpJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034085; c=relaxed/simple;
	bh=pjlrfUH8eUQ+zCivUMUKUassfapoyoThebsNFDFzdp4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YXSElQI/TCdojvbSK5Zl1QdMF4nr3QetyVaiIaSQByjPIQYQz9PYj1Q7Z7xvgpSYTA0UsR2NJ2pLMCdkuAJLWJ3lLcBavRLiW+hxNdbOW8TLj9UFo4Ow92voP02PbNkMFoyj8ZSOVxJk9xdqkWOUIB4NxrCffO6KhhuHk3CO5UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJ3SAr9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB42C4CEF7;
	Wed,  1 Apr 2026 09:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775034085;
	bh=pjlrfUH8eUQ+zCivUMUKUassfapoyoThebsNFDFzdp4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=pJ3SAr9Ex+S5hQMA/Ph7zhn38RBnzGKY6Ylul6pDXNW9SXNaowNqlsHSgRBVw+pTa
	 P63PJOVxf0bcO+NkqlDNqUrxHTciHsLsg5H+UP2ivEgkoetFaorB+uNBKuSsybJVlC
	 Ktybf8zDkelHT6s9jN4F+xz3ZjlZ3xWKf/ziMk/rH4Jlq43f2bIW8+wF+mfoAJYSfr
	 oGJdR/JYFAYduL+eNbCDtW9bjbzOIDzrMTqRVssUniyyriI6aeoyfbmILuYivbpz8o
	 nCwwnSDa+JbvwEH7gRcskKZM9Zc/xjLa134EPrD7HpiJikTIstysnOm/2U764xr6ws
	 e6vLdrtlMXwwQ==
Content-Type: multipart/mixed; boundary="===============8023301804951780972=="
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8dceda43e1d8fe0c9f3f34e035b5a4e66a40587db780e3722b88ad25e5797eec@mail.kernel.org>
In-Reply-To: <20260401074509.1897527-6-dwmw2@infradead.org>
References: <20260401074509.1897527-6-dwmw2@infradead.org>
Subject: Re: [PATCH 5/6] net: Change CONFIG_INET to CONFIG_LEGACY_IP for IPv4-only code
From: bot+bpf-ci@kernel.org
To: dwmw2@infradead.org,saeedm@nvidia.com,leon@kernel.org,tariqt@nvidia.com,mbloch@nvidia.com,andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,razor@blackwall.org,idosch@nvidia.com,martin.lau@linux.dev,daniel@iogearbox.net,john.fastabend@gmail.com,sdf@fomichev.me,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,kuniyu@google.com,willemb@google.com,dsahern@kernel.org,ncardwell@google.com,johannes@sipsolutions.net,pablo@netfilter.org,fw@strlen.de,phil@nwl.cc,gnault@redhat.com,dwmw@amazon.co.uk,kees@kernel.org,alazar@nvidia.com,gal@nvidia.com,paul@paul-moore.com,netdev@vger.kernel.org,linux-rdma@vger.kernel.org,linux-kernel@vger.kernel.org,oss-drivers@corigine.com,bridge@lists.linux.dev,bpf@vger.kernel.org,linux-wireless@vger.kernel.org,netfilter-devel@vger.kernel.org,coreteam@netfilter.org,torvalds@linux-foundation.org,jon.maddo
 g.hall@gmail.com
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Apr 2026 09:01:24 +0000 (UTC)
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,linux-rdma@vger.kernel.org];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-18884-lists,linux-rdma=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F053C377415
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============8023301804951780972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index ad71ceefcb5e..ef99bd9fddd6 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -6095,7 +6095,7 @@ static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu)
>  }
>  #endif
>
> -#if IS_ENABLED(CONFIG_INET)
> +#if IS_ENABLED(CONFIG_LEGACY_IP)
>  static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>  			       u32 flags, bool check_mtu)

bpf_fib_set_fwd_params() above this hunk is still guarded by
CONFIG_INET, and its only two callers are bpf_ipv4_fib_lookup()
(now CONFIG_LEGACY_IP) and bpf_ipv6_fib_lookup() (CONFIG_IPV6).

When CONFIG_INET=y with both CONFIG_LEGACY_IP=n and CONFIG_IPV6=n,
bpf_fib_set_fwd_params() becomes an unused static function, which
will produce a -Wunused-function warning and break CONFIG_WERROR
builds.

Should the guard on bpf_fib_set_fwd_params() be changed to
something like:

  #if IS_ENABLED(CONFIG_LEGACY_IP) || IS_ENABLED(CONFIG_IPV6)

to match its actual callers?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23838411859
--===============8023301804951780972==--

