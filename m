Return-Path: <linux-rdma+bounces-1411-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0FC87A1B0
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 03:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27DCF1F22C6D
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 02:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88088AD5D;
	Wed, 13 Mar 2024 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZHU0mfqx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B6E6FCB
	for <linux-rdma@vger.kernel.org>; Wed, 13 Mar 2024 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710297614; cv=none; b=MZr8XXIdxJoGLLVmiPGPYQvpZiOdS5E0ZijSElH8iHVx+CfSJDyKiCtKKyjnz7d7MQ54Zuco/Q7Zb2ckWKhzgDjyWxIcGVk1yAkJ7a66XJyVmCRlsCccms29AvqkDd2Ajx601mkW8ZEK7TwYe2n0jlrvmvayge6fH5TCcZOqytk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710297614; c=relaxed/simple;
	bh=d8yP5C/uRVJUpTyrODi7OEs0/2wDESi65JU0aok+SmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOZht5d2OypbDUXOc7ub+25bCtiQnUE7nfIg46oUHY/0o+oYUWcXbQg3uMNCdaYDjqxRpxMfdsxlaVvCByPQ5IssfQMlBrO0vDvGTMiRRwI5Lnl6GGdSUsUc7ysr8itJqTJZx02ot8xiKj7v1gXH7EUeQOJ7bbs190CYTbkXYQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZHU0mfqx; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710297608; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=j7eWfrUbNkAibvSEjg8kNEwuu12k7MjNIuplVdvipN4=;
	b=ZHU0mfqxTWNkSia7Pnye5M6bS3bIaI5lHF9tOJPK6L/RJ1gJaaAJ2YDSeVzRcaB7aqcjTyDNoICsztK9xrXJ66HFLPADBXBS5CNyaG9llqRMI2PO/OtPzaHT9HrXIHKqBlidY+GqFj8D8a2LtpBOEjec1nBgKx/z8dyxXAikY40=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=boshiyu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2NIoMG_1710297607;
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0W2NIoMG_1710297607)
          by smtp.aliyun-inc.com;
          Wed, 13 Mar 2024 10:40:08 +0800
Date: Wed, 13 Mar 2024 10:40:06 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, chengyou@linux.alibaba.com,
	KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 3/3] RDMA/erdma: Remove unnecessary __GFP_ZERO
 flag
Message-ID: <ZfESBtLmXfs27Ya-@xy-macbook.local>
References: <20240311113821.22482-1-boshiyu@alibaba-inc.com>
 <20240311113821.22482-4-boshiyu@alibaba-inc.com>
 <20240312105305.GR12921@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312105305.GR12921@unreal>

On Tue, Mar 12, 2024 at 12:53:05PM +0200, Leon Romanovsky wrote:
> On Mon, Mar 11, 2024 at 07:38:21PM +0800, Boshi Yu wrote:
> > From: Boshi Yu <boshiyu@linux.alibaba.com>
> > 
> > The dma_alloc_coherent() interface automatically zero the memory returned.
> 
> Can you please point to the DMA code which does that?

We have noticed a patchset which ensures that dma_alloc_coherent() always
returns zeroed memory. The url of this patchset is listed as below:
https://lore.kernel.org/all/20181214082515.14835-1-hch@lst.de/T/#m70c723c646004445713f31b7837f7e9d910c06f5

Besides, you may refer to commit 518a2f1925c3 ("dma-mapping: zero memory returned from dma_alloc_*")
for details. This commit zeros memory by passing __GFP_ZERO flag or
calling memset internally. For example, the dma_alloc_direct() interface
calls memset() to zero the allocated memory.

Thanks,
Boshi Yu

> 
> > Thus, we do not need to specify the __GFP_ZERO flag explicitly when we call
> > dma_alloc_coherent().
> > 
> > Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
> > Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
> > ---
> >  drivers/infiniband/hw/erdma/erdma_cmdq.c | 6 ++----
> >  drivers/infiniband/hw/erdma/erdma_eq.c   | 6 ++----
> >  2 files changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/erdma/erdma_cmdq.c b/drivers/infiniband/hw/erdma/erdma_cmdq.c
> > index 0ac2683cfccf..43ff40b5a09d 100644
> > --- a/drivers/infiniband/hw/erdma/erdma_cmdq.c
> > +++ b/drivers/infiniband/hw/erdma/erdma_cmdq.c
> > @@ -127,8 +127,7 @@ static int erdma_cmdq_cq_init(struct erdma_dev *dev)
> >  
> >  	cq->depth = cmdq->sq.depth;
> >  	cq->qbuf = dma_alloc_coherent(&dev->pdev->dev, cq->depth << CQE_SHIFT,
> > -				      &cq->qbuf_dma_addr,
> > -				      GFP_KERNEL | __GFP_ZERO);
> > +				      &cq->qbuf_dma_addr, GFP_KERNEL);
> >  	if (!cq->qbuf)
> >  		return -ENOMEM;
> >  
> > @@ -162,8 +161,7 @@ static int erdma_cmdq_eq_init(struct erdma_dev *dev)
> >  
> >  	eq->depth = cmdq->max_outstandings;
> >  	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT,
> > -				      &eq->qbuf_dma_addr,
> > -				      GFP_KERNEL | __GFP_ZERO);
> > +				      &eq->qbuf_dma_addr, GFP_KERNEL);
> >  	if (!eq->qbuf)
> >  		return -ENOMEM;
> >  
> > diff --git a/drivers/infiniband/hw/erdma/erdma_eq.c b/drivers/infiniband/hw/erdma/erdma_eq.c
> > index 0a4746e6d05c..84ccdd8144c9 100644
> > --- a/drivers/infiniband/hw/erdma/erdma_eq.c
> > +++ b/drivers/infiniband/hw/erdma/erdma_eq.c
> > @@ -87,8 +87,7 @@ int erdma_aeq_init(struct erdma_dev *dev)
> >  	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
> >  
> >  	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT,
> > -				      &eq->qbuf_dma_addr,
> > -				      GFP_KERNEL | __GFP_ZERO);
> > +				      &eq->qbuf_dma_addr, GFP_KERNEL);
> >  	if (!eq->qbuf)
> >  		return -ENOMEM;
> >  
> > @@ -237,8 +236,7 @@ static int erdma_ceq_init_one(struct erdma_dev *dev, u16 ceqn)
> >  
> >  	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
> >  	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT,
> > -				      &eq->qbuf_dma_addr,
> > -				      GFP_KERNEL | __GFP_ZERO);
> > +				      &eq->qbuf_dma_addr, GFP_KERNEL);
> >  	if (!eq->qbuf)
> >  		return -ENOMEM;
> >  
> > -- 
> > 2.39.3
> > 
> > 

