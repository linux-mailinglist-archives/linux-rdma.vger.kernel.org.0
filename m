Return-Path: <linux-rdma+bounces-18717-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPmJDbayxWmpAwUAu9opvQ
	(envelope-from <linux-rdma+bounces-18717-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 23:27:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C3433C5B4
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 23:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64D36301C151
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 22:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADE733065C;
	Thu, 26 Mar 2026 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/sh3n5j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D342313E1B;
	Thu, 26 Mar 2026 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563819; cv=none; b=QisO2GBgq1/XSrr3r0VGxPH6o3a3wunpo/3vYoc03sc4Wsgn3ScHxEzhWZBbjZ2H1c4tFCwGkhxNMwAzc73ipC0hLk7PiJbJRVpHoUaQTjmDbS1mCW9AJf4upNmBKj3uSDwe40CPv97J6LICHFJIh9dTmZ6YjOu5REpt4mmH++w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563819; c=relaxed/simple;
	bh=gd17ff83Qslzmu6nQdhq7Bpr2kdFpRbIISHbIzyiYpg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAtxxDxmyhRY1HRnXN++8nlfmsMgB+xKUoydNR4eeX/kVc6JOsgD7aWXx+3tmi7y9jxCBJ9pKtn091qSuVIQRTKUzQk1rPbSULaJssYb4B0+oc8LyX5VVRCkcSzoTNzXQ6BwZ5MlfMywhvd2JgKyFhikG2CE4ScVc842xaQJQuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/sh3n5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0F6C2BC87;
	Thu, 26 Mar 2026 22:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774563819;
	bh=gd17ff83Qslzmu6nQdhq7Bpr2kdFpRbIISHbIzyiYpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y/sh3n5jSq5Y4zqHT1MXYwHYKcO/9HobHF4tfnFrzErwbT335YDZqcq2ireQ+EEzB
	 mdHf3J/1PWEOw3WJk+Qw1+i++pcJ2XbkW7BTAz/U1jGA/B0zhfb0tII3IDId05p1aI
	 /rEt8UbeZoq0HNoPUiojinswNIvgVqbZhtGACVzeEFHZmbkaQTKZqCDVTnAly+cy99
	 bGdD7PwQWXfJgMkxatA6s2vZl8xBnMC7VGdHWVUUZAtrPCyERwAJAM2yflFNJz3I7a
	 Oa8Gz+iEu3hR1KXJ+FcKdMZSKUy5aoWrcb5QWYKhN4BH5mIIrK9orlv90gmprr5YM8
	 kzrg6zlmgl04A==
Date: Thu, 26 Mar 2026 15:23:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Naveen Mamindlapalli
 <naveenm@marvell.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Danielle Ratson <danieller@nvidia.com>, Hariprasad
 Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Leon Romanovsky <leon@kernel.org>, Michael
 Chan <michael.chan@broadcom.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Russell King <linux@armlinux.org.uk>, Saeed
 Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Willem de Bruijn <willemb@google.com>, Kees Cook
 <kees@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v2 03/12] ethtool: Add loopback netlink UAPI
 definitions
Message-ID: <20260326152337.2cff3c24@kernel.org>
In-Reply-To: <20260325145022.2607545-4-bjorn@kernel.org>
References: <20260325145022.2607545-1-bjorn@kernel.org>
	<20260325145022.2607545-4-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18717-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,bootlin.com,marvell.com,redhat.com,kernel.org,nvidia.com,broadcom.com,pengutronix.de,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[28];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92C3433C5B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 25 Mar 2026 15:50:10 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> +      -
> +        name: depth
> +        type: u8
> +        doc: |
> +          Ordering index within a component instance. When a component
> +          has multiple loopback points of the same type (e.g. two PCS
> +          blocks inside a rate-adaptation PHY), depth distinguishes
> +          them. Lower depth values are closer to the host side, higher
> +          values are closer to the line/media side. Defaults to 0 when
> +          there is only one loopback point per (component, name) tuple.
> +      -
> +        name: supported
> +        type: u8
> +        enum: loopback-direction
> +        enum-as-flags: true
> +        doc: Bitmask of supported loopback directions
> +      -
> +        name: direction
> +        type: u8
> +        enum: loopback-direction
> +        doc: Current loopback direction, 0 means disabled

u32, Netlink attrs are padded to 4B anyway

