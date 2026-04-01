Return-Path: <linux-rdma+bounces-18882-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNx1EvfazGlzXAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18882-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 10:44:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADCE377088
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 10:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0572B307BF10
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 08:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77653B47D2;
	Wed,  1 Apr 2026 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpUoTwk7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F2339D6D7;
	Wed,  1 Apr 2026 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775032588; cv=none; b=FzKR57K/AWpcX8SuoM06Xbi+/mlDCNWPBZeV2Wmre/UW+Ocx24v3/Eg8UMXZzL5qP8cbhMpWtrMDMjgLZAU1dT7PwqK1LjA195BAysCkMMrTiJiJOPhyLTpW41nlIXnYm3XnKLI/E/y4mvTE7/MjpVWzeReWhosYsGUl/nrLk/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775032588; c=relaxed/simple;
	bh=vO4qgjTinnMC1E1PuMj9/Ho/t5lOuicCn6JPkQ20wN8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qkK8VbXkGLKnG9G5MwhLiDCcwpP5v/ZDH1CpIigmw72WaB9q8pnEYjR8OCjv4yBbMxd/8MLyjxcCbiuv0ehAgJtwGcqcbdHPa3E2dKLCUEGl3N/nokJwLoIsQoqrTWqg+iGqW2eSjbAg3HOGlv5hqawhzCVqX6fDiZgHOIL92VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpUoTwk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1367AC4CEF7;
	Wed,  1 Apr 2026 08:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775032587;
	bh=vO4qgjTinnMC1E1PuMj9/Ho/t5lOuicCn6JPkQ20wN8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=QpUoTwk74QPJEWMqb5UT+C3b3BVVTYMJ1bpaIIDXAdCWrTOtLHYTprWub8HSG4NoX
	 xGOTfuppXShBKFrYjUbF8daw/gwsqKclKtfS50sruytvxvuFDadMub6I63BywDMWVY
	 wAdvkgN2f+BYzN4rjdJDabg1w0q48JsHTu7rkYUoycDAMMEXTP27dhIAesu17bgzHk
	 KQnhB+ee22M3Eu7p02ciNlOuGPW1DX9aGAUBAy3JsRC1hpP5nk3aaC1Q/Sw42y/4ZK
	 Ehk+ECDxGhz7EPVQmeK7OULTFxWEO+HzLoqqlWcAIaW9DpYypNEWTMagQ3E8azMVdk
	 g76UKEGVG+iZg==
Content-Type: multipart/mixed; boundary="===============6776902789597443804=="
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5550407278cf0a1b19f3bca88abc38fdf04c8732a9e543e63590a21b38196313@mail.kernel.org>
In-Reply-To: <20260401074509.1897527-5-dwmw2@infradead.org>
References: <20260401074509.1897527-5-dwmw2@infradead.org>
Subject: Re: [PATCH 4/6] net: Make IPv4-only Kconfig options depend on LEGACY_IP
From: bot+bpf-ci@kernel.org
To: dwmw2@infradead.org,saeedm@nvidia.com,leon@kernel.org,tariqt@nvidia.com,mbloch@nvidia.com,andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,razor@blackwall.org,idosch@nvidia.com,martin.lau@linux.dev,daniel@iogearbox.net,john.fastabend@gmail.com,sdf@fomichev.me,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,kuniyu@google.com,willemb@google.com,dsahern@kernel.org,ncardwell@google.com,johannes@sipsolutions.net,pablo@netfilter.org,fw@strlen.de,phil@nwl.cc,gnault@redhat.com,dwmw@amazon.co.uk,kees@kernel.org,alazar@nvidia.com,gal@nvidia.com,paul@paul-moore.com,netdev@vger.kernel.org,linux-rdma@vger.kernel.org,linux-kernel@vger.kernel.org,oss-drivers@corigine.com,bridge@lists.linux.dev,bpf@vger.kernel.org,linux-wireless@vger.kernel.org,netfilter-devel@vger.kernel.org,coreteam@netfilter.org,torvalds@linux-foundation.org,jon.maddo
 g.hall@gmail.com
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Apr 2026 08:36:27 +0000 (UTC)
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,linux-rdma@vger.kernel.org];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-18882-lists,linux-rdma=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9ADCE377088
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============6776902789597443804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
> index aef2c5349e62..03b5ba75c3cf 100644
> --- a/net/ipv4/Kconfig
> +++ b/net/ipv4/Kconfig

[ ... ]

> @@ -113,9 +119,11 @@ config IP_ROUTE_VERBOSE
>
>  config IP_ROUTE_CLASSID
>  	bool
> +	depends on LEGACY_IP

IP_ROUTE_CLASSID is selected by NETFILTER_XT_MATCH_REALM in
net/netfilter/Kconfig and by NET_CLS_ROUTE4 in net/sched/Kconfig,
neither of which depends on LEGACY_IP.

Would this produce unmet direct dependency warnings when either of
those options is enabled with LEGACY_IP=n?

> @@ -190,6 +199,7 @@ config NET_IPIP
>
>  config NET_IPGRE_DEMUX
>  	tristate "IP: GRE demultiplexer"
> +	depends on LEGACY_IP
>  	help
>  	  This is helper module to demultiplex GRE packets on GRE version field criteria.
>  	  Required by ip_gre and pptp modules.

IPV6_GRE in net/ipv6/Kconfig has 'depends on NET_IPGRE_DEMUX'.
ip6_gre.c uses gre_parse_header() from the GRE demux module.

Gating NET_IPGRE_DEMUX on LEGACY_IP silently makes IPv6 GRE tunneling
unavailable on IPv6-only systems. Should this option be left ungated,
similar to NET_IP_TUNNEL?

[ ... ]

> @@ -226,10 +238,12 @@ config NET_IPGRE_BROADCAST
>
>  config IP_MROUTE_COMMON
>  	bool
> +	depends on LEGACY_IP
>  	depends on IP_MROUTE || IPV6_MROUTE

IP_MROUTE_COMMON is shared infrastructure between IPv4 and IPv6
multicast routing. ipmr_base.c describes itself as "Common logic
shared by IPv4 [ipmr] and IPv6 [ip6mr] implementation".

IPV6_MROUTE in net/ipv6/Kconfig does 'select IP_MROUTE_COMMON'
without depending on LEGACY_IP. When LEGACY_IP=n and IPV6_MROUTE=y,
this will produce an unmet dependency warning.

Should IP_MROUTE_COMMON be left ungated, like NET_IP_TUNNEL and the
other shared options listed in the commit message?

[ ... ]

> @@ -425,11 +449,13 @@ config INET_TABLE_PERTURB_ORDER
>
>  config INET_XFRM_TUNNEL
>  	tristate
> +	depends on LEGACY_IP
>  	select INET_TUNNEL
>  	default n
>
>  config INET_TUNNEL
>  	tristate
> +	depends on LEGACY_IP
>  	default n

IPV6_SIT in net/ipv6/Kconfig does 'select INET_TUNNEL' without
depending on LEGACY_IP. When LEGACY_IP=n and IPV6_SIT is enabled,
this will produce an unmet dependency warning for INET_TUNNEL.

SIT is inherently IPv4-dependent (IPv6-in-IPv4 tunneling), so perhaps
IPV6_SIT also needs 'depends on LEGACY_IP'?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23838411859
--===============6776902789597443804==--

