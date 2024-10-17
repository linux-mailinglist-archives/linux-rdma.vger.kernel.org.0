Return-Path: <linux-rdma+bounces-5448-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0609A247D
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 16:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D451F22157
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 14:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859911DE4EB;
	Thu, 17 Oct 2024 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Iw2DsSNL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FB01DE3DC
	for <linux-rdma@vger.kernel.org>; Thu, 17 Oct 2024 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173916; cv=none; b=hFUpBB2U9tAOayomHpXyxGf5aaejrH8TGkBjTy3rCotcXeNQc36aF+lPj81eKCBakCSuVZkJxx390nmJccVsJCzOPPKP4LNoFuZhK/XXLPAF/X0TExYQ545K2hHuAChD9FzKYBJ60BM5uEeuwskBREFAxeD3f0+vaedXeer/4XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173916; c=relaxed/simple;
	bh=BCSyNAteMu1R2S9zBBq/QcTKowbWGSCB6OBP/rG26HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GarCeABENrjzAE8TrtsoaG/3YbRGFfXYLIcPVbSRUyVfFpcSw6OKC1mu85+7HYdJVcx9H30zu5bnNcVWxjJx+AM//itldxIag2TbgoSPYRCPsDbxk4lUYnmZOb21OPdR/6UrChrAtv7CeTAGYrEe+YuxKmIsaApU2Eb1rrMVJ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Iw2DsSNL; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbe3e99680so5171156d6.3
        for <linux-rdma@vger.kernel.org>; Thu, 17 Oct 2024 07:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729173909; x=1729778709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z7OJ+A0M+7sK83vQ9Fm7CrxVR6UTlfXfFle4pTLoIZk=;
        b=Iw2DsSNLFin4NHNNG65PVUBy4bUiu9s7s18bETKJQCYLfZdta875n0xZOYSWP2v0WN
         TP6OIxW+1hSRVbG5Z4OKO21J1MtwRmS3uIkl3P+JgstHXLMNyqcMJM57bXwrjP3tZ3kB
         +VKY6rXXaMRE3ozSahLPeRocznzsXgWiX4+Barz5NYHKqETe0FZ6Eys8AX50kXH13oHO
         ejxbrQ4Z/OmnstIb6w988NczuhLiMuGDJwEDaOdilQEJ+ZNcQ+GDTFu5CMYGFWO/L0WI
         bQmk5CjPE9OQdqqrP6m86yrwJd8ZfAWZ15gH4RT8F6pvzAhuuSHme2t4KIA42bCqBr1/
         D4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729173909; x=1729778709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7OJ+A0M+7sK83vQ9Fm7CrxVR6UTlfXfFle4pTLoIZk=;
        b=a8cfSw8T8YDrt1Tz4SUJM64Engr17kgeEVfUaCOBAQTjaBiVCjKjAdoObd3egQl5v+
         oqieyGYlWaegDb3VOZPCeE7wuZ6nPTrYmWJNQ0tmtzVE5WwBRFYcah7ku9HNDMNEkLWx
         fAH5RM1tP/rUu/zo1KGJj7bHxjCleVbWzxpDuvP6SJFMPslnMpMH8y3IbfpS7zVTpcFl
         SULXFg10JBPYjBvwGAOyrvJLnMjGEeFw23dJAczf5rB+8CmkZ+Xh5UE059kO2n0Rtrka
         so9K/J5msd5Zwj47046xeGKyJO7vaVVCTUl0rlp+i8PDT5wSCINbeVmuD+sxeY5NiMFr
         +flA==
X-Forwarded-Encrypted: i=1; AJvYcCVtFlpeKRgCeDwuYY+hdL8g+vAfoAhAnGfxAEaatacypNjK7URDaJTm/9HxpGIiopYC9VeH8MNjvhnU@vger.kernel.org
X-Gm-Message-State: AOJu0YyuyXNf4Pcl2T2NcMeutsRlJlThtJc9OVGl856dAEqE9dq2BCVz
	5BBWYmGnLHlBdMxUNwFWE9UZ5qXuH/Qp+WhYfSoUQ7OB8U6u4o4/n6LPLUV73C4=
X-Google-Smtp-Source: AGHT+IHal8p/zFk/MmJsuAonYG12bCKHBoHHm6lVzKtXA3QkUgZLBGuCRV/wmp+GJALXP2rbtY7uRw==
X-Received: by 2002:a05:6214:31a1:b0:6cb:c72d:6861 with SMTP id 6a1803df08f44-6cc2b8cbc62mr89798966d6.14.1729173908808;
        Thu, 17 Oct 2024 07:05:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22921c60sm28522656d6.51.2024.10.17.07.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 07:05:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1R7j-0041fS-QX;
	Thu, 17 Oct 2024 11:05:07 -0300
Date: Thu, 17 Oct 2024 11:05:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yonatan Maman <ymaman@nvidia.com>, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, herbst@redhat.com, lyude@redhat.com,
	dakr@redhat.com, airlied@gmail.com, simona@ffwll.ch,
	leon@kernel.org, jglisse@redhat.com, akpm@linux-foundation.org,
	dri-devel@lists.freedesktop.org, apopple@nvidia.com,
	bskeggs@nvidia.com, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v1 1/4] mm/hmm: HMM API for P2P DMA to device zone pages
Message-ID: <20241017140507.GB948948@ziepe.ca>
References: <20241015152348.3055360-2-ymaman@nvidia.com>
 <Zw9F2uiq6-znYmTk@infradead.org>
 <20241016154428.GD4020792@ziepe.ca>
 <Zw_sn_DdZRUw5oxq@infradead.org>
 <20241016174445.GF4020792@ziepe.ca>
 <ZxD71D66qLI0qHpW@infradead.org>
 <20241017130539.GA897978@ziepe.ca>
 <ZxENV_EppCYIXfOW@infradead.org>
 <20241017134644.GA948948@ziepe.ca>
 <ZxEV6ocpKLjPC8H4@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxEV6ocpKLjPC8H4@infradead.org>

On Thu, Oct 17, 2024 at 06:49:30AM -0700, Christoph Hellwig wrote:
> On Thu, Oct 17, 2024 at 10:46:44AM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 17, 2024 at 06:12:55AM -0700, Christoph Hellwig wrote:
> > > On Thu, Oct 17, 2024 at 10:05:39AM -0300, Jason Gunthorpe wrote:
> > > > Broadly I think whatever flow NVMe uses for P2P will apply to ODP as
> > > > well.
> > > 
> > > ODP is a lot simpler than NVMe for P2P actually :(
> > 
> > What is your thinking there? I'm looking at the latest patches and I
> > would expect dma_iova_init() to accept a phys so it can call
> > pci_p2pdma_map_type() once for the whole transaction. It is a slow
> > operation.
> 
> You can't do it for the whole transaction.  Here is my suggestion
> for ODP:
> 
> http://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/dma-split-wip

OK, this looks very promising. I sketched something similar to the
pci-p2pdma changes a while back too.

BTW this:

  iommu: generalize the batched sync after map interface

I am hoping to in a direction of adding a gather to the map, just like
unmap. So eventually instead of open coding iotlb_sync_map() you'd
flush the gather and it would do it.

> For NVMe I need to figure out a way to split bios on a per P2P
> type boundary as we don't have any space to record if something is a bus
> mapped address.

Yeah this came up before :\ Can't precompute the p2p type during bio
creation, splitting based on pgmap would be good enough.

Jason

