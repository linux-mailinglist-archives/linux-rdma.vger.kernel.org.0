Return-Path: <linux-rdma+bounces-3188-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FFE90A000
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 23:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92EF1F21876
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 21:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1900D62171;
	Sun, 16 Jun 2024 21:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AfuHdrtN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B87224D7
	for <linux-rdma@vger.kernel.org>; Sun, 16 Jun 2024 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718574439; cv=none; b=RnQQCMXg00hXWzaQAIET52/ka0VaPsri2GE3M/Hqa2hDwKEu8FjXsmo7a6CO/YCTEjrFYmcg1wCtHUpGN643d+SjGlmaeZlE+iM3XEdvSoB67nQ4P+Ju4SLrk7PpCL/BfaRPVNqYQbdMYD5zK8nUc72RJowB/4BrnKqkbiDNwOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718574439; c=relaxed/simple;
	bh=qY8ekCqb8CSYQlKNCmLpflYUJ/M3Swd1KevOkF6VTk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMLjg5of7mLP/zylzln25JPssRhxR0I3j+lI7mtlUMnnRU7Vl6hgCaAhywGMDp/KD3ItWQFcu50NcLXLBYEvlaZ2Gsiz79K+0BGPEMpKrLDRoaFME/4xXWheqR+9FVbv5UUVD3MzFru6sK3dRD4vpAmpVvN6ceUG8aU77PgG+6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AfuHdrtN; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: leon@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718574433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWJq14Wd9GMO7wEHyo/kTx7ZOQD0we/nLwb6bsYiYQg=;
	b=AfuHdrtNjCzRQ/zHEp/TVV5RDBbBLYzswwJTmwUv/1PB089c0eOP470uQYraE//ISInUXy
	Io1o/KYs5in+2+VjsUEH+gtnpuTAg2BO9q6Z+D+M5wG1uX/KXdbLb8igNktcuCkcPPdK5v
	MTOjOo+95CfmNUkQfGg7Jhiv2eqHZCc=
X-Envelope-To: jgg@nvidia.com
X-Envelope-To: leonro@nvidia.com
X-Envelope-To: sharmaajay@microsoft.com
X-Envelope-To: agoldberger@nvidia.com
X-Envelope-To: bmt@zurich.ibm.com
X-Envelope-To: tangchengchang@huawei.com
X-Envelope-To: chengyou@linux.alibaba.com
X-Envelope-To: huangjunxian6@hisilicon.com
X-Envelope-To: kaishen@linux.alibaba.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: longli@microsoft.com
X-Envelope-To: mrgolin@amazon.com
X-Envelope-To: mustafa.ismail@intel.com
X-Envelope-To: bharat@chelsio.com
X-Envelope-To: selvin.xavier@broadcom.com
X-Envelope-To: shiraz.saleem@intel.com
X-Envelope-To: yishaih@nvidia.com
X-Envelope-To: zyjzyj2000@gmail.com
Message-ID: <08219370-0d56-4c92-8b05-f42ca67b1bce@linux.dev>
Date: Mon, 17 Jun 2024 05:47:00 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 0/2] Extend mlx5 CQ creation with large UAR page
 index
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
 Ajay Sharma <sharmaajay@microsoft.com>,
 Akiva Goldberger <agoldberger@nvidia.com>,
 Bernard Metzler <bmt@zurich.ibm.com>,
 Chengchang Tang <tangchengchang@huawei.com>,
 Cheng Xu <chengyou@linux.alibaba.com>,
 Junxian Huang <huangjunxian6@hisilicon.com>,
 Kai Shen <kaishen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>,
 Michael Margolin <mrgolin@amazon.com>,
 Mustafa Ismail <mustafa.ismail@intel.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>
References: <cover.1718554263.git.leon@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <cover.1718554263.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/6/17 0:15, Leon Romanovsky 写道:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This series from Akiva extends the mlx5 private field with the UAR page index
> which is larger than 16 bits as was before.

UAR: User Access Region

Zhu Yanjun
> 
> As this is first time, we extend ioctl API with private data field after
> it already has UHW object, we need to change create CQ API signature to
> support it.
> 
> Thanks
> 
> Akiva Goldberger (2):
>    RDMA: Pass entire uverbs attr bundle to create cq function
>    RDMA/mlx5: Send UAR page index as ioctl attribute
> 
>   drivers/infiniband/core/uverbs_cmd.c          |  2 +-
>   drivers/infiniband/core/uverbs_std_types_cq.c |  2 +-
>   drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  3 +-
>   drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  2 +-
>   drivers/infiniband/hw/cxgb4/cq.c              |  3 +-
>   drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  2 +-
>   drivers/infiniband/hw/efa/efa.h               |  2 +-
>   drivers/infiniband/hw/efa/efa_verbs.c         |  3 +-
>   drivers/infiniband/hw/erdma/erdma_verbs.c     |  3 +-
>   drivers/infiniband/hw/erdma/erdma_verbs.h     |  2 +-
>   drivers/infiniband/hw/hns/hns_roce_cq.c       |  3 +-
>   drivers/infiniband/hw/hns/hns_roce_device.h   |  2 +-
>   drivers/infiniband/hw/irdma/verbs.c           |  5 +--
>   drivers/infiniband/hw/mana/cq.c               |  2 +-
>   drivers/infiniband/hw/mana/mana_ib.h          |  2 +-
>   drivers/infiniband/hw/mlx4/cq.c               |  3 +-
>   drivers/infiniband/hw/mlx4/mlx4_ib.h          |  2 +-
>   drivers/infiniband/hw/mlx5/cq.c               | 31 ++++++++++++++++---
>   drivers/infiniband/hw/mlx5/main.c             |  1 +
>   drivers/infiniband/hw/mlx5/mlx5_ib.h          |  3 +-
>   drivers/infiniband/hw/mthca/mthca_provider.c  |  3 +-
>   drivers/infiniband/sw/rxe/rxe_verbs.c         |  3 +-
>   drivers/infiniband/sw/siw/siw_verbs.c         |  2 +-
>   drivers/infiniband/sw/siw/siw_verbs.h         |  2 +-
>   include/rdma/ib_verbs.h                       |  2 +-
>   include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
>   include/uapi/rdma/mlx5_user_ioctl_cmds.h      |  4 +++
>   27 files changed, 67 insertions(+), 28 deletions(-)
> 


