Return-Path: <linux-rdma+bounces-17084-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF16EVzdnGl/LwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17084-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 00:06:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 991F317ECA2
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 00:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC907315D108
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 23:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0823137D125;
	Mon, 23 Feb 2026 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meaQnNPL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8F9322B9F;
	Mon, 23 Feb 2026 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887843; cv=none; b=EbQsjLz4oemKTftaoZyNyWxkcj22kpqN6LiTYiyixJ5B7xb13IyuZP1dyT1UEHbHWyIUxaRaJ+GPkCEw36jNal1uOcDJBZhwk7ZX1kVmgGyShhfNhEsSOzGl+MNbYOOjipIO/wvdHS7XjfgDlV3xBQd282/TWt+eTvD5+BFx4xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887843; c=relaxed/simple;
	bh=TkyQ0ve43Eajtu+f8t4voCveupiNrZZM+dzN9AHGyGc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BN1QmWvFAJBjw9BSXp1xaJ0q14FAb3r9bsXub1Utq8vD1eliSNeD5B0qyq2F4Dd8a48RXRd2gLpA06GyAeTiZrTbPf81lJqd23mv3wOjcSQVuUSKXcn7dNjfVpTkxZxCEa6YBZHlPRaqZ8+xHtb6+4TLwMGuGC0DEEclgZsYPoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meaQnNPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CADC116C6;
	Mon, 23 Feb 2026 23:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887843;
	bh=TkyQ0ve43Eajtu+f8t4voCveupiNrZZM+dzN9AHGyGc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=meaQnNPLeO+BPz/znhZDNE2E3JpKAEv+ZoJkxV3penwNDIZd/a9SP4wXiUoBy061Z
	 Vye9Wf+OcJc4tLQkvIkRM4V+tXVAOHxQOEobTvL8OCM5XnkOqxWS1zgwW/6wol842P
	 7gcNNJm+FzzvsVMFFG/BAYcwnMhee3vOP5n03XHLwRhs8BzZ6N4eIb+3Rp4RcpwSfF
	 RNCmIoEjc/+HM2n7JKoNopTHoTTBs7Chj048Zd1haz69t0BAPTQUp4iqiZfK8aRxzW
	 9qfxbXddoretLbXQxpoBQ/zkjddx9vADYU3cli67tb8EbpzCaEqV4kAkpN7A2JlH4U
	 S2z5Yl3CMA1Lw==
Date: Mon, 23 Feb 2026 15:04:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Michael Chan <michael.chan@broadcom.com>, Hariprasad Kelam
 <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>, Danielle Ratson
 <danieller@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 0/4] ethtool: CMIS module diagnostic loopback
 support
Message-ID: <20260223150401.7993b11a@kernel.org>
In-Reply-To: <CAJ+HfNgXqpqDYsmAa-mpHnO82aDgC7XbyVw3TmXk-ySFmGA-JQ@mail.gmail.com>
References: <20260219130050.2390226-1-bjorn@kernel.org>
	<415c4922-cc8d-4e35-bbac-3a532f44d238@lunn.ch>
	<20260219160519.323041bf@kernel.org>
	<3b0949fa-0b05-4bce-86c0-2a7a058865a5@lunn.ch>
	<20260220131254.03874c4c@kernel.org>
	<CAJ+HfNgXqpqDYsmAa-mpHnO82aDgC7XbyVw3TmXk-ySFmGA-JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17084-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,nvidia.com,bootlin.com,broadcom.com,marvell.com];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 991F317ECA2
X-Rspamd-Action: no action

On Sun, 22 Feb 2026 20:58:30 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> /* Loopback layers/scope
> enum ethtool_loopback_layer {
>     ETHTOOL_LB_LAYER_SW =3D 0,    /* Software/Kernel stack loopback */

What would that be? :)

>     ETHTOOL_LB_LAYER_MAC,        /* MAC/Controller internal */
>     ETHTOOL_LB_LAYER_PCS,        /* Physical Coding Sublayer (Digital) */
>     ETHTOOL_LB_LAYER_PMA,        /* SerDes / Analog-Digital boundary */
>     ETHTOOL_LB_LAYER_PMD,        /* Transceiver / Module internal */

In my mind the "layer" was supposed to tell core which driver to send
the request to. Same concept is used in the timestamp source selection.
PCS/PMA/PMD is both too fine grained when you have multiple PHYs in the
path, and does not cover all the possible loopback points.

>     ETHTOOL_LB_LAYER_EXT,        /* External physical plug/cable */

is EXT used somewhere to mean SFP already?

