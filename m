Return-Path: <linux-rdma+bounces-4037-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF8693E3FB
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 09:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D321F2191C
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 07:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A575B676;
	Sun, 28 Jul 2024 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLD1huKh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE6B8F62
	for <linux-rdma@vger.kernel.org>; Sun, 28 Jul 2024 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722153172; cv=none; b=lDZdmkvx5GHt0dmFSDW/Ct5xjb+bfXTESp9JKl68XbharKM+hs5OwaH7vYYACbn4j22ukHn6M2ggwNV9FB/02ASIakVdFeZ986vuVfCiOig0WDoA+5yln5kQVxQltpHH76mg1fwYEWYbV+j8TMPLIs58AmErmirW532k1I7DzvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722153172; c=relaxed/simple;
	bh=rUhqdlApYjjMPxke4m3P+lMNLO2+snERLnyBGjDbJP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+hbCDCH4JEx++bZncWt/2xu9A2oqQNRp+xMjWN7s+G+16ETKwzaBmP9OsLhopaGAbEWOKpss45Au/k/dhV4GwgB8/G0//sIQ0fORlbnV4ICo4wMdg00qzVK/RvgJ5RouIfzlmRS4oGrX4mr5qx7O1d9w39AtZ8akxfh8D8x2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLD1huKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26858C4AF09;
	Sun, 28 Jul 2024 07:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722153171;
	bh=rUhqdlApYjjMPxke4m3P+lMNLO2+snERLnyBGjDbJP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLD1huKh/YsJVdF9t0eVlg9gwiD9C7e6gzKXEloiiax1Qx/OLaYmELhnI7v5cJd/2
	 3gdMeEc2ftgSKbx3ZkHlAsXDTIeNsIAP+P499ejzyeOxmgW7NUC6foA8agBFSHw0xf
	 Mae4dnH6IfkXIP1OhckqEihZmrHlMWnAaRuw+XzRycQNxPIkZSRe/KsRUoHUv6HoHs
	 cmuWapbFV7SBBjo3LlVVpe/BFEE+sbCkV8DWifMyrZl0w6ML9L+sHIC1pl0AzI5yGC
	 MsJLPucsdu2GXjeODxGL1YHX6XQzdaBuUTqZvr6yL23dRt8uIJ13tw2gITFKBW13Tv
	 CHf9euRuDN62A==
Date: Sun, 28 Jul 2024 10:52:47 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dean Luick <dean.luick@cornelisnetworks.com>
Cc: flyingpenghao@gmail.com, dennis.dalessandro@cornelisnetworks.com,
	linux-rdma@vger.kernel.org, Peng Hao <flyingpeng@tencent.com>
Subject: Re: [PATCH] infiniband/hw/hfi1/tid_rdma: use kmalloc_array_node()
Message-ID: <20240728075247.GB4296@unreal>
References: <20240725071716.26136-1-flyingpeng@tencent.com>
 <db63e419-8185-4c45-8e59-2756013c73c3@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db63e419-8185-4c45-8e59-2756013c73c3@cornelisnetworks.com>

On Thu, Jul 25, 2024 at 08:46:30AM -0500, Dean Luick wrote:
> On 7/25/2024 2:17 AM, flyingpenghao@gmail.com wrote:
> > From: Peng Hao <flyingpeng@tencent.com>
> >
> > kmalloc_array_node() is a NUMA-aware version of kmalloc_array that
> > has overflow checking and can be used as a replacement for kmalloc_node.
> >
> > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > ---
> >  drivers/infiniband/hw/hfi1/tid_rdma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
> > index c465966a1d9c..6b1921f6280b 100644
> > --- a/drivers/infiniband/hw/hfi1/tid_rdma.c
> > +++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
> > @@ -1636,7 +1636,7 @@ static int hfi1_kern_exp_rcv_alloc_flows(struct tid_rdma_request *req,
> >
> >       if (likely(req->flows))
> >               return 0;
> > -     flows = kmalloc_node(MAX_FLOWS * sizeof(*flows), gfp,
> > +     flows = kmalloc_array_node(MAX_FLOWS, sizeof(*flows), gfp,
> >                            req->rcd->numa_id);
> >       if (!flows)
> >               return -ENOMEM;
> 
> This is clearly not going to overflow.  I see no reason to change it.
> 
> However, I don't know the current policy on such replacements.

There is no policy. My preference is to change if other changes are done in
the same area, but do not change something that is not broken.

Thanks

> 
> -Dean
> 
> External recipient
> 

