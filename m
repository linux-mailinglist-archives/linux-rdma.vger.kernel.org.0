Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8B16FB089
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2019 13:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfKMMft (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Nov 2019 07:35:49 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:37158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbfKMMft (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Nov 2019 07:35:49 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 400F5E162C397BAD5A80;
        Wed, 13 Nov 2019 20:35:44 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 13 Nov 2019
 20:35:43 +0800
Subject: =?UTF-8?B?UmU6IOOAkEFzayBmb3IgaGVscOOAkSBBIHF1ZXN0aW9uIGZvciBfX2li?=
 =?UTF-8?B?X2NhY2hlX2dpZF9hZGQoKQ==?=
To:     Parav Pandit <parav@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <fd2a9385-f6c7-8471-b20c-476d4e9fada7@huawei.com>
 <20191101130540.GB30938@ziepe.ca>
 <AM0PR05MB4866715D6F149927D4B31C46D1620@AM0PR05MB4866.eurprd05.prod.outlook.com>
From:   oulijun <oulijun@huawei.com>
Message-ID: <a1b0cf5f-e52e-99b2-9888-6a40c4d71702@huawei.com>
Date:   Wed, 13 Nov 2019 20:35:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <AM0PR05MB4866715D6F149927D4B31C46D1620@AM0PR05MB4866.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/11/2 0:00, Parav Pandit 写道:
> Hi Lijun,
>
>> -----Original Message-----
>> From: Jason Gunthorpe <jgg@ziepe.ca>
>> Sent: Friday, November 1, 2019 8:06 AM
>> To: oulijun <oulijun@huawei.com>; Parav Pandit <parav@mellanox.com>
>> Cc: Doug Ledford <dledford@redhat.com>; linux-rdma <linux-
>> rdma@vger.kernel.org>
>> Subject: Re: 【Ask for help】 A question for __ib_cache_gid_add()
>>
>> On Fri, Nov 01, 2019 at 05:36:36PM +0800, oulijun wrote:
>>> Hi
>>>   I am using the ubuntu system(5.0.0 kernel) to test the hip08 NIC
>>> port,. When I modify the perr mac1 to mac2,then restore to mac1, it will
>> cause the gid0 and gid 1 of the roce to be unavailable, and check that the
>> /sys/class/infiniband/hns_0/ports/1/gid_attrs/ndevs/0 is show invalid.
>>> the protocol stack print will appear.
>>>
>>>   Oct 16 17:59:36 ubuntu kernel: [200635.496317] __ib_cache_gid_add:
>>> unable to add gid fe80:0000:0000:0000:4600:4dff:fea7:9599 error=-28
>>> Oct 16 17:59:37 ubuntu kernel: [200636.705848] 8021q: adding VLAN 0 to
>>> HW filter on device enp189s0f0 Oct 16 17:59:37 ubuntu kernel:
>>> [200636.705854] __ib_cache_gid_add: unable to add gid
>>> fe80:0000:0000:0000:4600:4dff:fea7:9599 error=-28 Oct 16 17:59:39
>>> ubuntu kernel: [200638.755828] hns3 0000:bd:00.0 enp189s0f0: link up
>>> Oct 16 17:59:39 ubuntu kernel: [200638.755847] IPv6:
>>> ADDRCONF(NETDEV_CHANGE): enp189s0f0: link becomes ready Oct 16
>>> 18:00:56 ubuntu kernel: [200715.699961] hns3 0000:bd:00.0 enp189s0f0:
>>> link down Oct 16 18:00:56 ubuntu kernel: [200716.016142]
>>> __ib_cache_gid_add: unable to add gid
>>> fe80:0000:0000:0000:4600:4dff:fea7:95f4 error=-28 Oct 16 18:00:58
>>> ubuntu kernel: [200717.229857] 8021q: adding VLAN 0 to HW filter on
>>> device enp189s0f0 Oct 16 18:00:58 ubuntu kernel: [200717.229863]
>>> __ib_cache_gid_add: unable to add gid
>>> fe80:0000:0000:0000:4600:4dff:fea7:95f4 error=-28
>>>
>>> Has anyone else encounterd a similar problem ? I wonder if the
>> _ib_cache_add_gid() is defective in 5.0 kernel?
>>
>> Maybe Parav knows?
> I used the kernel from [1], which seems to be fine; it has the required commits [2], [3], [4].
>
> Are you running RDMA traffic/applications which are using GID 0 and 1 when changing MAC?
> If so, administrative operation such as MAC address change during active RDMA traffic is unsupported, which can lead to this error.
> Can you please confirm?
Hi, parav Pandit
    if running RDMA traffic/application which are using vlan gid when vconfig rem the vlan, it will happen the following error?
   
 Oct 11 13:51:13 ubuntu kernel: [10408.846497] unregister_netdevice: waiting for eno1.1000 to become free. Usage count = 4
Oct 11 13:51:23 ubuntu kernel: [10418.926477] unregister_netdevice: waiting for eno1.1000 to become free. Usage count = 4
Oct 11 13:51:33 ubuntu kernel: [10429.006489] unregister_netdevice: waiting for eno1.1000 to become free. Usage count = 4
Oct 11 13:51:43 ubuntu kernel: [10439.086477] unregister_netdevice: waiting for eno1.1000 to become free. Usage count = 4
Oct 11 13:51:53 ubuntu kernel: [10449.166493] unregister_netdevice: waiting for eno1.1000 to become free. Usage count = 4
Oct 11 13:52:04 ubuntu kernel: [10459.246473] unregister_netdevice: waiting for eno1.1000 to become free. Usage count = 4
Oct 11 13:52:14 ubuntu kernel: [10469.326478] unregister_netdevice: waiting for eno1.1000 to become free. Usage count = 4
Oct 11 13:52:24 ubuntu kernel: [10479.406470] unregister_netdevice: waiting for eno1.1000 to become free. Usage count = 4
Oct 11 13:52:34 ubuntu kernel: [10489.486495] unregister_netdevice: waiting for eno1.1000 to become free. Usage count = 4
Oct 11 13:52:44 ubuntu kernel: [10499.566476] unregister_netdevice: waiting for eno1.1000 to become free. Usage count = 4
Oct 11 13:52:54 ubuntu kernel: [10509.646600] unregister_netdevice: waiting for eno1.1000 to become free. Usage count = 4


Thanks

> If you are not running RDMA traffic while changing the mac, I need more debug logs.
> Can you please enable ftrace and share the output file mac_change_trace.txt using below steps?
>
> echo 0 > /sys/kernel/debug/tracing/tracing_on
> echo function_graph > /sys/kernel/debug/tracing/current_tracer
> echo > /sys/kernel/debug/tracing/trace
> echo > /sys/kernel/debug/tracing/set_ftrace_filter
> echo ':mod:ib*' > /sys/kernel/debug/tracing/set_ftrace_filter
> echo ':mod:rdma*' >> /sys/kernel/debug/tracing/set_ftrace_filter
> echo 1 > /sys/kernel/debug/tracing/tracing_on
>
> ip link set <netdev> address <new_mac1>
> ip link set <netdev> address <new_mac2>
> cat /sys/kernel/debug/tracing/trace > mac_change_trace.txt
>
> [1] git://git.launchpad.net/~ubuntu-kernel-test/ubuntu/+source/linux/+git/mainline-crack v5.0
> [2] commit 5c5702e259dc ("RDMA/core: Set right entry state before releasing reference")
> [3] commit be5914c124bc ("RDMA/core: Delete RoCE GID in hw when corresponding IP is deleted")
> [4] commit d12e2eed2743 ("IB/core: Update GID entries for netdevice whose mac address changes")
>
>
> .
>


