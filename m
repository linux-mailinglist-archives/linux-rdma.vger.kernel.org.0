Return-Path: <linux-rdma+bounces-17152-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIbwM6/hnmmCXgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17152-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 12:49:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 339E6196DD6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 12:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 667F2304FF9E
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 11:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811693A9DB1;
	Wed, 25 Feb 2026 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7uVi0dK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431C028C854;
	Wed, 25 Feb 2026 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772020040; cv=none; b=Lf9UjI5TYMazXGBJ+PmFolZmiyfbzKOFptgG4Qu/WnO1tuF504y6Fkhsod/TmlZMM2yxbfZsVL8SAbmN3KWiYJooS9GkVeonQQzb4yp5wuhwf4KadPOTYDNQMotkvcPnf/F8NtxCtr5cZzxbfrp+0dwTFM7kQV5TrUPUMTVE8jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772020040; c=relaxed/simple;
	bh=SnXGJnTrEuLwTL+SfTgHDgMsC/M1iJfW8DD5Wj/SUOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcW+VdxMwTAYgwq/+hzx4vE5lu7ROWvBPDr1ho7lRdThoPT8/h/MOMXn7oJy2vzRs4kzsjuYo5rDVyI3+CNRi/AY/NU3euobCi2x/1PZKog4XDmWmiba5vtPpLxWt59vGkXYxvC7rxUnvZ7HoZy/TVv/NbaLg3y2troArBqi76k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7uVi0dK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E65C116D0;
	Wed, 25 Feb 2026 11:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772020039;
	bh=SnXGJnTrEuLwTL+SfTgHDgMsC/M1iJfW8DD5Wj/SUOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7uVi0dK4F2jMpMH5VnBaT44RQf9qjplGsOs0SYVCw0aRPqZcCL3F+rilfv/EninI
	 yDVy4Y4XQQHF2w5RwkXccFV0pphMsJmBfjBK1kv+D7AglGSAm0TZn7uh271umFJJoM
	 Inf4mHwIfKSyw6NTD0DUAk4CFyHBcCjebr/j7nVLuFBq5a+z4EYahZ8nRrue7HTLEb
	 Oq83cE2zwPsNNG/YIW33IzLOT8xupP9rf3ByKQ68W8mHJfzVCpgltzPH03UCVSJ5sp
	 yjyQFlnciY0dIpLEoVa2zm4Lzz75tqwcQ8we64bn558/w3A8063FYEaR1uax62g8fm
	 LgyPIwqrzFUaw==
Date: Wed, 25 Feb 2026 13:47:16 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Edward Srouji <edwards@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Michael Guralnik <michaelgur@nvidia.com>,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH rdma-next v3 00/11] RDMA/core: Introduce FRMR pools
 infrastructure
Message-ID: <20260225114716.GD9541@unreal>
References: <20260202-frmr_pools-v3-0-b8405ed9deba@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202-frmr_pools-v3-0-b8405ed9deba@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17152-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 339E6196DD6
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 05:59:52PM +0200, Edward Srouji wrote:
> From Michael:
> 
> This patch series introduces a new FRMR (Fast Registration Memory Region)
> pool infrastructure for the RDMA core subsystem. The goal is to provide
> efficient management and allow reuse of MRs (Memory Regions) for RDMA
> device drivers.
> 
> Background
> ==========
> 
> Memory registration and deregistration can be a significant bottleneck in
> RDMA applications that need to register memory regions dynamically in
> their data path or must re-register memory on application restart.
> Repeatedly allocating and freeing these resources introduces overhead,
> particularly in high-throughput or latency-sensitive environments where
> memory regions are frequently cycled. Notably, the mlx5_ib driver has
> already adopted memory registration reuse mechanisms and has demonstrated
> notable performance improvements as a result.
> 
> FRMR pools will store handles of the reusable objects, giving drivers
> the flexibility to choose what to store (e.g: pointers or indexes).
> Device driver integration requires the ability to modify the hardware
> objects underlying MRs when reusing FRMR handles, allowing the update
> of pre-allocated handles to fit the parameters of requested MR
> registrations. The FRMR pools manage memory region handles with respect
> to attributes that cannot be changed after allocation such as access flags,
> ATS capabilities, vendor keys, and DMA block size so each pool is uniquely
> characterized by these non-modifiable attributes.
> This ensures compatibility and correctness while allowing drivers
> flexibility in managing other aspects of the MR lifecycle.
> 
> Solution Overview
> =================
> 
> This patch series introduces a centralized, per-device FRMR pooling
> infrastructure that provides:
> 
> 1. Pool Organization: Uses an RB-tree to organize pools by FRMR
>    characteristics (ATS support, access flags, vendor-specific keys,
>    and DMA block count). This allows efficient lookup and reuse of
>    compatible FRMR handles.
> 
> 2. Dynamic Allocation: Pools grow dynamically on demand when no cached
>    handles are available, ensuring optimal memory usage without
>    sacrificing performance.
> 
> 3. Aging Mechanism: Implements an aging system. Unused handles are
>    gradually moved to the freed after a configurable aging period
>    (default: 60 seconds), preventing memory bloat during idle periods.
> 
> 4. Pinned Handles: Supports pinning a minimum number of handles per
>    pool to maintain performance for latency-sensitive workloads, avoiding
>    allocation overhead on critical paths.
> 
> 5. Driver Flexibility: Provides a callback-based interface
>    (ib_frmr_pool_ops) that allows drivers to implement their own FRMR
>    creation/destruction logic while leveraging the common pooling
>    infrastructure.
> 
> API
> ===
> 
> The infrastructure exposes the following APIs:
> 
> - ib_frmr_pools_init(): Initialize FRMR pools for a device
> - ib_frmr_pools_cleanup(): Clean up all pools for a device
> - ib_frmr_pool_pop(): Get an FRMR handle from the pool
> - ib_frmr_pool_push(): Return an FRMR handle to the pool
> - ib_frmr_pools_set_aging_period(): Configure aging period
> - ib_frmr_pools_set_pinned(): Set minimum pinned handles per pool
> 
> mlx5_ib
> =======
> 
> The partial control and visability we had only over the 'persistent'
> cache entries through debugfs is replaced by the netlink FRMR API that
> allows showing and setting properties of all available pools.
> This series also changes the default behavior MR cache had for PFs
> (Physical Functions) by dropping the pre-allocation of MKEYs that was
> costing 100MB of memory per PF and slowing down the loading and
> unloading of the driver.
> 
> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> ---
> Changes in v3:
> - Use rbtree helpers for pool find and find_add operations.
> - Use cmp_int() for pool key comparison.
> - Make key comparison inline.
> - Link to v2: https://lore.kernel.org/r/20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com
> 
> Changes in v2:
> - Fix stack size warning in netlink set_pinned flow.
> - Add commit to move async command context init and cleanup out of MR
>   cache logic.
> - Add enforcement of access flags in set_pinned flow and enforce used
>   bits in vendor specific fields to ensure old kernels fail if any
>   unknown parameter is passed.
> - Add an option to expose kernel-internal pools through netlink.
> - Link to v1: https://lore.kernel.org/r/20251116-frmr_pools-v1-0-5eb3c8f5c9c4@nvidia.com
> 
> ---
> Chiara Meiohas (1):
>       RDMA/mlx5: Move device async_ctx initialization
> 
> Michael Guralnik (10):
>       IB/core: Introduce FRMR pools
>       RDMA/core: Add aging to FRMR pools
>       RDMA/core: Add FRMR pools statistics
>       RDMA/core: Add pinned handles to FRMR pools
>       RDMA/mlx5: Switch from MR cache to FRMR pools
>       net/mlx5: Drop MR cache related code
>       RDMA/nldev: Add command to get FRMR pools
>       RDMA/core: Add netlink command to modify FRMR aging
>       RDMA/nldev: Add command to set pinned FRMR handles
>       RDMA/nldev: Expose kernel-internal FRMR pools in netlink


There is a need to rebase this series, it doesn't apply.

Thanks

