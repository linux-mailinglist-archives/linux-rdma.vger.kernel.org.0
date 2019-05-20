Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B59BC24112
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 21:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfETTWL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 15:22:11 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:20087 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfETTWL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 May 2019 15:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1558380128; x=1589916128;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=fk4FOWnXH6m3S2a914xhgJurYfPfoBqeVQsxNwODOK0=;
  b=t3kCk+v1Rc7Bh5gIdLu350vVkI4a+lr/UcwH0E27c4dS6H3F/srFMJ4J
   +r2P7u85XlO2x7Yi6ugHnOzfaaAR/PoflOCEKtv3UZZRLWVWUt4l27lRY
   Kf5LRFoPdogwOanqPJzWWeQofgKJMU+QJcx6P0y54iAlcTlMeZ7tE5p21
   E=;
X-IronPort-AV: E=Sophos;i="5.60,492,1549929600"; 
   d="scan'208";a="733839260"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 May 2019 19:22:06 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x4KJM2sK072807
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 20 May 2019 19:22:05 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 20 May 2019 19:22:05 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.34) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 20 May 2019 19:22:00 +0000
Subject: Re: [PATCH rdma-next 04/15] RDMA/efa: Remove check that prevents
 destroy of resources in error flows
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
References: <20190520065433.8734-1-leon@kernel.org>
 <20190520065433.8734-5-leon@kernel.org>
 <a3358e40-9be4-0a7c-dab5-96573b646ded@amazon.com>
 <20190520131000.GJ4573@mtr-leonro.mtl.com>
 <161ad83d-cb50-d02a-8511-938b2b3b7156@amazon.com>
 <20190520145105.GQ4573@mtr-leonro.mtl.com>
 <807ef5dc-d4c7-9c4c-bad4-a437f3104237@amazon.com>
 <20190520183028.GS4573@mtr-leonro.mtl.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <d6355ff2-f9e2-8297-3869-386d54c5cbb3@amazon.com>
Date:   Mon, 20 May 2019 22:21:55 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520183028.GS4573@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D18UWA001.ant.amazon.com (10.43.160.11) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 20/05/2019 21:30, Leon Romanovsky wrote:
> On Mon, May 20, 2019 at 07:54:57PM +0300, Gal Pressman wrote:
>> On 20/05/2019 17:51, Leon Romanovsky wrote:
>>> On Mon, May 20, 2019 at 05:24:43PM +0300, Gal Pressman wrote:
>>>> On 20/05/2019 16:10, Leon Romanovsky wrote:
>>>>> On Mon, May 20, 2019 at 03:39:26PM +0300, Gal Pressman wrote:
>>>>>> On 20/05/2019 9:54, Leon Romanovsky wrote:
>>>>>>> From: Leon Romanovsky <leonro@mellanox.com>
>>>>>>>
>>>>>>> There are two possible execution contexts of destroy flows in EFA.
>>>>>>> One is normal flow where user explicitly asked for object release
>>>>>>> and another error unwinding.
>>>>>>>
>>>>>>> In normal scenario, RDMA/core will ensure that udata is supplied
>>>>>>> according to KABI contract, for now it means no udata at all.
>>>>>>>
>>>>>>> In unwind flow, the EFA driver will receive uncleared udata from
>>>>>>> numerous *_create_*() calls, but won't release those resources
>>>>>>> due to extra checks.
>>>>>>
>>>>>> Thanks for the fix Leon, a few questions:
>>>>>>
>>>>>> Some of the unwind flows pass NULL udata and others an uncleared udata (is it
>>>>>> really uncleared or is it actually the create udata?), what are we considering
>>>>>> as the expected behavior? Isn't passing an uncleared udata the bug here?
>>>>>
>>>>> It is a matter of unwind sequence, if IB/core did something after
>>>>> driver created some object, it will need to call to destroy of this
>>>>> object too. So I don't think that it is the bug.
>>>>>
>>>>> And yes, it is not applicable for all flows, the one which caused me to
>>>>> write this patch is failure in ib_uverbs_reg_mr(), which will call to
>>>>> ib_dereg_mr_user(mr, &attrs->driver_udata);
>>>>>
>>>>> and attrs->driver_udata is valid there.
>>>>
>>>> Right, but is it really valid? The udata in/out buffers in that case are
>>>> actually the create buffers and the driver has no way of telling. I think a
>>>> better approach is to clear the udata before calling the driver as done in
>>>> normal destroy flow.
>>>>
>>>> Also, create_qp flow for example calls ib_destroy_qp on failure which passes
>>>> NULL udata, the different flows are not consistent and I don't see a reason why
>>>> they shouldn't be?
>>>
>>> Sorry, but I didn't look deeply enough on QPs and MRs yet to make clear
>>> cut, but from what I have seen till now, the implementation looks like
>>> a disaster.
>>
>> Is it possible that in the future the destroy flows will pass a valid kabi udata
>> from rdma-core? If so, these removed checks are needed.
> 
> In such case, kernel modules will be updated. We are not supporting out-of-tree modules.
> 
>> Why not clear the udata struct before calling the driver?
> 
> What exactly are you trying to solve?

IMHO, This patch just hides the real issue - the udata passed to the destroy
flows is meaningless. Similarly for the reason we fixed the standard
(non-unwind) destroy flows instead of removing these checks that discovered the
bug [1].
It points to buffers which are not relevant to the actual destroy flow, same
goes for the in/out lengths.

In standard destroy flow the udata is cleared before calling the driver. This
way the driver knows it is called in user flow and the udata doesn't contain
garbage.

The checks you removed are not the problem here, but the content of the udata
struct.

[1] f89adedaf3fe ("RDMA/uverbs: Initialize udata struct on destroy flows")

> 
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>> Also, if passing NULL udata is expected (why?) we have a bigger problem here as
>>>>>> existing code will cause NULL dereference.
>>>>>
>>>>> Not anymore, the destroy paths are not relying on udata now.
>>>>
>>>> This patch solves it, I'm thinking we need another patch for for-rc to prevent
>>>> panic.
>>>
>>> I don't think that it is worth of hassle. EFA just entered kernel,
>>
>> That doesn't mean bugs shouldn't be fixed.
> 
> Go for it.
> 
>>
>>> rdma-core is not merged yet
>>
>> Userspace library is independent of the kernel, once the provider is merged it
>> can be used with any kernel with EFA.
> 
> I was under impression that Amazon controls OS stack, so unclear to me
> how I can install bad kernel version on AWS hypervisor.

Not at all, you can do whatever you want on your own instance, including
building and running your own kernel.

> 
>>
>>> and anyway no one can use EFA adapter in his home.
>>
>> That's not true, open up an AWS account and spin up an EFA enabled instance, all
>> from your laptop at home. It's that simple :).
> 
> Can I get two adapters to install in my server not in AWS?

EFA is initially offered in the Amazon EC2 environment only.

> 
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>>>>>>> ---
>>>>>>>  drivers/infiniband/hw/efa/efa_verbs.c | 24 ------------------------
>>>>>>>  1 file changed, 24 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
>>>>>>> index 6d6886c9009f..4999a74cee24 100644
>>>>>>> --- a/drivers/infiniband/hw/efa/efa_verbs.c
>>>>>>> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
>>>>>>> @@ -436,12 +436,6 @@ void efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
>>>>>>>  	struct efa_dev *dev = to_edev(ibpd->device);
>>>>>>>  	struct efa_pd *pd = to_epd(ibpd);
>>>>>>>
>>>>>>> -	if (udata->inlen &&
>>>>>>> -	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
>>>>>>> -		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
>>>>>>> -		return;
>>>>>>> -	}
>>>>>>> -
>>>>>>>  	ibdev_dbg(&dev->ibdev, "Dealloc pd[%d]\n", pd->pdn);
>>>>>>>  	efa_pd_dealloc(dev, pd->pdn);
>>>>>>>  }
>>>>>>> @@ -459,12 +453,6 @@ int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>>>>>>>  	struct efa_qp *qp = to_eqp(ibqp);
>>>>>>>  	int err;
>>>>>>>
>>>>>>> -	if (udata->inlen &&
>>>>>>> -	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
>>>>>>> -		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
>>>>>>> -		return -EINVAL;
>>>>>>> -	}
>>>>>>> -
>>>>>>>  	ibdev_dbg(&dev->ibdev, "Destroy qp[%u]\n", ibqp->qp_num);
>>>>>>>  	err = efa_destroy_qp_handle(dev, qp->qp_handle);
>>>>>>>  	if (err)
>>>>>>> @@ -865,12 +853,6 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
>>>>>>>  	struct efa_cq *cq = to_ecq(ibcq);
>>>>>>>  	int err;
>>>>>>>
>>>>>>> -	if (udata->inlen &&
>>>>>>> -	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
>>>>>>> -		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
>>>>>>> -		return -EINVAL;
>>>>>>> -	}
>>>>>>> -
>>>>>>>  	ibdev_dbg(&dev->ibdev,
>>>>>>>  		  "Destroy cq[%d] virt[0x%p] freed: size[%lu], dma[%pad]\n",
>>>>>>>  		  cq->cq_idx, cq->cpu_addr, cq->size, &cq->dma_addr);
>>>>>>> @@ -1556,12 +1538,6 @@ int efa_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>>>>>>>  	struct efa_mr *mr = to_emr(ibmr);
>>>>>>>  	int err;
>>>>>>>
>>>>>>> -	if (udata->inlen &&
>>>>>>> -	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
>>>>>>> -		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
>>>>>>> -		return -EINVAL;
>>>>>>> -	}
>>>>>>> -
>>>>>>>  	ibdev_dbg(&dev->ibdev, "Deregister mr[%d]\n", ibmr->lkey);
>>>>>>>
>>>>>>>  	if (mr->umem) {
>>>>>>> --
>>>>>>> 2.20.1
>>>>>>>
