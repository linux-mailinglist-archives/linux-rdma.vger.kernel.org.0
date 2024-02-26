Return-Path: <linux-rdma+bounces-1132-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB518675C7
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 13:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65092850E0
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 12:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668837FBAA;
	Mon, 26 Feb 2024 12:57:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9607F475;
	Mon, 26 Feb 2024 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952231; cv=none; b=mzZ0jDLxoMvKqplnG5Enzfwzidxi6LGt7Cn2ui99wtsO2hpPHDBzE0SGtDlAzIL0ObgE87nauiA8vzFYe9udcuHVJnEQYYsYY/DbF0OaMaymZgyzxl1XyEfFmFrTkO/RxwOfm1nkl+lQy50L0pvPAEelLkKu0EXQ0oYurEfQz9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952231; c=relaxed/simple;
	bh=JHreYlFG9Bvy0VWQqGq32kV4+VYQfyv2BVzD2+p+oGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fVG3MtnXB4XeaL1oBHSNCOxfXb9hTVg6RSC6PtyvgApVRL7AIImUTODYZjuazR9f1Jpm4Jq5wP9/VmNDJFT6lAPHhgpBTb9ArIrCrknRBseg/VtuAANAOWgHGprbFqNMx5AkQHNYhbEnLoUKGKqesYMyu7PXudfxf64jSgJTHyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tk0w873P6z1xpTt;
	Mon, 26 Feb 2024 20:55:36 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 16B191A0172;
	Mon, 26 Feb 2024 20:57:05 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 20:57:04 +0800
Message-ID: <954a1e9b-d0bb-10ea-aaa9-6a958de30537@hisilicon.com>
Date: Mon, 26 Feb 2024 20:57:04 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v2 for-next 2/2] RDMA/hns: Support userspace configuring
 congestion control algorithm with QP granularity
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20240208035038.94668-1-huangjunxian6@hisilicon.com>
 <20240208035038.94668-3-huangjunxian6@hisilicon.com>
 <20240221155248.GD13491@ziepe.ca>
 <26ea175c-fa31-720c-2ac3-41abcb4d398a@hisilicon.com>
 <20240226080946.GC1842804@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240226080946.GC1842804@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)



On 2024/2/26 16:09, Leon Romanovsky wrote:
> On Thu, Feb 22, 2024 at 03:06:20PM +0800, Junxian Huang wrote:
>>
>>
>> On 2024/2/21 23:52, Jason Gunthorpe wrote:
>>> On Thu, Feb 08, 2024 at 11:50:38AM +0800, Junxian Huang wrote:
>>>> Support userspace configuring congestion control algorithm with
>>>> QP granularity. If the algorithm is not specified in userspace,
>>>> use the default one.
>>>>
>>>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>>>> ---
>>>>  drivers/infiniband/hw/hns/hns_roce_device.h | 23 +++++--
>>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 14 +---
>>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  3 +-
>>>>  drivers/infiniband/hw/hns/hns_roce_main.c   |  3 +
>>>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 71 +++++++++++++++++++++
>>>>  include/uapi/rdma/hns-abi.h                 | 17 +++++
>>>>  6 files changed, 112 insertions(+), 19 deletions(-)
> 
> <...>
> 
>>>> +
>>>> +enum hns_roce_create_qp_comp_mask {
>>>> +	HNS_ROCE_CREATE_QP_MASK_CONGEST_TYPE = 1 << 1,
>>>
>>> Why 1<<1 not 1<<0?
>>
>> This is to keep consistent with our internal ABI, there are some
>> features not upstream yet.
>>
> 
> <...>
> 
>>>> @@ -114,6 +128,9 @@ struct hns_roce_ib_alloc_ucontext_resp {
>>>>  	__u32	reserved;
>>>>  	__u32	config;
>>>>  	__u32	max_inline_data;
>>>> +	__u8	reserved0;
>>>> +	__u8	congest_type;
>>>
>>> Why this layout?
>>>> Jason
>>
>> Same as the 1<<1 issue, to keep consistent with our internal ABI.
> 
> We are talking about upstream kernel UAPI, there is no internal ABI here.
> 
> Please fix it.
> 
> Thanks
> 

Sure. Will fix it in next version.

Thanks,
Junxian

>>
>> Thanks,
>> Junxian

