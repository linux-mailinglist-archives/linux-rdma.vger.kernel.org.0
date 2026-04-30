Return-Path: <linux-rdma+bounces-19767-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NjxOSG48mnltgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19767-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 04:02:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D9E49C2E8
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 04:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 117C2301DC1A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 02:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4268A285072;
	Thu, 30 Apr 2026 02:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mlkw7phV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DE1270545;
	Thu, 30 Apr 2026 02:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777514512; cv=none; b=A+eWDa7sBw/jnA7PY2Cih+HdPRjAzuaVigrLkLbsGA1XLNmmkmdr7aqNvnz3vx8AuyVmDAK4vaUDo5wHZ/QQZCz/LpHG02ZAae3V7TFr9N9ru8+OW73Bn2ArjZW1VuGujzeUbkmMPDLChVBDNEg0F0z03ws0fheUZwkJFduaQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777514512; c=relaxed/simple;
	bh=YX2d4wcuN1GU1u0POqjHNgHYHZGTaml01xeVLvOYBms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1u+QxQg8CQ76FQqWZhyN/tJxULfe9PUtD8KigCB+SRa93Lptk4biMAg+I28Xyj/KbnQkOeO3kSZqV6u6ZiNXymSVoYLBKs28SrVdTbbPYeIYp/Iws2Zaj7FQXdMVok2HO98LJv284EpizwqTG+mKXBIhC99/h2/Kz8lfOjV51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mlkw7phV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9A4C19425;
	Thu, 30 Apr 2026 02:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777514511;
	bh=YX2d4wcuN1GU1u0POqjHNgHYHZGTaml01xeVLvOYBms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mlkw7phVtuwbS2L0giugbl0rR5f3TxbREQbL5P8f4ivpCEoTV0UeOfIpLzGqR2kZC
	 RAjFN9kzXsapHJ9CjY48iWp4xeVTR7Id0vWq3CJz2OO3Hf7Xghi0W5YaCo06o4zEmC
	 mjde64FpEsqd/HrY/NSog+sNpz0Yun0j8YvXa7YqgKVP2Jwd/WMQ4Mcxz5M29UpU7x
	 04qPkeLURvkZF6tQ+nPM/K59OjIGMHvGoOKNpMfLxTNwL7WHw7Cwz8B6Vdc7Refwg0
	 RzlGf0n1xirYskv4dfyhX6VX6+QAmWhuqiMpsSEC+Y8G/EqaNS00KHLOtgl8A0Zg8A
	 +o2ywYX6ekspA==
Date: Wed, 29 Apr 2026 19:01:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Harvey <marcharvey@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net-next] net/mlx5: Add MLX5_VXLAN config option
Message-ID: <20260429190150.417b0302@kernel.org>
In-Reply-To: <CANkEMgkBnuRfurKcFEUAZcJcX1XYSnHbBozZGP8DpnKq--tWbw@mail.gmail.com>
References: <20260428-mlx5_vxlan-v1-1-cf666d042618@google.com>
	<20260428184631.40f1f1b7@kernel.org>
	<CANkEMgkBnuRfurKcFEUAZcJcX1XYSnHbBozZGP8DpnKq--tWbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 90D9E49C2E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19767-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Wed, 29 Apr 2026 17:46:36 -0700 Marc Harvey wrote:
> On Tue, Apr 28, 2026 at 6:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue, 28 Apr 2026 22:44:34 +0000 Marc Harvey wrote: =20
> > > Currently, there is no way to disable mlx5 vxlan offloading if vxlan
> > > is enabled. We've (possibly) seen some minor udp rr and udp stream
> > > regressions when enabling vxlan, and want a way to disable this
> > > offloading. Also coupling vxlan offloading with vxlan enablement
> > > generally limits the flexability of vxlan setups.
> > >
> > > Add a new config option for mlx5 vxlan offloading specifically, so
> > > that users can use vxlan without automatically opting in to the
> > > offloading.
> > >
> > > To keep the same behavior as before, the new config option is enabled
> > > by default if vxlan is enabled. =20
> >
> > Can we delay init of whatever makes the device slow down until the
> > first vxlan port is registered? A kconfig level optimization of this
> > sort will have rather limited applicability. =20
>=20
> There would still be the problem of wanting to use vxlan without vxlan
> offload. Agree that a kconfig might not be ideal, but it is currently
> guarded by a kconfig that offers no choice to opt out.

Are you aware of NETIF_F_RX_UDP_TUNNEL_PORT ?
I haven't checked it does exactly what we need, but I recall there was=20
a ethtool feature for this..

