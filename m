Return-Path: <linux-rdma+bounces-16116-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vZTbCRyIeWkQxgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16116-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 04:53:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCF79CDFD
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 04:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D9D430095C4
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 03:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A9832ED42;
	Wed, 28 Jan 2026 03:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6Pv9mIr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DA132E15F;
	Wed, 28 Jan 2026 03:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769572374; cv=none; b=PoEoLXhqboOBZmWdWOTLcNE4GkF48polLzP58myHnPKlvQub0xK5md3cl9TWkqhwDph/IfupZUcUQl0K6E8mSvO+imber2H32Q/qOyNilwzzSq1AFQKAUpuG67N//710gI1Slc2ArRtDQSNJHduaMTORm2lSgwigjC9uxuqxMco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769572374; c=relaxed/simple;
	bh=jUggg5iPwk0qCpwRp9Q4wouUEID54Fx5dRH+4L9Sn14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNpVG3risFWfKTgH+1MiET/AwFgwS1D8Gdd1WFr6Z4qrJ/2yQcWpSGdoTcVHcXJChXmQByEbMrfFDUi0/EHrEMGhu5XTaBXbHhKcWuFM0kIVnS6Whp6/pHhGqTpX0sSTgsBTuPybxnTCNgt0WK043ej1ycAGp4k51vH4aYcSPKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6Pv9mIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1AAC4CEF1;
	Wed, 28 Jan 2026 03:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769572374;
	bh=jUggg5iPwk0qCpwRp9Q4wouUEID54Fx5dRH+4L9Sn14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J6Pv9mIrOM9YEoysqtlcd5JyKcJyySkBX9K4xYjNiBungQMRWxjD+aP/Rb72GrKey
	 Y3KOrvqQuk7xQnTlga+OHs0XivBiLzK8SWuHNR9DTfSXhvr2pFzSa4klDbDhlVn+ae
	 VaLdP8VZ0jEAmej94ggOp6z/xxPSNjfi0MM2LKQ1gAQWpaDcSMzrBB8ObRaMIQyp39
	 y0u8BVFMgzQ/0WUMgXzIzPbvrZuF0F6tTh+8SiFcPLYqFujLRZki2g+WSRXxt4aV8L
	 I/HTB+4Y4OUSUfQbPoAsRyiw6tCE9vT3Sbsoix6gNlfvv/m58dk8xBkzYadbyxVviJ
	 pvp0CZMg0owRQ==
Date: Tue, 27 Jan 2026 19:52:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe
 Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net 3/3] net/mlx5e: Account for netdev stats in
 ndo_get_stats64
Message-ID: <20260127195252.10fa054e@kernel.org>
In-Reply-To: <1769411695-18820-4-git-send-email-tariqt@nvidia.com>
References: <1769411695-18820-1-git-send-email-tariqt@nvidia.com>
	<1769411695-18820-4-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16116-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3DCF79CDFD
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 09:14:55 +0200 Tariq Toukan wrote:
> The driver's ndo_get_stats64 callback is only reporting mlx5 counters,
> without accounting for the netdev stats, causing errors from the network
> stack to be invisible in statistics.

I cooked up a patch to fix this generically in the core... but I can't
actually find any "errors from the network stack" that are accounted
to dev->stats. Could you be more specific about the issues you were
seeing?

