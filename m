Return-Path: <linux-rdma+bounces-16764-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JC1NyWIjGmHqgAAu9opvQ
	(envelope-from <linux-rdma+bounces-16764-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 14:46:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E10124EAD
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 14:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAE77301948A
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 13:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACA92BD5AD;
	Wed, 11 Feb 2026 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="EBKs6+gY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBBD2F49F0;
	Wed, 11 Feb 2026 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770817510; cv=none; b=RAaulUui8OGu5dSsrg64NfHumOIlTfs4FFITjKV3rduZeqA5/gN2yqcIJoUkBr/uKsmxfh9u+/0zOIcd/zKkkWP41p+TTih7454t715SHPdX9UYu0vHdVjv+UE3cQwwpqmDaMVtw1DvgSO5NoXws4VslDX3dNJFFAAcv7SWCakk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770817510; c=relaxed/simple;
	bh=/Q5p4Lscy9lUSPNGsN8vo3iiOEj7o8Bpkr6wiO5IUvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpaYiGdIDz7vtnKZIRVTD6Rp/bih030BN5uvPd5zMfDTiSGb2Ehlp4XPUrAConInZlcidquAJ3jjEL0d9+3GijMiNPH1t2A6r22rFhcY8391Iqw29TRihdoVMy5LUBAgjTPV2Z0pI+HWyWQoP3jrfdVPLeLkxYO0cNIUxIsOgEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=EBKs6+gY; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JB6k4/RrNjPlMllxDC6Oj8qJK0lUnmvgjQsV5ZUjKFo=; b=EBKs6+gY4blppUVhmp6BItThEj
	8DCdjedjl+MUJ2PXqR5G+6YfLlTD231eAyZ7e6SwT/JAiRxNzpbwNsrSo2V7lcK6zQ9VAmxOkLtrG
	V5FFQwzO4pOrG7P/r+Rn8lE0OWGVHKQ4DMt7sc1tNlJcrC6pFqoYourFpg2xBSkyBOrseYV9Llep3
	JEMRPRvSDsau0Jl2UqJyO2K5G+7yWmfmTBicoV09Kkp/ETAK5btDJvElb3iLuUi58fSQaIg0/BBDH
	BL9oDqBQ0k+u+7uWJxrIzBbHLfmqkrvua7Jx+XGwjpOJfsFACphRBMvZCQ20MWp+bKOxLUPyqQo8F
	8L78mVpg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vqAWU-00B4bR-Sx; Wed, 11 Feb 2026 13:44:55 +0000
Date: Wed, 11 Feb 2026 05:44:48 -0800
From: Breno Leitao <leitao@debian.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Amir Vadai <amirv@mellanox.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, dcostantino@meta.com, 
	rneu@meta.com, kernel-team@meta.com
Subject: Re: [PATCH net] net/mlx5e: Skip NAPI polling when PCI channel is
 offline
Message-ID: <aYyHNGBPu0dEIEzS@gmail.com>
References: <20260209-mlx5_iommu-v1-1-b17ae501aeb2@debian.org>
 <09a77964-37bf-4b3c-bfa9-8939eb7761ab@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09a77964-37bf-4b3c-bfa9-8939eb7761ab@gmail.com>
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16764-lists,linux-rdma=lfdr.de];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03E10124EAD
X-Rspamd-Action: no action

Hello Tariq,

On Wed, Feb 11, 2026 at 01:26:35PM +0200, Tariq Toukan wrote:
> On 09/02/2026 20:01, Breno Leitao wrote:
> > When a PCI error (e.g. AER error or DPC containment) marks the PCI
> > channel as frozen or permanently failed, the IOMMU mappings for the
> > device may already be torn down. If mlx5e_napi_poll() continues
> > processing CQEs in this state, every call to dma_unmap_page() triggers
> > a WARN_ON in iommu_dma_unmap_phys().
> > 
> > In a real-world crash scenario on an NVIDIA Grace (ARM64) platform,
> > a DPC event froze the PCI channel and the mlx5 NAPI poll continued
> > processing error CQEs, calling dma_unmap for each pending WQE. Here is
> > an example:
> > 
> > The DPC event on port 0007:00:00.0 fires and eth1 (on 0017:01:00.0) starts
> > seeing error CQEs almost immediately:
> > 
> >      pcieport 0007:00:00.0: DPC: containment event, status:0x2009
> >      mlx5_core 0017:01:00.0 eth1: Error cqe on cqn 0x54e, ci 0xb06, ...
> > 
> > The WARN_ON storm begins ~0.4s later and repeats for every pending WQE:
> > 
> >      WARNING: CPU: 32 PID: 0 at drivers/iommu/dma-iommu.c:1237 iommu_dma_unmap_phys
> >      Call trace:
> >       iommu_dma_unmap_phys+0xd4/0xe0
> >       mlx5e_tx_wi_dma_unmap+0xb4/0xf0
> >       mlx5e_poll_tx_cq+0x14c/0x438
> >       mlx5e_napi_poll+0x6c/0x5e0
> >       net_rx_action+0x160/0x5c0
> >       handle_softirqs+0xe8/0x320
> >       run_ksoftirqd+0x30/0x58
> > 
> > After 23 seconds of WARN_ON() storm, the watchdog fires:
> > 
> >      watchdog: BUG: soft lockup - CPU#32 stuck for 23s! [ksoftirqd/32:179]
> >      Kernel panic - not syncing: softlockup: hung tasks
> > 
> > Each unmap hit the WARN_ON in the IOMMU layer, printing a full stack
> > trace. With dozens of pending WQEs, this created a storm of WARN_ON
> > dumps in softirq context that monopolized the CPU for over 23 seconds,
> > triggering a soft lockup panic.
...
> You're introducing an interesting problem, but I am not convinced by this
> solution approach.
> 
> Why would the driver perform this check if it doesn't guarantee prevention
> of invalid access? It only "allows one napi cycle", which happen to be good
> enough to prevent the soft lockup in your case.
> 
> What if a napi cycle is configured with larger budget?

Very good point. In this case, we will still see some WARN_ON() in DMA, and the
patch might eventually not help much if the AER hits mid-NAPI and there is
still a long budget remaining.

> If the problem is that the WARN_ON is being called at a high rate, then it
> should be rate-limited.

That would be a solution as well, and I am happy to pursue it, if that one is
more appropriate

Thanks for reviewing it,
--breno

