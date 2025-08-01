Return-Path: <linux-rdma+bounces-12565-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F09B185FA
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Aug 2025 18:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C54854692F
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Aug 2025 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9DA1C3C14;
	Fri,  1 Aug 2025 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MTNFV2F3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206051ACEAF
	for <linux-rdma@vger.kernel.org>; Fri,  1 Aug 2025 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066801; cv=none; b=u1Q28BEflFoAD/fVrg2/7RTIV+PWh+8sMcW0XF+SeTg9ajgbvmLWWrtiI9fhG4JelafFQALtd/cmu5+GD8kpM/JD2qzGtqYPT+8WvvDH1yaSau915fsro+F062hPBHP0bTr7Cywcq/qWzNE23pPBPTpntVDy/YFF5+nSZvJUOlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066801; c=relaxed/simple;
	bh=m1M89TETP+J1IQAu9w4QTKb4VwkHxMScxMjR/5Na2xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TujTBZEDvDOBfOK1jreYOo1KvEeZ+Obl+pElDfz/bIaKLtVbpUTRJMfS1WYDtPybUVRNSNoReBZeuNFejDVyRGfCsRyID8g0O1F17KtqntqeZiKmAg7XW0l0MzRxsD33nGo1lFSjk9KPEVK6qzuD1RGIWt/znvmvF/49+xTu7Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MTNFV2F3; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4af027d966eso7541821cf.3
        for <linux-rdma@vger.kernel.org>; Fri, 01 Aug 2025 09:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754066799; x=1754671599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5oUm5wK6G92WfMPCbUZUcR35sqkaEU8gvzPmgYYYTFg=;
        b=MTNFV2F3EhdyihpR819XT0u/Gb0o7pwppssHNRDq1xx27TSlX87qDWSASBIOEvbefH
         mV/78yKei1zjqp9Ius5/bD7NrIcz9LjqDXmQaqvCPFkQGtpf7eyLuV7XY93a8f97qGbU
         WIqFVDEWgI1KknfxNsxzGn8VoeiQQNdV+wBL7l3t/bMCjmbIHHhSrAbJFBQDpXokXheS
         +JTaICY942MQviGCYyQI7DJdfQnkTOIu7/fbbjNptlIw5buo/2l5lkEnv6bcgimYWjA3
         dFVVq3k6VVYxzM8u/iFI99n/WH3LBDc/FSwMZE2NR78KMxfAdxFo2QfeheTy2zDRhiLH
         YtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754066799; x=1754671599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oUm5wK6G92WfMPCbUZUcR35sqkaEU8gvzPmgYYYTFg=;
        b=AwzoumR/jNaRvC3JaEV0ZWDc5PBEH32yCHET/X9U00DIm8Qh7OmW/lRYXA0NWrTljE
         g0bKXvPI/HWKa6Qqc8dNf31C4ftZK4h0iuJDOPmZs/tdXD7MRZXpzHYCCwx3f74gAcil
         Fji8MmdTuEV/q6EiO7g0QGneGEdxRCCIuXmULpqOLN8MnSw22szbtyhvg6YKGamaHEy4
         bJ7y13rRLfrj+iKoIrNZ3elHKdd1LMl2vB7txgZyKpIz3bErg2c9Xoqv8b22itOLUQcn
         GJ1jof0QMJ5ICBzmOpz5YRAWxOZjKAQQDGwW1t698oIe0/S/eqKgYTUTJhMwGa4YOb0v
         cL6g==
X-Forwarded-Encrypted: i=1; AJvYcCVX1N0UcQZctsgXjeUjhoDLMi+p5VWCwyRy03afhMsSXvmdbMyIia26g76CBvig4Y3nKP4nuO64GoZl@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl8gMf5E+694RQpQuO3PmpKs5eawsl3mla5liRrNaZLo9elrtl
	Mc11Lah/Cg5IdNpbtEXd7zqDyX3lBdMhFrPKng5GMuI+ZAPVURZQvIRGXcPWMAvIptw=
X-Gm-Gg: ASbGncvMsQ42cFVXJ6CFD/SHwEwZ725OKT3pXTy9MH/E/3GZ+FGdNAaFNKrYQgYTZSa
	Bk3GabEAGm9EVi37MyWsZ8EWelZowAv9HtGcqPydkheZKMeuewo7RK7NNHjZBhuQq6qt9XKXJ5q
	OLv/1bxdJLca6051ZwG+h88GSRS8NYTbqEmAAEclHS5cxO2YV46It/3ZtES640zNmy2EU996QM0
	fcv93wXdkqCrRRxc5rJ7wJVQ1M7iCrf0fC0FCgV9P2WqPV1fbHTd0PwB6bRqHqed/a36s4qbJSP
	G5Z/zO+R3cxGLyRCzTrUm/GBSKWoBAGX1HHsAPi0y5iCy4NV90I8r4LpEgc6uGr+yMg5iS3+duN
	dPYXMJF9DMx/0f5+BSBbnnk2RuNDjAuGtP7R4mcODMrXrKUIbJg95PGLwapo2bebr9Q0K0+xR6S
	jKYuY=
X-Google-Smtp-Source: AGHT+IGVVOWQB4/1iDofT+YAUuJwKo0n0CGvBCRj9fO4gfCwpoC+KN12czXAx1xbZXDfGO7Jsn2RQw==
X-Received: by 2002:ad4:5aaf:0:b0:707:43cb:d9ef with SMTP id 6a1803df08f44-70935fb0820mr5596516d6.21.1754066798378;
        Fri, 01 Aug 2025 09:46:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9d6db9sm23142096d6.14.2025.08.01.09.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:46:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhstx-000000013A0-19T8;
	Fri, 01 Aug 2025 13:46:37 -0300
Date: Fri, 1 Aug 2025 13:46:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yonatan Maman <ymaman@nvidia.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leon Romanovsky <leon@kernel.org>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v2 4/5] RDMA/mlx5: Enable P2P DMA with fallback mechanism
Message-ID: <20250801164637.GE26511@ziepe.ca>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250718115112.3881129-5-ymaman@nvidia.com>
 <aH3mTZP7w8KnMLx1@infradead.org>
 <aIBdKhzft4umCGZO@ziepe.ca>
 <aIHhGi3adOiLykJn@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIHhGi3adOiLykJn@infradead.org>

On Thu, Jul 24, 2025 at 12:30:34AM -0700, Christoph Hellwig wrote:
> On Wed, Jul 23, 2025 at 12:55:22AM -0300, Jason Gunthorpe wrote:
> > On Mon, Jul 21, 2025 at 12:03:41AM -0700, Christoph Hellwig wrote:
> > > On Fri, Jul 18, 2025 at 02:51:11PM +0300, Yonatan Maman wrote:
> > > > From: Yonatan Maman <Ymaman@Nvidia.com>
> > > > 
> > > > Add support for P2P for MLX5 NIC devices with automatic fallback to
> > > > standard DMA when P2P mapping fails.
> > > 
> > > That's now how the P2P API works.  You need to check the P2P availability
> > > higher up.
> > 
> > How do you mean?
> > 
> > This looks OKish to me, for ODP and HMM it has to check the P2P
> > availability on a page by page basis because every single page can be
> > a different origin device.
> > 
> > There isn't really a higher up here...
> 
> The DMA API expects the caller to already check for connectability,
> why can't HMM do that like everyone else?

It does, this doesn't change anything about how the DMA API works.

All this series does, and you stated it perfectly, is to allow HMM to
return the single PCI P2P alias of the device private page.

HMM already blindly returns normal P2P pages in a VMA, it should also
blindly return the P2P alias pages too.

Once the P2P is returned the xisting code in hmm_dma_map_pfn() calls
pci_p2pdma_state() to find out if it is compatible or not.

Lifting the pci_p2pdma_state() from hmm_dma_map_pfn() and into
hmm_range_fault() is perhaps possible and may be reasonable, but not
really related to this series.

Jason

