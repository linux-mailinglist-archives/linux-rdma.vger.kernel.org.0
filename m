Return-Path: <linux-rdma+bounces-18927-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OvOAbe2zWkLgAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18927-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 02:22:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3320381F5D
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 02:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92794306F5C3
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 00:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C777D1DDA24;
	Thu,  2 Apr 2026 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTVgB/f2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8319D1A681D;
	Thu,  2 Apr 2026 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775089218; cv=none; b=EIn4rm4jCKRVpersCDhN9bQpEmE4YLgaxAI7Euhc8nb380D2AtEr530EOPBWED1kHUWTOSKnfDTGJphhPUfnjBlbLKbADQN03XRyvcuuHNgZ4FXZDT+4BwqSzNujf6l731pG/S0Cvq3g9uf0xpbcvw2hjElec3AadEyF7Jy7iaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775089218; c=relaxed/simple;
	bh=xOc0MxuhOlh/2rYb+V6dfalnuoROdCwJOe5iK0mSue8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NAJ7zLkwc7m11/bX9acbNkMRd0snMdv35clyjj0uk8iXIlCJoaFvx2i2nzzN2mVWLoiUN0r+RudQyahNURLslHNOwy9O/+oCLigql9o63HRqJ0GlSVG5BcPM0qYWIhTF3dU3t+PZETu7kzuiMqkdE8glg0M+XgI0GlrMCkII4IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTVgB/f2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBA4C19421;
	Thu,  2 Apr 2026 00:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775089218;
	bh=xOc0MxuhOlh/2rYb+V6dfalnuoROdCwJOe5iK0mSue8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NTVgB/f2KhYP8gTTFW+iKP8X2zmpwXgR9AjSlmtOydimfF/UilRhtQA6gktQkc9EC
	 4+iVZ4xHV6nvdEEt1mDPodUwFtEcqEEhYltCOC+vUappyuioJZEP0WxxrF/77UqEHG
	 w9xN8QcRT25ABDdtQIr28h4aypusULUgFiKSw2BR4a/m6Z7J/Ji3pS7kZKVvVVuR2v
	 eE5p3zPXhkfIzccjXjnBms6jOrfApzVc7GPIGOX/firjZHvh111/re4pAg6walAmSM
	 zpudH87g5MmIoFwpHAXisRVD3BH4VyXECGFV4NYLPXoHi2VhjRUGP7TsOQ3sF3CbfH
	 vhbA2Ai/1KFmQ==
Date: Wed, 1 Apr 2026 17:20:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Eric Dumazet
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, Martin KaFai Lau <martin.lau@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Johannes Berg <johannes@sipsolutions.net>, Pablo
 Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil
 Sutter <phil@nwl.cc>, Guillaume Nault <gnault@redhat.com>, Kees Cook
 <kees@kernel.org>, Alexei Lazar <alazar@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 oss-drivers@corigine.com, bridge@lists.linux.dev, bpf@vger.kernel.org,
 linux-wireless@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
Message-ID: <20260401172010.6734453e@kernel.org>
In-Reply-To: <20260401080657.70cd9bd1@phoenix.local>
References: <20260401074509.1897527-1-dwmw2@infradead.org>
	<20260401074509.1897527-7-dwmw2@infradead.org>
	<CANn89i+GHkkubJp3MTKZ_r4tde1qLejfsxUh+w0gPZ3ec+YdjQ@mail.gmail.com>
	<252823d75e9221647e7f8ccef6105432aabe8d6f.camel@infradead.org>
	<20260401080657.70cd9bd1@phoenix.local>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18927-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,google.com,nvidia.com,kernel.org,lunn.ch,davemloft.net,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3320381F5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 1 Apr 2026 08:06:57 -0700 Stephen Hemminger wrote:
> On Wed, 01 Apr 2026 10:28:23 +0100
> David Woodhouse <dwmw2@infradead.org> wrote:
> 
> > > Some kernels are built without CONFIG_IPV6, so this warning would be
> > > quite misleading.    
> > 
> > Maybe on this date next year, we could make it not possible to build
> > the kernel *without* IPv6... ?  
> 
> There are some government agencies that used to require that IPV6 was disabled
> for security reasons. Yes they had broken old firewalls

Which is why we sadly have to keep the ipv6_mod_enabled()
sillilitude around. But that's a runtime thing.

