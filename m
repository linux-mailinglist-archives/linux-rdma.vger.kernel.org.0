Return-Path: <linux-rdma+bounces-9753-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9FEA996D2
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 19:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C69C1B8250C
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 17:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B066028BA95;
	Wed, 23 Apr 2025 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BLa9nsjk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02F4288C8C
	for <linux-rdma@vger.kernel.org>; Wed, 23 Apr 2025 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429938; cv=none; b=j/rKw5CCvg225OxVGLw/a6sFwGX7O2mO4Ry/0m8iz1m8ctfDpZMTPaU2dIHNnox29mBx/R3uItRfu2dAzPnb5GZWsCAwu0nNqM3dmAueZFZER0X5J+RoizYcy1OXJ5I/XdTSe/QpHoPpedKkjf7pCLYfRjEHjjHBWMb3rHGg6m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429938; c=relaxed/simple;
	bh=jyCSrAMbJeJJMtfyLp932NW76okHOgg35e8+PFG3Bes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7Q9hdEQb+ioMTN70rR9GP4e/Qwe+WsS9Q3cxg1eH2igWxiu67s04OX6TMjtfCesf9fBEULZ6kTi4Z87jxXKgnuCpH1POt1BEMLH7vOjKlwZULDpuky2qziDGzPVsPkpv6hPHNFWY8hCnMkGY8n3VVLWKu635pvIfBAkBtgFnpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BLa9nsjk; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c9376c4bddso7718885a.3
        for <linux-rdma@vger.kernel.org>; Wed, 23 Apr 2025 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745429936; x=1746034736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZKbLbO/VBglO/Va9GZRrTXMgQWmFJOWwhYhgpmasyg=;
        b=BLa9nsjk1nUgv4cYXhbtlLnUcGYKWx4s/nQ++KCipMa3JLgqixdV+px/z5gqty+PNp
         0b1XzV1foqnjxhd4kxU2ygsi/Nv3YMsA3Co9Qm3ISEnTgxglbm3LVTwE7nrMUTdJxB4u
         lR6mQZ6gfpaXKIAu2Yh8i6g8zmpyKmS5htNEKQ4q4BbQADqnUlYjg3XLIRt2xtWfl2gY
         xwb9TqLb//LkaNVobLptW73472wkPaauOlxup0nnsX4h+6wFKGvmV+wKcyiCcmCTuSgX
         Vbl8w2FkBcKHtiA2s24YEb0bciQZOCNftv4pbtcI08icWYat6JIHj4IkyI+me07/mmDA
         hFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429936; x=1746034736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZKbLbO/VBglO/Va9GZRrTXMgQWmFJOWwhYhgpmasyg=;
        b=ZMhRLH+dsMvg8ElsfoE833skwlbJ+9wYf0WxzFILQfYzf9Kp6avCKOMabpCf33Sjxs
         /d98D/b3jgXdfrWFcyil7vqq5yNxw5BwrNa7A9J8xsJHQ72xctRxS3FwVjO6rAsQ33rR
         FVBp2necgpRuDAkosFdtK+0L55e5svjfM7CX60v5O2OnnLA6UVeLeahYUH9Hq7VbMNh4
         01XHDIgJsNAHs+EOsZPRiIM4JinoOUnpx/TJV3vvSQcmjp77z5oWey4+kbYH75FTpaJW
         tf7d+vo51bRgYhVw5Wm6dUgmL9V7eJ0PPmql2DPM1UGP3WXG2xb1xf/wlpHPKvKKa+Zk
         nrHA==
X-Forwarded-Encrypted: i=1; AJvYcCW2vdIohN94MyZ3km11P09e2I2VnJSoaYe7mXvrNSdPR0lOzSv1vw6BVajgIQhtAXixEEC0+hirwkLA@vger.kernel.org
X-Gm-Message-State: AOJu0YwLeOILtoMFe89RMkZYMHrXyhDG1idps/aDEVw1LW04kxwnGoA0
	4/3hk2fj5pllaZveirEoZJxfcwvU0NswZd9XaOoz1vb63OxIpV6SZNe0mWCq+yg=
X-Gm-Gg: ASbGncvrUCWt9HNQ4MxJaLp4Z7pjwlSbkroDrZ8bGYTuAMM33rS1liPCT2u6fPnlp2p
	DGrYU/SuN/b8BXmTwn47rzJv94TuuxSyIoC64amztNad3yzk+OZQHyEDLFJwE3LWZTMQENSlEer
	2A6tTxFl6SxR2b3vvqNwhvWlPukUXultnjfpG62BeAvUJT8fuI7lmhf2LiDH/JXc2Z7IgVmx1UZ
	F3a1YKIxUUaJn6cKRnevsRDSslPmxqq0ML78Pqra0sQ829u6WOTmCluI5Go6R0nseNDWvB3MnhM
	yeO1zrVb0Ea3WtIu0DhNNa86qOoxJniuwr7AW+1wxCX5GbLWCnSSLKWWqgcUNbD+i/MbnLM9PLW
	6RGiTXyQDpp9bIWlzKNM=
X-Google-Smtp-Source: AGHT+IGgN3qsfS6onNY8+gQMZCTHD3MSF9+S5w+6n1/7VM1d4IchwJLfZsPm7/0ZCJyeB599ZskZwg==
X-Received: by 2002:a05:620a:1917:b0:7c5:ae20:e832 with SMTP id af79cd13be357-7c927f6ff15mr2997015185a.11.1745429935582;
        Wed, 23 Apr 2025 10:38:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a8c9f2sm708523885a.29.2025.04.23.10.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:38:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7e3i-00000007Le6-2jjE;
	Wed, 23 Apr 2025 14:38:54 -0300
Date: Wed, 23 Apr 2025 14:38:54 -0300
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
Subject: Re: [PATCH v9 14/24] RDMA/umem: Separate implicit ODP initialization
 from explicit ODP
Message-ID: <20250423173854.GP1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <c79721bb70988f60fa23fdfb6785e13f6ef806c5.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c79721bb70988f60fa23fdfb6785e13f6ef806c5.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:05AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Create separate functions for the implicit ODP initialization
> which is different from the explicit ODP initialization.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 91 +++++++++++++++---------------
>  1 file changed, 46 insertions(+), 45 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

