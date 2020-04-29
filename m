Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C8E1BE391
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2020 18:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgD2QRe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Apr 2020 12:17:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:10695 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD2QRe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Apr 2020 12:17:34 -0400
IronPort-SDR: q78/y7tQULKu38g/XvH1F+KMdubLRG+lcXw1aeZp8QhnvPHhbSbt8DK1hxVxrOjEnwq05OVJBu
 HCFpPMoXsfyw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 09:17:33 -0700
IronPort-SDR: v/zghgCruTKQN9QnAf5uDddXz2q7cC/sb9V5ojn4Y0q+B0FhlT6MIAGEIT9Rht++4spHqOls8R
 fEVqdYmx6xwQ==
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="246894211"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.206.199]) ([10.254.206.199])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 09:17:29 -0700
Subject: Re: [PATCH for-next] RDMA/core: Assign the name of device when
 allocating ib_device
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        Weihang Li <liweihang@huawei.com>,
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
 <9a875620-3f11-22ee-b908-59c8e49e3b24@intel.com>
 <20200429135015.GA26002@ziepe.ca>
 <5f5e104c-00fd-d08d-f2b2-f62f5f4950ff@intel.com>
 <20200429145735.GB26002@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <cfacf892-ce28-7953-5b3d-f64f5a21bee6@intel.com>
Date:   Wed, 29 Apr 2020 12:17:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429145735.GB26002@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/29/2020 10:57 AM, Jason Gunthorpe wrote:
> On Wed, Apr 29, 2020 at 10:33:19AM -0400, Dennis Dalessandro wrote:
>>>> The issue is hfi1 calls into rvt_alloc_device() which then calls
>>>> _ib_alloc_device(). We don't have the name set at that point. So the obvious
>>>> thing to do is move the rvt_set_ibdev_name(). However there is a catch.
>>>>
>>>> The name gets set after allocating the device and the device table because
>>>> we get the unit number as part of the xa_alloc_irq(hfi1_dev_table) call
>>>> which needs the pointer to the devdata.
>>>>
>>>> One solution would be to pass in the pointer for the driver's dev table and
>>>> let rvt_alloc_device() do the xa_alloc_irq().
>>>
>>> Just do:
>>>
>>> 	ret = xa_alloc_irq(&hfi1_dev_table, &unit, NULL, xa_limit_32b,
>>> 			GFP_KERNEL);
>>>           if (ret)
>>>                   return ERR_PTR(ret);
>>>
>>> 	dd = (struct hfi1_devdata *)rvt_alloc_device(sizeof(*dd) + extra,
>>> 						     nports, unit);
>>> 	if (!dd) {
>>> 		xa_erase(&hfi1_dev_table, unit);
>>> 		return ERR_PTR(-ENOMEM);
>>> 	}
>>> 	xa_store(&hfi1_dev_table, unit, dd, GFP_KERNEL);
>>
>> That works too.
> 
> I don't understand why this xarray exists anyhow? Why can't the core
> code assign the name with its internal algorithm?
> 
> There are several places that iterate over the xarray, but that
> doesn't need a unit #, could be a linked list or use the core device
> list.
> 
> The only actual lookup in hfi1_reset_device() looks pointless, the
> caller already has the dd??

That's a fair point, the caller has the dev pointer which it uses to 
find the dd. I'll take a look at getting rid of it.

-Denny



