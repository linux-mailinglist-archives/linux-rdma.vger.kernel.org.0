Return-Path: <linux-rdma+bounces-18954-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NScBKvRzmmUqQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18954-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 22:29:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B41A338DF99
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 22:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 213FB3085EF5
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 20:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55BD38E12D;
	Thu,  2 Apr 2026 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQ1JVW3k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E62DEA95;
	Thu,  2 Apr 2026 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161665; cv=none; b=pntrjYWW/Hgpk+ZLKtSyPAijfjrWeuKmm18sPh++jBriUXCbW7iXOZq1VbvtsCh0cZDxyenFoLpSGBq2NabmNu9JyvMxexMa2meip6MPjIOG9OOWPGIsm44yZuxQ2Xx06a5cE0DzDahGa7OTLGKdaXjP3OipoVLhI1gRk31Nfj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161665; c=relaxed/simple;
	bh=R2bUXwoiNKI+i8fhmS1mEypi+5XEE/H8JRhMIiJEbro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPMurbJnx3AJzFrZTM9QOy07KG6Vux3i5kC+oqwsIzFUJPQyBwG5M3lvPm5bhgKE1vKOJlpX9UDVV6vO1UOq0m7ryFciUDP7Ogb76+6vjh9VPYEGAw5biaVE31XLfg+rrrUlro4vrK24Qx+K2gqzQVvonwKequAhP/Str6SLiss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQ1JVW3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DD2C116C6;
	Thu,  2 Apr 2026 20:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775161664;
	bh=R2bUXwoiNKI+i8fhmS1mEypi+5XEE/H8JRhMIiJEbro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cQ1JVW3kZ4q6yf/mrMXMcUmXb/SpqVqWgSGhAro2e6sakjWIO86wX+hLGyma+i3sQ
	 zaRhaZLvr17NAdzRwaGEP+PSyz4ljYkGQtNf5OQXtI75Z+nyaA/H8bQkkSlwA2wlrV
	 Wo8PesnE5LHxozZUlED43qosmVFTZmfwEAOSp8TEuCJh5J7ZAJ7Mnz+TsM6P45WLGT
	 M+0j4JWhhRwjW7dRoK6F5CzU7AigiKguXJGZKt3EjrzHWe+rT3ipjNOhBesz9AYRxb
	 H7HyqrsSyhHtW6dKYVG0oNwbTqHNRPuTCJsBK+BKS1oYCezp0qiFYW9uC5yN1he7Sp
	 0K5mLfjwRIQFg==
Date: Thu, 2 Apr 2026 22:27:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
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
 coreteam@netfilter.org, torvalds@linux-foundation.org,
 jon.maddog.hall@gmail.com
Subject: Re: [PATCH 0/6] Deprecate Legacy IP
Message-ID: <20260402222558.6fe9bc0d@foz.lan>
In-Reply-To: <2cb91533e22ed6cb11205dbc56b8aeedbbce0cca.camel@infradead.org>
References: <20260401074509.1897527-1-dwmw2@infradead.org>
	<42caa438-3854-449c-b0ee-4f40772e5c1b@suse.de>
	<2cb91533e22ed6cb11205dbc56b8aeedbbce0cca.camel@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.de,nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-18954-lists,linux-rdma=lfdr.de,huawei];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B41A338DF99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 01 Apr 2026 09:25:08 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> On Wed, 2026-04-01 at 10:07 +0200, Fernando Fernandez Mancera wrote:
> > =C2=A0
> >=20
> > Dammit, you've beaten me to it! This was my next step for 7.2.
> >=20
> > Fully-endorsed-by: Fernando Fernandez Mancera <fmancera@suse.de> =20
>=20
> Yeah. The date notwithstanding,=20

You tricked me on this April fools day...

Very funny!

> I do actually think we should do most
> of this for real.
>=20
> Maybe we don't get away with the actual deprecation and the warnings on
> use *just* yet, and *maybe* we won't even get away with calling the
> config option CONFIG_LEGACY_IP, although I would genuinely like to see
> us moving consistently towards saying "Legacy IP" instead of "IPv4"
> everywhere.

IPv4 is not legacy yet... Lots of configurations, service providers
and corporations that requires the usage of VPN are IPv4 only still
today. For instance, my paid VPN provider only grants IPv4 addresses
(at least for those not using their proprietary software).

>=20
> But we *should* clean up the separation of CONFIG_INET and
> CONFIG_IPV[64] and make it possible to build with either protocol
> alone.

That makes sense on my eyes.

Thanks,
Mauro

