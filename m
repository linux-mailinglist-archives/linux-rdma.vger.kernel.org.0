Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 000876652D
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 05:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfGLDqB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 23:46:01 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38428 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbfGLDqB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jul 2019 23:46:01 -0400
Received: by mail-ot1-f65.google.com with SMTP id d17so8111971oth.5
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 20:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+/z2au3Kq93/20tmrzD/LzmZT99OasT7caKEOHpW7j8=;
        b=EtBTFECb3AQZcjE/3yj4GR/kNGgnyAb5Dk2+UAq2+uRvPqi98cQnxA5kUaPIHQN6w1
         XSTVBvx5EvmLhQcDu4K2rPSalo40PCer16bfVxr7iepQwxWxxnWGyZDQOuprA2s8foK2
         WOQMd1XU4EoyWyvBoHAzDDTpXvTmpgt6YaEZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+/z2au3Kq93/20tmrzD/LzmZT99OasT7caKEOHpW7j8=;
        b=miX8xJqvByXw7zSVBONTMbym/BiimZw+Z8zq8aJsOL4fZ5q81loPJ3a5jl5ol5rLF/
         Wt1F2wsscM9+prkat88CU4Drq3aoRvNbbjhCJ6d5eeaVIfPpgRWo77tIDtHDa6avgm6q
         LnrvwytmZ/5yrP6hDOyU/rsEA6ni8aHg44Ppbmq/Qnl2W+n2EnwXAUKFAJ+HQkq0nfZi
         7+0kxyj01OC8I/5ndq7a0tChYuM/lOm0DtbiyefPDnRR0hFw0UyMyg1jbIAqdQPCZFa7
         YFggf+I4EEL0hzXvzdQqfIuMO9duGBLc46cTLR9ZeB4RYY7N2vM/ppAEFylJVFYALWjo
         JsOQ==
X-Gm-Message-State: APjAAAWAIxHRsbrCNFcZgLlZLxvsPOHL+3EKj9oOA84Qr8cUhaIwQ2iB
        bELsuGfcIw5ArBDo8fLomYBHvi0mL50dbCYqRNEtTA==
X-Google-Smtp-Source: APXvYqw554RhA2Oy46+Sh+ZCs5XB41fc7EdLsbyjtWNq/fE2pBqeQYaftZpijiCP5q1y2NJFLzkK94/vCG/nx/Vez3E=
X-Received: by 2002:a05:6830:117:: with SMTP id i23mr6045533otp.47.1562903159907;
 Thu, 11 Jul 2019 20:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <1310083272.27124086.1562836112586.JavaMail.zimbra@redhat.com>
 <619411460.27128070.1562838433020.JavaMail.zimbra@redhat.com>
 <AM0PR05MB48664657022ECA8526E3C967D1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866070FBADCCABD1F84E42ED1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <66d43fd8-18e8-8b9d-90e3-ee2804d56889@redhat.com> <AM0PR05MB4866DEDB9DE4379F6A6EF15BD1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
In-Reply-To: <AM0PR05MB4866DEDB9DE4379F6A6EF15BD1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Fri, 12 Jul 2019 09:15:47 +0530
Message-ID: <CA+sbYW17PGAW57pyRmQB9KsDA9Q+7FFgSseSTTWE_h6vffa7UQ@mail.gmail.com>
Subject: Re: regression: nvme rdma with bnxt_re0 broken
To:     Parav Pandit <parav@mellanox.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 8:19 AM Parav Pandit <parav@mellanox.com> wrote:
>
> Hi Yi Zhang,
>
> > -----Original Message-----
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Yi Zhang
> > Sent: Friday, July 12, 2019 7:23 AM
> > To: Parav Pandit <parav@mellanox.com>; linux-nvme@lists.infradead.org
> > Cc: Daniel Jurgens <danielj@mellanox.com>; linux-rdma@vger.kernel.org;
> > Devesh Sharma <devesh.sharma@broadcom.com>;
> > selvin.xavier@broadcom.com
> > Subject: Re: regression: nvme rdma with bnxt_re0 broken
> >
> > Hi Parav
> >
> > Here is the info, let me know if it's enough, thanks.
> >
> > [root@rdma-perf-07 ~]$ echo -n "module ib_core +p" >
> > /sys/kernel/debug/dynamic_debug/control
> > [root@rdma-perf-07 ~]$ ifdown bnxt_roce
> > Device 'bnxt_roce' successfully disconnected.
> > [root@rdma-perf-07 ~]$ ifup bnxt_roce
> > Connection successfully activated (D-Bus active path:
> > /org/freedesktop/NetworkManager/ActiveConnection/16)
> > [root@rdma-perf-07 ~]$ sh a.sh
> > DEV    PORT    INDEX    GID                    IPv4         VER DEV
> > ---    ----    -----    ---                    ------------ ---    ---
> > bnxt_re0    1    0    fe80:0000:0000:0000:020a:f7ff:fee3:6e32
> > v1    bnxt_roce
> > bnxt_re0    1    1    fe80:0000:0000:0000:020a:f7ff:fee3:6e32
> > v2    bnxt_roce
> > bnxt_re0    1    10    0000:0000:0000:0000:0000:ffff:ac1f:2bbb
> > 172.31.43.187     v1    bnxt_roce.43
> > bnxt_re0    1    11    0000:0000:0000:0000:0000:ffff:ac1f:2bbb
> > 172.31.43.187     v2    bnxt_roce.43
> > bnxt_re0    1    2    fe80:0000:0000:0000:020a:f7ff:fee3:6e32
> > v1    bnxt_roce.45
> > bnxt_re0    1    3    fe80:0000:0000:0000:020a:f7ff:fee3:6e32
> > v2    bnxt_roce.45
> > bnxt_re0    1    4    fe80:0000:0000:0000:020a:f7ff:fee3:6e32
> > v1    bnxt_roce.43
> > bnxt_re0    1    5    fe80:0000:0000:0000:020a:f7ff:fee3:6e32
> > v2    bnxt_roce.43
> > bnxt_re0    1    6    0000:0000:0000:0000:0000:ffff:ac1f:28bb
> > 172.31.40.187     v1    bnxt_roce
> > bnxt_re0    1    7    0000:0000:0000:0000:0000:ffff:ac1f:28bb
> > 172.31.40.187     v2    bnxt_roce
> > bnxt_re0    1    8    0000:0000:0000:0000:0000:ffff:ac1f:2dbb
> > 172.31.45.187     v1    bnxt_roce.45
> > bnxt_re0    1    9    0000:0000:0000:0000:0000:ffff:ac1f:2dbb
> > 172.31.45.187     v2    bnxt_roce.45
> > bnxt_re1    1    0    fe80:0000:0000:0000:020a:f7ff:fee3:6e33
> > v1    lom_2
> > bnxt_re1    1    1    fe80:0000:0000:0000:020a:f7ff:fee3:6e33
> > v2    lom_2
> > cxgb4_0    1    0    0007:433b:f5b0:0000:0000:0000:0000:0000         v1
> > cxgb4_0    2    0    0007:433b:f5b8:0000:0000:0000:0000:0000         v1
> > hfi1_0    1    0    fe80:0000:0000:0000:0011:7501:0109:6c60     v1
> > hfi1_0    1    1    fe80:0000:0000:0000:0006:6a00:0000:0005     v1
> > mlx5_0    1    0    fe80:0000:0000:0000:506b:4b03:00f3:8a38     v1
> > n_gids_found=3D19
> >
> > [root@rdma-perf-07 ~]$ dmesg | tail -15
> > [   19.744421] IPv6: ADDRCONF(NETDEV_CHANGE): mlx5_ib0.8002: link
> > becomes ready [   19.758371] IPv6: ADDRCONF(NETDEV_CHANGE):
> > mlx5_ib0.8004: link becomes ready [   20.010469] hfi1 0000:d8:00.0: hfi=
1_0:
> > Switching to NO_DMA_RTAIL [   20.440580] IPv6:
> > ADDRCONF(NETDEV_CHANGE): mlx5_ib0.8006: link becomes ready
> > [   21.098510] bnxt_en 0000:19:00.0 bnxt_roce: Too many traffic classes
> > requested: 8. Max supported is 2.
> > [   21.324341] bnxt_en 0000:19:00.0 bnxt_roce: Too many traffic classes
> > requested: 8. Max supported is 2.
> > [   22.058647] IPv6: ADDRCONF(NETDEV_CHANGE): hfi1_opa0: link becomes
> > ready [  211.407329] _ib_cache_gid_del: can't delete gid
> > fe80:0000:0000:0000:020a:f7ff:fee3:6e32 error=3D-22 [  211.407334]
> > _ib_cache_gid_del: can't delete gid
> > fe80:0000:0000:0000:020a:f7ff:fee3:6e32 error=3D-22 [  211.425275] infi=
niband
> > bnxt_re0: del_gid port=3D1 index=3D6 gid
> > 0000:0000:0000:0000:0000:ffff:ac1f:28bb
> > [  211.425280] infiniband bnxt_re0: free_gid_entry_locked port=3D1 inde=
x=3D6 gid
> > 0000:0000:0000:0000:0000:ffff:ac1f:28bb
> > [  211.425292] infiniband bnxt_re0: del_gid port=3D1 index=3D7 gid
> > 0000:0000:0000:0000:0000:ffff:ac1f:28bb
> > [  211.425461] infiniband bnxt_re0: free_gid_entry_locked port=3D1 inde=
x=3D7 gid
> > 0000:0000:0000:0000:0000:ffff:ac1f:28bb
> > [  225.474061] infiniband bnxt_re0: store_gid_entry port=3D1 index=3D6 =
gid
> > 0000:0000:0000:0000:0000:ffff:ac1f:28bb
> > [  225.474075] infiniband bnxt_re0: store_gid_entry port=3D1 index=3D7 =
gid
> > 0000:0000:0000:0000:0000:ffff:ac1f:28bb
> >
> >
> GID table looks fine.
>
The GID table has  fe80:0000:0000:0000:020a:f7ff:fee3:6e32 entry
repeated 6 times. 2 for each interface
bnxt_roce, bnxt_roce.43 and bnxt_roce.45. Is this expected to have
same gid entries for vlan and base interfaces? As you mentioned
earlier, driver's assumption
that only 2 GID entries identical (one for RoCE v1 and one for RoCE
v2)   is breaking here.

> > On 7/12/19 12:18 AM, Parav Pandit wrote:
> > > Sagi,
> > >
> > > This is better one to cc to linux-rdma.
> > >
> > > + Devesh, Selvin.
> > >
> > >> -----Original Message-----
> > >> From: Parav Pandit
> > >> Sent: Thursday, July 11, 2019 6:25 PM
> > >> To: Yi Zhang <yi.zhang@redhat.com>; linux-nvme@lists.infradead.org
> > >> Cc: Daniel Jurgens <danielj@mellanox.com>
> > >> Subject: RE: regression: nvme rdma with bnxt_re0 broken
> > >>
> > >> Hi Yi Zhang,
> > >>
> > >>> -----Original Message-----
> > >>> From: Yi Zhang <yi.zhang@redhat.com>
> > >>> Sent: Thursday, July 11, 2019 3:17 PM
> > >>> To: linux-nvme@lists.infradead.org
> > >>> Cc: Daniel Jurgens <danielj@mellanox.com>; Parav Pandit
> > >>> <parav@mellanox.com>
> > >>> Subject: regression: nvme rdma with bnxt_re0 broken
> > >>>
> > >>> Hello
> > >>>
> > >>> 'nvme connect' failed when use bnxt_re0 on latest upstream build[1]=
,
> > >>> by bisecting I found it was introduced from v5.2.0-rc1 with [2], it
> > >>> works after I revert it.
> > >>> Let me know if you need more info, thanks.
> > >>>
> > >>> [1]
> > >>> [root@rdma-perf-07 ~]$ nvme connect -t rdma -a 172.31.40.125 -s 442=
0
> > >>> -n testnqn Failed to write to /dev/nvme-fabrics: Bad address
> > >>>
> > >>> [root@rdma-perf-07 ~]$ dmesg
> > >>> [  476.320742] bnxt_en 0000:19:00.0: QPLIB: cmdq[0x4b9]=3D0x15 stat=
us 0x5
>
> Devesh, Selvin,
>
> What does this error mean?
> bnxt_qplib_create_ah() is failing.
>
We are passing a wrong index for the GID to FW because of the
assumption mentioned earlier.
FW is failing command due to this.

> > >>> [ 476.327103] infiniband bnxt_re0: Failed to allocate HW AH [
> > >>> 476.332525] nvme nvme2: rdma_connect failed (-14).
> > >>> [  476.343552] nvme nvme2: rdma connection establishment failed
> > >>> (-14)
> > >>>
> > >>> [root@rdma-perf-07 ~]$ lspci  | grep -i Broadcom
> > >>> 01:00.0 Ethernet controller: Broadcom Inc. and subsidiaries
> > >>> NetXtreme
> > >>> BCM5720 2-port Gigabit Ethernet PCIe
> > >>> 01:00.1 Ethernet controller: Broadcom Inc. and subsidiaries
> > >>> NetXtreme
> > >>> BCM5720 2-port Gigabit Ethernet PCIe
> > >>> 18:00.0 RAID bus controller: Broadcom / LSI MegaRAID SAS-3 3008
> > >>> [Fury] (rev
> > >>> 02)
> > >>> 19:00.0 Ethernet controller: Broadcom Inc. and subsidiaries BCM5741=
2
> > >>> NetXtreme-E 10Gb RDMA Ethernet Controller (rev 01)
> > >>> 19:00.1 Ethernet controller: Broadcom Inc. and subsidiaries BCM5741=
2
> > >>> NetXtreme-E 10Gb RDMA Ethernet Controller (rev 01)
> > >>>
> > >>>
> > >>> [2]
> > >>> commit 823b23da71132b80d9f41ab667c68b112455f3b6
> > >>> Author: Parav Pandit <parav@mellanox.com>
> > >>> Date:   Wed Apr 10 11:23:03 2019 +0300
> > >>>
> > >>>      IB/core: Allow vlan link local address based RoCE GIDs
> > >>>
> > >>>      IPv6 link local address for a VLAN netdevice has nothing to do=
 with its
> > >>>      resemblance with the default GID, because VLAN link local GID =
is in
> > >>>      different layer 2 domain.
> > >>>
> > >>>      Now that RoCE MAD packet processing and route resolution consi=
der
> > the
> > >>>      right GID index, there is no need for an unnecessary check whi=
ch
> > prevents
> > >>>      the addition of vlan based IPv6 link local GIDs.
> > >>>
> > >>>      Signed-off-by: Parav Pandit <parav@mellanox.com>
> > >>>      Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
> > >>>      Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > >>>      Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > >>>
> > >>>
> > >>>
> > >>> Best Regards,
> > >>>    Yi Zhang
> > >>>
> > >> I need some more information from you to debug this issue as I don=
=E2=80=99t
> > >> have the hw.
> > >> The highlighted patch added support for IPv6 link local address for
> > >> vlan. I am unsure how this can affect IPv4 AH creation for which the=
re is
> > failure.
> > >>
> > >> 1. Before you assign the IP address to the netdevice, Please do, ech=
o
> > >> -n "module ib_core +p" > /sys/kernel/debug/dynamic_debug/control
> > >>
> > >> Please share below output before doing nvme connect.
> > >> 2. Output of script [1]
> > >> $ show_gids script
> > >> If getting this script is problematic, share the output of,
> > >>
> > >> $ cat /sys/class/infiniband/bnxt_re0/ports/1/gids/*
> > >> $ cat /sys/class/infiniband/bnxt_re0/ports/1/gid_attrs/ndevs/*
> > >> $ ip link show
> > >> $ip addr show
> > >> $ dmesg
> > >>
> > >> [1] https://community.mellanox.com/s/article/understanding-show-gids=
-
> > >> script#jive_content_id_The_Script
> > >>
> > >> I suspect that driver's assumption about GID indices might have gone
> > >> wrong here in drivers/infiniband/hw/bnxt_re/ib_verbs.c.
> > >> Lets see about results to confirm that.
> > > _______________________________________________
> > > Linux-nvme mailing list
> > > Linux-nvme@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-nvme
