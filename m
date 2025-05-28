Return-Path: <linux-rdma+bounces-10857-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4705AAC7124
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 20:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224681C043B1
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 18:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6EC28E5EF;
	Wed, 28 May 2025 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJxgvlwy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6D386323;
	Wed, 28 May 2025 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748457895; cv=none; b=mlUt5mbAOoWGP+QuShIqZDphZ4fXCS7XM8uFDfgXSYslstyAcnmUyXfRzXP/pb9ntL4aa98kr7xoxzlMJh7X+B7CFUOqgPsud/dlmbP/GZGrGvF78+OwLoPF2wXmPmckAA5DwbnistUXnCJl6/pLWkqnudDebXcFKIi/tynWCQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748457895; c=relaxed/simple;
	bh=ts9YHg52OABzcl4g4CBc8ly88viOrJ+JoytxCLhl/CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzqNyaKoeat01vNPYe5OesPA5Q6rwOr9IwPcSfXzsTns7i+lhTifYFvGWSOxEjRnOlU2CfLMkMJ5U8ON9joGKTU+e7Qk2WUi9URaU11JUJ8mna4lqi6Kt98DpN/9Ft8u0CHuXJ2RH6ziY35w8ILibf3ghEddK46OeYeu+s8T66k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJxgvlwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D201C4CEEB;
	Wed, 28 May 2025 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748457894;
	bh=ts9YHg52OABzcl4g4CBc8ly88viOrJ+JoytxCLhl/CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eJxgvlwydX2UTDyYka8cCrx4LFO8vv3F+kragSmhsVVLVbTZB7MOuKppbrHSPIhCW
	 UtEl+Fjzg3wJm2tiEWOlsgin9Pzr9xfVltIico7RSNnYJBWk4TbC8VCMRJxcDDE04y
	 1/TRMCW5YhD1zGOgXO0Wqy4hl0UCW1qB0xjvrrMZWZ6FjhpUe40JRLFT6S3YgPP2ay
	 Cc/uhdCfhMABrmRrB7LPce+A3LDO0Rzv6ju0fdTgThrWmafe2lFIQhyaEOW7J2jJEJ
	 VzYEUyjl6rEqwnPbxEzQ947BlScVoVoy13gr664vGRbj6uZwctXt+Ndno5iCGhGbtR
	 MMQvLFpyqG4ow==
Date: Wed, 28 May 2025 19:44:49 +0100
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Eugenia Emantayev <eugenia@mellanox.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Matan Barak <matanb@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 net] net/mlx4_en: Prevent potential integer overflow
 calculating Hz
Message-ID: <20250528184449.GI1484967@horms.kernel.org>
References: <aDbFHe19juIJKjsb@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDbFHe19juIJKjsb@stanley.mountain>

On Wed, May 28, 2025 at 11:11:09AM +0300, Dan Carpenter wrote:
> The "freq" variable is in terms of MHz and "max_val_cycles" is in terms
> of Hz.  The fact that "max_val_cycles" is a u64 suggests that support
> for high frequency is intended but the "freq_khz * 1000" would overflow
> the u32 type if we went above 4GHz.  Use unsigned long long type for the
> mutliplication to prevent that.
> 
> Fixes: 31c128b66e5b ("net/mlx4_en: Choose time-stamping shift value according to HW frequency")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


