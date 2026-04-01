Return-Path: <linux-rdma+bounces-18905-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wG0xKFxRzWmnbwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18905-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 19:09:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD9737E6C9
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 19:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7981315186E
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3F43C1971;
	Wed,  1 Apr 2026 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zabbadoz.net header.i=@zabbadoz.net header.b="M1b/lTq0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx-01.divo.sbone.de (legacy1.sbone.de [80.151.10.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC43472760;
	Wed,  1 Apr 2026 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.151.10.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061885; cv=none; b=hHQBbbSfjt9Y8UUlrMmo8fC9aZynqwudBQd7tW+cm2F/SRN2HXYWYVMM3k1mcP5G9in9Qxk67wtV2vOPA65HpZ0wxSPrWDikGnMNJv6dT2P2CViIOeTEkPWueBybRlu+GQIbZAAuRSFjrdI7Fe0wG8ym1iK/e/p0HlXHipmnx+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061885; c=relaxed/simple;
	bh=L7QYUKOAasoCSYere7gl554w+Twajp2xHlhYrh3+o4s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-Id; b=FryMQoaMSyFOTOgQeX0f94wSh6C0oaMJ+qHcDS9X2BMtk43tOyEpQ8F50QiUZ3b6haxNyyiS/8zbRdZ0WegiZB4NBkJV43LOJ0zYkbk1DrEsoMsuFsyOnpAaa+WG3vCJdSOZQBDOunnxLmsG9gHbfRdctJ/6hfeyMN+XEHZ6rCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.zabbadoz.net; spf=pass smtp.mailfrom=lists.zabbadoz.net; dkim=pass (4096-bit key) header.d=zabbadoz.net header.i=@zabbadoz.net header.b=M1b/lTq0; arc=none smtp.client-ip=80.151.10.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.zabbadoz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lists.zabbadoz.net
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:1025])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mx-01.divo.sbone.de (Postfix) with ESMTPS id D9902A64805;
	Wed, 01 Apr 2026 16:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zabbadoz.net;
	s=20240622; t=1775061285;
	bh=L7QYUKOAasoCSYere7gl554w+Twajp2xHlhYrh3+o4s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=M1b/lTq05e8KeboSTmXSX7M1YW9zV+QAk2vw6i+E8gwT1jgX8ScvW5jMD08uWILnk
	 hjmryFuzVdO6KTWrTwpfjPv+/9jNSOSN4abNHubpizWYq68eJ6NKlMeKSrY31UJQgk
	 +OqnAPYrDptHXN77ujSvPs7GsD4F8VTJx24/Oo8A5LKasyca8kBPPajU3vwSVrGHVc
	 7D+WzRaTjhyhYzS5R/w3aKdjjU1KHLzqZxNGWv4dHUxnI3/vwKzh09LcVOgxm4KOtg
	 zVjCJ1qBIN+NdzlhA+f0zP8ojXW0WYy/bORGZMtTUfZOCj928GNLhLKmRXyeiJDe9+
	 ZIP5oyrNsYdM+wZuZjZhoglbRXUmMVdHSknEYsjgXeztybOHVcfCMBfvep6X7sN0VS
	 YaeCs+e1c0yfnHD940PJyp7+EHpZkLukoP0+pC1C+xXylHVFRo7DhKbfTgqEsS/iZU
	 DvqAN9R7c4dRylj+uHD7onpO3y4oDDI20o3N3GTeK/RPsIBIU1wL7kcMbWQ67/NuvO
	 cMWKiLg1ww3avLz+Rahz0w7JZqN0p+ekNxl19IVby5BBH+hq/qCEb3YOoCZClU5ARv
	 F+UDmS+dArLaOr9eOg0CMQp9PJcn4sFG5peJB/zGrPeHzFtW76RdyLZQXsfclUyRKt
	 XrdKNAmsvH9zIf1fV5hZILXk=
Received: from content-filter.t4-02.sbone.de (content-filter.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:2742])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.sbone.de (Postfix) with ESMTPS id 8CD4A2D029E9;
	Wed,  1 Apr 2026 16:35:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:4902:0:7404:2:1025])
	by content-filter.t4-02.sbone.de (content-filter.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:2742]) (amavisd-new, port 10024)
	with ESMTP id 2IW08zsrTcK7; Wed,  1 Apr 2026 16:35:03 +0000 (UTC)
Received: from nv.t4-02.sbone.de (nv.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.sbone.de (Postfix) with ESMTPSA id AE4862D029D8;
	Wed,  1 Apr 2026 16:35:00 +0000 (UTC)
Date: Wed, 1 Apr 2026 16:35:00 +0000 (UTC)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
To: David Woodhouse <dwmw2@infradead.org>
cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
    Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
    Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
    Nikolay Aleksandrov <razor@blackwall.org>, 
    Ido Schimmel <idosch@nvidia.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
    Daniel Borkmann <daniel@iogearbox.net>, 
    John Fastabend <john.fastabend@gmail.com>, 
    Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
    Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
    Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
    KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
    Jiri Olsa <jolsa@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
    Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
    Neal Cardwell <ncardwell@google.com>, 
    Johannes Berg <johannes@sipsolutions.net>, 
    Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
    Phil Sutter <phil@nwl.cc>, Guillaume Nault <gnault@redhat.com>, 
    David Woodhouse <dwmw@amazon.co.uk>, Kees Cook <kees@kernel.org>, 
    Alexei Lazar <alazar@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
    Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
    linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
    oss-drivers@corigine.com, bridge@lists.linux.dev, bpf@vger.kernel.org, 
    linux-wireless@vger.kernel.org, netfilter-devel@vger.kernel.org, 
    coreteam@netfilter.org, torvalds@linux-foundation.org, 
    jon.maddog.hall@gmail.com
Subject: Re: [PATCH 0/6] Deprecate Legacy IP
In-Reply-To: <20260401074509.1897527-1-dwmw2@infradead.org>
References: <20260401074509.1897527-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Message-Id: <20260401163500.AE4862D029D8@mail.sbone.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zabbadoz.net,none];
	R_DKIM_ALLOW(-0.20)[zabbadoz.net:s=20240622];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,amazon.co.uk,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev,linux-foundation.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,freebsdfoundation.org:url,mail.sbone.de:mid,zabbadoz.net:dkim];
	DKIM_TRACE(0.00)[zabbadoz.net:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18905-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bzeeb-lists@lists.zabbadoz.net,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BAD9737E6C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/1/26 07:44, David Woodhouse wrote:

Hi David,

(fun fishing this out from nntp.lore.kernel.org needing NAT64)

> RFC1883, the IPv6 standard, was published in the final decade of the 1900s.
> That's closer in time to the Apollo 11 moon landing than it was to today.
> 
> Even our esteemed Maddog has worked with computers for longer in the IPv6
> era, than he ever did before it.
> 
> Yet Linux still can't even be *built* with only IPv6 support and without
> support for Legacy IP. This long overdue patch series fixes that, and
> ...

This is very interesting; I'll be happy to read the more serious 
discussions for 6/6 this year then :)

That said, I've been there 15 years ago and done that for real,
just not for Linux:
https://freebsdfoundation.org/blog/freebsd-foundation-and-ixsystems-announce-ipv6-only-testing-versions-of-freebsd-and-pc-bsd/

A lot of parts (e.g., PC-BSD,the IPv6-only snapshots we published 
back then, websites) are long gone, but FreeBSD today still has NO-INET
(as well as NO-INET6 and NO-IP) kernel configs which are regularly tested
as part of a universe build to make sure the status-quo stayed, along with
options to build (large parts) of userspace without IPv4 support.

I have since run real IPv6-only machines :]]
EAFNOSUPPORT and EPROTONOSUPPORT are (were) a good friend of mine.

It helped a lot back then to find applications which had real trouble
working without IPv4.
It was fun sitting in a UKNOF presentation years later to hear about
all these applications just working on IPv6-only and knowing why, whereas
the presenter was unaware, and still had a 127.1 on his loopback *sigh*

IPv6-only is something a lot of people will not understand and someone
just has to do it!  It is a worthwhile goal, even if late, as you say.
My reminder to people these days is: DNSsec is even older than IPv6.

I have moved on (though would love to go back to more IPv6);
please feel free to get in touch in case you want me to go and swap in
some more memories from that time to share experience and help.

To the global deployment of IPv6!
/bz

