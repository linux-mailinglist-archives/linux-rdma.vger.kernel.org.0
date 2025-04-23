Return-Path: <linux-rdma+bounces-9749-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DC4A99654
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 19:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080F45A7D42
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 17:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A092628BAA5;
	Wed, 23 Apr 2025 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="npaeDpuZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882EF28C5AF
	for <linux-rdma@vger.kernel.org>; Wed, 23 Apr 2025 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428644; cv=none; b=hi54t8XuyoRxZUZcn5vvTNjxjlYkRSZ+FhEeZopO1mac0zbCH80K84A5TmdP8FC7EkReudW9KIQYcdR3FZe1wTV4qMm/bd6PblI5FzFz/YYVxVMdpImsLkKG9rgnrAsQUgTh4mNtksKCNii7/CU43y6JaWvCqJ9RyvMHtBnxYDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428644; c=relaxed/simple;
	bh=EiBhyUfzV2Z7UDyJtWT+jDVz3vG5z4pmjKVdd/tf4pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNhjfVrKFSeBk/r6bcx6ql+BH44IrWbOJd4UYX2XAk8r4AXmciOfNKPvXMb3+IjbhMNwB8Sib+WVnJO7m/8aJ3lKqVx5EY9fFKQCLFWukgimV1qP9iXiwQ2S8JbifiQ+KEdmP3d00xboGwkJ38vMJVlvMU0xF9H0EmivRL4bfOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=npaeDpuZ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-476a304a8edso873311cf.3
        for <linux-rdma@vger.kernel.org>; Wed, 23 Apr 2025 10:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745428641; x=1746033441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dFsItIzcNoABKT1tTnR+L3KluEl/QW6UiWkd3yuS4gc=;
        b=npaeDpuZ5VPkOZqrigtgKEO3dCkGR0IX2y98q9Ii9PH6a4ySKU1Jl4WwtNJ6vivJox
         7hEhKgYIFPYqeHFyrzJiO3d33Z8ckzVE0eaA8fEtLnT8cYn03BrtVZuBiETLqrfiK/nf
         gFTPKeLi7Cpt7+qx2b+ZjMHPmjzmah7oNakivA1lRSbQMUGY1if5wHCAKmZlpI9uAt6a
         Zy6Lvyyn98F2uzFdf2FiWobaepLTsF6ukZ61MMk+0nGEE0Blu0FjWpPxnQrpfafrFL4m
         rX9Cge4tjMFyn+s+tbrBkE7lZCL4t6Rs9j2pRiBe6X2c5Xq9grXs9D9XN/yfjfw31f4z
         4q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428641; x=1746033441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFsItIzcNoABKT1tTnR+L3KluEl/QW6UiWkd3yuS4gc=;
        b=MKvcHEgI5v6lPb5XvmU8S33QhwjHupU+DO1aVAUmpL2EV5+eXOPr+cW3IuyRBUIbFH
         gBgvGcPR2J8a+AceXfuiNy/cQxNxd8rs2/VnrkGVnuuZ4+mO+RDqqn+/NlnpidRqbSMp
         qV3mXPVA/7WEnsw0b84578z2IJm/rCaivnXx/OwZRm/U7f2Oo+s7p6h6eyv7W+ySGXzK
         E22TYS4aaVQWwnmf0sPDrQFf923JRSzdmWaxagB1HA+N3iC9n3v5B9dKBSHFUXPEuIZA
         A7Omp0NXyHipCqWpaJzVLCgJtKZbdbxOIW2EBsMk7dgJ77YQsFI0Mwg1W4UOXR0zkKO3
         stXg==
X-Forwarded-Encrypted: i=1; AJvYcCU+MU0fRlELWJlwFtBX96o/IInWYRXwNMrcQEwXKkHL44NAK69y08hANuBkDpYLLlSe39fXYPdIHj7H@vger.kernel.org
X-Gm-Message-State: AOJu0Yzym4xXB++1loi4i0fuUd90VsApHvfDUYzaDXmkxg/zojGKhnlA
	JxmxXmMfvONmS1k+jLQRaur3Knjvmb4ErL1nEO09McwHXc5sa8twaGMy/JCzKso=
X-Gm-Gg: ASbGncvHiNjpaLVslgEbHeoes0ogA8nNSTSljSqE2Oq5fhYRMqTKTFZXE0xlZ5g1/zD
	sAO5Ic6c7RJWOY1UXioDPa/0YzUEV0vK2djGeizvpQo3HHuL+QcoQodzaWqqf/2JdoBJgTyd2Ct
	dYVnGljzdE69ofgOQmzVrksv8sRt+m7GAPoSpDAzVf3s2lmwA2r8RY9iUCsEtWHJXepHC/n1EYR
	b3vGUdYhXEkmHX2UHyQ3KL44JiegpQXmWIUTY6V91aAEYP7onDNmNCVHTlgP6U+srmkSk68UtG+
	DmqRSL0wkDuq5dR02hnqcV8df2cO6eISdECaPO8uPLRHR0OISoKpDB6ArN2H4Ht+ioNgz7HvWA7
	DIDtj1V9n2qTtNDtJvbQ=
X-Google-Smtp-Source: AGHT+IFtKlYmuMPWfMKQK8kh2VV5wwxeBA4j6ePEQHIEvAPMlC2NtpfOcLZrcYI7RZQRiXVuJwSHAw==
X-Received: by 2002:ac8:7f51:0:b0:476:838c:b0ce with SMTP id d75a77b69052e-47e7607d5ddmr844071cf.13.1745428641397;
        Wed, 23 Apr 2025 10:17:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cf9f29sm70808611cf.71.2025.04.23.10.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:17:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7diq-00000007LSZ-1iS9;
	Wed, 23 Apr 2025 14:17:20 -0300
Date: Wed, 23 Apr 2025 14:17:20 -0300
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
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
Message-ID: <20250423171720.GL1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:01AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Introduce new sticky flag (HMM_PFN_DMA_MAPPED), which isn't overwritten
> by HMM range fault. Such flag allows users to tag specific PFNs with
> information if this specific PFN was already DMA mapped.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/linux/hmm.h | 17 +++++++++++++++
>  mm/hmm.c            | 51 ++++++++++++++++++++++++++++-----------------
>  2 files changed, 49 insertions(+), 19 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This would be part of the RDMA bits

Jason

