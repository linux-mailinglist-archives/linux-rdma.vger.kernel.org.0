Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3004037A672
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 14:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhEKMVX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 08:21:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231429AbhEKMVW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 08:21:22 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BC3AdI008808
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=DzVTBlSaM+s7wyxhGMKjLGjWp5ugJdU88sC+hKpNJCE=;
 b=E7Bt5wxVUOkTlhJXKogtRxfdHQErJkGYhX/p9kHFw6W+GcNEL+t/IXw8M1s5y92a8Lbj
 oZ9IJmGG23itLtjzuONP4CkHxbS3wXouEv75AVC5fUB6aru/yezaOal4P4pjH4lEIceC
 GWYeUle9Lg4hOTwbWbMlY7rrBlKzX2J8CU/50mUkh06PnehoYURWXiClACNg7ySWYOfH
 OPS105X5LJZYYcaj3zWFra1fmBQHXPSLG6HLcroqFdGss0g4LrF1/MU6IOKUfyazgnsV
 ajTcktgLso/nIkz4JNLHo2gsUVTATs/Rl/sKPbhtHjHDaHcWVIPXafGHBRpnGcLgZdVj Og== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.74])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fj1uw9w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:20:16 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 12:20:15 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.92) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 12:20:13 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2021051112201279-345936 ;
          Tue, 11 May 2021 12:20:12 +0000 
In-Reply-To: <c81a993594cc8dca834b0bf5de960fac68093250.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 17/31] rdma/siw: start mpa timer before calling
 siw_send_mpareqrep()
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 12:20:12 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <c81a993594cc8dca834b0bf5de960fac68093250.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 27531
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051112-3165-0000-0000-000006101A90
X-IBM-SpamModules-Scores: BY=0.062598; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000003
X-IBM-SpamModules-Versions: BY=3.00015193; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01548292; UDB=6.00838382; IPR=6.01330255;
 MB=3.00036958; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 12:20:14
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-25 10:36:54 - 6.00012377
x-cbparentid: 21051112-3166-0000-0000-0000CE4A1AB1
Message-Id: <OF830044AE.28C581C7-ON002586D2.0043C4CD-002586D2.0043C4D3@notes.na.collabserv.com>
X-Proofpoint-GUID: Eu1qFM9JN1e1U_BWU0zhPwPEjaHYUIYJ
X-Proofpoint-ORIG-GUID: Eu1qFM9JN1e1U_BWU0zhPwPEjaHYUIYJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_02:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Stefan Metzmacher" <metze@samba.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Stefan Metzmacher" <metze@samba.org>
>Date: 05/07/2021 01:39AM
>Cc: linux-rdma@vger.kernel.org, "Stefan Metzmacher" <metze@samba.org>
>Subject: [EXTERNAL] [PATCH 17/31] rdma/siw: start mpa timer before
>calling siw=5Fsend=5Fmpareqrep()
>
>The mpa timer will also span the non-blocking connect
>in the final patch.
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index ec6d5c26fe22..853b80fcb8b0 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -1526,6 +1526,11 @@ int siw=5Fconnect(struct iw=5Fcm=5Fid *id, struct
>iw=5Fcm=5Fconn=5Fparam *params)
> 	}
> 	cep->mpa.hdr.params.pd=5Flen =3D pd=5Flen;
>=20
>+	rv =3D siw=5Fcm=5Fqueue=5Fwork(cep, SIW=5FCM=5FWORK=5FMPATIMEOUT);
>+	if (rv !=3D 0) {
>+		goto error;
>+	}
>+
> 	cep->state =3D SIW=5FEPSTATE=5FAWAIT=5FMPAREP;
>=20
> 	rv =3D siw=5Fsend=5Fmpareqrep(cep, cep->mpa.pdata,
>@@ -1543,11 +1548,6 @@ int siw=5Fconnect(struct iw=5Fcm=5Fid *id, struct
>iw=5Fcm=5Fconn=5Fparam *params)
> 		goto error;
> 	}
>=20
>-	rv =3D siw=5Fcm=5Fqueue=5Fwork(cep, SIW=5FCM=5FWORK=5FMPATIMEOUT);
>-	if (rv !=3D 0) {
>-		goto error;
>-	}
>-
> 	siw=5Fdbg=5Fcep(cep, "[QP %u]: exit\n", qp=5Fid(qp));
> 	siw=5Fcep=5Fset=5Ffree(cep);
> 	return 0;
>@@ -1556,6 +1556,8 @@ int siw=5Fconnect(struct iw=5Fcm=5Fid *id, struct
>iw=5Fcm=5Fconn=5Fparam *params)
> 	siw=5Fdbg(id->device, "failed: %d\n", rv);
>=20
> 	if (cep) {
>+		siw=5Fcancel=5Fmpatimer(cep);
>+
> 		siw=5Fsocket=5Fdisassoc(s);
> 		sock=5Frelease(s);
> 		cep->sock =3D NULL;
>--=20
>2.25.1
>
>
Makes sense if we have a non-blocking connect()

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

