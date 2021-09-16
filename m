Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF9540EAE6
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 21:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhIPTiP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 15:38:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232543AbhIPTiO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Sep 2021 15:38:14 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18GJTiEa012487;
        Thu, 16 Sep 2021 15:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : message-id : content-transfer-encoding :
 content-type : mime-version : references; s=pp1;
 bh=Rd+3eizzm3vSgx19ZRTQWtL4U0mUIUCSSO4V/V8Q5jA=;
 b=IAfpFSMtVBSWuFFx2XfvxdFXA5/DMKlCFk9fKA9BTm+J2PNMNtefSuT+xPdUdIlRJ5Bm
 8Hxf8MtAjFaunRSCAZH7sXh2mN3aj70b25Po4GOGM0e9Li1NHi4ZSe6Is+uFH+u32pir
 /TNBSXG4BRMWTzZA8bwz2oC8++3iOag0UFVPaqQeNXr4ndstZjfn3d3Jlo34JjVu9Bc5
 1H5BrSM0twMG5S8K+51kqER9CcYmkJAhU4w1bW7o/1Zgpw4mEWdZ62OrgUBd6YiRiZGM
 BbjrtT2qZ1Ah7SCcAn33D7OpbGpROis/yTN+DQ75/VeDFZFMgrsclJwimeJJXnEyUms1 nA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b4c4rr30p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 15:36:52 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18GJYMd1011332;
        Thu, 16 Sep 2021 19:36:51 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3b0m3d621x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 19:36:51 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18GJao8D20054506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 19:36:50 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3894E136061;
        Thu, 16 Sep 2021 19:36:50 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26A1313605D;
        Thu, 16 Sep 2021 19:36:50 +0000 (GMT)
Received: from mww0302.dal12m.mail.ibm.com (unknown [9.208.69.16])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 16 Sep 2021 19:36:50 +0000 (GMT)
In-Reply-To: 
Subject: Issus with blktest/srp on 5.15-rc1 and rdma_rxe
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "linux-rdma" <linux-rdma@vger.kernel.org>
Cc:     "Bob Pearson" <rpearsonhpe@gmail.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        "Bart Van Assche" <bvanassche@acm.org>
Date:   Thu, 16 Sep 2021 19:36:43 +0000
Message-ID: <OF54F8428F.7EA7E570-ON00258752.006AB21B-00258752.006BBB93@ibm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: 
X-Mailer: Lotus Domino Web Server Release 11.0.1FP2HF114   September 2, 2021
X-MIMETrack: Serialize by http on MWW0302/03/M/IBM at 09/16/2021 19:36:43,Serialize
 complete at 09/16/2021 19:36:43
X-KeepSent: 54F8428F:7EA7E570-00258752:006AB21B; name=$KeepSent; type=4
X-Disclaimed: 18883
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IrR7Qu0LClep4jk1PIExPRQCOPbHi769
X-Proofpoint-ORIG-GUID: IrR7Qu0LClep4jk1PIExPRQCOPbHi769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 mlxlogscore=465 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109160110
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

if I run the complete srp test series from the blktests suite,
the dmesg log contains many rdma=5Frxe messages of type:
=20
rdma=5Frxe: rxe=5Finvalidate=5Fmr: rkey (n) doesn't match mr->ibmr.rkey (n =
+ 1)

where 'n' is the current key. I expect this is not intended
behavior.

I am at commit 1b789bd4dbd48a92f5427d9c37a72a8f6ca17754



Furthermore, running ./check -q srp/005 sometimes I get this:

[  308.903330] sd 11:0:0:1: [sde] Attached SCSI disk
[  308.917293] scsi 11:0:0:1: alua: Detached
[  308.918191] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[  308.918223] #PF: supervisor instruction fetch in kernel mode
[  308.918242] #PF: error=5Fcode(0x0010) - not-present page
[  308.918259] PGD 0 P4D 0=20
[  308.918271] Oops: 0010 [#1] SMP PTI
[  308.918285] CPU: 1 PID: 4214 Comm: kworker/1:255 Not tainted 5.15.0-rc1+=
 #4
[  308.918309] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M.=
/Z77 Extreme6, BIOS P2.80 07/01/2013
[  308.918338] Workqueue: srp=5Fremove srp=5Fremove=5Fwork [ib=5Fsrp]
[  308.918362] RIP: 0010:0x0
[  308.918375] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd=
6.
[  308.918397] RSP: 0018:ffffb6124b9a3b68 EFLAGS: 00010086
[  308.918414] RAX: 0000000000000001 RBX: ffffb6124b9a3ce0 RCX: 00000000000=
00000
[  308.918437] RDX: 0000000000000000 RSI: ffffb6124b9a3c50 RDI: ffff966063a=
27a00
[  308.918459] RBP: ffffb6124b9a3bb0 R08: ffff966067481c00 R09: ffffeb57848=
9b808
[  308.918481] R10: ffff966043c0f200 R11: ffffb6124b9a3d00 R12: ffff966063a=
27a00
[  308.918503] R13: 0000000000000004 R14: 0000000000000000 R15: ffffb6124b9=
a3c50
[  308.918524] FS:  0000000000000000(0000) GS:ffff966157680000(0000) knlGS:=
0000000000000000
[  308.918550] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  308.918568] CR2: ffffffffffffffd6 CR3: 000000005060a004 CR4: 00000000001=
706e0
[  308.918590] Call Trace:
[  308.918601]  =5F=5Fib=5Fprocess=5Fcq+0x89/0x150 [ib=5Fcore]
[  308.918640]  ib=5Fprocess=5Fcq=5Fdirect+0x30/0x50 [ib=5Fcore]
[  308.918669]  ? xas=5Fstore+0x331/0x640
[  308.918684]  ? free=5Funref=5Fpage=5Fcommit.isra.135+0x91/0x140
[  308.918705]  ? free=5Funref=5Fpage+0x6e/0xd0
[  308.918719]  ? =5F=5Ffree=5Fpages+0xa3/0xc0
[  308.918733]  ? kfree+0x32f/0x3b0
[  308.918748]  srp=5Fdestroy=5Fqp+0x24/0x40 [ib=5Fsrp]
[  308.918767]  srp=5Ffree=5Fch=5Fib+0x77/0x180 [ib=5Fsrp]
[  308.918784]  srp=5Fremove=5Fwork+0xde/0x1a0 [ib=5Fsrp]
[  308.918801]  process=5Fone=5Fwork+0x1d0/0x380
[  308.918817]  worker=5Fthread+0x37/0x390
[  308.918831]  ? process=5Fone=5Fwork+0x380/0x380
[  308.918846]  kthread+0x12f/0x150
[  308.918859]  ? set=5Fkthread=5Fstruct+0x40/0x40
[  308.918874]  ret=5Ffrom=5Ffork+0x22/0x30


With ./check -q srp/008 I sometimes get something similar:

[ 1772.149274] sd 11:0:0:1: [sde] Attached SCSI disk
[ 1772.150096] scsi 11:0:0:2: alua: Detached
[ 1772.150184] blk=5Fupdate=5Frequest: I/O error, dev sde, sector 8 op 0x0:=
(READ) flags 0x80700 phys=5Fseg 1 prio class 0
[ 1772.151653] blk=5Fupdate=5Frequest: I/O error, dev sde, sector 8 op 0x0:=
(READ) flags 0x0 phys=5Fseg 1 prio class 0
[ 1772.153080] Buffer I/O error on dev sde, logical block 1, async page read
[ 1772.169139] scsi 11:0:0:1: alua: Detached
[ 1772.169446] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[ 1772.170881] #PF: supervisor instruction fetch in kernel mode
[ 1772.172297] #PF: error=5Fcode(0x0010) - not-present page
[ 1772.173751] PGD 0 P4D 0=20
[ 1772.175165] Oops: 0010 [#1] SMP PTI
[ 1772.176575] CPU: 3 PID: 8654 Comm: kworker/3:60 Not tainted 5.15.0-rc1+ =
#4
[ 1772.177995] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M.=
/Z77 Extreme6, BIOS P2.80 07/01/2013
[ 1772.179430] Workqueue: srp=5Fremove srp=5Fremove=5Fwork [ib=5Fsrp]
[ 1772.180859] RIP: 0010:0x0
[ 1772.182276] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd=
6.
[ 1772.183705] RSP: 0018:ffffa9710a2f7b68 EFLAGS: 00010086
[ 1772.185129] RAX: 0000000000000001 RBX: ffffa9710a2f7c50 RCX: 00000000000=
00000
[ 1772.186566] RDX: 0000000000000000 RSI: ffffa9710a2f7c08 RDI: ffff91a7038=
25a00
[ 1772.187994] RBP: ffffa9710a2f7bb0 R08: ffff91a7184f8300 R09: 00000000000=
00000
[ 1772.189425] R10: ffff91a7869ce000 R11: ffffa9710a2f7d00 R12: ffff91a7038=
25a00
[ 1772.190848] R13: 0000000000000002 R14: 0000000000000000 R15: ffffa9710a2=
f7c08
[ 1772.192270] FS:  0000000000000000(0000) GS:ffff91a817780000(0000) knlGS:=
0000000000000000
[ 1772.193689] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1772.195118] CR2: ffffffffffffffd6 CR3: 0000000111458006 CR4: 00000000001=
706e0
[ 1772.196558] Call Trace:
[ 1772.197975]  =5F=5Fib=5Fprocess=5Fcq+0x89/0x150 [ib=5Fcore]
[ 1772.199402]  ib=5Fprocess=5Fcq=5Fdirect+0x30/0x50 [ib=5Fcore]
[ 1772.200830]  ? put=5Fcpu=5Fpartial+0x98/0xb0
[ 1772.202260]  ? =5F=5Fslab=5Ffree+0x226/0x3c0
[ 1772.203664]  ? =5F=5Fslab=5Ffree+0x226/0x3c0
[ 1772.205038]  ? xas=5Fstore+0x331/0x640
[ 1772.206404]  ? rxe=5Felem=5Frelease+0x4f/0x60 [rdma=5Frxe]
[ 1772.207763]  ? kfree+0x372/0x3b0
[ 1772.209101]  ? srp=5Fdestroy=5Ffr=5Fpool+0x43/0x50 [ib=5Fsrp]
[ 1772.210439]  srp=5Fdestroy=5Fqp+0x24/0x40 [ib=5Fsrp]
[ 1772.211759]  srp=5Ffree=5Fch=5Fib+0x77/0x180 [ib=5Fsrp]
[ 1772.213093]  srp=5Fremove=5Fwork+0xde/0x1a0 [ib=5Fsrp]
[ 1772.214417]  process=5Fone=5Fwork+0x1d0/0x380
[ 1772.215756]  worker=5Fthread+0x37/0x390
[ 1772.217082]  ? process=5Fone=5Fwork+0x380/0x380
[ 1772.218422]  kthread+0x12f/0x150
[ 1772.219744]  ? set=5Fkthread=5Fstruct+0x40/0x40
[ 1772.221059]  ret=5Ffrom=5Ffork+0x22/0x30


Many thanks,
Bernard.


