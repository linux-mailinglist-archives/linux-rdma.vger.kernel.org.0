Return-Path: <linux-rdma+bounces-5005-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 719AD97CAD8
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 16:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1AF01C2251C
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 14:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFDE19E83E;
	Thu, 19 Sep 2024 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3fa7bGMC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7E420B04;
	Thu, 19 Sep 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755461; cv=none; b=EOWRuhC3WuVru2YlNYTcsduXzB6M7QSIOM7xt1NF2SyFRxn6BXxd8cgjr8xszfZlfZhbpoQozK+HzjZKEEtGftXqAuTH2092AbPNpXiNRPpjo80kPOTBE0xhYtdosxkMcPB6L+IZQuJRnPAhpirYHviiGHtE4/lGIzXtcq5eHC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755461; c=relaxed/simple;
	bh=vRsq37cyFsnMCRJWk08SutfAhz42ipMp2Yw5nEOlxaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BF8Cq5S3KxbIHOe3ldjHhW5quBh0gOIBFw8WisIZV23ui8qayxE910gMuwtsEcazsry175lOFAkGdAB7d3F/VqwuFw2O1S6O/1zhaV9mKbk/uaFNQCbGMR7fNMWQjq1HNLk3EW4RxXFOExFJq6I94QCSvBFyqMheW0IJXusOShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3fa7bGMC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=vRsq37cyFsnMCRJWk08SutfAhz42ipMp2Yw5nEOlxaw=; b=3fa7bGMC4PvUTU5hEXpH7tFiZ/
	F003lTIjZNWpChSRjQZ07bBk54UxrKOMGMeXEGDpRg/QOOakXjryc703OYvHMeC36AISjSLzfpqD+
	cm9vKilNvw4IErn56QRmet9iMyDphEan4n2dWEMmL/JNBRhm+Gt8uTZQFAswHuXEwPP4G18wlCqu3
	RHCOAYygRsTwGG0zGICHpJwA3Vi4f2dlKOB61JAIaKF4XyEnh5i511BncKWgr9QPW9WXv2h9URw+t
	gnU/uMFQTYTDhwJHRqa1xr2Sqp/qGs9VmSJ0ajUnjhLcbC7WdviMT0MfeMhpZDMQdxCWQGXPRIdN6
	dryUqQJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1srHyR-0000000AQfa-3oDX;
	Thu, 19 Sep 2024 14:17:35 +0000
Date: Thu, 19 Sep 2024 07:17:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Allison Henderson <allison.henderson@oracle.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com
Subject: Re: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
Message-ID: <Zuwyf0N_6E6Alx-H@infradead.org>
References: <20240918083552.77531-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240918083552.77531-1-haakon.bugge@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Sep 18, 2024 at 10:35:50AM +0200, Håkon Bugge wrote:
> The Dynamic Interrupt Moderation mechanism can only be used by ULPs
> using ib_alloc_cq() and family. We extend DIM to also cover legacy
> ULPs using ib_create_cq(). The last commit takes advantage of this end
> uses DIM in RDS.

I would much prefer if you could move RDS off that horrible API finally
instead of investing more effort into it and making it more complicated.


