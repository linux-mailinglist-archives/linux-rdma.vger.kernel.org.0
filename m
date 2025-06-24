Return-Path: <linux-rdma+bounces-11601-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC964AE6F00
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 20:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 303137A6504
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 18:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B7D2E763C;
	Tue, 24 Jun 2025 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNbViHY2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834C42E610B;
	Tue, 24 Jun 2025 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750791475; cv=none; b=WEH3O5KkhN7WumhIdQthwxkgcrF6q2Pdd1rRD/7Kyjnhi9QC/u5ZtZ9PK6+gPvh5dxVjb/5p83VuQkoKnxtMUp6ihZPmqD13C/Qhn0oKtP4J1X8YjqY62k5IEFifjBcz8e1to6iKI5c1D8Q4zyOz5bdpbeRkf7C2C8s4D08goik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750791475; c=relaxed/simple;
	bh=R/JVNUFj56dzmZhKFXGohO6nydxwlPaGPwn8nVusUnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TN/vdjb2k4MQd2lSkR0qpsa/+WMPPQ500DdYNXvecfG2MmE9RvuKaON9vZuZvH8fPGD/vC6iae3Jm/dBATujqSMK2uzoJy10KjxjQPYVSfxGLhbuHwtmoxsvXNlOlrU+q7EPyFMY2pJTMu9c4XqHeVbge6BVTO2y37KNz5q53+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNbViHY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A42C4CEE3;
	Tue, 24 Jun 2025 18:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750791475;
	bh=R/JVNUFj56dzmZhKFXGohO6nydxwlPaGPwn8nVusUnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WNbViHY2K+SwdcW8JnCXPeCEHtQzcaPv0wZteqZPV8cANhRlE36/5DhKIxccCoyPv
	 0xH/1zqO8ljaBeqamvXH595RYjZ3mBWG4xtjtIcJupN9S19P07+WGCIunk22jn5rpK
	 g3UX5GGXhiXDrQwL2Ucu41arHPCx990LLgSSvJtkWzWhnDC67OpiQRq2Q+EmeRWTsC
	 xoK38lvxzee2mfC+erkGNEtFqx6h+PKTIgdn1wSOWELfz9W/Sg2eh7VrrKIV6IRLeU
	 LkrnlX9gIhv6tS4KS1rWh04+sCuj8x89S4jS1ZCOaTcXTOUdJvqBrsA5yIXD0yGA8L
	 iHAjv4QmPxfHg==
Date: Tue, 24 Jun 2025 19:57:49 +0100
From: Simon Horman <horms@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com,
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	moshe@nvidia.com, Vlad Dogaru <vdogaru@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next v2 5/8] net/mlx5: HWS, Decouple matcher RX and
 TX sizes
Message-ID: <20250624185749.GH1562@horms.kernel.org>
References: <20250622172226.4174-1-mbloch@nvidia.com>
 <20250622172226.4174-6-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622172226.4174-6-mbloch@nvidia.com>

On Sun, Jun 22, 2025 at 08:22:23PM +0300, Mark Bloch wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> Kernel HWS only uses FDB tables and, as such, creates two lower level
> containers (RTCs) for each matcher: one for RX and one for TX. Allow
> these RTCs to differ in size by converting the size part of the matcher
> attribute to a two element array.
> 
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


