Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019A040F404
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Sep 2021 10:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbhIQIZA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Sep 2021 04:25:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233853AbhIQIZA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Sep 2021 04:25:00 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18H6upso007049;
        Fri, 17 Sep 2021 04:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : message-id : mime-version : references :
 content-type : content-transfer-encoding; s=pp1;
 bh=s4+vPuYbUE1KaqMf19N/hf8WgRZvcSvFH64qNSrNPiQ=;
 b=dssTAXlmKAzRaTRLP1whT6LjeDhvfbrZ5+webvT/0cfAYbe/98NDLvWzepW6zru8Z87J
 9WpJ8JfhmfMLcDnB/7lD59XViIa3SpojPWjKJr1vNJoDus9ivUTiwsbZ0IohaofHGE1Z
 nYBwvj9vwjfoaVPJ7HT963vVh9SoxQHvLiXxIy4bVDehbyC5POyc23eXT/xP0HlG5f+8
 VRZCJYm5o+Sg0sFAvJoM0+kas9EwJtdwJz7TasoAkI3M3eXpHAfIlIHzOGcqPOZ3olb6
 V1d2+ZTa14+k7Kyd8qowthh1I88H0Jl4dBfHtmnOobaqfSgz5/jHaHB/g8r+ZyE/OiHM 7A== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b4g6f8nyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 04:23:35 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18H8CDrY003032;
        Fri, 17 Sep 2021 08:23:35 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 3b0m3dby5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 08:23:34 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18H8NXge34275740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 08:23:33 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 882357806D;
        Fri, 17 Sep 2021 08:23:33 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C20A78063;
        Fri, 17 Sep 2021 08:23:33 +0000 (GMT)
Received: from mww0302.dal12m.mail.ibm.com (unknown [9.208.69.16])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 17 Sep 2021 08:23:33 +0000 (GMT)
In-Reply-To: <CAHj4cs9Rzte5zbgy7o158m7JA8dbSEpxy5oR-+K0NQCK1gxG=Q@mail.gmail.com>
Subject: Re: Re: Issus with blktest/srp on 5.15-rc1 and rdma_rxe
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Yi Zhang" <yi.zhang@redhat.com>
Cc:     "Robert Pearson" <rpearsonhpe@gmail.com>,
        "linux-rdma" <linux-rdma@vger.kernel.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        "Bart Van Assche" <bvanassche@acm.org>
Date:   Fri, 17 Sep 2021 08:23:32 +0000
Message-ID: <OFC7347FF0.D24DF679-ON00258753.002DFE5F-00258753.002E19D7@ibm.com>
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <CAHj4cs9Rzte5zbgy7o158m7JA8dbSEpxy5oR-+K0NQCK1gxG=Q@mail.gmail.com>,<OF54F8428F.7EA7E570-ON00258752.006AB21B-00258752.006BBB93@ibm.com>
 <CAFc_bgaH=fYMtKO-pJ0=KMU=d1wafDwWid8AoZsPhjpT9GdSDQ@mail.gmail.com>
X-Mailer: Lotus Domino Web Server Release 11.0.1FP2HF114   September 2, 2021
X-MIMETrack: Serialize by http on MWW0302/03/M/IBM at 09/17/2021 08:23:32,Serialize
 complete at 09/17/2021 08:23:32
X-KeepSent: C7347FF0:D24DF679-00258753:002DFE5F; name=$KeepSent; type=4
X-Disclaimed: 41619
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oRzV3_WiV9WuTpSgB2WhgBf7GRtqBf1u
X-Proofpoint-ORIG-GUID: oRzV3_WiV9WuTpSgB2WhgBf7GRtqBf1u
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_04,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 adultscore=0 clxscore=1015 mlxscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170051
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Yi Zhang" <yi.zhang@redhat.com> wrote: -----

>To: "Robert Pearson" <rpearsonhpe@gmail.com>
>From: "Yi Zhang" <yi.zhang@redhat.com>
>Date: 09/17/2021 09:29AM
>Cc: "Bernard Metzler" <BMT@zurich.ibm.com>, "linux-rdma"
><linux-rdma@vger.kernel.org>, "Jason Gunthorpe" <jgg@nvidia.com>,
>"Bart Van Assche" <bvanassche@acm.org>
>Subject: [EXTERNAL] Re: Issus with blktest/srp on 5.15-rc1 and
>rdma_rxe
>
>                    On Fri, Sep 17, 2021 at 6:21 AM Robert Pearson
><rpearsonhpe@gmail.com> wrote: Bernard, That would indicate that you
>have not applied the patch series RDMA/rxe: Fix various bugs which
>fixes the rkey not match rxe bug. I do not know how
>
>=20=20=20=20=20
>
>
>On Fri, Sep 17, 2021 at 6:21 AM Robert Pearson
><rpearsonhpe@gmail.com> wrote:
>Bernard,
> That would indicate that you have not applied the patch series
> RDMA/rxe: Fix various bugs which fixes the rkey not match rxe bug.
> I do not know how to get it to select the siw device instead of the
>rxe
> device but Bart does.
>=20
>
>Just try use_siw=3D1 ./check -q srp/005

srp/015 seem to be dedicated to siw testing. It selects siw if available.
I think this is how Bart found it.
Unfortunately, for some reason I am not aware of, testing defaults to
rxe only for the other tests. Maybe at least the helper should
talk about this hidden option.

Thanks,
Bernard.

>  Bob
>=20
> On Thu, Sep 16, 2021 at 2:36 PM Bernard Metzler <BMT@zurich.ibm.com>
>wrote:
> >
> > Hi,
> >
> > if I run the complete srp test series from the blktests suite,
> > the dmesg log contains many rdma_rxe messages of type:
> >
> > rdma_rxe: rxe_invalidate_mr: rkey (n) doesn't match mr->ibmr.rkey
>(n + 1)
> >
> > where 'n' is the current key. I expect this is not intended
> > behavior.
> >
> > I am at commit 1b789bd4dbd48a92f5427d9c37a72a8f6ca17754
> >
> >
> >
> > Furthermore, running ./check -q srp/005 sometimes I get this:
> >
> > [  308.903330] sd 11:0:0:1: [sde] Attached SCSI disk
> > [  308.917293] scsi 11:0:0:1: alua: Detached
> > [  308.918191] BUG: kernel NULL pointer dereference, address:
>0000000000000000
> > [  308.918223] #PF: supervisor instruction fetch in kernel mode
> > [  308.918242] #PF: error_code(0x0010) - not-present page
> > [  308.918259] PGD 0 P4D 0
> > [  308.918271] Oops: 0010 [#1] SMP PTI
> > [  308.918285] CPU: 1 PID: 4214 Comm: kworker/1:255 Not tainted
>5.15.0-rc1+ #4
> > [  308.918309] Hardware name: To Be Filled By O.E.M. To Be Filled
>By O.E.M./Z77 Extreme6, BIOS P2.80 07/01/2013
> > [  308.918338] Workqueue: srp_remove srp_remove_work [ib_srp]
> > [  308.918362] RIP: 0010:0x0
> > [  308.918375] Code: Unable to access opcode bytes at RIP
>0xffffffffffffffd6.
> > [  308.918397] RSP: 0018:ffffb6124b9a3b68 EFLAGS: 00010086
> > [  308.918414] RAX: 0000000000000001 RBX: ffffb6124b9a3ce0 RCX:
>0000000000000000
> > [  308.918437] RDX: 0000000000000000 RSI: ffffb6124b9a3c50 RDI:
>ffff966063a27a00
> > [  308.918459] RBP: ffffb6124b9a3bb0 R08: ffff966067481c00 R09:
>ffffeb578489b808
> > [  308.918481] R10: ffff966043c0f200 R11: ffffb6124b9a3d00 R12:
>ffff966063a27a00
> > [  308.918503] R13: 0000000000000004 R14: 0000000000000000 R15:
>ffffb6124b9a3c50
> > [  308.918524] FS:  0000000000000000(0000)
>GS:ffff966157680000(0000) knlGS:0000000000000000
> > [  308.918550] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  308.918568] CR2: ffffffffffffffd6 CR3: 000000005060a004 CR4:
>00000000001706e0
> > [  308.918590] Call Trace:
> > [  308.918601]  __ib_process_cq+0x89/0x150 [ib_core]
> > [  308.918640]  ib_process_cq_direct+0x30/0x50 [ib_core]
> > [  308.918669]  ? xas_store+0x331/0x640
> > [  308.918684]  ? free_unref_page_commit.isra.135+0x91/0x140
> > [  308.918705]  ? free_unref_page+0x6e/0xd0
> > [  308.918719]  ? __free_pages+0xa3/0xc0
> > [  308.918733]  ? kfree+0x32f/0x3b0
> > [  308.918748]  srp_destroy_qp+0x24/0x40 [ib_srp]
> > [  308.918767]  srp_free_ch_ib+0x77/0x180 [ib_srp]
> > [  308.918784]  srp_remove_work+0xde/0x1a0 [ib_srp]
> > [  308.918801]  process_one_work+0x1d0/0x380
> > [  308.918817]  worker_thread+0x37/0x390
> > [  308.918831]  ? process_one_work+0x380/0x380
> > [  308.918846]  kthread+0x12f/0x150
> > [  308.918859]  ? set_kthread_struct+0x40/0x40
> > [  308.918874]  ret_from_fork+0x22/0x30
> >
> >
> > With ./check -q srp/008 I sometimes get something similar:
> >
> > [ 1772.149274] sd 11:0:0:1: [sde] Attached SCSI disk
> > [ 1772.150096] scsi 11:0:0:2: alua: Detached
> > [ 1772.150184] blk_update_request: I/O error, dev sde, sector 8 op
>0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > [ 1772.151653] blk_update_request: I/O error, dev sde, sector 8 op
>0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> > [ 1772.153080] Buffer I/O error on dev sde, logical block 1, async
>page read
> > [ 1772.169139] scsi 11:0:0:1: alua: Detached
> > [ 1772.169446] BUG: kernel NULL pointer dereference, address:
>0000000000000000
> > [ 1772.170881] #PF: supervisor instruction fetch in kernel mode
> > [ 1772.172297] #PF: error_code(0x0010) - not-present page
> > [ 1772.173751] PGD 0 P4D 0
> > [ 1772.175165] Oops: 0010 [#1] SMP PTI
> > [ 1772.176575] CPU: 3 PID: 8654 Comm: kworker/3:60 Not tainted
>5.15.0-rc1+ #4
> > [ 1772.177995] Hardware name: To Be Filled By O.E.M. To Be Filled
>By O.E.M./Z77 Extreme6, BIOS P2.80 07/01/2013
> > [ 1772.179430] Workqueue: srp_remove srp_remove_work [ib_srp]
> > [ 1772.180859] RIP: 0010:0x0
> > [ 1772.182276] Code: Unable to access opcode bytes at RIP
>0xffffffffffffffd6.
> > [ 1772.183705] RSP: 0018:ffffa9710a2f7b68 EFLAGS: 00010086
> > [ 1772.185129] RAX: 0000000000000001 RBX: ffffa9710a2f7c50 RCX:
>0000000000000000
> > [ 1772.186566] RDX: 0000000000000000 RSI: ffffa9710a2f7c08 RDI:
>ffff91a703825a00
> > [ 1772.187994] RBP: ffffa9710a2f7bb0 R08: ffff91a7184f8300 R09:
>0000000000000000
> > [ 1772.189425] R10: ffff91a7869ce000 R11: ffffa9710a2f7d00 R12:
>ffff91a703825a00
> > [ 1772.190848] R13: 0000000000000002 R14: 0000000000000000 R15:
>ffffa9710a2f7c08
> > [ 1772.192270] FS:  0000000000000000(0000)
>GS:ffff91a817780000(0000) knlGS:0000000000000000
> > [ 1772.193689] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1772.195118] CR2: ffffffffffffffd6 CR3: 0000000111458006 CR4:
>00000000001706e0
> > [ 1772.196558] Call Trace:
> > [ 1772.197975]  __ib_process_cq+0x89/0x150 [ib_core]
> > [ 1772.199402]  ib_process_cq_direct+0x30/0x50 [ib_core]
> > [ 1772.200830]  ? put_cpu_partial+0x98/0xb0
> > [ 1772.202260]  ? __slab_free+0x226/0x3c0
> > [ 1772.203664]  ? __slab_free+0x226/0x3c0
> > [ 1772.205038]  ? xas_store+0x331/0x640
> > [ 1772.206404]  ? rxe_elem_release+0x4f/0x60 [rdma_rxe]
> > [ 1772.207763]  ? kfree+0x372/0x3b0
> > [ 1772.209101]  ? srp_destroy_fr_pool+0x43/0x50 [ib_srp]
> > [ 1772.210439]  srp_destroy_qp+0x24/0x40 [ib_srp]
> > [ 1772.211759]  srp_free_ch_ib+0x77/0x180 [ib_srp]
> > [ 1772.213093]  srp_remove_work+0xde/0x1a0 [ib_srp]
> > [ 1772.214417]  process_one_work+0x1d0/0x380
> > [ 1772.215756]  worker_thread+0x37/0x390
> > [ 1772.217082]  ? process_one_work+0x380/0x380
> > [ 1772.218422]  kthread+0x12f/0x150
> > [ 1772.219744]  ? set_kthread_struct+0x40/0x40
> > [ 1772.221059]  ret_from_fork+0x22/0x30
> >
> >
> > Many thanks,
> > Bernard.
> >
> >
>=20
>=20
>
>--=20
>Best Regards,
>  Yi Zhang=20=20
