Return-Path: <linux-rdma+bounces-18716-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Yz0sMKuxxWmpAwUAu9opvQ
	(envelope-from <linux-rdma+bounces-18716-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 23:22:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7247433C4D8
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 23:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18026305ACB7
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 22:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FB1329C71;
	Thu, 26 Mar 2026 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQpxCsQK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6577717BA2;
	Thu, 26 Mar 2026 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563751; cv=none; b=TqNfSJlrdQIJyMYLCyrMpbxBKthlbaHeCYPxIOBIy52hMEXMF+j5NQhyUphq1XpOmmC+LppdNdIAtS98Do/6j/e8JYM2aWjfISf4JYRYinmqj4SL36By8CYtDG/cNcRaFl+fUt/OxpJguMc5Nog2sx8B0LwTifE3J80cZ0pTLOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563751; c=relaxed/simple;
	bh=Nn6bJFfe8m3I2yL5csiWVtZaPGCdWiiPQMHXhCUNrng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+UE3vS+sKrSjxbrlDGs77qOx+OP/yBcqWX+CRXOVj53/WzDEZ/XIv76eVlg7a8K7OkxrWG8dPsBIWf7opJdd4ME6RCkY5Efy2ykr/lmuycR2ezP950c1HU5+jCLtn+d+kQvExASFOolGHTnR31gFWunxW/dkub4nmyAlpkgWfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQpxCsQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF074C116C6;
	Thu, 26 Mar 2026 22:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774563750;
	bh=Nn6bJFfe8m3I2yL5csiWVtZaPGCdWiiPQMHXhCUNrng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iQpxCsQKCY5ERbDNhb/9HPGLoLa6REYJ4W+cgNtyY4BD5eqcfyLXaNkOy7WRN2NFS
	 7LKrTp+2+fCFM7mu5/n5sQD7JkVxmcJLjzucT4N9t0p3nglIORjRnOLYsUwipI161e
	 6XMHwTmEMB7fMLPY9A1eUymx8PCsREK+9doK5h8QhbnJBzMTtcH0AnIcraqbkQ4Vaj
	 4QwZlpFWh8Ys3qv9yFxgnZC9kot7Yvv4b2PDoohO1gfk2qxRRmNDOQLIOJlEaLHPPL
	 lV8YqBm8WRC0k/RkmtkNui4um0SdrD3R7vWMZnqqJW9aeefNzoHG1KG4d/ovOAISH4
	 Wn3mEqt/D+9EQ==
Date: Thu, 26 Mar 2026 15:22:28 -0700
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
Message-ID: <20260326152228.2c6937ca@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18716-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7247433C4D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 25 Mar 2026 15:50:10 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0

I don't think we need to add unspec attrs for new sets ?

