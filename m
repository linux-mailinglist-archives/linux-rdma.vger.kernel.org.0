Return-Path: <linux-rdma+bounces-3709-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678D1929DCE
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 09:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208C5285A00
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 07:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8265039FC6;
	Mon,  8 Jul 2024 07:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mPPZfiIP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714EB200AF
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jul 2024 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425476; cv=none; b=STFugzgWVkr9IwH4/uI7SO7wXN5Bks7Ry9UI9fItTwbvn8F67JzNQNl/4e3+qoXZfQbGluys1viK1rGz0Mo2iXnpv68MYJRaLwikpzfpifAawt1gFWlTFitCmaNDvzp4++rrHaXUXoe2nCWiUy+KV8tr/fK2EG0nDpVFsbTrpyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425476; c=relaxed/simple;
	bh=gJ2XP5CnA4wlvhXXz7nVhqB9mSHpbF+Q5WmqQ0jdGBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUK7FaAvjy06bIjjR6Dq6P2kC+LSqQrJ2P51PSSB5OKWjma792YBw7wF61Do+SwNCaJl4nD54FKictj73yGDoWleRBKvKMbKkU6dxry5gPPrZJLwBXdlLIlsa4MuT+7LNPMSbb8EbejYnLylZEM/bGXDxXXLN5EtIZFegY1mLXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mPPZfiIP; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: huangjunxian6@hisilicon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720425471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vd5x/ux/YJAPr13UISfFPy2aS6qkTR3fwPYaSqocOhI=;
	b=mPPZfiIPC6SXjtKEJMBD2DLkIg0jWUo4K0Qs59KF2V6WOPK4DK1mk2vBGURCecI/AZNTYO
	KBMlmYMWMZqdsfekjiJYNNGeCUNuZcEtG2x80YSa26VJWbe3nI6dp9Y4lRpqf+b2n+/Fhs
	sLIj42iEsS0rIFvQeTIhzjMIX4D9Zhk=
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: leon@kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: linuxarm@huawei.com
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <ccd00d9d-4cad-4b18-ae73-e618d669959e@linux.dev>
Date: Mon, 8 Jul 2024 15:57:49 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-rc 5/9] RDMA/hns: Fix missing pagesize and alignment
 check in FRMR
To: Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org
References: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
 <20240705085937.1644229-6-huangjunxian6@hisilicon.com>
 <eba4bfaf-5986-489b-9ae5-8f5618501290@linux.dev>
 <849ed8b9-e826-7211-3e90-7fdeff9d945a@hisilicon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <849ed8b9-e826-7211-3e90-7fdeff9d945a@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/7/8 10:44, Junxian Huang 写道:
> 
> 
> On 2024/7/7 17:16, Zhu Yanjun wrote:
>> 在 2024/7/5 16:59, Junxian Huang 写道:
>>> From: Chengchang Tang <tangchengchang@huawei.com>
>>>
>>> The offset requires 128B alignment and the page size ranges from
>>> 4K to 128M.
>>>
>>> Fixes: 68a997c5d28c ("RDMA/hns: Add FRMR support for hip08")
>>
>> https://patchwork.kernel.org/project/linux-rdma/patch/2eee7e35-504e-4f2a-a364-527e90669108@CMEXHTCAS1.ad.emulex.com/
>> In the above link, from Bart, it seems that FRMR is renamed to FRWR.
>> "
>> There are already a few drivers upstream in which the fast register
>> memory region work request is abbreviated as FRWR. Please consider
>> renaming FRMR into FRWR in order to avoid confusion and in order to
>> make it easier to find related code with grep in the kernel tree.
>> "
>>
>> So is it possible to rename FRMR to FRWR?
>>
> 
> I think the rename is irrelevant to this bugfix, and if it needs to be done,
> we'll need a single patch to rename all existing 'FRMR' in hns driver.
> 
> So let's leave it as is for now.

Exactly. FRMR is obsolete. We do need a single patch to rename all 
existing "FRMR" to "FRWR" in RDMA.

@Leon, please let me know your suggestions.
Thanks,

Zhu Yanjun

> 
> Thanks,
> Junxian
> 
>>> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
>>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>>> ---
>>>    drivers/infiniband/hw/hns/hns_roce_device.h | 4 ++++
>>>    drivers/infiniband/hw/hns/hns_roce_mr.c     | 5 +++++
>>>    2 files changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>>> index 5a2445f357ab..15b3b978a601 100644
>>> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
>>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>>> @@ -83,6 +83,7 @@
>>>    #define MR_TYPE_DMA                0x03
>>>      #define HNS_ROCE_FRMR_MAX_PA            512
>>> +#define HNS_ROCE_FRMR_ALIGN_SIZE        128
>>>      #define PKEY_ID                    0xffff
>>>    #define NODE_DESC_SIZE                64
>>> @@ -189,6 +190,9 @@ enum {
>>>    #define HNS_HW_PAGE_SHIFT            12
>>>    #define HNS_HW_PAGE_SIZE            (1 << HNS_HW_PAGE_SHIFT)
>>>    +#define HNS_HW_MAX_PAGE_SHIFT            27
>>> +#define HNS_HW_MAX_PAGE_SIZE            (1 << HNS_HW_MAX_PAGE_SHIFT)
>>> +
>>>    struct hns_roce_uar {
>>>        u64        pfn;
>>>        unsigned long    index;
>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
>>> index 1a61dceb3319..846da8c78b8b 100644
>>> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
>>> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
>>> @@ -443,6 +443,11 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>>>        struct hns_roce_mtr *mtr = &mr->pbl_mtr;
>>>        int ret, sg_num = 0;
>>>    +    if (!IS_ALIGNED(*sg_offset, HNS_ROCE_FRMR_ALIGN_SIZE) ||
>>> +        ibmr->page_size < HNS_HW_PAGE_SIZE ||
>>> +        ibmr->page_size > HNS_HW_MAX_PAGE_SIZE)
>>> +        return sg_num;
>>> +
>>>        mr->npages = 0;
>>>        mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
>>>                     sizeof(dma_addr_t), GFP_KERNEL);
>>


