Return-Path: <linux-rdma+bounces-19983-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBScAddT+WnF7wIAu9opvQ
	(envelope-from <linux-rdma+bounces-19983-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 04:20:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B6F4C5F28
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 04:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F25AD301FA59
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 02:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ED4390C9E;
	Tue,  5 May 2026 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgN3gM17"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579138632B;
	Tue,  5 May 2026 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777947600; cv=none; b=aoq+gVk2NmaBEGv7ZGPonjaA5k4KR1JaXIGR6j+jdYYx5Vk3z4JSj3dBA094ASvnvT9AUzLIeih6biz6vKi2t/hbrjwmLUb9BYGEwDcJ6qMMy/7MqqN2qcJmupM1aPUnfAg7bvoACQ0In4VxGBlVd9WY00uyurdrCY5jVjNFxx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777947600; c=relaxed/simple;
	bh=Aq7g1mtSp3vjGfWBplp4S+Cf9ysPmhdYG0ZOGsXHdBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFUDj4WmSCkkaKSxHeX+TD7BuKfE6nJ+iiHj5nEBuv4liHOjy2Ji971apvYSX/i8Fn/F7GvjnlgU6uGZjm11896bFJDnXgWrsC1/LrkzywqFPu4Cs1pDiFEofHta8d8E5HFxLI8rf5MHDlpSN9ZIMBTdRMM8LcrV7b9B9NzskfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgN3gM17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D223AC2BCB8;
	Tue,  5 May 2026 02:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777947599;
	bh=Aq7g1mtSp3vjGfWBplp4S+Cf9ysPmhdYG0ZOGsXHdBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tgN3gM179E7qQplg0iL9KQjn0Pz36eHe10uOJpcHrqtTzorIcvDA59+sMKqpgUXgH
	 au3Rpj8oeqb6RjEWwA7s/myQDVf6gI7VTGUD4uPokHa6M+zAECP1qjUjEkjJu650JC
	 Hor+mhblD3qoIl1aaD09m3ISga3t1NDjyZAi0Fzua2u5Y5MFkBifH2rkmy3I77jDSL
	 J8ZS8eqyo4zw6CJM9dFuVrYkdPTtCKCJziVYWSeEilh4rQpk0KlWLnoODiBsuJboyB
	 bwA28ArCdPdvKairGLL82sm/T5SFcZD7XmKpL5K3mYUH9K5KIMq6IEgo4B4MPt3oZC
	 8QHz7eFtZRMxQ==
Date: Mon, 4 May 2026 19:19:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>, Shay
 Drory <shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
 <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
 <horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Moshe Shemesh
 <moshe@nvidia.com>, Kees Cook <kees@kernel.org>, Patrisious Haddad
 <phaddad@nvidia.com>, Parav Pandit <parav@nvidia.com>, Carolina Jubran
 <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 7/7] net/mlx5: Add profile to auto-enable
 switchdev mode at device init
Message-ID: <20260504191958.657cf439@kernel.org>
In-Reply-To: <9f73036e-32a8-4060-a347-cae05269b85f@nvidia.com>
References: <20260501041633.231662-1-tariqt@nvidia.com>
	<20260501041633.231662-8-tariqt@nvidia.com>
	<421e8885-5849-4390-8956-9bc344fa0bf0@nvidia.com>
	<20260502184153.4fd8d06f@kernel.org>
	<cc01cca2-0e5d-4db2-81e4-7ea9fe525320@nvidia.com>
	<20260504182122.08efb41e@kernel.org>
	<9f73036e-32a8-4060-a347-cae05269b85f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 60B6F4C5F28
X-Rspamd-Action: no action
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19983-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 5 May 2026 05:00:15 +0300 Mark Bloch wrote:
> What I meant is that I am wary of putting too much policy into the kernel
> command line. A generic devlink level switchdev probe mode knob sounds
> reasonable to me if we keep the scope narrow. More complex policy, such as
> changing multiple defaults still seems better handled by userspace.
> 
> Would adding only switchdev/switchdev_inactive for now be acceptable?
> I will try to keep the code generic enough so it can be extended later if
> we want.

I wanted the format to be reasonably generic, but yes, just for making
future extensions possible. I don't expect us to add anything beyond 
the switchdev flag at this point. We don't have to implement the device
matching either. Just a comment in the code how we expect the full
format to look like would be enough, for whoever needs it in the future.

