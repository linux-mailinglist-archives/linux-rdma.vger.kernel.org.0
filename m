Return-Path: <linux-rdma+bounces-3697-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0E8929AC2
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 04:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35613B20C33
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 02:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133612C9A;
	Mon,  8 Jul 2024 02:28:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E4E8F5A;
	Mon,  8 Jul 2024 02:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720405712; cv=none; b=R6KUA9dg4ClZsHT7i1C84Id11MgagyvrwfHmH9E/i82Gzbxc8ljtQt7uXTlPyuRD8S+FycOt7izP0+QYRlna+gOdlPnDgMYOzvfgsMk4aWCqkxAOQkQ6oAY14U2zHMRERsaOMrRiIUg17PX6MXCDREr/4JACZ3ekNBc/p6I87B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720405712; c=relaxed/simple;
	bh=dQ+UbSZjkxQb58Um+/1r3PkSjYqJnYwo9CDlzn/8SgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k6ZUlJQndh6PZ66u1PNAj6hW150jcTnl8Af2m0Nm7CVgaWAsefNZ9E44WJzb4do+aaumYB/qJmgcbIXYZgjtLrvLBzGmCerr/SGd8ohERjFg0AS8KaVAC0uyrfD3uRya/wzpQsHHDBE5PuUdxiIWJy7rvE3jt0nMNc7cWz9fqm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WHSbc6dk5z1T5VT;
	Mon,  8 Jul 2024 10:23:40 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B65C18010A;
	Mon,  8 Jul 2024 10:28:05 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Jul 2024 10:27:56 +0800
Message-ID: <011375d2-b941-23c0-59c7-67698a8e504c@hisilicon.com>
Date: Mon, 8 Jul 2024 10:27:56 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-rc 1/9] RDMA/hns: Check atomic wr length
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
 <20240705085937.1644229-2-huangjunxian6@hisilicon.com>
 <20240707082433.GD6695@unreal>
Content-Language: en-US
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240707082433.GD6695@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/7/7 16:24, Leon Romanovsky wrote:
> On Fri, Jul 05, 2024 at 04:59:29PM +0800, Junxian Huang wrote:
>> 8 bytes is the only supported length of atomic. Return an error if
>> it is not.
>>
>> Fixes: 384f88185112 ("RDMA/hns: Add atomic support")
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  2 ++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 19 +++++++++++++++----
>>  2 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index ff0b3f68ee3a..05005079258c 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -91,6 +91,8 @@
>>  /* Configure to HW for PAGE_SIZE larger than 4KB */
>>  #define PG_SHIFT_OFFSET				(PAGE_SHIFT - 12)
>>  
>> +#define ATOMIC_WR_LEN				8
>> +
>>  #define HNS_ROCE_IDX_QUE_ENTRY_SZ		4
>>  #define SRQ_DB_REG				0x230
>>  
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index 4287818a737f..a5d746a5cc68 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -164,15 +164,23 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
>>  	hr_reg_clear(fseg, FRMR_BLK_MODE);
>>  }
>>  
>> -static void set_atomic_seg(const struct ib_send_wr *wr,
>> -			   struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
>> -			   unsigned int valid_num_sge)
>> +static int set_atomic_seg(struct hns_roce_dev *hr_dev,
>> +			  const struct ib_send_wr *wr,
>> +			  struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
>> +			  unsigned int valid_num_sge, u32 msg_len)
>>  {
>>  	struct hns_roce_v2_wqe_data_seg *dseg =
>>  		(void *)rc_sq_wqe + sizeof(struct hns_roce_v2_rc_send_wqe);
>>  	struct hns_roce_wqe_atomic_seg *aseg =
>>  		(void *)dseg + sizeof(struct hns_roce_v2_wqe_data_seg);
>>  
>> +	if (msg_len != ATOMIC_WR_LEN) {
>> +		ibdev_err_ratelimited(&hr_dev->ib_dev,
>> +				      "invalid atomic wr len, len = %u.\n",
>> +				      msg_len);
>> +		return -EINVAL;
> 
> 1. Please don't add prints in data-path.
> 2. You most likely need to add this check before calling to set_atomic_seg().
> 3. You shouldn't continue to process the WQE if the length is invalid.
> Need to return from set_rc_wqe() and not continue.
> 4. I wonder if it is right place to put this limitation and can't be
> enforced much earlier.
> 
> Thanks
> 

Thanks. 1 & 3 will be fixed. And for 2 & 4, I don't see any place more appropriate,
so I'll just add this check in set_rc_wqe().

Junxian

