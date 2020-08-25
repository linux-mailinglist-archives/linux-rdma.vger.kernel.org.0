Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9692519B9
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 15:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgHYNde (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 09:33:34 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:28238 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgHYNdX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 09:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598362402; x=1629898402;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gy5wyA2tgkYMsHybjeuvixVAFLIykprABtY7NycjTms=;
  b=b0OJ77EhteMuCL8643d63PvkrmlDsXMvteG0L3JvuKmXd2LGaFXbs9L3
   butfhs/R4S/J5kg8v8ZH0RMQPSaTOqsOFvB+bzV37WRer3zGZkS/NhVur
   z2m5FRDSnCEdVokDiALe43J46F7TgxZKSzaCdJfUYl0Ql37jN/rnxoijk
   s=;
X-IronPort-AV: E=Sophos;i="5.76,352,1592870400"; 
   d="scan'208";a="49791567"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 25 Aug 2020 13:33:18 +0000
Received: from EX13D19EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 76E42A2128;
        Tue, 25 Aug 2020 13:33:16 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.40) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 25 Aug 2020 13:33:02 +0000
Subject: Re: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD
 deallocate
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
References: <20200824103247.1088464-1-leon@kernel.org>
 <20200824103247.1088464-2-leon@kernel.org>
 <10111f1b-ea06-dce5-a8be-d18e70962547@amazon.com>
 <20200825115246.GP1152540@nvidia.com>
 <110cc351-f8f1-8f88-3912-c4dae711b393@amazon.com>
 <20200825130736.GQ1152540@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <74f893e8-694a-17f0-dc49-05061a214558@amazon.com>
Date:   Tue, 25 Aug 2020 16:32:57 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825130736.GQ1152540@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.40]
X-ClientProxiedBy: EX13D07UWA001.ant.amazon.com (10.43.160.145) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 25/08/2020 16:07, Jason Gunthorpe wrote:
> On Tue, Aug 25, 2020 at 03:12:07PM +0300, Gal Pressman wrote:
>> On 25/08/2020 14:52, Jason Gunthorpe wrote:
>>> On Tue, Aug 25, 2020 at 11:13:25AM +0300, Gal Pressman wrote:
>>>> On 24/08/2020 13:32, Leon Romanovsky wrote:
>>>>> diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
>>>>> index 1889dd172a25..8547f9d543df 100644
>>>>> +++ b/drivers/infiniband/hw/efa/efa.h
>>>>> @@ -134,7 +134,7 @@ int efa_query_gid(struct ib_device *ibdev, u8 port, int index,
>>>>>  int efa_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
>>>>>  		   u16 *pkey);
>>>>>  int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
>>>>> -void efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
>>>>> +int efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
>>>>>  int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
>>>>>  struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
>>>>>  			    struct ib_qp_init_attr *init_attr,
>>>>> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
>>>>> index 3f7f19b9f463..660a69943e02 100644
>>>>> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
>>>>> @@ -383,13 +383,14 @@ int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
>>>>>  	return err;
>>>>>  }
>>>>>
>>>>> -void efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
>>>>> +int efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
>>>>>  {
>>>>>  	struct efa_dev *dev = to_edev(ibpd->device);
>>>>>  	struct efa_pd *pd = to_epd(ibpd);
>>>>>
>>>>>  	ibdev_dbg(&dev->ibdev, "Dealloc pd[%d]\n", pd->pdn);
>>>>>  	efa_pd_dealloc(dev, pd->pdn);
>>>>> +	return 0;
>>>>>  }
>>>>
>>>> Nice change, thanks Leon.
>>>> At least for EFA, I prefer to return the return value of the destroy command
>>>> instead of silently ignoring it (same for the other patches).
>>>
>>> Drivers can't fail the destroy unless a future destroy will succeed.
>>> it breaks everything to do that.
>>
>> What does it break?
> 
> For uverbs it will go into an infinite loop in
> uverbs_destroy_ufile_hw() if destroy doesn't eventually succeed.

The code breaks the loop in such cases, why infinite loop?

> For kernel it will trigger WARN_ON's and then a permanent memory leak.
> 
>> I agree that drivers shouldn't fail destroy commands, but you know.. bugs/errors
>> happen (especially when dealing with hardware), and we have a way to propagate
>> them, why do it for only some of the drivers?
> 
> There is no way to propogate them.
> 
> All destroy must eventually succeed.

There is no way to propagate them on process cleanup, but the destroy verbs have
a return code all the way back to libibverbs, which we can use for error
propagation. The cleanup flow can either ignore the return value, or we can add
another parameter that explicitly means the call shouldn't fail and all
allocated memory/state should be freed.

>>> If the chip fails a destroy when it should not then it has failed and
>>> should be disabled at PCI and reset, continuing to free anyhow.
>>
>> How do we reset the device when there are active apps using it?
> 
> The zap stuff revokes the BAR mmaping, it triggerst device fatal to
> userspace and that is mostly it for userspace..

Interesting, is there a reference driver that does that today?
