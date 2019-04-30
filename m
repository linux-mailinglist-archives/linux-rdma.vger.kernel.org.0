Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37929F1FF
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 10:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfD3I1w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 04:27:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725769AbfD3I1w (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Apr 2019 04:27:52 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3FEBC7A62C3429FE3CBA;
        Tue, 30 Apr 2019 16:27:50 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.196) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 30 Apr 2019
 16:27:42 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Add support function clear when
 removing module
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     oulijun <oulijun@huawei.com>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1555154941-55510-1-git-send-email-oulijun@huawei.com>
 <20190416121634.GA12981@mtr-leonro.mtl.com>
 <4d3613c7-1c68-9f9b-d185-ab015049e6cf@huawei.com>
 <20190422122209.GD27901@mtr-leonro.mtl.com>
 <add43d02-b3d5-35d9-a74d-8254c1fb472c@huawei.com>
 <20190423152339.GE27901@mtr-leonro.mtl.com>
 <90a91e1f-91fc-bc4e-067c-7bc788c62ab6@huawei.com>
 <20190426143656.GA2278@ziepe.ca> <20190426210520.GA6705@mtr-leonro.mtl.com>
From:   "Liuyixian (Eason)" <liuyixian@huawei.com>
Message-ID: <99195660-be8d-555f-01fc-efd9e680fdf3@huawei.com>
Date:   Tue, 30 Apr 2019 16:27:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20190426210520.GA6705@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/4/27 5:05, Leon Romanovsky wrote:
> On Fri, Apr 26, 2019 at 11:36:56AM -0300, Jason Gunthorpe wrote:
>> On Fri, Apr 26, 2019 at 06:12:11PM +0800, Liuyixian (Eason) wrote:
>>
>>>     However, I have talked with our chip team about function clear
>>>     functionality. We think it is necessary to inform the chip to
>>>     perform the outstanding task and some cleanup work and restore
>>>     hardware resources in time when rmmod ko. Otherwise, it is
>>>     dangerous to reuse the hardware as it can not guarantee those
>>>     work can be done well without the notification from our driver.
>>
>> If it is dangerous to reuse the hardware then you have to do this
>> cleanup on device startup, not on device removal.
> 
> Right, I can think about gazillion ways to brick such HW.
> The simplest way will be to call SysRq during RDMA traffic
> and no cleanup function will be called in such case.
> 
> Thanks

Hi Jason and Leon,

	As hip08 is a fake pcie device, we could not disassociate and stop the hardware access
	through the chain break mechanism as a real pcie device. Alternatively, function clear
	is used as a notification to the hardware to stop accessing and ensure to not read or
	write DDR later. That is, the role of function clear to hip08 is similar as the chain
	break to pcie device.

	Without function clear, following problems would be happened:
	1) With current hardware design, the hardware request to the bus may not be able to wait
	   for respone, as the rquest (read or write) may arrive to processor after the hardware
	   has already returned to the destroy verbs from application, in this case, the access
	   error may happen.
	2) The traffic buffer applied from schedule module could not return back, it will affect
	   the traffic of other functions.

	Thus, we think it is more reasonable to do function clear on device removal.

Thanks.

