Return-Path: <linux-rdma+bounces-5444-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE46D9A23B2
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 15:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229141C22F4D
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 13:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A111DDC0F;
	Thu, 17 Oct 2024 13:21:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627641D435F;
	Thu, 17 Oct 2024 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171313; cv=none; b=g7J7eqxg2nUu4a40QACEpz7gNENquoQDDsC+jDVZbr4hEQc4gUmIMau07R2ZLomEdh9QKwyQIfk677saO53rR7JNB7zmmdBs26f01mlF7waZoDoMYEFpXp+bd5B7dvQEUtI43mG6wbnOveycO/VxosaWaNyeotBZmQyDiq560Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171313; c=relaxed/simple;
	bh=HO7VO/l6vJF2WWghEaMrdSEc1Pa6WBo/pIGgw3SVUHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c1bDbzNk+/bKC9lk775VQhQr+fuZaUmpu5VlQ+zye/GDJ4mBDHUZp/9I71LY0sJVrZS+MeyJfxj0BaX0RwgBWtwLDCT6COZIgFddBwXUzqH/8PBbWP90N/pFB1sEmVFaM5EUDLsRATQpApPYwW9vvMMKGqKpfNpyJhZmHEgqgcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XTpN83clLz10N2f;
	Thu, 17 Oct 2024 21:19:52 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id B50281800F2;
	Thu, 17 Oct 2024 21:21:46 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Oct 2024 21:21:46 +0800
Message-ID: <cd7ae683-c9b9-cb1c-c5fc-739d66c303ec@hisilicon.com>
Date: Thu, 17 Oct 2024 21:21:45 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-next 9/9] RDMA/hns: Fix different dgids mapping to the
 same dip_idx
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240906093444.3571619-1-huangjunxian6@hisilicon.com>
 <20240906093444.3571619-10-huangjunxian6@hisilicon.com>
 <20240910131205.GB4026@unreal>
Content-Language: en-US
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240910131205.GB4026@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/9/10 21:12, Leon Romanovsky wrote:
> On Fri, Sep 06, 2024 at 05:34:44PM +0800, Junxian Huang wrote:
>> From: Feng Fang <fangfeng4@huawei.com>
>>
>> DIP algorithm requires a one-to-one mapping between dgid and dip_idx.
>> Currently a queue 'spare_idx' is used to store QPN of QPs that use
>> DIP algorithm. For a new dgid, use a QPN from spare_idx as dip_idx.
>> This method lacks a mechanism for deduplicating QPN, which may result
>> in different dgids sharing the same dip_idx and break the one-to-one
>> mapping requirement.
>>
>> This patch replaces spare_idx with two new bitmaps: qpn_bitmap to record
>> QPN that is not being used as dip_idx, and dip_idx_map to record QPN
>> that is being used. Besides, introduce a reference count of a dip_idx
>> to indicate the number of QPs that using this dip_idx. When creating
>> a DIP QP, if it has a new dgid, set the corresponding bit in dip_idx_map,
>> otherwise add 1 to the reference count of the reused dip_idx and set bit
>> in qpn_bitmap. When destroying a DIP QP, decrement the reference count
>> by 1. If it becomes 0, set bit in qpn_bitmap and clear bit in dip_idx_map.
>>
>> Fixes: eb653eda1e91 ("RDMA/hns: Bugfix for incorrect association between dip_idx and dgid")
>> Fixes: f91696f2f053 ("RDMA/hns: Support congestion control type selection according to the FW")
>> Signed-off-by: Feng Fang <fangfeng4@huawei.com>
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  6 +--
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 58 ++++++++++++++++++---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  1 +
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 16 ++++--
>>  4 files changed, 67 insertions(+), 14 deletions(-)
> 
> It is strange implementation, double bitmap and refcount looks like
> open-coding of some basic coding patterns. Let's wait with applying it
> for now.
> 

Hi Leon, it's been a while since this patch was sent. Is it okay to be applied?

Regarding your question about the double bitmaps, that's because we have 3 states
to track:
1) the context hasn't been created
2) the context has been created but not used as dip_ctx
3) the context is being used as dip_ctx.

Junxian

> Thanks
> 

