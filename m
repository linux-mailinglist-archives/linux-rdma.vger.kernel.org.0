Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736CE1EB2D3
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2020 02:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgFBA7Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jun 2020 20:59:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbgFBA7Y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 1 Jun 2020 20:59:24 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A46C03EAA86A60DBE163;
        Tue,  2 Jun 2020 08:59:21 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.154) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 2 Jun 2020
 08:59:18 +0800
Subject: Re: [PATCH -next] IB/hfi1: Remove set but not used variable 'priv'
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
References: <20200528075946.123480-1-yuehaibing@huawei.com>
 <MN2PR11MB396654BC46500F828609C6A3868E0@MN2PR11MB3966.namprd11.prod.outlook.com>
 <86634519-3dd8-0c6a-a8d2-19f4b986fd3d@intel.com>
 <20200601135644.GD4872@ziepe.ca>
CC:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Dan Carpenter (dan.carpenter@oracle.com)" <dan.carpenter@oracle.com>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <56063ae0-30a2-6522-2b6a-86b749264e78@huawei.com>
Date:   Tue, 2 Jun 2020 08:59:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200601135644.GD4872@ziepe.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/6/1 21:56, Jason Gunthorpe wrote:
> On Mon, Jun 01, 2020 at 09:45:52AM -0400, Dennis Dalessandro wrote:
>> On 5/28/2020 7:25 AM, Marciniszyn, Mike wrote:
>>>> From: YueHaibing <yuehaibing@huawei.com>
>>>> Sent: Thursday, May 28, 2020 4:00 AM
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>>   drivers/infiniband/hw/hfi1/netdev_rx.c | 11 +++--------
>>>>   1 file changed, 3 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c
>>>> b/drivers/infiniband/hw/hfi1/netdev_rx.c
>>>> index 58af6a454761..bd6546b52159 100644
>>>> +++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
>>>> @@ -371,14 +371,9 @@ int hfi1_netdev_alloc(struct hfi1_devdata *dd)
>>>>
>>>>   void hfi1_netdev_free(struct hfi1_devdata *dd)
>>>>   {
>>>> -struct hfi1_netdev_priv *priv;
>>>> -
>>>> -if (dd->dummy_netdev) {
>>>> -priv = hfi1_netdev_priv(dd->dummy_netdev);
>>>> -dd_dev_info(dd, "hfi1 netdev freed\n");
>>>> -kfree(dd->dummy_netdev);
>>>> -dd->dummy_netdev = NULL;
>>>> -}
>>>> +dd_dev_info(dd, "hfi1 netdev freed\n");
>>>> +kfree(dd->dummy_netdev);
>>>
>>> Dan Carpenter has reported kfree() should be free_netdev()...
>>>
>>> Mike
>>>
>>
>> I'm OK with this patch going in and then adding a separate one to fix the
>> kfree. Or this one can be touched up to include that as well.
> 
> Please resend it with both things fixed

Ok, will do that in v2.
> 
> Jason
> 
> 

