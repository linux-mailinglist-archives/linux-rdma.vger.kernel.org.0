Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84A81B9F46
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 11:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgD0JDB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 27 Apr 2020 05:03:01 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2119 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbgD0JDB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 05:03:01 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 918D6FEECE0A14744C3F;
        Mon, 27 Apr 2020 17:02:58 +0800 (CST)
Received: from DGGEML423-HUB.china.huawei.com (10.1.199.40) by
 dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 27 Apr 2020 17:02:57 +0800
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.242]) by
 dggeml423-hub.china.huawei.com ([10.1.199.40]) with mapi id 14.03.0487.000;
 Mon, 27 Apr 2020 17:02:47 +0800
From:   liweihang <liweihang@huawei.com>
To:     Gal Pressman <galpress@amazon.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "selvin.xavier@broadcom.com" <selvin.xavier@broadcom.com>,
        "devesh.sharma@broadcom.com" <devesh.sharma@broadcom.com>,
        "somnath.kotur@broadcom.com" <somnath.kotur@broadcom.com>,
        "sriharsha.basavapatna@broadcom.com" 
        <sriharsha.basavapatna@broadcom.com>,
        "bharat@chelsio.com" <bharat@chelsio.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "faisal.latif@intel.com" <faisal.latif@intel.com>,
        "shiraz.saleem@intel.com" <shiraz.saleem@intel.com>,
        "yishaih@mellanox.com" <yishaih@mellanox.com>,
        "mkalderon@marvell.com" <mkalderon@marvell.com>,
        "aelior@marvell.com" <aelior@marvell.com>,
        "benve@cisco.com" <benve@cisco.com>,
        "neescoba@cisco.com" <neescoba@cisco.com>,
        "pkaustub@cisco.com" <pkaustub@cisco.com>,
        "aditr@vmware.com" <aditr@vmware.com>,
        "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
        "monis@mellanox.com" <monis@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        "parav@mellanox.com" <parav@mellanox.com>,
        "markz@mellanox.com" <markz@mellanox.com>,
        "rd.dunlab@gmail.com" <rd.dunlab@gmail.com>,
        "dennis.dalessandro@intel.com" <dennis.dalessandro@intel.com>
Subject: Re: [PATCH for-next] RDMA/core: Assign the name of device when
 allocating ib_device
Thread-Topic: [PATCH for-next] RDMA/core: Assign the name of device when
 allocating ib_device
Thread-Index: AQHWG62Z7/BNGudzR0CivwFowafwZQ==
Date:   Mon, 27 Apr 2020 09:02:47 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A02326100@DGGEML522-MBX.china.huawei.com>
References: <1587893517-11824-1-git-send-email-liweihang@huawei.com>
 <cf1dc2dd-89e5-2fcc-845f-925fb531adc1@amazon.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.168.149]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/4/27 16:45, Gal Pressman wrote:
> On 26/04/2020 12:31, Weihang Li wrote:
>> If the name of a device is assigned during ib_register_device(), some
>> drivers have to use dev_*() for printing before register device. Bring
>> assign_name() into ib_alloc_device(), so that drivers can use ibdev_*()
>> anywhere.
>>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
> 
> Reviewed-by: Gal Pressman <galpress@amazon.com>
> 
> [...]
> 
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index 2a8c389..5560d79 100644
>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -6017,7 +6017,7 @@ static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
>>  	struct hns_roce_dev *hr_dev;
>>  	int ret;
>>  
>> -	hr_dev = ib_alloc_device(hns_roce_dev, ib_dev);
>> +	hr_dev = ib_alloc_device(hns_roce_dev, ib_dev, "hns%d");
> 
> This name is missing an underscore.
> As some of the drivers now pass the name in two call sites, it's better to
> define it in one place in order to prevent mistakes like these.
> 

Hi Gal,

Thanks for your reminder :) Will fix it and consider using a macro instead.

Weihang
