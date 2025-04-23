Return-Path: <linux-rdma+bounces-9754-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13426A996DF
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 19:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6629E7AA390
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 17:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2E728CF4A;
	Wed, 23 Apr 2025 17:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FZK0tNyc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2F52853E1
	for <linux-rdma@vger.kernel.org>; Wed, 23 Apr 2025 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430004; cv=none; b=HYGaTL8kDZ+bNB2s36wPCmx4ASwIgk1jbl0ryQ5ejYwCGqddy2EnzUZDVED/VbQ8XqyCsRxd/PTOqyndI85ZNnqUZjGTu9x/VFv06ITqB2WfnfgKSzG7kQqbIwC47+C6Y+5vyd3xaeA7sUdin2D8dW+5cKrRIJEjjIZrFuIwPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430004; c=relaxed/simple;
	bh=fqDUwA8t2UWWpUEyQC6cAVOhBUnimvgbh866DiIXJ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfh93q62hhX19EOeMfV9qK7xPr8HMcFLqzwQ7FgpBelwGS/ylC3N4b/rmdUBoqDlYR1mAaHHvriuGakHBfxOLLSnRHG05ZNzbVlQqwb5nPFBZIeZQdCl2h2NVLb6axhwH3yO5hq+PPg8s1uQQiDkwqEUZ3DxeVTU9JP35SLmK50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FZK0tNyc; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5aecec8f3so12395985a.1
        for <linux-rdma@vger.kernel.org>; Wed, 23 Apr 2025 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745430000; x=1746034800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dkawg+tdbHC9hQ8MctNRicE8hYlskMOz2aG9rt+rsDU=;
        b=FZK0tNycIZeEcEKi9Hf/xEWwd4R5BdjYoXvf0cAKhFshlekLKW5HOX9yKKXmpIFUv5
         79Rn9V/mObXQNsTW7WSayR736S462gXQaSU/orkQMUfjtrvbRSm+Cnuhe02vc5N1bE0v
         0KIAD9CwsRC9QPAYCgnj6GcjGyA529Y1v40yo8V2gVxaB6wQZiIfSYWEcJiS+WIs6F4M
         GYwR7rLW6F7Ly+gdekmPYIjCBSgv+slirmo/Qhisyfpdn0Y3c4OPOkp+VWuezk/D4Z4N
         G+lxeOynZfSiMEjeiqVlu17y6KkaZU3jTxuHdOnmDYsijasnvdQHrIQLQ2+0Ww4AUEVJ
         vZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430000; x=1746034800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dkawg+tdbHC9hQ8MctNRicE8hYlskMOz2aG9rt+rsDU=;
        b=OvUdvRfvMdpOCuZ1cW5W3bjUzs4/coinwdCXWGeXkv2wHND1OAHSFY0C2N/5TIKRcG
         f7ANxpO8EXPlc1YiYZ7lWzcLKxC4vIfGgYIki+QezuWKzz7xVKgxOkZg35pilp5uzSYN
         tMznrzQCIcX7U8Qf1Mjkyysmdm5/KouOmSbM12B4D+r1sgPl0Oo80/ZMmzuoTT/w47Hw
         SUBSAsUGOVFsIwTt34TdVHXj3oycuNhiv17sssXMfYMh6BOkR7O/XyX/bkclMhdIPTmb
         ZA0cJtc9O+hevWWdthXfqtzJwmZyBrmhOiiVXRisRUvUrs97P/f320d8OPCYyHO86M0d
         RTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjORzpcm60Bs6A3TiDqQ+/jGT33mi11/LEXGctbjq3E6gjPW6VL5ujxhduGhLYAL65B/GT909DQvqP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdw6evvjZ6uYT+wjSJwnsw1POjqd8CyXKL4W4BW7DNSboj+U18
	nSkzafVRJwyUzSjltawhDK474QLOBZTTH3E2YX4TkSBcs39rLbpHa+lQhi3RpgM=
X-Gm-Gg: ASbGncvOAEmaL+Bkp1m8b8xMybFl3ECCGom88Kbq0oex1Jza5wE8ZiLrBJp70q0eCID
	iXftqdORauQWc1F5/bOcdQPWxWVyG/3cDyh/+7uZ+Gv729MCSQULnZ+lWuOPNHJMUc7w2DAaFSt
	gQdar36CG8L1+bVFBoFvexMhVtOTKd5xcsWgrromCOmvHEoHNEyYX/ZXl9cs6dqTzK2mSuROhr1
	j+7oWDAijDJrJRX+yJpYAOT9eoQgpxb3IbQkezuvRJ4fHfkfev83KgCmdSXKGqJvQKwzp7ORblB
	tuOYnca9r3yo5oWNmulvi0AZkleaIcQUxcd1qRIWlCRFJvq23MAtXkxmFAiXz3Bx+NZAPwLQoPN
	LeeKpdODhandLBJ1rE+UdtZNBu/mjEQ==
X-Google-Smtp-Source: AGHT+IEbQuW5n2GfFvJAnoWRo8rT/VepuLZ0gxRArfui4RxjUWT0n6IGPAbDd8GEItyJpW33RI8jLQ==
X-Received: by 2002:a05:620a:4043:b0:7c5:4c6d:7fa5 with SMTP id af79cd13be357-7c92804d68amr3534168985a.48.1745430000401;
        Wed, 23 Apr 2025 10:40:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a6e9b6sm711717085a.2.2025.04.23.10.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:39:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7e4l-00000007LfH-1pvw;
	Wed, 23 Apr 2025 14:39:59 -0300
Date: Wed, 23 Apr 2025 14:39:59 -0300
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
Subject: Re: [PATCH v9 15/24] vfio/mlx5: Explicitly use number of pages
 instead of allocated length
Message-ID: <20250423173959.GQ1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <f2367fb33c0716ba661d8ecbd423e7279be23a74.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2367fb33c0716ba661d8ecbd423e7279be23a74.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:06AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> allocated_length is a multiple of page size and number of pages,
> so let's change the functions to accept number of pages. It opens
> us a venue to combine receive and send paths together with code
> readability improvement.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/mlx5/cmd.c  | 32 ++++++++++-----------
>  drivers/vfio/pci/mlx5/cmd.h  | 10 +++----
>  drivers/vfio/pci/mlx5/main.c | 56 +++++++++++++++++++++++-------------
>  3 files changed, 57 insertions(+), 41 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

