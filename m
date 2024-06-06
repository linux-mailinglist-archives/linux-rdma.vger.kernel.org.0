Return-Path: <linux-rdma+bounces-2933-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6438FE1B4
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 10:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C71B22700
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 08:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABB913E404;
	Thu,  6 Jun 2024 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+bCtIN6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623013C674;
	Thu,  6 Jun 2024 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664038; cv=none; b=YLmEo2TA0tDkpl08042yjYjpjS5oOtFoNa6ddxZQ5Uh7yGUkUNJWmCWlQmSy3SNU6SSBpsuoVGFOly3e6zYqlRfJfOerzVkr4cAB4q99BlVKMOBog81PQ+zQK2b3bulKalnvalpl5I7Gje3bP61AsE87EL7jUvelOzPOYTLQXkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664038; c=relaxed/simple;
	bh=76YSZcCdZ764lD0h45CLCNioTRewzDtJVZ99GEVCvUY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tK1ys6Z7s4Tv2adyHzhdDixL6pO68U6qnxXyuzBQW5Ccu81qsLGJsSIB6W/rTD2+8FxV7U5r2ykZffIx8tabTJk2/k4xgH+IfpBTQi8S+cDrLbtJGnTDAeokWh5snvMNFqHkjRRcwzPNuBGUp/Qq9JhGHH3VrlpUAOsTvJ2ZID8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+bCtIN6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4212b4eea2eso7696205e9.2;
        Thu, 06 Jun 2024 01:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717664035; x=1718268835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6VqKhsb7zNsKsO0Rwy1Ho9vMPyDMj69wLB9DOnaMWfE=;
        b=Q+bCtIN6bi9XfwL0qmBs0v9dKZsqw53A8TgSZ16m/YgidQiQ7+rgyJoEa/CoFVElyE
         3SGIYeURS9vH8BWAfZh7wATx/VVUOdJ/fEaBKsROXhFw5LqSy+Gb8bLVcLsIV6cvBq8M
         oIiIi3m12Isz2dRSwvgTfZ3QqUFYAc7Ig6il9keQuLaaSPBIfeu9NnU5z5ZAqk7Zw8u1
         pOWVRJ5I9XJHkouByCQTAH+iOpga39Cu18UNEIcJM2ELr/xKnZxVvGPGCzu61AthCTbc
         zYFSQT4ljbQkai24Wy6onfbC4evy7n7rNgVqTGC2edU8WzYdeMNCxC6U0zg+BciqkukM
         Effg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717664035; x=1718268835;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VqKhsb7zNsKsO0Rwy1Ho9vMPyDMj69wLB9DOnaMWfE=;
        b=J8VNxgVOiZcSOePWVtaNtpfNrGDXc54aoKs7cY9WM3gnExUCTuNkXHXj3YtCjRKeGB
         jtf0PmuMy2ns6KYsh8jHLJcNl7VgOBZ+VCSGHTDc0oYVdkZGWkNJlaixnnYceP1FkGqW
         to5joNByVtLJ7F0GPJvIEUqnf+nI441kbddcI1xNNnJjaDkJYhJPw7x/7KfbPtlzGx8G
         E9wfV3p605ect8Mj3cHAg1DmLEj3wUmtCUYxLXEdqeAGjXY6y/HFfwKkcYhOtD5aBjmY
         e101noZyDCTo9red+HUv09jdiHyfx+Gu1OLcHxYG35wbqFXMtKcYzdj58r8oEQMXm8Y6
         xd1A==
X-Forwarded-Encrypted: i=1; AJvYcCVKkrNbW02AR6gst+Uh72Hf4E8O/EVUCmEJHHWG8TRTbfCFUNEFf/K/USfiCEph0//gnQFU8tklj1vYYEvz4Qf8huJywap+LD5TMQr8GIyJlDtapBvUM0ZKy14+wy0AoLwY4zjg4dazdq9lGcqCrokUyPJPVG8s9XBphqzu6ib/wnbeQg==
X-Gm-Message-State: AOJu0YyDTfxTC2rKnBSs1XsAUJFGty3LScIl7n9PhL+1bWKfBSNM3c2H
	6gAwx1k4UFsjxM6GPU3NcC1ATxFOc59h2i6RaeWb56ZRngTum0mA
X-Google-Smtp-Source: AGHT+IEYxPKC2k/qAgc09dTYL+ijHyJ1hOhPMH9D51cPSwf9aJhwmRtpen34WhDJZuIh5e9CdV1zsQ==
X-Received: by 2002:a05:600c:45d2:b0:421:2168:8336 with SMTP id 5b1f17b1804b1-421562ef91cmr38175795e9.16.1717664035118;
        Thu, 06 Jun 2024 01:53:55 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814e7bfsm48107375e9.40.2024.06.06.01.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 01:53:53 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <285e6cdb-f765-4969-ab16-abc53ad66a95@linux.dev>
Date: Thu, 6 Jun 2024 10:53:52 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Enable P2PDMA in Userspace RDMA
To: Martin Oliveira <martin.oliveira@eideticom.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 Valentine Sinitsyn <valesini@yandex-team.ru>, Lukas Wunner <lukas@wunner.de>
References: <20240605192934.742369-1-martin.oliveira@eideticom.com>
Content-Language: en-US
In-Reply-To: <20240605192934.742369-1-martin.oliveira@eideticom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.06.24 21:29, Martin Oliveira wrote:
> This patch series enables P2PDMA memory to be used in userspace RDMA
> transfers. With this series, P2PDMA memory mmaped into userspace (ie.
> only NVMe CMBs, at the moment) can then be used with ibv_reg_mr() (or
> similar) interfaces. This can be tested by passing a sysfs p2pmem
> allocator to the --mmap flag of the perftest tools.

Do you mean the following --mmap flag?
"
--mmap=file  Use an mmap'd file as the buffer for testing P2P transfers.
"
I am interested in this. Can you provide the full steps to make tests 
with this patch series?

Thanks a lot.
Zhu Yanjun

> 
> This requires addressing three issues:
> 
> * Stop exporting the P2PDMA VMAs with page_mkwrite which is incompatible
> with FOLL_LONGTERM
> 
> * Fix folio_fast_pin_allowed() path to take into account ZONE_DEVICE pages.
> 
> * Remove the restriction on FOLL_LONGTREM with FOLL_PCI_P2PDMA which was
> initially put in place due to excessive caution with assuming P2PDMA
> would have similar problems to fsdax with unmap_mapping_range(). Seeing
> P2PDMA only uses unmap_mapping_range() on device unbind and immediately
> waits for all page reference counts to go to zero after calling it, it
> is actually believed to be safe from reuse and user access faults. See
> [1] for more discussion.
> 
> This was tested using a Mellanox ConnectX-6 SmartNIC (MT28908 Family),
> using the mlx5_core driver, as well as an NVMe CMB.
> 
> Thanks,
> Martin
> 
> [1]: https://lore.kernel.org/linux-mm/87cypuvh2i.fsf@nvdebian.thelocal/T/
> 
> Martin Oliveira (6):
>    kernfs: create vm_operations_struct without page_mkwrite()
>    sysfs: add mmap_allocates parameter to struct bin_attribute
>    PCI/P2PDMA: create VMA without page_mkwrite() operator
>    mm/gup: handle ZONE_DEVICE pages in folio_fast_pin_allowed()
>    mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
>    RDMA/umem: add support for P2P RDMA
> 
>   drivers/infiniband/core/umem.c |  3 +++
>   drivers/pci/p2pdma.c           |  1 +
>   fs/kernfs/file.c               | 15 ++++++++++++++-
>   fs/sysfs/file.c                | 25 +++++++++++++++++++------
>   include/linux/kernfs.h         |  7 +++++++
>   include/linux/sysfs.h          |  1 +
>   mm/gup.c                       |  9 ++++-----
>   7 files changed, 49 insertions(+), 12 deletions(-)
> 
> 
> base-commit: c3f38fa61af77b49866b006939479069cd451173


