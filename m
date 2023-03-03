Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04186A8F4A
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Mar 2023 03:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCCCgt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Mar 2023 21:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjCCCgs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Mar 2023 21:36:48 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF3D4E5C0
        for <linux-rdma@vger.kernel.org>; Thu,  2 Mar 2023 18:36:45 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PSX9613vcz16P2d;
        Fri,  3 Mar 2023 10:34:02 +0800 (CST)
Received: from [10.67.102.17] (10.67.102.17) by kwepemi500006.china.huawei.com
 (7.221.188.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 3 Mar
 2023 10:36:42 +0800
Message-ID: <9befbceb-a493-652b-bd51-97f3f632eefb@hisilicon.com>
Date:   Fri, 3 Mar 2023 10:36:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
From:   Junxian Huang <huangjunxian6@hisilicon.com>
Subject: Re: A question about FAILOVER event in RoCE LAG
To:     Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "huangjunxian (C)" <huangjunxian6@hisilicon.com>
References: <26b0d23202814f60b994ce123830353d@hisilicon.com>
 <Y/tWPpJNz3EHtMgB@unreal> <afd9c082-db31-da9e-8cc9-44410d110ccf@nvidia.com>
Content-Language: en-US
In-Reply-To: <afd9c082-db31-da9e-8cc9-44410d110ccf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.17]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2023/2/26 21:57, Mark Bloch wrote:
> 
> 
> On 26/02/2023 14:53, Leon Romanovsky wrote:
>> +Mark
>>
>> On Fri, Feb 24, 2023 at 11:14:47AM +0000, huangjunxian (C) wrote:
>>> Hi folks!
>>>
>>> We've been working on LAG in hns RoCE driver, and we notice that when a FAILOVER event
>>> occurs in active-backup mode, all GIDs of the RDMA bond device are deleted and new GIDs
>>> are added, triggered by the event handler listed below.
>>>
>>> So, when a FAILOVER event occurs on a RDMA bond device with running traffic, does it make
>>> sense that the traffic is terminated since its GIDs are deleted?
> 
> Yep, please read the original commit message:
> 
> commit 238fdf48f2b54a01cedb5774c3a1e81c94e1a3a0
> Author: Matan Barak <matanb@mellanox.com>
> Date:   Thu Jul 30 18:33:27 2015 +0300
> 
>     IB/core: Add RoCE table bonding support
> 
>     Handling bonding and other devices require us to all all GIDs of the
>     net-devices which are upper-devices of the RoCE port related
>     net-device.
> 
>     Active-backup configurations imposes even more challenges as the
>     default GID should only be set on the active devices (this is
>     necessary as otherwise the same MAC could be used for several
>     slaves and thus several slaves will have identical GIDs).
> 
>     Managing these configurations are done by listening to:
>     (a) NETDEV_CHANGEUPPER event
>             (1) if a related net-device is linked, delete all inactive
>                 slaves default GIDs and add the upper device GIDs.
>             (2) if a related net-device is unlinked, delete all upper GIDs
>                 and add the default GIDs.
>     (b) NETDEV_BONDING_FAILOVER:
>             (1) delete the bond GIDs from inactive slaves
>             (2) delete the inactive slave's default GIDs
>             (3) Add the bond GIDs to the active slave.
> 
>     Signed-off-by: Matan Barak <matanb@mellanox.com>
>     Signed-off-by: Doug Ledford <dledford@redhat.com>
> 
> and please read: https://wiki.linuxfoundation.org/networking/bonding
> especially the section that explains some of the restrictions of
> active-backup mode.
> 
> Mark
> 
>>>
>>> The FAILOVER event handler mentioned above:
>>> static int netdevice_event(struct notifier_block *this, unsigned long event, void *ptr)
>>> {
>>>          ......
>>>          static const struct netdev_event_work_cmd bonding_event_ips_del_cmd = {
>>>                   .cb = del_netdev_upper_ips, .filter = upper_device_filter};
>>>          ......
>>>          switch (event) {
>>>          ......
>>>          case NETDEV_BONDING_FAILOVER:
>>>                   cmds[0] = bonding_event_ips_del_cmd;
>>>                   /* Add default GIDs of the bond device */
>>>                   cmds[1] = bonding_default_add_cmd;
>>>                   /* Add IP based GIDs of the bond device */
>>>                   cmds[2] = add_cmd_upper_ips;
>>>                   break;
>>>          ......
>>>          }
>>>          ......
>>> }
>>>
>>> Thanks,
>>> Junxian

Thanks for replying. I'd like to explain my question more specifically.

When a GID is deleted, the GID index is not reusable until all references
are dropped, according to this commit message:

commit be5914c124bc3179536e5c4598f59aeb4b880517
Author: Parav Pandit <parav@mellanox.com>
Date:   Tue Dec 18 14:16:00 2018 +0200

    RDMA/core: Delete RoCE GID in hw when corresponding IP is deleted

    Currently a RoCE GID entry is removed from the hardware when all
    references to the GID entry drop to zero. This is a change in behavior
    from before the fixed patch. The GID entry should be removed from the
    hardware when GID entry deletion is requested. This allows the driver
    terminate ongoing traffic through the RoCE GID.

    While a GID is deleted from the hardware, GID slot in the software GID
    cache is not freed. GID slot is freed once all references of such GID are
    dropped. This continue to ensure that such GID slot of hardware is not
    allocated to new GID entry allocation request. It is allocated once all
    references to GID entry drop.

    This approach allows drivers to put a tombestone of some kind on the HW
    GID index to block the traffic.

    Fixes: b150c3862d21 ("IB/core: Introduce GID entry reference counts")
    Signed-off-by: Parav Pandit <parav@mellanox.com>
    Reviewed-by: Mark Bloch <markb@mellanox.com>
    Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
    Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Assume that a RoCE bond device is running RoCE traffic with a GID in index 3.

When a FAILOVER event occurs, the original GIDs in index 0-3 are deleted
and new GIDs are added. As the QP is still holding a reference to index 3,
the new GIDs are not added to index 0-3 but to index 0-2 and index 4.

Due to the deletion of the original GID in index 3, the RoCE traffic is
terminated. Although a backup slave becomes active, the traffic will
not recover anymore as the new GID is not added to index 3 and there is no
valid GID in index 3. This means the active-backup mode in RoCE LAG cannot
maintain ongoing RoCE traffic when a FAILOVER event happens.

Are the phenomenon and conclusion here correct? This seems odd to me because
as far as I know, there is no such restriction on the active-backup mode in
NIC Bonding.

Junxian









