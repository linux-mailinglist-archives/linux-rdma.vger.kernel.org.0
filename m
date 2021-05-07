Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC993764EF
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 14:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhEGMQS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 May 2021 08:16:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhEGMQR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 May 2021 08:16:17 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 147C2Zi0090337
        for <linux-rdma@vger.kernel.org>; Fri, 7 May 2021 08:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=tAqGIUGe/yOapuHeGDRw7M5XYk/0mYnRBhK2+j2Fs1E=;
 b=qnjCjFPWDmZwdAi3DevQP3P52qopHGP2pg0eUqdCQWfoaPxDL31n/c97obeqZd302t7Z
 a7YywzcgOlT9k2qnWZpCZ7kor/RsNBLK+8hOw2dFgHx4lVonNiVGl0GQSOG2LQjDXsuY
 9/NJvWr5Mdrfs5+fdzJieEKqCUp2v74dlpSa8LszinbihPmGZivWes7QglGFAdQrfqKx
 DitHIuU8+3o6Qt8LGzIylmsfpUfxTn8QI1+kTVu3yjZWZO3yUWa/HlIIoNKfDgyyL0rO
 muvzKY1YCT3aDv62Lhn6/16qaVOf55H5DnIZ86nueYG8yg2brwpYpHbfPJXddjQxJtYd Vg== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38d4ka9ayn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 07 May 2021 08:15:17 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 7 May 2021 12:15:17 -0000
Received: from us1b3-smtp07.a3dr.sjc01.isc4sb.com (10.122.203.198)
        by smtp.notes.na.collabserv.com (10.122.47.52) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 7 May 2021 12:15:15 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp07.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021050712151514-243688 ;
          Fri, 7 May 2021 12:15:15 +0000 
In-Reply-To: <1aa26782ef60cc69aa49886a4c478fbbf74a186e.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 01/31] rdma/siw: fix warning in siw_proc_send()
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Fri, 7 May 2021 12:15:15 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <1aa26782ef60cc69aa49886a4c478fbbf74a186e.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: E60A89FE:A92495A7-002586CE:00435069;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 20311
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21050712-3633-0000-0000-000003FF0A7E
X-IBM-SpamModules-Scores: BY=0.213742; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.123075
X-IBM-SpamModules-Versions: BY=3.00014940; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01526391; UDB=6.00825163; IPR=6.01308221;
 MB=3.00036522; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-07 12:15:16
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-22 13:51:17 - 6.00012377
x-cbparentid: 21050712-3634-0000-0000-00002D280AEF
Message-Id: <OFE60A89FE.A92495A7-ON002586CE.00435069-002586CE.0043506D@notes.na.collabserv.com>
X-Proofpoint-ORIG-GUID: jLXevWF5ISvVGZXShfQ7mTZOVPbz_K7p
X-Proofpoint-GUID: jLXevWF5ISvVGZXShfQ7mTZOVPbz_K7p
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-07_04:2021-05-06,2021-05-07 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Stefan Metzmacher" <metze@samba.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Stefan Metzmacher" <metze@samba.org>
>Date: 05/07/2021 01:37AM
>Cc: linux-rdma@vger.kernel.org, "Stefan Metzmacher" <metze@samba.org>
>Subject: [EXTERNAL] [PATCH 01/31] rdma/siw: fix warning in
>siw=5Fproc=5Fsend()
>
>  CC [M]  drivers/infiniband/sw/siw/siw=5Fqp=5Frx.o
>In file included from ./include/linux/wait.h:9:0,
>                 from ./include/linux/net.h:19,
>                 from drivers/infiniband/sw/siw/siw=5Fqp=5Frx.c:8:
>drivers/infiniband/sw/siw/siw=5Fqp=5Frx.c: In function =E2=80=98siw=5Fproc=
=5Fsend=E2=80=99:
>./include/linux/spinlock.h:288:3: warning: =E2=80=98flags=E2=80=99 may be =
used
>uninitialized in this function [-Wmaybe-uninitialized]
>   =5Fraw=5Fspin=5Funlock=5Firqrestore(lock, flags); \
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>drivers/infiniband/sw/siw/siw=5Fqp=5Frx.c:335:16: note: =E2=80=98flags=E2=
=80=99 was
>declared here
>  unsigned long flags;
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fqp=5Frx.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fqp=5Frx.c
>b/drivers/infiniband/sw/siw/siw=5Fqp=5Frx.c
>index 60116f20653c..0170c05d2cc3 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fqp=5Frx.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fqp=5Frx.c
>@@ -333,7 +333,7 @@ static struct siw=5Fwqe *siw=5Frqe=5Fget(struct siw=5F=
qp
>*qp)
> 	struct siw=5Fsrq *srq;
> 	struct siw=5Fwqe *wqe =3D NULL;
> 	bool srq=5Fevent =3D false;
>-	unsigned long flags;
>+	unsigned long flags =3D 0;
>=20
This is not needed. flags are only used if 'srq'
is valid. 'srq' dosen't get reassigned after first check.
Somehow the compiler warning is a false negative.


> 	srq =3D qp->srq;
> 	if (srq) {
>--=20
>2.25.1
>
>

