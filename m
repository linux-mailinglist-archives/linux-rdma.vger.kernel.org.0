Return-Path: <linux-rdma+bounces-2592-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505F08CCE1B
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 10:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C311F2164F
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 08:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FD113CA89;
	Thu, 23 May 2024 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XKFAr1GJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D77CF39;
	Thu, 23 May 2024 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452302; cv=none; b=o4nGNEAZGGz6wefsbRyezq/a98C6PKuDpf0lguHjqf75Q7kbpP+DwqanPdZXtq+tKrNt6fKuBkztbXsSsooZFPK47CYxF9uZEtJCVa1dhvwLSo5+rehj8kRUCxtCMFdQJeGijQLdaOT1giWQ5WJmTkXAGt3NcMjy3hPIOe1yeiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452302; c=relaxed/simple;
	bh=W1EJy3uQTcCeTDDtvxDKkfXdw1GfkMNaXSPZiWwzij8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckjMHYoDfJfhBd7n1J5pqIjIeIa3PSJ9GP3/fCsVA9nW3d2zp6gs7DuDo15VWeFX1si4WOzepW2BqiHO95h4qyFxFf6aqQSlD7unCUrr3MpUm9fH7RYMcLRIX9KTrh7TYBPv5DqPb49axHllwSOSfDyJxBYuX98Q5AGJSxZwWGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XKFAr1GJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W1EJy3uQTcCeTDDtvxDKkfXdw1GfkMNaXSPZiWwzij8=; b=XKFAr1GJJmpkVh7yZJc5BvdDtI
	8i5Rk56l5wngYvrrIbWqP3+akuy/paJB1MALpyklH1OcpnOKPO4wFvTjHm56ueNiADXNSaS7XJHvV
	zc/czPEqw/SpcetP2PnNxBUrHOu2JOqffwCBPCjvUHriJB610I/yewU7U06ZzeRxcgTCD6+JWCiSS
	Yfw/4fST7OrSI4bS1xZDN0GWV244s2CkR1/YqB249GZ5+HnFeZ7X7/jK/SCgD0GMxFv6sQk1J83oL
	BU3Tj/IqaywjlH0zWoYCvkv2Sxc3oqlZdnFO7BfAOjf3ZiakhM1uvQ4LIWpwK7Bka9lZqa+NNEDJR
	SGpV4XDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA3eR-00000005Ubo-2u6M;
	Thu, 23 May 2024 08:18:15 +0000
Date: Thu, 23 May 2024 01:18:15 -0700
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
Subject: Re: [PATCH v3 0/6] rds: rdma: Add ability to force GFP_NOIO
Message-ID: <Zk77x71LCqlgIING@infradead.org>
References: <20240522135444.1685642-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522135444.1685642-1-haakon.bugge@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Still NAK with the same reason as the previous round.


