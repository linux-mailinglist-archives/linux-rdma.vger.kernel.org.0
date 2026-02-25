Return-Path: <linux-rdma+bounces-17148-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMbPHQXcnmkTXgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17148-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 12:24:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 238841966AA
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 12:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C4A63149991
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 11:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D4F393DEC;
	Wed, 25 Feb 2026 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXJOuJec"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B312A3939AE
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018468; cv=none; b=hf4tgbE+bb8gPRjgvQJrs0FSuIASn/fOwpK/oU9C4T/1KnDi7CikuTznx+YxHS8jKZugSpsdD3h1EWcWgajJXAMPEgM1Lz+ccO9sbX4Zgb3hxLALtMufEWDz6BO+6r7Npzb4eAmvmmviNLZ68ScjSABxSY7J5r9/U0SD3AddJ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018468; c=relaxed/simple;
	bh=94eou5dwcDYbC4JsEVVYRj5YGau7pBRIrx95NAHD+Zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LL49RZmThMl1XrFZ9EapulzPadPv9qCcLeNsskmQ6pmJaA+QDc4zMqFK0mAs9pmzNH4qZGXRRKpJqRiqFelbL2gfV4nBtfVB9z7Ms3Odrrb+XjBbMQocM/9doerM17qyHFYVH8Fz708JXqDWI7lYisDb6B1uPlQa4RHHkbGdJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXJOuJec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74311C2BCB2
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 11:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772018468;
	bh=94eou5dwcDYbC4JsEVVYRj5YGau7pBRIrx95NAHD+Zk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IXJOuJecyjqABMtQopgtEtDs9qv7MscforTU/eGRmhBCvGsW+EDoIYbs77pgjA7jZ
	 sSxlMyVZtBlvORg+YRsFnRR5tqIh3xKjY5IHLFq/Xh5weLnZI9o6fjbHan+7t5k79z
	 7VvTYtIQu3KOMqKnjaoE6DKpcSIsy6Hgun89ilZG/n/sxS7PU7+vAEqHQ+eFLS/LUD
	 FIN36bOAi+dDQ9YfDEsd0eshihgfS4L/33qaR3hjIzgsue4Ya0NlN0Bmi5cceFXtSy
	 uuGlbGFj7T8sJnVM02zRQk+UeOw95mTQzTQSeCsVxKOYDFL/g1Oti78SNCcuDZ+gMA
	 s5cQxRDqvi+Ig==
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506a7bbe9d0so52794081cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 03:21:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXEBAoJkyexY+0+97ZzbGjDAJERiTRyMjVua1Y0T/L+lcuQ+eIG6j4HDfC0cO3DImxdRac4GP1j5omi@vger.kernel.org
X-Gm-Message-State: AOJu0YzII8g73whLQ/lz6KFzat3R+Xvw6t+u5JFRhdUD5zxozEZUDJTp
	SQX9JZVy8snZ5czu69xv1UrVmjQE0vHS9pmdmXdo3g3LcYJWIAJsz/PtsiZXSWUwZJS6agMxqUp
	q7ex44d3Oba8JquIwFHEdXtMng5pQjOg=
X-Received: by 2002:a05:622a:180a:b0:4f0:24e2:8de6 with SMTP id
 d75a77b69052e-5070bcb8b63mr220590271cf.64.1772018467522; Wed, 25 Feb 2026
 03:21:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219130050.2390226-1-bjorn@kernel.org> <415c4922-cc8d-4e35-bbac-3a532f44d238@lunn.ch>
 <20260219160519.323041bf@kernel.org> <3b0949fa-0b05-4bce-86c0-2a7a058865a5@lunn.ch>
 <20260220131254.03874c4c@kernel.org> <CAJ+HfNgXqpqDYsmAa-mpHnO82aDgC7XbyVw3TmXk-ySFmGA-JQ@mail.gmail.com>
 <71848101-e97c-4674-ad07-aec720123d64@bootlin.com>
In-Reply-To: <71848101-e97c-4674-ad07-aec720123d64@bootlin.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Wed, 25 Feb 2026 12:20:55 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNi77f6aNbLHTkxVQfAh92+eXiZTzgLT7ezHVkOYtHnmKA@mail.gmail.com>
X-Gm-Features: AaiRm50PhSWPI5h6c3LcI9-yoWrsjAE377vDWpfd_YTYiOEo7L6NvYN8vZyV6zg
Message-ID: <CAJ+HfNi77f6aNbLHTkxVQfAh92+eXiZTzgLT7ezHVkOYtHnmKA@mail.gmail.com>
Subject: Re: [RFC net-next 0/4] ethtool: CMIS module diagnostic loopback support
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Michael Chan <michael.chan@broadcom.com>, 
	Hariprasad Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>, 
	Danielle Ratson <danieller@nvidia.com>, linux-kernel@vger.kernel.org, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,broadcom.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-17148-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 238841966AA
X-Rspamd-Action: no action

Maxime!

On Wed, 25 Feb 2026 at 11:22, Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:

> I'm very sorry not to have looked into this yet, I'm having some family
> events to handle right-now but I hope to be back next monday to take a
> close look at this :)

No rush, and thank you! Take care of your family -- the patches will
still be around when you're back!

Cheers,
Bj=C3=B6rn

