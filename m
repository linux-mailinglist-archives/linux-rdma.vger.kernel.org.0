Return-Path: <linux-rdma+bounces-9748-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FB6A99640
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 19:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131E018892CF
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 17:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359C828CF47;
	Wed, 23 Apr 2025 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="igc8GuoA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C7028B4FB
	for <linux-rdma@vger.kernel.org>; Wed, 23 Apr 2025 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428559; cv=none; b=JPeXPDUuNrTdfvbptv0f8dC3wJT4AY/MxSpyl18nqBzek2Z+jaPvoWgN7HiHSIL8nLckg5rp/mWcjDFMtXFKBClv+mnz5wwVqqKIPx6tVzsHBieqoOKqI2We4Ba4Oia/gRtFcB0YnmICVt6NncvfcG5RXyri3Hva8Vx06QuHvLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428559; c=relaxed/simple;
	bh=vMXucndq2S6GHUftC4QAjKIvCRBxtQ3mQadyEEn05iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCf/Xz9x7ZElV+WwnXgcOfEYPhc28cnodnKSglz/dwV1Lwet47INGyZzezD95YfxlUnrxHGfhNxqj1vhigT4f5k8kYIzsxp0AQFdNGDrO7SfhJmfupJwUhNSSMHg5YzVgImoW4Zrm01A9cj3kisH2+EDQM6VV7QCqdxGt3K6r6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=igc8GuoA; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c560c55bc1so5671085a.1
        for <linux-rdma@vger.kernel.org>; Wed, 23 Apr 2025 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745428555; x=1746033355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5HpTnu16aeUYpErbp5yUwht+j3Mgf+r7FFUrUseQ0w=;
        b=igc8GuoAzkxq23x3zTwtP5oibqkeQg53VG0Iq7gad/MlX8rlFoaVwdhQ0apeqpKH2h
         U63IQo5nrNVr/aYRLNtMYNdCv4gydkVivRxSKp9R7pa6wsgSApmCtQMmO9kL+FNLuCYl
         X/+CooWu7xCeo0ATpiDWk+fOrcm0n3wgS7PLKA/bTH1rXQkbm6fbMji0uJQNUxm58yoB
         Rqu6j7oRTifpHPPn+9M3hN6fwsO7KeVdJS2pUvi/LGbn6oETIDds/1hWRCeug9xrcImW
         WzY6PYLDgjbbO+z5bnOFm9GEuBEpX2dZ4T7e+CqVXT1fnIfwTIv3FZayq4iQBioe8nnf
         CfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428555; x=1746033355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5HpTnu16aeUYpErbp5yUwht+j3Mgf+r7FFUrUseQ0w=;
        b=SU11P5wzotDEwzC2OddkHnWQOMkfUzobnJLOSt7Y325Fg5ITFIPKOEEbTmxuH6/i5J
         UjNk/Yc8udQPDj7rPt+5uzZRNC26Y202lMvBJF6zZtI3m0cKfuJ9G1sxREsHgwsTGW3/
         7W91xSDVlQYTF+/DRmplsJXGHyc3uatPbw0aOGdpJm7rQmYzXfREBiW6cuAL3gopnlTR
         b9o9AqQYidiq+UCDWHZaSc35RfYU9wJSQkygvJbnLGBkrCs3b3hMOEYgkdxpnaGH+eAt
         AFzl1ACNGFP/M999vbkLGsD8Fl2TW7zUWzoFIEwUwNbERIzsPZTthrP64A0W7wwkTqmN
         T1FA==
X-Forwarded-Encrypted: i=1; AJvYcCUko60m5nI/Dz+8zvBPKQTnCQOmXEXZu0GnWy+lt65bvB4ANumgbvXpfznww8wa8HZ6OOlYqjVzMpW7@vger.kernel.org
X-Gm-Message-State: AOJu0YzKLkWtEZM0eOj+I4lF42Il4AqR9WkxaMX50AcbPlbkyFjShFJA
	hf3DTkLFPi+yb9ngi1LFKWKxkBQux/0PDrh3EMXIEptMZ7rXYK7bXcraGdHz28Q=
X-Gm-Gg: ASbGncsGZzYdhO2StnB8OfA+DjddnvKEzTTTFig9qLObYJrgs78FpfYSs6zA2+l2zaL
	9P6nFGgI364MLgkqt/u/8B6q/o88Y16llvCDD/MXdvI73zOGTC/PhXmB38DlADBIiOWlzPZ72cl
	bErVodwS0piArA71I5DYwM6jKUhAMMWy9RICsKLngBlQRhSawhdJ8X5jcaYxdYnzOc4ChDkzj0H
	/oBCprghxHWVj2TZHL/Ci+4aIo9ifdEVE7IybB5ZQ50tJNFVUxSkfanq1uJFgGjbRj5Z4oLPhPW
	R2v6TrTU5vmoTmn6sZlna0IV0EQnjfyQ5HXBujBLYbLAHXisCj1Rsg8ITNsFB9tBggPjJAgW8Hh
	ElQLDVmtL4yWyl5Y7NWU=
X-Google-Smtp-Source: AGHT+IHusnUQ6QwwVsDnvg+0qYOM6lcQLPltCEX7WmRgNJP3vwJodfip7PxZnn5pgy7BG5cQ6pnE/Q==
X-Received: by 2002:a05:620a:4456:b0:7c7:a5e1:f204 with SMTP id af79cd13be357-7c955e14768mr54555485a.56.1745428554903;
        Wed, 23 Apr 2025 10:15:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b4e93asm705867885a.70.2025.04.23.10.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:15:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7dhR-00000007LQy-3kud;
	Wed, 23 Apr 2025 14:15:53 -0300
Date: Wed, 23 Apr 2025 14:15:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
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
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 04/24] iommu: add kernel-doc for iommu_unmap_fast
Message-ID: <20250423171553.GK1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <9becc0989ed0a6770e4e320580d1152b716acd0d.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9becc0989ed0a6770e4e320580d1152b716acd0d.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:12:55AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Add kernel-doc section for iommu_unmap_fast to document existing
> limitation of underlying functions which can't split individual ranges.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Will Deacon <will@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

