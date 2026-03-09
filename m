Return-Path: <linux-rdma+bounces-17787-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOeCAH/frmm/JQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17787-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 15:55:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2F823B055
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 15:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E1D2301688B
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46403D349B;
	Mon,  9 Mar 2026 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6P+HMjZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13884B640;
	Mon,  9 Mar 2026 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068155; cv=none; b=N6C3lvPkw/QjKWHG2UoIQWWWsvX0VVehLgm4ZW13FP1PAH74GEKzkQECZ3Pa7S/zuFX1Dd9/2SzTqd3kCUtSDl6MNwXWHKDcyHH04xAUR7spKIxLTSrnHNGYxJQrpbHIy791t+RWlp8kPDpx6yxCorp+w3he0RMP5vsNXSFIaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068155; c=relaxed/simple;
	bh=3A044siluQ+CgDz0gvCJ+MlnzuQ7BRNv3biDaSQWhqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z8CcZcEOE7P9llrfD/X3qkkCJCNmIbZ/h16PZvQ8bO2Pfsc6PiXDgpoaATetKj0htCw0uOx81Q0cLIO78YzvfuBgADcErJIbrxlqKOY91yRUAM/XSf/fVmuG1+/D1SGSBvpXJ81xLQEwJDGcc01jbv8vu1ckEu3tdld1rufbTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6P+HMjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0356DC4CEF7;
	Mon,  9 Mar 2026 14:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773068154;
	bh=3A044siluQ+CgDz0gvCJ+MlnzuQ7BRNv3biDaSQWhqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=b6P+HMjZkZhtfj6+/occb+CPtuKNuNAHlsDAnWgds5XDn+CcEjo+4bHfm8zXpIyzK
	 InJVWND5s8cD/iry5Z3zoOVJk/4FkdQm5yMJGg0EuQiXUIeu6R1OI7alnug4PX+OLf
	 +ZqgujUkbiOo9MdTeJxvEgHxXIV6dSmnGQbmEGITtyWvi6O2z9np5PGMk8wPM9yoJ3
	 OO7L0iJAlqDBHWGTxEUKcpjHyQf1xMrGjXIYLQl/+P0Vl9CQPRFRtl7HFp8koot48w
	 PzLEqQ6FS0VICAor/pBw/Jksx8WlQw1eIEr6JXGqOVArhrZmhCZL2qg5FNtzNopUg9
	 fGWZHVZ4K5Tbg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Naveen Mamindlapalli <naveenm@marvell.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, Jakub
 Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Tariq
 Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, Michael
 Chan <michael.chan@broadcom.com>, Hariprasad Kelam <hkelam@marvell.com>,
 Ido Schimmel <idosch@nvidia.com>, Danielle Ratson <danieller@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>
Subject: Re: [RFC net-next v2 0/6] ethtool: Generic loopback support
In-Reply-To: <aa7P7UUUG1p5RVwO@naveenm-PowerEdge-T630>
References: <20260308124016.3134012-1-bjorn@kernel.org>
 <aa7P7UUUG1p5RVwO@naveenm-PowerEdge-T630>
Date: Mon, 09 Mar 2026 15:55:51 +0100
Message-ID: <87tsupnjbc.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 9E2F823B055
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.55 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,bootlin.com,broadcom.com,marvell.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-17787-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,all.your.base.are.belong.to.us:mid]
X-Rspamd-Action: no action

Naveen!

Naveen Mamindlapalli <naveenm@marvell.com> writes:

>> Open questions
>> ==============
>> 
>>  - Is this the right extensibility model? I'd appreciate input from
>>    other NIC vendors on whether component/name/direction is flexible
>>    enough for their loopback implementations. Also, from the PHY/port
>>    folks (Maxime, Russell)!
>
> Hi Bjorn,
>
> The component/name/direction model in v2 fits our hardware well.
>
> I am working on loopback support for Marvell OcteonTX2.
> The MAC (RPM block) supports a PCS-level loopback. In addition,
> the on-chip SerDes (GSERM) is managed by embedded firmware and
> supports three more loopback modes:
>   NED (Near-End Digital) -- digital domain, before the analog front-end
>   NEA (Near-End Analog) -- through the full analog front-end
>   FED (Far-End Digital) -- line-side traffic looped back
>
> Since the GSERM is not a phylib phy_device, both the MAC PCS
> loopback and the SerDes loopbacks fall under the MAC component
> in your model.
>
> Mapped to the v2 model:
>   component  name         supported    description
>   MAC        mac          near-end     PCS-level loopback
>   MAC        serdes-ned   near-end     digital only
>   MAC        serdes-nea   near-end     analog
>   MAC        serdes-fed   far-end      line-side
>
> The SerDes NED and NEA both have the same (component, direction).
> Both are (MAC, near-end) -- but exercise fundamentally different
> hardware paths. The name field distinguishes them as per your model,

Ok! ...and MAC+serdes makes sense from your PoV? Or do we need a new
component "SERDES" (as Maxime points out in another reply)?

> I can work on MAC + SerDes loopback driver support for CN10K and
> post patches on top of your series once MAC component dispatch is
> in place.

Got it! Thanks!


