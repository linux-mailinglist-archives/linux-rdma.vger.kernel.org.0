Return-Path: <linux-rdma+bounces-2308-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0658BDE04
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 11:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963CD285388
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 09:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B4414D708;
	Tue,  7 May 2024 09:22:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFFC14D703;
	Tue,  7 May 2024 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073742; cv=none; b=gYqvzMQP1zt3diRoY1VPvrqouRDULgu/ePaiwuvLCerICCZSwUusC+MNDcTE0RG4vZxv7PG2mPFofgJIEhJjjW8IJI2dizb2CZU23zAeZb7d3RFyN7N2UETfFW+/bV3RBVJtYjDDH/KAgm0SBL3PYIyfv5iikcaeZh1XhbtbrXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073742; c=relaxed/simple;
	bh=wfcedzwG+EhgUy8lT3Z1ANBJKqDx/DtvFKy2hoN5u6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u/KynaxKCa4+xA1tQYUB+NKD1JIbPbC2/RIfNFlRh9SfjkIP0TOL4QCDUm+AUfo6xj/KnS78sIqPNIckZZYAmAAvSGz6BZhJEwYCeYQ/qRM3a2p0ZLOURSew/MA8ompUwBj85BGxad6VRUpvValJ4nZmKwztoAYyH3crwkoTDX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VYXlN55pfz1R9sh;
	Tue,  7 May 2024 17:18:56 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C8B918007D;
	Tue,  7 May 2024 17:22:15 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 17:22:14 +0800
Message-ID: <ce0de356-1ca1-df5f-c7db-fbe5a7fabff5@hisilicon.com>
Date: Tue, 7 May 2024 17:22:13 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-next] RDMA/hns: Support flexible WQE buffer page size
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240430092845.4058786-1-huangjunxian6@hisilicon.com>
 <20240430134113.GU231144@ziepe.ca>
Content-Language: en-US
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240430134113.GU231144@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500006.china.huawei.com (7.221.188.68)



On 2024/4/30 21:41, Jason Gunthorpe wrote:
> On Tue, Apr 30, 2024 at 05:28:45PM +0800, Junxian Huang wrote:
>> From: Chengchang Tang <tangchengchang@huawei.com>
>>
>> Currently, driver fixedly allocates 4K pages for userspace WQE buffer
>> and results in HW reading WQE with a granularity of 4K even in a 64K
>> system. HW has to switch pages every 4K, leading to a loss of performance.
> 
>> In order to improve performance, add support for userspace to allocate
>> flexible WQE buffer page size between 4K to system PAGESIZE.
>> @@ -90,7 +90,8 @@ struct hns_roce_ib_create_qp {
>>  	__u8    log_sq_bb_count;
>>  	__u8    log_sq_stride;
>>  	__u8    sq_no_prefetch;
>> -	__u8    reserved[5];
>> +	__u8    pageshift;
>> +	__u8    reserved[4];
> 
> It doesn't make any sense to pass in a pageshift from userspace.
> 
> Kernel should detect whatever underlying physical contiguity userspace
> has been able to create and configure the hardware optimally. The umem
> already has all the tools to do this trivially.
> 
> Why would you need to specify anything?
> 
> Jason

Hi Jason. Sorry for the late response.

WQE buffer of hns HW actually consists of 3 regions: SQ WQE, RQ WQE and
ext SGE. Userspace and kernel driver both computes buffer size and start
offset of these 3 regions based on the page shift. Kernel needs to obtains
the page shift from userspace to ensure the buffer size and start offset
are the same between kernel and userspace and avoid invalid memory access.

The "tools of umem" you said refers to ib_umem_find_best_pgsz() I assume.
This API cannot ensure returning the same page size as userspace, and
kernel cannot determine the start offset of the 3 regions in userspace in
this case.

Junxian

