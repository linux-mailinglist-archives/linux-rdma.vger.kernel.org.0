Return-Path: <linux-rdma+bounces-17751-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wG2WLA6DrmlfFQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17751-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 09:21:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EC9235708
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 09:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09D67303012E
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 08:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0C436CE1E;
	Mon,  9 Mar 2026 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I19jCDYJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8F436C5BE;
	Mon,  9 Mar 2026 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773044474; cv=none; b=N3oyM+TAXvj8B9elaIMT151q+sUxSAWxoXOGLzSG6XWbZ82QkQj2j2eYgDlR61mCCya93T+s+Ev/Dmj5TYG/p1sSD1kEC3dFYS892bJbeE612701jE0e17gju9tpcHVaJMdpVAie7cfRlq/yKdFmWPYNltV/DNfjJwh1RIbJRog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773044474; c=relaxed/simple;
	bh=yhDqd3a87e0Dyr+suaVKTSgT4WU4nLbz7GbcxD4ET/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c2ii9VJoV7feh+rEwMddPsFnp/eFEXDk+mGytKn1e33hYO9Jx8tpu1lMvcYV/0OBpyLfWyL0NhSCQeltvncozBUWVz6+2GAM5SN9Qkn8mFp4ZJfANdaUfB2aU12/+r7+RaYtNq6EActZEhboQADSJoCLHLnwufG8y7sPJc+kodo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I19jCDYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C301EC4CEF7;
	Mon,  9 Mar 2026 08:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773044474;
	bh=yhDqd3a87e0Dyr+suaVKTSgT4WU4nLbz7GbcxD4ET/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=I19jCDYJqZhAIlH9R/nUB7vJw7pmZNyHC+7qf6gBViEdlimOYRShV/Dfkiub1UJpk
	 otVYFLrPDI4KtvWslKCiJcsi5/NpLMgNfgCxFc3N+cXCgUyybRCOxbnddVxwRoVSvw
	 jAHPYgd9j4fz0+DC1V0vHOQoNG9VNIAzWcQPq+WWUebmvhgXgtcnnYk1d6Lwzb44LX
	 OB8sAn630r1xnSGZh+6YTN0CjTk0EyA/gw4YP07cmHKfuLDAU8N1i+sBEjmnk+aX64
	 qNg8UUBdME2wFxGsxrYTQDbLCnvgYdlzRohOr0UtVXFYfD5fTiBHOHRM8hjvJ65IA+
	 wJ5kL65I0bCLQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, Jakub
 Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Tariq
 Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
 Danielle Ratson <danieller@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC net-next v2 2/6] ethtool: Add loopback GET/SET netlink
 implementation
In-Reply-To: <19aa42c1-4e3c-4722-84bd-a21b53ad3993@bootlin.com>
References: <20260308124016.3134012-1-bjorn@kernel.org>
 <20260308124016.3134012-3-bjorn@kernel.org>
 <19aa42c1-4e3c-4722-84bd-a21b53ad3993@bootlin.com>
Date: Mon, 09 Mar 2026 09:21:11 +0100
Message-ID: <87eclth0qw.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 61EC9235708
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.07 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17751-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Maxime Chevallier <maxime.chevallier@bootlin.com> writes:

> Hi Bj=C3=B6rn,
>
> On 08/03/2026 13:40, Bj=C3=B6rn T=C3=B6pel wrote:
>> Add the kernel-side ETHTOOL_MSG_LOOPBACK_GET,
>> ETHTOOL_MSG_LOOPBACK_SET, and ETHTOOL_MSG_LOOPBACK_NTF handlers using
>> the standard ethnl_request_ops infrastructure.
>>=20
>> GET collects loopback entries from per-component helpers via
>> loopback_get_entries(). SET parses the nested entry attributes,
>> dispatches each to loopback_set_one(), and only sends a notification
>> when the state is changed.
>>=20
>> No components are wired yet.
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>
> At a first glance, what I see is that you're using the GET ->doit method
> to retrieve an array of loopback entries. The pefered approach in that
> case is to use the GET ->dumpit command instead, issueing a netlink DUMP
> request to list all available loopback entities on a given netdev.
>
> If you want some reference on that, take a look at the phy.c + the
> 'perphy' helpers in net/ethtool/netlink.c
>
> The idea is that you can pass a netdev ifindex in the header of the DUMP
> request, which you can use to dump all loopbacks the passed netdev.
>
> You can also check the ethtool code itself, you'll see that when you use
> the "ethtool --show-phys eth0" command for example, it issues a DUMP
> request to the kernel.

Ah, got it! Thanks!

> I'll continue the review w.r.t the actual content of the messages :)

...and thank you!


Bj=C3=B6rn

