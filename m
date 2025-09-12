Return-Path: <linux-rdma+bounces-13318-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D17B55085
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 16:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A55D1D645E3
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 14:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B8531280F;
	Fri, 12 Sep 2025 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGU8apuL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F0D311C30;
	Fri, 12 Sep 2025 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686308; cv=none; b=AZ8NjKJHzl9FTxSAeyJZdvKjJQNsqDwp1ekznh5iXwG3GxMMtkFsNE1rYYuAfr4a3Oia9eJYCw6vgrkH7O8H3ogMh3hF44tAs5e0eUM7hiVk8K7d91WZChPzc8BKaZjD8T5cWaLF/wD7qSQWqZJPAZUhqZX9S4j2s3fsvGSpv2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686308; c=relaxed/simple;
	bh=M13/y5r8QuZwx9IiU2y9TDTdSu8nXSThqvTuodKXRvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOPXHpBniLFdUavxPlOMDnfVzbcLbgQEDmvKkRFaITu8vW52MFT79250CAwch1gzbnaGDtNijWGH023x5L010FWhzdQk0KAEOQ+reR+THlsz8SdGp0ws/3KAz+Hsaxf015GGAm+DC6NoSwQZyT8XXCSSngM6L34IcTcT0Jd3xrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGU8apuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307CBC4CEF9;
	Fri, 12 Sep 2025 14:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757686308;
	bh=M13/y5r8QuZwx9IiU2y9TDTdSu8nXSThqvTuodKXRvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGU8apuL0dtG/oidnABZntsB+3pl9RA1vgif1ZGLAq75aSF2Brfd3ICqRu3BE8d/c
	 N0CG24vEtOOldJr43XjFG9sE7BATPxDDVt9xnA88fGTx5IeAiO4Pc2n9uk45+Bp3hk
	 tUvAkoinOJJvwZ0uQWfLJ4EK6tW3cIVljS8RKGo+Ps2zvsNYm+A1qEshlA7fnx2zcC
	 u/RLtPv9jyNQLOH6He+zEMu6qkuuz2yt8zsjdrhB99Ab4eDg0dmshfvPgTPSrhoaEf
	 V2URoXTV8QAg6qNIE8hTWb84dNdmIDh5K1ROLCbTzgiLMRM0+WBHwqjZdehhI14+CC
	 Ld/xKKQalwslg==
Date: Fri, 12 Sep 2025 15:11:43 +0100
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
	Parav Pandit <parav@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH net-next 1/4] net/mlx5: Refactor devcom to use match
 attributes
Message-ID: <20250912141143.GF30363@horms.kernel.org>
References: <1757572267-601785-1-git-send-email-tariqt@nvidia.com>
 <1757572267-601785-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1757572267-601785-2-git-send-email-tariqt@nvidia.com>

On Thu, Sep 11, 2025 at 09:31:04AM +0300, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Refactor the devcom interface to use a match attribute structure instead
> of passing raw keys. This change lays the groundwork for extending devcom
> matching logic with additional fields like net namespace, improving its
> flexibility and robustness.
> 
> No functional changes.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


