Return-Path: <linux-rdma+bounces-14255-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC2AC35069
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 11:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F81F4F4A0F
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8080F2EA171;
	Wed,  5 Nov 2025 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2AmnFIt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3137424A046;
	Wed,  5 Nov 2025 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337063; cv=none; b=TT7oxa5MrDz348TYEaEERtdaRFbt0JJStXJyrL73CefbSmProinwDtPSLl0mP8g64RagammuUn9I0NNhh40G/KpoQT+pJeQdN1Qa6j8N1XwF3f+QZ9BQYm0JBgirY/jg+KmoH3pEilFFGVe+FTdtzJcAImkD4k4omH6tMpfg4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337063; c=relaxed/simple;
	bh=LV3t/IbA2SVXHaJRkMqjkj3Vdf3L+S6/Be9lXX1Puy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbDpyKhN3XFc3t5vgf+/SWIyRTUqUajAuy0U1urT965Q7al+9aQunQeIQERc21ndRZT//6Of9BcIUAKfAYiI1vbhn7yPHK4u9p/y/JJSlClNUleZGn0OYfuVAySVxxlq13bqvNiBW2ti0DZ6DQAXRBwkd6oaHh4J00AWGWPtfjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2AmnFIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0218C116D0;
	Wed,  5 Nov 2025 10:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762337062;
	bh=LV3t/IbA2SVXHaJRkMqjkj3Vdf3L+S6/Be9lXX1Puy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2AmnFIt05I4ahJ0WeLdgJvZjP69WlHitoml9mqrsQoZ+EboW6pTCx+v/kRoNG/jJ
	 TeEV0m+NPo8ECIhr9PmgPKm0ZmW0uvuG1aNOCnymRwwdRzp6zixEKDUpMLY55FvU/q
	 pc/a//r0CwUk7OMfbsunQHxNPFAfDLDpuNL12+XP7n4xr3NnRphlV61BvSr2QNAfqd
	 674MqeN7p2GuFNIzj5YdIw5DxzjE47ikwOezjh29gI27Lb3XAeaS2n7+FnKNFIn39q
	 Bsv5PN+n8pY9928YCZdqnDQ4efwV7STXscbCT+HLcydmjLIbscMzHI5zd8uq1oyIYP
	 BUoTIlgLmS4bA==
Date: Wed, 5 Nov 2025 10:04:17 +0000
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
Subject: Re: [PATCH net V2 3/3] net/mlx5e: SHAMPO, Fix header formulas for
 higher MTUs and 64K pages
Message-ID: <aQshIZ88cxfSSNPo@horms.kernel.org>
References: <1762238915-1027590-1-git-send-email-tariqt@nvidia.com>
 <1762238915-1027590-4-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1762238915-1027590-4-git-send-email-tariqt@nvidia.com>

On Tue, Nov 04, 2025 at 08:48:35AM +0200, Tariq Toukan wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> The MLX5E_SHAMPO_WQ_HEADER_PER_PAGE and
> MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE macros are used directly in
> several places under the assumption that there will always be more
> headers per WQE than headers per page. However, this assumption doesn't
> hold for 64K page sizes and higher MTUs (> 4K). This can be first
> observed during header page allocation: ksm_entries will become 0 during
> alignment to MLX5E_SHAMPO_WQ_HEADER_PER_PAGE.
> 
> This patch introduces 2 additional members to the mlx5e_shampo_hd struct
> which are meant to be used instead of the macrose mentioned above.
> When the number of headers per WQE goes below
> MLX5E_SHAMPO_WQ_HEADER_PER_PAGE, clamp the number of headers per
> page and expand the header size accordingly so that the headers
> for one WQE cover a full page.
> 
> All the formulas are adapted to use these two new members.
> 
> Fixes: 945ca432bfd0 ("net/mlx5e: SHAMPO, Drop info array")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


