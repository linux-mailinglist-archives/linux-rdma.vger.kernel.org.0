Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F405740F3E0
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Sep 2021 10:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbhIQIQu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Sep 2021 04:16:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229837AbhIQIQt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Sep 2021 04:16:49 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18H7Z6sc021869;
        Fri, 17 Sep 2021 04:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : message-id : content-transfer-encoding :
 content-type : mime-version : references; s=pp1;
 bh=joCvZ7/8G1JJqT2T8q2CZMINutD+anxCpeQGPGZk7Xw=;
 b=ogxhKgFVE15y6cYcZ7xsXkcajyZ6RTBS2RISnjCWZQRKACRW1VkF4pcxpMra/QKniDPP
 lTHDv/049mWVcKrSqUoTp1/hhww3Pu9hL7Le3Ep1BBdhxymh5RETn7tDits9WtjgM7bq
 6pVUOvA1reWGfcUUVCIdhfSEWyn4iafKiv8M+eysxYdbAr5n4be4bS3wCC88c4WaKUtF
 zW4Ji3v4K/lg0/0Wo7j8s2gm4qd64UvO4WZ+A6zlFZDl0CUZkQtW3Y8Fdy2pyPTCa+Iq
 fP9FPoJQyovRk6aDgTGmkLVq8U1d//EIY1ldVhOMuVKzCDwc9CBePChTuIqBIhAzZQFE 2A== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b4ku5n4s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 04:15:22 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18H8Dv3o024572;
        Fri, 17 Sep 2021 08:15:21 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03dal.us.ibm.com with ESMTP id 3b0m3dkrmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 08:15:21 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18H8FKYc32964996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 08:15:20 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FB41C6067;
        Fri, 17 Sep 2021 08:15:20 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24347C6061;
        Fri, 17 Sep 2021 08:15:20 +0000 (GMT)
Received: from mww0302.dal12m.mail.ibm.com (unknown [9.208.69.16])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 17 Sep 2021 08:15:20 +0000 (GMT)
In-Reply-To: <CAFc_bgaH=fYMtKO-pJ0=KMU=d1wafDwWid8AoZsPhjpT9GdSDQ@mail.gmail.com>
Subject: Re: Re: Issus with blktest/srp on 5.15-rc1 and rdma_rxe
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Robert Pearson" <rpearsonhpe@gmail.com>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        "Bart Van Assche" <bvanassche@acm.org>
Date:   Fri, 17 Sep 2021 08:15:19 +0000
Message-ID: <OF817629FA.6715B4AE-ON00258753.002D0769-00258753.002D5914@ibm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <CAFc_bgaH=fYMtKO-pJ0=KMU=d1wafDwWid8AoZsPhjpT9GdSDQ@mail.gmail.com>,<OF54F8428F.7EA7E570-ON00258752.006AB21B-00258752.006BBB93@ibm.com>
X-Mailer: Lotus Domino Web Server Release 11.0.1FP2HF114   September 2, 2021
X-MIMETrack: Serialize by http on MWW0302/03/M/IBM at 09/17/2021 08:15:19,Serialize
 complete at 09/17/2021 08:15:19
X-KeepSent: 817629FA:6715B4AE-00258753:002D0769; name=$KeepSent; type=4
X-Disclaimed: 44043
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZC2aJ64ad_kxK7zwR6YooXnLMTSPBmfV
X-Proofpoint-ORIG-GUID: ZC2aJ64ad_kxK7zwR6YooXnLMTSPBmfV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_04,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=879 spamscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170047
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Robert Pearson" <rpearsonhpe@gmail.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Robert Pearson" <rpearsonhpe@gmail.com>
>Date: 09/17/2021 12:21AM
>Cc: "linux-rdma" <linux-rdma@vger.kernel.org>, "Jason Gunthorpe"
><jgg@nvidia.com>, "Bart Van Assche" <bvanassche@acm.org>
>Subject: [EXTERNAL] Re: Issus with blktest/srp on 5.15-rc1 and
>rdma=5Frxe
>
>Bernard,
>That would indicate that you have not applied the patch series
>RDMA/rxe: Fix various bugs which fixes the rkey not match rxe bug.


Hi Bob, oh, sorry, I obviously missed that one!

So I expect the Oops will disappear with that as well,
will check later.



Many thanks,
Bernard.

>I do not know how to get it to select the siw device instead of the
>rxe
>device but Bart does.
>
>Bob
>
>On Thu, Sep 16, 2021 at 2:36 PM Bernard Metzler <BMT@zurich.ibm.com>
>wrote:
>>
>> Hi,
>>
>> if I run the complete srp test series from the blktests suite,
>> the dmesg log contains many rdma=5Frxe messages of type:
>>
>> rdma=5Frxe: rxe=5Finvalidate=5Fmr: rkey (n) doesn't match mr->ibmr.rkey
>(n + 1)
>>
>> where 'n' is the current key. I expect this is not intended
>> behavior.
>>
>> I am at commit 1b789bd4dbd48a92f5427d9c37a72a8f6ca17754
>>
>>
>>
>> Furthermore, running ./check -q srp/005 sometimes I get this:
>>
>> [  308.903330] sd 11:0:0:1: [sde] Attached SCSI disk
>> [  308.917293] scsi 11:0:0:1: alua: Detached
>> [  308.918191] BUG: kernel NULL pointer dereference, address:
>0000000000000000
>> [  308.918223] #PF: supervisor instruction fetch in kernel mode
>> [  308.918242] #PF: error=5Fcode(0x0010) - not-present page
>> [  308.918259] PGD 0 P4D 0
>> [  308.918271] Oops: 0010 [#1] SMP PTI
>> [  308.918285] CPU: 1 PID: 4214 Comm: kworker/1:255 Not tainted
>5.15.0-rc1+ #4
>> [  308.918309] Hardware name: To Be Filled By O.E.M. To Be Filled
>By O.E.M./Z77 Extreme6, BIOS P2.80 07/01/2013
>> [  308.918338] Workqueue: srp=5Fremove srp=5Fremove=5Fwork [ib=5Fsrp]
>> [  308.918362] RIP: 0010:0x0
>> [  308.918375] Code: Unable to access opcode bytes at RIP
>0xffffffffffffffd6.
>> [  308.918397] RSP: 0018:ffffb6124b9a3b68 EFLAGS: 00010086
>> [  308.918414] RAX: 0000000000000001 RBX: ffffb6124b9a3ce0 RCX:
>0000000000000000
>> [  308.918437] RDX: 0000000000000000 RSI: ffffb6124b9a3c50 RDI:
>ffff966063a27a00
>> [  308.918459] RBP: ffffb6124b9a3bb0 R08: ffff966067481c00 R09:
>ffffeb578489b808
>> [  308.918481] R10: ffff966043c0f200 R11: ffffb6124b9a3d00 R12:
>ffff966063a27a00
>> [  308.918503] R13: 0000000000000004 R14: 0000000000000000 R15:
>ffffb6124b9a3c50
>> [  308.918524] FS:  0000000000000000(0000)
>GS:ffff966157680000(0000) knlGS:0000000000000000
>> [  308.918550] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  308.918568] CR2: ffffffffffffffd6 CR3: 000000005060a004 CR4:
>00000000001706e0
>> [  308.918590] Call Trace:
>> [  308.918601]  =5F=5Fib=5Fprocess=5Fcq+0x89/0x150 [ib=5Fcore]
>> [  308.918640]  ib=5Fprocess=5Fcq=5Fdirect+0x30/0x50 [ib=5Fcore]
>> [  308.918669]  ? xas=5Fstore+0x331/0x640
>> [  308.918684]  ? free=5Funref=5Fpage=5Fcommit.isra.135+0x91/0x140
>> [  308.918705]  ? free=5Funref=5Fpage+0x6e/0xd0
>> [  308.918719]  ? =5F=5Ffree=5Fpages+0xa3/0xc0
>> [  308.918733]  ? kfree+0x32f/0x3b0
>> [  308.918748]  srp=5Fdestroy=5Fqp+0x24/0x40 [ib=5Fsrp]
>> [  308.918767]  srp=5Ffree=5Fch=5Fib+0x77/0x180 [ib=5Fsrp]
>> [  308.918784]  srp=5Fremove=5Fwork+0xde/0x1a0 [ib=5Fsrp]
>> [  308.918801]  process=5Fone=5Fwork+0x1d0/0x380
>> [  308.918817]  worker=5Fthread+0x37/0x390
>> [  308.918831]  ? process=5Fone=5Fwork+0x380/0x380
>> [  308.918846]  kthread+0x12f/0x150
>> [  308.918859]  ? set=5Fkthread=5Fstruct+0x40/0x40
>> [  308.918874]  ret=5Ffrom=5Ffork+0x22/0x30
>>
>>
>> With ./check -q srp/008 I sometimes get something similar:
>>
>> [ 1772.149274] sd 11:0:0:1: [sde] Attached SCSI disk
>> [ 1772.150096] scsi 11:0:0:2: alua: Detached
>> [ 1772.150184] blk=5Fupdate=5Frequest: I/O error, dev sde, sector 8 op
>0x0:(READ) flags 0x80700 phys=5Fseg 1 prio class 0
>> [ 1772.151653] blk=5Fupdate=5Frequest: I/O error, dev sde, sector 8 op
>0x0:(READ) flags 0x0 phys=5Fseg 1 prio class 0
>> [ 1772.153080] Buffer I/O error on dev sde, logical block 1, async
>page read
>> [ 1772.169139] scsi 11:0:0:1: alua: Detached
>> [ 1772.169446] BUG: kernel NULL pointer dereference, address:
>0000000000000000
>> [ 1772.170881] #PF: supervisor instruction fetch in kernel mode
>> [ 1772.172297] #PF: error=5Fcode(0x0010) - not-present page
>> [ 1772.173751] PGD 0 P4D 0
>> [ 1772.175165] Oops: 0010 [#1] SMP PTI
>> [ 1772.176575] CPU: 3 PID: 8654 Comm: kworker/3:60 Not tainted
>5.15.0-rc1+ #4
>> [ 1772.177995] Hardware name: To Be Filled By O.E.M. To Be Filled
>By O.E.M./Z77 Extreme6, BIOS P2.80 07/01/2013
>> [ 1772.179430] Workqueue: srp=5Fremove srp=5Fremove=5Fwork [ib=5Fsrp]
>> [ 1772.180859] RIP: 0010:0x0
>> [ 1772.182276] Code: Unable to access opcode bytes at RIP
>0xffffffffffffffd6.
>> [ 1772.183705] RSP: 0018:ffffa9710a2f7b68 EFLAGS: 00010086
>> [ 1772.185129] RAX: 0000000000000001 RBX: ffffa9710a2f7c50 RCX:
>0000000000000000
>> [ 1772.186566] RDX: 0000000000000000 RSI: ffffa9710a2f7c08 RDI:
>ffff91a703825a00
>> [ 1772.187994] RBP: ffffa9710a2f7bb0 R08: ffff91a7184f8300 R09:
>0000000000000000
>> [ 1772.189425] R10: ffff91a7869ce000 R11: ffffa9710a2f7d00 R12:
>ffff91a703825a00
>> [ 1772.190848] R13: 0000000000000002 R14: 0000000000000000 R15:
>ffffa9710a2f7c08
>> [ 1772.192270] FS:  0000000000000000(0000)
>GS:ffff91a817780000(0000) knlGS:0000000000000000
>> [ 1772.193689] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1772.195118] CR2: ffffffffffffffd6 CR3: 0000000111458006 CR4:
>00000000001706e0
>> [ 1772.196558] Call Trace:
>> [ 1772.197975]  =5F=5Fib=5Fprocess=5Fcq+0x89/0x150 [ib=5Fcore]
>> [ 1772.199402]  ib=5Fprocess=5Fcq=5Fdirect+0x30/0x50 [ib=5Fcore]
>> [ 1772.200830]  ? put=5Fcpu=5Fpartial+0x98/0xb0
>> [ 1772.202260]  ? =5F=5Fslab=5Ffree+0x226/0x3c0
>> [ 1772.203664]  ? =5F=5Fslab=5Ffree+0x226/0x3c0
>> [ 1772.205038]  ? xas=5Fstore+0x331/0x640
>> [ 1772.206404]  ? rxe=5Felem=5Frelease+0x4f/0x60 [rdma=5Frxe]
>> [ 1772.207763]  ? kfree+0x372/0x3b0
>> [ 1772.209101]  ? srp=5Fdestroy=5Ffr=5Fpool+0x43/0x50 [ib=5Fsrp]
>> [ 1772.210439]  srp=5Fdestroy=5Fqp+0x24/0x40 [ib=5Fsrp]
>> [ 1772.211759]  srp=5Ffree=5Fch=5Fib+0x77/0x180 [ib=5Fsrp]
>> [ 1772.213093]  srp=5Fremove=5Fwork+0xde/0x1a0 [ib=5Fsrp]
>> [ 1772.214417]  process=5Fone=5Fwork+0x1d0/0x380
>> [ 1772.215756]  worker=5Fthread+0x37/0x390
>> [ 1772.217082]  ? process=5Fone=5Fwork+0x380/0x380
>> [ 1772.218422]  kthread+0x12f/0x150
>> [ 1772.219744]  ? set=5Fkthread=5Fstruct+0x40/0x40
>> [ 1772.221059]  ret=5Ffrom=5Ffork+0x22/0x30
>>
>>
>> Many thanks,
>> Bernard.
>>
>>
>
