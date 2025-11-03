Return-Path: <linux-rdma+bounces-14207-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F01D7C2C4C2
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 15:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81A124E3752
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 13:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DA430E852;
	Mon,  3 Nov 2025 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3sgFmY1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EED272801;
	Mon,  3 Nov 2025 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178333; cv=none; b=V7Xp3iz1kjQ1uitajY1tUZAvxaOEiLROiaYNRtVixigpFXCUoSxyisLKN5qGubVPlL+z/d0SoQAZnzHEgDceg8qaQvLwHx7wZua7Ks23MN5BkTy4Y/sC0RDYc86CVdL8dyAh6GkKI7dA+I5f1PoCPrC3IMG1gMfMtRbsygy1sb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178333; c=relaxed/simple;
	bh=CVpW39VvM+rcZYs4RPQFrCUx5jX1/vW3YR+Et2rrxZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojZ04gsC/F2S7Dw1WHIC2j9ZOcgsIaoAvCcxL1VMBsfbtxTVxMFpmwyHw4fdflVxfzodNfhJkGhRveCReUMnBA6DcNRLJVJF0GzvAkHnHdjW3u3cS6VTn2BZzlguyfjCTDJAs2yomvdyFaVyky+JinvTw/WafeMSWHR5MtdKPac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3sgFmY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C43C4CEFD;
	Mon,  3 Nov 2025 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762178329;
	bh=CVpW39VvM+rcZYs4RPQFrCUx5jX1/vW3YR+Et2rrxZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b3sgFmY1Wn1wg9ie1Q+cm6HjMRgl5g1p5sYoCMJIHNUY/S1O+m/QtoikwPbHVms7j
	 Qn/yoGtu25LJqFnuOQBhggtDTIeAdo0lBsSJ9DedQoWlvFIGWoC9Ml7pIBoRp8kJAv
	 7QTKnsWi3VEVlO0niNPazhoDX2Xn3WyDaBKmYD/N+zsSn8Da9C06H3PEPVWKbuEhGO
	 r7K57o4r/5rC+78PXIaAkS7OJe7EDKwWC76rNLiUaTc+gpAuHKpnWFfyidT+GSZmj6
	 d1O/7r6QQdROsU1ClK7CqFHTOMiHyzRWwIA17BD5q7c80N0wbTm4w+GlI3MsZB1R7E
	 XHakMsEgF1zEA==
Date: Mon, 3 Nov 2025 13:58:44 +0000
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
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next V2 5/7] net/mlx5e: Do not re-apply TIR loopback
 configuration if not necessary
Message-ID: <aQi1FCkvCfaJtdtp@horms.kernel.org>
References: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
 <1761831159-1013140-6-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761831159-1013140-6-git-send-email-tariqt@nvidia.com>

On Thu, Oct 30, 2025 at 03:32:37PM +0200, Tariq Toukan wrote:
> On old firmware, (tis_tir_td_order=0), TIR of a transport domain should
> either be created after all SQs of the same domain, or TIR.self_lb_en
> should be reapplied using MODIFY_TIR, for self loopback filtering to
> function correctly.
> 
> This is not necessary anymnore on new FW (tis_tir_td_order=1), thus
> there's no need for calling modify_tir operations after creating a new
> set of SQs to maintain the self loopback prevention functional.
> 
> Skip these operations.
> 
> This saves O(max_num_channels) MODIFY_TIR firmware commands in
> operations like interface up or channels configuration change.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


