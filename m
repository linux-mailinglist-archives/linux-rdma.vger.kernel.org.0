Return-Path: <linux-rdma+bounces-2559-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5508C8CB058
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2024 16:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114AE2819EF
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2024 14:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36EE12FF86;
	Tue, 21 May 2024 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RCIW0InT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B812FB35;
	Tue, 21 May 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301445; cv=none; b=gmO2/XMgSDHxE59VlTw31z5ERMNEnXRpHoRV2sbau+W0n74ERh1vhpg5a2j6ok1OL+YJp7UB+0kSUFPNCE6UME1sPBHA28NwNUuq8piPr0D+nOJ21F34q9Xll3pRBu1qQ0JRQqdZGztTVEhrpAolRhKOge0+ixDuMWC4bggIO+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301445; c=relaxed/simple;
	bh=Ufb8V9EXfBATCWAkkaDHd9SSjQcvqH4KeGWG5MbMraM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS8c6Y6r/rG+Jc6UaZJsIe3/XCr3pOiFM5o+5bvgQUFtpSDOd/rOWPw+I0Ni4hUd7kFIEikGIWvHyjavA3taz1s2Y6DVk53HrbfZrf6DkZwuTCWd4eD7ab2Tqb4M3rsToe8AfJkfTnnJt5yNZKFqc9kDC3rD0I4mdZEpNzCK11M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RCIW0InT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Tbk+wAckI7ORsUezlOoBQgzIj7S/QOcUIP0Sm5u3+ZQ=; b=RCIW0InT9c6CkHpwaXWKUslILM
	wfV9AWbKMedHc/FwlBmxyT8cdpp7PLtOn9mWgY4CASuTe5E6GH3InTKuzibwwV9cu8g0UXm3csKcY
	jJoihHKXsjC3/Aio3Ana0S6Idpg+43QklOI9jd6SGwkDjLzPXWqs5edFmkSyVSyHm5rQBqxsSUkl8
	js2TFxYLQG+/BPTuZEqhT8MK83kMuLTJfrsX4NR+QATb9X4UdG8Pk7vzKlqqHllilH363uhQR4y/F
	A01rvslh3xmh0Hb6pPHDkr5hWgflcM1P9NKVFVYt9n2DF+cr6+frnNETe5mGgJ1uOV7PkoRCmYgmX
	38kGJr2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9QPL-00000000AG1-0CtD;
	Tue, 21 May 2024 14:24:03 +0000
Date: Tue, 21 May 2024 07:24:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH v2 0/6] rds: rdma: Add ability to force GFP_NOIO
Message-ID: <Zkyug8ZQP_4ULAeA@infradead.org>
References: <20240515125342.1069999-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240515125342.1069999-1-haakon.bugge@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 15, 2024 at 02:53:36PM +0200, Håkon Bugge wrote:
> This series enables RDS and the RDMA stack to be used as a block I/O
> device. This to support a filesystem on top of a raw block device
> which uses RDS and the RDMA stack as the network transport layer.
> 
> Under intense memory pressure, we get memory reclaims. Assume the
> filesystem reclaims memory, goes to the raw block device, which calls
> into RDS, which calls the RDMA stack. Now, if regular GFP_KERNEL
> allocations in RDS or the RDMA stack require reclaims to be fulfilled,
> we end up in a circular dependency.

Use of network block devices or file systems from the local system
simply isn't supported in the Linux reclaim hierchary.  Trying to
hack in through module options for code you haven't even submitted
is a complete nogo.

NAK.


