Return-Path: <linux-rdma+bounces-1744-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDD3895B4E
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 20:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3D51C2163F
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 18:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640D915AACE;
	Tue,  2 Apr 2024 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWy71i60"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1810C60264;
	Tue,  2 Apr 2024 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080920; cv=none; b=bBSCZ/xHXi9fssdFQ4oz2Lhp5E9kgXDCtt6iVASBVSnJ36r3nS44Fq+f9BOMqMziCF7fQ5a8wS6iX/onKT9UATKARADaBc23uyeDnsCJh35Fv3U5fPTFiQs1sx5knouSwtnVA3hRxqPTdhrgbquy+pD28rzLU3HDYrIXCRwynSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080920; c=relaxed/simple;
	bh=o93icfGi1dhjdqK+DWRm8T4/nnvdI7svFWxa5S8pbXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cb1qX4Z4ENtW7zkM6QtjwgAPMcrFHiRFbq7zFuIp+ncWD2CcaJ70zuRtzjPUhGUTUSaTlX5FI1Gv1RatsaIcvZV7V72Qp4D+dffnxz+zcE8g8LomvsOo4jG8lXA1OfDucNzHpyUHklzXBUW2EQYNgplMQ1uvk8dM5vpL56S7kQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWy71i60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4081C433C7;
	Tue,  2 Apr 2024 18:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712080919;
	bh=o93icfGi1dhjdqK+DWRm8T4/nnvdI7svFWxa5S8pbXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWy71i60tVSzCeG/cF9EaKZujwpBxgdtNjvso3dWIPRIENTJYnaHEMIYOaSdUI4NJ
	 UYWKDPONzDM1gM/wYc5zYmGr0Wo4zmBZNrxfrfrI2xN+AFWf7sU0aOC83hL3qQj8Zr
	 kQYCbMzaNgmKv4vk3fdSBRMNMAsnteZxFhICEEwCdbkK1a9NFReHT+rW7JA0yHV+q5
	 fhO7vhEPXWZwndkAI6uX5gK0IpZXWxuI8dUzEWypkspw4Z+Wv1S3PTDv3mkb5b3hf5
	 66u6+PdQJe2uKPhynC4v0v0lAPPt2ZEwF2lndm1yPPcDFHOLnqa87WL8UxB7C1ftNS
	 mH67vBQB/bZbw==
Date: Tue, 2 Apr 2024 21:01:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	quic_jjohnson@quicinc.com, kvalo@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next] net: create a dummy net_device allocator
Message-ID: <20240402180155.GM11187@unreal>
References: <20240327200809.512867-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327200809.512867-1-leitao@debian.org>

On Wed, Mar 27, 2024 at 01:08:04PM -0700, Breno Leitao wrote:
> It is impossible to use init_dummy_netdev together with alloc_netdev()
> as the 'setup' argument.

<...>

> Also, create a helper to allocate and initialize dummy net devices,
> leveraging init_dummy_netdev_core() as the setup argument. 

<...>

> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Exciting read for people who remember this conversation:
"""
> I prefer to see some new wrapper over plain alloc_netdev, which will
> create this dummy netdevice. For example, alloc_dummy_netdev(...).

Nope, no bona fide APIs for hacky uses.
"""
https://lore.kernel.org/linux-rdma/20240311112532.71f1cb35@kernel.org/

Thanks

