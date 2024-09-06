Return-Path: <linux-rdma+bounces-4786-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C36DC96E95A
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 07:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE091C23454
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 05:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F8A85628;
	Fri,  6 Sep 2024 05:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jqcT8j6P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AE944C86
	for <linux-rdma@vger.kernel.org>; Fri,  6 Sep 2024 05:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725600957; cv=none; b=FH3omMvQKrBzgzPN59rzvAFH03g+U6DLy6wy3/T5KY6BGgPhDajg1jArVvYZ1YfyeRwnCq8FmzDcPfFIK4hT0eckmUwGlKrKVKzpHZfooHVfMUvwFP85as1sl7dJU4dkY6+mc0h5pQ4U07UYyiWForwIk63sQTkS7sRux4ETTj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725600957; c=relaxed/simple;
	bh=o/2KhL+xfw7eHQQPM1JU/IpkXsdwUCEWEQv7RBG+e4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YORPVpaMMSByeZeOZoKhNY41FPNRRNezoWgQYmY+gmWEnkNgFviHwTGzEexYw6yPHyAX1hAqJ3UuBwSzWkbHDOq4IC5nq+HyiYPTD7B+JNpHDZP+zU/Pzwq7hlWd2FKJc/WkbxknnPHHR91+QW/1Yd2JlxKhdT2pBW4fdEZosCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jqcT8j6P; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4e8e01d1-359d-4877-ac6c-29f4fc512fb7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725600953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFNC0Awc5iTNM0qfW3u9PkW3iUF8QXCExDtW4sqi/qc=;
	b=jqcT8j6PdqIPZLB5sxW8Csp2n4EuY/HhoDpG72KON/UgB/Q8m8BwoNX4y/NhCwpPgGnqfh
	3/2Ekhc2av5ldJh8tvk20GxIiVNdJ8w+EIAc3iqA8wBc2hYklixKQ74u45BCCYoWRg7Njd
	83N/mKIrXe4fD7cvrYJpSJPUkXEiQuI=
Date: Fri, 6 Sep 2024 13:35:46 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 0/8] Introduce mlx5 Memory Scheme ODP
To: Michael Guralnik <michaelgur@nvidia.com>, leonro@nvidia.com,
 jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com
References: <20240904153038.23054-1-michaelgur@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240904153038.23054-1-michaelgur@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/9/4 23:30, Michael Guralnik 写道:
> This series introduces a new ODP scheme in mlx5 where the FW takes the
> responsibility of parsing and providing page fault data to the driver
> to handle the fault.
> As opposed to the current ODP transport scheme where the driver is
> responsible for reading and parsing work queues and querying mkeys to
> acquire needed info to handle the page fault.
> 
> The new scheme allows driver to support ODP over Devx QPs where driver
> is not able to access the QP buffers, owned by the user application,
> to read the work queue requests.
> Furthermore, the new scheme allows support for ODP with new indirect
> MKEY types as the driver doesn't need to query or parse indirect mkeys
> in this scheme.
> 
> The driver will enable the new scheme on devices that have the relevant
> capabilities. Otherwise, transport scheme ODP will be the default.
> 
> The move to memory scheme ODP is transparent to existing ODP
> applications and no change is needed.
> New application that want to take advantage of the new functionality
> should query which scheme is active and it's capabilities using Devx.

On-Demand-Paging (ODP) is a technique to alleviate much of the 
shortcomings of memory registration. Applications no longer need to pin 
down the underlying physical pages of the address space, and track the 
validity of the mappings. Rather, the HCA requests the latest 
translations from the OS when pages are not present, and the OS 
invalidates translations which are no longer valid due to either 
non-present pages or mapping changes.

As such, it seems that it can save memory via not pinning down the 
underlying physical pages of the address space, and track the validity 
of the mappings.

What is the difference on the performance with/without ODP enabled? And 
about memory usage, is there any test result about this?

And ODP can be used mlx5 IB device? Or ODP can only be used in mlx5 
RoCEv2 device?

Thanks,
Zhu Yanjun

> 
> Michael Guralnik (8):
>    net/mlx5: Expand mkey page size to support 6 bits
>    net/mlx5: Expose HW bits for Memory scheme ODP
>    RDMA/mlx5: Add new ODP memory scheme eqe format
>    RDMA/mlx5: Enforce umem boundaries for explicit ODP page faults
>    RDMA/mlx5: Split ODP mkey search logic
>    RDMA/mlx5: Add handling for memory scheme page fault events
>    RDMA/mlx5: Add implicit MR handling to ODP memory scheme
>    net/mlx5: Handle memory scheme ODP capabilities
> 
>   drivers/infiniband/hw/mlx5/mlx5_ib.h          |  17 +-
>   drivers/infiniband/hw/mlx5/mr.c               |  10 +-
>   drivers/infiniband/hw/mlx5/odp.c              | 400 ++++++++++++++----
>   .../net/ethernet/mellanox/mlx5/core/main.c    |  54 ++-
>   include/linux/mlx5/device.h                   |  30 +-
>   include/linux/mlx5/mlx5_ifc.h                 |  64 ++-
>   6 files changed, 449 insertions(+), 126 deletions(-)
> 


