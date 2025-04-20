Return-Path: <linux-rdma+bounces-9634-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65527A950A7
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 14:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F467A83C9
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 12:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1983D264F8F;
	Mon, 21 Apr 2025 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTSbNmH0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE964264F89
	for <linux-rdma@vger.kernel.org>; Mon, 21 Apr 2025 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745237715; cv=none; b=KzYD2+1dVekfSwTko7cYP5ROlWJUmcS3w5q4s+ogOmTEwqAxBILqXnFDVhPvkmXm9rhh8FbI4qG7A7ySuaaoV+TfH6vQa9rvvFHcXczcOo/w4RGEtPiRIVO1z2FeZdsN4iNR91miC6PBK7KNbRm2GCKWWkO0abLJnhASE1IMgwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745237715; c=relaxed/simple;
	bh=xxdN4s1/s+GYpDDtpmQSxWH5qcjVCA0LWvl5GmhB4pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1mhEfcwL8bRoABM2/ujiZ5cWcyM7XDNFP+M6VV3pwn/WiBasKM5PEDBcGr4ucybcjeMwdSuohtQPzT/r5md2QBPa2yYMQ24IGg3ukAyNSD6kAZl5jerq36Gc6Sg1UM1ApHdGoce/Kd8lUv3NIYW4DeB0ZfhXAgh2cFn6pjuBSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTSbNmH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D222BC4CEE4;
	Mon, 21 Apr 2025 12:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745237715;
	bh=xxdN4s1/s+GYpDDtpmQSxWH5qcjVCA0LWvl5GmhB4pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTSbNmH0OvNADZ+nW7gT/5outIMW8eZ3hcunl2hdpXXt11HJJ7Az96Z+7gBXEcTPB
	 GQllII7IHV6Sbq8x0EC/jDIagmJQYft9CgBPqN7lpDU7yko2iNudKBUgYaGAVf5UWq
	 XmgnY+Cfz4vPxH3CL7I2VKrnDeXWXgvCGOwW39pxt3hNoE2RDlPgU1FEAI3ddCS9yB
	 NnwmlaEk3o7cXlbnJMzgLqsfqTMGuDDAgZ8Wu81yhyjTPU2WvBJyM4/RSqmeJrvJlZ
	 bkW5pKkMSFfg87ZFzT1Lj5eMJ9iwZcjV9e0UlmBezhNGly9Bzzgumv9+lQCiVW/r20
	 YJyOVrx00r1Vw==
Date: Sun, 20 Apr 2025 18:11:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-next 0/6] RDMA/hns: Add trace support
Message-ID: <20250420151118.GD10635@unreal>
References: <20250418085647.4067840-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418085647.4067840-1-huangjunxian6@hisilicon.com>

On Fri, Apr 18, 2025 at 04:56:41PM +0800, Junxian Huang wrote:
> Add trace support for hns. Set tracepoints for flushe CQE, WQE,
> AEQE, MT/MTR and CMDQ.
> 
> Patch #5 fixes the dependency issue of hns_roce_hw_v2.h on hnae3.h,
> otherwise there will be a compilation error when hns_roce_hw_v2.h
> is included in hns_roce_trace.h in patch #6.
> 
> Junxian Huang (6):
>   RDMA/hns: Add trace for flush CQE
>   RDMA/hns: Add trace for WQE dumping
>   RDMA/hns: Add trace for AEQE dumping
>   RDMA/hns: Add trace for MR/MTR attribute dumping
>   RDMA/hns: Include hnae3.h in hns_roce_hw_v2.h
>   RDMA/hns: Add trace for CMDQ dumping
> 
>  drivers/infiniband/hw/hns/hns_roce_ah.c       |   1 -
>  drivers/infiniband/hw/hns/hns_roce_device.h   |  20 ++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  19 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h    |   1 +
>  drivers/infiniband/hw/hns/hns_roce_main.c     |   1 -
>  drivers/infiniband/hw/hns/hns_roce_mr.c       |   3 +
>  drivers/infiniband/hw/hns/hns_roce_restrack.c |   1 -
>  drivers/infiniband/hw/hns/hns_roce_trace.h    | 213 ++++++++++++++++++
>  8 files changed, 255 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/infiniband/hw/hns/hns_roce_trace.h

Please change trace_drv_* calls to have a name of your driver, e.g.
trace_drv_mr() -> trace_hns_mr().

Thanks

> 
> --
> 2.33.0
> 
> 

