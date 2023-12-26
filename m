Return-Path: <linux-rdma+bounces-496-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA0B81E608
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Dec 2023 09:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4AD41C21D5A
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Dec 2023 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D644CDEE;
	Tue, 26 Dec 2023 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDU5W7E2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0AD4CB50;
	Tue, 26 Dec 2023 08:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6811EC433C8;
	Tue, 26 Dec 2023 08:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703580727;
	bh=jyG0jhzOfKmBvftJ+7E6X31X6Ev7kNw+BtFt0ToPtnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDU5W7E2N4N4NQG86OOkiM7s+1iPPVogKeFdF+UOvMB2HMkI+kxzAgo7uuJnuEUNY
	 Yuwy5ezW0YJh9DGqe9eVJXgqKSr7PRtWmicAU4Yx9uM6YFM8g8T2LXI1CoKfm6kYTb
	 GPgfwd6COccFMtktf0sMKRAJXBpFYhygX4jNXHvPY+2EaVgln8MnewAUdjzQqJ8ASs
	 pgZzxmC7UaPlPAngPcKWuFh5NHiFvEPMlJsHpIPVx24HoizMNyuL3pwcOLAgx7AobO
	 V27t/lLLZDL5saDDXSdRzgdE6NV4da+90G1K2AbVWNIt7OS/RjooYtgbGBUGGTIXEO
	 UNzqPGNbC617g==
Date: Tue, 26 Dec 2023 10:52:02 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 4/6] RDMA/hns: Support flexible pagesize
Message-ID: <20231226085202.GA13350@unreal>
References: <20231225075330.4116470-1-huangjunxian6@hisilicon.com>
 <20231225075330.4116470-5-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231225075330.4116470-5-huangjunxian6@hisilicon.com>

On Mon, Dec 25, 2023 at 03:53:28PM +0800, Junxian Huang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> In the current implementation, a fixed page size is used to
> configure the PBL, which is not flexible enough and is not
> conducive to the performance of the HW.
> 
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_alloc.c  |   6 -
>  drivers/infiniband/hw/hns/hns_roce_device.h |   9 ++
>  drivers/infiniband/hw/hns/hns_roce_mr.c     | 168 +++++++++++++++-----
>  3 files changed, 139 insertions(+), 44 deletions(-)

I'm wonder if the ib_umem_find_best_pgsz() API should be used instead.
What is missing there?

Thanks

