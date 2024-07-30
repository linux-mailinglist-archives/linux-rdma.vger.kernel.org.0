Return-Path: <linux-rdma+bounces-4123-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC139421B6
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 22:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66851F24662
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 20:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C990418DF9B;
	Tue, 30 Jul 2024 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1aVXMr/f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3581518DF7F;
	Tue, 30 Jul 2024 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372027; cv=none; b=e83QhlgpS1gTkMt2v7cwIX0zDnqMfTZy8HnBm7rkJQNFyt4GU9UZJWbI4FTlMN58HlBXLPphwPKSHpW2QpZSQRcVF4x95Ro0mFMBN7HtEdgyoCUwUWIQUJ3yLWM3GRt2v0NJKuKxeG6ylIYLoD/t4W5v++sBU4T5QOdpZIF+en4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372027; c=relaxed/simple;
	bh=XkgU6el8ueQeo/jYOQv1LuN3ZcuhNV3n6un0doX6CSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iI6JYS6qDgFJjSiEmdMTv1KamJtuoJWmvjfb/xsG3hsqOIYBqlBe/14pz8ldXVFfZWKMKz1LzYOEyF7H64cggy9EvWNLA0ycg4YMpFmOmphoFWE+vcazVKhUW/yL3RRxkhHuDAAYiI2Z0+1OVJZdmcf0fSbPbkbYi7a+yQ15uJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1aVXMr/f; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J5Jaq1YOsTim2xFo3Amv8mSEh00+XINRE2fskB3Zh6I=; b=1aVXMr/f1qTLOIYWMa922qgOKv
	oHNKldmDu+yXpPyvy+1VZ/clwvNkHlO1QdUhdW3fUO/FozqcyGU0vBXqpX/8sNSpSaWsKVjegx5KI
	sq5iPf3WGPrGjf814N8GtODItRm0pg8UZTupK35HAV5UtGDX1HHggJ2YD4drmwr+TrcM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYtdP-003c1f-VS; Tue, 30 Jul 2024 22:39:51 +0200
Date: Tue, 30 Jul 2024 22:39:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Allen Pais <allen.lkml@gmail.com>
Cc: kuba@kernel.org, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Mirko Lindner <mlindner@marvell.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	jes@trained-monkey.org, kda@linux-powerpc.org,
	cai.huoqing@linux.dev, dougmill@linux.ibm.com, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com,
	tlfalcon@linux.ibm.com, cooldavid@cooldavid.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, borisp@nvidia.com,
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	louis.peens@corigine.com, richardcochran@gmail.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acenic@sunsite.dk, linux-net-drivers@amd.com,
	netdev@vger.kernel.org
Subject: Re: [net-next v3 14/15] net: marvell: Convert tasklet API to new
 bottom half workqueue mechanism
Message-ID: <fbb19744-cc77-4541-90b5-0760e0eeae22@lunn.ch>
References: <20240730183403.4176544-1-allen.lkml@gmail.com>
 <20240730183403.4176544-15-allen.lkml@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730183403.4176544-15-allen.lkml@gmail.com>

> - * Called only from mvpp2_txq_done(), called from mvpp2_tx()
> - * (migration disabled) and from the TX completion tasklet (migration
> - * disabled) so using smp_processor_id() is OK.
> + * Called only from mvpp2_txq_done().
> + *
> + * Historically, this function was invoked directly from mvpp2_tx()
> + * (with migration disabled) and from the bottom half workqueue.
> + * Verify that the use of smp_processor_id() is still appropriate
> + * considering the current bottom half workqueue implementation.

What does this mean? You want somebody else to verify this? You are
potentially breaking this driver?

	Andrew

