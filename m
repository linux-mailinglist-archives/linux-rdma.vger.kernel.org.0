Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849D537A6B9
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 14:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhEKMcT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 08:32:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45776 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231587AbhEKMcR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 08:32:17 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BC2vEY050705
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=3+oqO8EbLNPnpiziKxHWXhZ5+cGFc8wDa52a2wDah4U=;
 b=ddmVcxwpkXnVHXGJGJuMMAN15PImpP6vZ+J++4mr+cCdfWibc6Zl1rhHcdofN8My08HK
 TXF9RkAI2V+vCKPCsZHRvaZV51ogVdTwDf14hzeeALrqS6JJYhwaZ4F9nox0KHU7/Bfn
 e/N/wreNBhV/W/eQOfqFD8SdN1RX4CCRxMIM+mgY7o+cQMb2c3Pp2Pu+MvFBpbpYMIH0
 0/oXytRrwGYlZOH09126SVpdn4bWNAsTWF6GRIN3Kd1Y/YpVU2fx+SZTVa++bK0BwEqq
 5K5WZRqSykIg802kkFzAZaqxrJtw0gagbzhbGMNQrNfkP3waIiIko+VYUzImHuEPFDZT PQ== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.82])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38frm9amnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:31:10 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 12:31:10 -0000
Received: from us1a3-smtp03.a3.dal06.isc4sb.com (10.106.154.98)
        by smtp.notes.na.collabserv.com (10.106.227.105) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 12:31:09 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp03.a3.dal06.isc4sb.com
          with ESMTP id 2021051112310855-378067 ;
          Tue, 11 May 2021 12:31:08 +0000 
In-Reply-To: <80a82b4d3029d1a63042910e3ac4c3731561967e.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 20/31] rdma/siw: implement non-blocking connect.
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 12:31:08 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <80a82b4d3029d1a63042910e3ac4c3731561967e.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 44895
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051112-9463-0000-0000-000005BA1C14
X-IBM-SpamModules-Scores: BY=0.245143; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.001057
X-IBM-SpamModules-Versions: BY=3.00015193; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01548293; UDB=6.00838381; IPR=6.01330253;
 MB=3.00036958; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 12:31:09
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-25 10:44:38 - 6.00012377
x-cbparentid: 21051112-9464-0000-0000-000061581C59
Message-Id: <OFBC50BE05.41477A2E-ON002586D2.0044C4E8-002586D2.0044C4EE@notes.na.collabserv.com>
X-Proofpoint-GUID: uN4Yr9LOnMvuSQgmkR-5Bykp04dWVC_M
X-Proofpoint-ORIG-GUID: uN4Yr9LOnMvuSQgmkR-5Bykp04dWVC_M
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
>Subject: [EXTERNAL] [PATCH 20/31] rdma/siw: implement non-blocking
>connect.
>
>This is very important in order to prevent deadlocks.
>
>The RDMA application layer expects rdma=5Fconnect() to be non-blocking
>as the completion is handled via RDMA=5FCM=5FEVENT=5FESTABLISHED and
>other async events. It's not unlikely to hold a lock during
>the rdma=5Fconnect() call.
>
>Without out this a connection attempt to a non-existing/reachable
>server block until the very long tcp timeout hits.
>The application layer had no chance to have its own timeout handler
>as that would just deadlock with the already blocking rdma=5Fconnect().
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 114
>+++++++++++++++++++++--------
> drivers/infiniband/sw/siw/siw=5Fcm.h |   1 +
> 2 files changed, 85 insertions(+), 30 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index cf0f881c6793..9a550f040678 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -37,6 +37,7 @@ static void siw=5Fcm=5Fllp=5Fwrite=5Fspace(struct sock *=
s);
> static void siw=5Fcm=5Fllp=5Ferror=5Freport(struct sock *s);
> static int siw=5Fcm=5Fupcall(struct siw=5Fcep *cep, enum iw=5Fcm=5Fevent=
=5Ftype
>reason,
> 			 int status);
>+static void siw=5Fconnected(struct siw=5Fcep *cep);
>=20
> static void siw=5Fsk=5Fassign=5Fcm=5Fupcalls(struct sock *sk)
> {
>@@ -1141,6 +1142,10 @@ static void siw=5Fcm=5Fwork=5Fhandler(struct
>work=5Fstruct *w)
> 		siw=5Faccept=5Fnewconn(cep);
> 		break;
>=20
>+	case SIW=5FCM=5FWORK=5FCONNECTED:
>+		siw=5Fconnected(cep);
>+		break;
>+
> 	case SIW=5FCM=5FWORK=5FREAD=5FMPAHDR:
> 		if (cep->state =3D=3D SIW=5FEPSTATE=5FAWAIT=5FMPAREQ) {
> 			if (cep->listen=5Fcep) {
>@@ -1306,6 +1311,7 @@ static void siw=5Fcm=5Fllp=5Fdata=5Fready(struct sock
>*sk)
> 	switch (cep->state) {
> 	case SIW=5FEPSTATE=5FRDMA=5FMODE:
> 	case SIW=5FEPSTATE=5FLISTENING:
>+	case SIW=5FEPSTATE=5FCONNECTING:
> 		break;
>=20
> 	case SIW=5FEPSTATE=5FAWAIT=5FMPAREQ:
>@@ -1359,12 +1365,26 @@ static void siw=5Fcm=5Fllp=5Fstate=5Fchange(struct
>sock *sk)
>=20
> 	switch (sk->sk=5Fstate) {
> 	case TCP=5FESTABLISHED:
>-		/*
>-		 * handle accepting socket as special case where only
>-		 * new connection is possible
>-		 */
>-		siw=5Fcm=5Fqueue=5Fwork(cep, SIW=5FCM=5FWORK=5FACCEPT);
>-		break;
>+		if (cep->state =3D=3D SIW=5FEPSTATE=5FCONNECTING) {
>+			/*
>+			 * handle accepting socket as special case where only
>+			 * new connection is possible
>+			 */
>+			siw=5Fcm=5Fqueue=5Fwork(cep, SIW=5FCM=5FWORK=5FCONNECTED);
>+			break;
>+
>+		} else if (cep->state =3D=3D SIW=5FEPSTATE=5FLISTENING) {
>+			/*
>+			 * handle accepting socket as special case where only
>+			 * new connection is possible
>+			 */
>+			siw=5Fcm=5Fqueue=5Fwork(cep, SIW=5FCM=5FWORK=5FACCEPT);
>+			break;
>+		}
>+		siw=5Fdbg=5Fcep(cep,
>+			    "unexpected socket state %d with cep state %d\n",
>+			    sk->sk=5Fstate, cep->state);
>+		/* fall through */
>=20
> 	case TCP=5FCLOSE:
> 	case TCP=5FCLOSE=5FWAIT:
>@@ -1383,7 +1403,7 @@ static void siw=5Fcm=5Fllp=5Fstate=5Fchange(struct s=
ock
>*sk)
> static int kernel=5Fbindconnect(struct socket *s, struct sockaddr
>*laddr,
> 			      struct sockaddr *raddr, bool afonly)
> {
>-	int rv, flags =3D 0;
>+	int rv;
> 	size=5Ft size =3D laddr->sa=5Ffamily =3D=3D AF=5FINET ?
> 		sizeof(struct sockaddr=5Fin) : sizeof(struct sockaddr=5Fin6);
>=20
>@@ -1402,7 +1422,7 @@ static int kernel=5Fbindconnect(struct socket *s,
>struct sockaddr *laddr,
> 	if (rv < 0)
> 		return rv;
>=20
>-	rv =3D kernel=5Fconnect(s, raddr, size, flags);
>+	rv =3D kernel=5Fconnect(s, raddr, size, O=5FNONBLOCK);
>=20
> 	return rv < 0 ? rv : 0;
> }
>@@ -1547,36 +1567,27 @@ int siw=5Fconnect(struct iw=5Fcm=5Fid *id, struct
>iw=5Fcm=5Fconn=5Fparam *params)
> 		goto error;
> 	}
>=20
>-	/*
>-	 * NOTE: For simplification, connect() is called in blocking
>-	 * mode. Might be reconsidered for async connection setup at
>-	 * TCP level.
>-	 */
> 	rv =3D kernel=5Fbindconnect(s, laddr, raddr, id->afonly);
>+	if (rv =3D=3D -EINPROGRESS) {
>+		siw=5Fdbg=5Fqp(qp, "kernel=5Fbindconnect: EINPROGRESS\n");
>+		rv =3D 0;
>+	}
> 	if (rv !=3D 0) {
> 		siw=5Fdbg=5Fqp(qp, "kernel=5Fbindconnect: error %d\n", rv);
> 		goto error;
> 	}
>-	if (siw=5Ftcp=5Fnagle =3D=3D false)
>-		tcp=5Fsock=5Fset=5Fnodelay(s->sk);
>-
>-	cep->state =3D SIW=5FEPSTATE=5FAWAIT=5FMPAREP;
>=20
>-	rv =3D siw=5Fsend=5Fmpareqrep(cep, cep->mpa.pdata,
>-				cep->mpa.hdr.params.pd=5Flen);
> 	/*
>-	 * Reset private data.
>+	 * The rest will be done by siw=5Fconnected()

Please use more concise language, giving some details.
The 'rest' and 'everything' refers to some state of code
understanding we cannot assume for every reader ;)


>+	 *
>+	 * siw=5Fcm=5Fllp=5Fstate=5Fchange() will detect
>+	 * TCP=5FESTABLISHED and schedules SIW=5FCM=5FWORK=5FCONNECTED,
>+	 * which will finally call siw=5Fconnected().
>+	 *
>+	 * As siw=5Fcm=5Fllp=5Fstate=5Fchange() handles everything
>+	 * siw=5Fcm=5Fllp=5Fdata=5Fready() can be a noop for
>+	 * SIW=5FEPSTATE=5FCONNECTING.
> 	 */
>-	if (cep->mpa.hdr.params.pd=5Flen) {
>-		cep->mpa.hdr.params.pd=5Flen =3D 0;
>-		kfree(cep->mpa.pdata);
>-		cep->mpa.pdata =3D NULL;
>-	}
>-
>-	if (rv < 0) {
>-		goto error;
>-	}
>-
> 	siw=5Fdbg=5Fcep(cep, "[QP %u]: exit\n", qp=5Fid(qp));
> 	siw=5Fcep=5Fset=5Ffree(cep);
> 	return 0;
>@@ -1604,6 +1615,49 @@ int siw=5Fconnect(struct iw=5Fcm=5Fid *id, struct
>iw=5Fcm=5Fconn=5Fparam *params)
> 	return rv;
> }
>=20
>+static void siw=5Fconnected(struct siw=5Fcep *cep)
>+{
>+	struct siw=5Fqp *qp =3D cep->qp;
>+	struct socket *s =3D cep->sock;
>+	int rv =3D -ECONNABORTED;
>+
>+	/*
>+	 * already called with
>+	 * siw=5Fcep=5Fset=5Finuse(cep);
>+	 */
>+
>+	if (cep->state !=3D SIW=5FEPSTATE=5FCONNECTING)
>+		goto error;
>+
>+	if (siw=5Ftcp=5Fnagle =3D=3D false)
>+		tcp=5Fsock=5Fset=5Fnodelay(s->sk);
>+
>+	cep->state =3D SIW=5FEPSTATE=5FAWAIT=5FMPAREP;
>+
>+	rv =3D siw=5Fsend=5Fmpareqrep(cep, cep->mpa.pdata,
>+				cep->mpa.hdr.params.pd=5Flen);
>+	/*
>+	 * Reset private data.
>+	 */
>+	if (cep->mpa.hdr.params.pd=5Flen) {
>+		cep->mpa.hdr.params.pd=5Flen =3D 0;
>+		kfree(cep->mpa.pdata);
>+		cep->mpa.pdata =3D NULL;
>+	}
>+
>+	if (rv < 0) {
>+		goto error;
>+	}
>+
>+	siw=5Fdbg=5Fcep(cep, "[QP %u]: exit\n", qp=5Fid(qp));
>+	return;
>+
>+error:
>+	siw=5Fdbg=5Fcep(cep, "[QP %u]: exit, error %d\n", qp=5Fid(qp), rv);
>+	siw=5Fqp=5Fcm=5Fdrop(qp, 1);
>+	return;
>+}
>+
> /*
>  * siw=5Faccept - Let SoftiWARP accept an RDMA connection request
>  *
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.h
>b/drivers/infiniband/sw/siw/siw=5Fcm.h
>index 4f6219bd746b..62c9947999ac 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.h
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.h
>@@ -78,6 +78,7 @@ struct siw=5Fcep {
>=20
> enum siw=5Fwork=5Ftype {
> 	SIW=5FCM=5FWORK=5FACCEPT =3D 1,
>+	SIW=5FCM=5FWORK=5FCONNECTED,
> 	SIW=5FCM=5FWORK=5FREAD=5FMPAHDR,
> 	SIW=5FCM=5FWORK=5FCLOSE=5FLLP, /* close socket */
> 	SIW=5FCM=5FWORK=5FPEER=5FCLOSE, /* socket indicated peer close */
>--=20
>2.25.1
>
>

