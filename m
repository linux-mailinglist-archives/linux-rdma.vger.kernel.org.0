Return-Path: <linux-rdma+bounces-18152-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCcxH3phtGmhmwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18152-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 20:11:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1563289283
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 20:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D403831D4C4E
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 19:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8511A3DA7F6;
	Fri, 13 Mar 2026 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvXBlKTh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456563AB280;
	Fri, 13 Mar 2026 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773429075; cv=none; b=GX5/1MthfVJ5d7DIBHNc3drAVR1MKEjRq50jmtaqxKBjEsX+OtfR8s2JYTG5fIVKyFVzc8dHzi90wJYhot/f5TW+M4wy2lc5L0AOSVx1RNG/4ZPPl8TnDWHURLKF/ZHuiMIwpV7Tk8kZuAqD4cMkcfRop87rC5vIeTbyZeeDVxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773429075; c=relaxed/simple;
	bh=doYwiQkJo973h+xP370H4wFzfMyN2oKUIPL/Gy0lfC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sLWOk1YuYgexahQozWD7T4Rh0YL7I9ev0nzMnYJK+kliPHvuiaDcz18+cBFEzEVG4qpDkuMu83a/kAVCNatTQe8aNowH80cbgC8lQQ58W+5DOA+Ody00dBxOx1MKBxJI7A/7AONWZ6sik4+oRWBsjhCXKdxVd16z/vwZ7Xg6vMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvXBlKTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369EFC19421;
	Fri, 13 Mar 2026 19:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773429074;
	bh=doYwiQkJo973h+xP370H4wFzfMyN2oKUIPL/Gy0lfC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kvXBlKThy2c6q4ru8fzGHaRg0j7zHgAOkMQPYjm1U4YXbfPJOqnLYDzOQnrEuSrHz
	 SFAiLguTQLD+i+0TD7r7J0WXDJOFNP6IaKJLw0fnZUjJy1Q5hg2Qb9skgONKkcN13L
	 nXoYvu0y6KbM/NRKymswZ6aFbrofpzzfU6kJwO5BFlw0n96fVx98cXrjumVNJ1OlwT
	 47Ffn5vqxsQ3/yLDt3zFleJvpjUAV2jcD/RVWI9XbnqJPwotK86ayt/FRwpIX/CDRu
	 mq2cmqCGv9Z4+gP6C00mtdCkYm1eBvQvh0skziQ0U5maXO3S4coyZH64kytubmRR3b
	 0+ARNXoVlihcA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Donald
 Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Naveen Mamindlapalli <naveenm@marvell.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Danielle Ratson
 <danieller@nvidia.com>, Hariprasad Kelam <hkelam@marvell.com>, Ido
 Schimmel <idosch@nvidia.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Leon Romanovsky <leon@kernel.org>, Michael Chan
 <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan
 <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Willem de Bruijn
 <willemb@google.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 02/11] ethtool: Add loopback netlink UAPI
 definitions
In-Reply-To: <42abf88e-4fbf-4966-9490-8315f118ddea@bootlin.com>
References: <20260310104743.907818-1-bjorn@kernel.org>
 <20260310104743.907818-3-bjorn@kernel.org>
 <580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
 <b3825c0d-02e5-4625-831f-4346ce4eabd2@lunn.ch>
 <085bb0a9-85d3-4d62-9ac4-3461b61da5f3@bootlin.com>
 <438dae03-4dac-4e66-9f4d-e08b0434c9b4@lunn.ch>
 <20260311195052.1202174f@kernel.org> <abJJY8whzSOB8O-X@pengutronix.de>
 <7c45ebf6-0cb2-4a4c-ac12-f4f9bb59c908@lunn.ch>
 <42abf88e-4fbf-4966-9490-8315f118ddea@bootlin.com>
Date: Fri, 13 Mar 2026 20:11:11 +0100
Message-ID: <873423y27k.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18152-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,marvell.com,redhat.com,nvidia.com,bootlin.com,broadcom.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[all.your.base.are.belong.to.us:mid,bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1563289283
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Folks, thanks for the elaborate discussion (accidental complexity vs
essential complexity comes to mind...)!

Maxime Chevallier <maxime.chevallier@bootlin.com> writes:

> Hi Andrew,
>
>>> One more issue is the test data generator location. The data generator
>>> is not always the CPU. We have HW generators located in components like
>>> PHYs or we may use external source (remote loopback).
>>=20
>> At the moment, we don't have a Linux model for such generators. There
>> is interest in them, but nobody has actually stepped up and proposed
>> anything. I do see there is an intersect, we need to be able to
>> represent them in the topology, and know which way they are pointing,
>> but i don't think they have a direct influence on loopback.
>
> If I'm following Oleksij, the idea would be to have on one side the
> ability to "dump" the link topology with a finer granularity so that we
> can see all the different blocks (pcs, pma, pmd, etc.), how they are
> chained together and who's driving them (MAC, PHY (+ phy_index), module,
> etc.), and on another side commands to configure loopback on them, with
> the ability to also configure traffic generators in the future, gather
> stats, etc.
>
> Another can of worms for sure, and probably too much for what Bj=C3=B6rn =
is
> trying to achieve. It's hard to say if this is overkill or not, there's
> interest in that for sure, but also quite a lot of work to do...

It's great to have these discussion as input to the first (minimal!)
series, so we can extend/build on it later.

If I try to make sense of the above discussions...

Rough agreement on:

 - Depth/ordering should be local to a component, not global across the
   whole path.
 - Cross-component ordering comes from existing infrastructure (PHY link
   topology, phy_index).
 - The current component set (MAC/PHY/MODULE) is reasonable for a first
   pass.
 - HW traffic generators and full topology dumps are interesting but out
   of scope for now (Please? ;-)).


So, maybe the next steps are:

 1. Keep the current component model (MAC/PHY/MODULE) and the
    NEAR_END/FAR_END direction (naming need to change as Maxime said).
=20
 2. Add a depth (or order?) field to ETHTOOL_A_LOOPBACK_ENTRY as Jakub
    suggested, local to each component instance. This addresses the
    "multiple loopback points within one MAC" case without requiring a
    global ordering. I hope it addresses what Oleksij's switch example
    needs (multiple local loops at different depths within one
    component) *insert that screaming emoji*.
=20
 3. Document the viewpoint convention clearly.
=20
 4. Punt on the grand topology dump. Too much to chew.
=20
 5. Don't worry about DSA CPU ports - they don't have a netif, so
    loopback doesn't apply there today. If someone adds netifs for CPU
    ports later, depth handles it.

TL;DR: Add depth, document the viewpoint convention, and ship
it^W^Winterate.

Did I get that right?


Enjoy the w/e!
Bj=C3=B6rn

