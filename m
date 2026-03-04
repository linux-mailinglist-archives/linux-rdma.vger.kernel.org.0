Return-Path: <linux-rdma+bounces-17478-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB7JLC9XqGlutQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17478-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:00:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB272038D1
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA25B30B6E30
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 15:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C2135B14B;
	Wed,  4 Mar 2026 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtwpgYt7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790334F255
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639584; cv=none; b=mNWZjuwQwm2DwGKI3JZ+w0bMdTKT8F+ZfRk6dEsNlSqL/xKSw6RTPPIW0n0FEab4S1kXgWBFsl/bYRBKESuRcBb4rXoQ2fy0TJFGFprMr4bcbPvUBrBwIIlAyO95rwgmQoWyhphouhiMVJjJioR3DzQ+Cc5LRPVuKXAgkyCrvrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639584; c=relaxed/simple;
	bh=334tEHtpzTsjNn4fKZ4gXzbtG7NKcj8PNnMMfG8RYA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgNmi5Aty/0oNM8uVkzEikAlwfbGBkU843Q73HRYPVqqqUHNLnWhOSQ/EzYBjyOlxSccKaUmMClShgQleSYB3gDDh9tgFAHjgdSVkq7PKInTbHqzsb5Wmkj3ZFxrLJoFS5K0Ro+DJa7u9lM3yRaDCDivIW7vKBc9ahA/0jqxFXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtwpgYt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC21C4CEF7
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772639584;
	bh=334tEHtpzTsjNn4fKZ4gXzbtG7NKcj8PNnMMfG8RYA8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WtwpgYt7kx6ZUNaahNpKGQENg27BHo6OMjPgZoVdoqcJkRF+VMljQD/Kho+IVCjry
	 FRTVd3DZ85qSbF0o0IbrfDl+/1yd93wbHxbsr2NXvRTHNC4OxeSd4KLizQss6S/HCL
	 aX0fObxujM5mbldJvHyKuqdFz+VO6ekNGBqHWSrbtxX3FLev9I/RAJtwBelCJZP3O7
	 fKaz7Ifui+wOqZRUPhvDxKVutTbAGUZLao99IgbiC1liap8bjjy9AAW4U6+/+hPkKb
	 nWFWrFNasx5XXDnCTfJlcWqzLC/6UR0p1XkTUmdOb+f92iKsgXEsINncZqkg/KMr3G
	 QJMdhr5p+FmPw==
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899e87b04d8so68606646d6.3
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 07:53:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOa/UJvo/51FM3bJly67EysmdkIY+Y8dU/kfDRjdMYThB6jinfu8lAtN0nT6APV3DmjrRFUywPTESD@vger.kernel.org
X-Gm-Message-State: AOJu0YzW3X8jmn3cZfGd6Bu0nOSO0msQ1zU+HalMo0DNOpvCNVQ3dg0g
	NU4zTxjGi/ffAsjJCX/Gqt4pCi/Cd/pR2zkTHd2XOTyHeV8p5lhKIgoQNPg64W0dB5pQZ6NhYcs
	tv7B2nuR58hotdgwle8MlZAgu+Ofe19Y=
X-Received: by 2002:a05:6214:4018:b0:89a:1536:2528 with SMTP id
 6a1803df08f44-89a19af13c1mr31908246d6.26.1772639583202; Wed, 04 Mar 2026
 07:53:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219130050.2390226-1-bjorn@kernel.org> <415c4922-cc8d-4e35-bbac-3a532f44d238@lunn.ch>
 <20260219160519.323041bf@kernel.org> <3b0949fa-0b05-4bce-86c0-2a7a058865a5@lunn.ch>
 <20260220131254.03874c4c@kernel.org> <CAJ+HfNgXqpqDYsmAa-mpHnO82aDgC7XbyVw3TmXk-ySFmGA-JQ@mail.gmail.com>
 <20260223150401.7993b11a@kernel.org> <CAJ+HfNjmRjr6VtRijmN9=4zPwxstw9B8D-_XVn3hwJzNHka1Jw@mail.gmail.com>
 <363527d6-1f29-4399-83a7-978785d1e11f@lunn.ch> <CAJ+HfNhwM82H-sgbz0+WJGRjXJc8Ww0aCnp_YTNi-CB4aBMi=w@mail.gmail.com>
 <4c51f18c-5eb1-4a9e-93b9-70cf7a4fd387@lunn.ch> <f2ce4c3b-407e-4c01-b117-c646feed877f@bootlin.com>
In-Reply-To: <f2ce4c3b-407e-4c01-b117-c646feed877f@bootlin.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Wed, 4 Mar 2026 16:52:51 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNga2510HrgpDH==H7CpmKBAEsoQkEmhFBMPxqM296p2eA@mail.gmail.com>
X-Gm-Features: AaiRm52PnREObziBwzeRIt2WgiHFaYqMJM-YPVE8rJunw0jQZna9BfkdQ_0a7iM
Message-ID: <CAJ+HfNga2510HrgpDH==H7CpmKBAEsoQkEmhFBMPxqM296p2eA@mail.gmail.com>
Subject: Re: [RFC net-next 0/4] ethtool: CMIS module diagnostic loopback support
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Michael Chan <michael.chan@broadcom.com>, 
	Hariprasad Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>, 
	Danielle Ratson <danieller@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5AB272038D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,broadcom.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-17478-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hey!

On Mon, 2 Mar 2026 at 10:01, Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:

> The overall approach after all these discussions sounds fine to me, I do
> think that the index of the component that does the loopback needs to be
> there somewhere, when relevant.
>
> Either through a name string, or a combo of an enum indicating the
> component type (MAC/PHY/Module/etc.) + its index. I think it's safe to
> assume that indices will fit in u32 ?
>
> something like :
>
> # MAC PCS loopback
> ethtool --set-loopback eth0 loc mac name pcs
>
> # PHY id 2 PMA loopback (I'm making things up here)
> ethtool --set-loopback eth0 loc phy id 2 name pma
>
> That way we can extend that fairly easily for, say, combo-port devices
> where we could select which of the port we want to loopback :)

Ok! I'll spin a new version with this in mind. To improve my mental
model, could you give an example how you would use a combo-port from a
userland perspective?


Cheers,
Bj=C3=B6rn

