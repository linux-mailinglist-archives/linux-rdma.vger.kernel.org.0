Return-Path: <linux-rdma+bounces-3702-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A06929BBC
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 07:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237B11F215B5
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 05:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B673FBA4B;
	Mon,  8 Jul 2024 05:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEFGORmv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71110AD5A;
	Mon,  8 Jul 2024 05:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720417308; cv=none; b=BrkstXNwtMVmFg1kXfdnIS2ahRDC7ZlznYLRuvHE08O1XyCzlaAuarX85KK2OFMIV3tMvJlxHhWLJ7xmszHRfwT4NTUfpHAYLM+bsJYf0eILWkNnAdDpEAFmLym3cKcL1QNMKKQwHYkn+JTLp6BeUyJ6DrZTU4EM0QtHX9/t/AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720417308; c=relaxed/simple;
	bh=OG+zUhKK1/GHQBgp4ByltQ57Fx04v00EykUypby03Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwhMK9UZTWcIc5FCh5Kn07aoSi5/94CFn2+C+4rvQpp82rycXgh4U49cRLKkXYULxQrPZOfsfelNpQWa5tvpjEi9oW4xugOcWBNN121C7MQ2F0iUcMuqvPQ9or7i6mc7k0u9X9uyG5f0VhqB8nGXi30dn7oM7EA3vPl1wPKnoAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEFGORmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8D9C116B1;
	Mon,  8 Jul 2024 05:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720417308;
	bh=OG+zUhKK1/GHQBgp4ByltQ57Fx04v00EykUypby03Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dEFGORmvZs2BDPgVBGyClZxnXNnktAlpuT9frWF1I8ylmPgwmVmYdxXcg7nxDI/lz
	 UUVuT1/BEn6UmpPIljx3iSRDRIPlEdW3OLMszN8uqk3aE2SpbY/7MDPkqUE4Nlwoc+
	 yjtTB1yi66syCb+LyHk3+iq5hu/nS+L+gCo8rv7tP35MaqiCZ/CxHHE+d5pqPKD2ts
	 1FbbdjTyPL+25vBPwemOumQprDxt519K/4YbIB5djb9FIqX9AGAbLsFFDA5t8B6eE8
	 x16E8Jqp8FSW6iGGtQkTt1YmTgUK4SLiLnTfv6JR2C0bWSrmwbUjtyMO1mlMztZNL+
	 cIrFn3+GFnhpw==
Date: Mon, 8 Jul 2024 08:41:44 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc 5/9] RDMA/hns: Fix missing pagesize and alignment
 check in FRMR
Message-ID: <20240708054144.GB6788@unreal>
References: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
 <20240705085937.1644229-6-huangjunxian6@hisilicon.com>
 <eba4bfaf-5986-489b-9ae5-8f5618501290@linux.dev>
 <849ed8b9-e826-7211-3e90-7fdeff9d945a@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <849ed8b9-e826-7211-3e90-7fdeff9d945a@hisilicon.com>

On Mon, Jul 08, 2024 at 10:44:52AM +0800, Junxian Huang wrote:
> 
> 
> On 2024/7/7 17:16, Zhu Yanjun wrote:
> > 在 2024/7/5 16:59, Junxian Huang 写道:
> >> From: Chengchang Tang <tangchengchang@huawei.com>
> >>
> >> The offset requires 128B alignment and the page size ranges from
> >> 4K to 128M.
> >>
> >> Fixes: 68a997c5d28c ("RDMA/hns: Add FRMR support for hip08")
> > 
> > https://patchwork.kernel.org/project/linux-rdma/patch/2eee7e35-504e-4f2a-a364-527e90669108@CMEXHTCAS1.ad.emulex.com/
> > In the above link, from Bart, it seems that FRMR is renamed to FRWR.
> > "
> > There are already a few drivers upstream in which the fast register
> > memory region work request is abbreviated as FRWR. Please consider
> > renaming FRMR into FRWR in order to avoid confusion and in order to
> > make it easier to find related code with grep in the kernel tree.
> > "
> > 
> > So is it possible to rename FRMR to FRWR?
> > 
> 
> I think the rename is irrelevant to this bugfix, and if it needs to be done,
> we'll need a single patch to rename all existing 'FRMR' in hns driver.
> 
> So let's leave it as is for now.

+1

> 
> Thanks,
> Junxian
> 
> >> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> >> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> >> ---
> >>   drivers/infiniband/hw/hns/hns_roce_device.h | 4 ++++
> >>   drivers/infiniband/hw/hns/hns_roce_mr.c     | 5 +++++
> >>   2 files changed, 9 insertions(+)
> >>
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> >> index 5a2445f357ab..15b3b978a601 100644
> >> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> >> @@ -83,6 +83,7 @@
> >>   #define MR_TYPE_DMA                0x03
> >>     #define HNS_ROCE_FRMR_MAX_PA            512
> >> +#define HNS_ROCE_FRMR_ALIGN_SIZE        128
> >>     #define PKEY_ID                    0xffff
> >>   #define NODE_DESC_SIZE                64
> >> @@ -189,6 +190,9 @@ enum {
> >>   #define HNS_HW_PAGE_SHIFT            12
> >>   #define HNS_HW_PAGE_SIZE            (1 << HNS_HW_PAGE_SHIFT)
> >>   +#define HNS_HW_MAX_PAGE_SHIFT            27
> >> +#define HNS_HW_MAX_PAGE_SIZE            (1 << HNS_HW_MAX_PAGE_SHIFT)
> >> +
> >>   struct hns_roce_uar {
> >>       u64        pfn;
> >>       unsigned long    index;
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> >> index 1a61dceb3319..846da8c78b8b 100644
> >> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> >> @@ -443,6 +443,11 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
> >>       struct hns_roce_mtr *mtr = &mr->pbl_mtr;
> >>       int ret, sg_num = 0;
> >>   +    if (!IS_ALIGNED(*sg_offset, HNS_ROCE_FRMR_ALIGN_SIZE) ||
> >> +        ibmr->page_size < HNS_HW_PAGE_SIZE ||
> >> +        ibmr->page_size > HNS_HW_MAX_PAGE_SIZE)
> >> +        return sg_num;
> >> +
> >>       mr->npages = 0;
> >>       mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
> >>                    sizeof(dma_addr_t), GFP_KERNEL);
> > 

