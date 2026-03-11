Return-Path: <linux-rdma+bounces-17930-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCDTDDTfsGkuoAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17930-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 04:19:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C880925B5AE
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 04:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7267330B7709
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 03:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6112630214B;
	Wed, 11 Mar 2026 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBnPQKw6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF3E2F0661;
	Wed, 11 Mar 2026 03:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773199134; cv=none; b=g4l01ZPo28hCi0IzYYkN/tdk65ONXo2MfBDL7ZkkpzDwsiqhTMjsMJhDvHdvuE6ytw9k3wxDpda74eGioSrOyEZIRz/zWNU5jMA9LSXH7NkkwvOtp7bvF980dWRGDT+jku7QTRv59lGhjsfM3aoQYTen3GSxurOYxgvrLoFZVgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773199134; c=relaxed/simple;
	bh=cpMshIqCnOsCnexGAqml6/AWpOS3/RAmsy7Y3dDFJJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jj7A8TsgRRJVwnnaNcbCWc3ddLgFewblvh4V825T+bIDGZpoljyrjUhPXtHKzuORkAX0ptonT51A9DXmdRJ4m7b7BhOez1f4rpAkOqHNRK57NsisiWRkXNeGAcb3uU+pA08a8UMPG2tDvqWK8tvnJ8jK7OSJJLa4gq7G3nxoMO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBnPQKw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E135C19423;
	Wed, 11 Mar 2026 03:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773199133;
	bh=cpMshIqCnOsCnexGAqml6/AWpOS3/RAmsy7Y3dDFJJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vBnPQKw6EGWhweMuAAMkbGIKeALpcDJHwjMOLVULYyVIKtmBK1BqEfpWNEASyWYNX
	 Nw0eCf9IpFc/x2C8T4UE7oSZcVUKCXKS5cI+ZN1hLHbJx48sowvCQcjiwdqXkUWRpg
	 0VskY5kEYlx1I0Gv9vYLcEfMW6xgQ1Z66K7daBQ9DJFHS0MEoyE6ht9RjLqM5kX4MO
	 7hcw6W2NBjH3uYf3Ba/11Pm5mH8bsVyd+1n1TTAuQc74v2tzCb6IKzHVHmts9oMdqd
	 7IKOlQJHzeEgMzDXm0c+hP+vrkJl+526P2nMNUIUVDOlI88Rb7BvX+7GyFwsNU2pZg
	 MlJ98nEiy4H/Q==
Date: Tue, 10 Mar 2026 20:18:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, "Mark Bloch"
 <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe
 Shemesh <moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 3/5] net/mlx5e: Report TX csum netdev stats
Message-ID: <20260310201852.0d5d1712@kernel.org>
In-Reply-To: <20260309095519.1854805-4-tariqt@nvidia.com>
References: <20260309095519.1854805-1-tariqt@nvidia.com>
	<20260309095519.1854805-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C880925B5AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17930-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 9 Mar 2026 11:55:17 +0200 Tariq Toukan wrote:
> Report TX checksum statistics via the netdev queue stats API by mapping
> the existing csum_none and csum_partial counters to the csum_none and
> needs_csum fields.

      -
        name: tx-needs-csum
        doc: |
          Number of packets that required the device to calculate the checksum.
          This counter includes the number of GSO wire packets for which device
          calculated the L4 checksum.
        type: uint

Looking at drivers currently implementing this it seems like the idea
was to avoid having to increment two counters in the drivers, given
that TSO always implies csum offload

