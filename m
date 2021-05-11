Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482DB37A631
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 14:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhEKMCp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 08:02:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230225AbhEKMCo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 08:02:44 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BBY3Y0128191
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=3PHTHack8Iraxz2EY62d+jv78uPoEM5JnBMndGlINqU=;
 b=OxHHmwpuG0DiaJNmN1SfoWzhjT9uJoFSrSQWLNGaSg99aPS1NwvsSDu8dKTO4qD85t6x
 +aCHuD2F9PyP7ETHTYv5x28NgmeY+5xuSNFO3cgN7CxmuAsBDhxdXBrYvtLvdDr54G/C
 hL0MMM8WbAQOgbv9tgAdna85yrNq791dH4Uonkk42KfDatkpBbQOTV0mGQ2ETYuhgGZe
 EEx6Zycqut/jeyJWUwXLaUEytn5pr3vUvRzc/L+ecSIjoC9ZyIH7tBQlXaTj70jXuuIP
 e7RTAZAyiUMBZhErBU4wl4Pwm3/4zw9bF4QclmOqtFzwW2WkVFsDSlRi+xPtLrOmtBvO cw== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.119])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fnujf71j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:01:38 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 12:01:38 -0000
Received: from us1b3-smtp05.a3dr.sjc01.isc4sb.com (10.122.203.183)
        by smtp.notes.na.collabserv.com (10.122.182.123) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 12:01:37 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp05.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021051112013616-335461 ;
          Tue, 11 May 2021 12:01:36 +0000 
In-Reply-To: <6ba824c412e5535b70683676734bebf82a4f325f.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 10/31] rdma/siw: use __siw_cep_terminate_upcall() for
 SIW_CM_WORK_MPATIMEOUT
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 12:01:36 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <6ba824c412e5535b70683676734bebf82a4f325f.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: F5579EAF:EF8BB5DF-002586D2:00421088;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 62647
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051112-3975-0000-0000-0000040D0804
X-IBM-SpamModules-Scores: BY=0.059789; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000002
X-IBM-SpamModules-Versions: BY=3.00015193; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01548293; UDB=6.00838383; IPR=6.01308321;
 MB=3.00036958; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 12:01:37
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-23 10:12:34 - 6.00012377
x-cbparentid: 21051112-3976-0000-0000-00007EB2081D
Message-Id: <OFF5579EAF.EF8BB5DF-ON002586D2.00421088-002586D2.0042108F@notes.na.collabserv.com>
X-Proofpoint-GUID: A233SCief9mc9Rs5Os8hs4QDReMyDmay
X-Proofpoint-ORIG-GUID: A233SCief9mc9Rs5Os8hs4QDReMyDmay
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
>Subject: [EXTERNAL] [PATCH 10/31] rdma/siw: use
>=5F=5Fsiw=5Fcep=5Fterminate=5Fupcall() for SIW=5FCM=5FWORK=5FMPATIMEOUT
>
>It's easier to have generic logic in just one place.
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 31
>++++++++----------------------
> 1 file changed, 8 insertions(+), 23 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index 5338be450285..d03c7a66c6d1 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -1127,31 +1127,16 @@ static void siw=5Fcm=5Fwork=5Fhandler(struct
>work=5Fstruct *w)
> 		break;
>=20
> 	case SIW=5FCM=5FWORK=5FMPATIMEOUT:
>+		/*
>+		 * MPA request timed out:
>+		 * Hide any partially received private data and signal
>+		 * timeout
>+		 */
> 		cep->mpa=5Ftimer =3D NULL;
>+		cep->mpa.hdr.params.pd=5Flen =3D 0;
>+		=5F=5Fsiw=5Fcep=5Fterminate=5Fupcall(cep, -ETIMEDOUT);
>=20
>-		if (cep->state =3D=3D SIW=5FEPSTATE=5FAWAIT=5FMPAREP) {
>-			/*
>-			 * MPA request timed out:
>-			 * Hide any partially received private data and signal
>-			 * timeout
>-			 */
>-			cep->mpa.hdr.params.pd=5Flen =3D 0;
>-
>-			if (cep->cm=5Fid)
>-				siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FCONNECT=5FREPLY,
>-					      -ETIMEDOUT);
>-			release=5Fcep =3D 1;
>-
>-		} else if (cep->state =3D=3D SIW=5FEPSTATE=5FAWAIT=5FMPAREQ) {
>-			/*
>-			 * No MPA request received after peer TCP stream setup.
>-			 */
>-			if (cep->listen=5Fcep) {
>-				siw=5Fcep=5Fput(cep->listen=5Fcep);
>-				cep->listen=5Fcep =3D NULL;
>-			}
>-			release=5Fcep =3D 1;
>-		}
>+		release=5Fcep =3D 1;
> 		break;
>=20
> 	default:
>--=20
>2.25.1
>
>

Okay.


