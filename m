Return-Path: <linux-rdma+bounces-19981-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCARLBlG+Wki7gIAu9opvQ
	(envelope-from <linux-rdma+bounces-19981-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 03:21:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 513C74C5B93
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 03:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2F493014960
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 01:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D6A31E840;
	Tue,  5 May 2026 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHSaAKe3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F430FC26;
	Tue,  5 May 2026 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777944084; cv=none; b=QTR70IVPGF8syBT+vEgyzZLaSsH2b+o1hYtDyrATxHY4DRUfnkLbZjoXdqBe1FOXex7QtAq0ZYaBPyydZF3NHwU5ZvpP9DIWRa/8N1vnH8ij0DIAX+1pY5wRc3+ePnhsxkwPxXik/1IeQnu/aUDJ3T8f20R31rbbEVYYaYSf2ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777944084; c=relaxed/simple;
	bh=WFjVRf1GxXlnia9YSNKUChMaNSiPGz8MkXkFb/g359A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVh9J8PhHdv0eIWQn28nq9aQ0jKxAvoPr3OxCplQ+D4gcEGmWS0Ed2TRsrt3iOhjJqVvtowpHbq0BuVMxcyRJO68Szdbxbc+0UhWl6DWQKZ6O8zKmOfdEguZZJUv0Qj0NMdqEdNHeYVJBtBRxD3phf1TusI1GOfQcUnAA/yQelc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHSaAKe3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F9FC2BCB8;
	Tue,  5 May 2026 01:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777944084;
	bh=WFjVRf1GxXlnia9YSNKUChMaNSiPGz8MkXkFb/g359A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HHSaAKe3Lvevpp9ukIS8pu43GTcOlDXPBXk4kZAfqJ5uPLx9cGKcudfMCfdXt9dOu
	 bQLgjOTAne3LS+CNOKX2keDrtCJfxZE8AjxP7OMHRXMiKlYM/P4zqkAoEyLZtJ9spa
	 ByYrhpigZlvF+tZ+qr02Xyv7M2X2tvqByAdp4ATplY5Hbnhrf3BzQy8U8cwHgyBd8g
	 tebi87vk+hL1ZqqD5yM1KIFZ/QJw0+xb+G6KloZdtBIeuurghRY5WyqA/nGjamkP2i
	 lmtspc8HFGWk+s9ytolI5fS+Nr4ujKFU3ocQPHWOwzYYoEcFJCwFzGbwbAIiFaeZ8n
	 qC0EXobeSG4wg==
Date: Mon, 4 May 2026 18:21:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>, Shay
 Drory <shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
 <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
 <horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Moshe Shemesh
 <moshe@nvidia.com>, Kees Cook <kees@kernel.org>, Patrisious Haddad
 <phaddad@nvidia.com>, Parav Pandit <parav@nvidia.com>, Carolina Jubran
 <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 7/7] net/mlx5: Add profile to auto-enable
 switchdev mode at device init
Message-ID: <20260504182122.08efb41e@kernel.org>
In-Reply-To: <cc01cca2-0e5d-4db2-81e4-7ea9fe525320@nvidia.com>
References: <20260501041633.231662-1-tariqt@nvidia.com>
	<20260501041633.231662-8-tariqt@nvidia.com>
	<421e8885-5849-4390-8956-9bc344fa0bf0@nvidia.com>
	<20260502184153.4fd8d06f@kernel.org>
	<cc01cca2-0e5d-4db2-81e4-7ea9fe525320@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 513C74C5B93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19981-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[26];
	TO_DN_SOME(0.00)[]

On Sun, 3 May 2026 10:51:06 +0300 Mark Bloch wrote:
> On 03/05/2026 4:41, Jakub Kicinski wrote:
> > On Sat, 2 May 2026 23:08:43 +0300 Mark Bloch wrote: =20
> >> Before I respin for the unrelated MR_CACHE cleanup, I=E2=80=99d like t=
o confirm
> >> whether the opt-in profile approach is acceptable at all. Regardless
> >> of this last patch, the first 6 patches fix real representor/LAG locki=
ng
> >> issues and are needed independently, so I=E2=80=99d like to keep those=
 moving toward
> >> acceptance as soon as possible. =20
> >=20
> > For probe-time config module param is probably our only option.
> > I'd obviously prefer to have a devlink-level knob for this, instead=20
> > of a mlx5 specific one. Can we come up with some format that'd apply
> > more broadly? devlink=3D[$bfd:]flag1 ? so devlink=3D[$bdf:]switchdev-mo=
de ? =20
>=20
> I=E2=80=99m not convinced this is really a generic devlink knob problem.

I'm surprised you say that. Anyone using switchdev mode could benefit.
Having the probe in one mode and switch adds to boot time. Whether it's
a DPU or not is quite secondary.

Unless there's another deeper reason which makes the DPU incapable of
running in the non-switchdev mode. But not sure that squares with the
code you posted AFAICT.

> A device should probe in its selected/default configuration. For DPU
> deployments switchdev is the expected operating mode. mlx5 just made the
> wrong default choice historically, and this profile is a way to move away
> from that without forcing it on everyone at once. I expect/hope to move
> quickly from this flag to simply making switchdev the driver default for
> all DPU configs.
>=20
> A generic cmdline format also gets complicated quickly: vendor-specific
> flags, ordering/dependencies between flags, hotplug timing, and whether a
> BDF rule should apply when a device is passed into a VM after boot.
> Userspace scripts are probably better for that kind of policy because
> they can carry real site specific logic.
>=20
> I=E2=80=99ll drop this last patch from the series for now so the represen=
tor/LAG
> locking fixes can move independently and we can continue the default
> switchdev discussion separately. I can always submit that as a standalone
> patch later in the cycle if needed.

SG

