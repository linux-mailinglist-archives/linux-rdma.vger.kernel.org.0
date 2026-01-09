Return-Path: <linux-rdma+bounces-15384-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2446D069B5
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 01:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E36330318D8
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 00:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FE41A9FB4;
	Fri,  9 Jan 2026 00:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VgUDy14k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DBE4A01
	for <linux-rdma@vger.kernel.org>; Fri,  9 Jan 2026 00:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767918142; cv=none; b=HRfNn65+ZK/OaEGwZTucLhSlLhOzCLtWuBSBT2p9WwEbXT0+KtFoVz5G1QwA+C0XP8Vh5otdyiYOwHUBkwJFbp6CKHUb4dI9+H8+c2nC6Vx9NN37dEW2YT7iF3jpCml8W2/ZMX8BvOpx4qhg92RLe72NcwLhagcwWyE76fcDHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767918142; c=relaxed/simple;
	bh=s6hMajc/WxPnJ8KMlq+g5bSYEESnqgOE6zR01kmwWfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+IT0RD2bWGADYbLVfuIL3tcQnMjth6+ZPGQXeep+WefYvXHiob7GYI+lsuoTxruSx6MG9LwGqEcQemogtphSgbOUJXR8WNDiUXFDhmDXNOMaVhQlw4JDVQvDf56WYhu10MBI++3c6lDfp/Y9PnIKNIvOCgEscnI2MPQ9R5MZS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VgUDy14k; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0f1edef2-f788-4d91-89e3-348465f91635@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767918128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3I9DcHBD4oEdTU67wQ5yymphc0845jveUaJjQQrn2to=;
	b=VgUDy14kZ0r5fqlT6q4x+4+99qIOMlXtFwxryCMfme4COJXfYUVy0YCuJIFLflk6eJXaL9
	LGERbvOu37YJYarI549LGYjjJXHNU4GBRMR/hbmLXvlUefEZPAPojH204HqJvOCcr2fLpi
	5mGCer+ITvje//A8gj5Ikd/ylqs4Rz0=
Date: Thu, 8 Jan 2026 16:22:01 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2 v6.6] Fix CVE-2024-57795
To: Shivani Agarwal <shivani.agarwal@broadcom.com>, stable@vger.kernel.org,
 gregkh@linuxfoundation.org
Cc: jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com, mbloch@nvidia.com,
 parav@nvidia.com, mrgolin@amazon.com, roman.gushchin@linux.dev,
 wangliang74@huawei.com, marco.crivellari@suse.com, zhao.xichao@vivo.com,
 haggaie@mellanox.com, monis@mellanox.com, dledford@redhat.com,
 amirv@mellanox.com, kamalh@mellanox.com, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, vamsi-krishna.brahmajosyula@broadcom.com,
 yin.ding@broadcom.com, tapas.kundu@broadcom.com
References: <20260108100540.672666-1-shivani.agarwal@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260108100540.672666-1-shivani.agarwal@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/8/26 2:05 AM, Shivani Agarwal wrote:
> To fix CVE-2024-57795, commit 8ce2eb9dfac8 is required; however,
> it depends on commit 2ac5415022d1. Therefore, both patches have
> been backported to v6.6.

Thanks a lot. It is my honor to fix this CVE problemm.
I am fine with this patch series.

Zhu Yanjun

> 
> Zhu Yanjun (2):
>    RDMA/rxe: Remove the direct link to net_device
>    RDMA/rxe: Fix the failure of ibv_query_device() and
>      ibv_query_device_ex() tests
> 
>   drivers/infiniband/core/device.c      |  1 +
>   drivers/infiniband/sw/rxe/rxe.c       | 22 ++++++++++++----------
>   drivers/infiniband/sw/rxe/rxe.h       |  3 ++-
>   drivers/infiniband/sw/rxe/rxe_mcast.c | 22 ++++++++++++++++++++--
>   drivers/infiniband/sw/rxe/rxe_net.c   | 25 ++++++++++++++++++++-----
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 26 +++++++++++++++++++++-----
>   drivers/infiniband/sw/rxe/rxe_verbs.h | 11 ++++++++---
>   include/rdma/ib_verbs.h               |  2 ++
>   8 files changed, 86 insertions(+), 26 deletions(-)
> 


