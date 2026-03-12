Return-Path: <linux-rdma+bounces-18056-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKN9GFEpsmleJQAAu9opvQ
	(envelope-from <linux-rdma+bounces-18056-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 03:47:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B2D26C6C8
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 03:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76597302DE31
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 02:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6534381B0E;
	Thu, 12 Mar 2026 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cURnn4P6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C56381B02;
	Thu, 12 Mar 2026 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773283639; cv=none; b=o5gobbcR/Xsmc0Syl8EYv34fvAYd+gAXL2qJkAz9CFWeBzghLQljx/+Mfhd9pBQopqnMcxrQN5+Uo7GH6HHONdw/V8Hj+KQOkzEoQ7Yd1wdt00/HzKgbAmscfRXSyeI851XTYObw0klbO2wpLT8dE/Memfb+5A14FzFdyylOrss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773283639; c=relaxed/simple;
	bh=EzDnqoDkNd2aGBg3w+NxUDMtYGdl4Z19JF8iO1ml98o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQtcoyNwFDl8lbv5fYU8TzB8ETvZ/bjHF2dQzVVp1VsS7rKz5SQhnXCqICjF3ZKKr4UULUSUgujxB01NwxJv7LB0vALSraO7OoxTrAdlxY84rgtZvQV9FAYTdBV428of/5JJ8Jf0cSk3Wm0g8d1ucHUOqcwIaE4bD7L7v6mul0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cURnn4P6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2ACC4CEF7;
	Thu, 12 Mar 2026 02:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773283638;
	bh=EzDnqoDkNd2aGBg3w+NxUDMtYGdl4Z19JF8iO1ml98o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cURnn4P6iDDrSMVfUr+cbFiKi3V6/PMI/Re2Aiwv7TtPeUIA6FWzXzphCdwNWtQ8R
	 dnGiyfF9jS41CXdxqFjtAF4TtueoJsX2eVkYYSEGHV5uwXDx+EWQCwekbno9ND2+1c
	 TwmqsN1T6DCldB1ai+wHq+Cirj3MPeBim0DQ+xE2z6kYESi9py/tL67ipv9e+tGcIj
	 N/6dmW9zJXduK/LVTD+vPs4iYltIVEVnuHWtHlEm7ztpzRXRZBxu6KD4M4CqklU6QM
	 IQtBve1ER+4BzO9xDCW1allNzPOsaIDXNZG7ULFNXsFJL+ZD6zUo73oPwwgGtZgAVU
	 Ir99ZDJWXm2Iw==
Date: Wed, 11 Mar 2026 19:47:16 -0700
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
Message-ID: <20260311194716.600704aa@kernel.org>
In-Reply-To: <ed30934a-4931-40e5-a659-6fc8d12741b5@lunn.ch>
References: <20260310104743.907818-1-bjorn@kernel.org>
	<20260310104743.907818-3-bjorn@kernel.org>
	<580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
	<87tsum3b1o.fsf@all.your.base.are.belong.to.us>
	<ed30934a-4931-40e5-a659-6fc8d12741b5@lunn.ch>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18056-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,bootlin.com,vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,marvell.com,redhat.com,nvidia.com,broadcom.com,pengutronix.de,armlinux.org.uk];
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
X-Rspamd-Queue-Id: 21B2D26C6C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 16:30:03 +0100 Andrew Lunn wrote:
> > I like this. The nice thing is that since "name" is a string, we're not
> > locked into an enum -- drivers report what they have using 802.3
> > vocabulary, and we document the recommended names (pcs, pma, pmd, mii)
> > with references? That way it's unambiguous, but not too constrained.  
> 
> It is both good and bad. I expect some vendors will just ignore the
> text and use what their data sheet says, because they don't know
> better. An enum forces more consistency.

enum only enforces using a value from a fixed set. The uAPI itself
cannot enforce functional equivalence. Worst case this may result
in different vendors interpreting the enum differently. With a string
there's a better chance that even if not matching between the vendors
at least a user with a databook in hand will know exactly what the
Linux API will do.

Could someone please explain to me what the use case for
standardization of the enum values would be? I push hard for
standardization of stats, because with standard stats its easy to build
high level standard tools. I don't understand what value standardization
across vendors what the last step of the MAC is called brings us.
Please explain, and if we have a real use case in mind it should be
possible to write a selftest that verifies that use case is met by any
given device.

Which reminds me -- I was suggesting that we add an order / id to the
stages, not just name. Because AFAIU being able to request the loopback
"very last loopback point of MAC" or "first loopback point of PHY" is
something that should be doable without user having to parse the names
/ enums and understanding them.

