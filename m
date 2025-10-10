Return-Path: <linux-rdma+bounces-13812-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ABABCBF05
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Oct 2025 09:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9E3189EDF5
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Oct 2025 07:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA32E273D8D;
	Fri, 10 Oct 2025 07:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="nzgUTRcs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01281227E83;
	Fri, 10 Oct 2025 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760081886; cv=pass; b=PYxSfTEAZK+tltSuCbRw5Nzbhc++HPC75+6SIDAlwt9Ti2+2uAjt8kOAH7fXRWgUnZXJPysYgthS+UEW1J8EugfhUKVEK7mYVd5S/4z8ven+cKQqWJiNPmoE5sPoSRkAJIbg3mSB8/fgS3y0sItev3RnmUoiYVQRFeJ9Tfm/a2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760081886; c=relaxed/simple;
	bh=S5Dur9E4bnWqvwZZOOpP1cfxfTQ1iQSQykB90QyHov4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5mkr5Co0OiJvkGvCgBDaP04Xf7CO16rPT+IJJ6shcpTtSuxel/bfHBOk5ZFkZwh8aZWDKYGuMfEtUUKpGJS22rDCssPrlFLZUHj+uvfMuIce8d5PYJmda0I3bprNNaSv9KPfEwhLqkT4AMxkax/+NsElrJcSkGPVpY3ZXhv54c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=nzgUTRcs; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
Received: from osx.local (ecs-119-8-240-33.compute.hwclouds-dns.com [119.8.240.33])
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 59A7bb3v2454402
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 15:37:43 +0800
ARC-Seal: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse; t=1760081864; cv=none;
	b=m3+eEHSQ1x50dT22qoukC9+3q9ff3C/Zcba3sHm+Y+hKsS0+Vh/KfuWbi3Efa9KVePI4HtGyLG7g/Xu2jKRs1KA42NhmsiJxdvGEugBHw6oatjpsDNn6t7m9J6qIDCxkJmrZV9DFI+ZTt8eOHMa6s5NMmzNinHxv1lhL88dDLaE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse;
	t=1760081864; c=relaxed/relaxed;
	bh=4hgIF15Im3inoLrgi6hXNiW3j7NJcEjqG1FWozj37aU=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Q2e3+Wc5xTnkp2Yvx0DFezOMp/CKo/2iba7pkeh3nx8EMCC4LwEP/swdFey9gQaF1V4brnX2SYFOicGlj2CxueC5Rnz+WsHVe5KlApXJGsR4aIDAG/ouUYQ3syNICwAeptPQjiWy9ZRZmcKX1s5EgyAWT2gCCzGMvF79PQIKfUE=
ARC-Authentication-Results: i=1; cse.ust.hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1760081864;
	bh=4hgIF15Im3inoLrgi6hXNiW3j7NJcEjqG1FWozj37aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nzgUTRcsBc4ue7TDfqaTl0VAVIMfCQXBpVuytFNivF5SmY2i8TgnfRmhPp2/NWnR3
	 ZTuY/B314rmnykI+m/CuwC106I3w/RTL2eV6JAd1jlyJuZdf1wztD9b4JxFPg/ndDf
	 e12ZYTcN71ZVbUynjgNLqBb1aBDSsZdPB7LabNxg=
Date: Fri, 10 Oct 2025 15:37:31 +0800
From: Shuhao Fu <sfual@cse.ust.hk>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/uverbs: fix umem release in UVERBS_METHOD_CQ_CREATE
Message-ID: <aOi3u82R9pLLdr4I@osx.local>
References: <aOflenF0XHtm80G9@homelab>
 <20251009184854.GB14552@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009184854.GB14552@unreal>
X-Env-From: sfual

On Thu, Oct 09, 2025 at 09:48:54PM +0300, Leon Romanovsky wrote:
> On Fri, Oct 10, 2025 at 12:40:26AM +0800, Shuhao Fu wrote:
> > In `UVERBS_METHOD_CQ_CREATE`, umem should be released if anything goes
> > wrong. Currently, if `create_cq_umem` fails, umem would not be
> > released or referenced, causing a possible leak.
> 
> It is only partially true. UMEM is released inside .create_cq_umem()
> implementation. However there is an issue there that it doesn't release
> in all flows. You need to change efa_create_cq_umem() too.
> 

My apologies for overlooking the umem release in `.create_cq_umem`. I have
sent out patch v2 [1] for this issue. In v2, the driver should not release
umem on failure, avoiding possible double free here.

[1] https://lore.kernel.org/linux-rdma/aOh1le4YqtYwj-hH@osx.local/

> > 
> > Fixes: 1a40c362ae26 ("RDMA/uverbs: Add a common way to create CQ with umem")
> > Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
> > ---
> >  drivers/infiniband/core/uverbs_std_types_cq.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
> > index 37cd37556510..9344020dede1 100644
> > --- a/drivers/infiniband/core/uverbs_std_types_cq.c
> > +++ b/drivers/infiniband/core/uverbs_std_types_cq.c
> > @@ -193,8 +193,10 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
> >  
> >  	ret = umem ? ib_dev->ops.create_cq_umem(cq, &attr, umem, attrs) :
> >  		ib_dev->ops.create_cq(cq, &attr, attrs);
> > -	if (ret)
> > +	if (ret) {
> > +		ib_umem_release(umem);
> >  		goto err_free;
> > +	}
> >  
> >  	obj->uevent.uobject.object = cq;
> >  	obj->uevent.uobject.user_handle = user_handle;
> > -- 
> > 2.39.5
> > 
> > 

