Return-Path: <linux-rdma+bounces-2329-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6118BEC8D
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 21:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA2C28A306
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 19:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1873C16DEB0;
	Tue,  7 May 2024 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DGHZcDwQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B61A16D9B4;
	Tue,  7 May 2024 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109806; cv=none; b=UbMhINtZeOIPeMBj+dRR6x+Lorv9Uzt5COuqdAXZ1l1I7zODPSNnk94e7EG/xXGef6hHXHaL/iFWLrYS9OkykYYrWZ0CYjf9HvE07KP/Az6+h4aiotLp00SnpvL2UfHLluT/njnIpSmhuJBguF5tprg6/rh5peBvuXpe6+h0ciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109806; c=relaxed/simple;
	bh=N9VAa7hmB0B7LwXNGLbiRpxaywLSphhnsGPBx+mqXyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuQBZHyw9LQgUv2Gj7Wlic0RggOXdnPtr+yRpHdxKaf9aAh7Fsv5BzCchjzM9X24hXQQfgEd7gLuP64jcS9/j34iITy9NBH3mnMRXL2UuQ+sLJU28Hcn2gqVJ4Nt5XlupShO9j4JQ/tFpLIuXGrglQTBOzeDzFjwDdcB4BZeZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DGHZcDwQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1Rlt99zmcVILKclqpbjv2utXWPqAc4TJPPlL31nMJt8=; b=DGHZcDwQt05/ofsRmHCXxB7F7p
	4+19AHlf/kB9ynBunr+XzmEvyFe6jOB5Bi4Rg6t+TMauL7eOeAIVct20JsAWJK4OCulTHdC9kwooI
	piaA8++amm65GJTBciceqX7s9AIYLi/5LAzyO1mzBOTXaqL3R65vQlUcICSp/KtxsspkpnGaEw/jv
	BFFDRAv6XEpLYVjeNMGIqqF6+U84USuu86U1FYPS/48Wb2aAdf83MBClnEzbI40mPdQEnJjsMlRxA
	jA2Mxibyz2aoHWw87X0TBKAU7uJ6LRcRJ4xY4XkjrvGCwdIf2txmwWpBcVfF0tuTv/Uq/WjjhOrdl
	Mj+cEspQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36042)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s4QP6-0004C4-0A;
	Tue, 07 May 2024 20:23:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s4QOw-0000ZA-Of; Tue, 07 May 2024 20:22:58 +0100
Date: Tue, 7 May 2024 20:22:58 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Allen Pais <apais@linux.microsoft.com>
Cc: netdev@vger.kernel.org, jes@trained-monkey.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	kda@linux-powerpc.org, cai.huoqing@linux.dev,
	dougmill@linux.ibm.com, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com,
	tlfalcon@linux.ibm.com, cooldavid@cooldavid.org,
	marcin.s.wojtas@gmail.com, mlindner@marvell.com,
	stephen@networkplumber.org, nbd@nbd.name, sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	borisp@nvidia.com, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, louis.peens@corigine.com,
	richardcochran@gmail.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acenic@sunsite.dk,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-mediatek@lists.infradead.org, oss-drivers@corigine.com,
	linux-net-drivers@amd.com
Subject: Re: [PATCH 1/1] [RFC] ethernet: Convert from tasklet to BH workqueue
Message-ID: <Zjp/kgBE2ddjV044@shell.armlinux.org.uk>
References: <20240507190111.16710-1-apais@linux.microsoft.com>
 <20240507190111.16710-2-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507190111.16710-2-apais@linux.microsoft.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 07, 2024 at 07:01:11PM +0000, Allen Pais wrote:
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
> 
> This patch converts drivers/ethernet/* from tasklet to BH workqueue.

I doubt you're going to get many comments on this patch, being so large
and spread across all drivers. I'm not going to bother trying to edit
this down to something more sensible, I'll just plonk my comment here.

For the mvpp2 driver, you're only updating a comment - and looking at
it, the comment no longer reflects the code. It doesn't make use of
tasklets at all. That makes the comment wrong whether or not it's
updated. So I suggest rather than doing a search and replace for
"tasklet" to "BH blahblah" (sorry, I don't remember what you replaced
it with) just get rid of that bit of the comment.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

