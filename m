Return-Path: <linux-rdma+bounces-13382-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3228B58528
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 21:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3251B2090A
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 19:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CE8280A4B;
	Mon, 15 Sep 2025 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcTSW0H5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA9D27E066;
	Mon, 15 Sep 2025 19:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963643; cv=none; b=sE9hcu17p07PyfBTBIDCG2DbqsxvXdCd6UBBKzFPvEPdRvSi1sVOAY/jJD/wyZe1ZH5FDkQaHU9TWcnCg8yKHXCfHWNnZnPUG3nGK5MnTBBzHYq37Pbpi6DJ2C3ZyHwec9dEcoLt+X0Ux1x0XQFLpPvvg5l/G6zQEUtafSv4OWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963643; c=relaxed/simple;
	bh=Z4rGHD9lKRtFNDATlHwnGV7grM1B5UnxeWcJtuz3cyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXmTqDkLjIbjf8djpcRBxjphw4RYnMQZY50StLCNxKnVTVSHbA90OP0YzCrdQfgTJj4idG3PvEtAqFI8b7C7pi4AMbjAB63kBXAhJYoKmIIINWTlggmpFxTVN2f51wmHX5qkNdm9pfJ+U13dyOaFCNpSQcKy8FOq3KW6ZovbAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcTSW0H5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A09C4CEF1;
	Mon, 15 Sep 2025 19:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757963642;
	bh=Z4rGHD9lKRtFNDATlHwnGV7grM1B5UnxeWcJtuz3cyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UcTSW0H5j+xzW1zoofZWrt3nPAG1lPZa9gHI/dAwF23bC9erF1hyHKCofioV1h7Xf
	 BckL1PgTroVSm1llGAsOc4L42h6p7Hy80zHgLXIDRr55XObOuSxcm7aXdxQEBaoBvW
	 CmyKqMwFwHhRte7UDPAUJdYLOg/eX4kn3rNcLOmGOWaYDYY2PtYC+E/ekqrdSl2Zi8
	 t/FuzAmbe5Fz/P21lOLJ1xCezXFTXuFJVbgNP5dCDf9+dPEtJ8JVhmiiBBTey95eb3
	 l5CCPzGi8xm1UTqFUl+pv93hbdKou6xftaWhh5rXJoivstXusRgl/HUjWBXKZpyccf
	 utsZB3DPCyMHg==
Date: Mon, 15 Sep 2025 20:13:56 +0100
From: Simon Horman <horms@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Bloch <mbloch@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCH mlx5-next 2/3] net/mlx5: Refactor MACsec WQE metadata
 shifts
Message-ID: <20250915191356.GW224143@horms.kernel.org>
References: <1757574619-604874-1-git-send-email-tariqt@nvidia.com>
 <1757574619-604874-3-git-send-email-tariqt@nvidia.com>
 <20250912154926.GG30363@horms.kernel.org>
 <153b22be-3cd4-4ae8-9091-923e4e0018f2@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <153b22be-3cd4-4ae8-9091-923e4e0018f2@nvidia.com>

On Mon, Sep 15, 2025 at 09:23:04AM +0300, Carolina Jubran wrote:
> 
> On 12/09/2025 18:49, Simon Horman wrote:
> > On Thu, Sep 11, 2025 at 10:10:18AM +0300, Tariq Toukan wrote:
> > > From: Carolina Jubran <cjubran@nvidia.com>

...

> Hi Simon,
> 
> Thanks for the suggestion!
> 
> The goal with this patch was to clearly show which bits are used for
> each feature in the metadata field, rather than compressing everything
> under a single mask. That’s why we chose to explicitly define MACsec,
> FS_ID_MASK, and the shift separately. This way, its easy to see at a
> glance that MACsec uses bit 1, and bits 2–5 are reserved for the fs_id.
> 
> Using FIELD_PREP can work, but it hides the bit layout behind one
> mask, which makes it harder to reason about when multiple features
> share the same 32-bit field. We wanted to keep things more readable
> and maintainable by showing the bit assignments explicitly.
> 
> Carolina

Hi Carolina.

Thanks for your response.
If this is a deliberate choice then I'm happy with the current approach.

Reviewed-by: Simon Horman <horms@kernel.org>


