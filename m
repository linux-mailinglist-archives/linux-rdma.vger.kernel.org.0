Return-Path: <linux-rdma+bounces-9484-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EE6A9047E
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 15:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E125F189B66C
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 13:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F521A5BBC;
	Wed, 16 Apr 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EI7+v9/T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6E7A32;
	Wed, 16 Apr 2025 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744810738; cv=none; b=a7KbNw+GO9OuUOfoxquT/qDeQ2PpXT/Sg2gLSzrPuGrjjTY+9R5pbSTSa+xQPrEhMFAFPCpemCXTTtB9VZpltxdQoFVOXJGI/gSz1OlrB3b394rDBPWQVuC9iAy5aFAlynaXVHhx7JCqZ1kAkYLmtUWOx19N2bdaasOecEDn9Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744810738; c=relaxed/simple;
	bh=nrrD3/sSaPsl3a1EqfKuMRRLXEiXUHmBEshVkFhljRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUR3kt+otwWlGmUWFxiIJ7viZnweaYa4sh2zhzsRnoC9l+P5w7FlsxsNfajR7SH6Q28N9N3kbqcWPy8OAuuwd6YPfQnAl0spVveBqWuzhZoPE2lwSxCGDz4dVUZStHEqCQiBXtPFVL2kXnHqpZ0eRDeo63GhA8OikIDgAlaXc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EI7+v9/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A17C4CEEA;
	Wed, 16 Apr 2025 13:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744810737;
	bh=nrrD3/sSaPsl3a1EqfKuMRRLXEiXUHmBEshVkFhljRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EI7+v9/TV3vL8wNZFHf5NwXTl/I+OIoNCxeCgleOMSMSQ2et4YlX2E/CtICiF2aRX
	 oW/4Id4sKByywPbfG/aMVtG/Yz6mzSPnvXl2qgsmgXLSFguGJM7kQXBF+k8BF1GIN4
	 ThZ3NCRohH1sv1xyMoYbOtaw0ZOb6F3NrppLlR07Zo+WDcVKWUg5pMJEKTrkuBgExU
	 gZz5KUkCuI4y1NsrxDznV0Gbp9y/3WlyHjn121kUA2n1+qTCsnrR97CYFi3SpyQJeO
	 +/nIc8jEkEOxLOCWZx+MQxt08+oXFr7HQg9OEzZXHNTxnFCn+qtGuDHzV8KoVlsfLf
	 +2x4BlPNPwstA==
Date: Wed, 16 Apr 2025 06:38:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Bryan
 Whitehead <bryan.whitehead@microchip.com>, UNGLinuxDriver@microchip.com,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?=
 <niklas.soderlund@ragnatech.se>, Richard Cochran
 <richardcochran@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Andrei Botila <andrei.botila@oss.nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: ptp: driver opt-in for supported
 PTP ioctl flags
Message-ID: <20250416063856.3b653d81@kernel.org>
In-Reply-To: <20250414-jk-supported-perout-flags-v2-0-f6b17d15475c@intel.com>
References: <20250414-jk-supported-perout-flags-v2-0-f6b17d15475c@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 14:26:29 -0700 Jacob Keller wrote:
> Both the PTP_EXTTS_REQUEST(2) and PTP_PEROUT_REQUEST(2) ioctls take flags
> from userspace to modify their behavior. Drivers are supposed to check
> these flags, rejecting requests for flags they do not support.

Applied, thanks!

