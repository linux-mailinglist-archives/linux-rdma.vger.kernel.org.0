Return-Path: <linux-rdma+bounces-9105-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7440A78708
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 06:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F47188F4DF
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 04:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F5C1F8756;
	Wed,  2 Apr 2025 04:05:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0A72BD1B
	for <linux-rdma@vger.kernel.org>; Wed,  2 Apr 2025 04:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743566753; cv=none; b=saN0KF1arzSnnbdKiXArTwuLbYLJr9JjEIpwpo0VFFtsDZ0ff3iIbcovYOrY8cu+3BKyspTh8YRngzy6Ij6SShOswOHhel7Fa1dyRgSzv0AhvXNYgG4lo7stzLPB+/XN3HtZ2Bd8yRJWDUaVtNU/4JlIjns784FWbaKWxKSmC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743566753; c=relaxed/simple;
	bh=qS5U2AC2ZWtlXUSBjAja4EYQ+QufaGIKkg4jNL6yDxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iRRJTkxyDDdqOrAm07LDci+6suQpEvAhudOCVvveWZp+USU3eFlKffBmONF/FdbqvjXNNpsv2BXq5yPPvTXQnBeTWLbrY5fD409gUjEOfJYulJE5wKlrPzAq94aBJ4sWdj8/5dnYO5tu7hLE3SHBdHiimfNHEkq0vNVYTEqg9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZSB4y1NbpzvWwq;
	Wed,  2 Apr 2025 12:01:38 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id EF1A91800E5;
	Wed,  2 Apr 2025 12:05:37 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 12:05:37 +0800
Message-ID: <bd0c0fa5-7579-8767-8c18-73fd5459de10@hisilicon.com>
Date: Wed, 2 Apr 2025 12:05:36 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH for-next 2/2] RDMA/hns: Fix wrong maximum DMA segment size
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<tangchengchang@huawei.com>
References: <20250327114724.3454268-1-huangjunxian6@hisilicon.com>
 <20250327114724.3454268-3-huangjunxian6@hisilicon.com>
 <20250401163926.GA325474@nvidia.com>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20250401163926.GA325474@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/4/2 0:39, Jason Gunthorpe wrote:
> On Thu, Mar 27, 2025 at 07:47:24PM +0800, Junxian Huang wrote:
>> @@ -763,7 +763,7 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
>>  		if (ret)
>>  			return ret;
>>  	}
>> -	dma_set_max_seg_size(dev, UINT_MAX);
>> +	dma_set_max_seg_size(dev, SZ_2G);
> 
> Are you sure? What do you think this does in the RDMA stack?
> 

This is the maximum DMA segment size when mapping ULP's scatter/gather
list to DMA address, right?

In some cases, it is possible to map a DMA segment exceeding 2G. This
exceeds the limit of our HW.

Junxian

> Jason

