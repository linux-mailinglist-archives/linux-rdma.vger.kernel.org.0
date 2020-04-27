Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45471BABC1
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 19:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgD0Rz7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 27 Apr 2020 13:55:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:32020 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgD0Rz7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 13:55:59 -0400
IronPort-SDR: 27XOX6Ivkic6+CZFoFWEZNkk9tn6qsjquaOXfx+YLEThcOJ732S3Wv3bEcecKldaIh6eTrc9JE
 1r7eW7GNiEUw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 10:55:58 -0700
IronPort-SDR: QviwsWAbwYvQFI3SagSK/67q46NtgVQqn/0LFCYtuaPDqeR5dLqTIOz9qRaWTYjGyXYx4CtoBE
 Ff14NDCfdodQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="302442354"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Apr 2020 10:55:58 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 27 Apr 2020 10:55:58 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.70]) by
 fmsmsx115.amr.corp.intel.com ([169.254.4.151]) with mapi id 14.03.0439.000;
 Mon, 27 Apr 2020 10:55:57 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Weihang Li <liweihang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
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
Subject: RE: [PATCH for-next] RDMA/core: Assign the name of device when
 allocating ib_device
Thread-Topic: [PATCH for-next] RDMA/core: Assign the name of device when
 allocating ib_device
Thread-Index: AQHWG62U96XubdNs0EWxvwN80Ryro6iNM0dw
Date:   Mon, 27 Apr 2020 17:55:57 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7DCD54BBA@fmsmsx124.amr.corp.intel.com>
References: <1587893517-11824-1-git-send-email-liweihang@huawei.com>
In-Reply-To: <1587893517-11824-1-git-send-email-liweihang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH for-next] RDMA/core: Assign the name of device when allocating
> ib_device
> 
> If the name of a device is assigned during ib_register_device(), some drivers have
> to use dev_*() for printing before register device. Bring
> assign_name() into ib_alloc_device(), so that drivers can use ibdev_*() anywhere.
> 
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/core/device.c               | 85 +++++++++++++-------------
>  drivers/infiniband/hw/bnxt_re/main.c           |  4 +-
>  drivers/infiniband/hw/cxgb4/device.c           |  2 +-
>  drivers/infiniband/hw/cxgb4/provider.c         |  2 +-
>  drivers/infiniband/hw/efa/efa_main.c           |  4 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c     |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c     |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_main.c      |  2 +-
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c      |  4 +-
>  drivers/infiniband/hw/mlx4/main.c              |  4 +-
>  drivers/infiniband/hw/mlx5/ib_rep.c            |  8 ++-
>  drivers/infiniband/hw/mlx5/main.c              | 18 +++---
>  drivers/infiniband/hw/mthca/mthca_main.c       |  2 +-
>  drivers/infiniband/hw/mthca/mthca_provider.c   |  2 +-
>  drivers/infiniband/hw/ocrdma/ocrdma_main.c     |  4 +-
>  drivers/infiniband/hw/qedr/main.c              |  4 +-
>  drivers/infiniband/hw/usnic/usnic_ib_main.c    |  4 +-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c |  4 +-
>  drivers/infiniband/sw/rxe/rxe.c                |  4 +-
>  drivers/infiniband/sw/rxe/rxe.h                |  2 +-
>  drivers/infiniband/sw/rxe/rxe_net.c            |  4 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c          |  4 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.h          |  2 +-
>  include/rdma/ib_verbs.h                        |  8 +--
>  24 files changed, 95 insertions(+), 86 deletions(-)

I think you ll need to update siw driver similarly.

rvt_register_device should be adapted to use the revised device registration API.
hfi1/qib also need some rework.
rvt_alloc_device needs to be adapted for the new one-shot 
name + device allocation scheme.
Hoping we can just use move the name setting from rvt_set_ibdev_name

A few more comments below.

[...]

>  /**
>   * _ib_alloc_device - allocate an IB device struct
>   * @size:size of structure to allocate
> + * @name: unique string device name. This may include a '%' which will
> + * cause a unique index to be added to the passed device name.
>   *
>   * Low-level drivers should use ib_alloc_device() to allocate &struct
>   * ib_device.  @size is the size of the structure to be allocated, @@ -567,7 +603,7
> @@ static void rdma_init_coredev(struct ib_core_device *coredev,
>   * ib_dealloc_device() must be used to free structures allocated with
>   * ib_alloc_device().
>   */
> -struct ib_device *_ib_alloc_device(size_t size)
> +struct ib_device *_ib_alloc_device(size_t size, const char *name)
>  {
>  	struct ib_device *device;
> 
> @@ -586,6 +622,11 @@ struct ib_device *_ib_alloc_device(size_t size)
>  	device->groups[0] = &ib_dev_attr_group;
>  	rdma_init_coredev(&device->coredev, device, &init_net);
> 
> +	if (assign_name(device, name)) {
> +		kfree(device);
Don't you need to do a rdma_restrack_clean here?


> +		return NULL;
> +	}
> +
>  	INIT_LIST_HEAD(&device->event_handler_list);
>  	spin_lock_init(&device->qp_open_list_lock);
>  	init_rwsem(&device->event_handler_rwsem);
> @@ -1132,40 +1173,6 @@ static __net_init int rdma_dev_init_net(struct net *net)
>  	return ret;
>  }
> 

[...]

> diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> index 1b6fb13..ccb0d70 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> @@ -2692,7 +2692,7 @@ static struct i40iw_ib_device
> *i40iw_init_rdma_device(struct i40iw_device *iwdev
>  	struct net_device *netdev = iwdev->netdev;
>  	struct pci_dev *pcidev = (struct pci_dev *)iwdev->hw.dev_context;
> 
> -	iwibdev = ib_alloc_device(i40iw_ib_device, ibdev);
> +	iwibdev = ib_alloc_device(i40iw_ib_device, ibdev, "i40iw%d");
>  	if (!iwibdev) {
>  		i40iw_pr_err("iwdev == NULL\n");
>  		return NULL;
> @@ -2780,7 +2780,7 @@ int i40iw_register_rdma_device(struct i40iw_device
> *iwdev)
>  	if (ret)
>  		goto error;
> 
> -	ret = ib_register_device(&iwibdev->ibdev, "i40iw%d");
> +	ret = ib_register_device(&iwibdev->ibdev);
>  	if (ret)
>  		goto error;
> 

i40iw looks ok except for the missing underscore which I think was brought up already in another provider.

Thanks for this work!

Shiraz

