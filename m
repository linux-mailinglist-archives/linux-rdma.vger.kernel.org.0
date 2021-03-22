Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED11343675
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 03:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhCVCBZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sun, 21 Mar 2021 22:01:25 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3912 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhCVCAw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Mar 2021 22:00:52 -0400
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F3d2d5zr2z5gfk;
        Mon, 22 Mar 2021 09:58:49 +0800 (CST)
Received: from dggema704-chm.china.huawei.com (10.3.20.68) by
 DGGEML401-HUB.china.huawei.com (10.3.17.32) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 22 Mar 2021 10:00:46 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema704-chm.china.huawei.com (10.3.20.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 22 Mar 2021 10:00:46 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Mon, 22 Mar 2021 10:00:46 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Fix memory corruption when allocating
 XRCDN
Thread-Topic: [PATCH for-next] RDMA/hns: Fix memory corruption when allocating
 XRCDN
Thread-Index: AQHXHJy+DOVU9nWWokiLWMRKgkKCwQ==
Date:   Mon, 22 Mar 2021 02:00:46 +0000
Message-ID: <dd591a4d80154c4390a07edc6409af7e@huawei.com>
References: <1616143536-24874-1-git-send-email-liweihang@huawei.com>
 <YFXBSyUI/J8uMoxH@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/3/20 17:33, Leon Romanovsky wrote:
> On Fri, Mar 19, 2021 at 04:45:36PM +0800, Weihang Li wrote:
>> It's incorrect to cast the type of pointer to xrcdn from (u32 *) to
>> (unsigned long *), then pass it into hns_roce_bitmap_alloc(), this will
>> lead to a memory corruption.
>>
>> Fixes: 32548870d438 ("RDMA/hns: Add support for XRC on HIP09")
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_pd.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
>> index 3ca51ce..16d6b69 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_pd.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
>> @@ -140,8 +140,14 @@ void hns_roce_cleanup_uar_table(struct hns_roce_dev *hr_dev)
>>  
>>  static int hns_roce_xrcd_alloc(struct hns_roce_dev *hr_dev, u32 *xrcdn)
>>  {
>> -	return hns_roce_bitmap_alloc(&hr_dev->xrcd_bitmap,
>> -				     (unsigned long *)xrcdn);
>> +	unsigned long obj;
>> +	int ret;
>> +
>> +	ret = hns_roce_bitmap_alloc(&hr_dev->xrcd_bitmap, &obj);
>> +
>> +	*xrcdn = (u32)obj;
> 
> NIT, it will be safer if you don't set set xrcdn after hns_roce_bitmap_alloc() failed.
> 
> Thanks
> 
>> +
>> +	return ret;
>>  }
>>  
>>  static void hns_roce_xrcd_free(struct hns_roce_dev *hr_dev,
>> -- 
>> 2.8.1
>>

Thank you, I will fix it.

Weihang
