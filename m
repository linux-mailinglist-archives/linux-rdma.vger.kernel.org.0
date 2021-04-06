Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3BE354DB2
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 09:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244220AbhDFHT5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 03:19:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244223AbhDFHT4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 03:19:56 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13674A8s105105
        for <linux-rdma@vger.kernel.org>; Tue, 6 Apr 2021 03:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : from : to
 : cc : date : mime-version : references : content-transfer-encoding :
 content-type : message-id : subject; s=pp1;
 bh=v7nKUkl58WVMlKA+Qf6vqYDS78QHwm/ZlF8BqPGiIF8=;
 b=iHYrjbXFU6w6Tvg0uyyPFeYmjoKWRRluXtVUZeP7tkV6mqZRYrm9W2mthL9A1KYq/mAE
 YJLbyopyLLPHGSthanNvAWr8zFTLC4wz1X2MPKrPtT0NcacsuuWFtlqzcuZ6eeVaTEs3
 L5Wotu9kK8Cn2QpBhsOWT8t9cEVm1D3JMI6HUzsScHuVqh/5RmQ3B+i9jD2M+jtoN2Ko
 kmfLXlAt3++Pf8niWN0pJJLUXj1CPOO9zGl+qEhsNiONGzQueJeG1tEQ8f1exUvS0pYR
 Ey8xmgGURQUSX7DqMuSBAgnjow+DY0QFkNM0yEPsBRaIgttl3condfKenQGYRZFF3KMt QQ== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37q5tyjn46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 03:19:48 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 6 Apr 2021 07:19:46 -0000
Received: from us1b3-smtp04.a3dr.sjc01.isc4sb.com (10.122.203.161)
        by smtp.notes.na.collabserv.com (10.122.47.48) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 6 Apr 2021 07:19:44 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp04.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021040607194407-116620 ;
          Tue, 6 Apr 2021 07:19:44 +0000 
In-Reply-To: <76827202.1204697.1617243535445.JavaMail.zimbra@redhat.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Yi Zhang" <yi.zhang@redhat.com>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>,
        "linux-nvme" <linux-nvme@lists.infradead.org>,
        "Bart Van Assche" <bvanassche@acm.org>
Date:   Tue, 6 Apr 2021 07:19:44 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <76827202.1204697.1617243535445.JavaMail.zimbra@redhat.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: 8D491BC4:3759DF6F-002586AF:002836E5;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 44351
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21040607-1429-0000-0000-000003A6853E
X-IBM-SpamModules-Scores: BY=0.019777; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000435
X-IBM-SpamModules-Versions: BY=3.00014940; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01526390; UDB=6.00825164; IPR=6.01308223;
 MB=3.00036522; MTD=3.00000008; XFM=3.00000015; UTC=2021-04-06 07:19:45
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-22 13:55:12 - 6.00012377
x-cbparentid: 21040607-1430-0000-0000-00003A128783
Message-Id: <OF8D491BC4.3759DF6F-ON002586AF.002836E5-002586AF.00284286@notes.na.collabserv.com>
X-Proofpoint-ORIG-GUID: MZvgYpEzuBl_x51mP5xBI2PTeFctMvry
X-Proofpoint-GUID: MZvgYpEzuBl_x51mP5xBI2PTeFctMvry
Subject: Re:  [bug report]kernel NULL pointer at siw_tx_hdt+0x128/0x978 [siw] with
 blktests nvmeof-mp/002
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_01:2021-04-01,2021-04-06 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Yi Zhang" <yi.zhang@redhat.com> wrote: -----

>To: linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org
>From: "Yi Zhang" <yi.zhang@redhat.com>
>Date: 04/01/2021 04:20AM
>Cc: "Bart Van Assche" <bvanassche@acm.org>
>Subject: [EXTERNAL] [bug report]kernel NULL pointer at
>siw=5Ftx=5Fhdt+0x128/0x978 [siw] with blktests nvmeof-mp/002
>
>Hello
>
>I reproduced this issue with blktests nvmeof-mp/002 on 5.12.0-rc5
>aarch64, pls help check it and let me know if you need any testing
>for it, thanks.=20
>
>[18381.922840] run blktests nvmeof-mp/002 at 2021-03-31 20:42:40
>[18382.123208] null=5Fblk: module loaded
>[18382.345093] SoftiWARP attached
>[18382.507549] nvmet: adding nsid 1 to subsystem nvme-test
>[18382.536043] iwpm=5Fregister=5Fpid: Unable to send a nlmsg (client =3D 2)
>[18382.542985] nvmet=5Frdma: enabling port 1 (10.19.241.109:7777)
>[18382.703578] nvmet: creating controller 1 for subsystem nvme-test
>for NQN
>nqn.2014-08.org.nvmexpress:uuid:a6ba6b82-f083-4df3-9ee2-cd3f635a8418.
>[18382.717201] nvme nvme0: creating 32 I/O queues.
>[18382.751581] nvme nvme0: mapped 32/0/0 default/read/poll queues.
>[18382.768935] nvme nvme0: new ctrl: NQN "nvme-test", addr
>10.19.241.109:7777
>[18382.811275] device-mapper: multipath service-time: version 0.3.0
>loaded
>[18383.611572] EXT4-fs (dm-3): mounted filesystem without journal.
>Opts: (null). Quota mode: none.
>[18383.620343] ext4 filesystem being mounted at
>/root/blktests/results/tmpdir.nvmeof-mp.002.pnM/mnt0 supports
>timestamps until 2038 (0x7fffffff)
>[18411.156005] Unable to handle kernel NULL pointer dereference at
>virtual address 0000000000000030
>[18411.156046] Unable to handle kernel NULL pointer dereference at
>virtual address 0000000000000030
>[18411.164790] Mem abort info:
>[18411.173564] Mem abort info:
>[18411.173565]   ESR =3D 0x96000006
>[18411.173567]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>[18411.173569]   SET =3D 0, FnV =3D 0
>[18411.176349]   ESR =3D 0x96000006
>[18411.179129]   EA =3D 0, S1PTW =3D 0
>[18411.182170]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>[18411.187473] Data abort info:
>[18411.190513]   SET =3D 0, FnV =3D 0
>[18411.193558]   ISV =3D 0, ISS =3D 0x00000006
>[18411.196685]   EA =3D 0, S1PTW =3D 0
>[18411.201982]   CM =3D 0, WnR =3D 0
>[18411.204853] Data abort info:
>[18411.207893] user pgtable: 64k pages, 42-bit VAs,
>pgdp=3D00000009c33b0000
>[18411.211714]   ISV =3D 0, ISS =3D 0x00000006
>[18411.214846] [0000000000000030] pgd=3D0000000000000000
>[18411.217800]   CM =3D 0, WnR =3D 0
>[18411.220666] , p4d=3D0000000000000000
>[18411.227184] user pgtable: 64k pages, 42-bit VAs,
>pgdp=3D00000009c33b0000
>[18411.231005] , pud=3D0000000000000000
>[18411.235873] [0000000000000030] pgd=3D0000000000000000
>[18411.238826] , pmd=3D0000000000000000
>[18411.242214] , p4d=3D0000000000000000
>[18411.248733]=20
>[18411.252120] , pud=3D0000000000000000
>[18411.256990] Internal error: Oops: 96000006 [#1] SMP
>[18411.260376] , pmd=3D0000000000000000
>[18411.263764] Modules linked in: ext4 mbcache jbd2 dm=5Fservice=5Ftime
>nvme=5Frdma
>[18411.265247]=20
>[18411.268634]  nvme=5Ffabrics nvme nvmet=5Frdma nvmet siw null=5Fblk
>dm=5Fmultipath nvme=5Fcore rfkill rpcrdma sunrpc rdma=5Fucm ib=5Fsrpt
>ib=5Fisert iscsi=5Ftarget=5Fmod ib=5Fumad target=5Fcore=5Fmod vfat fat ib=
=5Fiser
>ib=5Fipoib libiscsi scsi=5Ftransport=5Fiscsi rdma=5Fcm iw=5Fcm ib=5Fcm mlx=
4=5Fib
>ib=5Fuverbs ib=5Fcore acpi=5Fipmi crct10dif=5Fce ghash=5Fce ipmi=5Fssif sh=
a1=5Fce
>sbsa=5Fgwdt ipmi=5Fdevintf ipmi=5Fmsghandler xgene=5Fhwmon ip=5Ftables xfs
>libcrc32c mlx4=5Fen sr=5Fmod cdrom sg ast drm=5Fvram=5Fhelper drm=5Fkms=5F=
helper
>syscopyarea sysfillrect sysimgblt fb=5Fsys=5Ffops drm=5Fttm=5Fhelper ttm d=
rm
>mlx4=5Fcore igb sha2=5Fce sha256=5Farm64 i2c=5Fdesignware=5Fplatform
>ahci=5Fplatform i2c=5Falgo=5Fbit i2c=5Fdesignware=5Fcore gpio=5Fdwapb
>libahci=5Fplatform i2c=5Fxgene=5Fslimpro uas usb=5Fstorage dm=5Fmirror
>dm=5Fregion=5Fhash dm=5Flog dm=5Fmod [last unloaded: nvme=5Fcore]
>[18411.351792] CPU: 13 PID: 19581 Comm: siw=5Ftx/13 Not tainted
>5.12.0-rc5 #1
>[18411.368293] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=3D--)
>[18411.374287] pc : siw=5Ftx=5Fhdt+0x128/0x978 [siw]
>[18411.378641] lr : siw=5Fqp=5Fsq=5Fprocess+0xc4/0xa80 [siw]
>[18411.383512] sp : fffffe001acafa90
>[18411.386813] x29: fffffe001acafa90 x28: fffffc083f9a4238=20
>[18411.392114] x27: 0000000000000003 x26: 000000000000ef70=20
>[18411.397414] x25: 0000000000000003 x24: 0000000000000000=20
>[18411.402714] x23: 0000000000000000 x22: 0000000000000000=20
>[18411.408014] x21: fffffc083f9a4270 x20: fffffc083f9a41c8=20
>[18411.413313] x19: 0000000000000000 x18: 0000000000000000=20
>[18411.418612] x17: 0000000000000000 x16: 0000000000000000=20
>[18411.423912] x15: 0000000000000000 x14: 0000000000000000=20
>[18411.429211] x13: b6f8a80000001000 x12: fffffc093fe37000=20
>[18411.434511] x11: b6f8a80000000040 x10: 0000000000000001=20
>[18411.439810] x9 : 0000000000000000 x8 : 0000000000000000=20
>[18411.445110] x7 : 0000000000000014 x6 : 000000000000ffc8=20
>[18411.450409] x5 : fffffc083f9a4238 x4 : fffffe001acafc40=20
>[18411.455709] x3 : 0000000000000020 x2 : fffffc083f9a4238=20
>[18411.461009] x1 : fffffc083f9a4248 x0 : 0000000000000000=20
>[18411.466309] Call trace:
>[18411.468743]  siw=5Ftx=5Fhdt+0x128/0x978 [siw]
>[18411.472746]  siw=5Fqp=5Fsq=5Fprocess+0xc4/0xa80 [siw]
>[18411.477270]  siw=5Fsq=5Fresume+0x48/0x168 [siw]
>[18411.481446]  siw=5Frun=5Fsq+0xc8/0x290 [siw]
>[18411.485362]  kthread+0x114/0x118
>[18411.488580]  ret=5Ffrom=5Ffork+0x10/0x18
>[18411.492146] Code: 370800c1 f9403fe1 8b214c41 f9403c37 (f9401ae1)=20
>[18411.498237] ---[ end trace 67f55110d28671a3 ]---
>[18411.502842] Kernel panic - not syncing: Oops: Fatal exception
>[18411.508580] SMP: stopping secondary CPUs
>[18412.537491] SMP: failed to stop secondary CPUs 11,13
>[18412.542445] Kernel Offset: disabled
>[18412.545920] CPU features: 0x00240002,61802008
>[18412.550264] Memory Limit: none
>[18412.553311] ---[ end Kernel panic - not syncing: Oops: Fatal
>exception ]---
>
>
>Best Regards,
>  Yi Zhang
>
Looks like an siw issue. I will dig into it. Sorry for the late reply.

Many thanks,
Bernard.

