Return-Path: <linux-rdma+bounces-11467-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44979AE0752
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 15:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005684A4825
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A682673A3;
	Thu, 19 Jun 2025 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4jifniy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3F325D8FB;
	Thu, 19 Jun 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750339832; cv=none; b=FdxokmYhb9As/X29pJaC5yQdB/0MOUEOuUUJjPv9DzSqhedzIFABdFLUAfMx0mRoyhlpNvO96HO8WL0dTvY0RactqlYRlc1csPJOTCFurHZBYzxQJnSeg3gaLPVgHLnfR5n9Y4BhIKk6GZW2NYzIls7NKt234cT+4UkOtWTGPUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750339832; c=relaxed/simple;
	bh=hudOF111YgnX2+jpkJZHTU1k6oIbLOWGe2PdF1fYcS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOd6KfAWRYT/TRex0DXDKcYKbbirb9SPZkrzWeOF/E1pyPV5s4+x2F3g6ikAqGZ7ZVoTkt6kJ7/06hcyLsK09VnSpWch/spRVyFi7yxg2U25Wbq+t/tubX2GvURVOdpkhrRpvT1whVuKxphur9k+ukqwvPa2m+AtWVq+ASfKus4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4jifniy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF92C4CEEA;
	Thu, 19 Jun 2025 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750339831;
	bh=hudOF111YgnX2+jpkJZHTU1k6oIbLOWGe2PdF1fYcS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h4jifniyPlHfhCbjOAvSofdWxdQcpSwKyDVXk4v5K7sNFBp/RqlfqCGOgC7XjO2q1
	 VjHU9dlUJraLJPHmrGiMWcJHLY2Ophpl2nVZ1GByC2uypRKTuhwUFzdVOisfZzeiH6
	 qu1sbk+6Im/bq/7nYzHhedqsGqEYdpUx25OvCZgpe4b8iRqq5/ZkyhpcOBDvZlIVRz
	 vTPbzBfJ12vvBMO8gDq5TRzh0HrzOdrhg+CkhcP9jKQPiRhdlwUKnlQ1VNLDbeOTNz
	 EcdDy05J6gtt+bi1DyIwIWxp5aA8gEaxf1uOTsNaEPsGaDBeYD2/1AVgzORZIjN/jD
	 UUArqCpMCUUww==
Date: Thu, 19 Jun 2025 14:30:26 +0100
From: Simon Horman <horms@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 1/2] ice: Don't use %pK through printk or
 tracepoints
Message-ID: <20250619133026.GP1699@horms.kernel.org>
References: <20250618-restricted-pointers-net-v3-0-3b7a531e58bb@linutronix.de>
 <20250618-restricted-pointers-net-v3-1-3b7a531e58bb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250618-restricted-pointers-net-v3-1-3b7a531e58bb@linutronix.de>

On Wed, Jun 18, 2025 at 09:08:06AM +0200, Thomas Weißschuh wrote:
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk(). They can still unintentionally leak raw pointers or
> acquire sleeping locks in atomic contexts.
> 
> Switch to the regular pointer formatting which is safer and
> easier to reason about.
> There are still a few users of %pK left, but these use it through seq_file,
> for which its usage is safe.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


