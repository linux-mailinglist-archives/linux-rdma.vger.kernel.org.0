Return-Path: <linux-rdma+bounces-5774-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C559BD563
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 19:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC482842C3
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 18:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392B81EC019;
	Tue,  5 Nov 2024 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MwMI3f1F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302A11EC012
	for <linux-rdma@vger.kernel.org>; Tue,  5 Nov 2024 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730832666; cv=none; b=W3RkUyu2phW/wVp7lA0o0gj6/XnFThxVfemjDHXIiPfzWC9eEY7z9J+foZIjJDgNZ95Z3F1SkAGRu8mc7mzcGD6rtwfakZ61XbK9458lyeysuS/mOYypJO3VHN/yHvHy9z99BiNEr+/3amsScjq6Tosn5okwrqvrk5uiIhojJJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730832666; c=relaxed/simple;
	bh=nJnTbD5cGZ0OfD00jTtdrajsLazl3DFTJAxArG9Ps+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCJrMyr2aTzlegLfXvUm7bJOT8lenJuU6/NlPVfZjLxyOBIWfX/ZCAovOtgE7JE1xWCFFmH0GjFngaqvUdX8UgsLfaZ8AGnB/clmB1YhRXTPoPgfi8hsR71iCYpzY5pSYLp4O9O+aLUGTih6V/gBhIByu1MuM9M4loXlpCE/uaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MwMI3f1F; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b1457ba751so439099785a.3
        for <linux-rdma@vger.kernel.org>; Tue, 05 Nov 2024 10:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730832663; x=1731437463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C194RVyLAfjN0SwVJhWOGUoO0421PCIPswUt8quSHT8=;
        b=MwMI3f1FiJtKbSb+104JZqGid1wfIf3uJt8Wjuw4Mn8iu/DsebWaYWZdRPs8idwCnR
         G+I7AF7bhCUUSUBNQw+QPCmepNj+NeS+8V7uRjlg5iaVIA9CPV//gHtzykp6RFpWjSB3
         bEjGvNxbf2LnXaftz75p065/1sD/GAPsEOMMNpMZ5UjmD4y8a40GfLBTM1Qq2oU8QdZ3
         J8GIR4YQWuWl6Dtsf0Dy0aRq1Eila20Aj2m0v4hcEgmRZY3sAHdnp8RqfyrRoDjZYtzT
         ObzFuPZUFv04pc7JsyasDhZ57mi4ATensZ+Vjda89fVA64rlDYTQ6JD+3xUJlCux182V
         pzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730832663; x=1731437463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C194RVyLAfjN0SwVJhWOGUoO0421PCIPswUt8quSHT8=;
        b=vdK6PPG3B1zHe8Zd3TyGEdey4zC1OdfPijUPJzWeboEKHwCd4KeqDMRYfSedRdF7dm
         BCBcd0GeH0Jn6LupSFxNLyNuO7m60Xw4j689QfvGtsSZ/3KC506k4OCrRzQ1Bw2WwkQY
         TZxAXo9MQ7OcuNPXaucfwxQSEz1bMjga4Y96DenrDz9+uoQeuTNICht6dUHCremf6QBm
         iu2lbQ2cRReBrG5bsZJQQwDwJ9ZHZHA6IRdKl7HELXesY9cY4tajDiVuLuFuXJEQ7w2O
         W5+mD0Rp+H5YiwjeXd0plxjKrMp3HDFalT/K94MExim+ceWQkylTe9Umstgcs14vksAi
         7epw==
X-Forwarded-Encrypted: i=1; AJvYcCXpKUl5McN0BpIdDq9+5frLr25blDqEY0JgMQu+rMcuLlthZMqgCoyep6hczJ3qhTF81oynQb9NYZ3w@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZA5RU8JAXZ+CrCs3EOyW574G6DBChowHcIHPlS78vJfG0NHk
	pmwBtS4GAa9uvvM0iyioAmJy268NOiw0xe8TsYxudTjSTJPbwZ48NKWxPteUyGg=
X-Google-Smtp-Source: AGHT+IGWpBzbxGzBgv9Gx5tLlQAZYsSh7jgfOX8tW5mq4qsvhcUPgq93VZEIR90XeqIlAFYpEQmgSA==
X-Received: by 2002:a05:620a:1908:b0:7b1:481f:b89c with SMTP id af79cd13be357-7b193f0a206mr4853751585a.35.1730832662826;
        Tue, 05 Nov 2024 10:51:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a70971sm549852785a.77.2024.11.05.10.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 10:51:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t8Odp-000000023WW-0CZJ;
	Tue, 05 Nov 2024 14:51:01 -0400
Date: Tue, 5 Nov 2024 14:51:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
Message-ID: <20241105185101.GH35848@ziepe.ca>
References: <cover.1730298502.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730298502.git.leon@kernel.org>

On Wed, Oct 30, 2024 at 05:12:46PM +0200, Leon Romanovsky wrote:

>  Documentation/core-api/dma-api.rst   |  70 ++++
>  drivers/infiniband/core/umem_odp.c   | 250 +++++----------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  12 +-
>  drivers/infiniband/hw/mlx5/odp.c     |  65 ++--
>  drivers/infiniband/hw/mlx5/umr.c     |  12 +-
>  drivers/iommu/dma-iommu.c            | 459 +++++++++++++++++++++++----
>  drivers/iommu/iommu.c                |  65 ++--
>  drivers/pci/p2pdma.c                 |  38 +--
>  drivers/vfio/pci/mlx5/cmd.c          | 373 +++++++++++-----------
>  drivers/vfio/pci/mlx5/cmd.h          |  35 +-
>  drivers/vfio/pci/mlx5/main.c         |  87 +++--
>  include/linux/dma-map-ops.h          |  54 ----
>  include/linux/dma-mapping.h          |  85 +++++
>  include/linux/hmm-dma.h              |  32 ++
>  include/linux/hmm.h                  |  16 +
>  include/linux/iommu.h                |   4 +
>  include/linux/pci-p2pdma.h           |  84 +++++
>  include/rdma/ib_umem_odp.h           |  25 +-
>  kernel/dma/direct.c                  |  44 +--
>  kernel/dma/mapping.c                 |  20 ++
>  mm/hmm.c                             | 231 +++++++++++++-

This is touching alot of subsystems, at least two are mine :)

Who is in the hot seat to merge this? Are we expecting it this merge
window?

I've read through past versions and am happy with the general
concept. Would like to read it again in details.

Thanks,
Jason

