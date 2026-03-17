Return-Path: <linux-rdma+bounces-18271-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCvUOf6auWn5KwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18271-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 19:18:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0572B0CF6
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 19:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7ADA30748A2
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 18:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699893F7E9A;
	Tue, 17 Mar 2026 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iS6vpCjW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA553F7E84;
	Tue, 17 Mar 2026 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773771148; cv=none; b=kEIfWSjZNpX8Zjoq+t8fem1h2oP0eqiKHxkIQ+dNnkFTAb6YUEZ1pCCusVyfbDjyLEUXpED6yxzPyGBXYI/syCjS1sGYXSlpQRtfUN/6TXivazhb11CRAT7yWbJr89MGDyM62nGD7u7smpeJGoLzkyrFt/nL2GruRYiIFx3q5wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773771148; c=relaxed/simple;
	bh=JH0WXUYQ5HiJRN/RLvNKxq/3IL3EQg9pRAnmlaE6SjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMNEb1LmHKR11B92IIRBg6NG/4QPi2Hi3jDsjRkFUpDY8vyIT0DeWzbfqwRsNsZFQJksmoShxd6U2t/6EO7TmXsg1AQTvPslC29nRHXmmkirCvNVXRRtE8QuaRoPYmhWbN0VnvbNyU43KGSZ36s4+6RfasA4GS5qw+RzL0FovgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iS6vpCjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC47CC4CEF7;
	Tue, 17 Mar 2026 18:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773771147;
	bh=JH0WXUYQ5HiJRN/RLvNKxq/3IL3EQg9pRAnmlaE6SjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iS6vpCjW3G7cILy2Qx9C2okrREtmXRvqSCAO8MdpbA2v6awkntzjakN4XKvEFZCoc
	 bBVkTk7MJ9R6jTUAjsp2F/lbt5cDniR89lLL104ZioXxgIOTIp6IXUFjyzb2vh0+gI
	 HobVQC14XtTuFAVZ2pPL72RC1ChMztWrcr7pg/RpjuTtFZdQDjxXA8DWA2upIFxT/C
	 l+YYMux8pCj88/8s9dA09wfNsptYnOOb8MOwxPVPBeBSu6CcK6w83w48xnax/5QdfY
	 R9dVXImdw+vOPkpV+IeUha8w8acydU4mc6fvBhTsWDMYHLIkOto9WGC7FoEYXOTT8o
	 NZKN6H3b3/czQ==
Date: Tue, 17 Mar 2026 11:12:15 -0700
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
Message-ID: <abmZf3bRl2uQ69EA@sx113>
References: <20260310104841.1862380-1-tariqt@nvidia.com>
 <20260311203319.76d35ce0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260311203319.76d35ce0@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18271-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[saeed@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8B0572B0CF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 11 Mar 20:33, Jakub Kicinski wrote:
>On Tue, 10 Mar 2026 12:48:41 +0200 Tariq Toukan wrote:
>> This small patch enables mac forwarding to MPFs via uplink representor,
>
>"mac forwarding to MPF via uplink representor"
>Can't wrap my head around this "via". Could you explain this better?
>Perhaps some tool can spit out a little diagram to make the flow clear?
>

Mac forwarding in the sense of linux bridge mac forwarding mechanism which
requires set_rx_mode ndo to be implemented. 

Linux-bridge --> mlx5-uplink-rep --> set_rx_mode --> set up mac in HW.

Thanks,
Saeed.

