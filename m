Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB2137A62F
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 14:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhEKMBc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 08:01:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40922 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230400AbhEKMBc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 08:01:32 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BBXVx7071724
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=ouEbhMlIUYcx5DiWAr0iLVbxeDH4kwytPr9X3oXZuNI=;
 b=Hmkv3m/3C65j6xBhuCQIzzfHiuVidoL4/x/3jficaJmb08I6fSe/rcfw/UVZGb0WX9sV
 pwyOs8S+hSxkS6liUW1meMJ9b5E/0JJYx9DL/XSYqYrQpLgl5ilPo/7bIKB9gu4bm9oT
 pMB/xjEgpZQyd+pVrY6HINa8QXfJZ7q5EDhwkQukQzL6kcuKsmD2dOAFNZWWiqVpXGvw
 AA2q0m9xlTxM04wr6NtxP/tQ9YW0/oATCCzObhywWN89CqBR6dINtc2cOEo+jofCyuWF
 kGC6KdO44YBqYT4c9Lf4GZhZRgWm9tf3R8Qj0agWEMOlsMyjefh3JNNpcqTvyEcFXbC9 wQ== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.112])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fs070wgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:00:25 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 12:00:24 -0000
Received: from us1b3-smtp06.a3dr.sjc01.isc4sb.com (10.122.203.184)
        by smtp.notes.na.collabserv.com (10.122.47.54) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 12:00:22 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp06.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021051112002217-322458 ;
          Tue, 11 May 2021 12:00:22 +0000 
In-Reply-To: <8cf78b479cca333caf82eca812d421c61675d776.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 09/31] rdma/siw: use __siw_cep_terminate_upcall() for
 SIW_CM_WORK_PEER_CLOSE
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 12:00:21 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <8cf78b479cca333caf82eca812d421c61675d776.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: 6589B44D:27366A13-002586D2:0041F33A;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 29355
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051112-4615-0000-0000-000003E105DC
X-IBM-SpamModules-Scores: BY=0.267673; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.012011
X-IBM-SpamModules-Versions: BY=3.00015193; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01548293; UDB=6.00838383; IPR=6.01330255;
 MB=3.00036958; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 12:00:23
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-22 14:02:06 - 6.00012377
x-cbparentid: 21051112-4616-0000-0000-00000569058C
Message-Id: <OF6589B44D.27366A13-ON002586D2.0041F33A-002586D2.0041F33E@notes.na.collabserv.com>
X-Proofpoint-GUID: 99-zVMXlOdFu-VCyOAOikprGn8tzQCmQ
X-Proofpoint-ORIG-GUID: 99-zVMXlOdFu-VCyOAOikprGn8tzQCmQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_02:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Stefan Metzmacher" <metze@samba.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Stefan Metzmacher" <metze@samba.org>
>Date: 05/07/2021 01:38AM
>Cc: linux-rdma@vger.kernel.org, "Stefan Metzmacher" <metze@samba.org>
>Subject: [EXTERNAL] [PATCH 09/31] rdma/siw: use
>=5F=5Fsiw=5Fcep=5Fterminate=5Fupcall() for SIW=5FCM=5FWORK=5FPEER=5FCLOSE
>
>It's easier to have generic logic in just one place.
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 89
>+++++++++++++++++-------------
> 1 file changed, 50 insertions(+), 39 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index b7e7f637bd03..5338be450285 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -110,26 +110,67 @@ static void siw=5Fsocket=5Fdisassoc(struct socket
>*s)
> static void =5F=5Fsiw=5Fcep=5Fterminate=5Fupcall(struct siw=5Fcep *cep,
> 				       int reply=5Fstatus)
> {
>-	if (cep->qp && cep->qp->term=5Finfo.valid)
>-		siw=5Fsend=5Fterminate(cep->qp);
>+	bool suspended =3D false;

this is development debugging only. please remove it.

>+
>+	if (cep->qp) {
>+		struct siw=5Fqp *qp =3D cep->qp;
>+
>+		if (qp->term=5Finfo.valid)
>+			siw=5Fsend=5Fterminate(qp);
>+
>+		if (qp->rx=5Fstream.rx=5Fsuspend || qp->tx=5Fctx.tx=5Fsuspend)
>+			suspended =3D true;
>+	} else {
>+		suspended =3D true;
>+	}

This block is not needed.
>=20
> 	switch (cep->state) {
> 	case SIW=5FEPSTATE=5FAWAIT=5FMPAREP:
>+		/*
>+		 * MPA reply not received, but connection drop,
>+		 * or timeout.
>+		 */
> 		siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FCONNECT=5FREPLY,
> 			      reply=5Fstatus);
> 		break;
>=20
> 	case SIW=5FEPSTATE=5FRDMA=5FMODE:
>+		/*
>+		 * NOTE: IW=5FCM=5FEVENT=5FDISCONNECT is given just
>+		 *       to transition IWCM into CLOSING.
>+		 */
>+		WARN(!suspended, "SIW=5FEPSTATE=5FRDMA=5FMODE called without
>suspended\n");

Please remove this development debugging. also below.

>+		siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FDISCONNECT, 0);
> 		siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FCLOSE, 0);
> 		break;
>=20
>+	case SIW=5FEPSTATE=5FRECVD=5FMPAREQ:
>+		/*
>+		 * Wait for the ulp/CM to call accept/reject
>+		 */
>+		siw=5Fdbg=5Fcep(cep, "mpa req recvd, wait for ULP\n");
>+		WARN(!suspended, "SIW=5FEPSTATE=5FRECVD=5FMPAREQ called without
>suspended\n");
>+		break;
>+
>+	case SIW=5FEPSTATE=5FAWAIT=5FMPAREQ:
>+		/*
>+		 * Socket close before MPA request received.
>+		 */
>+		siw=5Fdbg=5Fcep(cep, "no mpareq: drop listener\n");
>+		if (cep->listen=5Fcep)
>+			siw=5Fcep=5Fput(cep->listen=5Fcep);
>+		cep->listen=5Fcep =3D NULL;
>+		break;
>+
> 	case SIW=5FEPSTATE=5FIDLE:
> 	case SIW=5FEPSTATE=5FLISTENING:
> 	case SIW=5FEPSTATE=5FCONNECTING:
>-	case SIW=5FEPSTATE=5FAWAIT=5FMPAREQ:
>-	case SIW=5FEPSTATE=5FRECVD=5FMPAREQ:
> 	case SIW=5FEPSTATE=5FCLOSED:
> 	default:
>+		/*
>+		 * for other states there is no connection
>+		 * known to the IWCM.
>+		 */
> 		break;
> 	}
> }
>@@ -1077,41 +1118,11 @@ static void siw=5Fcm=5Fwork=5Fhandler(struct
>work=5Fstruct *w)
> 		break;
>=20
> 	case SIW=5FCM=5FWORK=5FPEER=5FCLOSE:
>-		if (cep->cm=5Fid) {
>-			if (cep->state =3D=3D SIW=5FEPSTATE=5FAWAIT=5FMPAREP) {
>-				/*
>-				 * MPA reply not received, but connection drop
>-				 */
>-				siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FCONNECT=5FREPLY,
>-					      -ECONNRESET);
>-			} else if (cep->state =3D=3D SIW=5FEPSTATE=5FRDMA=5FMODE) {
>-				/*
>-				 * NOTE: IW=5FCM=5FEVENT=5FDISCONNECT is given just
>-				 *       to transition IWCM into CLOSING.
>-				 */
>-				siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FDISCONNECT, 0);
>-				siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FCLOSE, 0);
>-			}
>-			/*
>-			 * for other states there is no connection
>-			 * known to the IWCM.
>-			 */
>-		} else {
>-			if (cep->state =3D=3D SIW=5FEPSTATE=5FRECVD=5FMPAREQ) {
>-				/*
>-				 * Wait for the ulp/CM to call accept/reject
>-				 */
>-				siw=5Fdbg=5Fcep(cep,
>-					    "mpa req recvd, wait for ULP\n");
>-			} else if (cep->state =3D=3D SIW=5FEPSTATE=5FAWAIT=5FMPAREQ) {
>-				/*
>-				 * Socket close before MPA request received.
>-				 */
>-				siw=5Fdbg=5Fcep(cep, "no mpareq: drop listener\n");
>-				siw=5Fcep=5Fput(cep->listen=5Fcep);
>-				cep->listen=5Fcep =3D NULL;
>-			}
>-		}
>+		/*
>+		 * Peer closed the connection: TCP=5FCLOSE*
>+		 */
>+		=5F=5Fsiw=5Fcep=5Fterminate=5Fupcall(cep, -ECONNRESET);
>+
> 		release=5Fcep =3D 1;
> 		break;
>=20
>--=20
>2.25.1
>
>

