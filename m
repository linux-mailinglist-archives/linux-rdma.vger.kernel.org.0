Return-Path: <linux-rdma+bounces-498-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF0681E681
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Dec 2023 10:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECB21F227B4
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Dec 2023 09:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0049E4D114;
	Tue, 26 Dec 2023 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBY+/xTU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F244D102;
	Tue, 26 Dec 2023 09:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE1EC433C7;
	Tue, 26 Dec 2023 09:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703583742;
	bh=Tsmg+MnN4G6iohoVCMTbtuf++BSfs/xm9Czu/0qaSKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sBY+/xTUXxm9VeY9c5lBhJweeyQVDX7DKjV7HvlP5iWYwZmcmyv4/PqPMhfz3oaHF
	 NXV0/2SSXT++xN7EyODtQ/v5gjMxq9SGkKOGqNa+sR18nuTJnYdDr9D/yoWYvmFzHp
	 2RWPLqMGs/Gja7Xrdtu3sjL6Nk0xr+iWuWjciLzgBbTEjDO/zlZEZ/ReiFRmN5MwdK
	 Fif2mImrslkJdIVitjWYf7nSl2gzT2OMF8oDANvlt1Jdo7z+GQSBc/GOob0wmyNgK5
	 5NbAaLCK55jrZKZe0+uLClHcqs+6JCeljwVhHp7cLMVuIGsSOyVLOITer8VmPIqmCZ
	 vXzXf/IEaUcAg==
Date: Tue, 26 Dec 2023 11:42:18 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 4/6] RDMA/hns: Support flexible pagesize
Message-ID: <20231226094218.GA17182@unreal>
References: <20231225075330.4116470-1-huangjunxian6@hisilicon.com>
 <20231225075330.4116470-5-huangjunxian6@hisilicon.com>
 <20231226085202.GA13350@unreal>
 <fbd65691-b0a2-0963-96fc-7e09a66cd203@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbd65691-b0a2-0963-96fc-7e09a66cd203@hisilicon.com>

On Tue, Dec 26, 2023 at 05:16:33PM +0800, Junxian Huang wrote:
> 
> 
> On 2023/12/26 16:52, Leon Romanovsky wrote:
> > On Mon, Dec 25, 2023 at 03:53:28PM +0800, Junxian Huang wrote:
> >> From: Chengchang Tang <tangchengchang@huawei.com>
> >>
> >> In the current implementation, a fixed page size is used to
> >> configure the PBL, which is not flexible enough and is not
> >> conducive to the performance of the HW.
> >>
> >> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> >> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> >> ---
> >>  drivers/infiniband/hw/hns/hns_roce_alloc.c  |   6 -
> >>  drivers/infiniband/hw/hns/hns_roce_device.h |   9 ++
> >>  drivers/infiniband/hw/hns/hns_roce_mr.c     | 168 +++++++++++++++-----
> >>  3 files changed, 139 insertions(+), 44 deletions(-)
> > 
> > I'm wonder if the ib_umem_find_best_pgsz() API should be used instead.
> > What is missing there?
> > 
> > Thanks
> 
> Actually this API is used for umem.
> For kmem, we add hns_roce_find_buf_best_pgsz() to do a similar job.

Thanks, let's give a chance to Jason to provide his feedback. I have a
strong feeling that this code duplicates something in the kernel.

Thanks

> 
> +static int get_best_page_shift(struct hns_roce_dev *hr_dev,
> +			       struct hns_roce_mtr *mtr,
> +			       struct hns_roce_buf_attr *buf_attr)
> +{
> +	unsigned int page_sz;
> +
> +	if (!buf_attr->adaptive || buf_attr->type != MTR_PBL)
> +		return 0;
> +
> +	if (mtr->umem)
> +		page_sz = ib_umem_find_best_pgsz(mtr->umem,
> +						 hr_dev->caps.page_size_cap,
> +						 buf_attr->iova);
> +	else
> +		page_sz = hns_roce_find_buf_best_pgsz(hr_dev, mtr->kmem);
> +
> +	if (!page_sz)
> +		return -EINVAL;
> +
> +	buf_attr->page_shift = order_base_2(page_sz);
> +	return 0;
> +}
> 
> Thanks,
> Junxian

