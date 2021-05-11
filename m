Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E755C37A64F
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 14:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhEKMI5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 08:08:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230225AbhEKMI5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 08:08:57 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BC2gk4030753
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=ppPoUIaQ5zkDmCnoHpyQhtybcg+/aYIiReubBn8IJyE=;
 b=V82bCbz7i17TThOVbzY0O0TKYF8CVH/PBNBCuxvOnvZzIYz6YvkjaHmwreIBNg1VYvrZ
 ffEP9hdT/seScjXYMtDP7bg/4oDSvAodiEjXMXqU6QToNdGy3ucXjKaq5ZXbYnL6AeYJ
 QB6e7evCyWW+TXHcqUECxaVi95ksSNQNp9iOJ8piwwh81lKmhd6WEUk105AAbeSdLQgE
 pHgBX03OxIV8gekxo/lcuexaTXmzl3ZZEFUc6Z7/hE8JH2K4hJmqZ1gJqpgf6lav1nU4
 MJSBnXUrj/bkHkd4x9FbjF0lYcICaKHHiTNTioJ8qJ503JP1OHxR2FVFYaYzVvbKBKYk Jw== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38fmxx0g9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:07:50 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 12:07:50 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.143) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 12:07:48 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2021051112074778-336166 ;
          Tue, 11 May 2021 12:07:47 +0000 
In-Reply-To: <0f85e2dc8c8cdeb25a14113b279ec44441112867.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 12/31] rdma/siw: add some debugging of state and sk_state to the
 teardown process
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 12:07:47 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <0f85e2dc8c8cdeb25a14113b279ec44441112867.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 61943
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051112-2475-0000-0000-0000112E11C6
X-IBM-SpamModules-Scores: BY=0.058601; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000490
X-IBM-SpamModules-Versions: BY=3.00015182; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01546696; UDB=6.00825223; IPR=6.01308321;
 MB=3.00036941; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 12:07:49
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-22 14:28:52 - 6.00012377
x-cbparentid: 21051112-2476-0000-0000-0000DD03121E
Message-Id: <OF81C4176A.85FCACDE-ON002586D2.00426904-002586D2.0042A192@notes.na.collabserv.com>
X-Proofpoint-GUID: t1Y6ZEuUErswDIgwTLmWfyFvzXmVt6Q3
X-Proofpoint-ORIG-GUID: t1Y6ZEuUErswDIgwTLmWfyFvzXmVt6Q3
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
>Subject: [EXTERNAL] [PATCH 12/31] rdma/siw: add some debugging of
>state and sk=5Fstate to the teardown process
>
>That makes it easier to understanf where possible problems come from.
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 15 ++++++++++++++-
> 1 file changed, 14 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index 3cc1d22fe232..ed33533ff9e6 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -111,6 +111,14 @@ static void =5F=5Fsiw=5Fcep=5Fterminate=5Fupcall(stru=
ct
>siw=5Fcep *cep,
> 				       int reply=5Fstatus)
> {
> 	bool suspended =3D false;
>+	int sk=5Fstate=5Fval =3D UINT=5FMAX;
>+
>+	if (cep->sock && cep->sock->sk)
>+		sk=5Fstate=5Fval =3D cep->sock->sk->sk=5Fstate;
>+

Please put this 'sk=5Fstate=5Fval' logic into the single debug
statement, if we need that information at all.

>+	siw=5Fdbg=5Fcep(cep, "[QP %u]: state: %d sk=5Fstate: %d\n",
>+		    cep->qp ? qp=5Fid(cep->qp) : UINT=5FMAX,
>+		    cep->state, sk=5Fstate=5Fval);
>=20
> 	if (cep->qp) {
> 		struct siw=5Fqp *qp =3D cep->qp;
>@@ -118,9 +126,14 @@ static void =5F=5Fsiw=5Fcep=5Fterminate=5Fupcall(stru=
ct
>siw=5Fcep *cep,
> 		if (qp->term=5Finfo.valid)
> 			siw=5Fsend=5Fterminate(qp);
>=20
>+		siw=5Fdbg=5Fcep(cep,
>+			    "with qp rx=5Fsuspend=3D%d tx=5Fsuspend=3D%d\n",
>+			    qp->rx=5Fstream.rx=5Fsuspend,
>+			    qp->tx=5Fctx.tx=5Fsuspend);
> 		if (qp->rx=5Fstream.rx=5Fsuspend || qp->tx=5Fctx.tx=5Fsuspend)
> 			suspended =3D true;
> 	} else {
>+		siw=5Fdbg=5Fcep(cep, "without qp\n");
> 		suspended =3D true;
> 	}
>=20
>@@ -1307,7 +1320,7 @@ static void siw=5Fcm=5Fllp=5Fstate=5Fchange(struct s=
ock
>*sk)
> 	}
> 	orig=5Fstate=5Fchange =3D cep->sk=5Fstate=5Fchange;
>=20
>-	siw=5Fdbg=5Fcep(cep, "state: %d\n", cep->state);
>+	siw=5Fdbg=5Fcep(cep, "state: %d sk=5Fstate: %d\n", cep->state,
>sk->sk=5Fstate);
>=20
> 	switch (sk->sk=5Fstate) {
> 	case TCP=5FESTABLISHED:
>--=20
>2.25.1
>
>

