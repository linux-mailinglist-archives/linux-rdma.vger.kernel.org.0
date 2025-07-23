Return-Path: <linux-rdma+bounces-12402-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135FEB0E95A
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 05:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D733AA227
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 03:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F495202C30;
	Wed, 23 Jul 2025 03:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bK+KGqnT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14192AE72
	for <linux-rdma@vger.kernel.org>; Wed, 23 Jul 2025 03:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753242708; cv=none; b=rTZrFe1rAjIDrsAxgaSxGOMhmR3AhEfqpLObxZcLW0uo1DW5Ufd44Tof6LPU0czyZuTYHyhcO1DioBcfjx3Gl9wyrABAlfe+XjMSwHMkkTOJHkEWmluMPAzuO0dWvt94Ixg0vIJ2z8pxK6/ZU8b/lHONAnjc4kRGmNwFBlAYTSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753242708; c=relaxed/simple;
	bh=g1D4R+y8GTymFwV80C1L2cx2UaXGlgshC+EanWWy6Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaKax4nNZ6rwFIme0ykRAmBT4+loeOGxfl/4XrT7A/pBMun5sbBcQbP0voLTafpfEz6MtQrDamqdGJxt1X4JMq2FU5s+1nCvyaoIyN0xIHso70o4CKbgeh1oZS/SigZPPpSfFiwM2wqT214uTiDLIq/jNkus2aupKF8Jyo02U7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bK+KGqnT; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-749248d06faso5294860b3a.2
        for <linux-rdma@vger.kernel.org>; Tue, 22 Jul 2025 20:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753242706; x=1753847506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r0yhqhfmgcWd4Boy+yEMxc9KNWgoVjI2gD67+Le01vg=;
        b=bK+KGqnTFcD4sTo+Dgf3WduUx90IevQRf0znLXgpwsQmPuI2jrGxLhZ2QVPrRiwf0/
         A2tNrTZ4Y/EtNmc2dDexDyL72YAt3zOXcC2wHP1KV6JGKrHgCF3DQjeW5Z3LZzWGOHTr
         BLVi8auTwZxt5tMZi7c2Kkpy+nSfOzyxDsVQ0I9xWiOdkdZuaLFg575sXlnHLcUhWbH7
         ylbvtO1q+Cr9mq9dpKSkaWM0F/0RSB4U4JRGapBFL7tRHAkcjiaQ+9HY+eoUOoJnpURw
         9OnnGtseFciEbQvC3FAzvnClMwB23iBBOdXusupZkarPfWdPETS+Nyujvr7RrNHKeRM0
         dxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753242706; x=1753847506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0yhqhfmgcWd4Boy+yEMxc9KNWgoVjI2gD67+Le01vg=;
        b=pTH0FHA0CRWXTd9InfC7FgBlR9d90bxHznc6q6ycFSzD86dVsx9RyQm07Udcczj9HR
         NY6i/1aEM/uNuhxvxngp3hpWKqW9TbYfFS9CJO5nQS5bHzhTibK8jQI6IVD930aPewk4
         mK8Tf+/3xhe2PviOTGKX4fH+7iCt1BH9Wt45HPz1CCoLa1BkyMP8KINghsskkBrFhq0P
         biVQl/KSc/yew9wiOyFR4tCrGj7uUrzXJYxdL+RH+kGYrcCiP5zVjb58VSdcf9LQzkXt
         yqQmljC30CI5BFCuaZkPtQ6o4CF1Kxy0jvtZpeMBzTcXapRSO3AvbezB0L3nW7vphOET
         zP8A==
X-Forwarded-Encrypted: i=1; AJvYcCUzlZl6B0EGSvoeVkv54jTj2l9ynpB67TBVJZJBEWost4tVwR6U8fsGpZ0ksiKhVd7EiHFYv6q40aLR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu8xhPL1v7fUnrl5OLMhd0hMuE/zmrnhRrLhz5CiDL5D2TYOcP
	7RWireG91B9GJXkEgBLktW3Mhs0QEKFRsGotRS+Pc877P8S/5Gp77u+uT4X85yC8J80=
X-Gm-Gg: ASbGncsNgtKhdQerIVad6eLKy05UsH4wqaQqvneUfMP6GLz31XcgRdYzq5fZ9Ilx4ar
	NWHPhia8/Tk/S1bGzPoi9I3bX4nk0wlMmGVhO16reUt7IEdcQDmnVErK5jS+WGreoOm7rztxObK
	1Uwv+UG2G3pHz7urHhfA/tbBN7HoS5OcgVApD3QeY1kAD3vfuMKqA6v5sR1mtuJimvLMiSLthdO
	/uMVkjr+9LPhCLPHsMIrbgXJ1/9fjQcAWumBNGA2mWQW5so61umNPd4q1pNXU5YWb/D4PkPq/eg
	3FNpHoDLR1K8uBSLIe8ecYPMKYEX5dGAZ5xxx9qUy9HDG4YvYrASMVkBSwX2CkQengQm4oLDyci
	2xj8nKhFFovEp7f0ySWXrKLzPAWcvLyEWYoY=
X-Google-Smtp-Source: AGHT+IFhuc9YoswnVjbx+w6CW5AJc04rjosHA7fJ9MRqxxtRH8l6eukiOU6gxLlrv7CiSglvAulz8g==
X-Received: by 2002:a05:6a00:1491:b0:748:f406:b09 with SMTP id d2e1a72fcca58-760367de539mr2440550b3a.23.1753242705935;
        Tue, 22 Jul 2025 20:51:45 -0700 (PDT)
Received: from ziepe.ca (S010670037e345dea.cg.shawcable.net. [68.146.128.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89d3190sm8518497b3a.39.2025.07.22.20.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 20:51:43 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ueQW6-0003Fi-CT;
	Wed, 23 Jul 2025 00:51:42 -0300
Date: Wed, 23 Jul 2025 00:51:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>, Yonatan Maman <ymaman@nvidia.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leon Romanovsky <leon@kernel.org>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v2 1/5] mm/hmm: HMM API to enable P2P DMA for device
 private pages
Message-ID: <aIBcTpC9Te7YIe4J@ziepe.ca>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250718115112.3881129-2-ymaman@nvidia.com>
 <aHpXXKTaqp8FUhmq@casper.infradead.org>
 <20250718144442.GG2206214@ziepe.ca>
 <aH4_QaNtIJMrPqOw@casper.infradead.org>
 <7lvduvov3rvfsgixbkyyinnzz3plpp3szxam46ccgjmh6v5d7q@zoz4k723vs3d>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7lvduvov3rvfsgixbkyyinnzz3plpp3szxam46ccgjmh6v5d7q@zoz4k723vs3d>

On Tue, Jul 22, 2025 at 10:49:10AM +1000, Alistair Popple wrote:
> > So what is it?
> 
> IMHO a hack, because obviously we shouldn't require real physical addresses for
> something the CPU can't actually address anyway and this causes real
> problems

IMHO what DEVICE PRIVATE really boils down to is a way to have swap
entries that point to some kind of opaque driver managed memory.

We have alot of assumptions all over about pfn/phys to page
relationships so anything that has a struct page also has to come with
a fake PFN today..

> (eg. it doesn't actually work on anything other than x86_64). There's no reason
> the "PFN" we store in device-private entries couldn't instead just be an index
> into some data structure holding pointers to the struct pages. So instead of
> using pfn_to_page()/page_to_pfn() we would use device_private_index_to_page()
> and page_to_device_private_index().

It could work, but any of the pfn conversions would have to be tracked
down.. Could be troublesome.

Jason

