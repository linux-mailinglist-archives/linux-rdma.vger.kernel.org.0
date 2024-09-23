Return-Path: <linux-rdma+bounces-5048-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 517A497EB34
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 14:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091501F21E3A
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 12:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA451197A72;
	Mon, 23 Sep 2024 12:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e06S7W/Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD17433D6;
	Mon, 23 Sep 2024 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092998; cv=none; b=P6nJRaFo1BTx77CQVCtjiwOn5XdmrFH4eEHHVAwbf7GEcABD1x5vDsF6wzy3nOJ5ax10klwkRbWvZH662YFSe/q2AwfqZRtNp+w2E/MvhYndWq94D0OWTb7DBqbbkRTCTRsUCuan59gjPN158kPbO+P3xEj6b/qh7qrypDYyN2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092998; c=relaxed/simple;
	bh=J6mLGKCQImtW4cmdFCUf+ZR0IT2a9SVu9Hrc7LedkXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGh+l9hCACIoYY3mxa3R1lfvV1nmi3CRWAvNL4/JqiGsyugZ7cLlY49wF2OZWXd30KEZ07fCZqq39czqxDWDFsbrYpo8NMe4NOjar5jXvnxfxCb4M6Yik2QD6G6+tvaLkzyzOUj5Cl25NrYl8J6f9o12tlwqlu3YaB2M/uKEInA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e06S7W/Y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=rr9O4oopdmio99+RuTegtMX8fwAtshEZaJECcRoNGIs=; b=e06S7W/YhlvXAYq2TAfmXQhZrn
	kPFkheoOLmbUh/L1MDt4soFJNiIYC4b6yk1mhr2DWqzT6amo9xAti8ICA4R5RidDtCjmbwn+dG3u3
	dUmI/Nl6BmchyrGskqo5PAFkxBZUk0pqUXq48i7UeU7xYSbQCibU1OPwc+Sz1CTfTAhmJnb9oq6xz
	bLzTWKQZhWPYLm5qLBGvzHnKO0Idx0RhGKdqLwisoOAshSuiz4bvoPNT9KxRnel3dYZF1/RhuRwio
	u1Er0OwpAtuf0wdpXZT/shHK+FMUjoY6M1K0pHnGae5mE1tQtRsbW8DUKH2+A/KkE5mHvcsDSmlv6
	xpb7EldQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sshmZ-0000000H89d-29AW;
	Mon, 23 Sep 2024 12:03:11 +0000
Date: Mon, 23 Sep 2024 05:03:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>,
	Haakon Bugge <haakon.bugge@oracle.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Allison Henderson <allison.henderson@oracle.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>
Subject: Re: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
Message-ID: <ZvFY_4mCGq2upmFl@infradead.org>
References: <20240918083552.77531-1-haakon.bugge@oracle.com>
 <Zuwyf0N_6E6Alx-H@infradead.org>
 <C00EA178-ED20-4D56-B6F2-200AC72F3A39@oracle.com>
 <Zu191hsvJmvBlJ4J@infradead.org>
 <525e9a31-31ee-4acf-a25c-8bf3a617283f@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <525e9a31-31ee-4acf-a25c-8bf3a617283f@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Sep 21, 2024 at 10:28:48AM +0800, Zhu Yanjun wrote:
> 在 2024/9/20 21:51, Christoph Hellwig 写道:
> > On Fri, Sep 20, 2024 at 09:46:06AM +0000, Haakon Bugge wrote:
> > > > I would much prefer if you could move RDS off that horrible API finally
> > > > instead of investing more effort into it and making it more complicated.
> > > 
> > > ib_alloc_cq() and family does not support arming the CQ with the IB_CQ_SOLICITED flag, which RDS uses.
> > 
> > Then work on supporting it.  RDS and SMC are the only users, so one
> 
> Some other open source projects are also the users.

I'm not sure what you mean with "open source projects", but the only
thing that matters is users in the kernel tree.


