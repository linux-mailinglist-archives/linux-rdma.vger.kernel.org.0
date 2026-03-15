Return-Path: <linux-rdma+bounces-18168-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EzsMoDctmkQJwEAu9opvQ
	(envelope-from <linux-rdma+bounces-18168-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Mar 2026 17:21:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB095291629
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Mar 2026 17:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9CF933007AC8
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Mar 2026 16:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378FC372666;
	Sun, 15 Mar 2026 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcI2sQuJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AAA371CFE
	for <linux-rdma@vger.kernel.org>; Sun, 15 Mar 2026 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773591671; cv=none; b=aNuQlsi7iy+uIqgTgwTJlJUv9LAaykWz4/cIvp8Fvz0SF/d2LvvQ6P5SvgA3bOH1EF/zqOQnZ+Hly+tITwQzNCcEGklEOd/0RD6Oz90L7ZsTlGyiHk6A/FTJVRNFJ9P+32Oi3Awrxc+q+MQTnTpnxZKfINdrjyQSKnK3z8uJTNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773591671; c=relaxed/simple;
	bh=J9tpxWupWAX2Pt9UrNoCAOtAMFKzeL/kxywB4YHzQck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdLZ329tipO37EqDIgUpGhe3cryBlxV3iYNGxUjE/Y3YVvCMQB6kBIHDfZMNBPN8IXlkuQq7etb4Qz4uvo0BSXD7Dw7R1d7qcwZfLd+RxbzQyQ326vIuNBkD0T6kaF4bRrvkW7hU1qPmXAKyH8NMdKnhPTGvLu7CgTMcDDGnDDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcI2sQuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76CDC2BCB7
	for <linux-rdma@vger.kernel.org>; Sun, 15 Mar 2026 16:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773591670;
	bh=J9tpxWupWAX2Pt9UrNoCAOtAMFKzeL/kxywB4YHzQck=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TcI2sQuJ7WLaS13QUciw8Uxhj+hdgUQDlacsejXtr/bxKSWKCjzz7Ea3fFPRoUlay
	 N3WSo3PD6fkLu5crkikQWa/vMNHQrYaPWsAWw8T1ZC9nOkjWQLPnQ3pbYVrPsOv4Xj
	 PoqKzGcPA7NzcxwnifOT6RbAsV/JORzkjXMSZXOod/HURPcE6jzsEBtbHl9rGVIgEy
	 jg5QYWn/Z1N/lPB4RfrDkDnn888aZw5NAX/ABLOOxG/6TKc1Btz12o7Qvx7ks02z/1
	 kJpfyI/eb8qcMJWjKtOgcmpPFwZtlK0f3DKRR6x581H2elxt92/lKQ5k2JrmSKL4vT
	 RzTvQ6LOIEC/w==
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-899a9f445cbso53654676d6.0
        for <linux-rdma@vger.kernel.org>; Sun, 15 Mar 2026 09:21:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQPsamgMuHRMbbjT2YyBYy6KRdtQcbr8yNvWAD/hPfs/jnVOosv+miG1ob7Om9YUo0BShexKeoIRde@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1sleZAdMDfDnmfXDa36PJ8dVoPfG84+qj7QgYJzJPuVfjcZRk
	2ae7vNp3VVPMlLxUU2WgbS89Hb4dlQhlzsLl8P2NU8JGED6UuZkzyqrR8DHdtup3MnmWnysc8zM
	OO/tXirCseWfLQkdBEdBifXG8bkcIVjI=
X-Received: by 2002:ad4:458e:0:b0:89c:47a0:392d with SMTP id
 6a1803df08f44-89c47a03bc9mr28826996d6.44.1773591669600; Sun, 15 Mar 2026
 09:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310104743.907818-3-bjorn@kernel.org> <580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
 <b3825c0d-02e5-4625-831f-4346ce4eabd2@lunn.ch> <085bb0a9-85d3-4d62-9ac4-3461b61da5f3@bootlin.com>
 <438dae03-4dac-4e66-9f4d-e08b0434c9b4@lunn.ch> <20260311195052.1202174f@kernel.org>
 <abJJY8whzSOB8O-X@pengutronix.de> <7c45ebf6-0cb2-4a4c-ac12-f4f9bb59c908@lunn.ch>
 <42abf88e-4fbf-4966-9490-8315f118ddea@bootlin.com> <873423y27k.fsf@all.your.base.are.belong.to.us>
 <abbLu-OjngRjcc09@pengutronix.de>
In-Reply-To: <abbLu-OjngRjcc09@pengutronix.de>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Sun, 15 Mar 2026 17:20:58 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNhpvSZpsVjvjGU0PaoDR4-b1PLzcXXemqm6hDjanMcd3w@mail.gmail.com>
X-Gm-Features: AaiRm53Tq_eYzYSBfM-BMOsNrHN8Bd6s8DtX-VVRf7Uot0lHRK-mNGUtckgT_lU
Message-ID: <CAJ+HfNhpvSZpsVjvjGU0PaoDR4-b1PLzcXXemqm6hDjanMcd3w@mail.gmail.com>
Subject: Re: [PATCH net-next 02/11] ethtool: Add loopback netlink UAPI definitions
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Naveen Mamindlapalli <naveenm@marvell.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Danielle Ratson <danieller@nvidia.com>, Hariprasad Kelam <hkelam@marvell.com>, 
	Ido Schimmel <idosch@nvidia.com>, Kory Maincent <kory.maincent@bootlin.com>, 
	Leon Romanovsky <leon@kernel.org>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,lunn.ch,kernel.org,vger.kernel.org,davemloft.net,gmail.com,google.com,marvell.com,redhat.com,nvidia.com,broadcom.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-18168-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: CB095291629
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 15 Mar 2026 at 16:10, Oleksij Rempel <o.rempel@pengutronix.de> wrot=
e:
>
> Hi Bj=C3=B6rn,
>
> On Fri, Mar 13, 2026 at 08:11:11PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
> > Folks, thanks for the elaborate discussion (accidental complexity vs
> > essential complexity comes to mind...)!
>
> Sorry for overthinking :)

Haha, don't be! I think it's great that we have these discussions
upfront! If this is overthinking, please continue to do that! :-)

> > Maxime Chevallier <maxime.chevallier@bootlin.com> writes:
> >
> > > Hi Andrew,
> > >
> > >>> One more issue is the test data generator location. The data genera=
tor
> > >>> is not always the CPU. We have HW generators located in components =
like
> > >>> PHYs or we may use external source (remote loopback).
> > >>
> > >> At the moment, we don't have a Linux model for such generators. Ther=
e
> > >> is interest in them, but nobody has actually stepped up and proposed
> > >> anything. I do see there is an intersect, we need to be able to
> > >> represent them in the topology, and know which way they are pointing=
,
> > >> but i don't think they have a direct influence on loopback.
> > >
> > > If I'm following Oleksij, the idea would be to have on one side the
> > > ability to "dump" the link topology with a finer granularity so that =
we
> > > can see all the different blocks (pcs, pma, pmd, etc.), how they are
> > > chained together and who's driving them (MAC, PHY (+ phy_index), modu=
le,
> > > etc.), and on another side commands to configure loopback on them, wi=
th
> > > the ability to also configure traffic generators in the future, gathe=
r
> > > stats, etc.
> > >
> > > Another can of worms for sure, and probably too much for what Bj=C3=
=B6rn is
> > > trying to achieve. It's hard to say if this is overkill or not, there=
's
> > > interest in that for sure, but also quite a lot of work to do...
> >
> > It's great to have these discussion as input to the first (minimal!)
> > series, so we can extend/build on it later.
> >
> > If I try to make sense of the above discussions...
> >
> > Rough agreement on:
> >
> >  - Depth/ordering should be local to a component, not global across the
> >    whole path.
>
> ack
>
> >  - Cross-component ordering comes from existing infrastructure (PHY lin=
k
> >    topology, phy_index).
>
> ack
>
> >  - The current component set (MAC/PHY/MODULE) is reasonable for a first
> >    pass.
>
> I do not have strong opinion here.
>
> >  - HW traffic generators and full topology dumps are interesting but ou=
t
> >    of scope for now (Please? ;-)).
>
> It didn't tried to push it here. My point is - image me or may be you,
> will need to implement it in the next step. This components will need to
> cooperate and user will need to understand the relation and/or topology.
>
> The diagnostic is all about topology.

I hear you, and I hope this didn't come across as negative. I
definitely think we need something that we all can continue to build
on. ...and if my summary/view isn't, please holler!

> > So, maybe the next steps are:
> >
> >  1. Keep the current component model (MAC/PHY/MODULE) and the
> >     NEAR_END/FAR_END direction (naming need to change as Maxime said).
>
> Probably good to document that NEAR_END/FAR_END or local/remote is
> related to the viewpoint convention. Otherwise it will get confusing
> with components which mount in a unusual direction (embedded worlds is
> full of it :))

ACK!

> >  2. Add a depth (or order?) field to ETHTOOL_A_LOOPBACK_ENTRY as Jakub
> >     suggested, local to each component instance. This addresses the
> >     "multiple loopback points within one MAC" case without requiring a
> >     global ordering. I hope it addresses what Oleksij's switch example
> >     needs (multiple local loops at different depths within one
> >     component) *insert that screaming emoji*.
>
> ack. I guess "depth" fits to the "viewpoint" terminology.
>
> >  3. Document the viewpoint convention clearly.
>
> ack
>
> >  4. Punt on the grand topology dump. Too much to chew.
>
> ack
>
> >  5. Don't worry about DSA CPU ports - they don't have a netif, so
> >     loopback doesn't apply there today. If someone adds netifs for CPU
> >     ports later, depth handles it.
>
> ack
>
> > TL;DR: Add depth, document the viewpoint convention, and ship
> > it^W^Winterate.
> >
> > Did I get that right?
>
> I'm ok with it, but maintainers will have the last word.

Agreed!
Bj=C3=B6rn

