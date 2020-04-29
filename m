Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999101BDDAC
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2020 15:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgD2NcY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Apr 2020 09:32:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:43130 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbgD2NcX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Apr 2020 09:32:23 -0400
IronPort-SDR: LV7Wwzhrp2AybuJOjhOgXGE7873CF54GqJaWEPu7ETBW0luTSyMu1VJzEySrLR+kzFokfAsqW5
 pTA/C5tSYeiQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 06:32:22 -0700
IronPort-SDR: UQHnAoWJFQLxjxoz/tF3B64Eir6pSbn9uP9pXuNhAXpQJRYPmAbde+XzsUq+nne5AmVzx37x/l
 1OHqjqaIUlmg==
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="246847999"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.206.199]) ([10.254.206.199])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 06:32:18 -0700
Subject: Re: [PATCH for-next] RDMA/core: Assign the name of device when
 allocating ib_device
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     Weihang Li <liweihang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
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
        "rd.dunlab@gmail.com" <rd.dunlab@gmail.com>
References: <1587893517-11824-1-git-send-email-liweihang@huawei.com>
 <9DD61F30A802C4429A01CA4200E302A7DCD54BBA@fmsmsx124.amr.corp.intel.com>
 <20200428000428.GP26002@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <9a875620-3f11-22ee-b908-59c8e49e3b24@intel.com>
Date:   Wed, 29 Apr 2020 09:32:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428000428.GP26002@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/27/2020 8:04 PM, Jason Gunthorpe wrote:
> On Mon, Apr 27, 2020 at 05:55:57PM +0000, Saleem, Shiraz wrote:
>>> Subject: [PATCH for-next] RDMA/core: Assign the name of device when allocating
>>> ib_device
>>>
>>> If the name of a device is assigned during ib_register_device(), some drivers have
>>> to use dev_*() for printing before register device. Bring
>>> assign_name() into ib_alloc_device(), so that drivers can use ibdev_*() anywhere.
>>>
>>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>>   drivers/infiniband/core/device.c               | 85 +++++++++++++-------------
>>>   drivers/infiniband/hw/bnxt_re/main.c           |  4 +-
>>>   drivers/infiniband/hw/cxgb4/device.c           |  2 +-
>>>   drivers/infiniband/hw/cxgb4/provider.c         |  2 +-
>>>   drivers/infiniband/hw/efa/efa_main.c           |  4 +-
>>>   drivers/infiniband/hw/hns/hns_roce_hw_v1.c     |  2 +-
>>>   drivers/infiniband/hw/hns/hns_roce_hw_v2.c     |  2 +-
>>>   drivers/infiniband/hw/hns/hns_roce_main.c      |  2 +-
>>>   drivers/infiniband/hw/i40iw/i40iw_verbs.c      |  4 +-
>>>   drivers/infiniband/hw/mlx4/main.c              |  4 +-
>>>   drivers/infiniband/hw/mlx5/ib_rep.c            |  8 ++-
>>>   drivers/infiniband/hw/mlx5/main.c              | 18 +++---
>>>   drivers/infiniband/hw/mthca/mthca_main.c       |  2 +-
>>>   drivers/infiniband/hw/mthca/mthca_provider.c   |  2 +-
>>>   drivers/infiniband/hw/ocrdma/ocrdma_main.c     |  4 +-
>>>   drivers/infiniband/hw/qedr/main.c              |  4 +-
>>>   drivers/infiniband/hw/usnic/usnic_ib_main.c    |  4 +-
>>>   drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c |  4 +-
>>>   drivers/infiniband/sw/rxe/rxe.c                |  4 +-
>>>   drivers/infiniband/sw/rxe/rxe.h                |  2 +-
>>>   drivers/infiniband/sw/rxe/rxe_net.c            |  4 +-
>>>   drivers/infiniband/sw/rxe/rxe_verbs.c          |  4 +-
>>>   drivers/infiniband/sw/rxe/rxe_verbs.h          |  2 +-
>>>   include/rdma/ib_verbs.h                        |  8 +--
>>>   24 files changed, 95 insertions(+), 86 deletions(-)
>>
>> I think you ll need to update siw driver similarly.
>>
>> rvt_register_device should be adapted to use the revised device registration API.
>> hfi1/qib also need some rework.
> 
> It is necessary to make such a big change? :(
> 
>> rvt_alloc_device needs to be adapted for the new one-shot
>> name + device allocation scheme.
>> Hoping we can just use move the name setting from rvt_set_ibdev_name
> 
> I thought so..
> 

The issue is hfi1 calls into rvt_alloc_device() which then calls 
_ib_alloc_device(). We don't have the name set at that point. So the 
obvious thing to do is move the rvt_set_ibdev_name(). However there is a 
catch.

The name gets set after allocating the device and the device table 
because we get the unit number as part of the 
xa_alloc_irq(hfi1_dev_table) call which needs the pointer to the devdata.

One solution would be to pass in the pointer for the driver's dev table 
and let rvt_alloc_device() do the xa_alloc_irq().

-Denny

