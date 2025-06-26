Return-Path: <linux-rdma+bounces-11668-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBD8AE99A0
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 11:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001BE3A7815
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 09:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444672957C2;
	Thu, 26 Jun 2025 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDSYdLmE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BFD1DF99C;
	Thu, 26 Jun 2025 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750928878; cv=none; b=kU4ibmKTOZTleavoJIeDPaKwuhkkkjhUWf1VHSb4Gxni51BrXTcOL8jxcaUxABk0PZolRvwgskRd7L3mon18IA8VoO3oL5f41sox4RjpdAlo23G658+EsJj9FvlQAjbR2Py8qTJOYbqkuWCn7RU5A3/3XOe2UE0Sdd2nU/CyP20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750928878; c=relaxed/simple;
	bh=cMWzftq2K/LlrUV3h0r8T99wGbmF4Fb85mw7RkXt0vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THYtvFL8rmPDN9OzjfYInXdnOA3wVkhFdUlPc/1H/pci7++XoFYahEUbMaVhxKeJBbduUoL0tXLqjHsC0RJxwCD2806P2bfSpq+ui4xLfuEod4BJCmdtCBGz7Smp0Rnh86hBPWydnra9YZ83rmmO8mcXwzg3qYDyKD3EayDDoVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDSYdLmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3770DC4CEEB;
	Thu, 26 Jun 2025 09:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750928877;
	bh=cMWzftq2K/LlrUV3h0r8T99wGbmF4Fb85mw7RkXt0vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sDSYdLmEptJrfoQcOx/lqGIKc0ntZ9ZIyGHxOVOEZikIHNAQvC5UebB2f0C8eiFyp
	 9lnP3lKWcG6yno50gX9t/DMcvnJMpWLpoDRKRFcgjTZdbo/agniDrU6zOXXB+EJQlg
	 3HZ4EU+T43P1D2KeP5n5xQjsVlGLly0KNMZYD4iRGSYiNN+LBeqQWdBsd0kjMA41G4
	 /Is3DJ4jzQ0n2wF/QJh9U4Zwab9kaL3tfPFagcDI5VO4X6SoZyRaOlv+TDtrlm4XL2
	 skKQHL7yigDlapSgjg3I8tI3/T3nzpvafC28WlzD0VpV8dXbR1OedHFkpH9o0U6uEW
	 k2XGo6ZcBbLQg==
Date: Thu, 26 Jun 2025 10:07:53 +0100
From: Simon Horman <horms@kernel.org>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v2] net/mlx5e: Fix error handling in RQ memory
 model registration
Message-ID: <20250626090753.GU1562@horms.kernel.org>
References: <20250626053003.45807-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626053003.45807-1-wangfushuai@baidu.com>

On Thu, Jun 26, 2025 at 01:30:03PM +0800, Fushuai Wang wrote:
> Currently when xdp_rxq_info_reg_mem_model() fails in the XSK path, the
> error handling incorrectly jumps to err_destroy_page_pool. While this
> may not cause errors, we should make it jump to the correct location.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Acked-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Thanks for rebasing.
This version applies cleanly and otherwise LGTM.

