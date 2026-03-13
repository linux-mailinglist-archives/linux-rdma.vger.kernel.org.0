Return-Path: <linux-rdma+bounces-18132-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPYCKXtYs2kRVQAAu9opvQ
	(envelope-from <linux-rdma+bounces-18132-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 01:21:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D9827B8EA
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 01:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F606305555F
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 00:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D285F283C82;
	Fri, 13 Mar 2026 00:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzfOX2BK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9394A191;
	Fri, 13 Mar 2026 00:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361267; cv=none; b=k0SiSk6q+Zp1GHXdGQ+xFmtxxvEj2GE26XGicFozinqY1CG4mAXIHZ447lA7WyCFzFuS+tdMJM+xlxfcZ26e34ikQ3ZjCQ09clwUneKod3Lxqeo3bMYpFJj14ftnAR+pmDeWntdvAcekb0aOYyHoJ0L5Ul9p3raBFlZQ3MJ79ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361267; c=relaxed/simple;
	bh=EGu7h6sqch53CVjj+74drrbwn+MhP5k4eHR8FWN8LjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAieOhl4H17uHIZeHkMJD8x1tzKYmHrYGCUf866lOSUlYHYjmMwr+BOuoknzxw12EkjiYPMzEbAy4c+LElcwUq5myL1O3M6xU9uLU1hpugTpBOpsEPReTJeJ1tO8N/yJqJIzfORk9iXSISeLg+YEyylQ/g1VQO4OoA4X2UVRs5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzfOX2BK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4088C4CEF7;
	Fri, 13 Mar 2026 00:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773361267;
	bh=EGu7h6sqch53CVjj+74drrbwn+MhP5k4eHR8FWN8LjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TzfOX2BKtrlz/XUUA32/AYFnB40A/Lg1pwVHbSHCw2QMhRcymAVqM3fJ/0MvuADtR
	 1+oJpFiUWZn7koeq1wN0rE9sUdsG82bnHSOYi+/mNPYnGGVk+CMZwB/8ZndsyYvA+a
	 +T0qHWxErFA6ejnhdxTRHVeHXMEWp7t+C0cwVPOufOcY7mc1MXYH0HDA9J0E7owrCm
	 bGWBqHZd7R8xpN/SU00KCUtq6oupOX8XqBnrmJZMfMizUgQrsCDHncoCz92jD+VTP8
	 UGj04yCM7l1Myx4deMxTcPm8j44oUrX5XsoynEIEAz8m+8T7hqmeSKUlLH+LR0CPfz
	 0kA6bPFkrW5JQ==
Date: Thu, 12 Mar 2026 17:21:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, Naveen
 Mamindlapalli <naveenm@marvell.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Danielle Ratson <danieller@nvidia.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Leon Romanovsky
 <leon@kernel.org>, Michael Chan <michael.chan@broadcom.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan
 <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Willem de Bruijn
 <willemb@google.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 02/11] ethtool: Add loopback netlink UAPI
 definitions
Message-ID: <20260312172104.2ed465f0@kernel.org>
In-Reply-To: <171da8e9-fb09-4cfc-a29e-aefbdc8c3ce9@lunn.ch>
References: <20260310104743.907818-1-bjorn@kernel.org>
	<20260310104743.907818-3-bjorn@kernel.org>
	<580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
	<87tsum3b1o.fsf@all.your.base.are.belong.to.us>
	<ed30934a-4931-40e5-a659-6fc8d12741b5@lunn.ch>
	<20260311194716.600704aa@kernel.org>
	<171da8e9-fb09-4cfc-a29e-aefbdc8c3ce9@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18132-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,bootlin.com,vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,marvell.com,redhat.com,nvidia.com,broadcom.com,pengutronix.de,armlinux.org.uk];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 66D9827B8EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 14:46:40 +0100 Andrew Lunn wrote:
> > Which reminds me -- I was suggesting that we add an order / id to the
> > stages, not just name. Because AFAIU being able to request the loopback
> > "very last loopback point of MAC" or "first loopback point of PHY"  
> 
> How do you define where the MAC ends?

MAC may not be the greatest of names because I'd include in it
everything past the PHY, up to the DMA blocks.

> I suspect some vendors will include the PCS and the PMA, because the
> MAC ends at the MII pins on their SoC. Other vendors are going to say
> the MAC ends at the interface to the PCS, especially those who have
> licensed the PCS, and are using the shared Linux driver for the
> PCS. And the PMA might again be a shared implementation, since it is
> also used for USB, PCIe and SATA.
> 
> If Linux is driving the hardware, using phylink, phylib, PCS drivers
> and generic PHY, we are very likely to have a uniform definition of
> all these parts. Are we happy firmware devices will have a much
> fuzzier, different interpretation, conglomerating it all together?

As long as the kernel API lets "integrated" devices expose both a MAC
and a PHY node I don't think we should let anyone conglomerate.

I see your point that the enum would work nicely for PHY stages.
But it will be limiting for MAC stages.
These conflicting preferences make having all of loopback config 
in one API tricky. I guess we could have a half-measure to add in
the kernel the "well known" PHY stage name, and WARN_ON_ONCE() if 
some driver exposes PHY stage in something that's not a PHY.
Or uses an unknown name for a PHY stage?

