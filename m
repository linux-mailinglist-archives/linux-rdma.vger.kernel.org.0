Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18D030A8A8
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Feb 2021 14:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhBAN1i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Feb 2021 08:27:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231145AbhBAN1g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Feb 2021 08:27:36 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 111D2Q4g163281
        for <linux-rdma@vger.kernel.org>; Mon, 1 Feb 2021 08:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : from : to
 : cc : date : mime-version : references : content-transfer-encoding :
 content-type : message-id : subject; s=pp1;
 bh=PuJdfShk/+PYpoFd6yISN4aXVlZBH0jy69DYDXB4Big=;
 b=XMn+wIRJHFqnhVBJ/MOJNre31SEHJU5fJFV6vxE37PpmK2EcPBESYDj7wHRalIrqnko4
 xh1ctQfduX1y4eYJ3IIk6DUpBDMDVizIzxR3E2zW3wc/IV7EgSiXxQ9ZGrKeGhdx+aAH
 8XELcF4X9fc83AHeQ3KL+XqJdCq9QEKXn/dibACil1i0KDKw8Uak9cyJ+NMKg4ge5i4g
 AW3zXxvgfrhm3Pnao0zY+dJTJwuPCyvkni1kTheW/VWLtGqFqak8Uc0wKop/00o6VHh7
 QjERMmqcju4/2rd2YW9rxWetoU7UQ3TrzxxbG1p2N5Eepk+/UWKlfyQJ0tahTvUXl2tE vg== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ej608nyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 01 Feb 2021 08:26:54 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 1 Feb 2021 13:26:49 -0000
Received: from us1b3-smtp07.a3dr.sjc01.isc4sb.com (10.122.203.198)
        by smtp.notes.na.collabserv.com (10.122.47.39) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 1 Feb 2021 13:26:47 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp07.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021020113264608-373691 ;
          Mon, 1 Feb 2021 13:26:46 +0000 
In-Reply-To: <20210201112922.141085-1-kamalheib1@gmail.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Kamal Heib" <kamalheib1@gmail.com>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>,
        "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
Date:   Mon, 1 Feb 2021 13:26:46 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20210201112922.141085-1-kamalheib1@gmail.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: 20B9AA82:73348CC3-0025866F:0049DCAB;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 45439
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21020113-6283-0000-0000-0000045914DB
X-IBM-SpamModules-Scores: BY=0.292785; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.068525
X-IBM-SpamModules-Versions: BY=3.00014660; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01501460; UDB=6.00810301; IPR=6.01283996;
 MB=3.00035998; MTD=3.00000008; XFM=3.00000015; UTC=2021-02-01 13:26:47
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-02-01 08:43:05 - 6.00012266
x-cbparentid: 21020113-6284-0000-0000-000003E21555
Message-Id: <OF20B9AA82.73348CC3-ON0025866F.0049DCAB-0025866F.0049DCB6@notes.na.collabserv.com>
Subject: Re:  [PATCH for-rc] RDMA/siw: Fix calculation of tx_valid_cpus size
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_05:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Kamal Heib" <kamalheib1@gmail.com> wrote: -----

>To: linux-rdma@vger.kernel.org
>From: "Kamal Heib" <kamalheib1@gmail.com>
>Date: 02/01/2021 12:30PM
>Cc: "Bernard Metzler" <bmt@zurich.ibm.com>, "Doug Ledford"
><dledford@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Kamal Heib"
><kamalheib1@gmail.com>
>Subject: [EXTERNAL] [PATCH for-rc] RDMA/siw: Fix calculation of
>tx=5Fvalid=5Fcpus size
>
>The size of tx=5Fvalid=5Fcpus was calculated under the assumption that
>the
>numa nodes identifiers are continuous, which is not the case in all
>archs as this could lead to the following panic when trying to access
>an
>invalid tx=5Fvalid=5Fcpus index, avoid the following panic by using
>nr=5Fnode=5Fids instead of num=5Fonline=5Fnodes() to allocate the
>tx=5Fvalid=5Fcpus
>size.
>

Uuups! Thanks for fixing this. nr=5Fnode=5Fids is indeed the right
resource here, since it's set reflecting the highest bit + 1
from node=5Fpossible=5Fmap.bits.

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>


>Kernel attempted to read user page (8) - exploit attempt? (uid: 0)
>BUG: Kernel NULL pointer dereference on read at 0x00000008
>Faulting instruction address: 0xc0080000081b4a90
>Oops: Kernel access of bad area, sig: 11 [#1]
>LE PAGE=5FSIZE=3D64K MMU=3DRadix SMP NR=5FCPUS=3D2048 NUMA PowerNV
>Modules linked in: siw(+) rfkill rpcrdma ib=5Fisert iscsi=5Ftarget=5Fmod
>ib=5Fiser libiscsi scsi=5Ftransport=5Fiscsi ib=5Fsrpt target=5Fcore=5Fmod =
ib=5Fsrp
>scsi=5Ftransport=5Fsrp ib=5Fipoib rdma=5Fucm sunrpc ib=5Fumad rdma=5Fcm ib=
=5Fcm
>iw=5Fcm i40iw ib=5Fuverbs ib=5Fcore i40e ses enclosure scsi=5Ftransport=5F=
sas
>ipmi=5Fpowernv ibmpowernv at24 ofpart ipmi=5Fdevintf regmap=5Fi2c
>ipmi=5Fmsghandler powernv=5Fflash uio=5Fpdrv=5Fgenirq uio mtd opal=5Fprd z=
ram
>ip=5Ftables xfs libcrc32c sd=5Fmod t10=5Fpi ast i2c=5Falgo=5Fbit
>drm=5Fvram=5Fhelper drm=5Fkms=5Fhelper syscopyarea sysfillrect sysimgblt
>fb=5Fsys=5Ffops cec drm=5Fttm=5Fhelper ttm drm vmx=5Fcrypto aacraid
>drm=5Fpanel=5Forientation=5Fquirks dm=5Fmod
>CPU: 40 PID: 3279 Comm: modprobe Tainted: G        W      X ---------
>---  5.11.0-0.rc4.129.eln108.ppc64le #2
>NIP:  c0080000081b4a90 LR: c0080000081b4a2c CTR: c0000000007ce1c0
>REGS: c000000027fa77b0 TRAP: 0300   Tainted: G        W      X
>--------- ---   (5.11.0-0.rc4.129.eln108.ppc64le)
>MSR:  9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 44224882
>XER: 00000000
>CFAR: c0000000007ce200 DAR: 0000000000000008 DSISR: 40000000 IRQMASK:
>0
>GPR00: c0080000081b4a2c c000000027fa7a50 c0080000081c3900
>0000000000000040
>GPR04: c000000002023080 c000000012e1c300 000020072ad70000
>0000000000000001
>GPR08: c000000001726068 0000000000000008 0000000000000008
>c0080000081b5758
>GPR12: c0000000007ce1c0 c0000007fffc3000 00000001590b1e40
>0000000000000000
>GPR16: 0000000000000000 0000000000000001 000000011ad68fc8
>00007fffcc09c5c8
>GPR20: 0000000000000008 0000000000000000 00000001590b2850
>00000001590b1d30
>GPR24: 0000000000043d68 000000011ad67a80 000000011ad67a80
>0000000000100000
>GPR28: c000000012e1c300 c0000000020271c8 0000000000000001
>c0080000081bf608
>NIP [c0080000081b4a90] siw=5Finit=5Fcpulist+0x194/0x214 [siw]
>LR [c0080000081b4a2c] siw=5Finit=5Fcpulist+0x130/0x214 [siw]
>Call Trace:
>[c000000027fa7a50] [c0080000081b4a2c] siw=5Finit=5Fcpulist+0x130/0x214
>[siw] (unreliable)
>[c000000027fa7a90] [c0080000081b4e68] siw=5Finit=5Fmodule+0x40/0x2a0
>[siw]
>[c000000027fa7b30] [c0000000000124f4] do=5Fone=5Finitcall+0x84/0x2e0
>[c000000027fa7c00] [c000000000267ffc] do=5Finit=5Fmodule+0x7c/0x350
>[c000000027fa7c90] [c00000000026a180]
>=5F=5Fdo=5Fsys=5Finit=5Fmodule+0x210/0x250
>[c000000027fa7db0] [c0000000000387e4]
>system=5Fcall=5Fexception+0x134/0x230
>[c000000027fa7e10] [c00000000000d660] system=5Fcall=5Fcommon+0xf0/0x27c
>Instruction dump:
>40810044 3d420000 e8bf0000 e88a82d0 3d420000 e90a82c8 792a1f24
>7cc4302a
>7d2642aa 79291f24 7d25482a 7d295214 <7d4048a8> 7d4a3b78 7d4049ad
>40c2fff4
>---[ end trace 813d4c362755dcfc ]---
>
>Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
>Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>---
> drivers/infiniband/sw/siw/siw=5Fmain.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fmain.c
>b/drivers/infiniband/sw/siw/siw=5Fmain.c
>index ee95cf29179d..41c46dfaebf6 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fmain.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fmain.c
>@@ -135,7 +135,7 @@ static struct {
>=20
> static int siw=5Finit=5Fcpulist(void)
> {
>-	int i, num=5Fnodes =3D num=5Fpossible=5Fnodes();
>+	int i, num=5Fnodes =3D nr=5Fnode=5Fids;
>=20
> 	memset(siw=5Ftx=5Fthread, 0, sizeof(siw=5Ftx=5Fthread));
>=20
>--=20
>2.26.2
>
>

