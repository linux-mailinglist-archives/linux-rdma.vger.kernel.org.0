Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE24413B16
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Sep 2021 22:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhIUUJw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Sep 2021 16:09:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229736AbhIUUJv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Sep 2021 16:09:51 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LIePkd005679;
        Tue, 21 Sep 2021 16:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : message-id : content-transfer-encoding :
 content-type : mime-version : references; s=pp1;
 bh=Nrv/f78m7u/cOQhf6jX7+V8EYUYQDf32E8DPbxBtCgk=;
 b=naOxnKZJCxiTluhxh2JaKOECpjTlpHfJnoTAuJkg++8LiuYh6RWbcmulRVElAkkD4pxL
 tWwwFtLxAf+H84cczamGQIwcHtXAEAxc96VJTmDB5g8sTOZDkvNB39d+Bd3xpXc/Vt3Q
 b2ArVs2NALmmE3ADYuRo3QMKWlrZYUHAgz9/jvijOn0mbEIDwBw2mdKfPaSULVT8j6iO
 HsWolpigBjOxUfYhUUcNG+ToTNVN3yFokJFIdJYPDNI9QeOy7+2ep1ZOtoI+l+e/DdfC
 iPeUaNhEW2XDgWuchXCM72xCyoysMPwnVyz6+mFR4rF7oM32LH05y0NtgOrKkpH1kg5P nA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b7mf0t1fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Sep 2021 16:08:08 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18LK7Uk8006671;
        Tue, 21 Sep 2021 20:08:07 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3b57rb8ynw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Sep 2021 20:08:07 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18LK86vQ37224954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 20:08:06 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DF3C78076;
        Tue, 21 Sep 2021 20:08:06 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01CA07805E;
        Tue, 21 Sep 2021 20:08:06 +0000 (GMT)
Received: from mww0302.dal12m.mail.ibm.com (unknown [9.208.69.16])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Sep 2021 20:08:05 +0000 (GMT)
In-Reply-To: <79755291-a36f-535c-03b8-73178f80ca5e@acm.org>
Subject: Still issues with blktest/srp on 5.15-rc1 and software rdma providers
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "linux-rdma" <linux-rdma@vger.kernel.org>
Cc:     "Yi Zhang" <yi.zhang@redhat.com>,
        "Robert Pearson" <rpearsonhpe@gmail.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        "Bart Van Assche" <bvanassche@acm.org>
Date:   Tue, 21 Sep 2021 20:08:04 +0000
Message-ID: <OFE1CA20E9.CCEF92D5-ON00258757.006B589C-00258757.006E9A27@ibm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <79755291-a36f-535c-03b8-73178f80ca5e@acm.org>,<CAHj4cs9Rzte5zbgy7o158m7JA8dbSEpxy5oR-+K0NQCK1gxG=Q@mail.gmail.com>
 <OF54F8428F.7EA7E570-ON00258752.006AB21B-00258752.006BBB93@ibm.com>
 <CAFc_bgaH=fYMtKO-pJ0=KMU=d1wafDwWid8AoZsPhjpT9GdSDQ@mail.gmail.com>
 <OFC7347FF0.D24DF679-ON00258753.002DFE5F-00258753.002E19D7@ibm.com>
X-Mailer: Lotus Domino Web Server Release 11.0.1FP2HF114   September 2, 2021
X-MIMETrack: Serialize by http on MWW0302/03/M/IBM at 09/21/2021 20:08:04,Serialize
 complete at 09/21/2021 20:08:04
X-KeepSent: E1CA20E9:CCEF92D5-00258757:006B589C; name=$KeepSent; type=4
X-Disclaimed: 53095
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cCKANxcZEgWO8Iu4mMSSlUC1P4GiE3ho
X-Proofpoint-ORIG-GUID: cCKANxcZEgWO8Iu4mMSSlUC1P4GiE3ho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_06,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=601 clxscore=1015 spamscore=0
 impostorscore=0 malwarescore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109210119
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,
=20
I further investigated srp blktest with software rdma
drivers and I am still running into issues. These seem
not to be specific to using rxe or siw driver, but happen
with both occasionally. Can we run tests using hardware
rdma drivers with that blktest tool as well?


First I see some WARNINGs which relate to resources not
created or unable to get destroyed (maybe since not created
before):

...

[ 1437.197989] sd 11:0:0:1: [sde] Attached SCSI disk
[ 1437.845266] ------------[ cut here ]------------
[ 1437.845269] WARNING: CPU: 3 PID: 26257 at block/genhd.c:537 device=5Fadd=
=5Fdisk+0x1cb/0x3b0
...
[ 1437.845360] Call Trace:
[ 1437.845363]  dm=5Fsetup=5Fmd=5Fqueue+0xc8/0x100
[ 1437.845368]  table=5Fload+0x1be/0x2d0
[ 1437.845371]  ctl=5Fioctl+0x1d6/0x4c0
[ 1437.845373]  ? retrieve=5Fstatus+0x1d0/0x1d0
[ 1437.845377]  dm=5Fctl=5Fioctl+0xe/0x20
[ 1437.845379]  =5F=5Fx64=5Fsys=5Fioctl+0x118/0x910
[ 1437.845384]  ? switch=5Ffpu=5Freturn+0x56/0xc0
[ 1437.845388]  do=5Fsyscall=5F64+0x3a/0x80
[ 1437.845391]  entry=5FSYSCALL=5F64=5Fafter=5Fhwframe+0x44/0xae
[ 1437.845395] RIP: 0033:0x7f81419dbb97
[ 1437.845398] Code: 00 00 90 48 8b 05 09 73 2c 00 64 c7 00 26 00 00 00 48 =
c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d9 72 2c 00 f7 d8 64 89 01 48
[ 1437.845400] RSP: 002b:00007f814363b508 EFLAGS: 00000202 ORIG=5FRAX: 0000=
000000000010
[ 1437.845402] RAX: ffffffffffffffda RBX: 00007f81423b8d60 RCX: 00007f81419=
dbb97
[ 1437.845403] RDX: 00007f812c026c30 RSI: 00000000c138fd09 RDI: 00000000000=
00009
[ 1437.845403] RBP: 00007f81423f38b3 R08: 00007f8143639260 R09: 00007f81426=
018f8
[ 1437.845404] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f812c0=
26c30
[ 1437.845405] R13: 0000000000000000 R14: 00007f812c026ce0 R15: 00007f812c0=
0adc0
[ 1437.845407] ---[ end trace c416dea93915334e ]---





...

[ 1437.845411] kobject=5Fadd=5Finternal failed for dm (error: -2 parent: dm=
-2)
[ 1437.845451] ------------[ cut here ]------------
[ 1437.845451] WARNING: CPU: 3 PID: 26257 at block/genhd.c:564 del=5Fgendis=
k+0x1a4/0x1e0
...
[ 1437.845516] Call Trace:
[ 1437.845517]  dm=5Fsetup=5Fmd=5Fqueue+0xef/0x100
[ 1437.845520]  table=5Fload+0x1be/0x2d0
[ 1437.845522]  ctl=5Fioctl+0x1d6/0x4c0
[ 1437.845523]  ? retrieve=5Fstatus+0x1d0/0x1d0
[ 1437.845527]  dm=5Fctl=5Fioctl+0xe/0x20
[ 1437.845528]  =5F=5Fx64=5Fsys=5Fioctl+0x118/0x910
[ 1437.845531]  ? switch=5Ffpu=5Freturn+0x56/0xc0
[ 1437.845533]  do=5Fsyscall=5F64+0x3a/0x80
[ 1437.845535]  entry=5FSYSCALL=5F64=5Fafter=5Fhwframe+0x44/0xae
[ 1437.845537] RIP: 0033:0x7f81419dbb97
[ 1437.845538] Code: 00 00 90 48 8b 05 09 73 2c 00 64 c7 00 26 00 00 00 48 =
c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d9 72 2c 00 f7 d8 64 89 01 48
[ 1437.845540] RSP: 002b:00007f814363b508 EFLAGS: 00000202 ORIG=5FRAX: 0000=
000000000010
[ 1437.845542] RAX: ffffffffffffffda RBX: 00007f81423b8d60 RCX: 00007f81419=
dbb97
[ 1437.845543] RDX: 00007f812c026c30 RSI: 00000000c138fd09 RDI: 00000000000=
00009
[ 1437.845544] RBP: 00007f81423f38b3 R08: 00007f8143639260 R09: 00007f81426=
018f8
[ 1437.845545] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f812c0=
26c30
[ 1437.845546] R13: 0000000000000000 R14: 00007f812c026ce0 R15: 00007f812c0=
0adc0
[ 1437.845547] ---[ end trace c416dea93915334f ]---



...
[ 1437.845552] ------------[ cut here ]------------
[ 1437.845553] kernfs: can not remove 'sdc', no directory
[ 1437.845557] WARNING: CPU: 3 PID: 26257 at fs/kernfs/dir.c:1524 kernfs=5F=
remove=5Fby=5Fname=5Fns+0x88/0xa0
[ 1437.845562] Modules linked in:
...
[ 1437.845619] Call Trace:
[ 1437.845620]  sysfs=5Fremove=5Flink+0x19/0x30
[ 1437.845623]  bd=5Funlink=5Fdisk=5Fholder+0x6d/0xd0
[ 1437.845627]  dm=5Fput=5Ftable=5Fdevice+0x62/0xe0
[ 1437.845629]  dm=5Fput=5Fdevice+0x88/0xe0
[ 1437.845631]  ? dm=5Fput=5Fpath=5Fselector+0x40/0x50 [dm=5Fmultipath]
[ 1437.845635]  free=5Fpriority=5Fgroup+0x8e/0xc0 [dm=5Fmultipath]
[ 1437.845638]  free=5Fmultipath+0x78/0xb0 [dm=5Fmultipath]
[ 1437.845640]  multipath=5Fdtr+0x2a/0x30 [dm=5Fmultipath]
[ 1437.845642]  dm=5Ftable=5Fdestroy+0x67/0x130
[ 1437.845645]  table=5Fload+0x110/0x2d0
[ 1437.845647]  ctl=5Fioctl+0x1d6/0x4c0
[ 1437.845648]  ? retrieve=5Fstatus+0x1d0/0x1d0
[ 1437.845651]  dm=5Fctl=5Fioctl+0xe/0x20
[ 1437.845653]  =5F=5Fx64=5Fsys=5Fioctl+0x118/0x910
[ 1437.845655]  ? switch=5Ffpu=5Freturn+0x56/0xc0
[ 1437.845657]  do=5Fsyscall=5F64+0x3a/0x80
[ 1437.845659]  entry=5FSYSCALL=5F64=5Fafter=5Fhwframe+0x44/0xae
[ 1437.845662] RIP: 0033:0x7f81419dbb97
[ 1437.845663] Code: 00 00 90 48 8b 05 09 73 2c 00 64 c7 00 26 00 00 00 48 =
c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d9 72 2c 00 f7 d8 64 89 01 48
[ 1437.845664] RSP: 002b:00007f814363b508 EFLAGS: 00000202 ORIG=5FRAX: 0000=
000000000010
[ 1437.845665] RAX: ffffffffffffffda RBX: 00007f81423b8d60 RCX: 00007f81419=
dbb97
[ 1437.845666] RDX: 00007f812c026c30 RSI: 00000000c138fd09 RDI: 00000000000=
00009
[ 1437.845667] RBP: 00007f81423f38b3 R08: 00007f8143639260 R09: 00007f81426=
018f8
[ 1437.845668] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f812c0=
26c30
[ 1437.845669] R13: 0000000000000000 R14: 00007f812c026ce0 R15: 00007f812c0=
0adc0
[ 1437.845670] ---[ end trace c416dea939153350 ]---



and a final Oops close to blk=5Fmq=5Ffree=5Frqs:

[ 1438.976875] scsi 11:0:0:1: alua: Detached
[ 1438.980927] BUG: unable to handle page fault for address: ffffffffc0d831=
60
[ 1438.980960] #PF: supervisor read access in kernel mode
[ 1438.980978] #PF: error=5Fcode(0x0000) - not-present page
[ 1438.980995] PGD 15f60e067 P4D 15f60e067 PUD 15f610067 PMD 1bc2e3067 PTE 0
[ 1438.981019] Oops: 0000 [#1] SMP PTI
[ 1438.981033] CPU: 3 PID: 26257 Comm: multipathd Tainted: G        W      =
   5.15.0-rc1+ #1
[ 1438.981059] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M.=
/Z77 Extreme6, BIOS P2.80 07/01/2013
[ 1438.981088] RIP: 0010:scsi=5Fmq=5Fexit=5Frequest+0x18/0x50
[ 1438.981107] Code: 00 00 e8 5b 14 76 00 5d c3 e8 e4 cb e1 ff 5d c3 66 90 =
0f 1f 44 00 00 55 48 89 e5 53 48 8b 7f 60 48 89 f3 48 8b 87 98 00 00 00 <48=
> 8b 40 40 48 85 c0 74 0c 48 8d b6 10 01 00 00 e8 23 14 76 00 48
[ 1438.981160] RSP: 0018:ffffa289c0447b38 EFLAGS: 00010286
[ 1438.981178] RAX: ffffffffc0d83120 RBX: ffff975354360000 RCX: 00000000000=
00000
[ 1438.981201] RDX: 0000000000000000 RSI: ffff975354360000 RDI: ffff97534cf=
d1000
[ 1438.981223] RBP: ffffa289c0447b40 R08: 0000000000009c6b R09: 00000000000=
09c6b
[ 1438.981245] R10: 0000000000000002 R11: 0000000000000000 R12: 00000000000=
00000
[ 1438.981266] R13: ffff97534a34a240 R14: 0000000000000000 R15: 00000000000=
00000
[ 1438.981288] FS:  00007f814363d700(0000) GS:ffff975357780000(0000) knlGS:=
0000000000000000
[ 1438.981313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1438.981331] CR2: ffffffffc0d83160 CR3: 00000001b7fcc006 CR4: 00000000001=
706e0
[ 1438.981354] Call Trace:
[ 1438.981365]  blk=5Fmq=5Ffree=5Frqs+0x5f/0x1b0
[ 1438.981381]  blk=5Fmq=5Ffree=5Fmap=5Fand=5Frequests+0x37/0x70
[ 1438.981398]  blk=5Fmq=5Ffree=5Ftag=5Fset+0x27/0x90
[ 1438.981413]  scsi=5Fmq=5Fdestroy=5Ftags+0x15/0x20
[ 1438.981429]  scsi=5Fhost=5Fdev=5Frelease+0x8b/0xf0
[ 1438.981445]  device=5Frelease+0x38/0x90
[ 1438.981459]  kobject=5Fput+0x87/0x190
[ 1438.981475]  put=5Fdevice+0x13/0x20
[ 1438.981488]  scsi=5Ftarget=5Fdev=5Frelease+0x1f/0x30
[ 1438.981504]  device=5Frelease+0x38/0x90
[ 1438.981518]  kobject=5Fput+0x87/0x190
[ 1438.981532]  put=5Fdevice+0x13/0x20
[ 1438.981544]  scsi=5Fdevice=5Fdev=5Frelease=5Fusercontext+0x2a0/0x2b0
[ 1438.981565]  execute=5Fin=5Fprocess=5Fcontext+0x25/0x70
[ 1438.981583]  scsi=5Fdevice=5Fdev=5Frelease+0x1c/0x20
[ 1438.981600]  device=5Frelease+0x38/0x90
[ 1438.981613]  kobject=5Fput+0x87/0x190
[ 1438.981627]  put=5Fdevice+0x13/0x20
[ 1438.981639]  scsi=5Fdevice=5Fput+0x2c/0x30
[ 1438.981653]  scsi=5Fdisk=5Fput+0x30/0x50
[ 1438.981668]  sd=5Frelease+0x37/0xb0
[ 1438.981681]  blkdev=5Fput=5Fwhole+0x30/0x50
[ 1438.981696]  blkdev=5Fput+0x92/0x150
[ 1438.981710]  blkdev=5Fclose+0x27/0x30
[ 1438.981723]  =5F=5Ffput+0x8b/0x240
[ 1438.981736]  =5F=5F=5F=5Ffput+0xe/0x10
[ 1438.981748]  task=5Fwork=5Frun+0x74/0xb0
[ 1438.981762]  exit=5Fto=5Fuser=5Fmode=5Fprepare+0x14e/0x150
[ 1438.981782]  syscall=5Fexit=5Fto=5Fuser=5Fmode+0x16/0x30
[ 1438.981799]  do=5Fsyscall=5F64+0x46/0x80
[ 1438.981813]  entry=5FSYSCALL=5F64=5Fafter=5Fhwframe+0x44/0xae
[ 1438.981831] RIP: 0033:0x7f8142613c47
[ 1438.981845] Code: 00 00 0f 05 48 3d 00 f0 ff ff 77 3f c3 66 0f 1f 44 00 =
00 53 89 fb 48 83 ec 10 e8 c4 fb ff ff 89 df 89 c2 b8 03 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 2b 89 d7 89 44 24 0c e8 06 fc ff ff 8b 44 24
[ 1438.981897] RSP: 002b:00007f814363b840 EFLAGS: 00000293 ORIG=5FRAX: 0000=
000000000003
[ 1438.981920] RAX: 0000000000000000 RBX: 000000000000000a RCX: 00007f81426=
13c47
[ 1438.981942] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00000000000=
0000a
[ 1438.981964] RBP: 0000000000000008 R08: 0000000000000001 R09: 00000000000=
00007
[ 1438.981986] R10: 0000000000000000 R11: 0000000000000293 R12: 0000564949b=
25700
[ 1438.982007] R13: 00007f81432a1ccf R14: 00007f812c02c710 R15: 00007f812c0=
2c710
[ 1438.983180] Modules linked in: ib=5Fsrpt target=5Fcore=5Fiblock target=
=5Fcore=5Fmod scsi=5Fdebug rdma=5Frxe ip6=5Fudp=5Ftunnel udp=5Ftunnel null=
=5Fblk dm=5Fservice=5Ftime configs bridge stp llc nf=5Fnat=5Fftp nf=5Fconnt=
rack=5Fftp xt=5FCT ip6t=5Frpfilter ip6t=5FREJECT nf=5Freject=5Fipv6 xt=5Fco=
nntrack ib=5Fiser ip=5Fset nfnetlink libiscsi ebtable=5Fnat ebtable=5Fbrout=
e scsi=5Ftransport=5Fiscsi ip6table=5Fmangle ip6table=5Fraw ip6table=5Fsecu=
rity iptable=5Fmangle iptable=5Fraw iptable=5Fsecurity ebtable=5Ffilter ebt=
ables ip6table=5Ffilter ip6table=5Fnat ip6=5Ftables iptable=5Fnat nf=5Fnat =
nf=5Fconntrack nf=5Fdefrag=5Fipv6 nf=5Fdefrag=5Fipv4 rpcrdma sunrpc ib=5Fip=
oib rdma=5Fucm ib=5Fumad dm=5Fmultipath scsi=5Fdh=5Frdac scsi=5Fdh=5Femc sc=
si=5Fdh=5Falua iw=5Fcxgb4 libcxgb intel=5Frapl=5Fmsr intel=5Frapl=5Fcommon =
ib=5Fuverbs x86=5Fpkg=5Ftemp=5Fthermal intel=5Fpowerclamp coretemp kvm=5Fin=
tel rdma=5Fcm iw=5Fcm kvm ib=5Fcm ib=5Fcore snd=5Fhda=5Fcodec=5Fhdmi snd=5F=
hda=5Fcodec=5Frealtek snd=5Fhda=5Fcodec=5Fgeneric ledtrig=5Faudio snd=5Fhda=
=5Fintel snd=5Fintel=5Fdspcfg irqbypass snd=5Fhda=5Fcodec crc32=5Fpclmul ra=
pl snd=5Fhwdep snd=5Fhda=5Fcore intel=5Fcstate intel=5Funcore
[ 1438.983224]  snd=5Fpcm snd=5Ftimer iTCO=5Fwdt mei=5Fme snd iTCO=5Fvendor=
=5Fsupport mxm=5Fwmi mei soundcore i2c=5Fi801 i2c=5Fsmbus lpc=5Fich wmi xfs=
 i915 i2c=5Falgo=5Fbit ttm drm=5Fkms=5Fhelper firewire=5Fohci firewire=5Fco=
re syscopyarea sysfillrect cxgb4 crc=5Fitu=5Ft sysimgblt fb=5Fsys=5Ffops tg=
3 drm ptp crc32c=5Fintel csiostor scsi=5Ftransport=5Ffc pps=5Fcore video [l=
ast unloaded: scsi=5Ftransport=5Fsrp]
[ 1438.992637] CR2: ffffffffc0d83160
[ 1438.994057] ---[ end trace c416dea939153351 ]---
[ 1438.995476] RIP: 0010:scsi=5Fmq=5Fexit=5Frequest+0x18/0x50
[ 1438.996905] Code: 00 00 e8 5b 14 76 00 5d c3 e8 e4 cb e1 ff 5d c3 66 90 =
0f 1f 44 00 00 55 48 89 e5 53 48 8b 7f 60 48 89 f3 48 8b 87 98 00 00 00 <48=
> 8b 40 40 48 85 c0 74 0c 48 8d b6 10 01 00 00 e8 23 14 76 00 48
[ 1438.998414] RSP: 0018:ffffa289c0447b38 EFLAGS: 00010286
[ 1438.999954] RAX: ffffffffc0d83120 RBX: ffff975354360000 RCX: 00000000000=
00000
[ 1439.001513] RDX: 0000000000000000 RSI: ffff975354360000 RDI: ffff97534cf=
d1000
[ 1439.003079] RBP: ffffa289c0447b40 R08: 0000000000009c6b R09: 00000000000=
09c6b
[ 1439.004652] R10: 0000000000000002 R11: 0000000000000000 R12: 00000000000=
00000
[ 1439.006218] R13: ffff97534a34a240 R14: 0000000000000000 R15: 00000000000=
00000
[ 1439.007777] FS:  00007f814363d700(0000) GS:ffff975357780000(0000) knlGS:=
0000000000000000
[ 1439.009340] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1439.010906] CR2: ffffffffc0d83160 CR3: 00000001b7fcc006 CR4: 00000000001=
706e0



Thanks,
Bernard.
