Return-Path: <linux-rdma+bounces-18352-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L5nLo3VummfcAIAu9opvQ
	(envelope-from <linux-rdma+bounces-18352-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 17:40:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4982BF718
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 17:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 605F931B1F97
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42493328B58;
	Wed, 18 Mar 2026 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K5h205g3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954543E1208;
	Wed, 18 Mar 2026 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849571; cv=none; b=e5vO3gXP8dV7UB73+IC/q37AZsmSirHmo2fRC751KqBrjfJlsFI87k7EUqjJvTCCSEO9tQ4sv2+ZzhplKrpxDKPqjvl5bcoAR9cr3D0NYmBoaDNNXb9zaqfA3j5eStAevohWs5pywdvX7aRwoZ/r4kT/stIEYN7snIUv0ldmTCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849571; c=relaxed/simple;
	bh=/X0YlCpfDx+7GE4gYCD2ji/irbhRczxe13pO90tN+ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGD6mHEoEeLS3Ngkq/3A+zdIs5aKJUspErGkIkRuQUc0Kx6m/0iEwXhnyIBOKotv2zwAa739f4PAUzJtS+CPH+U43Ay/zakUffh6qM6ggmiWzdDe6GjV/T0fNO/wLJQQSfvd1Ci2ZjqXi+AhekrkvuYC6sae9M+/SuJAZOTPF6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=K5h205g3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IveppaNPJT54QFrgVviokBkEo5h/cNL1a68V6Vsapn4=; b=K5h205g38VqadK+bKr61TqLPDr
	sr5DSGstfyqcEiG9s0nLqqkewGb0yAJ6KlwaDCuBd3NDNKvmkWqhtNL/04ilUUci7BokG3O5usmg1
	6ZCve42SkVC+AEn19S3zspkD1rxd8QaMSezAkBuXayo9v+2EojNYtqBz1ngb1RKesWXM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w2tIX-00CEhX-Pn; Wed, 18 Mar 2026 16:59:05 +0100
Date: Wed, 18 Mar 2026 16:59:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Danielle Ratson <danieller@nvidia.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Leon Romanovsky <leon@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 02/11] ethtool: Add loopback netlink UAPI
 definitions
Message-ID: <7620dcbc-8423-4351-96d9-3e0e9e7c0b8a@lunn.ch>
References: <20260310104743.907818-3-bjorn@kernel.org>
 <580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
 <b3825c0d-02e5-4625-831f-4346ce4eabd2@lunn.ch>
 <085bb0a9-85d3-4d62-9ac4-3461b61da5f3@bootlin.com>
 <438dae03-4dac-4e66-9f4d-e08b0434c9b4@lunn.ch>
 <20260311195052.1202174f@kernel.org>
 <abJJY8whzSOB8O-X@pengutronix.de>
 <7c45ebf6-0cb2-4a4c-ac12-f4f9bb59c908@lunn.ch>
 <42abf88e-4fbf-4966-9490-8315f118ddea@bootlin.com>
 <873423y27k.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873423y27k.fsf@all.your.base.are.belong.to.us>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18352-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,pengutronix.de,kernel.org,vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,marvell.com,redhat.com,nvidia.com,broadcom.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C4982BF718
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> So, maybe the next steps are:
> 
>  1. Keep the current component model (MAC/PHY/MODULE) and the
>     NEAR_END/FAR_END direction (naming need to change as Maxime said).
>  
>  2. Add a depth (or order?) field to ETHTOOL_A_LOOPBACK_ENTRY as Jakub
>     suggested, local to each component instance. This addresses the
>     "multiple loopback points within one MAC" case without requiring a
>     global ordering. I hope it addresses what Oleksij's switch example
>     needs (multiple local loops at different depths within one
>     component) *insert that screaming emoji*.
>  
>  3. Document the viewpoint convention clearly.
>  
>  4. Punt on the grand topology dump. Too much to chew.
>  
>  5. Don't worry about DSA CPU ports - they don't have a netif, so
>     loopback doesn't apply there today. If someone adds netifs for CPU
>     ports later, depth handles it.
> 
> TL;DR: Add depth, document the viewpoint convention, and ship
> it^W^Winterate.
> 
> Did I get that right?

Sounds reasonable. The first version can be KISS, we just need to keep
in mind reality is more complex and try to avoid adding any roadblocks
for making it more complex to reflect that reality.

    Andrew

