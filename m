Return-Path: <linux-rdma+bounces-12590-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE16B1B615
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 16:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0141883C0C
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 14:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEF5274B43;
	Tue,  5 Aug 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QCwoi+dh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F87326CE2C
	for <linux-rdma@vger.kernel.org>; Tue,  5 Aug 2025 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754402974; cv=none; b=TZKSm/xmYGO3J94hVHZKI8SnSkUWbKFRYBKcLyFQZRIjEP16eBfQI/ie5Uma0KES5s/aKoiCOOH6XBbTpl+M5yavh5nYhGdgcx5DaGer7xRagZFSWJiv8Q1IYCY3OuF/1RdPSHEM5GNv9sO2dYyPuGgkIOTtAFwsKUV6a9Pk5Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754402974; c=relaxed/simple;
	bh=320HJNn3ZyIhNHt0qLcttuzPG79KlsmiYoJdg+13Uio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VndyCSIKv8/lQ4SsR6jyU0Qv6ndptvCjJL6a28NxFE+28I7JZ++Ur/UkkhjITzvO6NMudZw0UGIGw4vIE5Lds80x4/ynQ0eDueL1kNDNX2JDL0ZioOqq6KLxgQavF7br+OmHEUuTeyAzKN+htvXKYsbQInyZIVeoJALx3gdBCMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QCwoi+dh; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ab61ecc1e8so29043211cf.1
        for <linux-rdma@vger.kernel.org>; Tue, 05 Aug 2025 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754402972; x=1755007772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzAYIR/shPSYacUrOQJo0K9+jh4P0UFNjUkTluGngLM=;
        b=QCwoi+dhAkExXVPD5oTSD9d02H0sgPS7PcyAtJU248kNICO8iYoHOm4wt8fkuMffpZ
         ojGNPywLIyVxHFTnOaMDP2IPwcgSh966mCds2whniBkuoGp+FBqC2PoEZq+w99vHwyh6
         B0xIY2YH9tdCzmewwXwR0fekVxKhu92hO1MXtgwTh+OqBUL8FPAN5RJy7ax88P7i0ugE
         R06JhzV1D4Ir5gI1wD/7hPXEMsMf90IddVQKwb9WkpYR89+3q7Eolz0VC7a5UOtWVeQr
         gJ9qWWAoORZx3nVQvFPoR0ycAfs1j7+5FWqX+EPo+qP5YmN+xWRW2L3rNUX3eYN1GHeG
         aTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754402972; x=1755007772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzAYIR/shPSYacUrOQJo0K9+jh4P0UFNjUkTluGngLM=;
        b=K204BFrXhwqvqbA7D/gVzyoYGZzkyhrVsXlCiuhpe1B5Hn76i9gH+m9QWLrurZ1tqm
         iAhdahcRHrImSd1Uk38M1QO6evyRs9bv2E8ynSTcnOITrT8aLEwZ85KSszHSdop6GR9J
         4v8xfWOeyI8z/hp3gHLVfwaF9/PtUumo66K2wXMBoRqr86RbvmgoiUhUNwfu2+AeIQSv
         cLw6iyTBggGm4St2TxAOTsi376Mrz7wdMgfVCaPzPLcFadJTUtxGZk4GT9yjMnsDad/p
         4kFVaKvJqsWZM1AZ6KE0c3KhKyE/PUwXbbrFFxANw0a9QFiy5k585HF50SHgj4TNHsrT
         Y0pg==
X-Forwarded-Encrypted: i=1; AJvYcCVX286GmAGJL+72BJDF6+Hai/ietZU3yoWMxvtRE05U+cCNFbnPp0v0osbtJSQO8rJI2dVQ5B1xgwaj@vger.kernel.org
X-Gm-Message-State: AOJu0YxiL6UBE3w/VDwfRxxtsutsqbHQPOvAUA0GDIe+wxbVg1VWbkb3
	9pKaxMxXntUPwxUEALdYwKK6e9EUx/I1j5PJJZw4SDyenpGjrRE5P8isnmHiN/ApEHg=
X-Gm-Gg: ASbGncsjfzwmg+Fi3WTwoayT7JtOZMIZcNglYU921J8hXXMMQW/6DEIcDhd2ZgFkCG3
	1meB6bKcrPn0riPlxbxuL6rS7hqNbuSMQU7z7WmafzJZhRypX9UO4pLtvRoX1TNj1Iv1zNwwDjb
	25ep/knhKV+8MgWY2or9zvSxbHeEAWOiK9cx2S65ndznasKXB0/Po0htjUqX/bND3y/ujAGRaQX
	JezUtG84CjbPq7KUpOmSs79ye1w6IfTwM+l+3gYIckwYVcT59qtHY/3S5r81MlL1XtTOkD0FWez
	R7DRzBdrHRbZH8PrGqmoEMS2iYkFAOC5InKqiP2cb0t5L9+oXRNElrnnGCNwRkCWH/1NVAOcktl
	+PV721JtyfQAzMJl1y7DSzOtU7C7zIhBdHaBlXCg/I+DGFjYJ6gkxAdXLW8A2a5GAmAkwtdQPVt
	oPJ6c=
X-Google-Smtp-Source: AGHT+IHL+J4sqP2SxcyYA/bm344OksrCpi3leJPwTfOOG1s5eCheuA6YOXSpbD6tw1CHk8ksExeFwQ==
X-Received: by 2002:a05:622a:4a14:b0:4a9:a3ff:28bb with SMTP id d75a77b69052e-4af10a1abd0mr240543491cf.25.1754402967223;
        Tue, 05 Aug 2025 07:09:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeed669c0sm65687951cf.33.2025.08.05.07.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:09:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujIM1-00000001XVj-3WEg;
	Tue, 05 Aug 2025 11:09:25 -0300
Date: Tue, 5 Aug 2025 11:09:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Yonatan Maman <ymaman@nvidia.com>,
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
Message-ID: <20250805140925.GO26511@ziepe.ca>
References: <aH4_QaNtIJMrPqOw@casper.infradead.org>
 <7lvduvov3rvfsgixbkyyinnzz3plpp3szxam46ccgjmh6v5d7q@zoz4k723vs3d>
 <aIBcTpC9Te7YIe4J@ziepe.ca>
 <cn7hcxskr5prkc3jnd4vzzeau5weevzumcspzfayeiwdexkkfe@ovvgraqo7svh>
 <a3f1af02-ef3f-40f8-be79-4c3929a59bb7@redhat.com>
 <i5ya3n7bhhufpczprtp2ndg7bxtykoyjtsfae6dfdqk2rfz6ix@nzwnhqfwh6rq>
 <20250801164058.GD26511@ziepe.ca>
 <b8009500-8b0b-4bb9-ae5e-6d2135adbfdd@redhat.com>
 <20250801165749.GF26511@ziepe.ca>
 <vscps6igy42u5limiigiok6y35mjx6acawi3qmvzbrpvltp4qp@mkydml7lz6fu>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vscps6igy42u5limiigiok6y35mjx6acawi3qmvzbrpvltp4qp@mkydml7lz6fu>

On Mon, Aug 04, 2025 at 11:51:38AM +1000, Alistair Popple wrote:
> On Fri, Aug 01, 2025 at 01:57:49PM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 01, 2025 at 06:50:18PM +0200, David Hildenbrand wrote:
> > > On 01.08.25 18:40, Jason Gunthorpe wrote:
> > > > On Fri, Jul 25, 2025 at 10:31:25AM +1000, Alistair Popple wrote:
> > > > 
> > > > > The only issue would be if there were generic code paths that somehow have a
> > > > > raw pfn obtained from neither a page-table walk or struct page. My assumption
> > > > > (yet to be proven/tested) is that these paths don't exist.
> > > > 
> > > > hmm does it, it encodes the device private into a pfn and expects the
> > > > caller to do pfn to page.
> 
> What callers need to do pfn to page when finding a device private pfn via
> hmm_range_fault()? GPU drivers don't, they tend just to use the pfn as an offset
> from the start of the pgmap to find whatever data structure they are using to
> track device memory allocations.

All drivers today must. You have no idea if the PFN returned is a
private or CPU page. The only way to know is to check the struct page
type, by looking inside the struct page.

> So other than adding a HMM_PFN flag to say this is really a device index I don't
> see too many issues here.

Christoph suggested exactly this, and it would solve the issue. Seems
quite easy too. Let's do it.

Jason

