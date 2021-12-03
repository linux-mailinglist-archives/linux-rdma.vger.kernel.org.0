Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E07467656
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Dec 2021 12:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhLCLay (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Dec 2021 06:30:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232921AbhLCLav (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Dec 2021 06:30:51 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B39Llnf030635
        for <linux-rdma@vger.kernel.org>; Fri, 3 Dec 2021 11:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : message-id : content-transfer-encoding :
 content-type : mime-version : references; s=pp1;
 bh=m+ETaXwrAU+1+TnLmG9MtJOh6AC0RzEuZyTTqJlHL8Q=;
 b=FfaAtt7d5nCdRKqb72IWYkiRCWGiatEacgrA1Ersx9SRI5JxRMCN9EKoLdsFcYVogJnd
 2JWikcnDN3wZn1klcRZq8jsI6WqvqjeocB/mdMw8MDpr728JG/8PnzeJPp9ocWfH0S9c
 KPzFQU4eyEXZKHa7GBeuIcBU2XMrHsvTWM5yZyXf7Zti9NysdqU8kkgcXdpkHnq+jKvP
 synqbWySJ/55rAY2YcIBPcvF7zGAMibNCqEiDBYhwWWmA78QUETvokdRyjOa0rvc8gDN
 mzyUQ+f36VNThO+oxdksjKSRDQvEmyn5BfOKUddbW/+QaifoqL7pzITJgBpo+xPhj1im xw== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cqghsj792-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 03 Dec 2021 11:27:26 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B3BNMuX018342
        for <linux-rdma@vger.kernel.org>; Fri, 3 Dec 2021 11:27:25 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma05wdc.us.ibm.com with ESMTP id 3ckcad2jvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 03 Dec 2021 11:27:25 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B3BRO1a48169470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Fri, 3 Dec 2021 11:27:24 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74DA6112061
        for <linux-rdma@vger.kernel.org>; Fri,  3 Dec 2021 11:27:24 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4001D11206E
        for <linux-rdma@vger.kernel.org>; Fri,  3 Dec 2021 11:27:24 +0000 (GMT)
Received: from mww0301.wdc07m.mail.ibm.com (unknown [9.208.64.45])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS
        for <linux-rdma@vger.kernel.org>; Fri,  3 Dec 2021 11:27:24 +0000 (GMT)
In-Reply-To: <CAHj4cs8h3e_fY6cKb3XL9aEp8_MT3Po8-W6cL35kKEAvj6qs0Q@mail.gmail.com>
Subject: Re: [bug report]concurrent blktests nvme-rdma execution lead kernel null
 pointer
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Yi Zhang" <yi.zhang@redhat.com>
Cc:     "RDMA mailing list" <linux-rdma@vger.kernel.org>
Date:   Fri, 3 Dec 2021 11:27:22 +0000
Message-ID: <OF74AE32F7.7A787A6C-ON002587A0.003CDEF3-002587A0.003EEE89@ibm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <CAHj4cs8h3e_fY6cKb3XL9aEp8_MT3Po8-W6cL35kKEAvj6qs0Q@mail.gmail.com>
X-Mailer: Lotus Domino Web Server Release 11.0.1FP2HF117   October 6, 2021
X-MIMETrack: Serialize by http on MWW0301/01/M/IBM at 12/03/2021 11:27:22,Serialize
 complete at 12/03/2021 11:27:22
X-Disclaimed: 27823
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PDyK95pTEfIKYBAZjVd_9GFSHgpW2MAJ
X-Proofpoint-ORIG-GUID: PDyK95pTEfIKYBAZjVd_9GFSHgpW2MAJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_06,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030069
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Yi Zhang" <yi.zhang@redhat.com> wrote: -----

>To: "RDMA mailing list" <linux-rdma@vger.kernel.org>
>From: "Yi Zhang" <yi.zhang@redhat.com>
>Date: 12/03/2021 03:20AM
>Subject: [EXTERNAL] [bug report]concurrent blktests nvme-rdma
>execution lead kernel null pointer
>
>Hello
>With the concurrent blktests nvme-rdma execution with both rdma=5Frxe
>and siw lead kernel BUG on 5.16.0-rc3, pls help check it, thanks.
>

The RDMA core currently does not prevent us from
assigning  both siw and rxe to the same netdev. I think this
is what is happening here. This setting is of no sense, but
obviously not prohibited by the RDMA infrastructure. Behavior
is undefined and a kernel panic not unexpected. Shall we
prevent the privileged user from doing this type of
experiments?

A related question: should we also explicitly refuse to
add software RDMA drivers to netdevs with RDMA hardware active?
This is, while stupid and resulting behavior undefined, currently
possible as well.

Thanks
Bernard.

>Reproducer:
>Run blktests nvme-rdma on two terminal at the same time
>terminal 1:
># use=5Fsiw=3D1 nvme=5Ftrtype=3Drdma ./check nvme/
>terminal 2:
># nvme=5Ftrtype=3Drdma ./check nvme/
>
>[ 1685.584327] run blktests nvme/013 at 2021-12-02 21:08:46
>[ 1685.669804] eno2 speed is unknown, defaulting to 1000
>[ 1685.674866] eno2 speed is unknown, defaulting to 1000
>[ 1685.679941] eno2 speed is unknown, defaulting to 1000
>[ 1685.686033] eno2 speed is unknown, defaulting to 1000
>[ 1685.691087] eno2 speed is unknown, defaulting to 1000
>[ 1685.697677] eno2 speed is unknown, defaulting to 1000
>[ 1685.703727] eno3 speed is unknown, defaulting to 1000
>[ 1685.708798] eno3 speed is unknown, defaulting to 1000
>[ 1685.713863] eno3 speed is unknown, defaulting to 1000
>[ 1685.719965] eno3 speed is unknown, defaulting to 1000
>[ 1685.725043] eno3 speed is unknown, defaulting to 1000
>[ 1685.731688] eno2 speed is unknown, defaulting to 1000
>[ 1685.736763] eno3 speed is unknown, defaulting to 1000
>[ 1685.742818] eno4 speed is unknown, defaulting to 1000
>[ 1685.747881] eno4 speed is unknown, defaulting to 1000
>[ 1685.752949] eno4 speed is unknown, defaulting to 1000
>[ 1685.759134] eno4 speed is unknown, defaulting to 1000
>[ 1685.764195] eno4 speed is unknown, defaulting to 1000
>[ 1685.770914] eno2 speed is unknown, defaulting to 1000
>[ 1685.775980] eno3 speed is unknown, defaulting to 1000
>[ 1685.781047] eno4 speed is unknown, defaulting to 1000
>[ 1686.002801] eno2 speed is unknown, defaulting to 1000
>[ 1686.007867] eno3 speed is unknown, defaulting to 1000
>[ 1686.012934] eno4 speed is unknown, defaulting to 1000
>[ 1686.022521] rdma=5Frxe: rxe-ah pool destroyed with unfree'd elem
>[ 1686.289384] run blktests nvme/013 at 2021-12-02 21:08:46
>[ 1686.356666] eno2 speed is unknown, defaulting to 1000
>[ 1686.361735] eno2 speed is unknown, defaulting to 1000
>[ 1686.366807] eno2 speed is unknown, defaulting to 1000
>[ 1686.371876] eno2 speed is unknown, defaulting to 1000
>[ 1686.378400] eno2 speed is unknown, defaulting to 1000
>[ 1686.384419] eno3 speed is unknown, defaulting to 1000
>[ 1686.389494] eno3 speed is unknown, defaulting to 1000
>[ 1686.394583] eno3 speed is unknown, defaulting to 1000
>[ 1686.399660] eno3 speed is unknown, defaulting to 1000
>[ 1686.406219] eno2 speed is unknown, defaulting to 1000
>[ 1686.411291] eno3 speed is unknown, defaulting to 1000
>[ 1686.417275] eno4 speed is unknown, defaulting to 1000
>[ 1686.422338] eno4 speed is unknown, defaulting to 1000
>[ 1686.427401] eno4 speed is unknown, defaulting to 1000
>[ 1686.432475] eno4 speed is unknown, defaulting to 1000
>[ 1686.439038] eno2 speed is unknown, defaulting to 1000
>[ 1686.444109] eno3 speed is unknown, defaulting to 1000
>[ 1686.449180] eno4 speed is unknown, defaulting to 1000
>[ 1686.873596] xfs filesystem being mounted at /mnt/blktests supports
>timestamps until 2038 (0x7fffffff)
>[ 1687.540606] xfs filesystem being mounted at /mnt/blktests supports
>timestamps until 2038 (0x7fffffff)
>[ 1693.658327] block nvme0n1: no available path - failing I/O
>[ 1693.663038] block nvme0n1: no available path - failing I/O
>[ 1693.663828] XFS (nvme0n1): log I/O error -5
>[ 1693.665024] block nvme0n1: no available path - failing I/O
>[ 1693.665041] XFS (nvme0n1): log I/O error -5
>[ 1693.665044] XFS (nvme0n1): Log I/O Error (0x2) detected at
>xlog=5Fioend=5Fwork+0x71/0x80 [xfs] (fs/xfs/xfs=5Flog.c:1377).  Shutting
>down filesystem.
>[ 1693.665142] XFS (nvme0n1): Please unmount the filesystem and
>rectify the problem(s)
>[ 1693.720462] block nvme0n1: no available path - failing I/O
>[ 1693.728150] nvmet=5Frdma: post=5Frecv cmd failed
>[ 1693.732432] nvmet=5Frdma: sending cmd response failed
>[ 1693.836083] eno2 speed is unknown, defaulting to 1000
>[ 1693.841152] eno3 speed is unknown, defaulting to 1000
>[ 1693.846217] eno4 speed is unknown, defaulting to 1000
>[ 1693.852280] BUG: unable to handle page fault for address:
>ffffffffc09d2680
>[ 1693.859156] #PF: supervisor instruction fetch in kernel mode
>[ 1693.864815] #PF: error=5Fcode(0x0010) - not-present page
>[ 1693.869953] PGD 2b5813067 P4D 2b5813067 PUD 2b5815067 PMD
>13a157067 PTE 0
>[ 1693.876740] Oops: 0010 [#1] PREEMPT SMP NOPTI
>[ 1693.881098] CPU: 15 PID: 16091 Comm: rdma Tainted: G S        I
>  5.16.0-rc3 #1
>[ 1693.888751] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
>2.11.2 004/21/2021
>[ 1693.896403] RIP: 0010:0xffffffffc09d2680
>[ 1693.900329] Code: Unable to access opcode bytes at RIP
>0xffffffffc09d2656.
>[ 1693.907202] RSP: 0018:ffffb3d5456237b0 EFLAGS: 00010286
>[ 1693.912428] RAX: ffffffffc09d2680 RBX: ffff9d4adade2000 RCX:
>0000000000000001
>[ 1693.919559] RDX: 0000000080000001 RSI: ffffb3d5456237e8 RDI:
>ffff9d4adade2000
>[ 1693.926693] RBP: ffffb3d5456237e8 R08: ffffb3d545623850 R09:
>0000000000000230
>[ 1693.933823] R10: 0000000000000002 R11: ffffb3d545623840 R12:
>ffff9d4adade2270
>[ 1693.940957] R13: ffff9d4adade21e0 R14: 0000000000000005 R15:
>ffff9d4adade2220
>[ 1693.948089] FS:  00007f2f0601c000(0000) GS:ffff9d59ffdc0000(0000)
>knlGS:0000000000000000
>[ 1693.956176] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[ 1693.961921] CR2: ffffffffc09d2656 CR3: 0000000180578004 CR4:
>00000000007706e0
>[ 1693.969052] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>0000000000000000
>[ 1693.976177] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>0000000000000400
>[ 1693.983309] PKRU: 55555554
>[ 1693.986023] Call Trace:
>[ 1693.988474]  <TASK>
>[ 1693.990582]  ? cma=5Fcm=5Fevent=5Fhandler+0x1d/0xd0 [rdma=5Fcm]
>[ 1693.995817]  ? cma=5Fprocess=5Fremove+0x73/0x290 [rdma=5Fcm]
>[ 1694.000954]  ? cma=5Fremove=5Fone+0x5a/0xd0 [rdma=5Fcm]
>[ 1694.005661]  ? remove=5Fclient=5Fcontext+0x88/0xd0 [ib=5Fcore]
>[ 1694.010990]  ? disable=5Fdevice+0x8c/0x130 [ib=5Fcore]
>[ 1694.015790]  ? xa=5Fload+0x73/0xa0
>[ 1694.019024]  ? =5F=5Fib=5Funregister=5Fdevice+0x40/0xa0 [ib=5Fcore]
>[ 1694.024431]  ? ib=5Funregister=5Fdevice=5Fand=5Fput+0x33/0x50 [ib=5Fcor=
e]
>[ 1694.030360]  ? nldev=5Fdellink+0x86/0xe0 [ib=5Fcore]
>[ 1694.035000]  ? rdma=5Fnl=5Frcv=5Fmsg+0x109/0x200 [ib=5Fcore]
>[ 1694.039978]  ? =5F=5Falloc=5Fskb+0x8c/0x1b0
>[ 1694.043645]  ? =5F=5Fkmalloc=5Fnode=5Ftrack=5Fcaller+0x184/0x340
>[ 1694.048785]  ? rdma=5Fnl=5Frcv+0xc8/0x110 [ib=5Fcore]
>[ 1694.053325]  ? netlink=5Funicast+0x1a2/0x280
>[ 1694.057424]  ? netlink=5Fsendmsg+0x244/0x480
>[ 1694.061524]  ? sock=5Fsendmsg+0x58/0x60
>[ 1694.065188]  ? =5F=5Fsys=5Fsendto+0xee/0x160
>[ 1694.068944]  ? netlink=5Fsetsockopt+0x26e/0x3d0
>[ 1694.073300]  ? =5F=5Fsys=5Fsetsockopt+0xdc/0x1d0
>[ 1694.077400]  ? =5F=5Fx64=5Fsys=5Fsendto+0x24/0x30
>[ 1694.081414]  ? do=5Fsyscall=5F64+0x37/0x80
>[ 1694.085164]  ? entry=5FSYSCALL=5F64=5Fafter=5Fhwframe+0x44/0xae
>[ 1694.090391]  </TASK>
>[ 1694.092584] Modules linked in: siw rpcrdma rdma=5Fucm ib=5Fuverbs
>ib=5Fsrpt ib=5Fisert iscsi=5Ftarget=5Fmod target=5Fcore=5Fmod loop ib=5Fis=
er
>libiscsi scsi=5Ftransport=5Fiscsi rdma=5Fcm iw=5Fcm ib=5Fcm ib=5Fcore
>rpcsec=5Fgss=5Fkrb5 auth=5Frpcgss nfsv4 dns=5Fresolver nfs lockd grace
>fscache
>netfs rfkill sunrpc vfat fat dm=5Fmultipath intel=5Frapl=5Fmsr
>intel=5Frapl=5Fcommon isst=5Fif=5Fcommon skx=5Fedac x86=5Fpkg=5Ftemp=5Fthe=
rmal
>intel=5Fpowerclamp coretemp kvm=5Fintel ipmi=5Fssif kvm mgag200
>i2c=5Falgo=5Fbit
>drm=5Fkms=5Fhelper iTCO=5Fwdt iTCO=5Fvendor=5Fsupport syscopyarea irqbypass
>sysfillrect crct10dif=5Fpclmul sysimgblt crc32=5Fpclmul fb=5Fsys=5Ffops
>ghash=5Fclmulni=5Fintel acpi=5Fipmi drm rapl ipmi=5Fsi intel=5Fcstate mei=
=5Fme
>intel=5Funcore i2c=5Fi801 mei ipmi=5Fdevintf nd=5Fpmem dax=5Fpmem=5Fcompat
>wmi=5Fbmof pcspkr device=5Fdax intel=5Fpch=5Fthermal i2c=5Fsmbus lpc=5Fich
>ipmi=5Fmsghandler nd=5Fbtt dax=5Fpmem=5Fcore acpi=5Fpower=5Fmeter xfs libc=
rc32c
>sd=5Fmod t10=5Fpi sg ahci libahci libata megaraid=5Fsas nfit tg3
>crc32c=5Fintel libnvdimm wmi dm=5Fmirror dm=5Fregion=5Fhash dm=5Flog dm=5F=
mod
>[last unloaded: nvmet]
>[ 1694.178277] CR2: ffffffffc09d2680
>[ 1694.181596] ---[ end trace 9c234cd612cbb92a ]---
>[ 1694.217410] RIP: 0010:0xffffffffc09d2680
>[ 1694.221343] Code: Unable to access opcode bytes at RIP
>0xffffffffc09d2656.
>[ 1694.228212] RSP: 0018:ffffb3d5456237b0 EFLAGS: 00010286
>[ 1694.233437] RAX: ffffffffc09d2680 RBX: ffff9d4adade2000 RCX:
>0000000000000001
>[ 1694.240570] RDX: 0000000080000001 RSI: ffffb3d5456237e8 RDI:
>ffff9d4adade2000
>[ 1694.247702] RBP: ffffb3d5456237e8 R08: ffffb3d545623850 R09:
>0000000000000230
>[ 1694.254828] R10: 0000000000000002 R11: ffffb3d545623840 R12:
>ffff9d4adade2270
>[ 1694.261958] R13: ffff9d4adade21e0 R14: 0000000000000005 R15:
>ffff9d4adade2220
>[ 1694.269091] FS:  00007f2f0601c000(0000) GS:ffff9d59ffdc0000(0000)
>knlGS:0000000000000000
>[ 1694.277178] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[ 1694.282922] CR2: ffffffffc09d2656 CR3: 0000000180578004 CR4:
>00000000007706e0
>[ 1694.290054] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>0000000000000000
>[ 1694.297180] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>0000000000000400
>[ 1694.304312] PKRU: 55555554
>[ 1694.307025] Kernel panic - not syncing: Fatal exception
>[ 1694.772244] Kernel Offset: 0x35c00000 from 0xffffffff81000000
>(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>[ 1694.794394] ---[ end Kernel panic - not syncing: Fatal exception
>]---
>
>
>--=20
>Best Regards,
>  Yi Zhang
>
>
