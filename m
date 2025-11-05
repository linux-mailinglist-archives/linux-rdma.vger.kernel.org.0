Return-Path: <linux-rdma+bounces-14253-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCF6C35050
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 11:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2965318C1F26
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504542BE7C3;
	Wed,  5 Nov 2025 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmxNgT/4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CDD26F28D;
	Wed,  5 Nov 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337037; cv=none; b=rszjGTvk59Vp0b8mPRfzBsvQ+n4gC0aAghq+gJhsXXRKxMxaZecjBmo2lOb06tz3OTJteogqI5dbRc87ClICyfXQofYznNH8Odd8YGjq1We/tzSp+zSQzJD0BECHlrqZlAxFQZuG5jWam2Zy6MG9kr/7QvAFsDPYaftJrHpVxjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337037; c=relaxed/simple;
	bh=cn558Urw0zJ7niq2+h9AxAmTEpGDLxMeZM2fyH+C0UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ+fHuhNrb/UYtrEIsLK6b6uZli/yJRRgn2Meny5juYJXnopxTYueYAulJpA+OXdolNbuzbKoNMdneS4Hv+EetUg+YK7giMnzZ6XJ9cYbAhqPvFfS47+r8bw2VMPE8TgVBfORWucQrqlnRuMrVRCFfQNPzFsWe+lAvOYIh7WG3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmxNgT/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F260C116D0;
	Wed,  5 Nov 2025 10:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762337036;
	bh=cn558Urw0zJ7niq2+h9AxAmTEpGDLxMeZM2fyH+C0UA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmxNgT/4d2Q4io3IDj3Dw0fmiSG26pkuN+8KJW7ULQjZNH0WK/+yxbfg9ZR7m37x9
	 nblx1eSmOKRhDe9jqwHaQTQaMia2fIBEL4u/wEi+RcSJnxJKO2PSCesc2dOxF4SDY0
	 drDmvpH6OR/axl1hxpKQvJHJbwMZFaTbonhbzRftCGtaYIqhbPpuKUXjqOt0pKi9Rl
	 cFQqwTm9ncletw+T4hwAgm1d4+UeI7soM2ZEZs86ppZ/gaK5a6BZgbG1FAINdhkREz
	 QBxpxmgowZ3PEGdAh5ViDpcsU9VSTjG3NxVc632C0XtCD7WEgT123mlNQsuF2zTekS
	 NXZmv9gxnKRQg==
Date: Wed, 5 Nov 2025 10:03:52 +0000
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
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net V2 1/3] net/mlx5e: SHAMPO, Fix header mapping for 64K
 pages
Message-ID: <aQshCGafAhuvy2qt@horms.kernel.org>
References: <1762238915-1027590-1-git-send-email-tariqt@nvidia.com>
 <1762238915-1027590-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1762238915-1027590-2-git-send-email-tariqt@nvidia.com>

On Tue, Nov 04, 2025 at 08:48:33AM +0200, Tariq Toukan wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> HW-GRO is broken on mlx5 for 64K page sizes. The patch in the fixes tag
> didn't take into account larger page sizes when doing an align down
> of max_ksm_entries. For 64K page size, max_ksm_entries is 0 which will skip
> mapping header pages via WQE UMR. This breaks header-data split
> and will result in the following syndrome:
> 
> mlx5_core 0000:00:08.0 eth2: Error cqe on cqn 0x4c9, ci 0x0, qn 0x1133, opcode 0xe, syndrome 0x4, vendor syndrome 0x32
> 00000000: 00 00 00 00 04 4a 00 00 00 00 00 00 20 00 93 32
> 00000010: 55 00 00 00 fb cc 00 00 00 00 00 00 07 18 00 00
> 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 4a
> 00000030: 00 00 3b c7 93 01 32 04 00 00 00 00 00 00 bf e0
> mlx5_core 0000:00:08.0 eth2: ERR CQE on RQ: 0x1133
> 
> Furthermore, the function that fills in WQE UMRs for the headers
> (mlx5e_build_shampo_hd_umr()) only supports mapping page sizes that
> fit in a single UMR WQE.
> 
> This patch goes back to the old non-aligned max_ksm_entries value and it
> changes mlx5e_build_shampo_hd_umr() to support mapping a large page over
> multiple UMR WQEs.
> 
> This means that mlx5e_build_shampo_hd_umr() can now leave a page only
> partially mapped. The caller, mlx5e_alloc_rx_hd_mpwqe(), ensures that
> there are enough UMR WQEs to cover complete pages by working on
> ksm_entries that are multiples of MLX5E_SHAMPO_WQ_HEADER_PER_PAGE.
> 
> Fixes: 8a0ee54027b1 ("net/mlx5e: SHAMPO, Simplify UMR allocation for headers")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


