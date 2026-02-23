Return-Path: <linux-rdma+bounces-17059-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJy0MY5nnGmsFwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17059-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 15:43:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B62178301
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 15:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1AC9305561B
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 14:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25932346AF0;
	Mon, 23 Feb 2026 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3JdwXrB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE8A2853E9
	for <linux-rdma@vger.kernel.org>; Mon, 23 Feb 2026 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857679; cv=none; b=fnF3Ci3QtUASwdu10YMupWzHwCZOkzANAxZ6VM6NJGgX9SYVenNxBfCW5Gt6YXnIFKQbEi06ywtAw9YUJQiQjsigWfzDMf1OVdonzgslEp/y9EsLtd/kCGGF0gW3O0yjRxX5LbR/FHuonQTkaVwqtS/AbEaYGsPdwBSvBeOl3Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857679; c=relaxed/simple;
	bh=KzXTOKG5ACoTpsXhTjn3lMl935inBBInfsItxqDcShE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHGEXBjRLjJNUZvkW7FjwrpkIvldwgAL3yp1uclmfK8DDW5yhsDDX7Xs8izn1O9l7a+TS8HYb1VihUKmUvv9m1iMJmU1Q90PtOKXYl0ertMVum0sOjfO9EFhGUKy60ibjVk9Clr0IA3eb6rR0FPW/PxOOsg9IBb/WD3wMOO6JkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3JdwXrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BCCC2BCB3
	for <linux-rdma@vger.kernel.org>; Mon, 23 Feb 2026 14:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771857679;
	bh=KzXTOKG5ACoTpsXhTjn3lMl935inBBInfsItxqDcShE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l3JdwXrBCQ9jKZFKuXyVshHVEOEQ5QiSZXmOGtkdk4ZmRk833si6B4NvcPemEK0k/
	 TebypsCwq3y/ymVc04gFIcYCVB1QNNNXV93KSvl8GrqLe9bUrekOK8b9TQwwFd0vCu
	 sdw0w9uqXbLiF018nzvvhfFSDH6j30P6m6Ky+IXSxpeZQaHW4coSbSpdLET+BkOBC/
	 92TAd/Yi4onVWoqGiRWbjlcL5R8EJH/FizZVauWiNVpgo8ejftLv64CEYf0OOhtBJ1
	 Zgw0azaqHdRfpvIqoR1UmjEfo0SuhLhcbKQTJgRYURazoYdCslT2kTQjRzMhdnD2ZR
	 NYXHH/7nLTIvg==
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb20bcff5aso452860185a.3
        for <linux-rdma@vger.kernel.org>; Mon, 23 Feb 2026 06:41:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpO/PIG/aberSOiCdZWVdmkRwZkyv59CLBlYABaar69jbzf6cH9HZKs6y704hwc7BNWShNT397O3fK@vger.kernel.org
X-Gm-Message-State: AOJu0YzEZFa7Ic/VXcV8obCxZL0sB9y0+hGGvve6eg3bVmjrADKfkI9p
	Rd4SADruVM5i+Ef5CKmI3BckC/thlYHLKGPhNxrsuc11l7P8/LDpqzV2SWJ950Oq3BnDjItWsT9
	OmseI7GdnSOJAoO09ZQ5zGjQ0mGESFSk=
X-Received: by 2002:ac8:7d45:0:b0:505:ec73:822f with SMTP id
 d75a77b69052e-5070bcc1f88mr113885681cf.70.1771857678619; Mon, 23 Feb 2026
 06:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219130050.2390226-1-bjorn@kernel.org> <415c4922-cc8d-4e35-bbac-3a532f44d238@lunn.ch>
 <20260219160519.323041bf@kernel.org> <3b0949fa-0b05-4bce-86c0-2a7a058865a5@lunn.ch>
 <20260220131254.03874c4c@kernel.org> <CAJ+HfNgXqpqDYsmAa-mpHnO82aDgC7XbyVw3TmXk-ySFmGA-JQ@mail.gmail.com>
 <74ff32e0-f883-40d4-be89-3276dc26cf0d@lunn.ch>
In-Reply-To: <74ff32e0-f883-40d4-be89-3276dc26cf0d@lunn.ch>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Mon, 23 Feb 2026 15:41:07 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNisjk-QjXn8Yget6o2Yk9c6JFgQtvw7YQ7ESDyvk=fnsA@mail.gmail.com>
X-Gm-Features: AaiRm529dl4cAV_MW-c9Bqsm6rrWpJ1MRX0EqaZRkAgPxDRZY5wvZRhI3gHImDM
Message-ID: <CAJ+HfNisjk-QjXn8Yget6o2Yk9c6JFgQtvw7YQ7ESDyvk=fnsA@mail.gmail.com>
Subject: Re: [RFC net-next 0/4] ethtool: CMIS module diagnostic loopback support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Michael Chan <michael.chan@broadcom.com>, Hariprasad Kelam <hkelam@marvell.com>, 
	Ido Schimmel <idosch@nvidia.com>, Danielle Ratson <danieller@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,bootlin.com,broadcom.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-17059-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lunn.ch:email]
X-Rspamd-Queue-Id: 35B62178301
X-Rspamd-Action: no action

Hey!

On Mon, 23 Feb 2026 at 15:30, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > /* Loopback Direction (XXX is local/remote easier to understand?) */
> > enum ethtool_loopback_dir {
> >     ETHTOOL_LB_DIR_NEAR_END =3D 0,    /* Host -> Loop -> Host  */
> >     ETHTOOL_LB_DIR_FAR_END,        /* Line -> Loop -> Line  */
> > };
>
> I like host->loop->host, it is much clearer than NEAR_END or
> FAR_END. Where there is space, would use this description, even if it
> is a bit verbose.

Ok!

> > struct ethtool_loopback_layer_cfg {
> >     enum ethtool_loopback_layer layer;    /* ETHTOOL_LB_L_MAC, etc. */
> >     enum ethtool_loopback_dir direction;  /* NEAR or FAR */
> >     u32 lane_mask;                        /* Specific lanes */
> >     u32  flags;                           /* patterns? reserved... */
> >     bool enabled;
> >     char name[16];
>
> What would name be used for. I don't see it in your example. The nice
> thing about netlink messages is that they are extendable, unlike
> system calls. If there is no current use for a field, don't add it. It
> can be added later when actually needed. So i would drop flags and
> name.

Yeah, good call (I dropped flags on my local hack), name *and*
lane_mask. More on that below.

> Does CMIS, when used with a splitter cable, allow you to set loopback
> on lanes? What is your use case for lane_mask?

At least the spec exposed that it could be supported. Thinking more
about it, I think it can be added later if someone cares about it.
IOW, flags, name, and lane_mask shouldn't be part of the initial
patches.

> > };
> >
> > struct ethtool_loopback_cfg {
> >     struct ethtool_loopback_layer_cfg *entries;
> >     u32 num_layers;
>
> What is num_layers used for?

I'll change the _cfg to have a proper array instead. The idea is that
_cfg is a set of layers (MAC, PMA, etc.). The num_layers is the number
of entries. I'll make sure this is more obvious.

...

> > # ethtool --show-loopback eth0
> > Loopback Status for eth0:
> >   Layer: SW  | State: OFF
> >   Layer: MAC   | State: OFF
> >   Layer: PMA   | State: ON  | Lanes: 0x1 (Lane 0) | Direction: Near-End=
 (Local)
> >   Layer: PMD   | State: ON  | Lanes: 0xF (All)    | Direction: Far-End =
(Remote)
>
> ETHTOOL_LINK_MODE_800000baseKR8_Full_BIT has 8 lanes, so 0xff would be
> All in this case. Lanes adds quite a bit of complexity. Do we have a
> real use case for it?

I don't. As outlined above -- let's leave it out for now. If somebody
needs it in the future, we can have the discussion then.

> >   Layer: EXT   | State: ON  | Detected: External Loopback Plug
> >
> > # ethtool --set-loopback <dev> [layer[:lanes][:direction]] ... [off]
> >
> > # # Simple MAC loopback:
> > # ethtool --set-loopback eth0 mac (Defaults: lanes=3Dall, dir=3Dnear)
> > # # Specific SerDes (PMA) lane:
> > # ethtool --set-loopback eth0 pma:lane0
> > # # Complex multi-layer (PMA Near + PMD Far):
> > # ethtool --set-loopback eth0 pma:0x1:near pmd:all:far
>
> Is this something we actually want? Again it adds complexity,
> especially in the error handling, when pma:0x1:near works, but
> pmd:all:far fails, and you need to unwind the pma:0x1:near. Is there a
> use case for atomically setting two loopbacks, rather than having the
> user make two different calls?

Good point! Simpler is better.

> > # # Disable all loopbacks:
> > ethtool --set-loopback eth0 off
> >
> > Thoughts? Is this somewhat close to what you had in mind, Andrew?
>
> I'm happy with the basic shape of this. I just needs the details
> nailing down.

Ok! I'll roll something we can discuss more. Thanks for all input!


Bj=C3=B6rn

