Return-Path: <linux-rdma+bounces-18447-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFY2Ego2vWkN7wIAu9opvQ
	(envelope-from <linux-rdma+bounces-18447-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 12:56:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B96152D9D86
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 12:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 654AF301A7D4
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 11:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FCD3AA1B0;
	Fri, 20 Mar 2026 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdox1X3X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561136EA99;
	Fri, 20 Mar 2026 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007810; cv=none; b=rEX+ipcutgqR2t2qaXGLB3FiK1pkCwecTwXr08x4TO7304NccyXo2wTQcgQmpTkXlW/mH9myLXr2qCWenEbOdt5+EmiNlC49xiriXnNMtd4ayrPDnjRDI35JW4UJGRU1ZQ7xzZXzCgBb02RejjBOUfictLKnmgbFYic3qsf7GXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007810; c=relaxed/simple;
	bh=NByveJIMTOGWR8SYIDSI/wNbl0U2fDVDmDT1nEIR88g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAYjF7yz8rENDr3UGJNbd/+8Os1DNPYfUAkjA+2LVAoT80q22FSD/qttRUEg657nAQ2Pdl2651gILZo0cV3G4XdVSFfqex3TnkFCQ9XE5dy0+l2MyVbfuO5gPJJmNN8eH87btVme6CdPnsrZ/F8K2VkUrFNVO//z9UDI6yI77K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdox1X3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAFEC4CEF7;
	Fri, 20 Mar 2026 11:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774007810;
	bh=NByveJIMTOGWR8SYIDSI/wNbl0U2fDVDmDT1nEIR88g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdox1X3XI/XTc2+HitONJ4zG2JCCCbqZXGC0cZxx2Q465B9MBqpXw/f3y1RxXBA11
	 nLKdHmCDjbRYZ9+kT/Ffrs29erK9QYrtY8x8bss422Q2sPEhkpxV+eVtgNGcZXn+0Y
	 vpiOyIVRr2thikRXFC8pyF00sGxmpwMJ6p6DuXAJC7y3eyO1uGeKerj8Xp6VMoTcJ9
	 LFfqfKUydZLxUGNjJzMtL/gPPuaqmjR75oklK+g8iQq8aY0yRn5OX1O1PGwTPQ/6Na
	 HjKwO6MbctSzdctXjspGwZ3AhFcfuS14UiILubXxXwNl96nJgWGp/V82mIUdhmc0ta
	 U43yNevnG9Rjw==
Date: Fri, 20 Mar 2026 11:56:45 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 0/3] net/mlx5e: Improve channel creation time
 via fast-path MKEY initialization
Message-ID: <20260320115645.GE1753385@horms.kernel.org>
References: <20260319074338.24265-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319074338.24265-1-tariqt@nvidia.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-18447-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B96152D9D86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 09:43:35AM +0200, Tariq Toukan wrote:
> Hi,
> 
> This series improves channel creation time by moving per-channel MKEY
> initialization from a slow-path FW command to a fast-path UMR WQE.
> 
> The benefit becomes more significant with larger MKEYs and a higher
> number of channels.
> 
> On my setup with the maximum configuration (248 channels, MTU 9000,
> RX/TX ring size 8K), the "interface up" operation is 2.081 seconds
> faster:
> 
> Before: 5.618 seconds
> After:  3.537 seconds
> 
> This corresponds to ~8.4 msec saved per channel.
> 
> Regards,
> Tariq
> 
> Tariq Toukan (3):
>   net/mlx5e: Move RX MPWQE slowpath fields into a separate struct
>   net/mlx5e: RX, Pre-calculate pad value in MPWQE
>   net/mlx5e: Speed up channel creation by initializing MKEY entries via
>     UMR WQE

Thanks,

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>


