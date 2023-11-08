Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90987E5E21
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Nov 2023 20:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjKHTFN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Nov 2023 14:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjKHTE7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Nov 2023 14:04:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B862704
        for <linux-rdma@vger.kernel.org>; Wed,  8 Nov 2023 11:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699470133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/rtUa47sSQu1su2O/M92kNNh1Ip53b6a5CFJU1V2CsY=;
        b=DFYFglFN0LCCPor9Y8afFY1yytQZ+hXydeFvvqjl7gA2i/4KtrQmO6bNwa6N8zPxCj6EIV
        PeHOM7zDe4cDn46q+OSnhzY5nRi5lAHtfV21SZrAzr/3GagihevcxM6N8mWSW62VHy8egT
        rrJqnci07aPeRkjW3GHvy5iuxqGizRA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-DFqoN-J2OV2VMEB4Ig_yeg-1; Wed, 08 Nov 2023 14:02:10 -0500
X-MC-Unique: DFqoN-J2OV2VMEB4Ig_yeg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7789a691086so2209885a.0
        for <linux-rdma@vger.kernel.org>; Wed, 08 Nov 2023 11:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470129; x=1700074929;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rtUa47sSQu1su2O/M92kNNh1Ip53b6a5CFJU1V2CsY=;
        b=apLyqHhx1ldrFaw27B5Y5j+hZGHYfEUWV4e2TNCA8KvNznyFL6KljjNHLKKO3ycc4P
         ke6ZoyliplpxQGHNMALOPHFpcDieFk4LYPumra5WSVqeH2r5jaXoPIjzFQEXhhbFhT5H
         VEqHVSTytJPpZoBzrddaEVLZDapqQ0/XGblR+NVyWIV7yXM2DlJJKON7gcfZx32urX0i
         Psdwy1p/jAOc1gZ37H3CFrN6kwtijBC2YMYEt4+W+LtqalhVQw4/K2wC2JQgiP9Gr6vw
         yX+XkNrUJUSrE+h0CXEUkz/hUuVDqdttqK17STt4225txzWnyLC47y/AkA8L7n+oBsu/
         B85Q==
X-Gm-Message-State: AOJu0YyiHSriZLcErjn4LDf8yXGZ0MWct4y+VNQ+c46FrIQT25loRWnr
        n/UrqMFrbgFZyHbaXc3jj6WklAYTimP24i8CBF8GDHdxpSlST6ujpPVg3M31KTy67sG15f3s4JU
        7YHa7DK9iSOhwU9668Q47uZve26p4QkJl1KHxKDPyuiXntpEdPxbVs1WJ1HhgIHNquitwFf7YTO
        N8LSY+Zg==
X-Received: by 2002:a05:620a:c46:b0:77a:7e91:45e7 with SMTP id u6-20020a05620a0c4600b0077a7e9145e7mr2743095qki.34.1699470129078;
        Wed, 08 Nov 2023 11:02:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPA7S99VLqrfI46sSXIIF2qO7IOgE8qKha4acF7r9+xHJPqjSAHxqCgVmZi16+A/VhqyaBgg==
X-Received: by 2002:a05:620a:c46:b0:77a:7e91:45e7 with SMTP id u6-20020a05620a0c4600b0077a7e9145e7mr2743052qki.34.1699470128477;
        Wed, 08 Nov 2023 11:02:08 -0800 (PST)
Received: from ?IPv6:2600:6c64:4e7f:603b:2613:173:a68a:fce8? ([2600:6c64:4e7f:603b:2613:173:a68a:fce8])
        by smtp.gmail.com with ESMTPSA id cx17-20020a05620a51d100b0077580becd52sm1332396qkb.103.2023.11.08.11.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:02:08 -0800 (PST)
Message-ID: <475a37e920badad12a0d71fff65e817979417594.camel@redhat.com>
Subject: Mellanox CX6 and nvmet connectivity failure, happens on RHEL9.2
 kernels and latest 6.6 upstream
From:   Laurence Oberman <loberman@redhat.com>
To:     linux-rdma <linux-rdma@vger.kernel.org>,
        "busch, keith" <keith.busch@intel.com>
Date:   Wed, 08 Nov 2023 14:02:07 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello

Long message as it has supporting data so apologies up front.=20
With CX3 and mlx4 I have no issues with this working,  but Dell and Red
Hat see issues with CX6 adapters.

I cannot see what I am doing wrong as the identical test works with
CX3.


I get this sequence
I see the kato expire and the controller is torn down

Target
[  162.276501] nvmet: adding nsid 1 to subsystem nqn.2023-10.org.dell
[  162.340724] nvmet_rdma: enabling port 1 (172.18.60.2:4420)
[  304.742924] nvmet: creating nvm controller 1 for subsystem nqn.2023-
10.org.dell for NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0034-5310-
8057-b1c04f355333.
[  315.060743] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[  315.066667] nvmet: ctrl 1 fatal error occurred!
[  320.344443] nvmet: could not find controller 1 for subsys nqn.2023-
10.org.dell / host nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0034-5310-
8057-b1c04f355333

Initiator

[root@rhel-storage-103 ~]# nvme connect -t rdma -n nqn.2023-10.org.dell
-a 172.18.60.2  -s 4420

no controller found: failed to write to nvme-fabrics device

[  270.946125] nvme nvme4: creating 80 I/O queues.
[  286.530761] nvme nvme4: mapped 80/0/0 default/read/poll queues.
[  286.547112] nvme nvme4: Connect Invalid Data Parameter, cntlid: 1
[  286.555181] nvme nvme4: failed to connect queue: 1 ret=3D16770

so TLDR but here are the gory details

Supporting Data
----------------
Working setup, kernel is a kernel with=20

commit 4cde03d82e2d0056d20fd5af6a264c7f5e6a3e76
Author: Daniel Wagner <dwagner@suse.de>
Date:   Fri Jul 29 16:26:30 2022 +0200

    nvme: consider also host_iface when checking ip options


I tested with both IB RDMA and Ethernet, both work
Currently configured for Ethernet


Target

[root@dl580 ~]# lspci | grep -i mell
8a:00.0 Ethernet controller: Mellanox Technologies MT27500 Family
[ConnectX-3]

[root@dl580 ~]# uname -a
Linux dl580 5.14.0-284.25.1.nvmefix.el9.x86_64=20

ens4: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.0.2  netmask 255.255.255.0  broadcast 10.0.0.255
        ether f4:52:14:86:49:41  txqueuelen 1000  (Ethernet)
        RX packets 17  bytes 5610 (5.4 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 8  bytes 852 (852.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens4d1: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.1.0.2  netmask 255.255.255.0  broadcast 10.1.0.255
        ether f4:52:14:86:49:42  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 8  bytes 852 (852.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0


root@dl580 ~]# ibstat
CA 'mlx4_0'
	CA type: MT4099
	Number of ports: 2
	Firmware version: 2.42.5000
	Hardware version: 1
	Node GUID: 0xf452140300864940
	System image GUID: 0xf452140300864943
	Port 1:
		State: Active
		Physical state: LinkUp
		Rate: 10
		Base lid: 0
		LMC: 0
		SM lid: 0
		Capability mask: 0x00010000
		Port GUID: 0xf65214fffe864941
		Link layer: Ethernet
	Port 2:
		State: Active
		Physical state: LinkUp
		Rate: 10
		Base lid: 0
		LMC: 0
		SM lid: 0
		Capability mask: 0x00010000
		Port GUID: 0xf65214fffe864942
		Link layer: Ethernet


Initiator

[root@dl380rhel9 ~]# lspci | grep -i mell
08:00.0 Ethernet controller: Mellanox Technologies MT27500 Family
[ConnectX-3]

Linux dl380rhel9 5.14.0-284.25.1.nvmefix.el9.x86_64

ens1: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.0.1  netmask 255.255.255.0  broadcast 10.0.0.255
        ether f4:52:14:67:6b:a1  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 56  bytes 9376 (9.1 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens1d1: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.1.0.1  netmask 255.255.255.0  broadcast 10.1.0.255
        ether f4:52:14:67:6b:a2  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0


[root@dl380rhel9 ~]# ibstat
CA 'mlx4_0'
	CA type: MT4099
	Number of ports: 2
	Firmware version: 2.42.5000
	Hardware version: 1
	Node GUID: 0xf452140300676ba0
	System image GUID: 0xf452140300676ba3
	Port 1:
		State: Active
		Physical state: LinkUp
		Rate: 10
		Base lid: 0
		LMC: 0
		SM lid: 0
		Capability mask: 0x00010000
		Port GUID: 0xf65214fffe676ba1
		Link layer: Ethernet
	Port 2:
		State: Active
		Physical state: LinkUp
		Rate: 10
		Base lid: 0
		LMC: 0
		SM lid: 0
		Capability mask: 0x00010000
		Port GUID: 0xf65214fffe676ba2
		Link layer: Ethernet


The Test is the same test failing in Red Hat lab on CX6 but working on
CX3.


Run this script on target, advertising on IP 10.1.0.2

[root@dl580 ~]# cat new_start_nvme_target.sh=20
#!/bin/bash
modprobe nvmet
modprobe nvme-fc
mkdir /sys/kernel/config/nvmet/subsystems/nqn.2023-10.org.dell
cd /sys/kernel/config/nvmet/subsystems/nqn.2023-10.org.dell
echo 1 > attr_allow_any_host
mkdir namespaces/1
cd namespaces/1
echo -n /dev/nvme0n1> device_path
echo 1 > enable
cd
mkdir /sys/kernel/config/nvmet/ports/1
cd /sys/kernel/config/nvmet/ports/1
echo 10.1.0.2 > addr_traddr
echo rdma > addr_trtype
echo 4420 > addr_trsvcid
echo ipv4 > addr_adrfam
ln -s /sys/kernel/config/nvmet/subsystems/nqn.2023-10.org.dell/
/sys/kernel/config/nvmet/ports/1/subsystems/nqn.2023-10.org.dell


On initiator run=20

modprobe nvme-fc
nvme connect -t rdma -n nqn.2023-10.org.dell -a 10.1.0.2 -s 4420



Results - Red Hat LAB CX3 mlx4

Target
[  626.630914] nvmet: adding nsid 1 to subsystem nqn.2023-10.org.dell
[  626.654567] nvmet_rdma: enabling port 1 (10.1.0.2:4420)
[  685.041034] nvmet: creating nvm controller 1 for subsystem nqn.2023-
10.org.dell for NQN nqn.2014-08.org.nvmexpress:uuid:34333336-3530-4d32-
3232-303730304a36.

Initiator

[  696.864671] nvme nvme0: creating 24 I/O queues.
[  697.370447] nvme nvme0: mapped 24/0/0 default/read/poll queues.
[  697.526386] nvme nvme0: new ctrl: NQN "nqn.2023-10.org.dell", addr
10.1.0.2:4420

[root@dl380rhel9 ~]# nvme list
Node                  Generic               SN                   Model
Namespace Usage                      Format           FW Rev =20
--------------------- --------------------- -------------------- ------
---------------------------------- --------- --------------------------
---------------- --------
/dev/nvme0n1          /dev/ng0n1            71cf88c9fd26d64268e2 Linux
1         500.11  GB / 500.11  GB    512   B +  0 B   5.14.0-2


All good=20


Now Red Hat LAB with upstream 6.6 kernel
-----------------------------------------

Here is latest upstream



Target config

Linux rhel-storage-105.storage.lab.eng.bos.redhat.com 6.6.0+ #2 SMP
PREEMPT_DYNAMIC Wed Nov  8 09:53:23 EST 2023 x86_64 x86_64 x86_64
GNU/Linux

[root@rhel-storage-105 ~]# ibstat
CA 'mlx5_0'
	CA type: MT4119
	Number of ports: 1
	Firmware version: 16.35.1012
	Hardware version: 0
	Node GUID: 0xe8ebd30300558946
	System image GUID: 0xe8ebd30300558946
	Port 1:
		State: Active
		Physical state: LinkUp
		Rate: 25
		Base lid: 0
		LMC: 0
		SM lid: 0
		Capability mask: 0x00010000
		Port GUID: 0xeaebd3fffe558946
		Link layer: Ethernet
CA 'mlx5_1'
	CA type: MT4119
	Number of ports: 1
	Firmware version: 16.35.1012
	Hardware version: 0
	Node GUID: 0xe8ebd30300558947
	System image GUID: 0xe8ebd30300558946
	Port 1:
		State: Active
		Physical state: LinkUp
		Rate: 25
		Base lid: 0
		LMC: 0
		SM lid: 0
		Capability mask: 0x00010000
		Port GUID: 0xeaebd3fffe558947
		Link layer: Ethernet
CA 'mlx5_2'
	CA type: MT4125
	Number of ports: 1
	Firmware version: 22.36.1010
	Hardware version: 0
	Node GUID: 0x946dae0300d05002
	System image GUID: 0x946dae0300d05002
	Port 1:
		State: Active
		Physical state: LinkUp
		Rate: 100
		Base lid: 0
		LMC: 0
		SM lid: 0
		Capability mask: 0x00010000
		Port GUID: 0x966daefffed05002
		Link layer: Ethernet
CA 'mlx5_3'
	CA type: MT4125
	Number of ports: 1
	Firmware version: 22.36.1010
	Hardware version: 0
	Node GUID: 0x946dae0300d05003
	System image GUID: 0x946dae0300d05002
	Port 1:
		State: Active
		Physical state: LinkUp
		Rate: 100
		Base lid: 0
		LMC: 0
		SM lid: 0
		Capability mask: 0x00010000
		Port GUID: 0x966daefffed05003
		Link layer: Ethernet


Initiator config

Linux rhel-storage-103.storage.lab.eng.bos.redhat.com 6.6.0+ #2 SMP
PREEMPT_DYNAMIC Wed Nov  8 09:53:23 EST 2023 x86_64 x86_64 x86_64
GNU/Linux


I decided to disable qla2xxx from loading in both


root@rhel-storage-103 ~]# ibstat
CA 'mlx5_0'
	CA type: MT4119
	Number of ports: 1
	Firmware version: 16.32.2004
	Hardware version: 0
	Node GUID: 0xe8ebd303003a1d0c
	System image GUID: 0xe8ebd303003a1d0c
	Port 1:
		State: Active
		Physical state: LinkUp
		Rate: 25
		Base lid: 0
		LMC: 0
		SM lid: 0
		Capability mask: 0x00010000
		Port GUID: 0xeaebd3fffe3a1d0c
		Link layer: Ethernet
CA 'mlx5_1'
	CA type: MT4119
	Number of ports: 1
	Firmware version: 16.32.2004
	Hardware version: 0
	Node GUID: 0xe8ebd303003a1d0d
	System image GUID: 0xe8ebd303003a1d0c
	Port 1:
		State: Active
		Physical state: LinkUp
		Rate: 25
		Base lid: 0
		LMC: 0
		SM lid: 0
		Capability mask: 0x00010000
		Port GUID: 0xeaebd3fffe3a1d0d
		Link layer: Ethernet
CA 'mlx5_2'
	CA type: MT4125
	Number of ports: 1
	Firmware version: 22.36.1010
	Hardware version: 0
	Node GUID: 0x946dae0300d06d72
	System image GUID: 0x946dae0300d06d72
	Port 1:
		State: Active
		Physical state: LinkUp
		Rate: 100
		Base lid: 0
		LMC: 0
		SM lid: 0
		Capability mask: 0x00010000
		Port GUID: 0x966daefffed06d72
		Link layer: Ethernet
CA 'mlx5_3'
	CA type: MT4125
	Number of ports: 1
	Firmware version: 22.36.1010
	Hardware version: 0
	Node GUID: 0x946dae0300d06d73
	System image GUID: 0x946dae0300d06d72
	Port 1:
		State: Active
		Physical state: LinkUp
		Rate: 100
		Base lid: 0
		LMC: 0
		SM lid: 0
		Capability mask: 0x00010000
		Port GUID: 0x966daefffed06d73
		Link layer: Ethernet



Test

Target

#!/bin/bash
modprobe nvmet
modprobe nvme-fc
mkdir /sys/kernel/config/nvmet/subsystems/nqn.2023-10.org.dell
cd /sys/kernel/config/nvmet/subsystems/nqn.2023-10.org.dell
echo 1 > attr_allow_any_host
mkdir namespaces/1
cd namespaces/1
echo -n /dev/nvme0n1> device_path
echo 1 > enable
cd
mkdir /sys/kernel/config/nvmet/ports/1
cd /sys/kernel/config/nvmet/ports/1
echo 172.18.60.2 > addr_traddr
echo rdma > addr_trtype
echo 4420 > addr_trsvcid
echo ipv4 > addr_adrfam
ln -s /sys/kernel/config/nvmet/subsystems/nqn.2023-10.org.dell/
/sys/kernel/config/nvmet/ports/1/subsystems/nqn.2023-10.org.dell



[  162.276501] nvmet: adding nsid 1 to subsystem nqn.2023-10.org.dell
[  162.340724] nvmet_rdma: enabling port 1 (172.18.60.2:4420)
[  304.742924] nvmet: creating nvm controller 1 for subsystem nqn.2023-
10.org.dell for NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0034-5310-
8057-b1c04f355333.
[  315.060743] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
[  315.066667] nvmet: ctrl 1 fatal error occurred!
[  320.344443] nvmet: could not find controller 1 for subsys nqn.2023-
10.org.dell / host nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0034-5310-
8057-b1c04f355333


Initiator

Has some local NVME already

Node                  Generic               SN                   Model
Namespace Usage                      Format           FW Rev =20
--------------------- --------------------- -------------------- ------
---------------------------------- --------- --------------------------
---------------- --------
/dev/nvme3n1          /dev/ng3n1            72F0A021TC88         Dell
Ent NVMe CM6 MU 1.6TB               1           2.14  GB /   1.60  TB=20
512   B +  0 B   2.1.8  =20
/dev/nvme2n1          /dev/ng2n1            72F0A02CTC88         Dell
Ent NVMe CM6 MU 1.6TB               1           2.27  MB /   1.60  TB=20
512   B +  0 B   2.1.8  =20
/dev/nvme1n1          /dev/ng1n1            72F0A01DTC88         Dell
Ent NVMe CM6 MU 1.6TB               1         544.21  MB /   1.60  TB=20
512   B +  0 B   2.1.8  =20
/dev/nvme0n1          /dev/ng0n1            72F0A019TC88         Dell
Ent NVMe CM6 MU 1.6TB               1          33.77  GB /   1.60  TB=20
512   B +  0 B   2.1.8  =20

[root@rhel-storage-103 ~]# modprobe nvme-fc
[root@rhel-storage-103 ~]# nvme connect -t rdma -n nqn.2023-10.org.dell
-a  172.18.60.2  -s 4420

no controller found: failed to write to nvme-fabrics device

[  270.946125] nvme nvme4: creating 80 I/O queues.
[  286.530761] nvme nvme4: mapped 80/0/0 default/read/poll queues.
[  286.547112] nvme nvme4: Connect Invalid Data Parameter, cntlid: 1
[  286.555181] nvme nvme4: failed to connect queue: 1 ret=3D16770

