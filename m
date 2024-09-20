Return-Path: <linux-rdma+bounces-5027-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2857497D677
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 15:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE38E1F24C43
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 13:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1F717ADE9;
	Fri, 20 Sep 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="haTLp1z9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E793BBC1;
	Fri, 20 Sep 2024 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726840288; cv=none; b=Ic1ppeLoc1yf4NY/SeXw4NruN0NZM8lN+wk/kowfiM03PzLClrZghemgCyvMkRZeJfInUnpKHmmcO3PN6VDxy5THKpFBayvZLIVfj2gYf9mCFefwoFbhaNXCKSKFtjyXalDXQ/k3BkK9C7pI9T/t2CnlvWbJTCqahFuOVuWcxOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726840288; c=relaxed/simple;
	bh=dJlrmLJJ+XTvZyR+7WXzCkoqDjLucWi2ChOyY2CCacg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oks1qOr/00ZsvAx4pJC8CdZ4ZLyDlQC1oCXdRyKPDA7m00RVwTZfTyJwIR0vBzP+S8Ie6a101DOS/EYItk0B2tLBjs8+mhZTOxTvwTEEsixchrXEWnk6D8JsGmzs2YgEH/qsDrQoLVqxzb+ZB1cuDeJcQjcGhSGmTzxDTNl+HDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=haTLp1z9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gzS3M5c49Wetw6cHAPp6rxdhttAiRwa4AerwdaEEnSI=; b=haTLp1z9Ak//iXP34KC7DaGFO5
	80mBhdViGj4y7UmysI58KvsnKJ1LQHM5vuRADy4bqDha50I+a54nVtdxqINJ+qSTIYtgY/xQVHUry
	I+riyYmpIvA73u8nHY87ydJAoByIJpOwidd46Rafp0ufLwSD6mJqYQ3gYW0ts/GzcW2Z2TKD5pNkE
	cxdq0bvht3odzfKaN1asqVkt73+gBKmB80IZ0ol8k2uTmcjSuWC8fCpbYyDzFWSFtj9TdcoL01jdi
	kurVftURG1N9T7Jtd3OZa2ABWnj/46m8f++hOk7arzVXzMvJwrTnzhe+udb46mb2qm0mA+Ufc44gD
	EdakA+2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sre2Y-0000000CIu4-3Eke;
	Fri, 20 Sep 2024 13:51:18 +0000
Date: Fri, 20 Sep 2024 06:51:18 -0700
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
Message-ID: <Zu191hsvJmvBlJ4J@infradead.org>
References: <20240918083552.77531-1-haakon.bugge@oracle.com>
 <Zuwyf0N_6E6Alx-H@infradead.org>
 <C00EA178-ED20-4D56-B6F2-200AC72F3A39@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C00EA178-ED20-4D56-B6F2-200AC72F3A39@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 20, 2024 at 09:46:06AM +0000, Haakon Bugge wrote:
> > I would much prefer if you could move RDS off that horrible API finally
> > instead of investing more effort into it and making it more complicated.
> 
> ib_alloc_cq() and family does not support arming the CQ with the IB_CQ_SOLICITED flag, which RDS uses.

Then work on supporting it.  RDS and SMC are the only users, so one
of the maintainers needs to drive it.


