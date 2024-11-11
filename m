Return-Path: <linux-rdma+bounces-5918-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7589C39FC
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Nov 2024 09:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC7328244C
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Nov 2024 08:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B037916F8E9;
	Mon, 11 Nov 2024 08:47:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6EE16E863;
	Mon, 11 Nov 2024 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731314839; cv=none; b=mBKeCx7hIRDMPYz0oQ2HjrQCk4p/HwNg7jrhy01GWZxYVipVoeuD/fmCRkpr7KQKCGO+Fd0rN+pBn39KpdonbBjHDlWHLW76uhYVZTKy2TwG0Nt5zv0xIdWuQcGAxl7/GeTsnW3G9LisXateRQ4Nfi/UG2T6RyU8fW1C0GgjG9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731314839; c=relaxed/simple;
	bh=v6yTDjLk1dp12i4TOQt6zwiAuZEOaKsPfnbGYw/afOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GmIqRyYbeDKT5n73lwz/15026UdDVqh9irya29qheQOh9FPM5mJm604GMdllzQo+ihRNQ8+noc0kqbZ+SXJjOCOgKBN6hhV2vDch1Z5iaeHz4i3odHMDVFq4tFKjcosaMuOs4fVBB5MpDYBTV9SjEK6ycLb+Qnp8UefaRBof81g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xn36T18yQz20t2P;
	Mon, 11 Nov 2024 16:45:53 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 69245180043;
	Mon, 11 Nov 2024 16:47:05 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Nov 2024 16:47:04 +0800
Message-ID: <e8230a57-4614-a2df-12fe-80e764d4df27@hisilicon.com>
Date: Mon, 11 Nov 2024 16:47:04 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v2 for-next] RDMA/hns: Fix different dgids mapping to the
 same dip_idx
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <tangchengchang@huawei.com>
References: <20241107061148.2010241-1-huangjunxian6@hisilicon.com>
 <20241110142836.GB50588@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20241110142836.GB50588@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/11/10 22:28, Leon Romanovsky wrote:
> On Thu, Nov 07, 2024 at 02:11:48PM +0800, Junxian Huang wrote:
>> From: Feng Fang <fangfeng4@huawei.com>
>>
>> DIP algorithm requires a one-to-one mapping between dgid and dip_idx.
>> Currently a queue 'spare_idx' is used to store QPN of QPs that use
>> DIP algorithm. For a new dgid, use a QPN from spare_idx as dip_idx.
>> This method lacks a mechanism for deduplicating QPN, which may result
>> in different dgids sharing the same dip_idx and break the one-to-one
>> mapping requirement.
>>
>> This patch replaces spare_idx with xarray and introduces a refcnt of
>> a dip_idx to indicate the number of QPs that using this dip_idx.
>>
>> The state machine for dip_idx management is implemented as:
>>
>> * The entry at an index in xarray is empty -- This indicates that the
>>   corresponding dip_idx hasn't been created.
>>
>> * The entry at an index in xarray is not empty but with 0 refcnt --
>>   This indicates that the corresponding dip_idx has been created but
>>   not used as dip_idx yet.
>>
>> * The entry at an index in xarray is not empty and with non-0 refcnt --
>>   This indicates that the corresponding dip_idx is being used by refcnt
>>   number of DIP QPs.
>>
>> Fixes: eb653eda1e91 ("RDMA/hns: Bugfix for incorrect association between dip_idx and dgid")
>> Fixes: f91696f2f053 ("RDMA/hns: Support congestion control type selection according to the FW")
>> Signed-off-by: Feng Fang <fangfeng4@huawei.com>
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> ---
>> v1 -> v2:
>> * Use xarray instead of bitmaps as Leon suggested.
>> * v1: https://lore.kernel.org/all/20240906093444.3571619-10-huangjunxian6@hisilicon.com/
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_device.h | 11 +--
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 96 +++++++++++++++------
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  2 +-
>>  drivers/infiniband/hw/hns/hns_roce_main.c   |  2 -
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  7 +-
>>  5 files changed, 74 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index 9b51d5a1533f..560a1d9de408 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -489,12 +489,6 @@ struct hns_roce_bank {
>>  	u32 next; /* Next ID to allocate. */
>>  };
>>
>> -struct hns_roce_idx_table {
>> -	u32 *spare_idx;
>> -	u32 head;
>> -	u32 tail;
>> -};
>> -
>>  struct hns_roce_qp_table {
>>  	struct hns_roce_hem_table	qp_table;
>>  	struct hns_roce_hem_table	irrl_table;
>> @@ -503,7 +497,7 @@ struct hns_roce_qp_table {
>>  	struct mutex			scc_mutex;
>>  	struct hns_roce_bank bank[HNS_ROCE_QP_BANK_NUM];
>>  	struct mutex bank_mutex;
>> -	struct hns_roce_idx_table	idx_table;
>> +	struct xarray			dip_xa;
> 
> I don't see xa_destroy() for this xarray, why?
> 

Will add in v3, thanks.

Junxian

> Thanks

