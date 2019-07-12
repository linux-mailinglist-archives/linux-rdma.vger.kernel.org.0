Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1F2E6637D
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 03:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfGLBxe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 21:53:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729202AbfGLBxe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Jul 2019 21:53:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3CCA308338F;
        Fri, 12 Jul 2019 01:53:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-47.pek2.redhat.com [10.72.12.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F2BE1001B2B;
        Fri, 12 Jul 2019 01:53:24 +0000 (UTC)
Subject: Re: regression: nvme rdma with bnxt_re0 broken
To:     Parav Pandit <parav@mellanox.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     Daniel Jurgens <danielj@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        "selvin.xavier@broadcom.com" <selvin.xavier@broadcom.com>
References: <1310083272.27124086.1562836112586.JavaMail.zimbra@redhat.com>
 <619411460.27128070.1562838433020.JavaMail.zimbra@redhat.com>
 <AM0PR05MB48664657022ECA8526E3C967D1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866070FBADCCABD1F84E42ED1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <66d43fd8-18e8-8b9d-90e3-ee2804d56889@redhat.com>
Date:   Fri, 12 Jul 2019 09:53:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <AM0PR05MB4866070FBADCCABD1F84E42ED1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 12 Jul 2019 01:53:34 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Parav

Here is the info, let me know if it's enough, thanks.

[root@rdma-perf-07 ~]$ echo -n "module ib_core +p" > 
/sys/kernel/debug/dynamic_debug/control
[root@rdma-perf-07 ~]$ ifdown bnxt_roce
Device 'bnxt_roce' successfully disconnected.
[root@rdma-perf-07 ~]$ ifup bnxt_roce
Connection successfully activated (D-Bus active path: 
/org/freedesktop/NetworkManager/ActiveConnection/16)
[root@rdma-perf-07 ~]$ sh a.sh
DEV    PORT    INDEX    GID                    IPv4         VER DEV
---    ----    -----    ---                    ------------ ---    ---
bnxt_re0    1    0    fe80:0000:0000:0000:020a:f7ff:fee3:6e32         
v1    bnxt_roce
bnxt_re0    1    1    fe80:0000:0000:0000:020a:f7ff:fee3:6e32         
v2    bnxt_roce
bnxt_re0    1    10    0000:0000:0000:0000:0000:ffff:ac1f:2bbb 
172.31.43.187     v1    bnxt_roce.43
bnxt_re0    1    11    0000:0000:0000:0000:0000:ffff:ac1f:2bbb 
172.31.43.187     v2    bnxt_roce.43
bnxt_re0    1    2    fe80:0000:0000:0000:020a:f7ff:fee3:6e32         
v1    bnxt_roce.45
bnxt_re0    1    3    fe80:0000:0000:0000:020a:f7ff:fee3:6e32         
v2    bnxt_roce.45
bnxt_re0    1    4    fe80:0000:0000:0000:020a:f7ff:fee3:6e32         
v1    bnxt_roce.43
bnxt_re0    1    5    fe80:0000:0000:0000:020a:f7ff:fee3:6e32         
v2    bnxt_roce.43
bnxt_re0    1    6    0000:0000:0000:0000:0000:ffff:ac1f:28bb 
172.31.40.187     v1    bnxt_roce
bnxt_re0    1    7    0000:0000:0000:0000:0000:ffff:ac1f:28bb 
172.31.40.187     v2    bnxt_roce
bnxt_re0    1    8    0000:0000:0000:0000:0000:ffff:ac1f:2dbb 
172.31.45.187     v1    bnxt_roce.45
bnxt_re0    1    9    0000:0000:0000:0000:0000:ffff:ac1f:2dbb 
172.31.45.187     v2    bnxt_roce.45
bnxt_re1    1    0    fe80:0000:0000:0000:020a:f7ff:fee3:6e33         
v1    lom_2
bnxt_re1    1    1    fe80:0000:0000:0000:020a:f7ff:fee3:6e33         
v2    lom_2
cxgb4_0    1    0    0007:433b:f5b0:0000:0000:0000:0000:0000         v1
cxgb4_0    2    0    0007:433b:f5b8:0000:0000:0000:0000:0000         v1
hfi1_0    1    0    fe80:0000:0000:0000:0011:7501:0109:6c60     v1
hfi1_0    1    1    fe80:0000:0000:0000:0006:6a00:0000:0005     v1
mlx5_0    1    0    fe80:0000:0000:0000:506b:4b03:00f3:8a38     v1
n_gids_found=19

[root@rdma-perf-07 ~]$ dmesg | tail -15
[   19.744421] IPv6: ADDRCONF(NETDEV_CHANGE): mlx5_ib0.8002: link 
becomes ready
[   19.758371] IPv6: ADDRCONF(NETDEV_CHANGE): mlx5_ib0.8004: link 
becomes ready
[   20.010469] hfi1 0000:d8:00.0: hfi1_0: Switching to NO_DMA_RTAIL
[   20.440580] IPv6: ADDRCONF(NETDEV_CHANGE): mlx5_ib0.8006: link 
becomes ready
[   21.098510] bnxt_en 0000:19:00.0 bnxt_roce: Too many traffic classes 
requested: 8. Max supported is 2.
[   21.324341] bnxt_en 0000:19:00.0 bnxt_roce: Too many traffic classes 
requested: 8. Max supported is 2.
[   22.058647] IPv6: ADDRCONF(NETDEV_CHANGE): hfi1_opa0: link becomes ready
[  211.407329] _ib_cache_gid_del: can't delete gid 
fe80:0000:0000:0000:020a:f7ff:fee3:6e32 error=-22
[  211.407334] _ib_cache_gid_del: can't delete gid 
fe80:0000:0000:0000:020a:f7ff:fee3:6e32 error=-22
[  211.425275] infiniband bnxt_re0: del_gid port=1 index=6 gid 
0000:0000:0000:0000:0000:ffff:ac1f:28bb
[  211.425280] infiniband bnxt_re0: free_gid_entry_locked port=1 index=6 
gid 0000:0000:0000:0000:0000:ffff:ac1f:28bb
[  211.425292] infiniband bnxt_re0: del_gid port=1 index=7 gid 
0000:0000:0000:0000:0000:ffff:ac1f:28bb
[  211.425461] infiniband bnxt_re0: free_gid_entry_locked port=1 index=7 
gid 0000:0000:0000:0000:0000:ffff:ac1f:28bb
[  225.474061] infiniband bnxt_re0: store_gid_entry port=1 index=6 gid 
0000:0000:0000:0000:0000:ffff:ac1f:28bb
[  225.474075] infiniband bnxt_re0: store_gid_entry port=1 index=7 gid 
0000:0000:0000:0000:0000:ffff:ac1f:28bb


On 7/12/19 12:18 AM, Parav Pandit wrote:
> Sagi,
>
> This is better one to cc to linux-rdma.
>
> + Devesh, Selvin.
>
>> -----Original Message-----
>> From: Parav Pandit
>> Sent: Thursday, July 11, 2019 6:25 PM
>> To: Yi Zhang <yi.zhang@redhat.com>; linux-nvme@lists.infradead.org
>> Cc: Daniel Jurgens <danielj@mellanox.com>
>> Subject: RE: regression: nvme rdma with bnxt_re0 broken
>>
>> Hi Yi Zhang,
>>
>>> -----Original Message-----
>>> From: Yi Zhang <yi.zhang@redhat.com>
>>> Sent: Thursday, July 11, 2019 3:17 PM
>>> To: linux-nvme@lists.infradead.org
>>> Cc: Daniel Jurgens <danielj@mellanox.com>; Parav Pandit
>>> <parav@mellanox.com>
>>> Subject: regression: nvme rdma with bnxt_re0 broken
>>>
>>> Hello
>>>
>>> 'nvme connect' failed when use bnxt_re0 on latest upstream build[1],
>>> by bisecting I found it was introduced from v5.2.0-rc1 with [2], it
>>> works after I revert it.
>>> Let me know if you need more info, thanks.
>>>
>>> [1]
>>> [root@rdma-perf-07 ~]$ nvme connect -t rdma -a 172.31.40.125 -s 4420
>>> -n testnqn Failed to write to /dev/nvme-fabrics: Bad address
>>>
>>> [root@rdma-perf-07 ~]$ dmesg
>>> [  476.320742] bnxt_en 0000:19:00.0: QPLIB: cmdq[0x4b9]=0x15 status
>>> 0x5 [ 476.327103] infiniband bnxt_re0: Failed to allocate HW AH [
>>> 476.332525] nvme nvme2: rdma_connect failed (-14).
>>> [  476.343552] nvme nvme2: rdma connection establishment failed (-14)
>>>
>>> [root@rdma-perf-07 ~]$ lspci  | grep -i Broadcom
>>> 01:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme
>>> BCM5720 2-port Gigabit Ethernet PCIe
>>> 01:00.1 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme
>>> BCM5720 2-port Gigabit Ethernet PCIe
>>> 18:00.0 RAID bus controller: Broadcom / LSI MegaRAID SAS-3 3008 [Fury]
>>> (rev
>>> 02)
>>> 19:00.0 Ethernet controller: Broadcom Inc. and subsidiaries BCM57412
>>> NetXtreme-E 10Gb RDMA Ethernet Controller (rev 01)
>>> 19:00.1 Ethernet controller: Broadcom Inc. and subsidiaries BCM57412
>>> NetXtreme-E 10Gb RDMA Ethernet Controller (rev 01)
>>>
>>>
>>> [2]
>>> commit 823b23da71132b80d9f41ab667c68b112455f3b6
>>> Author: Parav Pandit <parav@mellanox.com>
>>> Date:   Wed Apr 10 11:23:03 2019 +0300
>>>
>>>      IB/core: Allow vlan link local address based RoCE GIDs
>>>
>>>      IPv6 link local address for a VLAN netdevice has nothing to do with its
>>>      resemblance with the default GID, because VLAN link local GID is in
>>>      different layer 2 domain.
>>>
>>>      Now that RoCE MAD packet processing and route resolution consider the
>>>      right GID index, there is no need for an unnecessary check which prevents
>>>      the addition of vlan based IPv6 link local GIDs.
>>>
>>>      Signed-off-by: Parav Pandit <parav@mellanox.com>
>>>      Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
>>>      Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>>>      Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>>>
>>>
>>>
>>> Best Regards,
>>>    Yi Zhang
>>>
>> I need some more information from you to debug this issue as I don’t have the
>> hw.
>> The highlighted patch added support for IPv6 link local address for vlan. I am
>> unsure how this can affect IPv4 AH creation for which there is failure.
>>
>> 1. Before you assign the IP address to the netdevice, Please do, echo -n
>> "module ib_core +p" > /sys/kernel/debug/dynamic_debug/control
>>
>> Please share below output before doing nvme connect.
>> 2. Output of script [1]
>> $ show_gids script
>> If getting this script is problematic, share the output of,
>>
>> $ cat /sys/class/infiniband/bnxt_re0/ports/1/gids/*
>> $ cat /sys/class/infiniband/bnxt_re0/ports/1/gid_attrs/ndevs/*
>> $ ip link show
>> $ip addr show
>> $ dmesg
>>
>> [1] https://community.mellanox.com/s/article/understanding-show-gids-
>> script#jive_content_id_The_Script
>>
>> I suspect that driver's assumption about GID indices might have gone wrong
>> here in drivers/infiniband/hw/bnxt_re/ib_verbs.c.
>> Lets see about results to confirm that.
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
