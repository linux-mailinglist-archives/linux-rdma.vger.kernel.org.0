Return-Path: <linux-rdma+bounces-4342-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4593694FA27
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 01:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A591C22257
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 23:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCC018C92D;
	Mon, 12 Aug 2024 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SmOqffh9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492DE17BB35
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723504374; cv=none; b=MJW9YPvMkRfCI4cg253A375JddfTdFUFAdsSnlQ7ptrV1EKDaesmrWT4wlCoVqIYiZBPAm+RoHld4pXOPy7pMe6YZR7SWx/IgksSPFAL5YsmQRlh12gD0ExIwDIagjQPjJpviRv0t8viEcUwvY8SMLBrFAhlL5q7Sx0z8iz4YhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723504374; c=relaxed/simple;
	bh=h8P4Uotzl/+p3fOqN0ouVYZU+tVOEs1/jaWkykqyvfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdVul9AQXypvuFOX2On+qmxodBxD4BZhkgcCs53/JdcxUsL9vhz9FhKC3Q8aCVInTdqTUzlNlhWfWrH/CLjKVuevj4KPbsnGmCazUDjlZZL/Iw+PUuK1rDcZfKwYzUbkPHPSDzonA53bP4esk3VsE8f+Zxw7iYyInJvC7Qy4qHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SmOqffh9; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1da036d35so312351585a.0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 16:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723504372; x=1724109172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMjC6KhS/DBc58mLY7O4E24ckqj/K1IN+aMXWT+eFAQ=;
        b=SmOqffh9hSEZUqCcB1VSHYM/ghMbTKidcdvHfLwvR4300Uyqy5lZxk6Yy4xeYGbGFy
         KakpC4u9I7w9Jv9y2p9wTW/TpCRejV6ntcgu04SQaasJfO4pLb3rfa7RteyoSTUXSGiw
         yO7weL8YAsZ6rF52XvfAMx3WlTyqkAp4UZfBEVSeiqaudePCrHbfLLAiC0QLLT0DcyVL
         5tabUmxpaycP3VvC4mSTsPbAMtRsaLWLmQxSXydcG1PsSr/96yoy9e/ZkRDsdMc5nnpJ
         UbzK78QWEajErL94HnCnBB9oUJcsIEs3S5ELJhJSBe2I7B/KwS99Np5JSVfJTCEJKM2f
         CBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723504372; x=1724109172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMjC6KhS/DBc58mLY7O4E24ckqj/K1IN+aMXWT+eFAQ=;
        b=WRuRgwS/bVkWR0IZixMginjHYsoLbDWmf+Z/ygBMRDbUu+wZn7ycXBA2mYvRDgGnTI
         ic/vK2S8JZ/wHsDQZCRNgNpgG9l83yv7i2zfAgjU7EKvysqCk8DdeD87vA+csGt4kMwt
         Zs+MaGAcoxxzUj5h0PfiKaDVpAUcmfxFQF0OPiS2ejjFv913v/2IFZx9YHYnP0U2eY+J
         Lot34acvjlRxXIidaTmZoqPeUmJ4V8LU90hyzbwRK++F58LmkI9S0ALSgB+d90Fbu56G
         HGDURTSzTxCToVfrqsW1/5dxNZ6dyonhRhHFwC2Hy5LIPP3uPAEMcvukoC7pUaPPvVxw
         cICQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBM9JSSxdtZa2TZLcG2uiYcba3NtlGYFubDENO786N+Fyimc5diwxd1/8WzRzQAUJeK7E1s9uDZmWYvxICT5BL93BYDL2n5JAICA==
X-Gm-Message-State: AOJu0Yzn/O5NLPHd7zs5Apd8NSw0/o9/6faMGge1Wnn5MteqzB+Cr8P5
	XpBNFEGDz4riE5/X2IYyOi3Vwkwe62F4XlzwKyo9DL8pxDRZ+rlezGAD4bf4bMU=
X-Google-Smtp-Source: AGHT+IEpwb1c6X4g483ibQty6P9YNt2S2AvdGjI5tc/NjzzDCUGnXhu4CwRzClQuuw6N0eK8ESuT1g==
X-Received: by 2002:a05:620a:240f:b0:7a1:da5e:c501 with SMTP id af79cd13be357-7a4e160fda9mr193930785a.60.1723504372080;
        Mon, 12 Aug 2024 16:12:52 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d79076sm286600585a.60.2024.08.12.16.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 16:12:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sdeDZ-003VqS-T1;
	Mon, 12 Aug 2024 20:12:49 -0300
Date: Mon, 12 Aug 2024 20:12:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: Martin Oliveira <martin.oliveira@eideticom.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>, Tejun Heo <tj@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Sloan <david.sloan@eideticom.com>
Subject: Re: [PATCH v5 3/4] mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
Message-ID: <20240812231249.GG1985367@ziepe.ca>
References: <20240808183340.483468-1-martin.oliveira@eideticom.com>
 <20240808183340.483468-4-martin.oliveira@eideticom.com>
 <ZrmuGrDaJTZFrKrc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrmuGrDaJTZFrKrc@infradead.org>

On Sun, Aug 11, 2024 at 11:39:22PM -0700, Christoph Hellwig wrote:
> On Thu, Aug 08, 2024 at 12:33:39PM -0600, Martin Oliveira wrote:
> > This check existed originally due to concerns that P2PDMA needed to copy
> > fsdax until pgmap refcounts were fixed (see [1]).
> > 
> > The P2PDMA infrastructure will only call unmap_mapping_range() when the
> > underlying device is unbound, and immediately after unmapping it waits
> > for the reference of all ZONE_DEVICE pages to be released before
> > continuing. This does not allow for a page to be reused and no user
> > access fault is therefore possible. It does not have the same problem as
> > fsdax.
> > 
> > The one minor concern with FOLL_LONGTERM pins is they will block device
> > unbind until userspace releases them all.
> 
> This is unfortunately not really minor unless we have a well documented
> way to force this :(

It is not that different from blocking driver unbind while FDs are
open which a lot of places do in various ways?

Jason

