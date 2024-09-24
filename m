Return-Path: <linux-rdma+bounces-5058-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ABD983D81
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 09:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C892815D2
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 07:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A3112C7FB;
	Tue, 24 Sep 2024 07:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yoSMyK7G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE412C478;
	Tue, 24 Sep 2024 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161313; cv=none; b=Hhl6qL53+Ls/ZNVt28bEDgIHAMuJzROBBrPJEPWIdQ7oATIyYDD1xy9NOrsaScIOA8Uz5OXrM3Cx6TSMVdYeH3iKyxzIeUHwjA9GRPHy3pLI04VtHjZgbYdhpx+FFh3VXZ2XbvbkOjv4Z2pbMxqJWfyQ6L9nyKDezZNdH9vrryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161313; c=relaxed/simple;
	bh=xjfVoT1K47D5H3BF1Ou6jrbA/4vWt3yST4Y5x3T8Yzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiOLJWQujlZnIbHy9UgOFyidrvl0fEp2g4mhcRDFEmMqZLuHq4HeJRjqVbCPz2ZypmThYd/dXgeN6h3P5lpdJnUezhnAjrq8xGzJdHspI8qVFK2ftkk2t7ZS71RBv/YJ7AGBcH+eKBYgAqjE96frfgtfrsnJiS185Xv/lmgAkGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yoSMyK7G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Kn4ZLvNCtsllKYX+Hz4MqbgHZ402+n6+2o1HiK+jZJ4=; b=yoSMyK7GkhluVuS9WeBHe/xFQ4
	AI9YWUKBleThMUyzBAsUiytsDzb21PJniFGq5XR9h234P18XuihECYhDc8zN5U1n0fRt4vbETtSCd
	qwWarZwnfBFvFA1noLrVtW/CBvQsZ5qPR6cERpKX8/oIb/pzyy5nIRD+cAet0DwIgXkfGOeDCSA1g
	9WA+IoUsvGXWCSWt9P0j+M6N3Qj6bThTdVUeyUxwPVpxRkBDPcQAzb1MjkEjKL+mQLWrG/VD7ybVr
	130uNUfCuNnlesx7GQ5O7gj5F4+NgItL577xTVoKl2U8g6iMC30PePOWSjB5/PaO8kEQGv6t0rShm
	8PzG66oA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sszYT-00000001L53-1NM0;
	Tue, 24 Sep 2024 07:01:49 +0000
Date: Tue, 24 Sep 2024 00:01:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Allison Henderson <allison.henderson@oracle.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>
Subject: Re: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
Message-ID: <ZvJj3butL8FYeXpi@infradead.org>
References: <20240918083552.77531-1-haakon.bugge@oracle.com>
 <Zuwyf0N_6E6Alx-H@infradead.org>
 <C00EA178-ED20-4D56-B6F2-200AC72F3A39@oracle.com>
 <Zu191hsvJmvBlJ4J@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zu191hsvJmvBlJ4J@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 20, 2024 at 06:51:18AM -0700, Christoph Hellwig wrote:
> On Fri, Sep 20, 2024 at 09:46:06AM +0000, Haakon Bugge wrote:
> > > I would much prefer if you could move RDS off that horrible API finally
> > > instead of investing more effort into it and making it more complicated.
> > 
> > ib_alloc_cq() and family does not support arming the CQ with the IB_CQ_SOLICITED flag, which RDS uses.
> 
> Then work on supporting it.  RDS and SMC are the only users, so one
> of the maintainers needs to drive it.

I took a quick look at what it would take, and adding IB_CQ_SOLICITED
support to the cq API looks pretty trivial, you'll just need to pass
it to ib_cq_pool_get by adding a new argument and the pass it
down to __ib_alloc_cq.  So yes, please get started at moving RDS out
of the stone age.


