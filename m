Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A9F466027
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Dec 2021 10:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345896AbhLBJMJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Dec 2021 04:12:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345955AbhLBJMI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Dec 2021 04:12:08 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B27HU2V003178
        for <linux-rdma@vger.kernel.org>; Thu, 2 Dec 2021 09:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : message-id : content-transfer-encoding :
 content-type : mime-version : references; s=pp1;
 bh=EmoClDcvXEEqEaVrlz9WzA0fr6cdapreX/FUnpqY60g=;
 b=hKW35EI80Z+1wL/Y8h1H1EobkBuqW90XBt2N2TfFWlrD7qce8LZFOASmGPM1iSXHZ1cG
 hAOcqyYfLFMGdGwO6ZjLOkhPeFnk7WIikyFdnKQPEwqoGgVM9y9/Tj4vLonboZutjh3k
 KhJ9qawdts6dV2ShBo7xfXwgRvey3BucbaRbL2ipTIllbmNmKA4ApWOGleSsYD7Tjah1
 QLb4qI+t/Y6CpdecqrsLgN3O0hhJUuTA81fTecoLpscYjX+UFYsuxw1oqcEK9zFtHES7
 dAesCa0/npuG1nqsjF6ZUyRQR1nrfYw8nBhlDpXmshmoUAFswETuKX2BPd+4Y7BFUSnA kA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpsmhj39k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 02 Dec 2021 09:08:46 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B2937hX013359
        for <linux-rdma@vger.kernel.org>; Thu, 2 Dec 2021 09:08:45 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 3ckcacgx6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 02 Dec 2021 09:08:45 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B298iao43188692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Thu, 2 Dec 2021 09:08:44 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B9D4AC05F
        for <linux-rdma@vger.kernel.org>; Thu,  2 Dec 2021 09:08:44 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DFE5AC064
        for <linux-rdma@vger.kernel.org>; Thu,  2 Dec 2021 09:08:44 +0000 (GMT)
Received: from mww0301.wdc07m.mail.ibm.com (unknown [9.208.64.45])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS
        for <linux-rdma@vger.kernel.org>; Thu,  2 Dec 2021 09:08:44 +0000 (GMT)
In-Reply-To: <CAHj4cs9_ZuMnrP9=E-jP7mBZ87Et1ne0VTfQiQGq284XrbbOnw@mail.gmail.com>
Subject: Re: [bug report] blktests srp/011 hang at "ib_srpt
 srpt_disconnect_ch_sync:still waiting ..."
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Yi Zhang" <yi.zhang@redhat.com>
Cc:     "RDMA mailing list" <linux-rdma@vger.kernel.org>
Date:   Thu, 2 Dec 2021 09:08:41 +0000
Message-ID: <OF7DCA0693.A962F168-ON0025879F.00323BE5-0025879F.00323C14@ibm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <CAHj4cs9_ZuMnrP9=E-jP7mBZ87Et1ne0VTfQiQGq284XrbbOnw@mail.gmail.com>
X-Mailer: Lotus Domino Web Server Release 11.0.1FP2HF117   October 6, 2021
X-MIMETrack: Serialize by http on MWW0301/01/M/IBM at 12/02/2021 09:08:42,Serialize
 complete at 12/02/2021 09:08:42
X-Disclaimed: 38199
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IWsFiIuclplFES8wpepYN1I0y8j7u1DH
X-Proofpoint-ORIG-GUID: IWsFiIuclplFES8wpepYN1I0y8j7u1DH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112020054
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Yi Zhang" <yi.zhang@redhat.com> wrote: -----

>To: "RDMA mailing list" <linux-rdma@vger.kernel.org>
>From: "Yi Zhang" <yi.zhang@redhat.com>
>Date: 12/01/2021 09:55AM
>Subject: [EXTERNAL] [bug report] blktests srp/011 hang at "ib=5Fsrpt
>srpt=5Fdisconnect=5Fch=5Fsync:still waiting ..."
>
>Hello
>I found blktest srp/011 hang on latest 5.16.0-rc3+, and from dmesg I
>can see kernel repeat printing "ib=5Fsrpt srpt=5Fdisconnect=5Fch=5Fsync:st=
ill
>waiting ...".
>Pls help check it and let me know if you need any info/testing for
>it, thanks.
>

Is this bug happening only when using siw, or also happening with
rxe?

I'll try to recreate.


Thanks,
Bernard.

>[root@gigabyte-r120-11 blktests]# use=5Fsiw=3D1 ./check srp/011
>-------------> hang
>srp/011 (Block I/O on top of multipath concurrently with logout and
>login) [passed]
>    runtime  52.731s  ...  61.351s
>
>dmesg:
>[  101.614632] run blktests srp/011 at 2021-12-01 03:43:24
>[  102.493106] alua: device handler registered
>[  102.519148] emc: device handler registered
>[  102.540806] rdac: device handler registered
>[  102.608792] null=5Fblk: module loaded
>[  103.031132] SoftiWARP attached
>[  103.067829] enP2p1s0v1 speed is unknown, defaulting to 1000
>[  103.073399] enP2p1s0v1 speed is unknown, defaulting to 1000
>[  103.079038] enP2p1s0v1 speed is unknown, defaulting to 1000
>[  103.093348] enP2p1s0v1 speed is unknown, defaulting to 1000
>[  103.111956] enP2p1s0v1 speed is unknown, defaulting to 1000
>[  103.130870] enP2p1s0v1 speed is unknown, defaulting to 1000
>[  103.141017] enP2p1s0v4 speed is unknown, defaulting to 1000
>[  103.146585] enP2p1s0v4 speed is unknown, defaulting to 1000
>[  103.152374] enP2p1s0v4 speed is unknown, defaulting to 1000
>[  103.166691] enP2p1s0v1 speed is unknown, defaulting to 1000
>[  103.172623] enP2p1s0v4 speed is unknown, defaulting to 1000
>[  103.191728] enP2p1s0v1 speed is unknown, defaulting to 1000
>[  103.197641] enP2p1s0v4 speed is unknown, defaulting to 1000
>[  103.380984] scsi=5Fdebug:sdebug=5Fadd=5Fstore: dif=5Fstorep 524288 byte=
s @
>0000000068763489
>[  103.389445] scsi=5Fdebug:sdebug=5Fdriver=5Fprobe: scsi=5Fdebug: trim
>poll=5Fqueues to 0. poll=5Fq/nr=5Fhw =3D (0/1)
>[  103.398577] scsi=5Fdebug:sdebug=5Fdriver=5Fprobe: host protection DIF3
>DIX3
>[  103.405018] scsi host4: scsi=5Fdebug: version 0190 [20200710]
>[  103.405018]   dev=5Fsize=5Fmb=3D32, opts=3D0x0, submit=5Fqueues=3D1,
>statistics=3D0
>[  103.417664] scsi 4:0:0:0: Direct-Access     Linux    scsi=5Fdebug
>  0190 PQ: 0 ANSI: 7
>[  103.426302] sd 4:0:0:0: Power-on or device reset occurred
>[  103.426368] sd 4:0:0:0: Attached scsi generic sg1 type 0
>[  103.431800] sd 4:0:0:0: [sdb] Enabling DIF Type 3 protection
>[  103.442794] sd 4:0:0:0: [sdb] 65536 512-byte logical blocks: (33.6
>MB/32.0 MiB)
>[  103.450168] sd 4:0:0:0: [sdb] Write Protect is off
>[  103.454958] sd 4:0:0:0: [sdb] Mode Sense: 73 00 10 08
>[  103.455020] sd 4:0:0:0: [sdb] Write cache: enabled, read cache:
>enabled, supports DPO and FUA
>[  103.463665] sd 4:0:0:0: [sdb] Optimal transfer size 524288 bytes
>[  103.567989] sd 4:0:0:0: [sdb] Enabling DIX T10-DIF-TYPE3-CRC
>protection
>[  103.574602] sd 4:0:0:0: [sdb] DIF application tag size 6
>[  103.757781] sd 4:0:0:0: [sdb] Attached SCSI disk
>[  104.620435] enP2p1s0v1 speed is unknown, defaulting to 1000
>[  104.805722] enP2p1s0v4 speed is unknown, defaulting to 1000
>[  105.168234] Rounding down aligned max=5Fsectors from 4294967295 to
>4294967288
>[  105.313416] ib=5Fsrpt:srpt=5Fadd=5Fone: ib=5Fsrpt device =3D
>0000000043289393
>[  105.313438] ib=5Fsrpt:srpt=5Fuse=5Fsrq: ib=5Fsrpt
>srpt=5Fuse=5Fsrq(enP2p1s0v0=5Fsiw): use=5Fsrq =3D 0; ret[  101.614632] run
>blktests srp/011 at 2021-12-01 03:43:24
>[  102.493106] alua: device handler registered
>[  102.519148] emc: device handler registered
>[  102.540806] rdac: device handler registered
>[  102.608792] null=5Fblk: module loaded
>[  103.031132] SoftiWARP attached
>[  103.067829] enP2p1s0v1 speed is unknown, defaulting to 1000
>[  103.073399] enP2p1s0v1 speed is unknown, defaulting to 1000
>[  103.079038] enP2p1s0v1 speed is unknown, defaulting to 1000
>[  103.093348] enP2p1s0v1 speed is unknown, defaulting to 1000
>[  103.111956] enP2p1s0v1 speed is unknown, defaulting to 1000
>[  103.130870] enP2p1s0v1 speed is unknown, defaulting to 1000
>[  103.141017] enP2p1s0v4 speed is unknown, defaulting to 1000
>[  103.146585] enP2p1s0v4 speed is unknown, defaulting to 1000
>[  103.152374] enP2p1s0v4 speed is unknown, defaulting to 1000
>[  103.166691] enP2p1s0v1 speed is unknown, defaulting to 1000
>[  103.172623] enP2p1s0v4 speed is unknown, defaulting to 1000
>[  103.191728] enP2p1s0v1 speed is unknown, defaulting to 1000
>[  103.197641] enP2p1s0v4 speed is unknown, defaulting to 1000
>[  103.380984] scsi=5Fdebug:sdebug=5Fadd=5Fstore: dif=5Fstorep 524288 byte=
s @
>0000000068763489
>[  103.389445] scsi=5Fdebug:sdebug=5Fdriver=5Fprobe: scsi=5Fdebug: trim
>poll=5Fqueues to 0. poll=5Fq/nr=5Fhw =3D (0/1)
>[  103.398577] scsi=5Fdebug:sdebug=5Fdriver=5Fprobe: host protection DIF3
>DIX3
>[  103.405018] scsi host4: scsi=5Fdebug: version 0190 [20200710]
>[  103.405018]   dev=5Fsize=5Fmb=3D32, opts=3D0x0, submit=5Fqueues=3D1,
>statistics=3D0
>[  103.417664] scsi 4:0:0:0: Direct-Access     Linux    scsi=5Fdebug
>  0190 PQ: 0 ANSI: 7
>[  103.426302] sd 4:0:0:0: Power-on or device reset occurred
>[  103.426368] sd 4:0:0:0: Attached scsi generic sg1 type 0
>[  103.431800] sd 4:0:0:0: [sdb] Enabling DIF Type 3 protection
>[  103.442794] sd 4:0:0:0: [sdb] 65536 512-byte logical blocks: (33.6
>MB/32.0 MiB)
>[  103.450168] sd 4:0:0:0: [sdb] Write Protect is off
>[  103.454958] sd 4:0:0:0: [sdb] Mode Sense: 73 00 10 08
>[  103.455020] sd 4:0:0:0: [sdb] Write cache: enabled, read cache:
>enabled, supports DPO and FUA
>[  103.463665] sd 4:0:0:0: [sdb] Optimal transfer size 524288 bytes
>[  103.567989] sd 4:0:0:0: [sdb] Enabling DIX T10-DIF-TYPE3-CRC
>protection
>[  103.574602] sd 4:0:0:0: [sdb] DIF application tag size 6
>[  103.757781] sd 4:0:0:0: [sdb] Attached SCSI disk
>[  104.620435] enP2p1s0v1 speed is unknown, defaulting to 1000
>[  104.805722] enP2p1s0v4 speed is unknown, defaulting to 1000
>[  105.168234] Rounding down aligned max=5Fsectors from 4294967295 to
>4294967288
>[  105.313416] ib=5Fsrpt:srpt=5Fadd=5Fone: ib=5Fsrpt device =3D
>0000000043289393
>[  105.313438] ib=5Fsrpt:srpt=5Fuse=5Fsrq: ib=5Fsrpt
>srpt=5Fuse=5Fsrq(enP2p1s0v0=5Fsiw): use=5Fsrq =3D 0; ret
>--snip--
>[  172.857740] ib=5Fsrpt:srpt=5Frelease=5Fchannel=5Fwork: ib=5Fsrpt
>2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-63
>[  172.857885] ib=5Fsrpt:srpt=5Frelease=5Fchannel=5Fwork: ib=5Fsrpt
>2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-66
>[  172.858032] ib=5Fsrpt:srpt=5Frelease=5Fchannel=5Fwork: ib=5Fsrpt
>2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-68
>[  172.858185] ib=5Fsrpt:srpt=5Frelease=5Fchannel=5Fwork: ib=5Fsrpt
>2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-70
>[  172.858344] ib=5Fsrpt:srpt=5Frelease=5Fchannel=5Fwork: ib=5Fsrpt
>2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-72
>[  172.858501] ib=5Fsrpt:srpt=5Frelease=5Fchannel=5Fwork: ib=5Fsrpt
>2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-74
>[  172.858666] ib=5Fsrpt:srpt=5Frelease=5Fchannel=5Fwork: ib=5Fsrpt
>2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-76
>[  172.858822] ib=5Fsrpt:srpt=5Frelease=5Fchannel=5Fwork: ib=5Fsrpt
>2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-78
>[  172.858976] ib=5Fsrpt:srpt=5Frelease=5Fchannel=5Fwork: ib=5Fsrpt
>2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-80
>[  172.859120] ib=5Fsrpt:srpt=5Frelease=5Fchannel=5Fwork: ib=5Fsrpt
>2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-82
>[  172.859278] ib=5Fsrpt:srpt=5Frelease=5Fchannel=5Fwork: ib=5Fsrpt
>2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-84
>[  172.859426] ib=5Fsrpt:srpt=5Frelease=5Fchannel=5Fwork: ib=5Fsrpt
>2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-86
>[  172.859564] ib=5Fsrpt:srpt=5Frelease=5Fchannel=5Fwork: ib=5Fsrpt
>2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-88
>[  172.859706] ib=5Fsrpt:srpt=5Frelease=5Fchannel=5Fwork: ib=5Fsrpt
>2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-90
>[  172.859851] ib=5Fsrpt:srpt=5Frelease=5Fchannel=5Fwork: ib=5Fsrpt
>2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-92
>[  173.439406] ib=5Fsrpt:srpt=5Fdisconnect=5Fch=5Fsync: ib=5Fsrpt ch
>2620:0052:0000:13f0:a236:9fff:fe79:eb22-62 state 4
>[  178.456609] ib=5Fsrpt
>srpt=5Fdisconnect=5Fch=5Fsync(2620:0052:0000:13f0:a236:9fff:fe79:eb22-62
>state 4): still waiting ...
>[  183.496506] ib=5Fsrpt
>srpt=5Fdisconnect=5Fch=5Fsync(2620:0052:0000:13f0:a236:9fff:fe79:eb22-62
>state 4): still waiting ...
>[  188.536450] ib=5Fsrpt
>srpt=5Fdisconnect=5Fch=5Fsync(2620:0052:0000:13f0:a236:9fff:fe79:eb22-62
>state 4): still waiting ...
>[  193.576351] ib=5Fsrpt
>srpt=5Fdisconnect=5Fch=5Fsync(2620:0052:0000:13f0:a236:9fff:fe79:eb22-62
>state 4): still waiting ...
>[  198.616280] ib=5Fsrpt
>srpt=5Fdisconnect=5Fch=5Fsync(2620:0052:0000:13f0:a236:9fff:fe79:eb22-62
>state 4): still waiting ...
>
>
>--=20
>Best Regards,
>  Yi Zhang
>
>
