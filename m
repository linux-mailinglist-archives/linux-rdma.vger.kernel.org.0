Return-Path: <linux-rdma+bounces-14861-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965A7C9BEE6
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Dec 2025 16:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2703A8C0C
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Dec 2025 15:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1D3255248;
	Tue,  2 Dec 2025 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OphAwwMu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CF8218AAD;
	Tue,  2 Dec 2025 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689033; cv=none; b=NeR+zVBDGzmJrdJs9KnmJxRLwjswrOt4mht7EZ0DJ+lYmAfbk08HSz6jvnS/cvqoRROQ83C2j67UVgoHXuWwo9cIUH8uhgavRnCjDd/u+6cvccJUivwtniNdRUmKs7CsHnd92Nv5sIbymML1h7BBXKeN/KtTxK4DMPH+Fdq0EVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689033; c=relaxed/simple;
	bh=uz1+HGXMT2n2/YYRdY5QbfvnvA3WvX0x3GOduJJO+vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/7VhSJxqmJAhU1W3V4n7dfZMNmUQX/bDsSyy537nlv38phnWZDW3csD3cxwdmEkVvJd2Fe+Nxgez956VTBco3WJ4e43gYqPnFjWaguH9ECUbSH+xZw/HHIQOZWNbglHvCoZ3uBPOD02M9nQNwMGzmgv7i2H8kj5fD8qORloza8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OphAwwMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C322C4CEF1;
	Tue,  2 Dec 2025 15:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764689033;
	bh=uz1+HGXMT2n2/YYRdY5QbfvnvA3WvX0x3GOduJJO+vA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OphAwwMuYQV34X/fRQfcbm/I7VOg8J7jieD0R3chXOXSgFfpO47D1EWyvnWGjbb/X
	 E3TaOBsjmsAUYgiv0hVhMCUuienKYzOpLFd3p80nrullX/fugtLvNwR5ngn7zOxkfA
	 c7ayxSexjzm8iX4qh65qOb70ifUofg9w+jip5monFPmSi26utdTQ37cvJes4fcLsMl
	 bfcP5jjLuxNTAEgI8tPiz+QQcEeXbxN6xWGd1P130z4SQrM/odyMF6xv2vzCZs+5cX
	 xQPP1KisL8aAhDahnzpGcF+ctAmAQr2ne3dhTwUPIPcEHeusKskwZ8lGsbCp+5KcpC
	 2qJNkJ55O+3Lw==
Date: Tue, 2 Dec 2025 15:23:47 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net 1/2] net/mlx5: make enable_mpesw idempotent
Message-ID: <aS8Eg4I2B2b6rJBU@horms.kernel.org>
References: <1764602008-1334866-1-git-send-email-tariqt@nvidia.com>
 <1764602008-1334866-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1764602008-1334866-2-git-send-email-tariqt@nvidia.com>

On Mon, Dec 01, 2025 at 05:13:27PM +0200, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> The enable_mpesw() function returns -EINVAL if ldev->mode is not
> MLX5_LAG_MODE_NONE. This means attempting to enable MPESW mode when it's
> already enabled will fail. In contrast, disable_mpesw() properly checks
> if the mode is MLX5_LAG_MODE_MPESW before proceeding, making it
> naturally idempotent and safe to call multiple times.
> 
> Fix enable_mpesw() to return success if mpesw is already enabled.
> 
> Fixes: a32327a3a02c ("net/mlx5: Lag, Control MultiPort E-Switch single FDB mode")
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Shay Drori <shayd@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


