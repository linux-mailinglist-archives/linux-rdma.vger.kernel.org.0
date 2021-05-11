Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A83A37A5DF
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 13:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhEKLjj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 07:39:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230501AbhEKLji (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 07:39:38 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BBYElZ195039
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 07:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=fkOkHqMrE9Ej7MwLI0hd51B/6e6hvVv1os0cWfM9d2I=;
 b=bCZLNkorSPg1EBHnQ9BtnASDRVXcTDIdBFuOLBDTAEIoadFJoSupkkyqUaFf7sK3HT9l
 zDitA6Uzs8xt/ftBoFf55f5LMDAaHovpCecFpHKUy31/usnz08EvWwtdR6ik7YqPUQMr
 RJpVcC+gkDrpTUsD0fLWcjJqL8++waNGeeZMFQ8FaJySDD7hQBi66WOGnNUZUreaLjX+
 2YmxsdrmfdUbhVu06ox2BlP90lYSfjVmOwlbOqPGAgJaeZjOqH8uIcQJBj0FcAqL6c6T
 W4d0VTSK0MzIiJ1d4SFuMTGZhTGglfZEM2IiF6fdePyIdUakT7YJGh5MSqmtVvUEArqU /Q== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fqrf2r9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 07:38:32 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 11:38:32 -0000
Received: from us1b3-smtp04.a3dr.sjc01.isc4sb.com (10.122.203.161)
        by smtp.notes.na.collabserv.com (10.122.47.46) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 11:38:30 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp04.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021051111382941-326719 ;
          Tue, 11 May 2021 11:38:29 +0000 
In-Reply-To: <4d26a4cfd96bfcb3fe0362a37d595608b09ddd91.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 04/31] rdma/siw: let siw_accept() deferr RDMA_MODE until
 EVENT_ESTABLISHED
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 11:38:29 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <4d26a4cfd96bfcb3fe0362a37d595608b09ddd91.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: AAE221EB:13FAF0AE-002586D2:003FF2E8;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 45839
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051111-3017-0000-0000-0000048F086B
X-IBM-SpamModules-Scores: BY=0.060857; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000000
X-IBM-SpamModules-Versions: BY=3.00015182; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01548293; UDB=6.00825223; IPR=6.01330096;
 MB=3.00036941; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 11:38:31
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-22 14:10:42 - 6.00012377
x-cbparentid: 21051111-3018-0000-0000-000070520892
Message-Id: <OFAAE221EB.13FAF0AE-ON002586D2.003FF2E8-002586D2.003FF2EC@notes.na.collabserv.com>
X-Proofpoint-ORIG-GUID: NdjtvZqW2EvJ6vAUq1-ghny2h89FhiNG
X-Proofpoint-GUID: NdjtvZqW2EvJ6vAUq1-ghny2h89FhiNG
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
>Subject: [EXTERNAL] [PATCH 04/31] rdma/siw: let siw=5Faccept() deferr
>RDMA=5FMODE until EVENT=5FESTABLISHED
>
>If we receive an TCP FIN before sending the MPA response
>we'll get an error and posted IW=5FCM=5FEVENT=5FCLOSE.
>But the IWCM layer didn't receive IW=5FCM=5FEVENT=5FESTABLISHED
>yet and doesn't expect IW=5FCM=5FEVENT=5FCLOSE. Instead
>it expects IW=5FCM=5FEVENT=5FCONNECT=5FREPLY.
>
>If we stay in SIW=5FEPSTATE=5FRECVD=5FMPAREQ until we posted
>IW=5FCM=5FEVENT=5FESTABLISHED =5F=5Fsiw=5Fcep=5Fterminate=5Fupcall()
>will use IW=5FCM=5FEVENT=5FCONNECT=5FREPLY.
>
>This can be triggered by the following change on the
>client:
>
>   --- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>   +++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>   @@ -1507,6 +1507,9 @@ int siw=5Fconnect(struct iw=5Fcm=5Fid *id, struct
>iw=5Fcm=5Fconn=5Fparam *params)
>           if (rv >=3D 0) {
>                   rv =3D siw=5Fcm=5Fqueue=5Fwork(cep,
>SIW=5FCM=5FWORK=5FMPATIMEOUT);
>                   if (!rv) {
>   +                       rv =3D -ECONNRESET;
>   +                       msleep=5Finterruptible(100);
>   +                       goto error;
>                           siw=5Fdbg=5Fcep(cep, "[QP %u]: exit\n",
>qp=5Fid(qp));
>                           siw=5Fcep=5Fset=5Ffree(cep);
>                           return 0;
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index da84686a21fd..145ab6e4e0ed 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -129,8 +129,10 @@ static void siw=5Frtr=5Fdata=5Fready(struct sock *sk)
> 	 * Failed data processing would have already scheduled
> 	 * connection drop.
> 	 */
>-	if (!qp->rx=5Fstream.rx=5Fsuspend)
>+	if (!qp->rx=5Fstream.rx=5Fsuspend) {
> 		siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FESTABLISHED, 0);
>+		cep->state =3D SIW=5FEPSTATE=5FRDMA=5FMODE;
>+	}
> out:
> 	read=5Funlock(&sk->sk=5Fcallback=5Flock);
> 	if (qp)
>@@ -1656,8 +1658,6 @@ int siw=5Faccept(struct iw=5Fcm=5Fid *id, struct
>iw=5Fcm=5Fconn=5Fparam *params)
> 	/* siw=5Fqp=5Fget(qp) already done by QP lookup */
> 	cep->qp =3D qp;
>=20
>-	cep->state =3D SIW=5FEPSTATE=5FRDMA=5FMODE;
>-
> 	/* Move socket RX/TX under QP control */
> 	rv =3D siw=5Fqp=5Fmodify(qp, &qp=5Fattrs,
> 			   SIW=5FQP=5FATTR=5FSTATE | SIW=5FQP=5FATTR=5FLLP=5FHANDLE |
>@@ -1683,6 +1683,7 @@ int siw=5Faccept(struct iw=5Fcm=5Fid *id, struct
>iw=5Fcm=5Fconn=5Fparam *params)
> 		rv =3D siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FESTABLISHED, 0);
> 		if (rv)
> 			goto error;
>+		cep->state =3D SIW=5FEPSTATE=5FRDMA=5FMODE;
> 	}
> 	siw=5Fcep=5Fset=5Ffree(cep);
>=20
>--=20
>2.25.1
>
>
Thanks!

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

