Return-Path: <linux-rdma+bounces-9878-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 996FDA9F1F1
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Apr 2025 15:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F571638F2
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Apr 2025 13:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F1626B2D5;
	Mon, 28 Apr 2025 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N/XOlj9E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8572620FA
	for <linux-rdma@vger.kernel.org>; Mon, 28 Apr 2025 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846195; cv=none; b=S2VbxrXUiZO3It2+DOFV9VQqvjS6MCfJfp2MDha/oeHz9+CCAKAKfi3E6MpwlvQar/5lf4cMLWxL2c1Mna5wKGWFm16duZ7Ct8NcSVT35ThIuDugrfDlQ30sPxaUE1Hitp9CS/ptd+wbVjbJCLoPkpmy3QSbWN9WMkyORz/nUqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846195; c=relaxed/simple;
	bh=NW84TxEhdb7ZElUc5cFUgz5zc5jpHgx7GoeBgURA278=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/nly2meZNNO+LCZVU5163iMP2THm7sr6xrgAK7P7ZVcKySBqobSROZOezzJN5lFIXNvPGb+mqWuyR+CTqxS8A6tKVSBW4/CdJ1RUiTAO8DQ9g0lFFrX088lCnJGxyyN2t3tkC3nmvPbJbAJH6BnloY+D33qUxjwElzILiUxaCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=N/XOlj9E; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8fb83e137so49197356d6.0
        for <linux-rdma@vger.kernel.org>; Mon, 28 Apr 2025 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745846193; x=1746450993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4DHTb7AvO4YicH+xSWtDalbuQanacnJSYHX0xM691I=;
        b=N/XOlj9EFqhqN5MhWNQAiQ+QnTjPBWKDnC0nsRikpONqYlFezdqGxS2LJY56ggJ+mt
         JkNXx1eAXQ0xucYtxQXYDAFibfCxNIIu832IdctCno0zDAB24Bu7nvnin4U4wyxe/1kp
         zD+0GcShK5MfbKTPnXw9UQqUrrpYggeWrFKjywHAg5ivdfg5C9jf2sa3Dcry+88GIdGk
         xwy6i3RsslHx8Tr+MkipL2QTqCbomlv2KJr4e+MHcIkVlCutdWik/D4sEOK1yj+QVhne
         sI+td4RlizN3PgS9Nsm6v2gQ6m6ioDYTiIXEQPA5J/ncuPm5PC/YlHCYV5OdDXtU/xl+
         bWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745846193; x=1746450993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4DHTb7AvO4YicH+xSWtDalbuQanacnJSYHX0xM691I=;
        b=XXanyIaYQLUsZQYAD6NEMn26EjN6Qs1/VabnGzQhgEVInmcn4tuAk7/85wHtMsyCg6
         mQ7PRfrREgcYfPhWrmGJMlB48XDjDASiu8x3+TizTn7oEDVWI99YbfvlFVeUllB8WoVc
         +qdk58n4HoHYmKVycXzutrUIV6MrjisdoisfYuwSisZYuwC+EsJ7D4EV6h2mnCxAUnAO
         oJI29JLiQMgj6d9jD8F4rTjqFDeF+ChfmKSihIDbxGbc6pC6A4152kAAFjSEo2tcVO9k
         9rGqJIoMsW2J2GQP7nT8PI2Hbjy2bLZxy15ucFv5jA2C08g40CXPr/s31saHH37OW85p
         sDqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI30mSdKSmnIMnN8MZ1eoUaswwm3JOPuXsUyAdRIf533eJsQ347QwpYGGhtaeL2nxHpNh8FIpLWRbv@vger.kernel.org
X-Gm-Message-State: AOJu0YyWx/y/E72aE+yzTOwydLIkdznULYFQXfWraJiwI95t4H7rFc6d
	3SEu/5uuQni6SymoPJ5VCywzlmotLxasURaJ7FNiFh+X+E9RWGca1pf3qrm2+Bg=
X-Gm-Gg: ASbGncvndhCL5Zv/YX4B9Q5ZhDV1YodX1J9GWO2gE43+zucbNBodE/7Uejo5ZonPXJx
	wRtaPDT7CIeoUP4dLkljTByizX0PT3PBSXclmoLyYtd9o37vWFdudsyyKFkGvfd9Ee2k6jIb93w
	K/JMcuaGu4/f1pogUzz47p6Je7Ouo3ZpAlukx6pKY8+WoeD9CrG2ONeqzPzsvesfbYZZNGphJjq
	+IbDSRw/4Ew3zLqvXW2b5lM6gdfklANbaNMxwxDGEONViZdFAjHQ+qmFlQEEkg+7gN4dw4fMMba
	bfX899ui4vg2IM99BWD+KsQhrA/Wmkq8Xp+oNQesD4l1UGYbIeQAYy2lU3ZcAR8QBX7Xm9/z4gM
	EQZNjr/22h4JCqzhEJ8w=
X-Google-Smtp-Source: AGHT+IGm1OrVyo7NrhtixKONc1TT2Ec0eky4BVMvt9fZIav2cWhkRh7ddfgsBqvKXcfpG60XtXV5Kw==
X-Received: by 2002:a05:6214:76c:b0:6f2:d367:56bf with SMTP id 6a1803df08f44-6f4cba51bd9mr207427746d6.31.1745846192886;
        Mon, 28 Apr 2025 06:16:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c74d3dcbsm53164536d6.50.2025.04.28.06.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 06:16:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u9OLX-00000009TaN-1zxp;
	Mon, 28 Apr 2025 10:16:31 -0300
Date: Mon, 28 Apr 2025 10:16:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 07/24] dma-mapping: Implement link/unlink ranges API
Message-ID: <20250428131631.GB1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <2d6ca43ef8d26177d7674b9e3bdf0fe62b55a7ed.1745394536.git.leon@kernel.org>
 <aA1iRtCsPkuprI-X@bombadil.infradead.org>
 <20250427081312.GE5848@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427081312.GE5848@unreal>

On Sun, Apr 27, 2025 at 11:13:12AM +0300, Leon Romanovsky wrote:
> > So arch_sync_dma_for_device() is a no-op on some architectures, notably x86.
> > So since you're doing this work and given the above pattern is common on
> > the non iova case, we could save ourselves 2 branches checks on x86 on
> > __dma_iova_link() and also generalize savings for the non-iova case as
> > well. For the non-iova case we have two use cases, one with the attrs on
> > initial mapping, and one without on subsequent sync ops. For the iova
> > case the attr is always consistently used.
> 
> I want to believe that compiler will discards these "if (!coherent &&
> !(attrs & DMA_ATTR_SKIP_CPU_SYNC)))" branch if case is empty.

Yeah, I'm pretty sure it will

Jason

