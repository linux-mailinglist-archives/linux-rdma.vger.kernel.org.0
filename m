Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3D137A61F
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 13:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhEKL5E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 07:57:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230519AbhEKL5D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 07:57:03 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BBZBYP074115
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 07:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=4O8esPIlbw/EyRDqKFAAskho9xILnEgCGE53wwrbb3Y=;
 b=UUg98YuZr5MscZkyQ8KUJdMUdiPTVrcLauIxpv+3OWBHKz1zU4suzZdfhG6NuDjoH6+d
 /q1L9RT3vjDwobz3kAvX8xTLhlZN2b43BIKnh5VAiB97GQ1MjwE+w7XyX2+dH+dCUPXp
 E3YZ9dAQHj211Pi0ZrctgvrVWfYfcqNlV4D7dfgN4k+QdtLCsQK7t0XZq7fcCjr5CfYO
 y5HtGyDyaMyrv0Ptzyet7sWDqUPmIGKBosu9980HpFurNbRCoCjGLncfsIfe1OEiG/dB
 0Jq7A+ussdCWgobD2lhOszPqCj7xSy4kOuy3urZuP9G0Sw6rs6mbj+HGRjhvs+YzSI3a Iw== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.104])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fj1uvg61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 07:55:57 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 11:55:57 -0000
Received: from us1b3-smtp01.a3dr.sjc01.isc4sb.com (10.122.7.174)
        by smtp.notes.na.collabserv.com (10.122.47.44) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 11:55:55 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp01.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021051111555502-351244 ;
          Tue, 11 May 2021 11:55:55 +0000 
In-Reply-To: <8d6af83bbaf4647290d25c7ba0017a5a8059f107.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 07/31] rdma/siw: split out a __siw_cep_terminate_upcall() function
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 11:55:54 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <8d6af83bbaf4647290d25c7ba0017a5a8059f107.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: 872B499E:BA032CC9-002586D2:0040E4B7;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 53383
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051111-5525-0000-0000-000004530991
X-IBM-SpamModules-Scores: BY=0.061153; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000458
X-IBM-SpamModules-Versions: BY=3.00015150; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01526390; UDB=6.00825164; IPR=6.01308321;
 MB=3.00036884; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 11:55:56
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-25 10:42:47 - 6.00012377
x-cbparentid: 21051111-5526-0000-0000-0000F27309A3
Message-Id: <OF872B499E.BA032CC9-ON002586D2.0040E4B7-002586D2.00418B2B@notes.na.collabserv.com>
X-Proofpoint-GUID: KBFTn7RC7mBq2tuVZIIq-eqvgOlUXvrY
X-Proofpoint-ORIG-GUID: KBFTn7RC7mBq2tuVZIIq-eqvgOlUXvrY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_02:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Stefan Metzmacher" <metze@samba.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Stefan Metzmacher" <metze@samba.org>
>Date: 05/07/2021 01:37AM
>Cc: linux-rdma@vger.kernel.org, "Stefan Metzmacher" <metze@samba.org>
>Subject: [EXTERNAL] [PATCH 07/31] rdma/siw: split out a
>=5F=5Fsiw=5Fcep=5Fterminate=5Fupcall() function
>
>There are multiple places where should have the same logic.
>Having one helper function to be used in all places
>makes it easier to extended the logic.
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 53
>++++++++++++++++++------------
> 1 file changed, 32 insertions(+), 21 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index 2cc2863bd427..c91a74271b9b 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -103,6 +103,37 @@ static void siw=5Fsocket=5Fdisassoc(struct socket
>*s)
> 	}
> }
>=20
>+/*
>+ * The caller needs to deal with siw=5Fcep=5Fset=5Finuse()
>+ * and siw=5Fcep=5Fset=5Ffree()
>+ */
>+static void =5F=5Fsiw=5Fcep=5Fterminate=5Fupcall(struct siw=5Fcep *cep,
>+				       int reply=5Fstatus)
>+{
>+	if (cep->qp && cep->qp->term=5Finfo.valid)
>+		siw=5Fsend=5Fterminate(cep->qp);
>+

While I see some merits of having consolidated the=20
updates to the IWCM state machine on close, I don't think we
should mix this with sending TERMINATE messages on the wire.
Just keep that where it currently is.

Call that new thing different - 'siw=5Fupcall=5Fllp=5Fclose'=20
or some such?

>+	switch (cep->state) {
>+	case SIW=5FEPSTATE=5FAWAIT=5FMPAREP:
>+		siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FCONNECT=5FREPLY,
>+			      reply=5Fstatus);
>+		break;
>+
>+	case SIW=5FEPSTATE=5FRDMA=5FMODE:
>+		siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FCLOSE, 0);
>+		break;
>+
>+	case SIW=5FEPSTATE=5FIDLE:
>+	case SIW=5FEPSTATE=5FLISTENING:
>+	case SIW=5FEPSTATE=5FCONNECTING:
>+	case SIW=5FEPSTATE=5FAWAIT=5FMPAREQ:
>+	case SIW=5FEPSTATE=5FRECVD=5FMPAREQ:
>+	case SIW=5FEPSTATE=5FCLOSED:
>+	default:
>+		break;
>+	}
>+}
>+
> static void siw=5Frtr=5Fdata=5Fready(struct sock *sk)
> {
> 	struct siw=5Fcep *cep;
>@@ -395,29 +426,9 @@ void siw=5Fqp=5Fcm=5Fdrop(struct siw=5Fqp *qp, int
>schedule)
> 		}
> 		siw=5Fdbg=5Fcep(cep, "immediate close, state %d\n", cep->state);
>=20
>-		if (qp->term=5Finfo.valid)
>-			siw=5Fsend=5Fterminate(qp);
>+		=5F=5Fsiw=5Fcep=5Fterminate=5Fupcall(cep, -EINVAL);
>=20
> 		if (cep->cm=5Fid) {
>-			switch (cep->state) {
>-			case SIW=5FEPSTATE=5FAWAIT=5FMPAREP:
>-				siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FCONNECT=5FREPLY,
>-					      -EINVAL);
>-				break;
>-
>-			case SIW=5FEPSTATE=5FRDMA=5FMODE:
>-				siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FCLOSE, 0);
>-				break;
>-
>-			case SIW=5FEPSTATE=5FIDLE:
>-			case SIW=5FEPSTATE=5FLISTENING:
>-			case SIW=5FEPSTATE=5FCONNECTING:
>-			case SIW=5FEPSTATE=5FAWAIT=5FMPAREQ:
>-			case SIW=5FEPSTATE=5FRECVD=5FMPAREQ:
>-			case SIW=5FEPSTATE=5FCLOSED:
>-			default:
>-				break;
>-			}
> 			cep->cm=5Fid->rem=5Fref(cep->cm=5Fid);
> 			cep->cm=5Fid =3D NULL;
> 			siw=5Fcep=5Fput(cep);
>--=20
>2.25.1
>
>

