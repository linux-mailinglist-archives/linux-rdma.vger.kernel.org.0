Return-Path: <linux-rdma+bounces-19062-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG2xJtf702k8owcAu9opvQ
	(envelope-from <linux-rdma+bounces-19062-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 20:30:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E24B3A6412
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 20:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DE1A301F4BB
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 18:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715A438C2D0;
	Mon,  6 Apr 2026 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRo4eiad"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3361A2D4816;
	Mon,  6 Apr 2026 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775500241; cv=none; b=hoCjimtwMqrfkTWhpvMJEMfVyagXE1MRXZvdpn8dcc3Le33MZ5Xaq/XSAn0Puq7EpDzu56FVmLJlfLCORqc/D2tfs3tNvw9TeDibyx8/XdxQckWz3qtpPHL5aRDYjai3jeJDCGj3MId3O3x2OEiDx/6aY1WBoLFvYh3w/iuarVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775500241; c=relaxed/simple;
	bh=X3LmDlOL7oHsiksL0XYneAIo6ey0U0WWWnsaiFK0W0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEuJRHjnJrsn+bwoY0/DKpgbzqUsWW/l+pI1lmpc8hdtJTtvbF6C/QbZ2LoA+pofKka9bIe8OjHzq0rRlxf4yw0uA6BcOJuYgiR6eWUvWfD/w1k9cth1y7HhpuuBe1KBDkqsXg6X8AC8bqH0oO/3xbC0b7TzP5RuZtd4amppUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRo4eiad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA58C19421;
	Mon,  6 Apr 2026 18:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775500240;
	bh=X3LmDlOL7oHsiksL0XYneAIo6ey0U0WWWnsaiFK0W0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WRo4eiadFuh+rmR1IwitFB11BMn6R4ph56sofV3YJ+i1JSiMo+hxXRNDvGvebn8vr
	 nHslEjnLnZT1NIBACMpsYxVkNQXdN3I5Vx9W7AjXSNjb1635T1tlTfk7jvHDPvVAwc
	 3XQZMI2036P3CuyWtVoVT1ZBZwoPce5pjzu7oV9HJ4hcakpDsMHLB2SyJ23o/hBzPp
	 S9VyfnPpQHp9bQn/VH3LZY+S96MevoRDC6uof8k4PCwgi6rL31S7fPMPV5T9R0x6rn
	 UQ74416t8l0IHVyIAWnywnPPnO1C2wYt8xxK3NcI5Y5fskCDAeJmQEanTA7YQ9coBK
	 btc8zLu/1+S9w==
Date: Mon, 6 Apr 2026 11:30:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Cosmin Ratiu <cratiu@nvidia.com>, Simon Horman <horms@kernel.org>, Jacob
 Keller <jacob.e.keller@intel.com>, Lama Kayal <lkayal@nvidia.com>, Michal
 Swiatkowski <michal.swiatkowski@linux.intel.com>, Carolina Jubran
 <cjubran@nvidia.com>, Nathan Chancellor <nathan@kernel.org>, Daniel Zahka
 <daniel.zahka@gmail.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, Raed
 Salem <raeds@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net-next V2 4/5] net/mlx5e: XDP, Use a single linear
 page per rq
Message-ID: <20260406113038.212d91c0@kernel.org>
In-Reply-To: <e0ac9755-fd49-4620-92ce-0f5e4203a95e@nvidia.com>
References: <20260403090927.139042-1-tariqt@nvidia.com>
	<20260403090927.139042-5-tariqt@nvidia.com>
	<adH5yAsPJ8rNgT0k@x13>
	<20260406084344.5d315f01@kernel.org>
	<e0ac9755-fd49-4620-92ce-0f5e4203a95e@nvidia.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19062-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,kernel.org,iogearbox.net,gmail.com,fomichev.me,intel.com,linux.intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E24B3A6412
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 6 Apr 2026 19:31:03 +0300 Mark Bloch wrote:
> On 06/04/2026 18:43, Jakub Kicinski wrote:
> > On Sun, 5 Apr 2026 08:08:06 +0200 Dragos Tatulea wrote: =20
> >> sashiko says: =20
> >=20
> > Thanks a lot for reviewing the review! It takes a lot of maintainer tim=
e =20
>=20
> Just to add some context: we started running Sashiko internally,
> so hopefully trivial issues won=E2=80=99t be missed. I don=E2=80=99t know=
 if
> you remember our on-list discussion from a few weeks ago, following that
> discussion right now we have three different internal AI tools reviewing =
each
> commit.
>=20
> At the moment this is still manageable, and I think developers should
> look over all comments from all tools. In our case that currently
> means three review outputs per commit. It would also be useful to have
> some official guidance on what authors are recommended to run before
> posting, so obvious issues can be caught earlier and less reviewer/mainta=
iner
> time is spent on them.
>=20
> For example:
>=20
> =E2=80=9CBefore posting, authors could run a recommended baseline of revi=
ew tools,
> where available, to catch obvious issues early. During review, tools such
> as review-prompts and Sashiko may be used to assist the reviewer.=E2=80=9D

Please send patches if you think something should be mentioned
somewhere. It'd be awesome if y'all participated more in upstream
reviews so that you recommendation could be rooted in what happens
on the list not just what happens within nVidia.

