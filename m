Return-Path: <linux-rdma+bounces-11924-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EA4AFB1FD
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 13:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8EBC7AC639
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 11:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E71296158;
	Mon,  7 Jul 2025 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBvJwiZU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533FE295517;
	Mon,  7 Jul 2025 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886552; cv=none; b=Msd+pAV3l7Q2qJ7UXMrYAYWF0uBMyGPovv71QipBs1kbyz6oG4m7ZWjDzIh4EC8UP9mKBktUHZeLOUosMBKr9OMfjofSTzTKtFzJ1BU7s3HRz7g4nrdqJlq09lIAyioTgB+zxVKzKE9iXczoRlUpExm6vlTr6fDwey2PTTfbTnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886552; c=relaxed/simple;
	bh=rVeIq2r7Iq4ccES97pJk/gfKT7JsO1Du8z33/Xli2qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5eaWjgpRI9a7JwAji1JIEKAWBf60DlAqCIy5osqUnqD5gUdq/MZOgFggilYO72QjZn88TrOlVkMkSp0HIW5Sree/1FYySdawAlnvww0VTYlYe0M2s4SGHjq/9ORRP0NbgHWdORcKgLTafKU8fRp0Aph2MppEfgjmeU8FiZJamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBvJwiZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6C9C4CEEF;
	Mon,  7 Jul 2025 11:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751886551;
	bh=rVeIq2r7Iq4ccES97pJk/gfKT7JsO1Du8z33/Xli2qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LBvJwiZUv+Cj7MO2ccbc20sVywf8D1OhBgm9ipMfd4ucQ7NxJY8it8kNrDlwyNESL
	 2Cqy19yYi7H6o+MmyDjeGKGBGWU9wU0b8x8oXYmK1JGiZHpGTiyCz9ez9qQ7+OYmaA
	 yxhsjnVdgzfEHtRSAPKVIfon7WrCLB3EsxedbJAKrZDP/qw8cQsLMusI3QVkXSnekj
	 SqJ+O9/YEa6YMnvGIqHv1VgCz3Kki1pWgqwsYaEwjDO0gf69B4T+prNoL+zG0tD5bK
	 qEPS81Ftn0rD5L3bamldrLuAT8SVEKc4ACTdHCG7L3we4ST2HntTNRX14ZyC5Ikljn
	 11o+y+d7WFXOQ==
Date: Mon, 7 Jul 2025 12:09:07 +0100
From: Simon Horman <horms@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com,
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vlad Dogaru <vdogaru@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next v3 07/10] net/mlx5: HWS, Track matcher sizes
 individually
Message-ID: <20250707110907.GI89747@horms.kernel.org>
References: <20250703185431.445571-1-mbloch@nvidia.com>
 <20250703185431.445571-8-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703185431.445571-8-mbloch@nvidia.com>

On Thu, Jul 03, 2025 at 09:54:28PM +0300, Mark Bloch wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> Track and grow matcher sizes individually for RX and TX RTCs. This
> allows RX-only or TX-only use cases to effectively halve the device
> resources they use.
> 
> For testing we used a simple module that inserts 1M RX-only rules and
> measured the number of pages the device requests, and memory usage as
> reported by `free -h`.
> 
> 			Pages		Memory
> Before this patch:	300k		1.5GiB
> After this patch:	160k		900MiB
> 
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


