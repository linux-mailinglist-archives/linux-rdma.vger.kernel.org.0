Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DD83416D4
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 08:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhCSHpG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 03:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbhCSHom (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Mar 2021 03:44:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5C7C06174A
        for <linux-rdma@vger.kernel.org>; Fri, 19 Mar 2021 00:44:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w3so8095769ejc.4
        for <linux-rdma@vger.kernel.org>; Fri, 19 Mar 2021 00:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uJutC8Ri/9ULr8T6if+RUhZN4gtxJUpKjWaVDX0XkB4=;
        b=TCN6rVhvySN3I0CrD6CpzR1NezjHr/1OZtpFv414OJXtiHhEVzyr1eLknl+arIcEUm
         Lmjq0GuTx/eGF6tXryuhqhCyDHtdJBTxaQEWAOEIas5CaDdis+ELScwIFbjLRIfSEOKw
         YgNdm2hwKSjxCVmcWoYoZLsnhbK1OXnF430k2Qe8GI/l4UxqniCHcsIG4istYlZz2zb3
         2ynZt0QXFYUGiBTnH060SF7AcGHKj+K7vqTh7Zh8LQhHJzaVD39GNAC97Diutry8ikPz
         KOqmm9a09rFThykzWgIv8LsHpsK9GUZLf3H7gEX+Yvmiigu5sQtg3nZBRI2DKJlLbPMb
         tBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uJutC8Ri/9ULr8T6if+RUhZN4gtxJUpKjWaVDX0XkB4=;
        b=EDn6RQqSw54u0nfuEqV5HnzVmhWb63l/cI7O10MAxmd01lW2+L9+VWDXl77+aR5IG5
         MQ2uZ8HESy247XEjJqrjz74kLR6lCzqGJYqaF8fOU4fQs9EasKytcSjzOZmQiEKO85Bc
         v9wjlDugFSC8m6BEkmt0cFu0bhnEeYfp6ZYuLLYp+1/RllpBt6BSfMvbrazHhU3py471
         pQSy6W8j9r4PhQSB5UcXv1ktPjQyE3xdDgvzgdcrTHI+CA+FKax3caxJnb8Nnmj4pDSB
         SpEXEjw0IukCuBERNbBY6NCAVXfdbqr5j4y7k7iyjvDMeAmw3XN8LGDyFAxmwZJ7zcB/
         6GJQ==
X-Gm-Message-State: AOAM531Cq5dneMBiZ8gzHskxGnJElLWCKgozMSUQAmqoARdZNjvnecWp
        XfXIqm/vYsoqVsRxlkD4oMQI41rXLrT1NexaKbhwLjkOH7RhCQ==
X-Google-Smtp-Source: ABdhPJxmX4NPVmOS0dGKEAARVBTF9LhmJZ3B5PEFY4Dw7k6nPXiJrc+WyPhVl6Ih26lPtZY6MoWAUh4wn+Syb0V8p+o=
X-Received: by 2002:a17:906:2504:: with SMTP id i4mr2887426ejb.115.1616139880336;
 Fri, 19 Mar 2021 00:44:40 -0700 (PDT)
MIME-Version: 1.0
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 19 Mar 2021 08:44:29 +0100
Message-ID: <CAMGffE=3YYxv9i7_qQr3-Uv-NGr-7VsnMk8DTjR0YbX1vJBzXQ@mail.gmail.com>
Subject: IPoIB child interfaces not working with mlx5
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason and Leon,

We recently switch to use upstream OFED from MLNX-OFED, and we notice
IPoIB stop working with upstream kernel 5.4.102 with mellanox CX-5
HCA, it's working fine on CX-2/CX-3. I tested also on 5.11 kernel it
behaves the same.

The symptoms are ipoib child interfaces are UP and ready, but ping
doens't work at all, simple ifdown/ifup the child interface doens't
change anything.
Workaround is bring up the parent interface "ip link set ib0 up"

basic config from "ip a"
jwang@ps401a-914.nst:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
group default qlen 1000
    link/ether 0c:c4:7a:ff:07:d0 brd ff:ff:ff:ff:ff:ff
    inet 10.41.3.146/22 brd 10.41.3.255 scope global eth0
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group
default qlen 1000
    link/ether 0c:c4:7a:ff:07:d1 brd ff:ff:ff:ff:ff:ff
4: ib0: <BROADCAST,MULTICAST> mtu 4092 qdisc noop state DOWN group
default qlen 1024
    link/infiniband
00:00:11:07:fe:80:00:00:00:00:00:00:98:03:9b:03:00:66:de:52 brd
00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff
5: ib1: <BROADCAST,MULTICAST> mtu 4092 qdisc noop state DOWN group
default qlen 1024
    link/infiniband
00:00:19:07:fe:80:00:00:00:00:00:00:98:03:9b:03:00:66:de:53 brd
00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff
6: ib0.beef@ib0: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 4092
qdisc mq state UP group default qlen 1024
    link/infiniband
00:00:11:4b:fe:80:00:00:00:00:00:00:98:03:9b:03:00:66:de:52 brd
00:ff:ff:ff:ff:12:40:1b:be:ef:00:00:00:00:00:00:ff:ff:ff:ff
    inet 10.42.3.146/20 brd 10.42.15.255 scope global ib0.beef
       valid_lft forever preferred_lft forever
    inet6 fe80::9a03:9b03:66:de52/64 scope link
       valid_lft forever preferred_lft forever
7: ib0.dddd@ib0: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 4092
qdisc mq state UP group default qlen 1024
    link/infiniband
00:00:12:87:fe:80:00:00:00:00:00:00:98:03:9b:03:00:66:de:52 brd
00:ff:ff:ff:ff:12:40:1b:dd:dd:00:00:00:00:00:00:ff:ff:ff:ff
    inet6 2a02:247f:401:1:2:0:a:392/64 scope global
       valid_lft forever preferred_lft forever
    inet6 fe80::9a03:9b03:66:de52/64 scope link
       valid_lft forever preferred_lft forever
8: ib1.beef@ib1: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 4092
qdisc mq state UP group default qlen 1024
    link/infiniband
00:00:19:4b:fe:80:00:00:00:00:00:00:98:03:9b:03:00:66:de:53 brd
00:ff:ff:ff:ff:12:40:1b:be:ef:00:00:00:00:00:00:ff:ff:ff:ff
    inet 10.43.3.146/20 brd 10.43.15.255 scope global ib1.beef
       valid_lft forever preferred_lft forever
    inet6 fe80::9a03:9b03:66:de53/64 scope link
       valid_lft forever preferred_lft forever
9: ib1.dddd@ib1: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 4092
qdisc mq state UP group default qlen 1024
    link/infiniband
00:00:1a:87:fe:80:00:00:00:00:00:00:98:03:9b:03:00:66:de:53 brd
00:ff:ff:ff:ff:12:40:1b:dd:dd:00:00:00:00:00:00:ff:ff:ff:ff
    inet6 2a02:247f:402:1:2:0:a:392/64 scope global
       valid_lft forever preferred_lft forever
    inet6 fe80::9a03:9b03:66:de53/64 scope link
       valid_lft forever preferred_lft forever

jwang@ps401a-914.nst:~$ dmesg | egrep 'mlx|ib'
[    0.000000] Command line:
BOOT_IMAGE=3D(http)/live-images/liveboot-2021.76/vmlinuz
BOOTIF=3D0c:c4:7a:ff:07:d0 boot=3Dlive
fetch=3Dhttp://mgmt/live-images/liveboot-2021.76/root.squashfs
consoleblank=3D0 PHASE=3DTesting crashkernel=3D512M quiet
salt-master=3Dsalt-master.stg.profitbricks.net saltenv=3Dbase
pillarenv=3Dbase ib_ipoib.debug_level=3D1 liveboot.sdn2
[    0.889525] Kernel command line:
BOOT_IMAGE=3D(http)/live-images/liveboot-2021.76/vmlinuz
BOOTIF=3D0c:c4:7a:ff:07:d0 boot=3Dlive
fetch=3Dhttp://mgmt/live-images/liveboot-2021.76/root.squashfs
consoleblank=3D0 PHASE=3DTesting crashkernel=3D512M quiet
salt-master=3Dsalt-master.stg.profitbricks.net saltenv=3Dbase
pillarenv=3Dbase ib_ipoib.debug_level=3D1 liveboot.sdn2
[    1.997444] Calibrating delay loop (skipped), value calculated
using timer frequency.. 4200.00 BogoMIPS (lpj=3D21000000)
[    2.422119] MDS CPU bug present and SMT on, data leak possible. See
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html
for more details.
[    2.422119] TAA CPU bug present and SMT on, data leak possible. See
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.=
html
for more details.
[    2.992059] pci_bus 0000:03: extended config space not accessible
[    3.024991] pci 0000:03:00.0: vgaarb: bridge control possible
[    5.287548] tsc: Refined TSC clocksource calibration: 2099.999 MHz
[   16.839146] systemd[1]: File
/lib/systemd/system/systemd-journald.service:12 configures an IP
firewall (IPAddressDeny=3Dany), but the local system does not support
BPF/cgroup based firewalling.
[   16.874155] systemd[1]:
/lib/systemd/system/tap-offloads-trk.service:10: PIDFile=3D references
path below legacy directory /var/run/, updating
/var/run/tap-offloads-trk.pid =E2=86=92 /run/tap-offloads-trk.pid; please
update the unit file accordingly.
[   16.893383] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   23.244067] mlx5_core 0000:af:00.0: firmware version: 16.27.2008
[   23.244103] mlx5_core 0000:af:00.0: 126.016 Gb/s available PCIe
bandwidth (8.0 GT/s PCIe x16 link)
[   23.274277] libata version 3.00 loaded.
[   23.555901] mlx5_core 0000:af:00.0: Port module event: module 0,
Cable plugged
[   23.556314] mlx5_core 0000:af:00.0: mlx5_pcie_event:296:(pid 7):
PCIe slot advertised sufficient power (75W).
[   23.573895] mlx5_core 0000:af:00.1: firmware version: 16.27.2008
[   23.573950] mlx5_core 0000:af:00.1: 126.016 Gb/s available PCIe
bandwidth (8.0 GT/s PCIe x16 link)
[   23.885989] mlx5_core 0000:af:00.1: Port module event: module 1,
Cable plugged
[   23.886133] mlx5_core 0000:af:00.1: mlx5_pcie_event:296:(pid 3256):
PCIe slot advertised sufficient power (75W).
[   27.924069] mlx5_core 0000:af:00.0: MLX5E: StrdRq(0) RqSz(1024)
StrdSz(256) RxCqeCmprss(0)
[   27.924076] mlx5_core 0000:af:00.0: MLX5E: StrdRq(0) RqSz(1024)
StrdSz(256) RxCqeCmprss(0)
[   27.999211] ib0: Not flushing - IPOIB_FLAG_ADMIN_UP not set.
[   28.000387] mlx5_core 0000:af:00.1: MLX5E: StrdRq(0) RqSz(1024)
StrdSz(256) RxCqeCmprss(0)
[   28.000393] mlx5_core 0000:af:00.1: MLX5E: StrdRq(0) RqSz(1024)
StrdSz(256) RxCqeCmprss(0)
[   28.086111] ib1: Not flushing - IPOIB_FLAG_ADMIN_UP not set.
[   29.415045] ib0: Event 12 on device mlx5_0 port 1
[   29.415147] ib0: Not flushing - IPOIB_FLAG_ADMIN_UP not set.
[   29.415661] ib0: Event 12 on device mlx5_0 port 1
[   29.415742] ib0: Not flushing - IPOIB_FLAG_ADMIN_UP not set.
[   29.416497] ib0: Event 12 on device mlx5_0 port 1
[   29.416591] ib0: Not flushing - IPOIB_FLAG_ADMIN_UP not set.
[   29.419656] ib0: Event 17 on device mlx5_0 port 1
[   29.419669] ib0: Not flushing - IPOIB_FLAG_INITIALIZED not set.
[   29.420226] ib0: Event 11 on device mlx5_0 port 1
[   29.420240] ib0: Not flushing - IPOIB_FLAG_INITIALIZED not set.
[   29.420257] ib1: Event 12 on device mlx5_1 port 1
[   29.420317] ib1: Not flushing - IPOIB_FLAG_ADMIN_UP not set.
[   29.420840] ib1: Event 12 on device mlx5_1 port 1
[   29.420898] ib1: Not flushing - IPOIB_FLAG_ADMIN_UP not set.
[   29.421190] ib1: Event 12 on device mlx5_1 port 1
[   29.421247] ib1: Not flushing - IPOIB_FLAG_ADMIN_UP not set.
[   29.421632] ib1: Event 11 on device mlx5_1 port 1
[   29.421640] ib1: Not flushing - IPOIB_FLAG_INITIALIZED not set.
[   29.422261] ib1: Event 17 on device mlx5_1 port 1
[   29.422276] ib1: Not flushing - IPOIB_FLAG_INITIALIZED not set.
[   29.749430] ib0: Event 9 on device mlx5_0 port 1
[   29.749441] ib0: Not flushing - IPOIB_FLAG_INITIALIZED not set.
[   29.751349] ib1: Event 9 on device mlx5_1 port 1
[   29.751365] ib1: Not flushing - IPOIB_FLAG_INITIALIZED not set.
[   46.707421] mlx5_core 0000:af:00.0: MLX5E: StrdRq(0) RqSz(1024)
StrdSz(256) RxCqeCmprss(0)
[   46.707434] mlx5_core 0000:af:00.0: MLX5E: StrdRq(0) RqSz(1024)
StrdSz(256) RxCqeCmprss(0)
[   46.725944] ib0.beef: bringing up interface
[   46.968005] ib0.beef: Created ah 00000000cb29051b
[   47.000529] IPv6: ADDRCONF(NETDEV_CHANGE): ib0.beef: link becomes ready
[   47.004101] ib0.beef: Created ah 000000001338d4ae
[   47.007399] ib0.beef: Created ah 000000002947be1d
[   47.010668] ib0.beef: Created ah 00000000a8586948
[   47.013871] ib0.beef: Created ah 00000000e584ea42
[   47.033747] ib0.beef: Created ah 0000000086cb1ff9
[   47.189454] mlx5_core 0000:af:00.0: MLX5E: StrdRq(0) RqSz(1024)
StrdSz(256) RxCqeCmprss(0)
[   47.189465] mlx5_core 0000:af:00.0: MLX5E: StrdRq(0) RqSz(1024)
StrdSz(256) RxCqeCmprss(0)
[   47.215051] ib0.dddd: bringing up interface
[   47.457634] ib0.dddd: Created ah 000000009bb41171
[   47.490564] IPv6: ADDRCONF(NETDEV_CHANGE): ib0.dddd: link becomes ready
[   47.494065] ib0.dddd: Created ah 00000000531ff3b3
[   47.497206] ib0.dddd: Created ah 0000000006238049
[   47.500281] ib0.dddd: Created ah 00000000a2776703
[   47.503453] ib0.dddd: Created ah 000000006f839ea0
[   47.506697] ib0.dddd: Created ah 00000000d3218392
[   47.523579] ib0.dddd: Created ah 000000004e8a14c7
[   48.894389] ib0.dddd: Created ah 00000000c664dbd4
[   48.897657] ib0.beef: Created ah 00000000c446a0e6
[   49.593055] mlx5_core 0000:af:00.1: MLX5E: StrdRq(0) RqSz(1024)
StrdSz(256) RxCqeCmprss(0)
[   49.593064] mlx5_core 0000:af:00.1: MLX5E: StrdRq(0) RqSz(1024)
StrdSz(256) RxCqeCmprss(0)
[   49.610051] ib1.beef: bringing up interface
[   49.857979] ib1.beef: Created ah 000000003571492a
[   49.890521] IPv6: ADDRCONF(NETDEV_CHANGE): ib1.beef: link becomes ready
[   49.893951] ib1.beef: Created ah 00000000aea98452
[   49.897011] ib1.beef: Created ah 000000004e23c357
[   49.899995] ib1.beef: Created ah 00000000ed62df50
[   49.903036] ib1.beef: Created ah 0000000041605d6d
[   49.915754] mlx5_core 0000:af:00.1: MLX5E: StrdRq(0) RqSz(1024)
StrdSz(256) RxCqeCmprss(0)
[   49.915765] mlx5_core 0000:af:00.1: MLX5E: StrdRq(0) RqSz(1024)
StrdSz(256) RxCqeCmprss(0)
[   49.923955] ib1.beef: Created ah 00000000f5d6b457
[   49.943153] ib1.dddd: bringing up interface
[   50.187608] ib1.dddd: Created ah 00000000cebeba47
[   50.220523] IPv6: ADDRCONF(NETDEV_CHANGE): ib1.dddd: link becomes ready
[   50.224347] ib1.dddd: Created ah 00000000c6f96f11
[   50.227539] ib1.dddd: Created ah 000000004fe70418
[   50.230691] ib1.dddd: Created ah 00000000ae96df99
[   50.233810] ib1.dddd: Created ah 000000004af47f93
[   50.236892] ib1.dddd: Created ah 0000000064aca082
[   50.264221] ib1.dddd: Created ah 00000000f330012e
[   51.774399] ib1.beef: Created ah 000000007f1ef527
[   52.094689] ib1.dddd: Created ah 00000000210b80b4
[   57.215935] ib0.dddd: Created ah 00000000f07b9547
[   57.216368] ib1.beef: Created ah 00000000f3a87dc7
[   57.219420] ib1.beef: Created ah 00000000b7d4d592
[   57.225647] ib0.beef: Created ah 00000000e65557a4
[   57.228334] ib1.dddd: Created ah 000000001914b301
[   57.228819] ib0.beef: Created ah 0000000070b21f1c
[   57.264003] ib1.beef: Created ah 0000000070b3a6e8
[   57.264079] ib0.beef: Created ah 00000000be1feac1,
[  137.514460] ib0.beef: neigh free for ffffff
ff12:601b:beef:0000:0000:0001:ff66:de52
[  137.514461] ib0.dddd: neigh free for ffffff
ff12:601b:dddd:0000:0000:0001:ff0a:0392
[  137.514471] ib0.dddd: neigh free for ffffff
ff12:601b:dddd:0000:0000:0001:ff66:de52
[  137.514473] ib0.beef: neigh free for ffffff
ff12:401b:beef:0000:0000:0000:0000:0016
[  137.514477] ib0.dddd: neigh free for ffffff
ff12:601b:dddd:0000:0000:0000:0000:0016
[  137.514478] ib0.beef: neigh free for ffffff
ff12:601b:beef:0000:0000:0000:0000:0016
[  140.074531] ib1.beef: neigh free for ffffff
ff12:401b:beef:0000:0000:0000:0000:0016
[  140.074541] ib1.beef: neigh free for ffffff
ff12:601b:beef:0000:0000:0000:0000:0016
[  140.074545] ib1.beef: neigh free for ffffff
ff12:601b:beef:0000:0000:0001:ff66:de53
[  140.714539] ib1.dddd: neigh free for ffffff
ff12:601b:dddd:0000:0000:0001:ff0a:0392
[  140.714549] ib1.dddd: neigh free for ffffff
ff12:601b:dddd:0000:0000:0000:0000:0016
[  140.714553] ib1.dddd: neigh free for ffffff
ff12:601b:dddd:0000:0000:0001:ff66:de53
[  144.470916] ib0.dddd: Created ah 000000009d40e279
[  177.320655] ib0.dddd: Created ah 0000000023a374d0
[  177.321583] ib1.beef: Created ah 00000000b54aadfc
[  177.324385] ib0.beef: Created ah 00000000f4507818
[  177.325263] ib1.beef: Created ah 00000000132b48ff
[  177.328056] ib0.beef: Created ah 000000004e093b7c
[  177.328715] ib1.dddd: Created ah 00000000b274652f
[  177.358792] ib0.beef: Created ah 0000000076e40813
[  177.358863] ib1.dddd: Created ah 00000000146f0ae3
[  177.361796] ib1.beef: Created ah 00000000d7c8cff5
[  177.362033] ib0.beef: Created ah 0000000086031b72
[  177.365082] ib0.dddd: Created ah 0000000083e723db
[  177.365086] ib1.beef: Created ah 0000000029b2b4cb
[  200.215825] ib1.beef: neigh free for ffffff
ff12:401b:beef:0000:0000:0000:ffff:ffff

I suspect it might be related to change in this patchset:
https://lore.kernel.org/linux-rdma/20180729083500.5352-1-leon@kernel.org/

Is this expected behavor? how can we fix it?

Thanks!
--=20
Jinpu Wang
