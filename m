Return-Path: <linux-rdma+bounces-9638-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA69BA95152
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 15:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B701881F17
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 13:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A321263F3F;
	Mon, 21 Apr 2025 13:01:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ACF20C037
	for <linux-rdma@vger.kernel.org>; Mon, 21 Apr 2025 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745240516; cv=none; b=K/yrJ52Eci0XQjmTCcuhqwYWrEXO/KbZ/NTwnYkc6kvP91vmQQ+RsihfK1hwHh2wUtVE8MQbiDJYdZ1VmAxMFOLANSPse0lyRqK/CMHJ1tRFDfK0CEswzLGBEiszHFJ8+rtgiJvQJhcdBtq4+H6KJ0bxnGqyjkIzRnVAiNwvjJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745240516; c=relaxed/simple;
	bh=PSfJDVxKiEcou6GYNcjarRQPGNhYriHtu6K02ncg7lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q4BTnnNqiYIkPHvVP3g96NqRYHE6RBASF+TT2hpLNG2kjwipgtg9dodyR88VGoOjXgQvEwlxddz3J3QfRr70hMs7ka5CARXiC3mmUjBFATeSeXhvFnPea8mIB34sLY25QNy0p9C8K4fjWeer0AKvXhJMxw2D+qK29sCrnJtN29M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zh54j3vm9zvWq8;
	Mon, 21 Apr 2025 20:57:41 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id DA7D3140121;
	Mon, 21 Apr 2025 21:01:49 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Apr 2025 21:01:49 +0800
Message-ID: <108d44f3-c336-52da-c86b-5c4bfe2ac18d@hisilicon.com>
Date: Mon, 21 Apr 2025 21:01:48 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH for-next 0/6] RDMA/hns: Add trace support
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<tangchengchang@huawei.com>
References: <20250418085647.4067840-1-huangjunxian6@hisilicon.com>
 <20250420151118.GD10635@unreal>
Content-Language: en-US
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20250420151118.GD10635@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/4/20 23:11, Leon Romanovsky wrote:
> On Fri, Apr 18, 2025 at 04:56:41PM +0800, Junxian Huang wrote:
>> Add trace support for hns. Set tracepoints for flushe CQE, WQE,
>> AEQE, MT/MTR and CMDQ.
>>
>> Patch #5 fixes the dependency issue of hns_roce_hw_v2.h on hnae3.h,
>> otherwise there will be a compilation error when hns_roce_hw_v2.h
>> is included in hns_roce_trace.h in patch #6.
>>
>> Junxian Huang (6):
>>   RDMA/hns: Add trace for flush CQE
>>   RDMA/hns: Add trace for WQE dumping
>>   RDMA/hns: Add trace for AEQE dumping
>>   RDMA/hns: Add trace for MR/MTR attribute dumping
>>   RDMA/hns: Include hnae3.h in hns_roce_hw_v2.h
>>   RDMA/hns: Add trace for CMDQ dumping
>>
>>  drivers/infiniband/hw/hns/hns_roce_ah.c       |   1 -
>>  drivers/infiniband/hw/hns/hns_roce_device.h   |  20 ++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  19 +-
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h    |   1 +
>>  drivers/infiniband/hw/hns/hns_roce_main.c     |   1 -
>>  drivers/infiniband/hw/hns/hns_roce_mr.c       |   3 +
>>  drivers/infiniband/hw/hns/hns_roce_restrack.c |   1 -
>>  drivers/infiniband/hw/hns/hns_roce_trace.h    | 213 ++++++++++++++++++
>>  8 files changed, 255 insertions(+), 4 deletions(-)
>>  create mode 100644 drivers/infiniband/hw/hns/hns_roce_trace.h
> 
> Please change trace_drv_* calls to have a name of your driver, e.g.
> trace_drv_mr() -> trace_hns_mr().
> 

Sure

> Thanks
> 
>>
>> --
>> 2.33.0
>>
>>

