Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C84A175465
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 08:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCBHWr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 2 Mar 2020 02:22:47 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:44150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbgCBHWr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Mar 2020 02:22:47 -0500
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 63FB6BB59A0FB5263F49;
        Mon,  2 Mar 2020 15:22:37 +0800 (CST)
Received: from DGGEML422-HUB.china.huawei.com (10.1.199.39) by
 DGGEML402-HUB.china.huawei.com (10.3.17.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Mar 2020 15:22:36 +0800
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.20]) by
 dggeml422-hub.china.huawei.com ([10.1.199.39]) with mapi id 14.03.0439.000;
 Mon, 2 Mar 2020 15:22:29 +0800
From:   liweihang <liweihang@huawei.com>
To:     Parav Pandit <parav@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: Is anyone working on implementing LAG in ib core?
Thread-Topic: Is anyone working on implementing LAG in ib core?
Thread-Index: AQHV6TLv6f19Y5Y7HEi39Ag/HyzLYg==
Date:   Mon, 2 Mar 2020 07:22:28 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A0226F346@DGGEML522-MBX.china.huawei.com>
References: <280d87d0-fbc0-0566-794b-f66cb4fadb63@huawei.com>
 <20200222234026.GO31668@ziepe.ca>
 <98482e8a-f2eb-5406-b679-0ceb946ac618@mellanox.com>
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

On 2020/2/23 8:44, Parav Pandit wrote:
> Hi Jason, Weihang,
> 
> On 2/22/2020 5:40 PM, Jason Gunthorpe wrote:
>> On Sat, Feb 22, 2020 at 11:48:04AM +0800, Weihang Li wrote:
>>> Hi all,
>>>
>>> We plan to implement LAG in hns drivers recently, and as we know, there is
>>> already a mature and stable solution in the mlx5 driver. Considering that
>>> the net subsystem in kernel adopt the strategy that the framework implement
>>> bonding, we think it's reasonable to add LAG feature to the ib core based
>>> on mlx5's implementation. So that all drivers including hns and mlx5 can
>>> benefit from it.
>>>
>>> In previous discussions with Leon about achieving reporting of ib port link
>>> event in ib core, Leon mentioned that there might be someone trying to do
>>> this.
>>>
>>> So may I ask if there is anyone working on LAG in ib core or planning to
>>> implement it in near future? I will appreciate it if you can share your
>>> progress with me and maybe we can finish it together.
>>>
>>> If nobody is working on this, our team may take a try to implement LAG in
>>> the core. Any comments and suggestion are welcome.
>>
>> This is something that needs to be done, I understand several of the
>> other drivers are going to want to use LAG and we certainly can't have
>> everything copied into each driver.
>>
>> Jason
>>
> I am not sure mlx5 is right model for new rdma bond device support which
> I tried to highlight in Q&A-1 below.
> 
> I have below not-so-refined proposal for rdma bond device.
> 
> - Create a rdma bond device named rbond0 using two slave rdma devices
> mlx5_0 mlx5_1 which is connected to netdevice bond1 and underlying dma
> device of mlx5_0 rdma device.
> 
> $ rdma dev add type bond name rbond0 netdev bond1 slave mlx5_0 slave
> mlx5_1 dmadevice mlx5_0
> 
> $ rdma dev show
> 0: mlx5_0: node_type ca fw 12.25.1020 node_guid 248a:0703:0055:4660
> sys_image_guid 248a:0703:0055:4660
> 1: mlx5_1: node_type ca fw 12.25.1020 node_guid 248a:0703:0055:4661
> sys_image_guid 248a:0703:0055:4660
> 2: rbond0: node_type ca node_guid 248a:0703:0055:4660 sys_image_guid
> 248a:0703:0055:4660
> 
> - This should be done via rdma bond driver in
> drivers/infiniband/ulp/rdma_bond
> 
> Few obvious questions arise from above proposal:
> 1. But why can't I do the trick to remove two or more rdma device(s) and
> create one device when bond0 netdevice is created?
> Ans:
> (a) Because it leads to complex driver code in vendor driver to handle
> netdev events under rtnl lock.
> Given GID table needs to hold rtnl lock for short duration in
> ib_register_device(), things need to differ to work queue and perform
> synchronization.
> (b) User cannot predict when this new rdma bond device will be created
> automatically, after how long?
> (c) What if some failure occurred, should I parse /var/log/messages to
> figure out the error? What steps to roll back and retry?
> (d) What if driver internally attempt retry?..
> and some more..
> 
> 2. Why do we need to give netdevice in above proposal?
> Ans:
> Because for RoCE device you want to build right GID table for its
> matching netdevice. No guess work.
> 
> 3. But with that there will be multiple devices rbond0, mlx5_0 with same
> GID table entries.
> And that will confuse the user.
> What do we do about it?
> Ans:
> No. That won't happen, because this bond driver accept slave rdma devices.
> bond driver will request IB core to disable GID table of slave rdma devices.
> Or we can have commands to disable/enable specific GID types of slave
> rdma devices, which user can invoke before creating rdma bond device.
> 
> Such as
> $ rdma link mlx5_0 disable rocev1
> $ rdma link mlx5_0 enable rocev2
> 
> This way its easy to compose and addressed wider use case where RoCEv1
> GID table entries can be disabled and make efficient use of GID table.
> 
> 4. But if we are going to disable the GID table, why do we even need
> those RDMA devices?
> Ans:
> Because when you delete the bond rdma device, you can revert back to
> those mlx5_0/1 devices.
> Follwo mirror of add in delete.
> 
> 5. Why do we need to give DMA device?
> Ans:
> Because we want to avoid doing guess work in rdma_bond driver on which
> DMA device to use.
> User knows the configuration of how he wants to use it based on the
> system. (irqs etc).
> 
> 6. What happens if slave pci devices are hot removed?
> Ans:
> If slave dma device is removed, it disassociates the ucontext and rbond0
> becomes unusable for applications.
> 
> 7. How is the failover done?
> Ans: Since failover netdevice is provided, its failover settings are
> inherited by rbond0 rdma device and passed on to its slave device.
> 

Hi Parav,

Thanks for your discussion with Jason and Leon, there are a lot of
things that I have never considered. And sorry for the late response, it
took me some time to understand current LAG driver of mlx5. Seems a
mlx5_lag structure combines all slave net devices and ib devices, and it
has no directly combination with the bonding net device.

It seems you have been thinking a lot about how LAG can be achieved
in core. Do you have plans to implement it? Or have you already finished
some part of it? I'm curious about that because we want to use LAG in
HIPXX as I said, and we can help to test and improve the existing design
if some work is already done.

Thank you
Weihang
