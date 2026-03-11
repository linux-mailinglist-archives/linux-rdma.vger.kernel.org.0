Return-Path: <linux-rdma+bounces-17961-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDYnEx1DsWlCtAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17961-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 11:25:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB70426215A
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 11:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5760303CED8
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 10:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34933C661B;
	Wed, 11 Mar 2026 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3YYRy8M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B319D3C945B;
	Wed, 11 Mar 2026 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224690; cv=none; b=g5bMp0n/5Q13Jaa8IenI3vhDjuNqPnnbdEyELrC29uA+OjskPF+gofcizH0B2UDLpa/BkATtusN1opk4K3hBswICBvOkOFT7sDCCQTL1aSpK9emv+d3sih5KJI9qA/i5Ru8erCKMMUvdSVhLP9eJkEKT1dV8/H3jC54KvAlFW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224690; c=relaxed/simple;
	bh=GYR+iUyCK+fc0uuujRwUNrqEsrnz7mgwG4oMx3zcs0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AUVk1R1c5HFTJ2U864xE+LXA6xFQYFLJhYPZW+VYn5ttg9t3gN++bwPHklNgp5wGMgp2AqWnmj6y7LAE0sfyeHxD+eJxFv273pGn+2Dce5lVYi83ulLFQGD25+BIasgeY6gZeiQuKZlZdNjyGXdQxjXLToalY1biayV5VS86buY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3YYRy8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82F9C4CEF7;
	Wed, 11 Mar 2026 10:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773224690;
	bh=GYR+iUyCK+fc0uuujRwUNrqEsrnz7mgwG4oMx3zcs0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Q3YYRy8M+4ocxdh9UpF+Nyqsy5ZTQoAOZb6gpqpz/ldmFg2uWeZMCLp7Iu42m2h6I
	 Zyfz2K7SnMP2CybrJ/okObZ7ARRWYGra5ooPHB8LJsGxZYrJhEkPOtBzJHiaP6ZYka
	 nXicyeXph+WzRb3RXIDAlUxeJrgzIUadYoufHKseVjshxV2+IjsB4PWHMEcjqNLdIg
	 Rf3BCLRkmMtIHgShRvsgCmEx5kdMCLf4rOsX5zewxtf6681VEZu8UNj265kdFtmHkj
	 obOl2vqhJkWB43E3G10v3+pEiMAvGa8ABTO24oWdP/gMslE2QoC23IxAd6kP03Bg/T
	 ewOd+9G2Ag5Sw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Naveen Mamindlapalli <naveenm@marvell.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Danielle Ratson
 <danieller@nvidia.com>, Hariprasad Kelam <hkelam@marvell.com>, Ido
 Schimmel <idosch@nvidia.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Leon Romanovsky <leon@kernel.org>, Michael Chan
 <michael.chan@broadcom.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Willem de Bruijn <willemb@google.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 00/11] ethtool: Generic loopback support
In-Reply-To: <abEJK8ombhGhaJWq@naveenm-PowerEdge-T630>
References: <20260310104743.907818-1-bjorn@kernel.org>
 <abEJK8ombhGhaJWq@naveenm-PowerEdge-T630>
Date: Wed, 11 Mar 2026 11:24:47 +0100
Message-ID: <871phq4qa8.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BB70426215A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.11 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.77)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17961-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,kernel.org,bootlin.com,redhat.com,nvidia.com,marvell.com,broadcom.com,pengutronix.de,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:email]
X-Rspamd-Action: no action

Naveen Mamindlapalli <naveenm@marvell.com> writes:

>>  - Is this the right extensibility model? I'd appreciate input from
>>    other NIC vendors on whether component/name/direction is flexible
>>    enough for their loopback implementations. Also, from the PHY/port
>>    folks (Maxime, Russell)! Naveen, please LMK if the MAC side of
>>    thing, is good enough for Marvell.
>
> Hi Bjorn,
>
> Is a SERDES component as Maxime suggested something you'd consider
> for follow-up patches? It would be a natural fit for SoCs with a
> separate SerDes hardware block.

I don't think so -- rather, I think I'll follow Maxime's suggestion for
fewer components, where "component" would be "Linux abstraction/object",
and the "name" would be 802.3 vocabolary. Please see my reply to Maxime
(in the writing now ;-)).


Cheers,
Bj=C3=B6rn

