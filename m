Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F346D1BB36E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 03:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgD1B3d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 27 Apr 2020 21:29:33 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:59922 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbgD1B3d (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 21:29:33 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id F3431E0A2AAFBF7216A2;
        Tue, 28 Apr 2020 09:29:29 +0800 (CST)
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.242]) by
 dggeml405-hub.china.huawei.com ([10.3.17.49]) with mapi id 14.03.0487.000;
 Tue, 28 Apr 2020 09:29:19 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "selvin.xavier@broadcom.com" <selvin.xavier@broadcom.com>,
        "devesh.sharma@broadcom.com" <devesh.sharma@broadcom.com>,
        "somnath.kotur@broadcom.com" <somnath.kotur@broadcom.com>,
        "sriharsha.basavapatna@broadcom.com" 
        <sriharsha.basavapatna@broadcom.com>,
        "bharat@chelsio.com" <bharat@chelsio.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
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
Date:   Tue, 28 Apr 2020 01:29:19 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A0232975D@DGGEML522-MBX.china.huawei.com>
References: <1587893517-11824-1-git-send-email-liweihang@huawei.com>
 <20200427114734.GC134660@unreal>
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

On 2020/4/27 19:47, Leon Romanovsky wrote:
> On Sun, Apr 26, 2020 at 05:31:57PM +0800, Weihang Li wrote:
>> If the name of a device is assigned during ib_register_device(), some
>> drivers have to use dev_*() for printing before register device. Bring
>> assign_name() into ib_alloc_device(), so that drivers can use ibdev_*()
>> anywhere.
>>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/core/device.c               | 85 +++++++++++++-------------
>>  drivers/infiniband/hw/bnxt_re/main.c           |  4 +-
>>  drivers/infiniband/hw/cxgb4/device.c           |  2 +-
>>  drivers/infiniband/hw/cxgb4/provider.c         |  2 +-
>>  drivers/infiniband/hw/efa/efa_main.c           |  4 +-
>>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c     |  2 +-
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c     |  2 +-
>>  drivers/infiniband/hw/hns/hns_roce_main.c      |  2 +-
>>  drivers/infiniband/hw/i40iw/i40iw_verbs.c      |  4 +-
>>  drivers/infiniband/hw/mlx4/main.c              |  4 +-
>>  drivers/infiniband/hw/mlx5/ib_rep.c            |  8 ++-
>>  drivers/infiniband/hw/mlx5/main.c              | 18 +++---
>>  drivers/infiniband/hw/mthca/mthca_main.c       |  2 +-
>>  drivers/infiniband/hw/mthca/mthca_provider.c   |  2 +-
>>  drivers/infiniband/hw/ocrdma/ocrdma_main.c     |  4 +-
>>  drivers/infiniband/hw/qedr/main.c              |  4 +-
>>  drivers/infiniband/hw/usnic/usnic_ib_main.c    |  4 +-
>>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c |  4 +-
>>  drivers/infiniband/sw/rxe/rxe.c                |  4 +-
>>  drivers/infiniband/sw/rxe/rxe.h                |  2 +-
>>  drivers/infiniband/sw/rxe/rxe_net.c            |  4 +-
>>  drivers/infiniband/sw/rxe/rxe_verbs.c          |  4 +-
>>  drivers/infiniband/sw/rxe/rxe_verbs.h          |  2 +-
>>  include/rdma/ib_verbs.h                        |  8 +--
>>  24 files changed, 95 insertions(+), 86 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index d0b3d35..30d28da 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -557,9 +557,45 @@ static void rdma_init_coredev(struct ib_core_device *coredev,
>>  	write_pnet(&coredev->rdma_net, net);
>>  }
>>
>> +/*
>> + * Assign the unique string device name and the unique device index. This is
>> + * undone by ib_dealloc_device.
>> + */
>> +static int assign_name(struct ib_device *device, const char *name)
>> +{
>> +	static u32 last_id;
>> +	int ret;
>> +
>> +	down_write(&devices_rwsem);
>> +	/* Assign a unique name to the device */
>> +	if (strchr(name, '%'))
>> +		ret = alloc_name(device, name);
>> +	else
>> +		ret = dev_set_name(&device->dev, name);
>> +	if (ret)
>> +		goto out;
>> +
>> +	if (__ib_device_get_by_name(dev_name(&device->dev))) {
>> +		ret = -ENFILE;
>> +		goto out;
>> +	}
>> +	strlcpy(device->name, dev_name(&device->dev), IB_DEVICE_NAME_MAX);
>> +
>> +	ret = xa_alloc_cyclic(&devices, &device->index, device, xa_limit_31b,
>> +			      &last_id, GFP_KERNEL);
>> +	if (ret > 0)
>> +		ret = 0;
>> +
>> +out:
>> +	up_write(&devices_rwsem);
>> +	return ret;
>> +}
>> +
>>  /**
>>   * _ib_alloc_device - allocate an IB device struct
>>   * @size:size of structure to allocate
>> + * @name: unique string device name. This may include a '%' which will
> 
> It looks like all drivers are setting "%" in their name and "name" can
> be changed to be "prefix".
> 
> Thanks
> 

Thank you for the advice, I will try.

Weihang
