Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E50F1BB65F
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 08:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgD1GRz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 28 Apr 2020 02:17:55 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2493 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726258AbgD1GRz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Apr 2020 02:17:55 -0400
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 9F2D04D6E53A66AB6C2B;
        Tue, 28 Apr 2020 14:17:52 +0800 (CST)
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.242]) by
 DGGEML401-HUB.china.huawei.com ([fe80::89ed:853e:30a9:2a79%31]) with mapi id
 14.03.0487.000; Tue, 28 Apr 2020 14:17:37 +0800
From:   liweihang <liweihang@huawei.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
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
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
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
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
Subject: Re: [PATCH for-next] RDMA/core: Assign the name of device when
 allocating ib_device
Thread-Topic: [PATCH for-next] RDMA/core: Assign the name of device when
 allocating ib_device
Thread-Index: AQHWG62Z7/BNGudzR0CivwFowafwZQ==
Date:   Tue, 28 Apr 2020 06:17:37 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A02329944@DGGEML522-MBX.china.huawei.com>
References: <1587893517-11824-1-git-send-email-liweihang@huawei.com>
 <9DD61F30A802C4429A01CA4200E302A7DCD54BBA@fmsmsx124.amr.corp.intel.com>
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

On 2020/4/28 1:56, Saleem, Shiraz wrote:
>> Subject: [PATCH for-next] RDMA/core: Assign the name of device when allocating
>> ib_device
>>
>> If the name of a device is assigned during ib_register_device(), some drivers have
>> to use dev_*() for printing before register device. Bring
>> assign_name() into ib_alloc_device(), so that drivers can use ibdev_*() anywhere.
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
> 
> I think you ll need to update siw driver similarly.
> 
> rvt_register_device should be adapted to use the revised device registration API.
> hfi1/qib also need some rework.
> rvt_alloc_device needs to be adapted for the new one-shot 
> name + device allocation scheme.
> Hoping we can just use move the name setting from rvt_set_ibdev_name
> 

Hi Shiraz,

Sorry for missing hfi1/qib, I will try to modify as your comments.

> A few more comments below.
>> [...]
> 
>>  /**
>>   * _ib_alloc_device - allocate an IB device struct
>>   * @size:size of structure to allocate
>> + * @name: unique string device name. This may include a '%' which will
>> + * cause a unique index to be added to the passed device name.
>>   *
>>   * Low-level drivers should use ib_alloc_device() to allocate &struct
>>   * ib_device.  @size is the size of the structure to be allocated, @@ -567,7 +603,7
>> @@ static void rdma_init_coredev(struct ib_core_device *coredev,
>>   * ib_dealloc_device() must be used to free structures allocated with
>>   * ib_alloc_device().
>>   */
>> -struct ib_device *_ib_alloc_device(size_t size)
>> +struct ib_device *_ib_alloc_device(size_t size, const char *name)
>>  {
>>  	struct ib_device *device;
>>
>> @@ -586,6 +622,11 @@ struct ib_device *_ib_alloc_device(size_t size)
>>  	device->groups[0] = &ib_dev_attr_group;
>>  	rdma_init_coredev(&device->coredev, device, &init_net);
>>
>> +	if (assign_name(device, name)) {
>> +		kfree(device);
> Don't you need to do a rdma_restrack_clean here?
> 

Yes, I think so. Thanks for your reminder.

> 
>> +		return NULL;
>> +	}
>> +
>>  	INIT_LIST_HEAD(&device->event_handler_list);
>>  	spin_lock_init(&device->qp_open_list_lock);
>>  	init_rwsem(&device->event_handler_rwsem);
>> @@ -1132,40 +1173,6 @@ static __net_init int rdma_dev_init_net(struct net *net)
>>  	return ret;
>>  }
>>
> 
> [...]
> 
>> diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
>> b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
>> index 1b6fb13..ccb0d70 100644
>> --- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
>> +++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
>> @@ -2692,7 +2692,7 @@ static struct i40iw_ib_device
>> *i40iw_init_rdma_device(struct i40iw_device *iwdev
>>  	struct net_device *netdev = iwdev->netdev;
>>  	struct pci_dev *pcidev = (struct pci_dev *)iwdev->hw.dev_context;
>>
>> -	iwibdev = ib_alloc_device(i40iw_ib_device, ibdev);
>> +	iwibdev = ib_alloc_device(i40iw_ib_device, ibdev, "i40iw%d");
>>  	if (!iwibdev) {
>>  		i40iw_pr_err("iwdev == NULL\n");
>>  		return NULL;
>> @@ -2780,7 +2780,7 @@ int i40iw_register_rdma_device(struct i40iw_device
>> *iwdev)
>>  	if (ret)
>>  		goto error;
>>
>> -	ret = ib_register_device(&iwibdev->ibdev, "i40iw%d");
>> +	ret = ib_register_device(&iwibdev->ibdev);
>>  	if (ret)
>>  		goto error;
>>
> 
> i40iw looks ok except for the missing underscore which I think was brought up already in another provider.
> 
> Thanks for this work!
> 
> Shiraz
> 

OK, will add it.

Thanks
Weihang

> 

