Return-Path: <linux-rdma+bounces-3711-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD658929E58
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 10:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3043EB22592
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 08:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249F63BB25;
	Mon,  8 Jul 2024 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBk90HXa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B3228DA5;
	Mon,  8 Jul 2024 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720427639; cv=none; b=o2vsm7g7X8SheEOOcC/GE1Ohxmy/lIGp8DqaHvszrQ4A3fcjC/0WrAFiDRlz3cgGvZU/cN/dryVM4pPxEX3iIrAgulpV9Z1YBctrWRi+81zNa/WSerrAMFz1bGArPdGhoWsRCMrMUeE+aXXSW21uar8lHXEFKUg0QSBHFFTnXtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720427639; c=relaxed/simple;
	bh=3sIPxb33042IQAE+yPREfvhASe7BN0JL4LULQUVHHxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZkhW21whjU/QrlZcwsQyr3OfVRouqwKYOihs1M9ygeVfRCeblMP9hdbG3+IQi8Of7OFHl7e6P2L0HlZGYpPyWEqDd/YtXb3rFnJAIklnHY+6KZiIU8FqF1mvqUcm2hWMkTioIM26r8Ik+4F97Z11q0dcykbL4WXpEY8c9w2nu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBk90HXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40A7C116B1;
	Mon,  8 Jul 2024 08:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720427639;
	bh=3sIPxb33042IQAE+yPREfvhASe7BN0JL4LULQUVHHxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBk90HXaIIW1DiW+1RTmR547tTLZF/2yWHveDDufJZ5quyl0FweEfDqJDXVrYBCVb
	 TGLs50c2l8/N9fU3ttPJPNu5/ne3R8iVM8CqbM0lcpQDGDMqufRlWKyJf/bl4iLfKL
	 0Tc0Xc9tf5Y6mIwjDpm0NpYsx7XizGoNxj0Qqfwy6+UtMVla11YwPR5xBQi9jvy1nR
	 3w/Nq8L110OkZthwMUlvsgvKUOu1+4DAVp78MCPi1YTBFTOq0+CqJh8kGnkRWO0YO3
	 j3neuwH+OMn8ibGzeyHu3wz4L0qdrxDuR5N1B0v7CL8aRgHTVu8ZjDFcObLAFp1ypV
	 lYSbzEmL/TLkw==
Date: Mon, 8 Jul 2024 11:33:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc 5/9] RDMA/hns: Fix missing pagesize and alignment
 check in FRMR
Message-ID: <20240708083356.GE6788@unreal>
References: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
 <20240705085937.1644229-6-huangjunxian6@hisilicon.com>
 <eba4bfaf-5986-489b-9ae5-8f5618501290@linux.dev>
 <849ed8b9-e826-7211-3e90-7fdeff9d945a@hisilicon.com>
 <ccd00d9d-4cad-4b18-ae73-e618d669959e@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccd00d9d-4cad-4b18-ae73-e618d669959e@linux.dev>

On Mon, Jul 08, 2024 at 03:57:49PM +0800, Zhu Yanjun wrote:
> 在 2024/7/8 10:44, Junxian Huang 写道:
> > 
> > 
> > On 2024/7/7 17:16, Zhu Yanjun wrote:
> > > 在 2024/7/5 16:59, Junxian Huang 写道:
> > > > From: Chengchang Tang <tangchengchang@huawei.com>
> > > > 
> > > > The offset requires 128B alignment and the page size ranges from
> > > > 4K to 128M.
> > > > 
> > > > Fixes: 68a997c5d28c ("RDMA/hns: Add FRMR support for hip08")
> > > 
> > > https://patchwork.kernel.org/project/linux-rdma/patch/2eee7e35-504e-4f2a-a364-527e90669108@CMEXHTCAS1.ad.emulex.com/
> > > In the above link, from Bart, it seems that FRMR is renamed to FRWR.
> > > "
> > > There are already a few drivers upstream in which the fast register
> > > memory region work request is abbreviated as FRWR. Please consider
> > > renaming FRMR into FRWR in order to avoid confusion and in order to
> > > make it easier to find related code with grep in the kernel tree.
> > > "
> > > 
> > > So is it possible to rename FRMR to FRWR?
> > > 
> > 
> > I think the rename is irrelevant to this bugfix, and if it needs to be done,
> > we'll need a single patch to rename all existing 'FRMR' in hns driver.
> > 
> > So let's leave it as is for now.
> 
> Exactly. FRMR is obsolete. We do need a single patch to rename all existing
> "FRMR" to "FRWR" in RDMA.
> 
> @Leon, please let me know your suggestions.

Our preference is to avoid from churn patches which are not part of some
larger series. In this case, rename won't give us any benefit, but will
create a lot of noise for the backports.

There is no need to be cruel to the people who are doing these backports
just because "some word was removed from the dictionary".

Thanks

> Thanks,
> 
> Zhu Yanjun
> 
> > 
> > Thanks,
> > Junxian
> > 
> > > > Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> > > > Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> > > > ---
> > > >    drivers/infiniband/hw/hns/hns_roce_device.h | 4 ++++
> > > >    drivers/infiniband/hw/hns/hns_roce_mr.c     | 5 +++++
> > > >    2 files changed, 9 insertions(+)
> > > > 
> > > > diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> > > > index 5a2445f357ab..15b3b978a601 100644
> > > > --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> > > > +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> > > > @@ -83,6 +83,7 @@
> > > >    #define MR_TYPE_DMA                0x03
> > > >      #define HNS_ROCE_FRMR_MAX_PA            512
> > > > +#define HNS_ROCE_FRMR_ALIGN_SIZE        128
> > > >      #define PKEY_ID                    0xffff
> > > >    #define NODE_DESC_SIZE                64
> > > > @@ -189,6 +190,9 @@ enum {
> > > >    #define HNS_HW_PAGE_SHIFT            12
> > > >    #define HNS_HW_PAGE_SIZE            (1 << HNS_HW_PAGE_SHIFT)
> > > >    +#define HNS_HW_MAX_PAGE_SHIFT            27
> > > > +#define HNS_HW_MAX_PAGE_SIZE            (1 << HNS_HW_MAX_PAGE_SHIFT)
> > > > +
> > > >    struct hns_roce_uar {
> > > >        u64        pfn;
> > > >        unsigned long    index;
> > > > diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> > > > index 1a61dceb3319..846da8c78b8b 100644
> > > > --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
> > > > +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> > > > @@ -443,6 +443,11 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
> > > >        struct hns_roce_mtr *mtr = &mr->pbl_mtr;
> > > >        int ret, sg_num = 0;
> > > >    +    if (!IS_ALIGNED(*sg_offset, HNS_ROCE_FRMR_ALIGN_SIZE) ||
> > > > +        ibmr->page_size < HNS_HW_PAGE_SIZE ||
> > > > +        ibmr->page_size > HNS_HW_MAX_PAGE_SIZE)
> > > > +        return sg_num;
> > > > +
> > > >        mr->npages = 0;
> > > >        mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
> > > >                     sizeof(dma_addr_t), GFP_KERNEL);
> > > 
> 

