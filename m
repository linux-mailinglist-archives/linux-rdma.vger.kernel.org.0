Return-Path: <linux-rdma+bounces-18363-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DJuJcD4umlwdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18363-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 20:10:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C342C1D81
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 20:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46A46300A391
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 19:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2F33EF678;
	Wed, 18 Mar 2026 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQ/IanJ4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013803D648C;
	Wed, 18 Mar 2026 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861048; cv=none; b=gUnDPa0MAuSkLleaM0cWRj/kDWyZysVn/Bc6ZvoK9wB/r8j0u7M2fh9dgEJHJnZhMM4wsLgZId6ht2ngkOai8wF2uAZVxdQgmts3T7xiyXTgPHljqXiSTGcyNHG+qJwr3rK0z5iiK5+/9BKJ/20p6sZi3rGdBmc/xcvctyaOPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861048; c=relaxed/simple;
	bh=vF85Ld0H6v3LbIAsot0GTMPeWPK6vbEVmdTJ6kKOmOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGxP2HBN93wyFuGdlJY03NpaZrDp9aCCp/zqruLQ/3SP4Uw7LmXwatmbWvX7aNEPhVrXryhYR+qbP4VQiZvAU/tcZm4XPbtX3xH0HaoxwB9i+a84wuJ5G/QzllLLPVFOt843FW+SQZg/6B2NffS2e/YAadi9o7ORElHpZZaU7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQ/IanJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C38C19421;
	Wed, 18 Mar 2026 19:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773861047;
	bh=vF85Ld0H6v3LbIAsot0GTMPeWPK6vbEVmdTJ6kKOmOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQ/IanJ4j3o4pZIhiIO5nts3zfsvyUQq9H3+Y+jpQG8mLEb3ylcLGVNC9QXb8eBnd
	 GMZzg9ZUq/dq36gkarg89AjRYzKl99ASpFPEBx5XdZW4vmD88eXiZkCy78bxLxn9AQ
	 i+3fXi4IycLKH7iKtpQMU78bnuHADyRkLZkF4OjmLGy2yV5dWgrf7CKLm1wBmV600C
	 EUh/LpIQuX3AKaVvMD9OIR5z2ZAeT0IBLYNc8Ku2XMwE85azK5eKOWHL15poVlY/lG
	 1vDlTSztWyXKYipWdtM1S7sPInO4iAz1cL5rL9XiHPdIMDgr5jClwKU35y/bMD/WnR
	 k4rBsXSMD1Uiw==
Date: Wed, 18 Mar 2026 12:10:37 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5e: Enable mac forwarding on uplink
 representor
Message-ID: <abr4O7rfDoOIKHYW@sx113>
References: <20260310104841.1862380-1-tariqt@nvidia.com>
 <20260311203319.76d35ce0@kernel.org>
 <abmZf3bRl2uQ69EA@sx113>
 <20260317143653.0eaa50a1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260317143653.0eaa50a1@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18363-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.946];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[saeed@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04C342C1D81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17 Mar 14:36, Jakub Kicinski wrote:
>On Tue, 17 Mar 2026 11:12:15 -0700 Saeed Mahameed wrote:
>> On 11 Mar 20:33, Jakub Kicinski wrote:
>> >On Tue, 10 Mar 2026 12:48:41 +0200 Tariq Toukan wrote:
>> >> This small patch enables mac forwarding to MPFs via uplink representor,
>> >
>> >"mac forwarding to MPF via uplink representor"
>> >Can't wrap my head around this "via". Could you explain this better?
>> >Perhaps some tool can spit out a little diagram to make the flow clear?
>> >
>>
>> Mac forwarding in the sense of linux bridge mac forwarding mechanism which
>> requires set_rx_mode ndo to be implemented.
>>
>> Linux-bridge --> mlx5-uplink-rep --> set_rx_mode --> set up mac in HW.
>
>And the actual forwarding happens in SW bridge? This is just to
>configure the Rx filter not to discard on Rx?

Yes Forwarding happens on the SW bridge, just to register the mac so it
won't get dropped.


