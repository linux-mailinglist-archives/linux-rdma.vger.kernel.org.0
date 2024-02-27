Return-Path: <linux-rdma+bounces-1150-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD0E8689D4
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 08:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A159285BDB
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 07:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4520954BC3;
	Tue, 27 Feb 2024 07:28:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CECFEAD5;
	Tue, 27 Feb 2024 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709018890; cv=none; b=KWfNyNyDPRdAlR0Fggm6m5VXls3n0/kUSufEpzJIKuTp3TpixcVfyaOai4FxC+ALHImoQbHlaVjJs9m2Kc5NYAmjswZfZfsJEo390/VEZLMKqZrKD8uxsCs3Oed4y86j9IKgeKsurBsnqPqv3MTqQR5BDZOyEkZwTU9TXrFAWGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709018890; c=relaxed/simple;
	bh=hvL0sbx6R2Sh77C67/IR4/MDaL+YF2p9oTYtxx9nnWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jafyANWARaYJiGPjqDRlGG2MXb053e7xO3krcT9Guf1PHu5bJ0ewKVned7fgexNcyF2yt115GeckccgxuOrK5f4NtuzACea/2RdnRU2hFUtsApYngSXsJAx2LtywzD90YuslQFLOQpQ3HtVtPBpTImeIqPGCZ1eAE1TvJuUpfhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TkTZ12bpwzNlnQ;
	Tue, 27 Feb 2024 15:26:33 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id B2B32140F0A;
	Tue, 27 Feb 2024 15:28:02 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 15:28:02 +0800
Message-ID: <f8e36e04-2318-89e0-f65e-155575d52c5e@hisilicon.com>
Date: Tue, 27 Feb 2024 15:28:01 +0800
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
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240208035038.94668-1-huangjunxian6@hisilicon.com>
 <20240208035038.94668-3-huangjunxian6@hisilicon.com>
 <20240221155248.GD13491@ziepe.ca>
 <26ea175c-fa31-720c-2ac3-41abcb4d398a@hisilicon.com>
 <20240226140647.GB3220539@ziepe.ca>
Content-Language: en-US
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240226140647.GB3220539@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)

Problems below will be fixed in next version.

Thanks,
Junxian

On 2024/2/26 22:06, Jason Gunthorpe wrote:
> On Thu, Feb 22, 2024 at 03:06:20PM +0800, Junxian Huang wrote:
>>>> +enum hns_roce_congest_type_flags {
>>>> +	HNS_ROCE_CREATE_QP_FLAGS_DCQCN = 1 << 0,
>>>> +	HNS_ROCE_CREATE_QP_FLAGS_LDCP = 1 << 1,
>>>> +	HNS_ROCE_CREATE_QP_FLAGS_HC3 = 1 << 2,
>>>> +	HNS_ROCE_CREATE_QP_FLAGS_DIP = 1 << 3,
>>>> +};
>>>
>>> Why are these bit flags if they are exclusive?
>>>
>>
>> Our FW uses bit flags. Although there is no direct relationship between
>> FW and ABI, but from the perspective of readability, bit flags are also
>> used consistently here in ABI.
> 
> Don't do that in uapi.
> 
>>>> +enum hns_roce_create_qp_comp_mask {
>>>> +	HNS_ROCE_CREATE_QP_MASK_CONGEST_TYPE = 1 << 1,
>>>
>>> Why 1<<1 not 1<<0?
>>
>> This is to keep consistent with our internal ABI, there are some
>> features not upstream yet.
> 
> Nope, pack them tightly. Don't keep an "internal ABI"
> 
>>>> @@ -114,6 +128,9 @@ struct hns_roce_ib_alloc_ucontext_resp {
>>>>  	__u32	reserved;
>>>>  	__u32	config;
>>>>  	__u32	max_inline_data;
>>>> +	__u8	reserved0;
>>>> +	__u8	congest_type;
>>>
>>> Why this layout?
>>
>> Same as the 1<<1 issue, to keep consistent with our internal ABI.
> 
> Same answer
> 
> Jason

